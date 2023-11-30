Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4377FE66C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjK3Bw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjK3Bw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:52:56 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9C8BC;
        Wed, 29 Nov 2023 17:52:55 -0800 (PST)
X-UUID: 2b83a7488f2311eea33bb35ae8d461a2-20231130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Sdpj5tyH7yU8gomUfqhiQkGfVdljFsy1Oevb/SVnP9I=;
        b=XNCBRmlSnmJ852nJI5cJWccOq9G0kW6lInAeQUTZXRgD1xjKi2HXmCgl5Vza2hkjT0us03IfiodmfwhZ900j6Jon3s+gyUjnE6sPRgVe+jEEh/dFGZgtcbknvzCGson6e+PmeYeDMoE8cIJQ4wW0Hqv8W1yJVvsmYIJy71qPfx0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:2fd34293-6c34-43d4-b814-1652589e9e61,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:2f72f895-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 2b83a7488f2311eea33bb35ae8d461a2-20231130
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1557819430; Thu, 30 Nov 2023 09:52:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 30 Nov 2023 09:52:49 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 30 Nov 2023 09:52:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xyx1TcrBlRXxYTpG0sCvJEjTRuufJLyiwLOq1o8YALcaPt8QUpGrGi7azWrhh91Ub1PDpcVpcQ0xz4Daniaifng6un8QyrrRierdOlrsqUHujGmJHSDc4tA6M9I9L4ZyxjLfkhpUTPjEXXIe3ABfeGdiyEoas7JLNvN9L0Slapa95Zn4xlddkYmZddLbgQuXOZXlOhlAcsfDh2UM08TxL56j1KURfrAHfI1ydg5OWrT1Q1uw1qlH2IsMEuPIr0Bs7ez7TSYXI+gJSYjCBW7ZFmALieULqeO68DLH5jESJJDcYtwP71Od1OV4QiQlDMcitnAD89SQl1u7/CT9cdwOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sdpj5tyH7yU8gomUfqhiQkGfVdljFsy1Oevb/SVnP9I=;
 b=QKKrkfEPEo0U17v3pZ9iwF8cxv0JiLOp1EMMxOc+X0oUM8YGw8DIXWmIUGrA3jkvQvENfSNY87U8d0k5Or1ZDjvqpbSRYkMmp9qJ8YZ31kHKFsR2fcBspyq7RUHzek06hFu9vO+R/1KGGMwxlADAIBNgjFtgrkvkfvlTfhVtHBR3i1Oqfd6dBlub4nj8qcCMexlxDB7rhEWYKxhjdj/IBXIMO89GrJY6BqLJfiyTs09bBgAmhpboYqC/aX2YuEq/ZPFqYeOG0fw1vBFWjNqwKCkl+DPpBwYqTbe/A36qf6JOKqX+2AyX/cfEbQ0QHyGhOXuZ11r0AG0fRYG2Wt0ObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sdpj5tyH7yU8gomUfqhiQkGfVdljFsy1Oevb/SVnP9I=;
 b=qs+2Wz9+vye+Db+MuT4FKIHQmDULUyIgW28pepnxBWK+jDv2JIFPSJgjU7Wsk6wBdm2Hat/gGZX6slFcAOmLDFbLzaO2MZ/iUh7TlRJ0owlLiDi2WpGRWnYsW0yrjrX9qIp1jgimJylZl40i8h9l33fY9H5mIMUMVs39gE9h+nY=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by TYZPR03MB6495.apcprd03.prod.outlook.com (2603:1096:400:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Thu, 30 Nov
 2023 01:51:40 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 01:51:40 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= 
        <bear.wang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek: tphy: add a property for
 force-mode switch
Thread-Topic: [PATCH 1/2] dt-bindings: phy: mediatek: tphy: add a property for
 force-mode switch
Thread-Index: AQHaHz31Z+QBjWZtBk+dlN+S28FsW7CK2GgAgALqXwCAAANiAIAEWt+A
Date:   Thu, 30 Nov 2023 01:51:40 +0000
Message-ID: <74957a9cc4663815e200d222483541a1eec43bbe.camel@mediatek.com>
References: <20231125012303.760-1-chunfeng.yun@mediatek.com>
         <e34c2746-8e93-48b8-9c96-690242fbf6e9@linaro.org>
         <239def9b-437b-9211-7844-af4332651df0@mediatek.com>
         <0dc24d82-e09d-45bc-98ae-1dfb6318cb96@linaro.org>
In-Reply-To: <0dc24d82-e09d-45bc-98ae-1dfb6318cb96@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|TYZPR03MB6495:EE_
x-ms-office365-filtering-correlation-id: 8b1f40cd-1ce6-42ae-5fdc-08dbf146e5a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +sP5VsLkxHtntuj8kPCg8pMqHksZ0YhF4XyWK2h2TiDKzAw/NjVuS5Oz4n/y07bT1XXNI5GwgWd3je/HmqOm7losJlf2ZYO9tpLc3Jfh8yuZhMzTRInRMF82d9e1hv0/6GcOqx1qoKwftiDZ4EARvSNbgxCZ1LufiY8nLupji2W4HnR3XVKMOwBlfdzSx0728OfQTv5UIchAUNsstkfsC4Qx6k3UXOnvuMe4CDonRutyPxk+Cb0RUMVUnVRROgDjbkRM44iJ/HVNiPWaYpa3tUyK5i+JSMgmPyNuZ62Buzvr1aaauyeV/ieSzsmYc1E0T+XL1ChK5fs6JECVuq9uIFc8MEOJ7v+onV1jtMrI9/IG4PZQyiHcaUuBZgF3ggVZVUfa350J8cp9tCl7039+8DLL9WDdT0t4HXycTvy3KT4jH5Nvew/mxR0WgL6OMTDJfBvIZByCXbuRC+++1hEVt7rBtwbIbTsJJWSntBTzUwYYS/2KiGSmjnkEdg1WXbARbvp54j+I86jwzJH00RQD9HWmOl7bfngLr6WE/UN7cIaAnKy0jcESHl10lX/je1UJcGlTRAO+sOSSNWk4w+VVqCxz24d7wS5EbrFxUVpMdVfH214K6EZIwcSYyMmVU2bAkfe7MBnqxBsSYYf9PbY/o7ol4r2e7ohk5NWos7efxoXExkQyUJGzJsL41kLedFSWQpxQBspoamv3sQ4sUVb44AVupF/MLdfUesHOnkWFvSKw2g1mce7DPdZWzV9J6L9GHR5kxcT3bFqk7VJ/vnSuzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(64756008)(91956017)(66946007)(76116006)(66446008)(66476007)(54906003)(66556008)(316002)(8676002)(110136005)(4326008)(8936002)(83380400001)(85182001)(4001150100001)(2906002)(202311291699003)(38100700002)(36756003)(6512007)(6486002)(38070700009)(478600001)(53546011)(86362001)(122000001)(6506007)(41300700001)(71200400001)(5660300002)(26005)(2616005)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXJ1WXFydHNPZk1Cc2hNeXlHWjdqSFR1dzU3a1UzcDlIWlpkZTZnT1QvMkd6?=
 =?utf-8?B?a0o0eDdqekxNVG1zN2Nva3FoaFhTZ2twYmtXVzNXTEYzeTcvQXk1RExFS25U?=
 =?utf-8?B?ZjVGQjBmeVRpUmJjemRpRG15VmdpNU5lZVV3V2FpcCt1MVJWakp5bnRkcFVI?=
 =?utf-8?B?dkE2b296T3I1enFXVWFWMDFCeXdOTTlvdWRmeU1BQjRDV2c5aDFIS1V0Tjla?=
 =?utf-8?B?TU5IVk13Y2VrYWRCVXZHa2dQa21wMXlycktLaWZsWkRDMkdaUXZPNnpocGxa?=
 =?utf-8?B?c2xRUTl3YjM1WmUyV3pPU0EzZXpRZng4VFdsTTNvK0sxdmxiK3NQdmQrT2tt?=
 =?utf-8?B?VmtDZnFvRitmS3d6a1ZTb0RCY3R1ejVOZHVJN1hQd1JnOFg5VU81eXRINjQz?=
 =?utf-8?B?dEVnNjVNWDhBNTdCV1NldTVjQXN0VWVsZEZoVzA3RUZxaDluc2xjdWQwUzlk?=
 =?utf-8?B?dVZ0ODZ1c2hyRitoL0I5WktOY01hZ215T1diZEdYQ0doWlNGRlFIb3dvVEZa?=
 =?utf-8?B?QzVqYklkT2hYQWtVOG1JMVJQSnJoNnErRkZ3cFJNTzRSeDQxOVlMLzJIVVZS?=
 =?utf-8?B?R0RPbnJLTWJkUUsrbTdEZ0QrVGpWMlMxQVBOcUIvZmpMYVdQS3g5TG9iWE0w?=
 =?utf-8?B?UW1haWlKcjBTVk9ZSkdTZDFTWXNIdlNjaDJQa3BHN3lENkJEU04xZ1RGMGY0?=
 =?utf-8?B?TDl0azN1R01oYmdkMmdlMndWbjFVb3E3cDJpdTl1Si9hOE03NVBWQjRzbFRj?=
 =?utf-8?B?VlB2Q2p3bzN3QmVjOUJXVkZFekszWE1UNDFRa2JlVEJ2TjFDem5XdUdmVjVE?=
 =?utf-8?B?Njh3c01CLzlOcmpnNmErUTFUQU5nMmRMVmVEbjdXWm5ZQnZ1QndUVXBTRjY4?=
 =?utf-8?B?Z2dQUFZ3R1AxVDJoYmU5RzlZVWExRXRWVHFORjNRNmVqajhlbjBjWVdNa1Zx?=
 =?utf-8?B?MWZFSnpEeTgvV0xmdGJ6NThNYndtSVZiMzdXczYvdllZbWVYWlc3M2ZRdmtZ?=
 =?utf-8?B?SVQvOFRKVXZYdTRzdlFIREhwazBjdlJZQk5Na3pHaC9SVGlHRXVMUDdQbHl4?=
 =?utf-8?B?ODU3VXhuRDEvT1h6d1pJRUplMXN3Z1hpdUZWOWJjR3RzWVI4QWRTN2RwSllM?=
 =?utf-8?B?WW1NSHdXZ2hmWXBGVHVXUTQ0WDZaeEFHazlITklQeFVoTlFGTWc1ZnFZZzVv?=
 =?utf-8?B?dlB0MWQySVZFcHlWVUlHRkMxcE1SbVVnellSNGhsaHZDdnlyQnVWZWI5YWVi?=
 =?utf-8?B?akUzVDJuRmtJSU1PVUVHdFM3YlVjcmxZRjNYRWpwYnc2N1J3NHBXQ0pqSnEw?=
 =?utf-8?B?VDRjdWtYdEtyUWh3c1MwaWdudjAxZ0ZEUlRmbUplY21Pa3lMMUMyVkQrN0Z6?=
 =?utf-8?B?aDRXQXIvN3lBbVE4dnk3Q1ZjSkh3bjcxQWh1ZlpkODZHdm9uc09LaU9TcWlH?=
 =?utf-8?B?OGxTRStjT2Y4ZWFRVnpRUUV6Zm5kb1Rubmo4NTRsOUErM3FhY1ZjRW00OE1G?=
 =?utf-8?B?b2Q3MXRPTzkzWDRla1g1Z0cwdGN3SU9RZ1hyNUR6cFE3Tm9xYk5Rd1VVYlhj?=
 =?utf-8?B?Z1FaR1RGWFlTM2hsR1U5UWhxRXFReGxOYkZlb1dBMU9pZTNDZnFUU1hRUUNq?=
 =?utf-8?B?N1RzZTNvY09GcnNoRUhSemJ3bndyMlA4WDNtSUh5NzhjYi9ZSEo0ZjN0UzNR?=
 =?utf-8?B?R2MwZHdnMDVaeE1TREllZk13NjI0ZFN3b3IrcDJYeXlLaVRrUEt4WlhialNT?=
 =?utf-8?B?bXViWllsTzRjRGF3MmdjbkZuSHJra28wWHhoYjNkMEcxM0FkdlFtYm1MNk15?=
 =?utf-8?B?S0hnR1dOS0ZGdHZQWVJqdEFCeXQzRTFXSUdPOWpIRUh1b1FTNm9VQXBlT2I5?=
 =?utf-8?B?dWZGTHZ4bUg2SlpqNHJjWGdiQmNJWURtMFBQdHNEbmFXMTl1V1FhNWxzMkVB?=
 =?utf-8?B?WnRWRWxVOXVHeGt3TEp1SjloQW5Kb1lXNEFqYTd6WUZXdkhqdThSY0svbUhh?=
 =?utf-8?B?QzA0ZTlEcWIzL3hMMlpSUFgxL0I0VzZaSU9zZlRNbDdFcGtEOWZCQlhOVDhY?=
 =?utf-8?B?UDQ4RmRJWlQyR29ZVXZjZ0JWZWxiQ3ZZQ1RXOE91QnVzMUZxWERQZkxQdjFz?=
 =?utf-8?B?TzNnSEVsMUJxMGVEY0w4TWNDVFFRUDV5UkVkR0xCQThuWVlzdHd4RXloa2Rl?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAAE7A2D2FE3DF40A26731185BA70111@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1f40cd-1ce6-42ae-5fdc-08dbf146e5a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 01:51:40.5995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyr5z+VOEM0fnhLigNyrAC+TV5yS23a7mMmFBKDPQz7u7D8wy8ycQ2tv8o26oaUvwxOEdpbaCFQXwgj1YGeAjeYANcwKq5ltk1JekqNC6a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6495
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--34.046300-8.000000
X-TMASE-MatchedRID: CML2QBp/u5TUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4/n0eNPmPPe5KWz
        WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2mlaAItiONP1RnscLnNAC7Nvpj5+dNlQvMC/
        K/e26+Q0tIcNCL+1lT4IDpXRi97xlDcy28oDHlwJc/msUC5wFQX5ErfRqpilVZ5yuplze9psVWT
        DhfTuSaNoUzlM8Yt0I0wOo8Q6y8JusVSjuVu0TEENTnAhL0/m3HznaOB9+eYio+b+yOP0oGEDH7
        fYNhjWYpLHkqMumMNqfJm8PXdmqu4qtuuQ+CE7v98sqn8kK3uGyNcEJTKJGJs2mvbig5LjG8Z5E
        7FtTRPZCBxbVTmCgug4BODg3LBohOzEyQBr3GYwSEYfcJF0pRYEcpMn6x9cZ8Ule2AXgYUvppfx
        NgiuPW6uGnr8dTBKw72n23NsrtG7zLVZFOZrw3uv8QGaI25e3GK57kZ/2mameLRPBGqw/vqKAzl
        CenXuFl9EADa9mjM5akpdOW1kgxXOUemoddxuVE0Q83A2vD+s5SAOCkuqVt9W0BaT1GcXqGNtH9
        cKwddYQ2TsKZmZguDvpMjHksKcLSSOWVJeuO1DSBVVc2BozSlkMvWAuahr8+gD2vYtOFhgqtq5d
        3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--34.046300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 78347600CF0BAB8561205D3365B10D339056CE020A764DFA84BC75E3E778B1FD2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTI3IGF0IDA4OjIxICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDI3LzExLzIwMjMgMDg6MDksIE1hY3BhdWwgTGluIHdy
b3RlOg0KPiA+IE9uIDExLzI1LzIzIDE4OjM3LCBLcnp5c3p0b2YgS296bG93c2tpIGFuZCBDaHVu
ZmVuZyBZdW4gd3JvdGU6DQo+ID4+IA0KPiA+Pg0KPiA+PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFz
ZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbCB5b3UgDQo+
ID4+IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPj4NCj4gPj4g
T24gMjUvMTEvMjAyMyAwMjoyMywgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+Pj4gRHVlIHRvIHNv
bWUgb2xkIFNvQ3Mgd2l0aCBzaGFyZWQgdC1waHkgb25seSBzdXBwb3J0IGZvcmNlLW1vZGUNCj4g
c3dpdGNoLCBhbmQNCj4gPj4+IGNhbid0IHVzZSBjb21wYXRpYmxlIHRvIGRpc3Rpbmd1aXNoIGJl
dHdlZW4gc2hhcmVkIGFuZCBub24tc2hhcmVkIA0KPiB0LXBoeSwNCj4gPj4+IGFkZCBhIHByb3Bl
cnR5IHRvIHN1cHBvcnRlZCBpdC4NCj4gPj4+IEJ1dCBub3cgcHJlZmVyIHRvIHVzZSAibWVkaWF0
ZWssc3lzY29uLXR5cGUiIG9uIG5ldyBTb0MgYXMgZmFyIGFzDQo+IHBvc3NpYmxlLg0KPiA+Pj4N
Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9waHkvbWVkaWF0ZWssdHBoeS55YW1sIHwgNg0KPiArKysrKysNCj4gPj4+ICAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdA0KPiBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdHBoeS55YW1sDQo+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0cGh5LnlhbWwN
Cj4gPj4+IGluZGV4IDJiYjkxNTQyZTk4NC4uZWVkYmE1YjcwMjVlIDEwMDY0NA0KPiA+Pj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0cGh5Lnlh
bWwNCj4gPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVk
aWF0ZWssdHBoeS55YW1sDQo+ID4+PiBAQCAtMjM1LDYgKzIzNSwxMiBAQCBwYXR0ZXJuUHJvcGVy
dGllczoNCj4gPj4+ICAgICAgICAgICAgU3BlY2lmeSB0aGUgZmxhZyB0byBlbmFibGUgQkMxLjIg
aWYgc3VwcG9ydCBpdA0KPiA+Pj4gICAgICAgICAgdHlwZTogYm9vbGVhbg0KPiA+Pj4gIA0KPiA+
Pj4gKyAgICAgIG1lZGlhdGVrLGZvcmNlLW1vZGU6DQo+ID4+PiArICAgICAgICBkZXNjcmlwdGlv
bjoNCj4gPj4+ICsgICAgICAgICAgVXNlIGZvcmNlIG1vZGUgdG8gc3dpdGNoIHNoYXJlZCBwaHkg
bW9kZSwgcGVyZmVyIHRvDQo+IHVzZSB0aGUgYmVsbG93DQo+ID4+DQo+ID4+IEkgc3RpbGwgZG8g
bm90IHVuZGVyc3RhbmQgd2hhdCBpcyB0aGUgImZvcmNlIG1vZGUiIHlvdSB3YW50IHRvDQo+IHVz
ZS4gV2hhdA0KPiA+PiBtb2RlcyBkbyB5b3UgaGF2ZT8gV2hhdCBhcmUgdGhlIGNoYXJhY3Rlcmlz
dGljcyBvZiBmb3JjZSBtb2RlPw0KPiA+Pg0KPiA+PiBBbHNvLCBwbGVhc2UgcnVuIHNwZWxsY2hl
Y2suDQo+ID4+DQo+ID4+IEJlc3QgcmVnYXJkcywNCj4gPj4gS3J6eXN6dG9mDQo+ID4+DQo+ID4g
DQo+ID4gVGhhbmtzIQ0KPiA+IA0KPiA+IDEuIEkndmUgdGVzdGVkIHRoaXMgcGF0Y2ggYW5kIGl0
IGNvdWxkIHNvbHZlIHRoZSBjbG9jayB1bnN0YWJsZSBmb3INCj4gPiBYSENJMSBvbiBtdDgxOTUg
b3IgbXQ4Mzk1IGR1cmluZyBzeXN0ZW0gYm9vdCB1cCBvciBkdXJpbmcNCj4gPiB1bmxvYWQvcmVs
b2FkIHRoZSBwaHkgZHJpdmVyLg0KPiA+IA0KPiA+IFRoZSBlcnJvciBtZXNzYWdlIGhhcyBiZWVu
IGxpc3RlZCBhcyBmb2xsb3dzLg0KPiA+IA0KPiA+IFsgICAxMy44NDk5MzZdWyAgIFQ3Ml0geGhj
aS1tdGsgMTEyOTAwMDAudXNiOiBzdXBwbHkgdmJ1cyBub3QNCj4gZm91bmQsIA0KPiA+IHVzaW5n
IGR1bW15IHJlZ3VsYXRvcg0KPiA+IFsgICAxMy44NTEzMDBdWyAgIFQ3Ml0geGhjaS1tdGsgMTEy
OTAwMDAudXNiOiB1d2sgLSByZWc6MHg0MDAsDQo+IHZlcnNpb246MTA0DQo+ID4gWyAgIDEzLjg1
MjYyNF1bICAgVDcyXSB4aGNpLW10ayAxMTI5MDAwMC51c2I6IHhIQ0kgSG9zdCBDb250cm9sbGVy
DQo+ID4gWyAgIDEzLjg1MzM5M11bICAgVDcyXSB4aGNpLW10ayAxMTI5MDAwMC51c2I6IG5ldyBV
U0IgYnVzDQo+IHJlZ2lzdGVyZWQsIA0KPiA+IGFzc2lnbmVkIGJ1cyBudW1iZXIgMw0KPiA+IFsg
ICAxMy44NzQ0OTBdWyAgIFQ3Ml0geGhjaS1tdGsgMTEyOTAwMDAudXNiOiBjbG9ja3MgYXJlIG5v
dCBzdGFibGUNCj4gKDB4M2QwZikNCj4gPiBbICAgMTMuODc1MzY5XVsgICBUNzJdIHhoY2ktbXRr
IDExMjkwMDAwLnVzYjogY2FuJ3Qgc2V0dXA6IC0xMTANCj4gPiBbICAgMTMuODc2MDkxXVsgICBU
NzJdIHhoY2ktbXRrIDExMjkwMDAwLnVzYjogVVNCIGJ1cyAzDQo+IGRlcmVnaXN0ZXJlZA0KPiA+
IFsgICAxMy44NzcwODFdWyAgIFQ3Ml0geGhjaS1tdGs6IHByb2JlIG9mIDExMjkwMDAwLnVzYiBm
YWlsZWQgd2l0aA0KPiBlcnJvciANCj4gPiAtMTEwDQo+ID4gDQo+ID4gMi4gVGhpcyBpcyBhIGZp
eCBwYXRjaCB0byBYSENJMSBzaW5jZSBNVDgxOTUgaGFzIGJlZW4gdXBzdHJlYW0uDQo+ID4gUGxl
YXNlIGFkZCAiRml4ZXM6IiB0YWdzIGFuZCAiQ2M6IHN0YWJsZUBrZXJuZWwub3JnIiB0byBiYWNr
IHdhcmQNCj4gPiBwb3J0aW5nIHRvIHByZXZpb3VzIHN0YWJsZSB0cmVlcy4NCj4gPiANCj4gPiBG
b3IgZXhhbXBsZSwgYWRkDQo+ID4gRml4ZXM6IDZiNWVmMTk0NjExZTUgKCJwaHk6IG1lZGlhdGVr
OiB0cGh5OiByZW1vdmUgbWFjcm9zIHRvDQo+IHByZXBhcmUgDQo+ID4gYml0ZmllbGQiKQ0KPiA+
IGlzIHN1Z2dlc3RlZCBzaW5jZSB0aGUgZm9yY2UtbW9kZSB3YXMgbWlzc2luZyBpbiB0aGUgcHJl
dmlvdXMNCj4gPiBpbXBsZW1lbnRhdGlvbiB3aGljaCBjYXVzZXMgaGFyZHdhcmUgZnVuY3Rpb24g
d2FzIGFibm9ybWFsLg0KPiA+IEhvd2V2ZXIsIGFkZA0KPiA+IEZpeGVzOiAzM2QxODc0NmZhNTE0
ICgicGh5OiBwaHktbXRrLXRwaHk6IHVzZSBuZXcgaW8gaGVscGVycyB0bw0KPiBhY2Nlc3MgDQo+
ID4gcmVnaXN0ZXIiKQ0KPiA+IHdpbGwgYmUgYmV0dGVyIHNpbmNlIHRoZSBVU0Igc3VwcG9ydCBm
b3IgbXQ4MTk1IGlzIGFscmVhZHkgZW5hYmxlZA0KPiBpbiANCj4gPiBsYXRlIDIwMjEuDQo+ID4g
DQo+ID4gMy4gSG93IGFib3V0IHdlIHJldmlzZSB0aGUgZGVzY3JpcHRpb24gYXMgZm9sbG93cyBm
b3IgbW9yZQ0KPiBwcmVjaXNlbHk/DQo+ID4gDQo+ID4gbWVkaWF0ZWssZm9yY2UtbW9kZToNCj4g
PiAgICBkZXNjcmlwdGlvbjoNCj4gPiAgICAgIFRoZSBmb3JjZSBtb2RlIGlzIHVzZWQgdG8gbWFu
dWFsbHkgc3dpdGNoIHRoZSBzaGFyZWQgUEhZIG1vZGUNCj4gPiAgICAgIGJldHdlZW4gVVNCIGFu
ZCBQQ0llLiBXaGVuIGZvcmNlLW1vZGUgaXMgc2V0LCB0aGUgVVNCIDMuMCBtb2RlDQo+ID4gICAg
ICB3aWxsIGJlIHNlbGVjdGVkLiBUaGlzIGlzIHR5cGljYWxseSByZXF1aXJlZCBmb3Igb2xkZXIg
U29Dcw0KPiA+ICAgICAgdGhhdCBkbyBub3QgYXV0b21hdGljYWxseSBtYW5hZ2UgUEhZIG1vZGUg
c3dpdGNoaW5nLg0KPiA+ICAgICAgRm9yIG5ld2VyIFNvQ3MgdGhhdCBzdXBwb3J0IGl0LCBpdCBp
cyBwcmVmZXJhYmxlIHRvIHVzZSB0aGUNCj4gPiAgICAgICJtZWRpYXRlayxzeXNjb24tdHlwZSIg
cHJvcGVydHkgaW5zdGVhZC4NCj4gPiAgICB0eXBlOiBib29sZWFuDQo+IA0KPiBBZ2Fpbiwgd2hh
dCBpcyBmb3JjZS1tb2RlPyANCk91ciBERSBkZXNjcmliZSB0aGlzIGJlaGF2aW9yIGFzIGZvcmNl
LW1vZGUsIGFzIHlvdSBzZWUsIHRoZSBkcml2ZXINCnBvd2VyIGRvd24gY29udHJvbGxlciBhbmQg
cmVzZXQgcGlwZSB0byBzZXQgdGhlIG1vZGUgZGlyZWN0bHkgd2Ugd2FudCwNCmJ1dCB1c3VhbGx5
IHRoZSBwaHkgY29udHJvbGxlciBzd2l0Y2ggdG8gdGhlIG1vZGUgYXV0b21hdGljYWxseQ0KYWNj
b3JkaW5nIHRvIHRoZSBleHRlcm5hbCBzaWduYWwsIGUuZy4gdHJhcHBpbmcgcGluLCBlZnVzZSBl
dGMuDQoNCj4gSXQgbG9va3MgbGlrZSB5b3Ugd3JvdGUgYmluZGluZ3MgZm9yIHRoZQ0KPiBkcml2
ZXIgYmVoYXZpb3IuIEJpbmRpbmdzIGRlc2NyaWJlIGhhcmR3YXJlLCBub3QgaG93IHRoZSBkcml2
ZXINCj4gc2hvdWxkDQo+IGJlaGF2ZS4gVGhlIHByb3BlcnR5IG1pZ2h0IGJlIHJlYXNvbmFibGUs
IGJ1dCB5b3UgbXVzdCBkZXNjcmliZSBoZXJlDQo+IGhhcmR3YXJlIGNoYXJhY3RlcmlzdGljcy9p
c3N1ZS9ldGMuDQo+IA0KPiBBbHNvLCB5b3VyIGRyaXZlciBjaGFuZ2Ugc3VnZ2VzdHMgdGhpcyBp
cyBjb21wYXRpYmxlIHNwZWNpZmljLCBzbyB3aHkNCj4gaXQNCj4gY2Fubm90IGJlIGRlZHVjZWQg
ZnJvbSBjb21wYXRpYmxlPw0KdGhhdCBpcyBiZWNhdXNlIG9uIHRoZSBzYW1lIFNvQywgc29tZSB0
LXBoeSBzdXBwb3J0ZWQgVVNCMyBhcmUgc2hhcmVkDQp3aXRoIFBDSWUsIGJ1dCBvdGhlcnMgYXJl
IG5vdCwgdXNlIHRoZSBTb0MncyBjb21wYXRpYmxlIGNhbiBub3QNCmRpc3Rpbmd1aXNoIHRoZW0u
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg==
