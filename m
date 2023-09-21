Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131DB7A96A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjIURHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjIURGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:06:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DACD1711;
        Thu, 21 Sep 2023 10:04:44 -0700 (PDT)
X-UUID: 12320f1e584111eea33bb35ae8d461a2-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=z+jhFgoSQBfuy8fwJh8qvmYCf9YZUZhByGUBfi4c5nQ=;
        b=sHVlz0+AzYNaovxu01/OMu+6ihRXF5Mxdcxcd+keufidqCEDKH/XIWXhB6evaoffmP2T8LpqiwAksfzVkitR1b1zHV1E9IJH3LNQr+qTys7QMP9yz3IfrJK+vItsqbepEEtYkN7WmtcnboX8wbcatBvhGyVwJBDsLBxvQpu07NM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2ee5fc8e-adbf-469f-99ef-c854a0fa63ec,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:f86617bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 12320f1e584111eea33bb35ae8d461a2-20230921
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 480200078; Thu, 21 Sep 2023 13:38:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 13:38:18 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 13:38:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvmWRKCKXV61bNzL6e+FbtKYawOoain0XzxVsOS6YSq0Cgcv6fZTlATAMnx68FjLiwy+eWRvL0JknmWEwx+E+QBIdVQCRBCYyBbQ51Z9iqWGR+BjV47kA9bz+z3cluo4JU63yaZN02N/h75nEyhIKO7ipXGOUUU+jpzLqqjQVZ7DAZ1aot5OpRzdF5X04vK9K1chl5n5fr36XAUaQ7XgbMRT98c4dfQSndyW1z4/ydUthXhQKTd+XQUgy1rtlnrABtxhvqzDiPjWJAaoc8hbcJGCi7Tquh90LbZwtEcopSXeIjsJCVLPWn+SR8eF725gFF+YswYcI0iyfYB78lRAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+jhFgoSQBfuy8fwJh8qvmYCf9YZUZhByGUBfi4c5nQ=;
 b=iZd6S+0hLbQkKDB9wB9+gMsKNgFYAG2UV2Au7QxR0uB9h6a3wxEnhoo2S6hqXgNaDcL2EQBMHIwf3PlNpcNk/sDYZC3AAoa7C85z8x3zxYhdgAWeh0WZf/nOntb0BK+bsfn1VeFTO8WGNanOiyMKIH8t5gj6gJ46ibb1/EQ2CHIZ1rQNyaq6scLNiK9ZwzHFzRWKjhZoiU28ANkcWVv+yAzDSwp1lLN1OWUBDjbkDbSeYoL88Qntx5atSpX0PDRMO89aGG1U8+d+fnqs459OsvARH2qSGu3mhA/U0+8ykBryP/2pCKs9dL4/JpMrxaQoKlYDhYd0UCuPd8nd5crZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+jhFgoSQBfuy8fwJh8qvmYCf9YZUZhByGUBfi4c5nQ=;
 b=Ssq4BwPEwo9PKcB9X5X3WpRk80RgYussGL9rBY06nus6wOFczDMehAc1PIBWGGt6zIe5pHpBjrseKe0drLIhskFRYshEcIRv2st290HFU/+nKq4yEGR+SMpo7aONniDiKONUqoCcti53bYji8WWDlJlk+tgGYqTNq1fh3MRpiG4=
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com (2603:1096:301:40::11)
 by TYZPR03MB5728.apcprd03.prod.outlook.com (2603:1096:400:8b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 05:38:16 +0000
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::fb21:1c1a:678:fbfd]) by PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::fb21:1c1a:678:fbfd%3]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 05:38:16 +0000
From:   =?utf-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?= 
        <Chun-Jen.Tseng@mediatek.com>
To:     "fshao@chromium.org" <fshao@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 2/2] soc: mediatek: svs: add support for mt8188
Thread-Topic: [PATCH v3 2/2] soc: mediatek: svs: add support for mt8188
Thread-Index: AQHZ6pr4zcsq7puX3U6jyOm98/AG5LAh+ZsAgAAdVgCAAQ8DgIABoHiA
Date:   Thu, 21 Sep 2023 05:38:15 +0000
Message-ID: <3ef9d7ea30d011e2bbb49d1c6d57ffdf14eb7e95.camel@mediatek.com>
References: <20230919014439.5795-1-chun-jen.tseng@mediatek.com>
         <20230919014439.5795-3-chun-jen.tseng@mediatek.com>
         <0009f224-aac4-6681-fde5-cf1ead94c604@collabora.com>
         <acd2cba7db6d4e523f84fa4725e9bd6b596023ba.camel@mediatek.com>
         <CAC=S1ng5wkZa6LzASUNDW9miG_ev7FGhw_8Xumom4y0oy3QN0w@mail.gmail.com>
In-Reply-To: <CAC=S1ng5wkZa6LzASUNDW9miG_ev7FGhw_8Xumom4y0oy3QN0w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5351:EE_|TYZPR03MB5728:EE_
x-ms-office365-filtering-correlation-id: 241202dd-6a93-4f8c-c079-08dbba64f443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /dyZbyrBtVVv9CAObFGj1w6nsEB/PQqhsqUW77M++MLNGxTFofkUlYcJYeWeq03n1AbU6WwyeMXg+d+bCUusaUKdqjvHpIiXSoXh5pDo5aWZc3c1DTbGXdCsauKNUk8QBRzB0fMUHrR5sAe7/Q/ZH6jGg8WsEbfn2CZM5gJYWz1bsFXxOh2aD+rmeGasNxpArC/i3JFZfGoTYG33CjOkMaLVZY6BpgfiTzsVmZ3+43TwmuPq9l2w0TwRijUpGnAZq3oVWdfw7wDhn3jGdWSDJBi6aOTzrsaEpdR7URJNlbYMXR4gwy+pP4kKruk2c7cYYoCBVyQAHafNYCyTr00k3A2clz9KC5RH2TQ9GMBwIlkGc5WpG87cJlUarzmHqS4K/bw8KPxC0VLzkQrKki9hgUO00t6rKWTTxUMR9DhmgTfiK/wMlQHhUdDRwv6bodb+qYbfuAEwYgzSDJSpGSzZBMZIjuBy1mqtdCM94BJHZW2ev4XzhVlxpvg5kvoVALiSp2fUj0nf8KlvS5aFB9IMbA8s1fA7qiLSJoSJYZldZPijZexlKIg32aRGpiylV7+aYY06L61SR0c6fFwwv71Mzsg8sCaSCcAEGbklbBzJPEjIzHDz90MxgOhFIy0MRPaFY7fsdDpZwHPLM/HxX487VVdQ11N+9sY7l4ErFdvV80Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5351.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(1800799009)(186009)(451199024)(66476007)(66446008)(41300700001)(64756008)(66556008)(316002)(66946007)(76116006)(8676002)(54906003)(4326008)(122000001)(6916009)(53546011)(6486002)(478600001)(6512007)(71200400001)(8936002)(83380400001)(6506007)(91956017)(26005)(2616005)(86362001)(2906002)(7416002)(5660300002)(38070700005)(38100700002)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1N0alhSY0hOZ2l5UXVuMTdxTTBhU214dy84NmxqUDkzRXM4a3lOU3dFYTlD?=
 =?utf-8?B?Y09IYWZSMk1YZWpZUnptQUZVRnU0bnVQZkxCekJXU1QzWERSQ1F1R0s3eWNo?=
 =?utf-8?B?bTNGQUJHdGdQQ1d2Vm8xZzVIU0ZXZ3VrNDd0d2pOMzNvMjh2L3NsdGZPeVpT?=
 =?utf-8?B?ck5ZcHdYb1lneENjZ01CWldiU1JUeU0vQjdVcDlON2dhQmNSdDRWOStNN2ZZ?=
 =?utf-8?B?OHJCZmRWMUdqMUJXVGlZd0hTa096T0x6MjF5VlVFcW85aFlTc2FGYThrTjhD?=
 =?utf-8?B?N0tjRnF1eDJPKzlrdHlZdGhCVDBRT25leWR0bmpuYXcvY1FLeGtxVjBXcEVR?=
 =?utf-8?B?c0U3eldZazRhbDNNbDdzWWs4MkxiMjFwT0VneVZ0dUZtYzBOSTFBbXUxUVlF?=
 =?utf-8?B?SzZvQTQ0MWV4ajg0RjlLZDRWRlZpTENleDZ4eFQxeXI5S3BVZU9ZOHR5Qm5q?=
 =?utf-8?B?KzN1eUJoa1FsZExXZlluWkV4ZnltS0Izemt6YW5XM3JEMGRYTVhoTitvRWJ2?=
 =?utf-8?B?VTJEWi9qa3VnTWE0eTlldmtYUjZ3U09OQlhrcHI4UGFyVmZnMEhzbHlDSXVN?=
 =?utf-8?B?ZmJBYUpadC8xU2NaQ3lxdUFLMlRaTkhXZnowVkFKZkZ1Y1NoWHBpdGpqS1Z6?=
 =?utf-8?B?c0dPTmNnR1h2bC9IZFRnQkZENHIvWi81a3p0UFJObE9ZakVrOG13YjhkS0Ft?=
 =?utf-8?B?Q2FnV09hQkx5YU1DT1F6UnRsWGNxQUFIb1Yvamx5cUphVGhZbkdTK0V0V3Y5?=
 =?utf-8?B?cGU0YW5CUXhOVUxsVG9BTHA3cjFFTnlQU1JGZnNjazl1THNJK29pY2QzVjhM?=
 =?utf-8?B?YkVPalF4R1c1bW5KcHRRUGpDa0tNcU1RcUc3QVdHV3FsQXlXVHVNWUE5bE1j?=
 =?utf-8?B?N2NBa1BPRXpIWlVuZXc1dkl1VTdLODFiOWlMNnM1VW9WWmJMNENaS2E5TWt6?=
 =?utf-8?B?S21uWW1QTE5YMTgwdStyZHdmVXlpQkhFaUE3VVdQQnFXNnlsaXd1amJucmhr?=
 =?utf-8?B?cDRLaHF2Mlc0cEVzS2l5SzFxc3ZPQ1ZFaVRtOGxzTWgydkF5eHFYZ0VXOHVY?=
 =?utf-8?B?WUVKS1RXd09tM2NjMWFpMjBmZk9Cb05hMTBzV3ZEZ3EvV1ovelhlTjBHKytO?=
 =?utf-8?B?U0FjSTlzZFgvSGxRTjVSZ1FlUGFUbTBnYVpiTzNFRkpFWnpZTWNLSFRTVVZ4?=
 =?utf-8?B?eTd0MEhpcGZtalkyYVo0T3F2bmZXSEhDblNzZUsxWk9HVWtxNW9FU2dLNzVl?=
 =?utf-8?B?Mlh5RXVETHRJbUpyT2VoQjBnSFBrcnlnRHgzeXllWXJwRysvTW1hTitGVEdO?=
 =?utf-8?B?cXZIR3c2MUxvcWt2QndjTTlWc3VXMFg4SXRaMHFZdFcyVHE2T1ZGZ0tURHB5?=
 =?utf-8?B?bjVLODVaU2VSaEh0aWZhVXdMRno3K1RFWmpIZnY1UVo5dnRUZ0dTTDNzSENU?=
 =?utf-8?B?dEo5dlllcFY1TDZ1YXovZkVpWitSR1d4dTVoYzZWQ3ZWMldpK1RncXY3cjYy?=
 =?utf-8?B?N2VuOXlIL1Rwcm5oekE0Z2VZWlkzZTUvTTROWW9HeGh1SUF4U0w2dWVXMVZG?=
 =?utf-8?B?TXRiZTBxMlFWOVE2dTRhS0twTEdSMStYY1FpWTdPYUlFU0Nkb1hOL0txRGdT?=
 =?utf-8?B?bjNXVmhGSHZlcE9xUlB4UFpwN0hFT2NEcE91SlhoVENpT0RMV3NaNTFiQVUx?=
 =?utf-8?B?ZnM1VzdMQUVoSlpNdm5lVnkvYUtSMDBEcWJSNkNraXZCc3JwY0pZbTdKUVgz?=
 =?utf-8?B?TjZ4Z2UvZllXWTB3bEpqclJwZTYrWElHaWNQL3NJZkZGYXBXVXBteUpNc2NN?=
 =?utf-8?B?SWtWUWdrVmRpSi8rQUU0QXUzVFNhT081UGVBWnpEb1ZGNUNUcWxjTW5MbjVF?=
 =?utf-8?B?QUFoU3N6eXEwV1Rvdkx3c21IWlUvRnNzWHQvN1NrK2dCTExUaTZFaGtGc0tK?=
 =?utf-8?B?M2xReGpVQW5QMzFxMDRTREhDS0V1Y2VWSElqU25TSHNtbFNCNXVMU0R0N0Vk?=
 =?utf-8?B?elRwdDFWUEZoYWtCazNUa1FDL3ZucURaY1dWcGF5YkFqSXdCaFBIT2pOVzMz?=
 =?utf-8?B?c2p5d2dsODJCbzJEeHBHdTM0TjRlK0JiMWEzQmtLeFhLVW5YUDEyN0FIVHBU?=
 =?utf-8?B?dG4zamlWRWNHNExNV0xqYXQyN3VTY2VBeWJJckFSbG1SNmJqM1ZwaGE0STZO?=
 =?utf-8?Q?BIdYt4YgXyUDN0rkkKhs6mM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E78453CB1804B545B4EADC1035730275@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5351.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241202dd-6a93-4f8c-c079-08dbba64f443
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 05:38:16.0237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hf3D3F3E2js5uJEHFMSB/krIQ2Lb4UYqP943U+Dn43BEL2xiqdkQuIskFvgSmCTFs0D23060X0TGOrShnyaLmmaffxumet+vsOHUFvCqqM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5728
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.312600-8.000000
X-TMASE-MatchedRID: Q8pJWSpPf0PUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
        CsGHURLuwpcJm2NYlPAF6GY0Fb6yCq8zqdV7d9lTmlaAItiONP1ai3lnXr67vgQCU+LQ7n5McDY
        BtqUkx7xkrFkfWkEG0GaUgtPxhg/OLaseLy1WdxYS7luGt6tlhr4Vw8Fss5K+IFBEE5CFomLmc1
        fhycWNwvVMhKhdtCQXiK4tTmf2YQMYkHOTosTds39NanCUA4VeWuFm7TqL4eHVrrSePZucEhG59
        Y7tVhgxFiZzivkiLNnf/TNhJ52n1pH0YXYnbGoz0gVVXNgaM0qcIZLVZAQa0PxXvvKElGCjq7rF
        UcuGp/G8QIu4z6HhEH7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.312600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8AAE5079F760FC5E49FCD371F348A871907A94AFF41B97D364BB97F0A08962872000:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA5LTIwIGF0IDEyOjQ3ICswODAwLCBGZWkgU2hhbyB3cm90ZToNCj4gIAkg
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+ICBIaSBNYXJrLA0KPiANCj4gT24gVHVlLCBTZXAgMTksIDIwMjMgYXQgODozOOKA
r1BNIENodW4tSmVuIFRzZW5nICjmm77kv4rku4EpDQo+IDxDaHVuLUplbi5Uc2VuZ0BtZWRpYXRl
ay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVHVlLCAyMDIzLTA5LTE5IGF0IDEyOjUyICswMjAw
LCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiB3cm90ZToNCj4gPiA+IElsIDE5LzA5LzIz
IDAzOjQ0LCBNYXJrIFRzZW5nIGhhIHNjcml0dG86DQo+ID4gPiA+IE1UODE4OCBzdnMgZ3B1IHVz
ZXMgMi1saW5lIGhpZ2ggYmFuayBhbmQgbG93IGJhbmsgdG8gb3B0aW1pemUNCj4gdGhlDQo+ID4g
PiA+IHZvbHRhZ2Ugb2Ygb3BwIHRhYmxlIGZvciBoaWdoZXIgYW5kIGxvd2VyIGZyZXF1ZW5jeQ0K
PiByZXNwZWN0aXZlbHkuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmsgVHNl
bmcgPGNodW4tamVuLnRzZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+IDxzbmlwPg0K
PiA+ID4gPiArDQo+ID4gPiA+ICsgICAvKiBGb3Igdm9sdGFnZSBiaW4gc3VwcG9ydCAqLw0KPiA+
ID4NCj4gPiA+IEkgYWxyZWFkeSBhc2tlZCB5b3UgdG8gcGxlYXNlIHNlbmQgdGhlIHZvbHRhZ2Ug
YmluIHN1cHBvcnQgYXMgYQ0KPiA+ID4gc2VwYXJhdGVkIGNvbW1pdA0KPiA+ID4gYmVjYXVzZSB0
aGlzIGlzIGZvciAqYWxsIFNvQ3MqIGFuZCBub3Qgb25seSBmb3IgODE4OC4NCj4gPiA+DQo+ID4g
PiBBZ2FpbiwgcGxlYXNlIHNlcGFyYXRlIHRoZSB2b2x0YWdlIGJpbiBzdXBwb3J0IGZyb20gdGhl
IE1UODE4OA0KPiA+ID4gc3VwcG9ydC4NCj4gPiA+DQo+ID4gSGkgQW5nZWxvLA0KPiA+DQo+ID4g
SSBoYXZlIGFscmVhZHkgY2hlY2tlZCAidm9sdGFnZSBiaW5zIHR1cm4gcG9pbnQiIHdpdGggREUs
IGl0IGlzDQo+IHN1cHBvcnQNCj4gPiBmb3IgKmFsbCBTb0NzKiAsIG5vdCBvbmx5IGZvciBNVDgx
ODguDQo+IA0KPiBJIHRoaW5rIEFuZ2VsbydzIHBvaW50IGlzIHRoYXQgeW91IHNob3VsZCBzZXBh
cmF0ZSB0aGlzIHBhdGNoIGludG8NCj4gdHdvLCB3aGVyZToNCj4gLSAic29jOiBtZWRpYXRlazog
c3ZzOiBBZGQgc3VwcG9ydCBmb3Igdm9sdGFnZSBiaW5zIiBjb250YWlucyBjaGFuZ2VzDQo+IG9u
bHkgcmVsYXRlZCB0byB0aGUgIkZvciB2b2x0YWdlIGJpbiBzdXBwb3J0IiBwYXJ0Lg0KPiAtICJz
b2M6IG1lZGlhdGVrOiBzdnM6IEFkZCBzdXBwb3J0IGZvciBNVDgxODggU29DIiBjb250YWlucyBj
b2RlIHRoYXQNCj4gaXMgc3BlY2lmaWNhbGx5IGZvciBNVDgxODgsIGkuZS4gc3ZzX210ODE4OF9l
ZnVzZV9wYXJzaW5nLA0KPiBzdnNfbXQ4MTg4X2JhbmtzIGV0Yy4NCj4gDQo+IEl0J2QgYmUgZWFz
aWVyIGZvciBwZW9wbGUgdG8gcmV2aWV3LCBtYW5hZ2UgYW5kIGNoZXJyeS1waWNrIHBhdGNoZXMN
Cj4gaWYNCj4geW91IGFkZCB0aGUgZ2VuZXJpYyBjaGFuZ2VzIGFwYXJ0IGZyb20gdGhlIHBsYXRm
b3JtLXNwZWNpZmljIGNvZGUuDQo+IEZvciBleGFtcGxlLCBzb21lb25lIHdpbGwgYmUgYWJsZSB0
byBzaW1wbHkgcGljayB1cCB0aGUgcGF0Y2ggZm9yDQo+IHZvbHRhZ2UgYmluIHN1cHBvcnQgc29s
ZWx5IGlmIHRoZXkgYXJlIG5vdCBpbnRlcmVzdGVkIGluIE1UODE4OC4NCj4gDQo+IFJlZ2FyZHMs
DQo+IEZlaQ0KPiA+DQo+ID4NCj4gPiA+IHNvYzogbWVkaWF0ZWs6IHN2czogQWRkIHN1cHBvcnQg
Zm9yIHZvbHRhZ2UgYmlucw0KPiA+ID4gc29jOiBtZWRpYXRlazogc3ZzOiBBZGQgc3VwcG9ydCBm
b3IgTVQ4MTg4IFNvQw0KPiA+ID4NCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBBbmdlbG8NCg0KSGkg
QW5nZWxvLA0KDQpJIGhhdmUgdXBkYXRlZCB2NCBwYXRjaCBhbmQgc2VwYXJhdGUgdGhlIHZvbHRh
Z2UgYmluIHN1cHBvcnQgZnJvbSB0aGUNCk1UODE4OC4NCg0KQlJzLA0KDQpNYXJrIFRzZW5nDQoN
Cj4gPiA+DQo=
