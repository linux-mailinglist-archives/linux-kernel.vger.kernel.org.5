Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969CB7B593E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbjJBRLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJBRLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:11:08 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4F8AC;
        Mon,  2 Oct 2023 10:11:02 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392Gt7fW025936;
        Mon, 2 Oct 2023 10:10:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=86FIRVk4STT00FUxCqbekGLPkogJkQ+V+RAuE7ImiRo=;
 b=nHXGmjQK4IlpOK9lSmZxrYwb3OuT6o4WwfVtp9iTNzmZZp8bvYVpk5YVS7+eiWyYkAPC
 zCywWE+UD/A/YmiR4B5QibFxyU9DjoPgyg8jDrYg3RgMDrwu62VYcwn8ra2hwhRd0fhx
 6UxkkY9w0EL92yaC3UuMHvTnrsa7Gq6mjqQwX/C+z26rgpvLs7y6u0NziEaVv1yUA6Ce
 MgD3rIJGEG3lTuJQHKYZeH9hLMPPl0v1ThYNTbILfyVnrXR/7yfxChkY3GGfaXzSJJSj
 zS6SCqOoHnL6ddVu6Cf53nxSawhNK9hAzZ8nHC+aolg0mlg0rAASMKcQQEsXoFinIxif Yg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tejx650kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 10:10:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1696266624; bh=86FIRVk4STT00FUxCqbekGLPkogJkQ+V+RAuE7ImiRo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MyuqxTCMzyHeSlQ3uqToygOLQDAf11doEMAZFrmN7BJkb68Z626d1i0DPudSNGmK/
         OfC1i34f09BaCwvcwXcBJcxkzLpQkWqrbQv2NM9BQv2ku2D0sHxwfVtylagb0zE7gb
         KlMuCb1XwbPKZnjLYUU7zCPeI+SrreBJLqi1JoKERab0oWtvqTNXTnYO4EclxewNOt
         KKyo1uH8C1Fsez9O1ovuW2DA3dFe8iyLgqt7IagRy07ZoARtF8azMrqWjj+e1bA6eo
         Q1asjkbg9b/q4P6NYiQruzWQAKjDi4JEQpZfzdaRaFmCwNl2nxX6IJo3oHhifA+RGv
         qCJOGMa3eEaCg==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CD2F140493;
        Mon,  2 Oct 2023 17:10:22 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 48FF2A006D;
        Mon,  2 Oct 2023 17:10:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=gNKpTRLu;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9CC8B405BD;
        Mon,  2 Oct 2023 17:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaQir2ERL7YDqGQFnC4magc7nbbJG3+82NldgGK72U2/fs5vKqf173GiFXIsAFWQKPD9tCOb6AXwG8qryU6jOiEHnhb8YhFE6QmzeXgXzBdabaTLS/83x6eO2QSnalwJzlMPtttWt1OSMb6g4UGBKBxky2oKiEFeaijIokY5KQsfNJrInkg7ccEj8F8Zf1Lnltc93/PDdIFOrd+Vxi0spgu4ScxN0AZ8wgpa9INPIti4lyslSSmN2/YBXFqQP+/WzEooPSECZ92Hw/5Lx3scIUY6Oxy216FrteuGrg/261+dFrp4DXXukPZp1UjE4V8rb3eFIFxUq1BKR60xLvIyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86FIRVk4STT00FUxCqbekGLPkogJkQ+V+RAuE7ImiRo=;
 b=T7VVhFrSY97Ei9RIETMwYDVk77Ayvnr2oELxrdJHUY1/eHJobbUMZCDZSShVBMLt4mUF9tEivi69x+nkb9wOdy0X4rDVd8dm9nTr0SPY2hQQpe4b2Z39DwvCPfNlBAh8bfGbo9r8biPIc2VVgybaaqb47yowFhKR/UFfOw7UGvPBXv/Yy/ATMQOoxDNpWp2LB17al/9tU1lZ+396D30yJa7AayZjXhYSX8x2lpUZj7GaFj0sU8EuQJ8Wu7HFozt37GWz+hMtnzzcJlvsgtVr3iXkCVv9V+AJKTUsEav3sldIu+uVcGf3D0HJIgeAR87J7lvNL9c4b3fu9dCTe9ZdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86FIRVk4STT00FUxCqbekGLPkogJkQ+V+RAuE7ImiRo=;
 b=gNKpTRLuNHp0UJKmrQhAlTnmryMSWif6j3+89Vf1zwsVoIcXU/aYJf5kqQYkJn3q9nwggfrbgyxkL3tDI3TOFpfIelsfqXxVIkbLQRxIA1vwC9qOrtN19sg2vlEZwkzmTNmJ60sZoYjGPuk1y2djCSk8fUqpka4uc8uUHUdgHfk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Mon, 2 Oct
 2023 17:10:17 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 17:10:17 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v11 04/13] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v11 04/13] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHZ2bP2bpAKMvLmvE+X0xJ05nWWGrA28z0A
Date:   Mon, 2 Oct 2023 17:10:16 +0000
Message-ID: <20231002171020.7v4kba5rugd4xhh7@synopsys.com>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
 <20230828133033.11988-5-quic_kriskura@quicinc.com>
In-Reply-To: <20230828133033.11988-5-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB8089:EE_
x-ms-office365-filtering-correlation-id: d9e22883-15f8-4e5b-4727-08dbc36a7347
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bo61uPXj86cUy+DUlcWm+lOKzcMS64FOynslDXq170Ua1VNcH1fAVzVtEmeBlQGU+Y1SkrNID7WM0GG3qlY5xfg4j8/Ek4wH7opvXDc25BPmkCcF5Vxy0ESWcg3MB3FXfkNHVdsNun3Xe/5x6NpOpb37Gbz/m2oS3B262rE1vYUjkJWSPPAtKEspd/Q1KIc3Cll8x8DO9Y6U7enukhAF345o6W0mHo8x+glISNhfAf35xRX6uDEzAoIk+n8bs6dcVQt601KSfZ6HHl9xVPdx/BoKlTQDztQCum/79zi3r73dX6qphhWQxzIZJMz+SOpd3igZs8+OEYjH/yG+duOGpWDfWwCX3JPeLl1jujVDV9cYiul9NA3TYj6fzKjB4aKgFqjGF+iwzTnOYIjwFPjlwsmYRVo4pMHOvxITfmpHHSNdVXc0/p0PdijGYeJ0f3SKvQFqxFknhzSqmKHbgff4z59I9os0BYYs0Lu9we0idTKQrSG1O8BGvZrgs/0yprAat7AlIOBi3eE43kwJXCLFnSPHAOw7Nc4Z0yopvPq1VnRtQCbz1x+BRIjroPzaOaKsZJtctMbeFsKvEgUhwsPoDNQ+V3D9YyuF0aLY+wpztJLH2hu5fhvBt9oIF5UXTBx8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6506007)(6486002)(71200400001)(478600001)(122000001)(38070700005)(38100700002)(86362001)(2906002)(7416002)(83380400001)(6512007)(26005)(1076003)(2616005)(36756003)(5660300002)(64756008)(54906003)(66446008)(66476007)(66946007)(6916009)(41300700001)(76116006)(316002)(66556008)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVNWN3gvajlZUFNYZVZZRHdFdDkvN29TV0JIdlUrbjNLL2Y0ODE3TkRBRGgr?=
 =?utf-8?B?TWVnK3V6WWptZjAxZHFHUzJTVnFhcXRCR1hnZ2VDU1hnZzBXRSsvVlE0eVha?=
 =?utf-8?B?emg5b1pnN0hqZW90SlVjWGNUanpMOEdlcmhUek1qd0pKSzk1TmRpdTJjQ05s?=
 =?utf-8?B?NllsV0YvZW1aeXlYYlQxV3ZUcllxamhvSVpFeTJxaDZyQjY1ODVGZVhFVkQ1?=
 =?utf-8?B?RzhrNHFZUWZpQVIrblNHMXJ3Zi9HWXpYVjJyVjFtTVVVVFFaZHAxMjJDc2N4?=
 =?utf-8?B?VjVBVmZvcW9XYmtzdXJwekJWVWExdlNmZEFyMFRncCtKNzVDa1grU1lEUFdj?=
 =?utf-8?B?czRpd2h3NlR5Vld1RHBuZ094cDFXT2NJb1kwQWhwaFdrNElxS2F4aGlxS01W?=
 =?utf-8?B?SEJINHQvYTRzVlNVR0VlYXJKWFF1VGw5dW01KzVIeHhURnhRTkJKVEtkYlNS?=
 =?utf-8?B?ZGF1NndzS3RKeVZYTXBzelN4aDB0Y3FzSzVleFVXNE5aZmUvNC94dm5JallG?=
 =?utf-8?B?V2tSQ3JyUzNLcS95SVhoa3ZjN2NtQXBBc1BESWtYb2RURU42REUxTytqZFBQ?=
 =?utf-8?B?SGxkMjFyWnRzdHZCNmF3WnhlK2VGWmdic1NzNGZrM3hMd1VpVDhORk44YSt4?=
 =?utf-8?B?SUpzbm5yS1cxYkRZd1pKM3ozM3VTeW43Qk1pU2xnYk1HcmpIT3lvOHFPTVpW?=
 =?utf-8?B?aGd6T2kwOFFPMGNadTE0MGNVRzdHaTNrUm5NdzJNYkd2ZEhRNU9IRnpwQTc3?=
 =?utf-8?B?UlY3ckxCQjZydVdqUEF1MlIrSFpEOUtQdWtTaGNKNWd5d2dzS3FHdFJSanp2?=
 =?utf-8?B?K2NVdmMrakhRdzZ4QUNhU2RBUk1mTDloTWVhbzlkbG1URkVNRG9ZTFJVWmJ3?=
 =?utf-8?B?Kzhqc3lNRXNPWS9VejNIM21Sb290K0FCQ20wK3pjMm9DVFBtRWd2bXBXMDFv?=
 =?utf-8?B?S3ljRitQMXdXbHlNQ0FtZCtVQnZESDl1NlI1SUVsTHp1RnRURHBwWGhBVWRS?=
 =?utf-8?B?YWw3RVJlL1pVOWhqSHVRMXljY1ZoZVhVUTFlaHg2bnFlWGVpbWRrb2xEWnpz?=
 =?utf-8?B?anlUTlB6dS9KaXdHRjlQWmdlU202WnNPVjhETHNZOFEvc1BsREZPTHF5Yjl0?=
 =?utf-8?B?RW1yakc0QzljaUdHTEVNWjdXN1VKMXBwWUp5RzBpL0VJbkxjM1dUNjlINTY1?=
 =?utf-8?B?eFdWcnRpWlNXbVRrdmNMS0ViaHVyVElpRkFBWERucGlyTDdWREJrSmZaU2lp?=
 =?utf-8?B?L3dKTmljWE4wV3QrRFJUbXRSZXBnQ1pJRm9nL043cktYODRKN2JEYXJSSzBm?=
 =?utf-8?B?SHY3N0syLzNmMXNEaHVZa3JLb2dRUlAzdjBmTXhJUTFEbTRPWUtMWWM0dTJx?=
 =?utf-8?B?a0VZbEppSkQvcTRXK0JUa3Q2VGJMVnMyRTE3MHNxZmcxTFRXK2lkRjBKNU9x?=
 =?utf-8?B?QWJGanlFTVVDS3NXcGh2K3BteEpkVkxVdWl2R05Qb1Z5WHpBVHgrRE1zUmZW?=
 =?utf-8?B?ZFJwS3VWeVdQWXJHWEticnJNUmFsd1RLRHA0WndXdjhuQTY3SmpoT0dZeFg4?=
 =?utf-8?B?ZnB1QlNKc0dKTlA3V09Qb0JiRnFkNzBYM1FzbGVONWFjei91UG9uTThpOGdZ?=
 =?utf-8?B?WXRiTlhCOFdWY1hld2d1QXV5MTBTMnBKMll2UmVhRTBrVkQvUHg3b1pGNytG?=
 =?utf-8?B?a01hbmMwQlE2UWY2aW5UeDBZNjlyZzZMVzNZWXJmOUg1cEs2R2djOVFaWktM?=
 =?utf-8?B?VlFwV1RqQzJ3bkFibjU4azhUeGR3TXdLWWsvV2JmaUsxejA0VXlxYTZrVXJB?=
 =?utf-8?B?Ulh5UTRCNG1XTmF1dzBvYWlRZ0hEOXNlOU9jU2RjUG1VbjJxT1lheFlyRllN?=
 =?utf-8?B?Wkg2SGZKdmxlcDBBQU4vTjVyd010R2NaTjhjOWgzMDlqbUduQk9RVy9oMnRx?=
 =?utf-8?B?b1dvSE80anJ0cTJUUHRTMVRZWFpEbFVBV2wrVzY4bTJQWUNnSTRXL1MwbUJB?=
 =?utf-8?B?Yjl0eWpYYnFkK0RUOG9jYWpwSVpQeThUWHd3TTdCOFJTRW9OU01NL1MrSkpx?=
 =?utf-8?B?S1dDSlFudTJIZWkwSWtsQ2ZBMy8xZkhXWGY2aDdQTVBRSkR5UWthdEJkQmdX?=
 =?utf-8?Q?cW9sq8kIHEy4wFbbmURe0epKT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC5E8D7FAB6ABC4F8EA17CAB8D122151@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dmt0dVI0eERPMU4xYTBoU0tnQ1NWd3YxYzFxZ0h0eVVZaDFLZjREY3M3RzVX?=
 =?utf-8?B?bHpUSEpONkJtTWJ0alBQekZMU0FxR0Y1ZFVFVnc2aWltMllOdm52OGFCUko3?=
 =?utf-8?B?ZHo4eUQyR2hJbTM0ZnZWT1hKSjR4akZjNGczeFczRGljK3ZUK0EraFNDWmQv?=
 =?utf-8?B?OC9uMzRqWGpKcEprYkhxNnRFRjltMXBxL2RxaVl0c0o5K1M0U2tWR1RJdGVI?=
 =?utf-8?B?Nzh1TlRxNDJ0ZXY4QlYrUU1EeC90S04rcTdvUkxmZHQxWkpObkU4YTZDZ3FC?=
 =?utf-8?B?T01HQ0pxdENpMWtmanZEODFabXgwWU9YL1psRmZZQlJtZFE5eFBBMi9SWng1?=
 =?utf-8?B?N0tEbGl5U21qNDFZNVVjN2ZUWFg2WDUySUVvMHE1YUZxdFZaMlVnVWpqRlBz?=
 =?utf-8?B?VndWUDFiMDdaMVI2WG5lVU5kV1VLZ3dLMzY5Um5McW1CeHFFWmJNL3FNVG9F?=
 =?utf-8?B?eFBmK0dTQzN5Mi9vZUtxTGcrd1dwTk9HVTNKQUc1UU9GOE9lQkJpZWhCaXlX?=
 =?utf-8?B?cGZPSFpFQW1QWVY0VXQ4MmsvRlRtVVhYNUduTWw0ZTBqRnowK1B6aFU5UmNk?=
 =?utf-8?B?N0dVa1VFWmNxZytCMEc5SHAxUjRrTHNpaGRRUUpJVmc1Vmp6cWZjREJPWjdY?=
 =?utf-8?B?bXBPenFaQWdwWnd5K2tzZ2FPTUE0R3p1MEFDR1hLcHA1WDgrOFBndDVyamJP?=
 =?utf-8?B?eTdCOXR5cVlpWlh2NGNTZ3pIQkhSYjlidlc2R0pMeWtwNVUxQ1JsY0JqSkpu?=
 =?utf-8?B?WXEwcmJsQVc1N2RyNnl3TzVNRVZIQk9zY1pkNi9Zc0NxWXJ0Q3N4Vjd2TVRL?=
 =?utf-8?B?MXFYU1lrdzVFK01BVEx4NXRXaWwrQ1plcEprMzlqVGpmWWkzRWJsQkRKd3Iy?=
 =?utf-8?B?UDVKV2JWQTVwMmJnTURrZ2lVei9LV1pIOG1MbStBTDZFcytIVjBqcHVPc1Vq?=
 =?utf-8?B?QWhRTlRzNCtuY2RwTWJFUm91Z3pqektVOXVjQ3JCYlZjYmtndm11VGhia0pq?=
 =?utf-8?B?MkhuRDdic29CYTdRSHpqVTVockI2d2h4VUx6ZHJUQnExQjNScWRsZ2hxN2R5?=
 =?utf-8?B?OWl0MFpRc3UySHpKRjhpMlcrQkg5T2JWS1RNbEFDT1ltUEREZ3I5M3dacEFp?=
 =?utf-8?B?d24yNmJiRldmNGQ4bmgwK3o0N1hvYjNFV21Ya3FJUVRzOTNZQnMxbjZUbktw?=
 =?utf-8?B?bXJYaXJ4NDY0UFBzVThjcTU4U1FxUEJMTDJjb2xic1FuMStiWWVhRVBNNEhQ?=
 =?utf-8?B?bmJ1SlViaExZd0RnNmZlWUQ2RVo2Nmc1VFpWRkVWeHZQTmVESkwyWXhia1Zu?=
 =?utf-8?B?WmxRSHkwalQ1RjlXR1Myb2M0M0hEdy9PUXN1UG00eHNEdThMZm1TMFhxRzJE?=
 =?utf-8?Q?2keJoxhrn4IEMYRN/Agc/lwwaCS+DolA=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e22883-15f8-4e5b-4727-08dbc36a7347
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 17:10:17.0992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAY4ZmtP4iysZodWVB3PG09GZ7myH993TAWhBD6cYOU2Cv9frb0FfL9GhJP6CSyx9Dxn2UrQWnQ675/MxvrE2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
X-Proofpoint-GUID: Q11nPasY9OkvcyDN6IEWruxrXxAW5L63
X-Proofpoint-ORIG-GUID: Q11nPasY9OkvcyDN6IEWruxrXxAW5L63
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 adultscore=0 impostorscore=0 clxscore=1011 mlxlogscore=999
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310020133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIHRoZSBkZWxheSwNCg0KT24gTW9uLCBBdWcgMjgsIDIwMjMsIEtyaXNobmEgS3Vy
YXBhdGkgd3JvdGU6DQo+IEN1cnJlbnRseSBob3N0LW9ubHkgY2FwYWJsZSBEV0MzIGNvbnRyb2xs
ZXJzIHN1cHBvcnQgTXVsdGlwb3J0Lg0KPiBUZW1wb3JhcmlseSBtYXAgWEhDSSBhZGRyZXNzIHNw
YWNlIGZvciBob3N0LW9ubHkgY29udHJvbGxlcnMgYW5kIHBhcnNlDQo+IFhIQ0kgRXh0ZW5kZWQg
Q2FwYWJpbGl0aWVzIHJlZ2lzdGVycyB0byByZWFkIG51bWJlciBvZiB1c2IyIHBvcnRzIGFuZA0K
PiB1c2IzIHBvcnRzIHByZXNlbnQgb24gbXVsdGlwb3J0IGNvbnRyb2xsZXIuIEVhY2ggVVNCIFBv
cnQgaXMgYXQgbGVhc3QgSFMNCj4gY2FwYWJsZS4NCj4gDQo+IFRoZSBwb3J0IGluZm8gZm9yIHVz
YjIgYW5kIHVzYjMgcGh5IGFyZSBpZGVudGlmaWVkIGFzIG51bV91c2IyX3BvcnRzDQo+IGFuZCBu
dW1fdXNiM19wb3J0cy4gVGhlIGludGVudGlvbiBpcyBhcyBmb2xsb3dzOg0KPiANCj4gV2hlcmV2
ZXIgd2UgbmVlZCB0byBwZXJmb3JtIHBoeSBvcGVyYXRpb25zIGxpa2U6DQo+IA0KPiBMT09QX09W
RVJfTlVNQkVSX09GX0FWQUlMQUJMRV9QT1JUUygpDQo+IHsNCj4gCXBoeV9zZXRfbW9kZShkd2Mt
PnVzYjJfZ2VuZXJpY19waHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gCXBoeV9zZXRfbW9k
ZShkd2MtPnVzYjNfZ2VuZXJpY19waHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gfQ0KPiAN
Cj4gSWYgbnVtYmVyIG9mIHVzYjIgcG9ydHMgaXMgMywgbG9vcCBjYW4gZ28gZnJvbSBpbmRleCAw
LTIgZm9yDQo+IHVzYjJfZ2VuZXJpY19waHkuIElmIG51bWJlciBvZiB1c2IzLXBvcnRzIGlzIDIs
IHdlIGRvbid0IGtub3cgZm9yIHN1cmUsDQo+IGlmIHRoZSBmaXJzdCAyIHBvcnRzIGFyZSBTUyBj
YXBhYmxlIG9yIHNvbWUgb3RoZXIgcG9ydHMgbGlrZSAoMiBhbmQgMykNCj4gYXJlIFNTIGNhcGFi
bGUuIFNvIGluc3RlYWQsIG51bV91c2IyX3BvcnRzIGlzIHVzZWQgdG8gbG9vcCBhcm91bmQgYWxs
DQo+IHBoeSdzIChib3RoIGhzIGFuZCBzcykgZm9yIHBlcmZvcm1pbmcgcGh5IG9wZXJhdGlvbnMu
IElmIGFueQ0KPiB1c2IzX2dlbmVyaWNfcGh5IHR1cm5zIG91dCB0byBiZSBOVUxMLCBwaHkgb3Bl
cmF0aW9uIGp1c3QgYmFpbHMgb3V0Lg0KPiANCj4gbnVtX3VzYjNfcG9ydHMgaXMgdXNlZCB0byBt
b2RpZnkgR1VTQjNQSVBFQ1RMIHJlZ2lzdGVycyB3aGlsZSBzZXR0aW5nIHVwDQo+IHBoeSdzIGFz
IHdlIG5lZWQgdG8ga25vdyBob3cgbWFueSBTUyBjYXBhYmxlIHBvcnRzIGFyZSB0aGVyZSBmb3Ig
dGhpcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1
cmFAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA2MSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmggfCAgNSArKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDY2IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDljNmJmMDU0ZjE1ZC4uODVjZWJlYjZkNjYyIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYw0KPiBAQCAtMzksNiArMzksNyBAQA0KPiAgI2luY2x1ZGUgImlvLmgiDQo+ICAN
Cj4gICNpbmNsdWRlICJkZWJ1Zy5oIg0KPiArI2luY2x1ZGUgIi4uL2hvc3QveGhjaS1leHQtY2Fw
cy5oIg0KPiAgDQo+ICAjZGVmaW5lIERXQzNfREVGQVVMVF9BVVRPU1VTUEVORF9ERUxBWQk1MDAw
IC8qIG1zICovDQo+ICANCj4gQEAgLTE3NTEsNiArMTc1Miw1MSBAQCBzdGF0aWMgaW50IGR3YzNf
Z2V0X2Nsb2NrcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+
ICtzdGF0aWMgaW50IGR3YzNfcmVhZF9wb3J0X2luZm8oc3RydWN0IGR3YzMgKmR3YykNCj4gK3sN
Cj4gKwl2b2lkIF9faW9tZW0gKmJhc2U7DQo+ICsJdTggbWFqb3JfcmV2aXNpb247DQo+ICsJdTMy
IG9mZnNldCA9IDA7DQo+ICsJdTMyIHZhbDsNCj4gKw0KPiArCS8qDQo+ICsJICogUmVtYXAgeEhD
SSBhZGRyZXNzIHNwYWNlIHRvIGFjY2VzcyBYSENJIGV4dCBjYXAgcmVncywNCj4gKwkgKiBzaW5j
ZSBpdCBpcyBuZWVkZWQgdG8gZ2V0IHBvcnQgaW5mby4NCj4gKwkgKi8NCj4gKwliYXNlID0gaW9y
ZW1hcChkd2MtPnhoY2lfcmVzb3VyY2VzWzBdLnN0YXJ0LA0KPiArCQkJCXJlc291cmNlX3NpemUo
JmR3Yy0+eGhjaV9yZXNvdXJjZXNbMF0pKTsNCj4gKwlpZiAoSVNfRVJSKGJhc2UpKQ0KPiArCQly
ZXR1cm4gUFRSX0VSUihiYXNlKTsNCj4gKw0KPiArCWRvIHsNCj4gKwkJb2Zmc2V0ID0geGhjaV9m
aW5kX25leHRfZXh0X2NhcChiYXNlLCBvZmZzZXQsDQo+ICsJCQkJWEhDSV9FWFRfQ0FQU19QUk9U
T0NPTCk7DQo+ICsJCWlmICghb2Zmc2V0KQ0KPiArCQkJYnJlYWs7DQo+ICsNCj4gKwkJdmFsID0g
cmVhZGwoYmFzZSArIG9mZnNldCk7DQo+ICsJCW1ham9yX3JldmlzaW9uID0gWEhDSV9FWFRfUE9S
VF9NQUpPUih2YWwpOw0KPiArDQo+ICsJCXZhbCA9IHJlYWRsKGJhc2UgKyBvZmZzZXQgKyAweDA4
KTsNCj4gKwkJaWYgKG1ham9yX3JldmlzaW9uID09IDB4MDMpIHsNCj4gKwkJCWR3Yy0+bnVtX3Vz
YjNfcG9ydHMgKz0gWEhDSV9FWFRfUE9SVF9DT1VOVCh2YWwpOw0KPiArCQl9IGVsc2UgaWYgKG1h
am9yX3JldmlzaW9uIDw9IDB4MDIpIHsNCj4gKwkJCWR3Yy0+bnVtX3VzYjJfcG9ydHMgKz0gWEhD
SV9FWFRfUE9SVF9DT1VOVCh2YWwpOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJZGV2X2Vycihkd2Mt
PmRldiwNCj4gKwkJCQkiVW5yZWNvZ25pemVkIHBvcnQgbWFqb3IgcmV2aXNpb24gJWRcbiIsDQo+
ICsJCQkJCQkJbWFqb3JfcmV2aXNpb24pOw0KPiArCQl9DQo+ICsJfSB3aGlsZSAoMSk7DQo+ICsN
Cj4gKwlkZXZfZGJnKGR3Yy0+ZGV2LCAiaHMtcG9ydHM6ICV1IHNzLXBvcnRzOiAldVxuIiwNCj4g
KwkJCWR3Yy0+bnVtX3VzYjJfcG9ydHMsIGR3Yy0+bnVtX3VzYjNfcG9ydHMpOw0KPiArDQo+ICsJ
aW91bm1hcChiYXNlKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMg
aW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gIAlz
dHJ1Y3QgZGV2aWNlCQkqZGV2ID0gJnBkZXYtPmRldjsNCj4gQEAgLTE3NTgsNiArMTgwNCw3IEBA
IHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
CXZvaWQgX19pb21lbQkJKnJlZ3M7DQo+ICAJc3RydWN0IGR3YzMJCSpkd2M7DQo+ICAJaW50CQkJ
cmV0Ow0KPiArCXVuc2lnbmVkIGludAkJaHdfbW9kZTsNCj4gIA0KPiAgCWR3YyA9IGRldm1fa3ph
bGxvYyhkZXYsIHNpemVvZigqZHdjKSwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFkd2MpDQo+IEBA
IC0xODM4LDYgKzE4ODUsMjAgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICAJCQlnb3RvIGVycl9kaXNhYmxlX2Nsa3M7DQo+ICAJfQ0KPiAg
DQo+ICsJLyoNCj4gKwkgKiBDdXJyZW50bHkgb25seSBEV0MzIGNvbnRyb2xsZXJzIHRoYXQgYXJl
IGhvc3Qtb25seSBjYXBhYmxlDQo+ICsJICogc3VwcG9ydCBNdWx0aXBvcnQuDQo+ICsJICovDQo+
ICsJaHdfbW9kZSA9IERXQzNfR0hXUEFSQU1TMF9NT0RFKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMw
KTsNCj4gKwlpZiAoaHdfbW9kZSA9PSBEV0MzX0dIV1BBUkFNUzBfTU9ERV9IT1NUKSB7DQo+ICsJ
CXJldCA9IGR3YzNfcmVhZF9wb3J0X2luZm8oZHdjKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCWdv
dG8gZXJyX2Rpc2FibGVfY2xrczsNCj4gKwl9IGVsc2Ugew0KPiArCQlkd2MtPm51bV91c2IyX3Bv
cnRzID0gMTsNCj4gKwkJZHdjLT5udW1fdXNiM19wb3J0cyA9IDE7DQo+ICsJfQ0KPiArDQo+ICAJ
c3Bpbl9sb2NrX2luaXQoJmR3Yy0+bG9jayk7DQo+ICAJbXV0ZXhfaW5pdCgmZHdjLT5tdXRleCk7
DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggYTY5YWM2N2Q4OWZlLi41YjBmMmFhMTE1ZDIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5oDQo+IEBAIC0xMDI2LDYgKzEwMjYsOCBAQCBzdHJ1Y3QgZHdjM19zY3JhdGNocGFk
X2FycmF5IHsNCj4gICAqIEB1c2IzX3BoeTogcG9pbnRlciB0byBVU0IzIFBIWQ0KPiAgICogQHVz
YjJfZ2VuZXJpY19waHk6IHBvaW50ZXIgdG8gVVNCMiBQSFkNCj4gICAqIEB1c2IzX2dlbmVyaWNf
cGh5OiBwb2ludGVyIHRvIFVTQjMgUEhZDQo+ICsgKiBAbnVtX3VzYjJfcG9ydHM6IG51bWJlciBv
ZiBVU0IyIHBvcnRzDQo+ICsgKiBAbnVtX3VzYjNfcG9ydHM6IG51bWJlciBvZiBVU0IzIHBvcnRz
DQo+ICAgKiBAcGh5c19yZWFkeTogZmxhZyB0byBpbmRpY2F0ZSB0aGF0IFBIWXMgYXJlIHJlYWR5
DQo+ICAgKiBAdWxwaTogcG9pbnRlciB0byB1bHBpIGludGVyZmFjZQ0KPiAgICogQHVscGlfcmVh
ZHk6IGZsYWcgdG8gaW5kaWNhdGUgdGhhdCBVTFBJIGlzIGluaXRpYWxpemVkDQo+IEBAIC0xMTY1
LDYgKzExNjcsOSBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICAJc3RydWN0IHBoeQkJKnVzYjJfZ2VuZXJp
Y19waHk7DQo+ICAJc3RydWN0IHBoeQkJKnVzYjNfZ2VuZXJpY19waHk7DQo+ICANCj4gKwl1OAkJ
CW51bV91c2IyX3BvcnRzOw0KPiArCXU4CQkJbnVtX3VzYjNfcG9ydHM7DQo+ICsNCj4gIAlib29s
CQkJcGh5c19yZWFkeTsNCj4gIA0KPiAgCXN0cnVjdCB1bHBpCQkqdWxwaTsNCj4gLS0gDQo+IDIu
NDAuMA0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lz
LmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=
