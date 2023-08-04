Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9318B76FAAA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjHDHIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjHDHIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:08:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC0C1713;
        Fri,  4 Aug 2023 00:08:13 -0700 (PDT)
X-UUID: a914a90e329511ee9cb5633481061a41-20230804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=xia3SrCq57VvHpa7awBaY2cHpqhtKg6CObzUU52kMoA=;
        b=cyJS5GvSNVAN64GaKdHh4/BjY06B6XrZRmcuYgTEUs5096KBVwxt5qbDM3KfmVdT0OirNCZKx3dzkRCiqPsDmykqMLX/L2ig5af6ncXHUJUwO+9ARNRfMDnnvhpzgHUSiYZ1TkVhBifZTtwPptOxl29UwkGJx26b0/OAK2r1klI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:2088f903-e8f0-4a81-969a-14d192f18bc1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.30,REQID:2088f903-e8f0-4a81-969a-14d192f18bc1,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:1fcc6f8,CLOUDID:9390add2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:2308041508094G8HDG4H,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULS
X-UUID: a914a90e329511ee9cb5633481061a41-20230804
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1741157137; Fri, 04 Aug 2023 15:08:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 4 Aug 2023 15:08:04 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 4 Aug 2023 15:08:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ2JJcap3bx3Mqqo/bY/vOvIee0hw/XxxFn9iQmpCObWuysYXb1VOsr/1dvV+7ML0kMlCi4+3YtXRTcn6E2XL+7Zms5qrLkr71WPpAOPgAM+5T7pF4u7o9biB+j19OdzvrD1s6Vven1t39rmtldON6NN+FHpRNaTisdiyklqzm70KER1aUvJDCpUFP5+tRB9Wj9kTPYHKdTs9oEZzcp7kUuFiqAjXZH+7UUr5TxGy61hNQl1bWfGGRZbz8peEdZW/5IRc47NoxZOg4u6k6eNlwFVbTFaOSL1AsQyXCwWLoRvHmG0TJ1xTWFv5V/+2aBGD009aD6tyOrdZRB489xQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xia3SrCq57VvHpa7awBaY2cHpqhtKg6CObzUU52kMoA=;
 b=ctc3coahKG02zjUIWOhbBoaC9CYkBnCElkMwdZujk/0tonhw/wndEt9c67NC3mbkwdw1R7X4ypBqdIZf2EXJNmKqYVyO1qDLR5dk9NLOvJkRZ1aGOMW4v7AMko2WPEA+FRogHPf5dF00nU6KVxpI2crziy5qbQ3DkCyoJe98LG7iEF2QzfE4B/UinIXFQrHIfeQLfvFoPIv98Qa9mPEc67dRqM+Hb8UpftwJW6CcTCxTY9OiQZpw/6GAAltepj9FE2mBtVmPuOOK0xKS0fIvMjpy3WRH0D4/S+WDLGF1RAW+DKs3kUMroqt2ZEHmVls+X+gAqfbKDmsCe9zt/9HF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xia3SrCq57VvHpa7awBaY2cHpqhtKg6CObzUU52kMoA=;
 b=sv8fHtnUo4SUCDRRk6lUNZyJvSIlsQj5nbW+Y1uRG2zC8TVAd93TQcObVPwnQnU+uPFLHD6lXaMjZWiNXCwezsSOWb4QZkfSt4PDKwEkx6L6AurwBPxUC8qHns/gIt1XyY0lsFM9UB0ouy1xCS/MofxcvmNxtgKv+fU9F7VZ1C8=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TYSPR03MB7883.apcprd03.prod.outlook.com (2603:1096:400:480::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 07:08:01 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::d040:b1d4:ab0b:b28e]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::d040:b1d4:ab0b:b28e%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 07:08:01 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chenxiangrui@huaqin.corp-partner.google.com" 
        <chenxiangrui@huaqin.corp-partner.google.com>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v3 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Thread-Topic: [PATCH v3 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Thread-Index: AQHZwTM9qZx2VdeqykKSfnhu9XP0Bq/PIWcAgAReQgCAAAv2AIAAcGWAgAXGYwA=
Date:   Fri, 4 Aug 2023 07:08:01 +0000
Message-ID: <2e781d29087b40bdf2c04a1fe11206986ff01ca8.camel@mediatek.com>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
         <20230728090819.18038-6-maso.huang@mediatek.com>
         <7d70f893-ee75-d355-4b4c-4afe7a72cd7c@linaro.org>
         <5f794f6d3595e845433aab3c48eb47ec7962c929.camel@mediatek.com>
         <ab66c8a4-6a5e-651b-8f77-047980ebc238@linaro.org>
         <26224f81-9993-0a4c-4c46-91acd1ff5f42@linaro.org>
In-Reply-To: <26224f81-9993-0a4c-4c46-91acd1ff5f42@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TYSPR03MB7883:EE_
x-ms-office365-filtering-correlation-id: bccb37ec-829f-47ff-0702-08db94b98a8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7PuiB6r92wp17waXZIh2mxIuacuUK7CjmKsGEpAgnOYfkuSFaOMFCb+dk+fQtB6h5m+OsTfUv+lLh9/RO3cZpdkIEB3ATj7epzYSksaZA6ldHTo4bsqYGmRAGpKKtFx50AEimLMPuIwRfp+VJszN+BstBYNGk1Immq/MhlxN4aKgpzn9PEj4HaPmN/C3kuoje6+dPFIQDkYgduUCV8nAIV3vLD1Ote5+gBPmojf3Mu2rgiLUFvhF8Z1xhFaUZnvVjS6PEeQYkeuACzCB0Hbqso3xAmwh7bKM+LwFOEZQrdDjcabI8xGjqTHbwq+dIuP2MvSeJoT3SJ75nnUOvbbtV1d/T6OmFz8dBqJA5TIbGKC6pqCJ12EKgGdjY4b+ZPHWyAiLfi7BZF7u8hBqT9JfFJjPYUmA7AT0wxXJdyO4dIYAbDdEAuulocoEh6txw8O3LqjxtYLZOjwfG/P/Lq+p27H6novIHbYftckWSk8Id5JBfSL4oVx/AnIGCpM2mexcLWnmAob33XhNLzq+QYuHWWMwynJzKlvNxk6eXaGquzUIMr+vKFwaSyUnyKP79aZ3L5WeVfBdFQBc1JtDLEdTr+1L9ocwkfBsYsHOMfWyjsIn2QTl63OZFB+FPzFiOu8JF9wKUMmjBoAVRwO6Rn8psUXYgploZVm8VbWVowkZX3Ewh225nfVcDXr7JSoryYo32t94XGnMe+soXgjAozZeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(1800799003)(186006)(2616005)(2906002)(86362001)(966005)(76116006)(66446008)(6512007)(66556008)(66476007)(66946007)(64756008)(71200400001)(91956017)(6486002)(316002)(36756003)(85182001)(122000001)(478600001)(921005)(53546011)(26005)(6506007)(41300700001)(83380400001)(38070700005)(5660300002)(38100700002)(110136005)(7416002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eS9vK3pVQTNyOEpYdG50Q1V5WnVSYjF0QW5kckZKNHJuRDdGMmhBc3AwYklp?=
 =?utf-8?B?ZnpRaWlMOUY0SkQ2enlQMk8yUm03UDQ2QlVmemd0WjZNTUo0bWNOVzBXVU9V?=
 =?utf-8?B?Y0dKNzh2M1pqaW83ejRKMU81c2VmU1hOOG5kSG5yOWZiUFFVSmVjU0VrWDlD?=
 =?utf-8?B?YXhGNlRMa0ZwR2RjR3g2UTNBaWFHQWZWWkZGa0VRcUpOZFY3OXUrcGs4YzZa?=
 =?utf-8?B?R3JudDMwd1BtODlreXZPaGswSWtNdUN5T0V2NlFkYkJEYmJuZTBIK2RvRjZ4?=
 =?utf-8?B?WjlNWVowUmJ1dFBMeE1YTXA0dnhFc0VNZFE1b1JreCt5QWtaR05Fd2NUWHZM?=
 =?utf-8?B?MFBTVjFNSnNheEZ1ZytGb2FNNU9iMjIya2VyODJpY09JaFNmeUFXbUdPOUJ6?=
 =?utf-8?B?ZDdjWFVBejB3eVdwVExYcHUyWU9MdndTUURPQjgwUVhZdmtQSmpONmZydFNp?=
 =?utf-8?B?WG56QXhMV3hDa1RNT202M01oMVRxTERNTzFqK2tmSzBZMEpVQWFwWGthbm55?=
 =?utf-8?B?YzM0N3VobzB6V1VTTFRiemM3N0tvc1lpVmFlRjU1T1A0dklBWm9GaVR4YjhW?=
 =?utf-8?B?UUZFeE96QlUvNCtpbEZETFVadkMzYmIwYldPZjlRSGxDcEJ1UmRyS2hTeGEw?=
 =?utf-8?B?a0VrYlU4ZlRUUG5QUDZWTkhTNW5lOVpRcGJIdnZYSE8vTHZ3R1lhUFEvQnAr?=
 =?utf-8?B?bTR2cXZFRnB6TUlrMVdoNXJZTjc2OHJtczZuWXFFZElDUjhBVWZkeGJ3aWpn?=
 =?utf-8?B?cWF6dnhUcGJZdG9RbThZeUk3MkRBWjExeTJHV2x0aG1NSThvOHlRM3p2emlP?=
 =?utf-8?B?UjJpNkN4SC84U2RYQm5EL1k2NXRWMXJQWVgyQWd6YjZzWDJGSUlyYnhpdmZp?=
 =?utf-8?B?UzlCSWY4Y0J2cmxWV2N0M29hWWhaUklnY1l4SHVzYkloMEl4Qit5WEJ4bzRs?=
 =?utf-8?B?YlExUW5JZGpoODVORTBMZ2t1Q1cwQ0FjbWJmYUxrWUtVci9ieDdlZW1ma0dr?=
 =?utf-8?B?VTA4Qk5WaVlMcC9CYlVLWTVXMk1DSFdQVHp3UUs3ZDJWQTRTb3FLRkxuUjlN?=
 =?utf-8?B?V3R3ZUtIWFNsN1dxZU1MSnlFTHlPMG1tTXo1SWNwQ0liRmVUTDZ3T0V1dlY3?=
 =?utf-8?B?Ly9FblRjM0pJbllBOVV5WUYxZUI3L2dIc2xVZmxkQ2V5dWUxbkI1TDFjWTI1?=
 =?utf-8?B?dWRqVHVuL3UvaVNNV0xLWjNKd3k4OVQzVlpaSDdIYmUyY0pGUDU1dUhSUEJh?=
 =?utf-8?B?WTV4em00TWdDM3pWY2duQVdYODE4dTA4OHhhYlNkTE15cnFHTHZHS2JXYk9D?=
 =?utf-8?B?M1RMOUFNQkVEUnFlVDJYNXc4M3AzcW42U2FBcVoybThIdHV1N0srczlydGJV?=
 =?utf-8?B?UTJJZ1VpT2FjM0JzbzRKdm9iL1Q5ZjVTVUdsaTF1TUZWQjhZaG1FQ3pxU3Bn?=
 =?utf-8?B?MEIvdGpPUWZZcnNDaE1NL3pJQnRtTUZ0TmxGcHdITUw5QUozR1p1SWdnV3Ru?=
 =?utf-8?B?Wk9ESkR6Nk1FSE4zQ3ZZQTN5VllhNWRGVHR4QmV4UE9mT0R5bE8yRTNmaE1R?=
 =?utf-8?B?Y04yMTBFRWRiei9rRDA1NzcwcW9wS2poSDVYZ3hHaXBxd0lWU2hrN2labTFE?=
 =?utf-8?B?ZGdFSm9ha3A0SXgzQUQrZVJENmxsUU5CblpISmFJbjFqZ0NoMjFtdUhLS3JJ?=
 =?utf-8?B?MFRrV1hMWi9aQ1BhTUd3L2tESTRZSU9qcHZiL1FrVDRaRmh5Vk85bEoyaHl1?=
 =?utf-8?B?czQrckZNNUVWbXhlUmtCQzFtcXR1OXZyNDFydm4wbWs4TGNkM3JWRzgzK1E4?=
 =?utf-8?B?Q3hhWVo5N3RnR0ZGbkY1ZWt5ZU9TRGp0TGdJYVVmWmRhOW84dVJTUk9TNmpU?=
 =?utf-8?B?bjVUbnExT1liMVpIcTN0TUswUDIzUktmYzU2dTJNMUlDWStPNlJwSlQ4TlA0?=
 =?utf-8?B?eWw5Y2F6N1JTdVU1TnprRHlqRjFaTGF6em0yTlcwNkNpT1hRTzc2NUR1TEZC?=
 =?utf-8?B?MlZhRXRRcFJ2RzR6TmcyVkxiNGhQYXZrakFiajlWVk1jendPV3lKbENkVVQ4?=
 =?utf-8?B?WThRVFJaN0hBTnBtdExaWjBNQkRlUlR5cEdOSzJob2hSVnZ2aXlEODVZYmZm?=
 =?utf-8?B?WEhOYW12eVU1YlRpdkNNOCtaS2w0dmRIcDdMaldRWjFwalF2cWIyVHpKSUk4?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34AD1388FE41A347BA4C8AFE00B17D02@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccb37ec-829f-47ff-0702-08db94b98a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 07:08:01.7116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkOf7bQecxmX6IbDz52Dnf3AjkDpSsWiJzYkhaqVpNSwnSgUr9rtdVHBtOLXOE0QEnPhD30UVp4UPZQmKBy98Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7883
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTMxIGF0IDE2OjU2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDMxLzA3LzIwMjMgMTA6MTQsIEtyenlzenRvZiBLb3ps
b3dza2kgd3JvdGU6DQo+ID4+Pj4gKyAgbWVkaWF0ZWssYXVkaW8tY29kZWM6DQo+ID4+Pj4gKyAg
ICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+ID4+Pj4g
KyAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgb2Ygd204OTYwIGNvZGVjLg0KPiA+Pj4+ICsN
Cj4gPj4+DQo+ID4+PiBIb3cgZGlkIHlvdSBpbXBsZW1lbnQgUm9iJ3MgY29tbWVudD8gT3IgZGlk
IHlvdSBqdXN0IGlnbm9yZSBpdD8NCj4gPj4+DQo+ID4+PiBCZXN0IHJlZ2FyZHMsDQo+ID4+PiBL
cnp5c3p0b2YNCj4gPj4+DQo+ID4+DQo+ID4+IEhpIEtyenlzenRvZiwNCj4gPj4NCj4gPj4gU29y
cnksIEkgZGlkIG5vdCBtZWFuIHRvIGlnbm9yZSBSb2IncyBjb21tZW50Lg0KPiA+PiBJIHdhaXRl
ZCBmb3Igc29tZSBzdWdnZXN0aW9uIGluIG1haWwgYmVsb3csIGJ1dCBpdCBzZWVtcyBSb2Igd2Fz
IGENCj4gPj4gbGl0dGxlIGJ1c3kuDQo+ID4+DQo+ID4+IA0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sLzhjNjMxNmU3OWU0MDQwNmU0ZDQ2NzA5ZjYwMmRjYjE0YTRjMDA1NjIuY2FtZWxA
bWVkaWF0ZWsuY29tLw0KPiA+Pg0KPiA+PiBBZnRlciBnZW50bGUgcGluZyBsYXN0IHdlZWsgYW5k
IHJlY2VpdmluZyB5b3VyIGFkdmljZSwgSSB0aG91Z2h0DQo+IHRoYXQNCj4gPj4gbWVhbnMgdG8g
c2VuZCB0aGUgdjMgcGF0Y2ggYW5kIG1pZ2h0IGRpc2N1c3MgZHRiaW5nZGluZyBpbiB2Mw0KPiBz
ZXJpZXMuDQo+ID4+DQo+ID4+IFNvIHNvcnJ5IGZvciBtaXN1bmRlcnN0YW5kaW5nIGl0LCBJJ2xs
IGNoZWNrIHRoZSBkZXRhaWxzIHdpdGggUm9iDQo+IGluIHYzDQo+ID4+IHNlcmllcyB0aGVuIHJl
ZmluZSBpdCBpbiB2NC4NCj4gPiANCj4gPiBUaGUgcHJvYmxlbSBpcyB0aGF0IHlvdSBkaWQgbm90
IHJlZmVyZW5jZSBpbiB0aGlzIHBhdGNoIGFueSBvbmdvaW5nDQo+ID4gZGlzY3Vzc2lvbiBhbmQg
ZnVydGhlciBxdWVzdGlvbnMsIHNvIGNvbW1lbnQgbG9va3MgbGlrZSBhZGRyZXNzZWQsDQo+IHdo
aWxlDQo+ID4gaXQgd2FzIG5vdC4NCj4gPiANCj4gPiBSb2Igc2FpZDoNCj4gPiAiaW4gYSBjb21t
b24gc2NoZW1hIGFuZCByZWZlcmVuY2UgdGhlbSAiDQo+ID4gWW91IHNhaWQ6DQo+ID4gImNvbW1v
biBwYXJ0IHlhbWwgYW5kIHJlZmVyZW5jZSB0byBpdCINCj4gPiBzbyBJIHRoaW5rIHlvdSBib3Ro
IGFncmVlZCBvbiB0aGUgc2FtZS4NCj4gPiANCj4gPiBUaGUgYWR2aWNlIHdvdWxkIGJlIHRvIGNy
ZWF0ZSBjb21tb24gYmluZGluZyB3aGljaCBpcyB0aGVuDQo+IHJlZmVyZW5jZWQgYnkNCj4gPiBv
dGhlciBhbmQgeW91ciBiaW5kaW5ncy4gSG93ZXZlciBpZiB5b3Ugc3RhcnQgZG9pbmcgaXQsIHlv
dSB3aWxsDQo+IG5vdGljZQ0KPiA+IHRoYXQgaXQgaXMgaW1wb3NzaWJsZSwgYmVjYXVzZSB5b3Ug
aGF2ZSBjb25mbGljdGluZyB0eXBlcyBmb3INCj4gPiAiYXVkaW8tY29kZWMiLCBzbyB5b3UgY2Fu
bm90IGhhdmUgb25lIGRlZmluaXRpb24uDQo+ID4gDQo+ID4gVGhpcyBsZWFkcyB0byB0aGUgcG9p
bnQgLSBwcm9wZXJ0eSBpcyBwcm9iYWJseSB3cm9uZyBhbmQgeW91IG5lZWQNCj4gPiBkYWktbGlu
ayB3aXRoIHNvdW5kLWRhaSBwcm9wZXJ0eSwganVzdCBsaWtlIG1vc3QgY2FyZHMgYXJlIGRvaW5n
Lg0KPiANCj4gQlRXLCBtaWdodCBiZSB1c2VmdWwgZm9yIHlvdSwganVzdCBzZW50Og0KPiANCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWRldmljZXRyZWUvMjAyMzA3MzEwOTQzMDMuMTg1
MDY3LTEta3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnL1QvI3QNCj4gDQo+IEFueXdheSB5
b3UgbmVlZCBkYWktbGlua3MsIEkgdGhpbmsuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KPiANCg0KSGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHlvdXIgdXNlZnVsIGluZm8h
DQpJJ2xsIHJlZmVyZW5jZSB0byBzb3VuZC1jYXJkLWNvbW1vbi55YW1sIGZvciBhdWRpby1yb3V0
aW5nLg0KDQpGb3IgbWVkaWF0ZWsscGxhdGZvcm0gYW5kIG1lZGlhdGVrLGF1ZGlvLWNvZGVjLCBJ
IHdvdWxkIGxpa2UgdG8gcmVwbGFjZQ0KdGhlbSB3aXRoIGNwdSBhbmQgY29kZWMgYXMgcHJvcGVy
dGllcyBkaXJlY3RseSBsaWtlIGJlbG93Lg0KDQpjcHUgew0KICAgIHNvdW5kLWRhaSA8JmF0ZT47
DQp9Ow0KDQpjb2RlYyB7DQogICAgc291bmQtZGFpIDwmd204OTYwPjsNCn07DQoNCklzIHRoYXQg
T0s/DQoNCkJlc3QgcmVnYXJkcywNCk1hc28NCg==
