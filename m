Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7475D7B5731
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjJBQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbjJBQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:03:04 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7538E;
        Mon,  2 Oct 2023 09:03:01 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 392EQIiE018171;
        Mon, 2 Oct 2023 12:02:53 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3tf173ppb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 12:02:52 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEjWTigVjIOsG9IHJOIqhHdcnZUZeq4mEJbI1MrFntJi9PvUfKf68QpFRY4M/ewHxXFYSH0tZS1ca1BVJhiicFqb88/JhdutRconNB4ak9rExslSADBSBCUuVqjLIa7tEJxLtvuQVuuJgAlvYHIaK8Sp8XSeXnkinW+WZpVgCqMsCAmSKaAM8yh100tXPC34C2LqSa3Q/QX2iTCc42goA/U9+UH9oYe7JChzKchQzdie+rrAk9FE5KQDuFuhuxD+nZ0aextR86UVjhJT5dOClkvR85SGW90HBiVzo/im570xQLVvCdMDK/0cfQUPOF6NarNqCM7JJBT5KwaRduI4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bWUSdnVwN8X1SteuJc+aJghIfe+WcGFn/jcJqc+aTk=;
 b=RZ3DqlbK0iW3uev1pqp5brmtnaQuKvq08a26c/5FbJIPIegyggDpHVp/WqIgpXlx+H7dffLwWhb6oRogCf1FOmYmpE7CDX8P3rUGCT82JUHDmH4wyaKA/7Ov2UJ0O+oqcvxb9yhKEHGYQQrrtNyTT46Lr0e9CfRWc5XYmELcGfnQQwRQnJeXNqIUGUdbKmTse+ERyQRO3PdskWRPeA5eELHpmyDK5G3v14gzv8NUuwdcb5k3Lz8qZL3X0PNQSRkh/V74+OgEq2xGxKywSSrpH7flu+YONUAcikPEvwja5w1SKWqUH2u7XnAnR//6yy481elnZN2i/3zdFYVrMCPBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bWUSdnVwN8X1SteuJc+aJghIfe+WcGFn/jcJqc+aTk=;
 b=t7U5cQQFRkLZeOjnnlVFYw+nyAaAucSEXyODhjfOkEv/BUe6k+MqGKFsqLw5/+zaos9HzzrFkb4ZGXYaVUvx+jH8bYEe2aAnCvImFYvSJTUxb0Qqiq2BDrjK6ajRp3q9noYHF81V64XRaci7rmihYIVwSVsQ2fhjIK4kQHau/Vc=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by PH0PR03MB6771.namprd03.prod.outlook.com (2603:10b6:510:122::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Mon, 2 Oct
 2023 16:02:49 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e1d5:636a:bda7:1c81]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e1d5:636a:bda7:1c81%2]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 16:02:49 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
        "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Subject: RE: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Topic: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Index: AQHZ8e7G+nmLWHb/Z0ShhzBMq3cwPrAwA0wAgAAEH8CAAEJXAIAAJfWAgAYr8uA=
Date:   Mon, 2 Oct 2023 16:02:49 +0000
Message-ID: <BN7PR03MB45450F9E3E1D5A032C4A346B97C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20230928092804.22612-1-eliza.balas@analog.com>
         <20230928092804.22612-3-eliza.balas@analog.com>
         <839638d2-7502-4925-8b7f-6b15779a6840@app.fastmail.com>
         <BN7PR03MB4545DC903A0D62639085591697C1A@BN7PR03MB4545.namprd03.prod.outlook.com>
         <94110af1-2b32-4eb2-81be-2a79fc6973d8@app.fastmail.com>
 <5043c6729e1ffd2dac84b6908b26db11347521b0.camel@gmail.com>
In-Reply-To: <5043c6729e1ffd2dac84b6908b26db11347521b0.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWldKaGJHRnpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RNakExTm1FMU1ERXROakV6WkMweE1XVmxMVGhrWWpJdE56UXdOR1l4?=
 =?utf-8?B?TlRjd05XWTNYR0Z0WlMxMFpYTjBYREl3TlRaaE5UQXlMVFl4TTJRdE1URmxa?=
 =?utf-8?B?UzA0WkdJeUxUYzBNRFJtTVRVM01EVm1OMkp2WkhrdWRIaDBJaUJ6ZWowaU1U?=
 =?utf-8?B?TTFORFFpSUhROUlqRXpNelF3TnpNMk1UWTJPVGsxTXpJd05pSWdhRDBpTlRr?=
 =?utf-8?B?d0wwdE1iamh1YzNWa1JTOTRWVzVLTkVneVZWQldRMHhKUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlJXOURRVUZETW1SelRHbFRabGhhUVZobWVXSTBXRkJ5WW1Gc1pD?=
 =?utf-8?B?OUtkbWhqSzNSMGNWVkVRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUkdGQlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGc1IxUkhWbWRCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKb1FVZFJRV0ZSUW1aQlNFMUJXbEZDYWtGSVZVRmpaMEpzUVVZNFFX?=
 =?utf-8?B?TkJRbmxCUnpoQllXZENiRUZIVFVGa1FVSjZRVVk0UVZwblFtaEJSM2RCWTNk?=
 =?utf-8?B?Q2JFRkdPRUZhWjBKMlFVaE5RV0ZSUWpCQlIydEJaR2RDYkVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhSVUZhUVVKd1FVWTRRV04zUW14QlIwMUJaRkZD?=
 =?utf-8?B?ZVVGSFZVRllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZJVFVGWWQwSXdR?=
 =?utf-8?B?VWRyUVZwUlFubEJSRVZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV1ZGQ2EwRkhhMEZZZDBKNlFV?=
 =?utf-8?B?ZFZRVmwzUWpGQlNFbEJXbEZDWmtGSVFVRmpaMEoyUVVkdlFWcFJRbXBCU0ZG?=
 =?utf-8?B?QlkzZENaa0ZJVVVGaFVVSnNRVWhKUVUxblFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUU5UFNJdlBqd3ZiV1Yw?=
 =?utf-8?Q?YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|PH0PR03MB6771:EE_
x-ms-office365-filtering-correlation-id: 0173b573-5ac0-44a5-7029-08dbc36106c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/9BgEQMslLarlDfJ3sPjhjYbtkZR0GhcfD6lGFr5wVU7SadvGekQX9mk9hvltz+eaN2gA5K1fMJKEZyWKxJI3ku8HMFsvvm1wByh/aXfsyMmo++1vfNIUqBDZ8UCczWkf/Ca9kTAd0UuXo7XGHFNNbItyqHRkIrMJiszv3bFHbRNbnLHQufuB/zUXmK8k+ZckgijjraVbBk8ljSheIcRQ1jrjyBaXC1lWr5joCG9L0HeZBmGTY2/o8HT/jzJX8il6twfbsSBSz475xHPv8HRCwkffUTEzIMNU07u4hDFzSK9J7/G6zVFc8fTKX+7tl6sMGkIQzUz8eOQrvdX078bIUaJ2eEZnVr6O0IZEbHI3qJF5us5hHtDGe9PbqBL3rX/7qI8XR2reTdBU1QoKc2tmmE4cQqJdZ8UWjLvUu9QPovNC2KcO0iU9eVphFGu6OPkd1Hh+F51anduM6PzoreZQ6dFHkBRvdTcVLPSNz7CoP/kUdFhABjbPzVLgL0VKL0/chB5cuC5jd5nQRAxpRLO6m5jUhuWaIVknUq24Iop5yBpzNLacaGqkKDnO7dEPO0DcDUoksjgk80urCfQoTPEeIOoaa/v/VjJXrPdZGGCBA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(54906003)(41300700001)(8936002)(6916009)(64756008)(316002)(26005)(53546011)(71200400001)(9686003)(122000001)(38070700005)(83380400001)(7696005)(86362001)(478600001)(6506007)(38100700002)(66476007)(66946007)(66556008)(66446008)(33656002)(966005)(55016003)(76116006)(7416002)(2906002)(5660300002)(4326008)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0ZDd2toODlicTEreXpPc0Rwcm4vbU9XcnlFS0trVENGQUkxKzRVSi9WdmhB?=
 =?utf-8?B?Y0Jxd09IalV1UUZYbEplVFFDYS8wWVdqbTZ5cEtUTWVuOUdNVjIxSzBVVUw3?=
 =?utf-8?B?U25hWkh3bUE4LzhjcFF2a3psUEdscW5HYkVaZnpQbllRQVdXaFRjbko5bXFO?=
 =?utf-8?B?aDdzSzlacnFGMlVKdmRpNFp3aW02a0YyanNIcVozcVpTTk1EeW1vUEVHTSts?=
 =?utf-8?B?QlNxWEEvbWZ0akludG1QbERTRDJNdDlLVnRGamV0cDZid2EzTmpyek1sSWVC?=
 =?utf-8?B?WmQwaEp2cVpjU0JqalRreGJEeXpLRU9haWN1WFZQK291eW5XR3RsVXpia2ly?=
 =?utf-8?B?bFdnbm5mcFk2ZjM2Z1MvRXFkM1FSRGJvZk5KeHdueTYzRjdYQ3diNUphd2Zq?=
 =?utf-8?B?ajN1QWhOcUhuNXBIclFpS3lFZWVQeStFUWRwNGNSQVZ1eXhjZVVHL01iYStJ?=
 =?utf-8?B?MndENVgyM0VYQWRzNGhkd3E4YkROSGVWQkxobTlQREtkWHlVa1dtV0lYMFdO?=
 =?utf-8?B?b0dWSzh3NDRIRFRnQ3lCRFRPVzhUUTFrUkJDb1lKc0FrSGpQQlpFcGovUWxZ?=
 =?utf-8?B?OWd1LzlBYW5od2Z3YjhkcXhyYTVHQ2liSXU4dUhPdzFGYXVrRFhTcmh0RzBZ?=
 =?utf-8?B?NDBpL1Y5MVJPQlYzc0R4MGRQOTAxM0FnSTRYeGFaaUxGZkRUQzEzS2lhdGVw?=
 =?utf-8?B?TWZtMnBtbXY2TC9pTGpDRDhrcGZrWHUwZmw0MXhubCtzK0ZRNmZ0Mlc3Vytu?=
 =?utf-8?B?dWxCUDN1WGZDN1pOYmliQktJcy9tVzFvQmFVR1FGeHliaWpqQk9SdnBtaGFC?=
 =?utf-8?B?WDVPQTFlWjhnNjVNbDdMNXJPcEdZb3g3M1hWaTJxSEkydmxPN0MyZ0FOY3lT?=
 =?utf-8?B?TWtnMWJBT253R2xTVkprd1hVd0hBRHlIcEpCSE1wWmJHM1M4R2tWODBaRWZr?=
 =?utf-8?B?N3RrRUxRMFN1M3poZHovWURGL3o5RW90S05pY1gzcVdLeE5zSmlETThjK3ds?=
 =?utf-8?B?YW53d2U4V2lpMit4WFVUVFlRaG15NFp5VXRtMXRUcHRHcUt6NnZ0OVhtSmhX?=
 =?utf-8?B?ajFaWUdBYTB0TWlHUU5tdDdWaitCRTNNY2RBdEd1cE83dGVreTd2WkZTSjE5?=
 =?utf-8?B?aVBacHlPY1RSQllVMTFoUWVsREVtZFJxeTlHUmwwQVdHcTZrUzdmWmFRNjd0?=
 =?utf-8?B?cEYrcm9pVVZZcGZ4emFwMXIxVUVUK0xyZUVVYUZlVlBZVFJZWENqTjZYNGlI?=
 =?utf-8?B?UFl0SEpualhNYWFMNGdFQjA4clF1REEvYWJoWkdqeXlDb0hTeitDWDJMWlNs?=
 =?utf-8?B?Y2NhbFdYR0VJNExxdWNDUkhrQ1VQZHpqMFRvYmNNRmgyeFhrQjFWSjJoNUc1?=
 =?utf-8?B?WWVKdUR4RzVzTzBGN2pXQnhXWXFINmltMkdpa0dmWis3TkZiM2FXais3bmJV?=
 =?utf-8?B?eVZ2dCtzOE5kM1VCOGNCZFVRNFZFMS9pend6eC9rMy9BN1huMXE5cUNtUkUw?=
 =?utf-8?B?UTAzbDFtVFdhQ05NYWdzbTBMMWU5eVBud1M5Uzc1cHFTcXJPMFY1WS9WcXZS?=
 =?utf-8?B?Rks2L1FLRnpsYmlhY2JSYzFvRFRjR2ROdmVMWW9xdU5SVkcxdFZQZFZVbUVM?=
 =?utf-8?B?ZUVHZEo2c3JDbUN6cjU1MVZPZitZRldGMFdHak03a2FGTXlqNWJoU1ZsREpN?=
 =?utf-8?B?YTk2K3VGM3d1YnJPMFRHRWNGbTdnTjFXTVJvMDRCY1RRQUNOUUo1UXR4SVh2?=
 =?utf-8?B?b0Zvcis4YTQrU2NTVHJZeUxoRU5td0RQVEl6bEN2YVVZUUpVSGZ1RnlBQXJ4?=
 =?utf-8?B?cFFiKy80YUlrWGlES2ZiN2lWczNieTZOcG83bTFkUWZHbHhaYklNOUNoZVZz?=
 =?utf-8?B?ZFptRTI5L3N2SVVwNGwveTJKOEgvcnd1emc3bDdYUzBTTFdyS2ptTnI1eFcy?=
 =?utf-8?B?NDRHWjlpQi9xSG1mVnB2Mm5KNHdLaDAxbG1hVm45OHRDYXJRMGd4bFFVNm1W?=
 =?utf-8?B?azUxMGwxQ1dJWHN3aGd4ditjeW40K3d1Vnljc3hpSmtRd2tuanNSUDUybFhZ?=
 =?utf-8?B?TnpLbXlCNldBTmRFaU0rM0dVU3VCdXh3Qkk1eTR4aXhPTTNQM08xT0Q0ME11?=
 =?utf-8?Q?d4IILXb2NgCXgEmoFwa2PDBoS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0173b573-5ac0-44a5-7029-08dbc36106c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 16:02:49.5173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: noFXmjgiTErmwpke5F/5TDsv233Kxfmwd+b4/C4PhHyeSyDfXxaUSLRIpmtrYifGTiZM1XuczrdolAWgWf7qRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6771
X-Proofpoint-GUID: elo6O_7tYuGCtvqH52H7zR6fGOVpsG-D
X-Proofpoint-ORIG-GUID: elo6O_7tYuGCtvqH52H7zR6fGOVpsG-D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1011 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310020123
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOdW5vIFPDoSA8bm9uYW1lLm51
bm9AZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDI4LCAyMDIzIDE5OjM1
DQo+IFRvOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgQmFsYXMsIEVsaXphIDxFbGl6
YS5CYWxhc0BhbmFsb2cuY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9y
Zz47IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9y
Zz47IENvbm9yIERvb2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9yZz47IGRlcmVrLmtpZXJuYW5A
YW1kLmNvbTsgZHJhZ2FuLmN2ZXRpY0BhbWQuY29tOyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzJd
IGRyaXZlcnM6IG1pc2M6IGFkaS1heGktdGRkOiBBZGQgVEREIGVuZ2luZQ0KPiANCj4gW0V4dGVy
bmFsXQ0KPiANCj4gT24gVGh1LCAyMDIzLTA5LTI4IGF0IDEwOjE5IC0wNDAwLCBBcm5kIEJlcmdt
YW5uIHdyb3RlOg0KPiA+IE9uIFRodSwgU2VwIDI4LCAyMDIzLCBhdCAwNjo1NCwgQmFsYXMsIEVs
aXphIHdyb3RlOg0KPiA+ID4gPiA8Y29ub3IrZHRAa2VybmVsLm9yZz47IGRlcmVrLmtpZXJuYW5A
YW1kLmNvbTsgZHJhZ2FuLmN2ZXRpY0BhbWQuY29tOyBHcmVnDQo+ID4gPiA+IEtyb2FoLUhhcnRt
YW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4gPiA+ID4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiAyLzJdIGRyaXZlcnM6IG1pc2M6IGFkaS1heGktdGRkOiBBZGQgVERE
IGVuZ2luZQ0KPiA+ID4gPg0KPiA+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPiA+DQo+ID4gPiA+IE9u
IFRodSwgU2VwIDI4LCAyMDIzLCBhdCAxMToyOCwgRWxpemEgQmFsYXMgd3JvdGU6DQo+ID4gPiA+
ID4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIHRoZSBkcml2ZXIgZm9yIHRoZSBuZXcgQURJIFRERCBl
bmdpbmUgSERMLg0KPiA+ID4gPiA+IFRoZSBnZW5lcmljIFRERCBjb250cm9sbGVyIGlzIGluIGVz
c2VuY2UgYSB3YXZlZm9ybSBnZW5lcmF0b3INCj4gPiA+ID4gPiBjYXBhYmxlIG9mIGFkZHJlc3Np
bmcgUkYgYXBwbGljYXRpb25zIHdoaWNoIHJlcXVpcmUgVGltZSBEaXZpc2lvbg0KPiA+ID4gPiA+
IER1cGxleGluZywgYXMgd2VsbCBhcyBjb250cm9sbGluZyBvdGhlciBtb2R1bGVzIG9mIGdlbmVy
YWwNCj4gPiA+ID4gPiBhcHBsaWNhdGlvbnMgdGhyb3VnaCBpdHMgZGVkaWNhdGVkIDMyIGNoYW5u
ZWwgb3V0cHV0cy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSByZWFzb24gb2YgY3JlYXRpbmcg
dGhlIGdlbmVyaWMgVEREIGNvbnRyb2xsZXIgd2FzIHRvIHJlZHVjZQ0KPiA+ID4gPiA+IHRoZSBu
YW1pbmcgY29uZnVzaW9uIGFyb3VuZCB0aGUgZXhpc3RpbmcgcmVwdXJwb3NlZCBUREQgY29yZQ0K
PiA+ID4gPiA+IGJ1aWx0IGZvciBBRDkzNjEsIGFzIHdlbGwgYXMgZXhwYW5kaW5nIGl0cyBudW1i
ZXIgb2Ygb3V0cHV0DQo+ID4gPiA+ID4gY2hhbm5lbHMgZm9yIHN5c3RlbXMgd2hpY2ggcmVxdWly
ZSBtb3JlIHRoYW4gc2l4IGNvbnRyb2xsaW5nIHNpZ25hbHMuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBFbGl6YSBCYWxhcyA8ZWxpemEuYmFsYXNAYW5hbG9nLmNvbT4NCj4g
PiA+ID4NCj4gPiA+ID4gVGhhbmtzIGZvciB5b3VyIHN1Ym1pc3Npb24sIEkndmUgaGFkIGEgZmly
c3QgbG9vayBhdCB0aGUgZHJpdmVyDQo+ID4gPiA+IGFuZCB0aGUgaW1wbGVtZW50YXRpb24gb2Yg
dGhlIGludGVyZmFjZSB5b3UgaGF2ZSBjaG9zZW4gbG9va3MNCj4gPiA+ID4gYWxsIGdvb2QgdG8g
bWUsIHNvIEkgaGF2ZSBubyBkZXRhaWxlZCBjb21tZW50cyBvbiB0aGF0Lg0KPiA+ID4gPg0KPiA+
ID4gPiBJdCB3b3VsZCBob3dldmVyIGhlbHAgdG8gZXhwbGFpbiB0aGUgaWRlYXMgeW91IGhhZCBm
b3IgdGhlDQo+ID4gPiA+IHVzZXItc3BhY2UgaW50ZXJmYWNlIGRlc2lnbiBhbmQgc3VtbWFyaXpl
IHRoZW0gaW4gdGhlIGNoYW5nZWxvZw0KPiA+ID4gPiB0ZXh0Lg0KPiA+ID4gPg0KPiA+ID4gPiBZ
b3UgaGF2ZSBjaG9zZW4gYSBsb3ctbGV2ZWwgaW50ZXJmYWNlIHRoYXQgd3JhcHMgdGhlIGluZGl2
aWR1YWwNCj4gPiA+ID4gZGV2aWNlIHJlZ2lzdGVycyBhbmQgZ2l2ZXMgdXNlciBzcGFjZSBkaXJl
Y3QgY29udHJvbCBvdmVyIHRoZW0uDQo+ID4gPiA+IFRoZSByaXNrIGhlcmUgaXMgdG8gbG9jayB5
b3Vyc2VsZiBpbnRvIHRoZSBmaXJzdCBkZXNpZ24sDQo+ID4gPiA+IGdpdmluZyB5b3UgbGVzcyBm
bGV4aWJpbGl0eSBmb3IgZnV0dXJlIGV4dGVuc2lvbnMsIHNvIGl0IHdvdWxkDQo+ID4gPiA+IGhl
bHAgdG8gdW5kZXJzdGFuZCB3aGF0IHRoZSB1c2FnZSBtb2RlbCBpcyBoZXJlLg0KPiA+ID4gPg0K
PiA+ID4gPiBPbmUgcmlzayBpcyB0aGF0IHRoZXJlIG1heSBiZSBhbiBpbi1rZXJuZWwgdXNlciBp
biB0aGUgZnV0dXJlDQo+ID4gPiA+IHdoZW4gdGhlIFRERCBlbmdpbmUgaW50ZXJhY3RzIHdpdGgg
YW5vdGhlciBkZXZpY2UsIHNvIHlvdQ0KPiA+ID4gPiBuZWVkIGEgZHJpdmVyIGxldmVsIGludGVy
ZmFjZSwgd2hpY2ggd291bGQgaW4gdHVybiBicmVhaw0KPiA+ID4gPiBpZiBhbnkgdXNlciBwb2tl
cyB0aGUgcmVnaXN0ZXJzIGRpcmVjdGx5Lg0KPiA+ID4gPg0KPiA+ID4gPiBBbm90aGVyIHBvc3Np
YmxlIHByb2JsZW0gSSBzZWUgaXMgdGhhdCBhbiBhcHBsaWNhdGlvbiB3cml0dGVuDQo+ID4gPiA+
IGZvciB0aGlzIGRyaXZlciB3b3VsZCBiZSBpbmNvbXBhdGlibGUgd2l0aCBzaW1pbGFyIGhhcmR3
YXJlDQo+ID4gPiA+IHRoYXQgaGFzIHRoZSBzYW1lIGZ1bmN0aW9uYWxpdHkgYnV0IGEgZGlmZmVy
ZW50IHJlZ2lzdGVyLWxldmVsDQo+ID4gPiA+IGludGVyZmFjZSwgb3IgZXZlbiBhIG1pbm9yIHJl
dmlzaW9uIG9mIHRoZSBkZXZpY2UgdGhhdCBlbmRzIHVwDQo+ID4gPiA+IGJyZWFraW5nIG9uZSBv
ZiB0aGUgYXNzdW1wdGlvbnMgYWJvdXQgdGhlIGhhcmR3YXJlIGRlc2lnbi4NCj4gPiA+ID4NCj4g
PiA+ID4gSW4gYm90aCBjYXNlcywgdGhlIGxpa2VseSBhbnN3ZXIgaXMgdG8gaGF2ZSBhIGhpZ2hl
ci1sZXZlbA0KPiA+ID4gPiBpbnRlcmZhY2Ugb2Ygc29tZSBzb3J0LCBidXQgdGhlIGRvd25zaWRl
IG9mIHRoYXQgd291bGQgYmUNCj4gPiA+ID4gdGhhdCBpdCBpcyBtdWNoIGhhcmRlciB0byBjb21l
IHVwIHdpdGggYSBnb29kIGludGVyZmFjZSB0aGF0DQo+ID4gPiA+IGNvdmVycyBhbGwgcG9zc2li
bGUgdXNlIGNhc2VzLg0KPiA+ID4gPg0KPiA+ID4gPiBBbm90aGVyIHF1ZXN0aW9uIGlzIHdoZXRo
ZXIgeW91IGNvdWxkIGZpdCBpbnRvIHNvbWUNCj4gPiA+ID4gZXhpc3Rpbmcgc3Vic3lzdGVtIGlu
c3RlYWQgb2YgY3JlYXRpbmcgYSBzaW5nbGUtZHJpdmVyDQo+ID4gPiA+IGludGVyZmFjZS4gZHJp
dmVycy9paW8vIG1pZ2h0IGJlIGEgZ29vZCBjaG9pY2UsIGFzDQo+ID4gPiA+IGl0IGFscmVhZHkg
aGFuZGxlcyBib3RoIGluLWtlcm5lbCBhbmQgdXNlcnNwYWNlIHVzZXJzLA0KPiA+ID4gPiBhbmQg
cHJvdmlkZXMgYSBjb21tb24gYWJzdHJhY3Rpb24gZm9yIG11bHRpcGxlIGNsYXNzZXMNCj4gPiA+
ID4gb2YgZGV2aWNlcyB0aGF0ICh3aXRob3V0IGFueSBkb21haW4ga25vd2xlZGdlIGluIG15IGNh
c2UpDQo+ID4gPiA+IGxvb2sgc2ltaWxhciBlbm91Z2ggdGhhdCB0aGlzIGNvdWxkIGJlIGFkZGVk
IHRoZXJlLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFdlIGFyZSB1c2luZyB0aGlzIGRyaXZlciB3
aXRoIGFuIGlpby1mYWtlIGRldmljZQ0KPiA+ID4NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHBzOi8vZ2l0aHViLmNvbS9hbmFsb2dkZXZpY2VzaW5jL2xpbnV4L2Jsb2IvbWFzdGVy
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vamVzZDINCj4gMDQvYWRpKjJD
aWlvLWZha2VkZXYueWFtbF9fO0pRISFBM05pOENTMHkyWSE4S20wVFhZY2dLa3VzSlRQb1l3NlYw
OV9LWkZiajA5WmZiclVwbnVWUlpvS0tPRUNNSlEtDQo+IDh0R1hBWVdzanJRNTBJYkduc1lYenF4
OC1HalIwQmtxUlEkDQo+ID4gPg0KPiA+ID4gwqBzbyB3ZSBjYW4gdGFrZSBhZHZhbnRhZ2Ugb2Yg
dGhlIGlpbyB1c2VyLXNwYWNlIGludGVyZmFjZS4NCj4gPg0KPiA+IEkgZG9uJ3QgdW5kZXJzdGFu
ZCBob3cgdGhhdCB3b3JrcyB5ZXQ6IERvIHlvdSBtZWFuIHRoYXQgdGhlcmUNCj4gPiBpc8KgIHVz
ZXItc3BhY2UgYXBwbGljYXRpb24gdGhhdCB1c2VzIHRoZSB0ZGQgc3lzZnMgaW50ZXJmYWNlIHRv
DQo+ID4gZXhwb3J0IGFuIElJTyBkZXZpY2UgYmFjayBpbnRvIHRoZSBrZXJuZWwsIG9yIGRvIHlv
dSBtZWFuIHRoZXJlDQo+ID4gaXMgYSByZWd1bGFyIElJTyBkZXZpY2UgaW4gd2l0aCBhIGtlcm5l
bCBkcml2ZXIgdGhhdCBpcyB1c2VkDQo+ID4gYXMgdGhlIGJhY2stZW5kIGZvciB0aGUgdGRkIGRl
dmljZSwgb3Igc29tZXRoaW5nIGVsc2U/DQo+ID4NCj4gDQo+IFdlbGwsIEkgbmV2ZXIgdXNlZCB0
aGlzIG15c2VsZiBidXQgdGhlIGlpby1mYWtlZGV2IGlzIGFuIG91dCBvZiB0cmVlIGRyaXZlciB0
aGF0DQo+IHJlY2VpdmVzIGEgcGhhbmRsZSB0byBhIGRldmljZSBhbmQgYSBzdHJpbmcgbGlzdCBv
ZiBzeXNmcyBhdHRyaWJ1dGVzIG9mIHRoYXQgc2FtZQ0KPiBkZXZpY2UuIEl0IHRoZW4gc3ltbGlu
a3MgdGhvc2UgdG8gYW4gSUlPIGZha2UgZGV2aWNlIHNvIHRoZXkgc2VlbSBsaWtlIElJTyBkZXZp
Y2UNCj4gYXR0cmlidXRlcy4gQXMgYSBzYWlkLCB0aGlzIGlzIF9fdmVyeV9fLCBfX3ZlcnlfXyBo
YWNraXNoIGFuZCB0aGUgc29sZWx5IHJlYXNvbiBpdCdzDQo+IGJlaW5nIGRvbmUgKEkgYmVsaWV2
ZSksIGlzIHRvIHVzZSBsaWJpaW8gb24gdGhhdCBmYWtlZGV2IHNvIHlvdSBjYW4gYWNjZXNzIHRo
ZXNlIGtpbmQNCj4gb2YgZGV2aWNlcyAobGlrZSB0aGlzIFRERCBjb3JlKSByZW1vdGVseSB0aHJv
dWdoIHRoZSBuZXR3b3JrIGZvciBleGFtcGxlIChvciBVU0IpLiBJbg0KPiB0aGUgcGFzdCwgd2Ug
d291bGQgcHV0IGRyaXZlcnMgdGhhdCBhcmUgbm90IElJTyBpbiBJSU8gZm9yIHRoZSBzYW1lIHJl
YXNvbi4gU28sIGF0DQo+IGxlYXN0IG5vdywgaXQncyBhIG9uZSB0aW1lIHVnbHkgaGFjayA6c3dl
YXRfc21pbGU6IGJ1dCB0aGVuIHdlIGNhbiBwdXQgZHJpdmVycyBpbg0KPiB0aGVpciByaWdodCBw
bGFjZXMuIE5vdCBzYXlpbmcgdGhpcyBqdXN0aWZpZXMgdGhpcyBmYWtlZGV2IGJ1dCBpdCBpcyB3
aGF0IGl0IGlzIDopLg0KPiANCj4gV2VsbCwgbWF5YmUgdGhpcyBvbmUgaXMgbm90IHJlYWxseSBp
biBoZXJlIGJ1dCB0aGUgSUlPIG1haW50YWluZXIgd2FzIGFsc28gbm90IHRvDQo+IGtlZW4gdG8g
aGF2ZSBpbiB0aGVyZS4gU28gSSdtIG5vdCByZWFsbHkgc3VyZSB3aGVyZSBlbHNlIGl0IGNhbiBn
by4NCj4gPg0KPiANCj4gLSBOdW5vIFPDoQ0KDQpBcyBOdW5vIGV4cGxhaW5lZCBpbiB0aGUgcHJl
dmlvdXMgZW1haWwsIHdlIGFyZSB1c2luZyB0aGUgaWlvLWZha2UgZGV2aWNlIGFzIGEgd29ya2Fy
b3VuZCBmb3IgdXNpbmcgdGhlIGRyaXZlciB3aXRoIHRoZSBsaWJpaW8gQVBJIHRvIGludGVyZmFj
ZSBpdCB3aXRoIHNvbWUgdXNlci1zcGFjZSBjbGllbnQgYXBwbGljYXRpb25zLiANClRoZSBkZXZp
Y2UgaXRzZWxmIGNvbnRhaW5zIGF0dHJpYnV0ZXMgd2hpY2ggYXJlIG5vdCBwYXJ0IG9mIHRoZSBJ
SU8uIFdlIGRvIG5vdCB3YW50IHRvIGNvbmZ1c2UgdGhpcyBkZXZpY2Ugd2l0aCBhbiBJSU8gZGV2
aWNlLCBzbyBJIGJlbGlldmUgdGhhdCB0aGUgZHJpdmVyIHNob3VsZCByZXNpZGUgaW4gdGhlIG1p
c2Mgc3Vic3lzdGVtLg0KDQpUaGlzIGRyaXZlciBpcyBjcmVhdGVkIGZvciBhIHNwZWNpZmljIEZQ
R0EgQ29yZSBhbmQgdGhlIGludGVudCB3YXMgdG8gaGF2ZSBhIGxvdy1sZXZlbCBpbnRlcmZhY2Ug
c28gdGhhdCB0aGUgdXNlciBjYW4gYWNjZXNzIHRoZSByZWdpc3RlcnMgZGlyZWN0bHksIGluIGFu
IGVhc3kgd2F5LCB3aXRob3V0IHVzaW5nIGEgY29tcGxleCBpbnRlcmZhY2UuIA0KSWYgdGhlcmUg
d2lsbCBiZSBvdGhlciBmdXR1cmUgcmV2aXNpb25zIG9mIHRoZSBUREQgRlBHQSBDb3JlLCB3ZSB3
aWxsIGtlZXAgdGhlIHJlZ2lzdGVyIHNwYWNlIGNvbXBhdGlibGUsIHNvIHdlIGRvbid0IGJyZWFr
IHRoZSBjdXJyZW50IGZ1bmN0aW9uYWxpdHkgb2YgdGhlIGRyaXZlci4NCg0KSSB3aWxsIG1ha2Ug
dGhlIGNoYW5nZXMgcmVsYXRlZCB0byB0aGUgZHVhbC1saWNlbnNlIGFuZCBjaGFuZ2UgaXQgdG8g
c2luZ2xlIGxpY2Vuc2UgZm9yIHRoZSBkcml2ZXIuIElmIHRoYXQgaXMgb2theSB3aXRoIHlvdSwg
SSB3aWxsIGtlZXAgdGhlIGRyaXZlciBpbiB0aGUgbWlzYyBzdWJzeXN0ZW0uDQoNCkkgdGhhbmsg
eW91IGFsbCBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIHJldmlldyB0aGlzIGRyaXZlciBhbmQgZm9y
IGhlbHBpbmcgbWUgZmlndXJlIG91dCB3aGVyZSB0aGlzIGRyaXZlciBmaXRzIGJlc3QuDQoNCkVs
aXphDQoNCg0KDQoNCg==
