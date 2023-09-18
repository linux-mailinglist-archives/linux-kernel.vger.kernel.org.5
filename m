Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E9E7A3F89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbjIRDBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbjIRDBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:01:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3358123;
        Sun, 17 Sep 2023 20:00:55 -0700 (PDT)
X-UUID: 936b5f7855cf11ee8051498923ad61e6-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ShLcJRTH0oP1Kvu4Ynr3+xG6it5Yom+K5QOfa2Fimls=;
        b=NMdBh1WByRWD0h6Mu5mLGBl4/6uK41/kZ4IZEDtbytyYYZY4UFQIBQsQtLWxZGumtjs9bZaNHAd9TpoGT3HHRnZQxDGTOTTGqBgtCPphU/ZSjRhh+eoKmaPfVqbFSbIQy+bdc2O/SfX/E8n9R+4wSIvscAwXRrLCTAdaz5KhRac=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:cecc0191-1f52-42be-9dce-fec569fc8018,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:02a4f2be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 936b5f7855cf11ee8051498923ad61e6-20230918
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1327498837; Mon, 18 Sep 2023 11:00:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 11:00:50 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 11:00:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/i4P7ZeBifI6QwdLiu/uBLcgwzEOIwHTwk/TuCMbXqlfV868mqU3USnHT4F4hAXO+WmB/b6KP3+DiQ6NvauQRgPSoMaq3fJJehxBaMxVXOZi6Chb86D2OAGd/ksfjNqCOfKW7QgCSU1+Utq51/7kCbxtV4CQvIqtSsbwl9CVEjE2DH3Y2DiS9ZtHOznCc29fzs02fU19nCwRMi3FH2znvG04PsHL+j4YM1TT/r/rVkjOloznkyAv6ufRkaUbyqH/KEXyXMPUzjq9crVcD6XNw+V2Qa6gmHDVD9IIEfncyYs8DCRogWUXdunsQawChntXrAmbJAGeD0Plm+PV2dd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShLcJRTH0oP1Kvu4Ynr3+xG6it5Yom+K5QOfa2Fimls=;
 b=BHvyM2K5Rf9fTqAGBy97TcZM+D9ByO5EKxb/pKdsGZMRT2JlB2BMT11sp2jZelEiC6WQR0y5jTnN8Xo10HnzIFouvCbBDoNuNlA1zXndRHBs1KD2CaRetwShD3y5Aat1/rVP8M4sRSql9A5QUoOg2aIMIKUuCC7oltFc5eXdU1kvvAAdsQbxezjW5BLFNKRebxN08SiOKGtExFt6auAHzNSMfRhpzBiXkia0ZsM67+RtK0P7opCroUIGI93DzpYg6+s0moyvcv/oqFit0zkpJUbZ7ObZEqTGycaeSSSQgqUVt6miBwYv5vDf3ixXhovKZxsAwrjb3B3Iz9QFdKVOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShLcJRTH0oP1Kvu4Ynr3+xG6it5Yom+K5QOfa2Fimls=;
 b=hsshW+Mpjp67kJSs0e0N2zaTAOkKqFuAmNsUHJD8yHJAVjycyu1XLn+399puCy1YPmMPBtWjuf1h1+0Yo4hcBWHFaxmIaXMFkvVcm6gESNBbvIIxy01jKRZlrhlM0tJjlzzhiSoWvinNq7iMzj3/qFx8qR5Zb5sbUXLj38WHRj4=
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com (2603:1096:301:40::11)
 by TYSPR03MB7883.apcprd03.prod.outlook.com (2603:1096:400:480::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Mon, 18 Sep
 2023 03:00:47 +0000
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::fb21:1c1a:678:fbfd]) by PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::fb21:1c1a:678:fbfd%3]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 03:00:47 +0000
From:   =?utf-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?= 
        <Chun-Jen.Tseng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1 2/2] soc: mediatek: svs: add support for mt8188
Thread-Topic: [PATCH v1 2/2] soc: mediatek: svs: add support for mt8188
Thread-Index: AQHZ56lW3pAlMPmEiEywykhuI1JJULAbnIGAgARM0AA=
Date:   Mon, 18 Sep 2023 03:00:47 +0000
Message-ID: <acfa542b3ca1c8dd05aa4f7730a6e00978cbb595.camel@mediatek.com>
References: <20230915075003.1552-1-chun-jen.tseng@mediatek.com>
         <20230915075003.1552-3-chun-jen.tseng@mediatek.com>
         <a6ae9a08-d295-8c1a-840a-84a1b447421b@collabora.com>
In-Reply-To: <a6ae9a08-d295-8c1a-840a-84a1b447421b@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5351:EE_|TYSPR03MB7883:EE_
x-ms-office365-filtering-correlation-id: 9a390189-5c3e-45b8-e2e5-08dbb7f37567
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/J5u7JznU3NSkJ3qXggKsaAFk2vUXUzE4f9XnQdn4z3tShpeuBBNP85QX5YyiKfVvwpykVhkZBCTn1RijkOvKKd4HXFwdrXTVSWDISedObwj4kLLvjy1Q1n2hOYsBZorFgkSzflrKdnlmK6jCaL+SmCONeYVyHfP8iAM/rFcgTgHszugA30tSrjQFB1MahQQhS9qMJcon7lAKicnSnHDPWzV7LoYvvtA2q8YQpDbisFm5IhZKBRRQCQhJc7vANwTal7oA100zjjSzLwnfrXmrg4z6Lva+T7zcwfafY98iAFSPN8RkdoMDv/Xq2pptJVIV7/BgKnU7LgKVPEfnzPcf5Q5T/7V+2qFEa3DpndoEQl0wM0GiarzpFJ7qhFJoUCG0gxh/+H1xYvMz2BOs4kqJ9dysEkqFtdw16yD776OHLToyMLuSdXyeCJPy1AiCLzX7yfXRAfYKDz/s/lUfK4X5XjeEtkCGywpU6wmm3vTUDXVrGS2Yw0H6TPM7yAw9vc5etPrSBU0ykw+BDivLUeMXgyszelKKz3pqM0BKFAH1dQvhX1qo/pUr/st0Y0E63EEmGeV3ov+ATsr1iWFehIfE6wSX7Pl+PrBFBkH8tOaRQN5mSM59lEUe5IvP42AsBm3okP3vkCU3vsiyaZh6gR6tYzZ55iSDyjsIftgcIXyIs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5351.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(1800799009)(186009)(451199024)(66946007)(76116006)(122000001)(316002)(8676002)(8936002)(4326008)(41300700001)(6506007)(6486002)(6512007)(478600001)(71200400001)(110136005)(91956017)(83380400001)(2616005)(38100700002)(107886003)(26005)(5660300002)(2906002)(86362001)(7416002)(38070700005)(36756003)(85182001)(66446008)(64756008)(66556008)(54906003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjEycllCcC9BSlNabWNERjlhY1kycndlUUFVcXpocFBVVm0zc1VUOUwrbEJq?=
 =?utf-8?B?YmsrUnVPRkFHQTFyOUxVNEhkY25vM01XK2JpbTA0N0RmMFhjWlZ3M3gzN05j?=
 =?utf-8?B?SDMvR3BsaHA4Nk9pSmZMT0U2VjFtVUp5M29RSnV6WnI0cFVxTXYzT3FPRjZs?=
 =?utf-8?B?eDI2cHhKRnpRcWhheHZTa09YaUdTTUdZTy9RSWp1djBUNUFlblkyVHI5dktX?=
 =?utf-8?B?bCtiZFpZNHY2NC9veTUyNHJCWWFRS21rd25zQ1QwSTEzTEVtaHpIS2NVRTc5?=
 =?utf-8?B?WHFxeGFvUWp1bXkvaEdHMDBSUk5scjhxb0hpamk3dUNHQVBPSzNIOTBaY3la?=
 =?utf-8?B?eXltelRjQ1BSb2s2OGQ0U0JIZll3TURQZmJLWHNHSXVJYXltK1o0TTdtbjVR?=
 =?utf-8?B?WG9Ra2Jab1A3MEZwY0NKZHA5VTZpbC8zZURoWFZPa3JUVFp5MHErYkl1Qk9Q?=
 =?utf-8?B?NExzdFR5VFh1Y21hYlZKT1ZYZUN1SXVCWnluYkZJMVVlR0dhWDNSaWQ1TVdV?=
 =?utf-8?B?UklLTEEwb1lBUWFTcmNZY0NnK2Nwd2RKQUN4NDYvNk9RREF0cHkvaDF2aHlV?=
 =?utf-8?B?NE1iay9TWHYzVUt1Y0tNK1kxdXdhVDRvZ3RPdXlpR1NSTzBJYzhaZlNyNlZI?=
 =?utf-8?B?ci9GdHF6NXBFMEY5NmtuVTZpTWlSNXh5T2NUT0xpMThkTG1nVXkwdndSUGxz?=
 =?utf-8?B?bkJNSzRpUW5adWlXUVlIVjVTMDZjVTYzc3N5WGRTWVFQQnlxelV0Um0ybDkr?=
 =?utf-8?B?RVdRN1FlYVoybCtpTVYxQnVzNkl3bG00R3hocUxlY090T2t1REU1bGE3MHZC?=
 =?utf-8?B?L2oyeEcxSWtDWWlqYXhJdXhxTUJKREJkVURJenVqVldsQTg0YTFqMEhmMXZn?=
 =?utf-8?B?bmp4SlIvSnZnb0MzM2lJYktvWWM2cTNLM1JSK1RlQUtuSzAxanBaSGZoZFNq?=
 =?utf-8?B?MG94OXMrSnJ5UFdkbDhyemxFRFlsVFJ5Z21mWlJNL3lUeUNBREU5eHNSN3FB?=
 =?utf-8?B?NEVYVmMyZUJ5SWh5N0FzeVQwWUdKK1lIb214V1BpNEZ4RG1LUXJxQzU5T1hM?=
 =?utf-8?B?NHNRRmNGZ210OFozck9iZ2Vjalk2V1czVFFIU25YWXBGUXhrdVh4RXV3cGFi?=
 =?utf-8?B?M1FJaTdwcHRpVWZXRFJtaFcrbTY4MXVKaGl1V2thY2FwZjdJeU84NlI2aTN6?=
 =?utf-8?B?TUlocFZYRlAxVndKeG0vOEs0Z0Nyb0hMOVlKdCtOalFrWWpjWE9DSFhaOE9V?=
 =?utf-8?B?dGYzS0Z2c09XUDFxL0pHc0w0MTRaUlJIcXVWWXA2U0pndGNCS3p1aFVBSXpw?=
 =?utf-8?B?dUFSWG01bXNBaWp6TFJsNDIyNEpGa3djNFNpQjIxaVRpRitzY2w2c2tiUFhD?=
 =?utf-8?B?SXhoU3hiajdlYzBUdzB1NFFydmNuemh3U0oybG9xN0NUTktjcmpMUTUvdUFt?=
 =?utf-8?B?N0hxOHV4bzcvRUhaL2VXcG1PeTkra01mcktCZU5oY0czakFEeFQrb0FkYm1o?=
 =?utf-8?B?bTRNUDBVY0RhaEJLSU94Q0lVNmN3Q1RWRG1oVTFlcFdnMzlLOHByd2FRUTFU?=
 =?utf-8?B?YUJscFRqVTVmM21CQ1dJSE43ZitpdTR2UlBNeU00T3c2ODlzT1lLSWtDYXAx?=
 =?utf-8?B?dkI5NWZ6SjdUMWlvbkx6NHphYkVhNTR4VVJub2llWGRaM095Q3hTUzg3Y0Jq?=
 =?utf-8?B?WGcvWEZhYTg1dVZHZ2xyZHpqMEZ0N2QvSzZSL1NUd1FCaytYZDUySjJKVmdS?=
 =?utf-8?B?OW05Y1hFTS9pb1pvOFdEQmJFNWFxbTlJdXBJa2VFZmVyNE5UalZ4ZVYwRUVn?=
 =?utf-8?B?cWdSUDRxNUo4Q1pHMjc3QzJmQXJ6N2NMU1FFejNlbkw1RXZRWTZjRittL1hS?=
 =?utf-8?B?RHQ0ajRqelRLTDI0WE9tUnA3Yjd6QUp6eWw1ZUNOTkI0dWVncGJNS3hjMHRM?=
 =?utf-8?B?SnppazVpRzlFdkdmUGcrOGlUamdVTVlHYVk0MENzNkkzRG9ReE9UNVlwc3BV?=
 =?utf-8?B?WVlFY2hzNjE3YTQrYVRBTEVCN04zcjdFRUhCQ2JlNUxjT0Y1bjRSRC9VaWcz?=
 =?utf-8?B?QjZlK08vOFlnQ1QrWCtRKzNBajVsYWxXV2tTMlZieDZ5aUo3MmY2djkwWVo0?=
 =?utf-8?B?U1k3UmRXeTNXWU9Jbk5SQ2hpYVQrYmxvSHM2STZRYVJlMmNETHNpNFFBQlht?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E560D80AE8BAFB408EEFBC359EFCA629@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5351.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a390189-5c3e-45b8-e2e5-08dbb7f37567
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 03:00:47.7212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdZAUnfsbdvY+/E4+69AureKTDPSWAm6lF20ddcxY/lNX28/cHn0PWjcWXjwOxaAFagOntFkHcCp0JPRtgiyqg4l5z/H0+CtBEgfR7bobRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7883
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTE1IGF0IDExOjIwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTUvMDkvMjMgMDk6NTAsIE1hcmsgVHNlbmcgaGEgc2NyaXR0bzoN
Cj4gPiBNVDgxODggc3ZzIGdwdSB1c2VzIDItbGluZSBoaWdoIGJhbmsgYW5kIGxvdyBiYW5rIHRv
IG9wdGltaXplIHRoZQ0KPiA+IHZvbHRhZ2Ugb2Ygb3BwIHRhYmxlIGZvciBoaWdoZXIgYW5kIGxv
d2VyIGZyZXF1ZW5jeSByZXNwZWN0aXZlbHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFy
ayBUc2VuZyA8Y2h1bi1qZW4udHNlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLXN2cy5jIHwgMTc3DQo+ID4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTcyIGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1zdnMuYw0KPiA+IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXN2cy5jDQo+ID4g
aW5kZXggM2EyZjk3Y2Q1MjcyLi5mYWZjNzJkZjk5ZWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLXN2cy5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLXN2cy5jDQo+ID4gQEAgLTQwNyw2ICs0MDcsNyBAQCBzdHJ1Y3Qgc3ZzX3BsYXRmb3JtX2Rh
dGEgew0KPiA+ICAgICogQGRjYmRldDogc3ZzIGVmdXNlIGRhdGENCj4gPiAgICAqIEBkY21kZXQ6
IHN2cyBlZnVzZSBkYXRhDQo+ID4gICAgKiBAdHVybl9wdDogMi1saW5lIHR1cm4gcG9pbnQgdGVs
bHMgd2hpY2ggb3BwX3ZvbHQgY2FsY3VsYXRlZCBieQ0KPiA+IGhpZ2gvbG93IGJhbmsNCj4gPiAr
ICogQHZiaW5fdHVybl9wdDogdm9sdGFnZSBiaW4gdHVybiBwb2ludCBoZWxwcyBrbm93IHdoaWNo
DQo+ID4gc3ZzYl92b2x0IHNob3VsZCBiZSBvdmVycmlkZGVuDQo+ID4gICAgKiBAdHlwZTogYmFu
ayB0eXBlIHRvIHJlcHJlc2VudCBpdCBpcyAyLWxpbmUgKGhpZ2gvbG93KSBiYW5rIG9yDQo+ID4g
MS1saW5lIGJhbmsNCj4gPiAgICAqDQo+ID4gICAgKiBTdnMgYmFuayB3aWxsIGdlbmVyYXRlIHN1
aXRhbGJlIHZvbHRhZ2VzIGJ5IGJlbG93IGdlbmVyYWwgbWF0aA0KPiA+IGVxdWF0aW9uDQo+ID4g
QEAgLTQ2OSw2ICs0NzAsNyBAQCBzdHJ1Y3Qgc3ZzX2Jhbmsgew0KPiA+ICAgCXUzMiBkY2JkZXQ7
DQo+ID4gICAJdTMyIGRjbWRldDsNCj4gPiAgIAl1MzIgdHVybl9wdDsNCj4gPiArCXUzMiB2Ymlu
X3R1cm5fcHQ7DQo+ID4gICAJdTMyIHR5cGU7DQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gQEAgLTc1
MSwxMSArNzUzLDEyIEBAIHN0YXRpYyBpbnQgc3ZzX3N0YXR1c19kZWJ1Z19zaG93KHN0cnVjdA0K
PiA+IHNlcV9maWxlICptLCB2b2lkICp2KQ0KPiA+ICAgDQo+ID4gICAJcmV0ID0gdGhlcm1hbF96
b25lX2dldF90ZW1wKHN2c2ItPnR6ZCwgJnR6b25lX3RlbXApOw0KPiA+ICAgCWlmIChyZXQpDQo+
ID4gLQkJc2VxX3ByaW50ZihtLCAiJXM6IHRlbXBlcmF0dXJlIGlnbm9yZSwgdHVybl9wdCA9ICV1
XG4iLA0KPiA+IC0JCQkgICBzdnNiLT5uYW1lLCBzdnNiLT50dXJuX3B0KTsNCj4gPiArCQlzZXFf
cHJpbnRmKG0sICIlczogdGVtcGVyYXR1cmUgaWdub3JlLCB2YmluX3R1cm5fcHQgPQ0KPiA+ICV1
LCB0dXJuX3B0ID0gJXVcbiIsDQo+ID4gKwkJCSAgIHN2c2ItPm5hbWUsIHN2c2ItPnZiaW5fdHVy
bl9wdCwgc3ZzYi0NCj4gPiA+dHVybl9wdCk7DQo+ID4gICAJZWxzZQ0KPiA+IC0JCXNlcV9wcmlu
dGYobSwgIiVzOiB0ZW1wZXJhdHVyZSA9ICVkLCB0dXJuX3B0ID0gJXVcbiIsDQo+ID4gLQkJCSAg
IHN2c2ItPm5hbWUsIHR6b25lX3RlbXAsIHN2c2ItPnR1cm5fcHQpOw0KPiA+ICsJCXNlcV9wcmlu
dGYobSwgIiVzOiB0ZW1wZXJhdHVyZSA9ICVkLCB2YmluX3R1cm5fcHQgPSAldSwNCj4gPiB0dXJu
X3B0ID0gJXVcbiIsDQo+ID4gKwkJCSAgIHN2c2ItPm5hbWUsIHR6b25lX3RlbXAsIHN2c2ItPnZi
aW5fdHVybl9wdCwNCj4gPiArCQkJICAgc3ZzYi0+dHVybl9wdCk7DQo+ID4gICANCj4gPiAgIAlm
b3IgKGkgPSAwOyBpIDwgc3ZzYi0+b3BwX2NvdW50OyBpKyspIHsNCj4gPiAgIAkJb3BwID0gZGV2
X3BtX29wcF9maW5kX2ZyZXFfZXhhY3Qoc3ZzYi0+b3BwX2RldiwNCj4gPiBAQCAtOTUyLDYgKzk1
NSwyOSBAQCBzdGF0aWMgdm9pZCBzdnNfZ2V0X2Jhbmtfdm9sdHNfdjMoc3RydWN0DQo+ID4gc3Zz
X3BsYXRmb3JtICpzdnNwKQ0KPiA+ICAgCWZvciAoaSA9IG9wcF9zdGFydDsgaSA8IG9wcF9zdG9w
OyBpKyspDQo+ID4gICAJCWlmIChzdnNiLT52b2x0X2ZsYWdzICYgU1ZTQl9SRU1PVkVfRFZURklY
RURfVk9MVCkNCj4gPiAgIAkJCXN2c2ItPnZvbHRbaV0gLT0gc3ZzYi0+ZHZ0X2ZpeGVkOw0KPiA+
ICsNCj4gPiArCS8qIEZvciB2b2x0YWdlIGJpbiBzdXBwb3J0ICovDQo+ID4gKwlpZiAoc3ZzYi0+
b3BwX2RmcmVxWzBdID4gc3ZzYi0+ZnJlcV9iYXNlKSB7DQo+ID4gKwkJc3ZzYi0+dm9sdFswXSA9
IHN2c19vcHBfdm9sdF90b19iYW5rX3ZvbHQoc3ZzYi0NCj4gPiA+b3BwX2R2b2x0WzBdLA0KPiA+
ICsJCQkJCQkJICBzdnNiLQ0KPiA+ID52b2x0X3N0ZXAsDQo+ID4gKwkJCQkJCQkgIHN2c2ItDQo+
ID4gPnZvbHRfYmFzZSk7DQo+ID4gKw0KPiA+ICsJCS8qIEZpbmQgdm9sdGFnZSBiaW4gdHVybiBw
b2ludCAqLw0KPiA+ICsJCWZvciAoaSA9IDA7IGkgPCBzdnNiLT5vcHBfY291bnQ7IGkrKykgew0K
PiA+ICsJCQlpZiAoc3ZzYi0+b3BwX2RmcmVxW2ldIDw9IHN2c2ItPmZyZXFfYmFzZSkgew0KPiA+
ICsJCQkJc3ZzYi0+dmJpbl90dXJuX3B0ID0gaTsNCj4gPiArCQkJCWJyZWFrOw0KPiA+ICsJCQl9
DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQkvKiBPdmVycmlkZSBzdnMgYmFuayB2b2x0YWdlcyAq
Lw0KPiA+ICsJCWZvciAoaSA9IDE7IGkgPCBzdnNiLT52YmluX3R1cm5fcHQ7IGkrKykNCj4gPiAr
CQkJc3ZzYi0+dm9sdFtpXSA9IGludGVycG9sYXRlKHN2c2ItPmZyZXFfcGN0WzBdLA0KPiA+ICsJ
CQkJCQkgICAgc3ZzYi0NCj4gPiA+ZnJlcV9wY3Rbc3ZzYi0+dmJpbl90dXJuX3B0XSwNCj4gPiAr
CQkJCQkJICAgIHN2c2ItPnZvbHRbMF0sDQo+ID4gKwkJCQkJCSAgICBzdnNiLT52b2x0W3N2c2It
DQo+ID4gPnZiaW5fdHVybl9wdF0sDQo+ID4gKwkJCQkJCSAgICBzdnNiLT5mcmVxX3BjdFtpXSk7
DQo+ID4gKwl9DQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgYmVpbmcgYSBuZXcgZmVhdHVyZSB0aGF0
IGFwcGxpZXMgdG8gbW9yZSB0aGFuIGp1c3QNCj4gTVQ4MTg4Pw0KPiBHb2VzIGludG8gYSBkaWZm
ZXJlbnQgY29tbWl0Lg0KPiANCg0KdGhpcyBpcyB2b2x0YWdlIGJpbiB0dXJuIHBvaW50LCBpdCBp
cyBmb3IgYWxsIFNvQyAsIG5vdCBmb3IgbXQ4MTg4LiAgDQogDQo+ID4gICB9DQo+ID4gICANCj4g
PiAgIHN0YXRpYyB2b2lkIHN2c19zZXRfYmFua19mcmVxX3BjdF92MyhzdHJ1Y3Qgc3ZzX3BsYXRm
b3JtICpzdnNwKQ0KPiA+IEBAIC0xODA4LDYgKzE4MzQsODAgQEAgc3RhdGljIGJvb2wgc3ZzX210
ODE5Ml9lZnVzZV9wYXJzaW5nKHN0cnVjdA0KPiA+IHN2c19wbGF0Zm9ybSAqc3ZzcCkNCj4gPiAg
IAlyZXR1cm4gdHJ1ZTsNCj4gPiAgIH0NCj4gPiAgIA0KPiA+ICtzdGF0aWMgYm9vbCBzdnNfbXQ4
MTg4X2VmdXNlX3BhcnNpbmcoc3RydWN0IHN2c19wbGF0Zm9ybSAqc3ZzcCkNCj4gPiArew0KPiA+
ICsJc3RydWN0IHN2c19iYW5rICpzdnNiOw0KPiA+ICsJc3RydWN0IG52bWVtX2NlbGwgKmNlbGw7
DQo+ID4gKwl1MzIgaWR4LCBpLCBnb2xkZW5fdGVtcDsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAw
OyBpIDwgc3ZzcC0+ZWZ1c2VfbWF4OyBpKyspDQo+ID4gKwkJaWYgKHN2c3AtPmVmdXNlW2ldKQ0K
PiA+ICsJCQlkZXZfaW5mbyhzdnNwLT5kZXYsICJNX0hXX1JFUyVkOiAweCUwOHhcbiIsDQo+ID4g
KwkJCQkgaSwgc3ZzcC0+ZWZ1c2VbaV0pOw0KPiA+ICsNCj4gPiArCWlmICghc3ZzcC0+ZWZ1c2Vb
NV0pIHsNCj4gPiArCQlkZXZfbm90aWNlKHN2c3AtPmRldiwgInN2c19lZnVzZVs1XSA9IDB4MD9c
biIpOw0KPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKiBTdnMg
ZWZ1c2UgcGFyc2luZyAqLw0KPiA+ICsJZm9yIChpZHggPSAwOyBpZHggPCBzdnNwLT5iYW5rX21h
eDsgaWR4KyspIHsNCj4gPiArCQlzdnNiID0gJnN2c3AtPmJhbmtzW2lkeF07DQo+ID4gKw0KPiA+
ICsJCWlmIChzdnNiLT50eXBlID09IFNWU0JfTE9XKSB7DQo+ID4gKwkJCXN2c2ItPm10ZGVzID0g
c3ZzcC0+ZWZ1c2VbNV0gJiBHRU5NQVNLKDcsIDApOw0KPiA+ICsJCQlzdnNiLT5iZGVzID0gKHN2
c3AtPmVmdXNlWzVdID4+IDE2KSAmDQo+ID4gR0VOTUFTSyg3LCAwKTsNCj4gPiArCQkJc3ZzYi0+
bWRlcyA9IChzdnNwLT5lZnVzZVs1XSA+PiAyNCkgJg0KPiA+IEdFTk1BU0soNywgMCk7DQo+ID4g
KwkJCXN2c2ItPmRjYmRldCA9IChzdnNwLT5lZnVzZVsxNV0gPj4gMTYpICYNCj4gPiBHRU5NQVNL
KDcsIDApOw0KPiA+ICsJCQlzdnNiLT5kY21kZXQgPSAoc3ZzcC0+ZWZ1c2VbMTVdID4+IDI0KSAm
DQo+ID4gR0VOTUFTSyg3LCAwKTsNCj4gPiArCQl9IGVsc2UgaWYgKHN2c2ItPnR5cGUgPT0gU1ZT
Ql9ISUdIKSB7DQo+ID4gKwkJCXN2c2ItPm10ZGVzID0gc3ZzcC0+ZWZ1c2VbNF0gJiBHRU5NQVNL
KDcsIDApOw0KPiA+ICsJCQlzdnNiLT5iZGVzID0gKHN2c3AtPmVmdXNlWzRdID4+IDE2KSAmDQo+
ID4gR0VOTUFTSyg3LCAwKTsNCj4gPiArCQkJc3ZzYi0+bWRlcyA9IChzdnNwLT5lZnVzZVs0XSA+
PiAyNCkgJg0KPiA+IEdFTk1BU0soNywgMCk7DQo+ID4gKwkJCXN2c2ItPmRjYmRldCA9IHN2c3At
PmVmdXNlWzE0XSAmIEdFTk1BU0soNywgMCk7DQo+ID4gKwkJCXN2c2ItPmRjbWRldCA9IChzdnNw
LT5lZnVzZVsxNF0gPj4gOCkgJg0KPiA+IEdFTk1BU0soNywgMCk7DQo+ID4gKwkJfQ0KPiA+ICsN
Cj4gPiArCQlzdnNiLT52bWF4ICs9IHN2c2ItPmR2dF9maXhlZDsNCj4gPiArCX0NCj4gDQo+IFRo
ZSBvbmx5IGNoYW5nZSBiZXR3ZWVuIG10ODE5MiwgODE5NSBhbmQgODE4OCBpcyB0aGlzIGZvciBs
b29wOyBjYW4NCj4gd2UgcGxlYXNlDQo+IGNvbW1vbml6ZSB0aGUgcmVzdCBvZiB0aGUgZnVuY3Rp
b24/DQo+IA0KSSBoYXZlIGRpZmYgbXQ4MTkyLCA4MTk1IGFuZCA4MTg4IHBhcnNpbmcgY29kZS4g
SXQgbG9va3Mgbm90IG9ubHkgdGhpcw0KZm9yIGxvb3AgcGFydCBkaWZmZXJlbnQsIGl0IGFsc28g
aGF2ZSB2bWluIGFuZCBmdF9wZ20gbmVlZCB0byBjaGVjay4NCg0KDQo+ID4gKw0KPiA+ICsJLyog
VGhlcm1hbCBlZnVzZSBwYXJzaW5nICovDQo+ID4gKwljZWxsID0gbnZtZW1fY2VsbF9nZXQoc3Zz
cC0+ZGV2LCAidC1jYWxpYnJhdGlvbi1kYXRhIik7DQo+ID4gKwlpZiAoSVNfRVJSX09SX05VTEwo
Y2VsbCkpIHsNCj4gPiArCQlkZXZfZXJyKHN2c3AtPmRldiwgIm5vIFwidC1jYWxpYnJhdGlvbi1k
YXRhXCI/ICVsZFxuIiwNCj4gPiArCQkJUFRSX0VSUihjZWxsKSk7DQo+ID4gKwkJcmV0dXJuIGZh
bHNlOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXN2c3AtPnRlZnVzZSA9IG52bWVtX2NlbGxfcmVh
ZChjZWxsLCAmc3ZzcC0+dGVmdXNlX21heCk7DQo+ID4gKwlpZiAoSVNfRVJSKHN2c3AtPnRlZnVz
ZSkpIHsNCj4gPiArCQlkZXZfZXJyKHN2c3AtPmRldiwgImNhbm5vdCByZWFkIHRoZXJtYWwgZWZ1
c2U6ICVsZFxuIiwNCj4gPiArCQkJUFRSX0VSUihzdnNwLT50ZWZ1c2UpKTsNCj4gPiArCQludm1l
bV9jZWxsX3B1dChjZWxsKTsNCj4gPiArCQlyZXR1cm4gZmFsc2U7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJc3ZzcC0+dGVmdXNlX21heCAvPSBzaXplb2YodTMyKTsNCj4gPiArCW52bWVtX2NlbGxf
cHV0KGNlbGwpOw0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBzdnNwLT50ZWZ1c2VfbWF4
OyBpKyspDQo+ID4gKwkJaWYgKHN2c3AtPnRlZnVzZVtpXSAhPSAwKQ0KPiA+ICsJCQlicmVhazsN
Cj4gPiArDQo+ID4gKwlpZiAoaSA9PSBzdnNwLT50ZWZ1c2VfbWF4KQ0KPiA+ICsJCWdvbGRlbl90
ZW1wID0gNTA7IC8qIEFsbCB0aGVybWFsIGVmdXNlIGRhdGEgYXJlIDAgKi8NCj4gPiArCWVsc2UN
Cj4gPiArCQlnb2xkZW5fdGVtcCA9IChzdnNwLT50ZWZ1c2VbMF0gJiBHRU5NQVNLKDMxLCAyNCkp
ID4+DQo+ID4gMjQ7DQo+ID4gKw0KPiA+ICsJZm9yIChpZHggPSAwOyBpZHggPCBzdnNwLT5iYW5r
X21heDsgaWR4KyspIHsNCj4gPiArCQlzdnNiID0gJnN2c3AtPmJhbmtzW2lkeF07DQo+ID4gKwkJ
c3ZzYi0+bXRzID0gNTAwOw0KPiA+ICsJCXN2c2ItPmJ0cyA9ICgoKDUwMCAqIGdvbGRlbl90ZW1w
ICsgMjUwNDYwKSAvIDEwMDApIC0NCj4gPiAyNSkgKiA0Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAr
CXJldHVybiB0cnVlOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIGJvb2wgc3ZzX210ODE4
M19lZnVzZV9wYXJzaW5nKHN0cnVjdCBzdnNfcGxhdGZvcm0gKnN2c3ApDQo+ID4gICB7DQo+ID4g
ICAJc3RydWN0IHN2c19iYW5rICpzdnNiOw0KPiA+IEBAIC0yMDUyLDcgKzIxNTIsNyBAQCBzdGF0
aWMgaW50IHN2c19tdDgxOTJfcGxhdGZvcm1fcHJvYmUoc3RydWN0DQo+ID4gc3ZzX3BsYXRmb3Jt
ICpzdnNwKQ0KPiA+ICAgCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShzdnNwLT5kZXYsIFBUUl9FUlIo
c3ZzcC0+cnN0KSwNCj4gPiAgIAkJCQkgICAgICJjYW5ub3QgZ2V0IHN2cyByZXNldCBjb250cm9s
XG4iKTsNCj4gPiAgIA0KPiA+IC0JZGV2ID0gc3ZzX2FkZF9kZXZpY2VfbGluayhzdnNwLCAibHZ0
cyIpOw0KPiA+ICsJZGV2ID0gc3ZzX2FkZF9kZXZpY2VfbGluayhzdnNwLCAidGhlcm1hbC1zZW5z
b3IiKTsNCj4gDQo+IFRoaXMgaXMgYSBmaXggdGhhdCBtdXN0IGdvIGluIGEgZGlmZmVyZW50IGNv
bW1pdCB3aXRoIGEgRml4ZXMgdGFnLg0KPiANCkkgaGF2ZSBhbHJlYWR5IGNoZWNrZWQgdGhpcyBw
YXJ0LCB0aGF0J3MgbXkgbWlzdGFrZSwgSSB3aWxsIHVwZGF0ZSB2Mg0KcGF0Y2ggdG8gZml4ZWQg
dGhpcy4NCg0KPiA+ICAgCWlmIChJU19FUlIoZGV2KSkNCj4gPiAgIAkJcmV0dXJuIGRldl9lcnJf
cHJvYmUoc3ZzcC0+ZGV2LCBQVFJfRVJSKGRldiksDQo+ID4gICAJCQkJICAgICAiZmFpbGVkIHRv
IGdldCBsdnRzIGRldmljZVxuIik7DQo+ID4gQEAgLTIxNzMsNiArMjI3Myw2MSBAQCBzdGF0aWMg
c3RydWN0IHN2c19iYW5rIHN2c19tdDgxOTJfYmFua3NbXSA9DQo+ID4gew0KPiA+ICAgCX0sDQo+
ID4gICB9Ow0KPiA+ICAgDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo=
