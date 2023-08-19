Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204B1781624
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 02:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243198AbjHSAwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 20:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243368AbjHSAwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 20:52:17 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78611449D;
        Fri, 18 Aug 2023 17:43:22 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IKVWRa000700;
        Fri, 18 Aug 2023 17:43:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=sdvGu0tRz/jrukoMJ3xxCJ06B3ztGrV2fh6iX/zyfFk=;
 b=ihYYGDNWPV3q4lgQO4yszDyFlqMBLo5o5smRbSs6q+SfpaW+Ql7LrXRu2gUOJEaEACLh
 D1n3uS3PjIBxqnTCd8x4VmFPRojvK0KCshhghxqEFc5IwDu1unBiDy9xccFI8TEwx2n1
 Plan4jRjbv7d7dKxOpLvbvsK4ij5yA73YwaXZqY/KDFzgdh1dcx8RgEANOzVqwQlxE5N
 NzhaqWgg/QyibzJ9hcENwnRLG0grTu07E38EByOmi8wSfs5oYR6rZm6sYa9v8Vz/2kte
 wyNi0Mq2LyO2O4UcbSlPHixyODqiPifrilp2Jns8wNoC7cAvE+O4jaPJXlX5jOmrRMel og== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3se90u4d8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 17:43:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692405785; bh=sdvGu0tRz/jrukoMJ3xxCJ06B3ztGrV2fh6iX/zyfFk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GDh/uytHjW4A3DtxyzSkNKPEpuP9XfI/mbqfVMthSyoT+NTHJD4afxhQEJs1v3xvg
         5al5l6ecBR/+xEr6pPIkEuLs8ujAAzBJUT5+QzQ5uCMd9M0jK1x/Re1+TdI4h2ZjMg
         1H/82/1Nxrq4h6RF4lhaNy1crbv8ZCpmLZucx+au867x4oYkng/WVtWtKrwNQ6zi3z
         rhzLPJTjzVcU2jjvocvLNhNYbW2jaNNz/jK1jJlv7TlS0U5wB0efLaxxbFEKLelJYM
         W306F4bcZaqYQ0aBY8h9xSJF5CP3nKbKhCiT8CL4tnpj41zqqKzeh5lt9ow1uMR+AF
         S9fegSTFQp6sg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0BC834024D;
        Sat, 19 Aug 2023 00:43:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B26CAA008A;
        Sat, 19 Aug 2023 00:43:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Ru7Ubno0;
        dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CD9574058C;
        Sat, 19 Aug 2023 00:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSEW0cBfZ/nCAw1FUJM/UO70x77SY7XqqsGa7NjLMYPOVNmdxYKg4yKg88sWJk8jUZeymcaUHsH7DuVkOj5aEeX0s1dbq39YCtEwA474z37G8z3lE1eFSnqycDqMh9tf9HBfOmjtq30exwSld+qelSW++2JZv1txHoaTZPhFWMHpuBFFIEJLaTMMP34FrH26eQ0/fMY/tfIPWqHNJf5rYdMz6QMLktwVPLJ2ISsyVs5H7lmhbnP5tqNYgzuxRCvJf2T3kw0+7oGPPEUkme8nSFwZJB7+vghR1ttXi63d1Z+K9DGj1399J12xX4aOitV+eVh6ZeNWmqHLC/gg7n/Sdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdvGu0tRz/jrukoMJ3xxCJ06B3ztGrV2fh6iX/zyfFk=;
 b=BS3TeCwVMtVUAgT3GLwxYCgQAfSmkxUbNQzX+1e5uTg9QYd20qDovuaDSmicoRXeNzqE9nCHzuF23agDq+ARnoDi9sr5GeCvY2sZPe1oa3oXP4Q5uBnDnCBMK/nnDVaxbqoc1WPWcTARJHXw2u64+TChoYVlPCNMt7UhFQJwJqxf2/DNfjJD87g6p/Zg7KCYUD5Jk6xXtwsoYkWsRBmSPtwlCu3ymhx7KfyOxHziVxg+LGzy/ZwLvvEdpNixn92syuvzH6dI1DhSus22hlyVUZtjzIqbZjHLAYXRB9qJIdrBYw8gyWWhgSmftqZIGq0B/bgFl2v737mLeUtH0BOIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdvGu0tRz/jrukoMJ3xxCJ06B3ztGrV2fh6iX/zyfFk=;
 b=Ru7Ubno0ttJq8O5UeVEY2edrSouSXSh7DjkGRczVUE4zq9HGkO4raDvnv281ILS/WldK8tpqAbXZAzWN0zY+HRLDFaot23+PIcTSGfD5EU5eeoW3dyFUD4HUgE4aViO6KPUyf2AbsPyw7Ilm+odAlLwlx6ZvN31QEvrzT62XBfg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 00:42:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b18d:912e:908a:5952]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b18d:912e:908a:5952%4]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 00:42:56 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Thread-Topic: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Thread-Index: AQHZzuBFIbiQId3K7UqIXmJcc9s6yK/sa62AgAQHiICAAFszAA==
Date:   Sat, 19 Aug 2023 00:42:56 +0000
Message-ID: <20230819004250.uae3z24m45ggk67l@synopsys.com>
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
 <20230814185043.9252-3-quic_eserrao@quicinc.com>
 <a77403f5-8b99-3012-3843-1999ee8d12ce@linaro.org>
 <6b27cd55-4e44-7a26-30ff-9692344cae4c@quicinc.com>
In-Reply-To: <6b27cd55-4e44-7a26-30ff-9692344cae4c@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW6PR12MB8898:EE_
x-ms-office365-filtering-correlation-id: 25c2b5e7-bd74-4fb1-fd7b-08dba04d3b0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uM6dwsEGiYIDNrizxROutz+Uu7QpUlrqangUfxBOwxNvgurFb+ryrsrj9tttMO38q3UnwBm+396nV9RdOuA5ePFOzyex78xRgsyHuuRsU++tjPUzudfOzZyNftnShYrPymDcGSZQp6GRpY2/2AEwLP1cKR2Sci5gm7BqRAgATMeK1R9PU8/h1goZYYmQYNJHulesNOAp/H86M21CP603nsrfokt2D7FkOpUgcD+6qa3aiiiMuoyKbPFysCzHfrUHeMlr+RoV/RiN8Y4hDHDpQ6KLudWx7SpEoWvrFUzQkuaT5iKDWmqPI+7C5pycu50N44Ml9UY+lgePZ3TbiD2nwhy4Mjc5gcJAftEjUue4MY7m7e1UVMOmYrd7a42sg8XCrDAqylssklIpCLX3BfKKVo6tkI2oCKvicWXimi4TItRdjjzeddhqIRb1YszgRoVz7C7UMSGxkIPqjaB7gLYCmedAipESoMBgFdXyflbMpGeHlKDiShxMBwa0e1PmZMu9LmpDZ4yRhgDYUORhQV/EihhHEBRpy+JsgvFoA1cmSOQxcGuPPGh3NyZlrKUV+U1bH04m8d0h2bhDDjO8DSwYrRXOHyZ0bfdVpPFA4TEPTPklgtBmThmQ0N1EGCXBaBGT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199024)(1800799009)(186009)(122000001)(316002)(15650500001)(1076003)(26005)(71200400001)(6506007)(6486002)(53546011)(6512007)(2616005)(4326008)(83380400001)(5660300002)(8936002)(8676002)(2906002)(7416002)(41300700001)(76116006)(64756008)(66476007)(66556008)(66946007)(66446008)(54906003)(91956017)(478600001)(6916009)(38070700005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHBOSXZzSUZ3ZUlzTnQ0WkVXVklKVk5UNmxRclNPaVJ0bFg1bFhWK3VxdkE2?=
 =?utf-8?B?WHd3K3g4Qk5rckZJVXFQOVZtWGUzRE5JYW50RVNjc1I4SlROSG9tcGlTbytu?=
 =?utf-8?B?aU1YSk90bDA4SVhEL012T3p4UnY3RFhtcHhkL1pBWlNRd2FjbEtaQnlWUmtE?=
 =?utf-8?B?K0hRN0JFVmdjeDBKaUlaSy9DVTVYQTdaWktRRUUzUWFaNkpad0ZHaUZOTVNj?=
 =?utf-8?B?eXU5ZVFoaUhMOVVCa0dOM2FmKzlPQ1dyRGRUTkRhVjdFODJyL3JnWFVsWWVZ?=
 =?utf-8?B?cnlVWXFJc0l1NG5nalNBbUQrRXgrL3BFekZSWlRyaG9qVWVyU01MRlZFWS9p?=
 =?utf-8?B?ODVNZzg4dGJXalp0YVUzSmZSZ242b2xNUUdkVFgyRXljcXlzZUtnRzRvUUZM?=
 =?utf-8?B?Wk9CeUkranc3NnBqWDNYd3g0NTVhNE1oMERxWkErQUJQSW41MGJ4am5FNDVC?=
 =?utf-8?B?N0J4dk94eWlSQWxtQ2dIdy9uR0dWS0lQMEJ2NzJyQXNJcDF3cVNVOVJQSmNM?=
 =?utf-8?B?TEZ4bzBueXVLWDM4bHhDQklWOHEyNHNTUWR1cDh4UEJtWSsrdUtaZWdlTUo2?=
 =?utf-8?B?MFJYcEhXVVp4TjFOU1oxdk5kSzVmQ05wZzBkc0VaaFh5SndlSkxLZTFsb0x1?=
 =?utf-8?B?VlB0KzhGZ2pqUFEzalRUcXp1dHNMbHgwck9EK0N1bElidVNNb09ZZUdnUWgv?=
 =?utf-8?B?aFU0eWFReHppVVJldU5FVjg0TUtWUGl1NEtQMWk3aUZaMWFZR2ZVRmloYWZk?=
 =?utf-8?B?c01RNFZ3NkZDT21XR003V0htM2hlenNYdGo4SDMyczUxaExpTFpYWFBNbHds?=
 =?utf-8?B?cmt4a0crMzJSWDFSTTliSlpGdVZOWVVhMWNjYnpPOVp6SklDTEZxanloT2x4?=
 =?utf-8?B?ZnozbEc1aHNFcnlzL2ExWnZUTngvdVhYOVNPZHVrSWlGMTZLZ2xvelhabHVI?=
 =?utf-8?B?bzlpcFNjaEJTYjlhejkxYkxDMk91cnNqbkF5TzFKdmNnYU9CQTZRbWRmaitH?=
 =?utf-8?B?SlZwOTdMS3E4Um8wT2ZLZ0dtVmZ6VytoWG85SUlZT1ZvRHg3RDJHcXUwc3pB?=
 =?utf-8?B?djJxd2tWMFdMRDJhRkpuMkxST1V2NjlyZ1VpYmREWjZoSUc3QWlVMTdFK2Rt?=
 =?utf-8?B?NDdGV0s3MU9QYzBoa0Q4VzZ2WnByL3NEWFJuNE1mUmMxN0E0VjVPTFJ4L0JM?=
 =?utf-8?B?TXRENktsdHRmYTZBd3JObkNmbFViMkVuTmlGT2E1ZkI2SWNPZE43ZWZOczRL?=
 =?utf-8?B?eU0zR1FjUFY4UE14QXduVTJ1aGxkdlVYZ0J4UTdVb2VBNFQ3R0RKTjN0TFYy?=
 =?utf-8?B?L3RPdGx5YVdLL1JsNHlaZkg5THZaVjltalFOMC9TdlIzKzM3VnZNaHBqVmpN?=
 =?utf-8?B?Qm1kNUtJREVoaThIS2prUlNhOHdNcTFjSWdhSG9DakVxRHprR00wYjJjUFI3?=
 =?utf-8?B?VHdEamZ2QytWS0lkbERoYWl1alkxa0NPM2t6bHZ1Zk9venFzdFljZm96djR0?=
 =?utf-8?B?UU80SlFrRFlsM0Nxa2VIWG5yL0RTNEV2Y01WRE5UQXlPWlJ0ZFBWayt4UTZw?=
 =?utf-8?B?Q2lUYjJZam5VUU5nSDB6U2gvQ3BlbmhqZHg3RVJYZ0c2bkZTdjRieWFpTEFQ?=
 =?utf-8?B?NzljekNYRE9CRFZ0RHgzU0lXTVZlYktyMG5LYVN6S3hMdXRHYnVZQXp0anVS?=
 =?utf-8?B?VDJvTFc5bzlJK1BNVnN5MWQ2eEFFc21uODlLQmxucVIyRG9wQkVFeVFLbXpZ?=
 =?utf-8?B?Y0xsbFdqWENXWjhjTHZ1ampMY1NWdm5kM0RpQk9iTGxWSkJXV0cyR1pWYnNW?=
 =?utf-8?B?Y0pzMzBjYmRKU0tZNXFjNVVmVzF2Zlp0Y1ZMSUVyZW10UkMwSktPak5wZ0Fz?=
 =?utf-8?B?b0Q3V2J3bmZZeHJkQnd6Z2ZyYXhsTzluWWsyMHFGQlArK1lzZTkvVXBLY0pH?=
 =?utf-8?B?dG9UVjVMUW9JSnA3alJlcmlvbHROd1N6dWZFVU12VlA0WEJlTzlUMWVLL3VX?=
 =?utf-8?B?c3diNEpwcXQzSVJXMG1WSEl1MER3WUw3dWZrRHh1cHcyS2Vvdk1tcmlsNFdP?=
 =?utf-8?B?bVhpS0FiQkVzeTR4dTBUUUQ3Z2dMQjVaWFpGdlJNTGp0dW5NS3EydU5rL1dY?=
 =?utf-8?B?ZVpRdFhWRTRrQXRvTlJ3T3NUVm9OaG5SUnhUbGFacjdQM3AzQkNRZnJMN09I?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <268065C1C9E695459667897FA5DBFE66@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VytsTnVibFhtVC9RZFJOd1ZsdVVLRHZwd0tUNXM3dGYxMkRrWnI0Q0YyMDhx?=
 =?utf-8?B?N1Z0MGNsZE9mNW5RcW15R2xLSmZESDJDODdkTWk1LzFYL2pxYkRBRlV6MEdy?=
 =?utf-8?B?TnV0UjZmL05SWGd1S2RIeURDcUFnZEVveEFNZmJldDZaQk9rUlE3dkpyM0tD?=
 =?utf-8?B?YjVXQnpzeGcyZVdDYlVSQVE2TzcreE9EcWFrdGZLaW4zdWFnWGsxRzREUTMx?=
 =?utf-8?B?bjlLYkRyWFg5cWhJQk1aYkIxTjVScjVLMTkzRnpIbnFRM2FFT29rdzlqcmpk?=
 =?utf-8?B?N1JsZzhLMzRqVFpGYmxGMCtURTUrQTE3Mmg2VzdEbzQ4b2R3djB5VS9xbWx3?=
 =?utf-8?B?QjN4V3d0bzJtTWJ0MEdyUUlhNjJLa3dZaFl1VVZLZzBFWk1HalljR1BDVm5x?=
 =?utf-8?B?ckdqalNXNEFqV0UvNDM1SE1aZEdSKzZ0bW9uNmEyU0w3SUFQTEdBWUZyenhL?=
 =?utf-8?B?ME9nWHJNaTROK2ZMT3NrN0h5eDNlb3U1b0RqWHJBRmVhcEI5RVRNS0pzc29B?=
 =?utf-8?B?NTJITWcvOTVCM21HM1dPRTZndlQ2VDlEWTlUUkdNNzNpaDN1bktEQTJOaDdx?=
 =?utf-8?B?Uk5Dc1VXRkhROEdJbVBiU1piRXF2UkZ2OGw2dTZ2S2NCL1g0c1ZFR1NvSWdM?=
 =?utf-8?B?NURvWmFOMmZGR2JVUzZ5QldoL2g1NSt4bTQ2T1V6NmxXQ1d6MERqbi9hUzE1?=
 =?utf-8?B?LzVyc0JYYzFPaThNckJTUkl4TVVyMWozaDJjOC90L1NSMEUvdzVrcjZBdVk3?=
 =?utf-8?B?RUZ3NHBNcUtPcGVkSnhPbDBGZUJpRUw3TjByeEIxeXIrWVZvbHhOL3RBWGJy?=
 =?utf-8?B?NXZhNGZ1RDQ5cExZZzFXbFRBWUNlSUZoM1Z5WkYvU0tpVTNFSzdIamJITkRz?=
 =?utf-8?B?VGJVUExETHV3dWtWSndTcFJrVnRnTlMwVlBMNmdGZ0s5bUZSazkzQmdURzhi?=
 =?utf-8?B?ZkFDWjBucUZMNUVrQUV4L2FZUWFpMkFOSHp6T0hEUmRoQ2pBOWdVNU4yK0lP?=
 =?utf-8?B?Ky9wVXRRUnQ0MVpQVEt1cld1WnlraXRHQ1hUa1Z3WTIxRFhwejZrRzRhMjdt?=
 =?utf-8?B?N2xBLzZvbWR3cytMNXlWbDJoeDQ3QWV2bFY1bEhocDAzQXRyallPd1RmeWMy?=
 =?utf-8?B?SnpheVYweDhGZ1pUQ1ljWmR5SURYaTEyU2dkamthRHBZbHJTUDNiRHZkcXBl?=
 =?utf-8?B?d2JvcnE1T3R1VnN6elJFcXViU3ZUVW41Wm9ZaktPQ3RBVS85R1I3bTNsdllH?=
 =?utf-8?B?NDh3dUFpYUU4U2ZVTE1EejFNZjBNanNxdG1GbndvajBmMjB1QT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c2b5e7-bd74-4fb1-fd7b-08dba04d3b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2023 00:42:56.6548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OnvDcXKH0As1CaKeCbrzR87QX8G3TEr0yHonYYd7s4J8Keo4d+nk7Kg1p8haF06V/OtAh1hpF4yDu8CsIrQiCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898
X-Proofpoint-GUID: 7EPEu9G5QlK0PwkRuQohkb2dYbfcQmPq
X-Proofpoint-ORIG-GUID: 7EPEu9G5QlK0PwkRuQohkb2dYbfcQmPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_29,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 mlxlogscore=791 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308190003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMTgsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiA4
LzE1LzIwMjMgMTA6NDQgUE0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gT24gMTQv
MDgvMjAyMyAyMDo1MCwgRWxzb24gUm95IFNlcnJhbyB3cm90ZToNCj4gPiA+IFRoaXMgcHJvcGVy
dHkgYWxsb3dzIGR3YzMgcnVudGltZSBzdXNwZW5kIHdoZW4gYnVzIHN1c3BlbmQgaW50ZXJydXB0
DQo+ID4gPiBpcyByZWNlaXZlZCBldmVuIHdpdGggY2FibGUgY29ubmVjdGVkLiBUaGlzIHdvdWxk
IGFsbG93IHRoZSBkd2MzDQo+ID4gPiBjb250cm9sbGVyIHRvIGVudGVyIGxvdyBwb3dlciBtb2Rl
IGR1cmluZyBidXMgc3VzcGVuZCBzY2VuYXJpby4NCj4gPiA+IA0KPiA+ID4gVGhpcyBwcm9wZXJ0
eSB3b3VsZCBwYXJ0aWN1bGFybHkgYmVuZWZpdCBkd2MzIElQcyB3aGVyZSBoaWJlcm5hdGlvbiBp
cw0KPiA+ID4gbm90IGVuYWJsZWQgYW5kIHRoZSBkd2MzIGxvdyBwb3dlciBtb2RlIGVudHJ5L2V4
aXQgaXMgaGFuZGxlZCBieSB0aGUNCj4gPiA+IGdsdWUgZHJpdmVyLiBUaGUgYXNzdW1wdGlvbiBo
ZXJlIGlzIHRoYXQgdGhlIHBsYXRmb3JtIHVzaW5nIHRoaXMgZHQNCj4gPiA+IHByb3BlcnR5IGlz
IGNhcGFibGUgb2YgZGV0ZWN0aW5nIHJlc3VtZSBldmVudHMgdG8gYnJpbmcgdGhlIGNvbnRyb2xs
ZXINCj4gPiA+IG91dCBvZiBzdXNwZW5kLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBF
bHNvbiBSb3kgU2VycmFvIDxxdWljX2VzZXJyYW9AcXVpY2luYy5jb20+DQo+ID4gPiAtLS0NCj4g
PiA+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFt
bCB8IDUgKysrKysNCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+
ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3VzYi9zbnBzLGR3YzMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2Ivc25wcyxkd2MzLnlhbWwNCj4gPiA+IGluZGV4IGE2OTZmMjM3MzBkMy4uZTE5YTYwZDA2ZDJi
IDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Vz
Yi9zbnBzLGR3YzMueWFtbA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0KPiA+ID4gQEAgLTQwMyw2ICs0MDMsMTEgQEAgcHJv
cGVydGllczoNCj4gPiA+ICAgICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gICAgICAgICBFbmFibGUg
VVNCIHJlbW90ZSB3YWtldXAuDQo+ID4gPiArICBzbnBzLHJ1bnRpbWUtc3VzcGVuZC1vbi11c2It
c3VzcGVuZDoNCj4gPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gPiArICAgICAgSWYgVHJ1ZSB0
aGVuIGR3YzMgcnVudGltZSBzdXNwZW5kIGlzIGFsbG93ZWQgZHVyaW5nIGJ1cyBzdXNwZW5kDQo+
ID4gPiArICAgICAgY2FzZSBldmVuIHdpdGggdGhlIFVTQiBjYWJsZSBjb25uZWN0ZWQuDQo+ID4g
DQo+ID4gVGhpcyB3YXMgbm8gdGVzdGVkLi4uIGJ1dCBhbnl3YXksIHRoaXMgaXMgbm8gYSBEVCBw
cm9wZXJ0eSBidXQgT1MNCj4gPiBwb2xpY3kuIFRoZXJlIGlzIG5vIHN1Y2ggdGhpbmcgYXMgInJ1
bnRpbWUgc3VzcGVuZCIgaW4gdGhlIGhhcmR3YXJlLA0KPiA+IGJlY2F1c2UgeW91IGRlc2NyaWJl
IG9uZSBwYXJ0aWN1bGFyIE9TLg0KPiA+IA0KPiA+IFNvcnJ5LCBubyBhIERUIHByb3BlcnR5LCBk
cm9wIHRoZSBjaGFuZ2UgZW50aXJlbHkuDQo+ID4gDQo+ID4gDQo+IEhpIEtyenlzenRvZg0KPiAN
Cj4gU29ycnkgbXkgbG9jYWwgZHQgY2hlY2tlciBoYWQgc29tZSBpc3N1ZSBhbmQgaXQgZGlkIG5v
dCBjYXRjaCB0aGVzZSBlcnJvcnMuDQo+IEkgaGF2ZSByZWN0aWZpZWQgaXQgbm93Lg0KPiANCj4g
VGhpcyBkdCBwcm9wZXJ0eSBpcyBtYWlubHkgZm9yIHNraXBwaW5nIGR3YzMgY29udHJvbGxlciBo
YWx0IHdoZW4gYSBVU0INCj4gc3VzcGVuZCBpbnRlcnJ1cHQgaXMgcmVjZWl2ZWQgd2l0aCB1c2Ig
Y2FibGUgY29ubmVjdGVkLCBzbyB0aGF0IHdlIGRvbnQNCj4gdHJpZ2dlciBhIERJU0NPTk5FQ1Qg
ZXZlbnQuIFBlcmhhcHMgYSBiZXR0ZXIgbmFtZSB3b3VsZCByZWZsZWN0IHRoZSB0cnVlDQo+IHVz
YWdlIG9mIHRoaXM/DQo+IA0KPiBTb21ldGhpbmcgbGlrZSBzbnBzLHNraXAtZHdjMy1oYWx0LW9u
LXVzYi1zdXNwZW5kLiBkd2MzIGNvcmVzIHdoZXJlDQo+IGhpYmVybmF0aW9uIGZlYXR1cmUgaXMg
bm90IGVuYWJsZWQvc3VwcG9ydGVkIGNhbiB1c2UgdGhpcyBwcm9wZXJ0eQ0KPiANCj4gSGkgVGhp
bmgsUm9nZXINCj4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgb3BpbmlvbiBvbiAnc25wcyxza2lw
LWR3YzMtaGFsdC1vbi11c2Itc3VzcGVuZCcgYXMNCj4gdGhlIHF1aXJrIG5hbWUuDQo+IA0KDQpJ
IGRvbid0IGNvbnNpZGVyIHRoaXMgYSBxdWlyay4gSWYgdGhlcmUncyBhIHF1aXJrLCBzb21ldGhp
bmcncyBicm9rZW4uDQpJdCdzIGEgYmVoYXZpb3Igb2YgdGhlIGRyaXZlciBkZXBlbmRpbmcgb24g
dGhlIGhhcmR3YXJlIGNhcGFiaWxpdHkuDQoNClNvLCB0aGlzIG5hbWUgc2hvdWxkIHJlZmxlY3Qg
dGhlIGNhcGFiaWxpdHkgcHJvcGVydHkgb2YgdGhlIHBoeShzKS4NCg0KSSdtIG5vdCBncmVhdCB3
aXRoIG5hbWluZyBlaXRoZXIuIFBlcmhhcHMgdGhpcz8NCnNucHMsZGVsZWdhdGUtd2FrZXVwLWlu
dGVycnVwdA0KDQpUaGFua3MsDQpUaGluaA==
