Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F7279DD60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbjIMBHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjIMBHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:07:04 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD49E6;
        Tue, 12 Sep 2023 18:07:00 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CMjMT7013911;
        Tue, 12 Sep 2023 18:06:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=mJoAtH+SSw6s0d1pjLcRKtk5YbnEDDapZtM30aMJvnE=;
 b=OcGSqqrp/kqWgSuooEBNlw0mp3oB92Dp10GNSDrwtfbhAiPeBgKiZh1G5429C6G8Kmzc
 ifjY8mOhnsAPcIJb4IpFQVidRCIuo2W6V51jZysC1Lj6Hi2R63tJqPeecAC3NSzXAaxq
 nvuOJBXbvCTWLnyu6KGrZCuQ79IVzU0lfIjQ6LEsc4OxHoCvpLiKWTDeiHBd+MwrjET7
 ZiEYOf0HDjRoI0wzsjGFDpVTTcnH5BMQb4hx6fWtQbPcG+nWJHuYXuBaQh2PjVFuH0Kh
 jUpYxeYEu9p5XABIjpVA4HIIvqMRre4V+e23QeD4deQEPCS4Z7LUN38md/vMDb9p+T88 Cw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3t312e8g79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 18:06:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1694567205; bh=mJoAtH+SSw6s0d1pjLcRKtk5YbnEDDapZtM30aMJvnE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=N/PDDKECyi+PlOyja7Uh2bqnaiVliuiZruf0kzeVKweV0/b32kYCD6r0jc9AImhpJ
         oqPyavqIdeQyWeNIqvcjl4j7yCK37NLi7RoeltYyfEZG33lTYlP/boDZJST0EDq2U5
         KGPIPcL/Ff1oD3UsjXnFq3j5cs5zGTbyosoS3icX6HqWMQ+8pP/i6HtQKx/SjnUJNj
         3zwiTEag4aF29Ftf7Y783drRuliNt9iOHXbqO3kXVlViEtno3/ge2rnNbWIBT3KqPK
         Y9Z5l/Q3s+bGo6io4pnMSrGg93bp1jG18VaapJ5ikocbhpZ9zkD593LTBYC+c5wVYc
         NLB0Zszd+rh5g==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0FBD040467;
        Wed, 13 Sep 2023 01:06:45 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5886DA005F;
        Wed, 13 Sep 2023 01:06:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=PzFYfdI2;
        dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0480440087;
        Wed, 13 Sep 2023 01:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVi1rj2dcdcQhYWGZ11pMaWwUxJ2KvLn56s3LxHlXspHvdOJhzF09QGvjISBCxJEUHpzNfntsLJwUHWYbbsQUJkJLYL0Euvfbtv9oc5wH9/l6/xWB9GChBsezuUsbpiplBmp/0TZJA79sOBgbz1iUhJdJrz4dRMAxI7zW/361pWlr0oP8K0421Izi8+ncmLy8+T01Enir/bFa8FMVxV+H7ybldvD+/XyD0PEqEfmW6URXeXJaGacyl8KYRe4z9xlFSMu2qKEVz2/rA45xRFwu3Ar0doinnfSEW9Wnmbk0oZG/VXm2RYg3G5UkVCl7RUre/89KLXi2y98STGwkBWU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJoAtH+SSw6s0d1pjLcRKtk5YbnEDDapZtM30aMJvnE=;
 b=IslW96GPgiXIfi5slhjMqJ4klt/bN552skrZkBo9RiOwFUtSyt2vQCNDhKMcIEl32dFF73+03IA8yGo4PGlrkHCWhdZeCEi2ahgEKciaePov8YNeIpr19jsUUfw0MgKjEpSgtWKj5vWfKyrP6r90eEEkmtxqWG7vRMcEi9rS8sbZ/i/yuXxAiuQUkt7jUQWUgdrRVaZjAmjJOcij9CaPCzkLPzRBFM6fZjsSfNuaCNPczI4mUeQSlj2b1G15JQDFcbZ/6CS6171vy880hJia3/WwLBUFN2m/TIOyR5nPjGYwB/tWVNlZ1JjDh/AshDrN9ffdZMFVdvMZWecUq9A+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJoAtH+SSw6s0d1pjLcRKtk5YbnEDDapZtM30aMJvnE=;
 b=PzFYfdI2mRgLvQmGbct+PYsKiyQwZVvw+al7hJCOM6ZjRPce+H1+rkWm3kt5T3R2HJbDfq8x9zmTM45qtmJ11GwlTG/O6sGsIbH8OE6I8Mkr5pyE6f1ZKmObBaI2fvkaACwI3Dr42SrMOIU4VHPwlS8dpg1GSGkhRsHgh1k94g0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 01:06:40 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 01:06:39 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] usb: dwc3: core: configure TX/RX threshold for
 DWC3_IP
Thread-Topic: [PATCH v3 1/2] usb: dwc3: core: configure TX/RX threshold for
 DWC3_IP
Thread-Index: AQHZ5TBTh26t0fWYgEyLgYbMcHtXnLAX2kOAgAAYc4A=
Date:   Wed, 13 Sep 2023 01:06:39 +0000
Message-ID: <20230913010637.c4eukssffviugkhl@synopsys.com>
References: <20230912041904.30721-1-stanley_chang@realtek.com>
 <90e27f2b-4512-6121-c5f4-e7cb87b259ab@quicinc.com>
In-Reply-To: <90e27f2b-4512-6121-c5f4-e7cb87b259ab@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA3PR12MB7998:EE_
x-ms-office365-filtering-correlation-id: 091fa52a-3b28-40f1-0383-08dbb3f5af93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C0Rrfleg2hwGwN2zYz3aQkeyzCbNWfUO8QFQ8jf1wz7f4vxMvVRul46atrSabMXCVH544mznp1NaYTYjlU7u7Hyfth7kacx6qzWV2/BKAY/HiEVUxJGDjqxrPDEADkVvn9np+XT2wjO3EuZ7wqA7REMTkWlu28eEByFtrDcjRB1IDssmkLp1v60PSMH47erkgqe3TC+OBVF9blHT6QyeJtbby+ezxYNfm5PP7TJWIR1PdoFpIFgeXq4zUDZPQRUX8HbuEb3Gm4RQtfJSm0ZudLZ2W+fRFiO2y4jBp6bBDmFuv4vCvLeLujauDL+bVG4KvqjG3HZDc12pjuSVPQwKN9mE9TPV8obwkWKaUVmqyD0s+WuX3Jb11YurWOELS+qBNU2czLg5b2SbPUQNtmetKPuhAq/xIkNh0gFb1gN2eu79arm0Ck0ETVNQnHNCx3Bxfv7krlIlukMrYDj6Slrf/vvPFFpZMlRKn/7imiRhLR+132BL1kTxtmCp8vHJKTLnXD35QSZSG7nuP44aTRwvCGO4cltHvaojZRgyX39Kjh6ONuVe5aSW3Kvn2fTTO5YV7+iLs20uNq5qUnepOOSpKBakoTdro8QDYpf4ylsOavJV1IK9TlMWyZ0GGsHie0fm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199024)(186009)(1800799009)(6506007)(53546011)(71200400001)(6486002)(6512007)(478600001)(1076003)(2906002)(26005)(7416002)(54906003)(66946007)(66446008)(76116006)(6916009)(66556008)(64756008)(66476007)(41300700001)(2616005)(8676002)(5660300002)(83380400001)(4326008)(8936002)(38100700002)(38070700005)(86362001)(36756003)(316002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkQzTTN1NXpHZ2owVVhhRzE0QUE1NUN5SlEzK29EN3l1OXZ5VVBERUVnQUhL?=
 =?utf-8?B?d2ZUNzdyNkZNaGp6UWsvZThCT3RXUk5FNkZGSEV1dXJTUWdySU43OGxTLzZ4?=
 =?utf-8?B?NGxYaWkzOHRzN1ZlMWZBbTN4d3gvZ20wSzhKdlE2a0NZdkNBZ3BvRTl0amlZ?=
 =?utf-8?B?VVJia3J2bDhoQU1kbXdPTWxBQUUrbEZWQ0t1VVV5cElQa1FybTd4MFpjVk1k?=
 =?utf-8?B?bXVVdE5ZUzBsRkRyV1pwRTNUTktLdVVSeC9lY28vZjEwNTlWYWtGdEdTZitl?=
 =?utf-8?B?ZVVDcE9yYjByUlRrQVgvTnFOMGNzTm4vc2pZK1dJems0SkNaOEZWYTRZTGFB?=
 =?utf-8?B?WFlqTnRTSWRuWUZtME93RzU4NlJYTVp1Y1RURDNRQTJGc3liQnFRV2tVZURO?=
 =?utf-8?B?UFdsaVRNSDNlUm80cE1DQTBjOUFIM0h3ZUtOSjZ5SlNyWlNwT2lOc1FMcWZC?=
 =?utf-8?B?RjhTdThxY0VxKzJULzE5UW01d2RuNkhZVVFHYXFHVXp4K1FKcTNhTmJFQzZW?=
 =?utf-8?B?SDV1cjBwc0hWVFJ3OEMydXNKSjd1OGZ1K2V6ekpvS1ZJTjdZMTBocmZ2MHlk?=
 =?utf-8?B?Mmx2bFZwRC90NGVUWWYrWnk5WjNuMDJDUTV3cjltZUZUNmhvU2hWZUZuaGJp?=
 =?utf-8?B?UGY3WWU4Yi9manNWdUovdVBKNVNOWEtNSG13RzRObDludHhqWG53YlRSK2NI?=
 =?utf-8?B?OEp1M3h1bk5XZk9udFVuV1V4NWlDb2JlNzBqQk9OaDhQK3VOMFNvcXllMGEz?=
 =?utf-8?B?NWtkVjRWNmZ4cXJ6Tml2azIxL09rK2xLRGxOaDdTTk1GeGw1L3Y1am5rVFhV?=
 =?utf-8?B?SzRsODR5aEdRNjh0TGx3NVpDNi9ZbXZENlNmVjFjQmJNcVNCQnNPSnh2ZFJN?=
 =?utf-8?B?U2ZkTnhiTUtDVHpvYmRzY0dxcllNdVdNejZjS2hXdU01Q3JEVkQyZ1lPRC9m?=
 =?utf-8?B?LzdubzZxOEgzYTlKOWNaRXNMa3VOTFQxaDdKeTBWMFRKZE52WGJ4YmxHdng5?=
 =?utf-8?B?UmZqV1JtcU5CenRkVVBxeU5ENHl1cnhwUm5uM2pVRnJWVGVOMmc4NEFmRE5O?=
 =?utf-8?B?ZTZzcHZQVXNkL2gvTUl0STZsN29qTlNsTkJMMUxCOVZreVdzMVM5MDYvaFVp?=
 =?utf-8?B?QndPMEJMalJjY2lEdk03bkpLa1grc001d3dPUzEvdnBJU01HN2toYmltYXJ2?=
 =?utf-8?B?S2YyanB3M3JKamtuR0FMdnpQVlpyTTlVR3J0RTJOTG4vcGcwZ2FBWmRLeFcr?=
 =?utf-8?B?ZkhTbmxNTEZ1RG9qbzRWSUg5MXk3S0FxSkQ3bnFuYlVGMWZXMlhwVUVIUGRa?=
 =?utf-8?B?MEpTQzRkRFdvVThFNkdCSmRkeG1rQ2tJQ2xsMDhXM3FlbGJVeXNkc3JjaEc3?=
 =?utf-8?B?Wi9JalBmTGJqYVlSYVUxSXU5MnlmUmVqV2hWL05VR3doWWZHYnZLQTByUVUw?=
 =?utf-8?B?NFZpdHc5NlBIS0dzVXJrcldEQ01CYnVrOUtvSE1WK1lSZHcwQTlxem5ZNFNI?=
 =?utf-8?B?c2Q4dmQ2dVRDdmswSko2cXNZMDNIc2RGM2NGM1pDbEF4aHFITlc3V1F4ZHM1?=
 =?utf-8?B?d0kvdzFab3I4N0NyaUliRkRyQzg5YVJnaVdXSUp5eCt2b2JCMVBMT2ZiY1RY?=
 =?utf-8?B?S1FnamkxZGtwM0VUZlJ6Y0F4MVg5YXhHdHpuMTM0NXJtdkpWNS9WMmlvM3Jl?=
 =?utf-8?B?d3BBZEtoUUNPQnBkNWJIWis1VFZydTNBZkpENkRENFlYL2NlVS9DSmFzdThh?=
 =?utf-8?B?L3gzMU54WGpPSGRDRkhlcDN1TkhQMDk1ZjJkZUQxcVIxQmdVZHlzWGxwTFI2?=
 =?utf-8?B?WHp1THNmejVHV0ozNlIxaDBiQVhBSFY3UWZDeXo5NVBDUHl3VDNKd1RwS0Fk?=
 =?utf-8?B?dmJvUnhVMnVxKzdwaWU1YTVoVEd2ZnA2c2piK21kaXUvem83MDlVVDd3K0pU?=
 =?utf-8?B?MGFZOGZyNlFidHE1TXZ0UzdrVmV4aEVlNklGT2Zid0xzNld5RWtUQS9TaUxz?=
 =?utf-8?B?TGhReExpVVIwcElLME5ianE3bEtIWE5hUDdmNE9nSzBrcm85eDBVeWdtbXly?=
 =?utf-8?B?V2NDMFBSMm1rVnFyTXlJNVJ4a3hnUUszZXBFakFiRWhJUFBjbmNqYmp3SHJH?=
 =?utf-8?Q?sfJmPqJA3cY1sehrc3oN0qYX5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <088AC04EF647454B9A683D2560BB11DC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cnE5N2lNV3VHUW1CdVBMSUZPWmgwell4N1ZJZXNKSXNzZDd5ZjZQV3ovZkRH?=
 =?utf-8?B?cGxWVkM2Q1dhWkpOcTJocTBESkZRelNOQ2FKS2Y1VlVJRnhucFppRzlzRDlo?=
 =?utf-8?B?UXpUTE01WllCK0Q3ZzNkVS9MVWVmTWJVbUVNZjdzWDYwcVpBSEZEK2JxcDRP?=
 =?utf-8?B?WmZXVXVjcWttUUNDaFVsaWMxVENsYXFqcmVRVzRrWVhpQUhVQ21OZnhFV2dh?=
 =?utf-8?B?cVZCdDhjRDJwYVBzemg4TXJrdVBkWVNYbXhqUGhPc05HdGR5UkErMzBEeUg3?=
 =?utf-8?B?V2IrUzhrblZrV3Z4VmZ5ZWw4cksxM0xWS3BCcWIybjd0M0FSU1BWQVJqYm1Z?=
 =?utf-8?B?SDVxRVBhZmtLMnRYVmhaa0NGT0QxalhSb3ZTVDdpZkJYWms5dkJUd0taU0Rr?=
 =?utf-8?B?ZkpYOVVEc1JBUVJud0hhaGlURmlrbE8vdjU5dXVRWGoza3JvTGl2UjBQRUdG?=
 =?utf-8?B?T0E4Y251VkVqbHJncTJIQjFndXE4Wlc1dGlKd2lsOXlDTWFCSEI4VjhhZXpt?=
 =?utf-8?B?THYxRnhHOHI2RUFWQXlhVmJpTmFQWkQxWkZmQWFZSjBVU3NtWTNybWZuaUFy?=
 =?utf-8?B?NXZDQmZGZzZNaDJPSU95UkRkV0psK1IwQ2U3bkJOVGtySmVYendPalRROVZM?=
 =?utf-8?B?dVU2U1FScVhXbTJSQXE3WEtxZEt1WEsxOVRNU1ZydXVXU3JaVnV6dWtrcmlF?=
 =?utf-8?B?K0EzdzR4NE9YSXR6Q2Y2aFBEdXdXUi83ZTVDNzhCKytyN0MrWFAyNytINnJh?=
 =?utf-8?B?NFROV0lwTDhSWjNMQ1lyaHl5emdYRXN4c1ZYOGVDNVZsYWljOGg1S1NlcHBi?=
 =?utf-8?B?RzBSL1kwdTlLb2pXR3U4cFMvdG1SM3JNbzBGUjZ4OXVSbEpjRXlJVi8yUVd0?=
 =?utf-8?B?bExaOXMvRDlEczZnYXBmdGUwL2tjSlpnbUJmaWJaelVtVENEbVRyeDZHd240?=
 =?utf-8?B?aGR3VmNvOVlTQmZId0VwODNWcWRIVFdMYjZFc0ZVd0FQUkJLaGhSb0dWTWZl?=
 =?utf-8?B?T3ZENzkrdFVHOVF1OGtCNDJiQ2lyVllGU3BxbkRGWjE2NmxTNytBUnl2L04y?=
 =?utf-8?B?VWRkclFhK0ZaWVNXbFhwRFRnU3Job1JOc3JyaEFBcFZIcmVjaC9Fdm5VcGRZ?=
 =?utf-8?B?cHNmUlpRNjJTZ1JOQVhJRGpzWUo1TExlOWFhTGRkTDAySjZEM3JESEJUTFRQ?=
 =?utf-8?B?RHlwdzQ4U2U2ci9tRWkrdldxR0p2MWtWUTdZQWp2QWZRK1Z3RU1RR0l0RjBX?=
 =?utf-8?B?ekdXTFNWdkVGd2dYUTBuWnNjaml6K1ZTZlJYajg3RFFiSGhadG0vcjJodkV0?=
 =?utf-8?Q?ODTpnSQlR+IXk=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091fa52a-3b28-40f1-0383-08dbb3f5af93
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 01:06:39.6485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Qd8USmGJAAbxUo8a6gbBuyt7DvAU7frRQTdS/9UNKW0tbDu7p2p6Ipb98ByPMHg0GU/dM2cORznnZodMsmzyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
X-Proofpoint-GUID: MVzbGECN7a00iIEYHaEZ0UeLX4ZUomPr
X-Proofpoint-ORIG-GUID: MVzbGECN7a00iIEYHaEZ0UeLX4ZUomPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130007
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMTIsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gSGksDQo+IA0KPiBP
biA5LzExLzIwMjMgOToxOSBQTSwgU3RhbmxleSBDaGFuZyB3cm90ZToNCj4gPiBJbiBTeW5vcHN5
cydzIGR3YzMgZGF0YSBib29rOg0KPiA+IFRvIGF2b2lkIHVuZGVycnVuIGFuZCBvdmVycnVuIGR1
cmluZyB0aGUgYnVyc3QsIGluIGEgaGlnaC1sYXRlbmN5IGJ1cw0KPiA+IHN5c3RlbSAobGlrZSBV
U0IpLCB0aHJlc2hvbGQgYW5kIGJ1cnN0IHNpemUgY29udHJvbCBpcyBwcm92aWRlZCB0aHJvdWdo
DQo+ID4gR1RYVEhSQ0ZHIGFuZCBHUlhUSFJDRkcgcmVnaXN0ZXJzLg0KPiA+IA0KPiA+IEluIFJl
YWx0ZWsgREhDIFNvQywgRFdDMyBVU0IgMy4wIHVzZXMgQUhCIHN5c3RlbSBidXMuIFdoZW4gZHdj
MyBpcw0KPiA+IGNvbm5lY3RlZCB3aXRoIFVTQiAyLjVHIEV0aGVybmV0LCB0aGVyZSB3aWxsIGJl
IG92ZXJydW4gcHJvYmxlbS4NCj4gPiBUaGVyZWZvcmUsIHNldHRpbmcgVFgvUlggdGhyZXNob2xk
cyBjYW4gYXZvaWQgdGhpcyBpc3N1ZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5
IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHYyIHRvIHYz
IGNoYW5nZToNCj4gPiAgICAgIE1vdmUgdGhlIHRocmVzaG9sZCBzZXR0aW5nIHRvIG5ldyBmdW5j
dGlvbiBkd2MzX2NvbmZpZ190aHJlc2hvbGQuDQo+ID4gICAgICBBZGQgdGhlIHRocmVzaG9sZCBz
ZXR0aW5nIGZvciB1c2IzMSBhbmQgdXNiMzINCj4gPiB2MSB0byB2MiBjaGFuZ2U6DQo+ID4gICAg
ICBBZGQgdGhlIHByb3BlcnRpZXMgZm9yIFRYL1JYIHRocmVzaG9sZCBzZXR0aW5nDQo+ID4gLS0t
DQo+ID4gICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDE2MCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4gICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8ICAx
MyArKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDEzNyBpbnNlcnRpb25zKCspLCAzNiBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+IGluZGV4IDljNmJmMDU0ZjE1ZC4uNDRlZTg1
MjZkYzI4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiBAQCAtMTA1Nyw2ICsxMDU3LDExMSBAQCBz
dGF0aWMgdm9pZCBkd2MzX3NldF9wb3dlcl9kb3duX2Nsa19zY2FsZShzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPiA+ICAgCX0NCj4gPiAgIH0NCj4gPiArc3RhdGljIHZvaWQgZHdjM19jb25maWdfdGhyZXNo
b2xkKHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gK3sNCj4gPiArCXUzMiByZWc7DQo+ID4gKwl1OCBy
eF90aHJfbnVtOw0KPiA+ICsJdTggcnhfbWF4YnVyc3Q7DQo+ID4gKwl1OCB0eF90aHJfbnVtOw0K
PiA+ICsJdTggdHhfbWF4YnVyc3Q7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIE11c3QgY29u
ZmlnIGJvdGggbnVtYmVyIG9mIHBhY2tldHMgYW5kIG1heCBidXJzdCBzZXR0aW5ncyB0byBlbmFi
bGUNCj4gPiArCSAqIFJYIGFuZC9vciBUWCB0aHJlc2hvbGQuDQo+ID4gKwkgKi8NCj4gPiArCWlm
ICghRFdDM19JUF9JUyhEV0MzKSAmJiBkd2MtPmRyX21vZGUgPT0gVVNCX0RSX01PREVfSE9TVCkg
ew0KPiA+ICsJCXJ4X3Rocl9udW0gPSBkd2MtPnJ4X3Rocl9udW1fcGt0X3ByZDsNCj4gPiArCQly
eF9tYXhidXJzdCA9IGR3Yy0+cnhfbWF4X2J1cnN0X3ByZDsNCj4gPiArCQl0eF90aHJfbnVtID0g
ZHdjLT50eF90aHJfbnVtX3BrdF9wcmQ7DQo+ID4gKwkJdHhfbWF4YnVyc3QgPSBkd2MtPnR4X21h
eF9idXJzdF9wcmQ7DQo+ID4gKw0KPiA+ICsJCWlmIChyeF90aHJfbnVtICYmIHJ4X21heGJ1cnN0
KSB7DQo+ID4gKwkJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dSWFRIUkNGRyk7
DQo+ID4gKwkJCXJlZyB8PSBEV0MzMV9SWFRIUk5VTVBLVFNFTF9QUkQ7DQo+ID4gKw0KPiA+ICsJ
CQlyZWcgJj0gfkRXQzMxX1JYVEhSTlVNUEtUX1BSRCh+MCk7DQo+ID4gKwkJCXJlZyB8PSBEV0Mz
MV9SWFRIUk5VTVBLVF9QUkQocnhfdGhyX251bSk7DQo+ID4gKw0KPiA+ICsJCQlyZWcgJj0gfkRX
QzMxX01BWFJYQlVSU1RTSVpFX1BSRCh+MCk7DQo+ID4gKwkJCXJlZyB8PSBEV0MzMV9NQVhSWEJV
UlNUU0laRV9QUkQocnhfbWF4YnVyc3QpOw0KPiA+ICsNCj4gPiArCQkJZHdjM193cml0ZWwoZHdj
LT5yZWdzLCBEV0MzX0dSWFRIUkNGRywgcmVnKTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCWlm
ICh0eF90aHJfbnVtICYmIHR4X21heGJ1cnN0KSB7DQo+ID4gKwkJCXJlZyA9IGR3YzNfcmVhZGwo
ZHdjLT5yZWdzLCBEV0MzX0dUWFRIUkNGRyk7DQo+ID4gKwkJCXJlZyB8PSBEV0MzMV9UWFRIUk5V
TVBLVFNFTF9QUkQ7DQo+ID4gKw0KPiA+ICsJCQlyZWcgJj0gfkRXQzMxX1RYVEhSTlVNUEtUX1BS
RCh+MCk7DQo+ID4gKwkJCXJlZyB8PSBEV0MzMV9UWFRIUk5VTVBLVF9QUkQodHhfdGhyX251bSk7
DQo+ID4gKw0KPiA+ICsJCQlyZWcgJj0gfkRXQzMxX01BWFRYQlVSU1RTSVpFX1BSRCh+MCk7DQo+
ID4gKwkJCXJlZyB8PSBEV0MzMV9NQVhUWEJVUlNUU0laRV9QUkQodHhfbWF4YnVyc3QpOw0KPiA+
ICsNCj4gPiArCQkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dUWFRIUkNGRywgcmVnKTsN
Cj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcnhfdGhyX251bSA9IGR3Yy0+cnhfdGhy
X251bV9wa3Q7DQo+ID4gKwlyeF9tYXhidXJzdCA9IGR3Yy0+cnhfbWF4X2J1cnN0Ow0KPiA+ICsJ
dHhfdGhyX251bSA9IGR3Yy0+dHhfdGhyX251bV9wa3Q7DQo+ID4gKwl0eF9tYXhidXJzdCA9IGR3
Yy0+dHhfbWF4X2J1cnN0Ow0KPiA+ICsNCj4gPiArCWlmIChEV0MzX0lQX0lTKERXQzMpKSB7DQo+
ID4gKwkJaWYgKHJ4X3Rocl9udW0gJiYgcnhfbWF4YnVyc3QpIHsNCj4gPiArCQkJcmVnID0gZHdj
M19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1JYVEhSQ0ZHKTsNCj4gPiArCQkJcmVnIHw9IERXQzNf
R1JYVEhSQ0ZHX1BLVENOVFNFTDsNCj4gPiArDQo+ID4gKwkJCXJlZyAmPSB+RFdDM19HUlhUSFJD
RkdfUlhQS1RDTlQofjApOw0KPiA+ICsJCQlyZWcgfD0gRFdDM19HUlhUSFJDRkdfUlhQS1RDTlQo
cnhfdGhyX251bSk7DQo+ID4gKw0KPiA+ICsJCQlyZWcgJj0gfkRXQzNfR1JYVEhSQ0ZHX01BWFJY
QlVSU1RTSVpFKH4wKTsNCj4gPiArCQkJcmVnIHw9IERXQzNfR1JYVEhSQ0ZHX01BWFJYQlVSU1RT
SVpFKHJ4X21heGJ1cnN0KTsNCj4gPiArDQo+ID4gKwkJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywg
RFdDM19HUlhUSFJDRkcsIHJlZyk7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlpZiAodHhfdGhy
X251bSAmJiB0eF9tYXhidXJzdCkgew0KPiA+ICsJCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVn
cywgRFdDM19HVFhUSFJDRkcpOw0KPiA+ICsJCQlyZWcgfD0gRFdDM19HVFhUSFJDRkdfUEtUQ05U
U0VMOw0KPiA+ICsNCj4gPiArCQkJcmVnICY9IH5EV0MzX0dUWFRIUkNGR19UWFBLVENOVCh+MCk7
DQo+ID4gKwkJCXJlZyB8PSBEV0MzX0dUWFRIUkNGR19UWFBLVENOVCh0eF90aHJfbnVtKTsNCj4g
PiArDQo+ID4gKwkJCXJlZyAmPSB+RFdDM19HVFhUSFJDRkdfTUFYVFhCVVJTVFNJWkUofjApOw0K
PiA+ICsJCQlyZWcgfD0gRFdDM19HVFhUSFJDRkdfTUFYVFhCVVJTVFNJWkUodHhfbWF4YnVyc3Qp
Ow0KPiA+ICsNCj4gPiArCQkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dUWFRIUkNGRywg
cmVnKTsNCj4gPiArCQl9DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCWlmIChyeF90aHJfbnVtICYm
IHJ4X21heGJ1cnN0KSB7DQo+ID4gKwkJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0Mz
X0dSWFRIUkNGRyk7DQo+ID4gKwkJCXJlZyB8PSBEV0MzMV9HUlhUSFJDRkdfUEtUQ05UU0VMOw0K
PiA+ICsNCj4gPiArCQkJcmVnICY9IH5EV0MzMV9HUlhUSFJDRkdfUlhQS1RDTlQofjApOw0KPiA+
ICsJCQlyZWcgfD0gRFdDMzFfR1JYVEhSQ0ZHX1JYUEtUQ05UKHJ4X3Rocl9udW0pOw0KPiA+ICsN
Cj4gPiArCQkJcmVnICY9IH5EV0MzMV9HUlhUSFJDRkdfTUFYUlhCVVJTVFNJWkUofjApOw0KPiA+
ICsJCQlyZWcgfD0gRFdDMzFfR1JYVEhSQ0ZHX01BWFJYQlVSU1RTSVpFKHJ4X21heGJ1cnN0KTsN
Cj4gPiArDQo+ID4gKwkJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HUlhUSFJDRkcsIHJl
Zyk7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlpZiAodHhfdGhyX251bSAmJiB0eF9tYXhidXJz
dCkgew0KPiA+ICsJCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HVFhUSFJDRkcp
Ow0KPiA+ICsJCQlyZWcgfD0gRFdDMzFfR1RYVEhSQ0ZHX1BLVENOVFNFTDsNCj4gPiArDQo+ID4g
KwkJCXJlZyAmPSB+RFdDMzFfR1RYVEhSQ0ZHX1RYUEtUQ05UKH4wKTsNCj4gPiArCQkJcmVnIHw9
IERXQzMxX0dUWFRIUkNGR19UWFBLVENOVCh0eF90aHJfbnVtKTsNCj4gPiArDQo+ID4gKwkJCXJl
ZyAmPSB+RFdDMzFfR1RYVEhSQ0ZHX01BWFRYQlVSU1RTSVpFKH4wKTsNCj4gPiArCQkJcmVnIHw9
IERXQzMxX0dUWFRIUkNGR19NQVhUWEJVUlNUU0laRSh0eF9tYXhidXJzdCk7DQo+ID4gKw0KPiA+
ICsJCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1RYVEhSQ0ZHLCByZWcpOw0KPiA+ICsJ
CX0NCj4gPiArCX0NCj4gPiArfQ0KPiA+ICsNCj4gPiAgIC8qKg0KPiA+ICAgICogZHdjM19jb3Jl
X2luaXQgLSBMb3ctbGV2ZWwgaW5pdGlhbGl6YXRpb24gb2YgRFdDMyBDb3JlDQo+ID4gICAgKiBA
ZHdjOiBQb2ludGVyIHRvIG91ciBjb250cm9sbGVyIGNvbnRleHQgc3RydWN0dXJlDQo+ID4gQEAg
LTEyMDksNDIgKzEzMTQsNyBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2Mz
ICpkd2MpDQo+ID4gICAJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVUNUTDEsIHJlZyk7
DQo+ID4gICAJfQ0KPiA+IC0JLyoNCj4gPiAtCSAqIE11c3QgY29uZmlnIGJvdGggbnVtYmVyIG9m
IHBhY2tldHMgYW5kIG1heCBidXJzdCBzZXR0aW5ncyB0byBlbmFibGUNCj4gPiAtCSAqIFJYIGFu
ZC9vciBUWCB0aHJlc2hvbGQuDQo+ID4gLQkgKi8NCj4gPiAtCWlmICghRFdDM19JUF9JUyhEV0Mz
KSAmJiBkd2MtPmRyX21vZGUgPT0gVVNCX0RSX01PREVfSE9TVCkgew0KPiA+IC0JCXU4IHJ4X3Ro
cl9udW0gPSBkd2MtPnJ4X3Rocl9udW1fcGt0X3ByZDsNCj4gPiAtCQl1OCByeF9tYXhidXJzdCA9
IGR3Yy0+cnhfbWF4X2J1cnN0X3ByZDsNCj4gPiAtCQl1OCB0eF90aHJfbnVtID0gZHdjLT50eF90
aHJfbnVtX3BrdF9wcmQ7DQo+ID4gLQkJdTggdHhfbWF4YnVyc3QgPSBkd2MtPnR4X21heF9idXJz
dF9wcmQ7DQo+ID4gLQ0KPiA+IC0JCWlmIChyeF90aHJfbnVtICYmIHJ4X21heGJ1cnN0KSB7DQo+
ID4gLQkJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dSWFRIUkNGRyk7DQo+ID4g
LQkJCXJlZyB8PSBEV0MzMV9SWFRIUk5VTVBLVFNFTF9QUkQ7DQo+ID4gLQ0KPiA+IC0JCQlyZWcg
Jj0gfkRXQzMxX1JYVEhSTlVNUEtUX1BSRCh+MCk7DQo+ID4gLQkJCXJlZyB8PSBEV0MzMV9SWFRI
Uk5VTVBLVF9QUkQocnhfdGhyX251bSk7DQo+ID4gLQ0KPiA+IC0JCQlyZWcgJj0gfkRXQzMxX01B
WFJYQlVSU1RTSVpFX1BSRCh+MCk7DQo+ID4gLQkJCXJlZyB8PSBEV0MzMV9NQVhSWEJVUlNUU0la
RV9QUkQocnhfbWF4YnVyc3QpOw0KPiA+IC0NCj4gPiAtCQkJZHdjM193cml0ZWwoZHdjLT5yZWdz
LCBEV0MzX0dSWFRIUkNGRywgcmVnKTsNCj4gPiAtCQl9DQo+ID4gLQ0KPiA+IC0JCWlmICh0eF90
aHJfbnVtICYmIHR4X21heGJ1cnN0KSB7DQo+ID4gLQkJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5y
ZWdzLCBEV0MzX0dUWFRIUkNGRyk7DQo+ID4gLQkJCXJlZyB8PSBEV0MzMV9UWFRIUk5VTVBLVFNF
TF9QUkQ7DQo+ID4gLQ0KPiA+IC0JCQlyZWcgJj0gfkRXQzMxX1RYVEhSTlVNUEtUX1BSRCh+MCk7
DQo+ID4gLQkJCXJlZyB8PSBEV0MzMV9UWFRIUk5VTVBLVF9QUkQodHhfdGhyX251bSk7DQo+ID4g
LQ0KPiA+IC0JCQlyZWcgJj0gfkRXQzMxX01BWFRYQlVSU1RTSVpFX1BSRCh+MCk7DQo+ID4gLQkJ
CXJlZyB8PSBEV0MzMV9NQVhUWEJVUlNUU0laRV9QUkQodHhfbWF4YnVyc3QpOw0KPiA+IC0NCj4g
PiAtCQkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dUWFRIUkNGRywgcmVnKTsNCj4gPiAt
CQl9DQo+ID4gLQl9DQo+ID4gKwlkd2MzX2NvbmZpZ190aHJlc2hvbGQoZHdjKTsNCj4gPiAgIAly
ZXR1cm4gMDsNCj4gPiBAQCAtMTM4MCw2ICsxNDUwLDEwIEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2V0
X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gPiAgIAl1OAkJCWxwbV9ueWV0X3RocmVz
aG9sZDsNCj4gPiAgIAl1OAkJCXR4X2RlX2VtcGhhc2lzOw0KPiA+ICAgCXU4CQkJaGlyZF90aHJl
c2hvbGQ7DQo+ID4gKwl1OAkJCXJ4X3Rocl9udW1fcGt0ID0gMDsNCj4gPiArCXU4CQkJcnhfbWF4
X2J1cnN0ID0gMDsNCj4gPiArCXU4CQkJdHhfdGhyX251bV9wa3QgPSAwOw0KPiA+ICsJdTgJCQl0
eF9tYXhfYnVyc3QgPSAwOw0KPiA+ICAgCXU4CQkJcnhfdGhyX251bV9wa3RfcHJkID0gMDsNCj4g
PiAgIAl1OAkJCXJ4X21heF9idXJzdF9wcmQgPSAwOw0KPiA+ICAgCXU4CQkJdHhfdGhyX251bV9w
a3RfcHJkID0gMDsNCj4gPiBAQCAtMTQ0Miw2ICsxNTE2LDE0IEBAIHN0YXRpYyB2b2lkIGR3YzNf
Z2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gPiAgIAkJCQkic25wcyx1c2IyLWxw
bS1kaXNhYmxlIik7DQo+ID4gICAJZHdjLT51c2IyX2dhZGdldF9scG1fZGlzYWJsZSA9IGRldmlj
ZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiA+ICAgCQkJCSJzbnBzLHVzYjItZ2FkZ2V0LWxw
bS1kaXNhYmxlIik7DQo+ID4gKwlkZXZpY2VfcHJvcGVydHlfcmVhZF91OChkZXYsICJzbnBzLHJ4
LXRoci1udW0tcGt0IiwNCj4gPiArCQkJCSZyeF90aHJfbnVtX3BrdCk7DQo+ID4gKwlkZXZpY2Vf
cHJvcGVydHlfcmVhZF91OChkZXYsICJzbnBzLHJ4LW1heC1idXJzdCIsDQo+ID4gKwkJCQkmcnhf
bWF4X2J1cnN0KTsNCj4gPiArCWRldmljZV9wcm9wZXJ0eV9yZWFkX3U4KGRldiwgInNucHMsdHgt
dGhyLW51bS1wa3QiLA0KPiA+ICsJCQkJJnR4X3Rocl9udW1fcGt0KTsNCj4gPiArCWRldmljZV9w
cm9wZXJ0eV9yZWFkX3U4KGRldiwgInNucHMsdHgtbWF4LWJ1cnN0IiwNCj4gPiArCQkJCSZ0eF9t
YXhfYnVyc3QpOw0KPiANCj4gQXJlbid0IHRoZXJlIHZhbHVlIGxpbWl0YXRpb25zIGZvciBzb21l
IG9mIHRoZXNlIChpZiBub3QgYWxsKSBzZXR0aW5ncz8gIEZvcg0KPiBleGFtcGxlLCBpbiB0aGUg
RFdDMyBwcm9ncmFtbWluZyBndWlkZSwgdGhlIG1heCBidXJzdCBmaWVsZHMgc2F5IChmb3INCj4g
RFdDMzEpOg0KPiAJIk5vdGU6IFRoaXMgZmllbGQgY2FuIG9ubHkgYmUgc2V0IHRvIDIsIDQsIDgg
b3IgMTYuIg0KPiANCj4gQW5kIGZvciB0aGUgcGFja2V0IHRocmVzaG9sZCBjb3VudDoNCj4gCSJW
YWxpZCB2YWx1ZXMgYXJlIGZyb20gMSB0byAxNi4iDQo+IA0KDQpTdGFubGV5IGRvY3VtZW50ZWQg
dGhpcyBpbiB0aGUgZHQgYmluZGluZy4gSSB0aGluayB3aGF0IGhlIGhhZCB3cml0dGVuDQp0aGVy
ZSBpcyBmaW5lLg0KDQpUaGFua3MsDQpUaGluaA==
