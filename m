Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375807C625A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjJLBlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjJLBlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:41:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0E8A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:40:56 -0700 (PDT)
X-UUID: 5ddc8a4268a011ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DoohhNmCao/66ujVgT8zdso5ObJCFT+OC4hgP6IfUwo=;
        b=AOwpfWfsgDVNsdWsekbeWBH7SZnPYXETG9TiQ8vFU91ME7chJwQIO1KPWsjvtGuLjm1gjuvKbz8/xtUlzye0HZokvUgPTp1dzEH/a8zhsQbTuZazWJVp+mPUb8bPMSKSWDDkukf9MMoOOQi8iaIhGYji3943H7SVB8t/o8ibAGU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:a6939e2d-3b15-4f94-9504-59ab7620bccd,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:374fb0f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5ddc8a4268a011ee8051498923ad61e6-20231012
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 795295926; Thu, 12 Oct 2023 09:40:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 09:40:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 09:40:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPaz7zpGfkSjqh31b+j9O0ukU1P7cj2Ah6j2xdYn/W/38aJ/r5oZ4ByOL+tmqp9BkUZyTnxTZMvRlA75hX6T59c59wr/tfw/L+tKqB0I3UZ7PeoFrqJAs7CWS8Ex/i1md24WjEy+nlVagiVYuSOv8FmzcvQHnCUGaiZE8TVB8qqY9+z6OMUUQLLHjkYgczM3qU1MAnVY80bxf/XQGSeJz7XNQdPc5Mv7dKi30VvVxdLBRL/6jXgV7QC+odtra6oV8gSJgdPi/DrYknYj5jW1duedhwL7T66vQT1MIPL90kFXXMWwoC3eXnBFz3gyS5ikk0f2hXj7kiaKWZLHGwMXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoohhNmCao/66ujVgT8zdso5ObJCFT+OC4hgP6IfUwo=;
 b=SJVIi2XKKvLUUYmR2hOS/9sDpJKX9Ud192WMYMv4OBxhPHe6dvSjJMZjlsEgDvSHzPdPPbsQzpNK+/iYbn0O9JAH7RyKeZHwJc36aDJLyMCMwf4esiFOUIz61N/j49TIl2Zy2HMaLSDPJSAfn/46QwYnq4PiLfX6pWWoMLE2OeV7DhUrFkD8v1B2Ny+v90S3lKUtEbZ1RSr3NYt7a4sh2fppBWylAd5o83aHaljz1O1Vid/tFxKkKz+McB1c3X10lBuNRcfQX4rlrzTMXfp5gysIeJq6oUzxwaO1G5BUDWEaaSqIXjqINbGWgboPPcreR1eBT3hcbPwcYv9bXxk+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoohhNmCao/66ujVgT8zdso5ObJCFT+OC4hgP6IfUwo=;
 b=nKAVZCQq/GVPcmSMRLEpLNnxJ6d+X/hVmR+PQeFN/skpRCQg+cRZrZmk/kVYvMDolONRcnZM05BsRT29eUy7J3CY5Az+7tvdgFA5qNdDwQTz+r1ODuUAfYdPk4MJmJCO+79IYaenrYAPNXyqQgqNCAGMXkbozJOx+BhcRe4v2V8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7563.apcprd03.prod.outlook.com (2603:1096:101:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 01:40:44 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.041; Thu, 12 Oct 2023
 01:40:44 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v10 13/16] drm/mediatek: gamma: Program gamma LUT type for
 descending or rising
Thread-Topic: [PATCH v10 13/16] drm/mediatek: gamma: Program gamma LUT type
 for descending or rising
Thread-Index: AQHZxqWOmIJYPHBLe02ikpY8MwcU97BFzO6A
Date:   Thu, 12 Oct 2023 01:40:44 +0000
Message-ID: <5af8290e693c7b5927dd7d12cc9d20ed3d6ebaa7.camel@mediatek.com>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
         <20230804072850.89365-14-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230804072850.89365-14-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7563:EE_
x-ms-office365-filtering-correlation-id: b2c9262a-6fde-49cc-a4a1-08dbcac44046
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P5EICxVALfsZDhxJeOFiBv4StoP8aaRoEQAB2q3ZiZ5yJARRCHdt75ZuNhtw5uDUIb/NxWM1d/2QR/uPkAIvwtvsSpvstqQXLv+Ai8znZ0rLfHjUmDoKeuX+u4J3QjANk4w4IsiFIrzVbZSzrauKW3A7B8Dp9ufgpQ6uJOYCEVCOdRwPKgn1B31WtBET5y/ng+b6PF1Sc+SwBfL1mXKhPhMqydTiBBN/ZlgB0jw3ijNk4NzEHtHQRnaJwAYZnL9NmpSFYoT7lqPkmBlfNLe8C19OKFSA05BQnludScY7wgDb4OOaVddRSEmU8YOMUaxjKyQiDNhEdnHCzSeXFxuAK86PlikGO+/qwAP7r/bw1LTOypyZ87mwQirwB9lwgNMavWi/RR2eONNiL2mkXYzSZ6JjCTGbZAAS0QZr3K5RRE7Q3lKfz02psb7NyA2+n9xH8tiqxcYa1jOcDg9StQmBSO3WkT5k6CqTInoAWZwk93LTAtqNdG3ptVIjZbVqi8G7H2PKydHaXIP1Hp/IevDbPUE0r+QBc2gaK54icRblkqcVUEUhMyFcYHGStzQeMfUROpIh+9JrxMBvIxyS+HtKXdNhm0V6uGflc4c3+W/X06paERP4dKANaM9DQZfeRfNgFi02TvhQLKAwPHdt5/Bc8RTJscQlBjusxnPR4N3WWvM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6506007)(6486002)(6512007)(64756008)(66446008)(66476007)(76116006)(110136005)(66556008)(66946007)(2616005)(316002)(54906003)(71200400001)(478600001)(26005)(4326008)(8676002)(8936002)(85182001)(36756003)(86362001)(2906002)(122000001)(38070700005)(41300700001)(5660300002)(38100700002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHJPYnpJbFgxZFMwMzdrNHo3MmRORjR1UTh6TE9HY3hIOWREeE4zUE16Z21s?=
 =?utf-8?B?VS91S1hyUDN1dTFRL2FFY1pjVjQwOHVJUEFRYVZrZ0VXSU5RNFk5eTgweS90?=
 =?utf-8?B?ZnNMU3hlTkZUcEZTN0NIL096c2pqcGVLZ3hNejhEVnBqbVVSU2orWkJkSjl4?=
 =?utf-8?B?aU0yWE5Vd2tIWGMwRHpERXJmTnBTZnZVYXI1aUxRMFNPT0h6OHpaOU1GM3N0?=
 =?utf-8?B?NEs0dXVxazU2UHZmN0VMRVppWmxWS1dWRGpMcDVFdFpMUWRaWGZOb2RYclVR?=
 =?utf-8?B?dnJEdzFZRXE1WDZqNG9ETmZBUFY0dmpXMm4zMXRlViswZ1RCMGt3YTdndW4r?=
 =?utf-8?B?c1RrcEQzZHE2OGRTd3lTV09UWWFMT3hnWEdCWSs4am9SOWZvcU04SCttbDFk?=
 =?utf-8?B?R2xKUjJTVno0WnJ4M3BaOTZsaEVzbkF4Qk02L3NjajVReUVZcjRNSm1JMnlz?=
 =?utf-8?B?ckkxWTg4V1BwcFhlOXFTS002WTRKREVxUmxzeFR3a1RmQTNIU3R1R2pabkgr?=
 =?utf-8?B?a3BjTkNldkNTcWxraUhtcEFpVFFxMHhRaThxOEFra1RpQTVLMnhoOTdlOWdU?=
 =?utf-8?B?WkNZVXAwSmFaOVdHMjlGNjdDN0JDRnVqWDRSY2EvR1JERE1aMGxVaVFtdm43?=
 =?utf-8?B?Y2JaZ3hPTG9QMXBNNXFCWkZkR2JSbDFPMDEwbVM1U1U2ejZDN29LUGdOS3Jj?=
 =?utf-8?B?UzY2SzNIUThheVpKZDN4SnBlUXowczFpVnAxT3QzQnAzK1ZBRldkUUhzTGRx?=
 =?utf-8?B?U3BZQXpPeUtzVk5hcWRPL1J3aTN1YWJWSUtmM1R6ZjlzQ0hqQW56L2I5M0k2?=
 =?utf-8?B?U3VVTXhLTE1IRFpiUkxKa1o3V3M5MjdMVXh6K1pCbnMvSm5McWs1UGRUVXpk?=
 =?utf-8?B?VCtVMlB4bTcrS3VwN2Q1MUlGY3RnOExyamxXbVpHUTlKQkdiZEZxNVFZOHNS?=
 =?utf-8?B?Z0NxdlZKbG9DNVJKL1NRaTFYYmdMVWlxWlZOWk5FOWJwZkFYdm9TSm1QbmNa?=
 =?utf-8?B?LzBJK2hLSzFNaDhmNXArREQyVTNocWY3K05vd29FaWF3QlVzZ2lTellLWUNM?=
 =?utf-8?B?b0pTOFgzY0R2M1g4a3BMZGhHOEcyK0JxeFhPUjE0RWFqNjBCN0ZOVFl2Ukdm?=
 =?utf-8?B?WGhBODZzRUI5SGhwTXBxYkUvY3BxU3RGZ3NXTkRaOGp4SzVZOEtXS0dVaDAw?=
 =?utf-8?B?SEkxaFdpMm9SKy85OUM4RzFGY1U5a05ENVZEblZTRElJeW80ZS90Ym9KdDly?=
 =?utf-8?B?aW9XWG9pT2N6bTFaL2lFK1FvV0NtUmY3QktGNk5XWG1Uc0UwVkdLb0tSbFRN?=
 =?utf-8?B?KzdLR0JMNmd6eFVSVnM1M0tYb01VbWVHTVIwdjdzWFdrMVAzejl0aDRITTJ1?=
 =?utf-8?B?TFhBazBUYzZCbHpJb0JVOFFGTXpQY0dSbHhZRDJwSVJBYmZkcDhsR1VUcmxW?=
 =?utf-8?B?YjYwZG5ib3B1bTlsK2dYanYwSGxTbXMzdldvRmhxU3Flc2M0MEo4b285YlM2?=
 =?utf-8?B?Nmp2ZWhQcGNEK0FXS1dZYkJrcHpQcEFsUGFMOU5rTDFWZ2srcWNrQndlRDFJ?=
 =?utf-8?B?Z25QbmxhOHptOEVHRTBvZDRYZWZPR1JiazZ2SHRkNlo3UFp5c1h0T3hFT0Nw?=
 =?utf-8?B?b2R6Z3ZHemk1elNXa3hLR1VwWUx6L2crK0tPOVFtdUEyVU9aR3lsRHpSWVhq?=
 =?utf-8?B?QVQ3aC9mMDJiYXhXeGZLRGhXSnBGWmVYeXMva2psTEpuMFdHTDI5VVYrMnZD?=
 =?utf-8?B?ak9EZFVMSUJtL01VeXExWGVOWkZhUTk3bGhQcHBDTS9qd3pDeWJnUVN3Mzhn?=
 =?utf-8?B?U1h1WTk5Z2FMZGJyVC8xaXlLWnk3UjdsZTF6bmxSd3ZKcVgvK1NIQXhDMlcz?=
 =?utf-8?B?amZkQkFGRlZUQ3c4ZHorajZheVloZDEwSUxLMEtQdTFvWFpLK0ZpNngxU0RL?=
 =?utf-8?B?M3d1RCtZNnZIU2ZSYkd1ZXBMZlVadkIzdHBpQ1hTeGFZTy8wc1dtN3RtK3Mr?=
 =?utf-8?B?YXl6U3Z3SDVsbHlnemVLMGptNEtpdFhHbTMyVXVsQTBVUEc3Mk1vNktxK2sv?=
 =?utf-8?B?R0Y2T01wNmJGV21ZeWpSU2QwRWs2VEtIbWUzQ3grdTJYYlVlNUZZOFBSYld2?=
 =?utf-8?Q?tLqGsA16xWNnKxwUIJDq02VHu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF4477E94832D14583FA8A07A6A1DEAE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c9262a-6fde-49cc-a4a1-08dbcac44046
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 01:40:44.3279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0kRp5TOILlEAxeZ8Siti91U8YQk6D6/L3ZvobmFozzw75fasi8Vsx1PuKaE6zrPw8l2Po9gKVQiHwiJod3cnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7563
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gRnJpLCAyMDIzLTA4LTA0IGF0IDA5OjI4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gQWxsIG9mIHRoZSBTb0NzIHRoYXQgZG9uJ3Qg
aGF2ZSBkaXRoZXJpbmcgY29udHJvbCBpbiB0aGUgZ2FtbWEgSVANCj4gaGF2ZSBnb3QgYSBHQU1N
QV9MVVRfVFlQRSBiaXQgdGhhdCB0ZWxscyB0byB0aGUgSVAgaWYgdGhlIExVVCBpcw0KPiAiZGVz
Y2VuZGluZyIgKGJpdCBzZXQpIG9yICJyaXNpbmciIChiaXQgY2xlYXJlZCk6IG1ha2Ugc3VyZSB0
byBzZXQNCj4gaXQgY29ycmVjdGx5IGFmdGVyIHByb2dyYW1taW5nIHRoZSBMVVQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2Fj
Y2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEphc29uLUpILkxp
biA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRyZSBN
ZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IGluZGV4IGZiZmY5Zjk3YjczNy4uZDlhNzAy
MzhkNTI0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
Z2FtbWEuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEu
Yw0KPiBAQCAtMjIsNiArMjIsNyBAQA0KPiAgI2RlZmluZSBHQU1NQV9SRUxBWV9NT0RFCQkJCUJJ
VCgwKQ0KPiAgI2RlZmluZSBHQU1NQV9MVVRfRU4JCQkJCUJJVCgxKQ0KPiAgI2RlZmluZSBHQU1N
QV9ESVRIRVJJTkcJCQkJCUJJVCgyKQ0KPiArI2RlZmluZSBHQU1NQV9MVVRfVFlQRQkJCQkJQklU
KDIpDQo+ICAjZGVmaW5lIERJU1BfR0FNTUFfU0laRQkJCQkweDAwMzANCj4gICNkZWZpbmUgRElT
UF9HQU1NQV9TSVpFX0hTSVpFCQkJCUdFTk1BU0sNCj4gKDI4LCAxNikNCj4gICNkZWZpbmUgRElT
UF9HQU1NQV9TSVpFX1ZTSVpFCQkJCUdFTk1BU0sNCj4gKDEyLCAwKQ0KPiBAQCAtODYsNiArODcs
MTcgQEAgdW5zaWduZWQgaW50IG10a19nYW1tYV9nZXRfbHV0X3NpemUoc3RydWN0IGRldmljZQ0K
PiAqZGV2KQ0KPiAgCXJldHVybiBMVVRfU0laRV9ERUZBVUxUOw0KPiAgfQ0KPiAgDQo+ICtzdGF0
aWMgYm9vbCBtdGtfZ2FtbWFfbHV0X2lzX2Rlc2NlbmRpbmcoc3RydWN0IGRybV9jb2xvcl9sdXQg
Kmx1dCwNCj4gdTMyIGx1dF9zaXplKQ0KPiArew0KPiArCXU2NCBmaXJzdCwgbGFzdDsNCj4gKwlp
bnQgbGFzdF9lbnRyeSA9IGx1dF9zaXplIC0gMTsNCj4gKw0KPiArCWZpcnN0ID0gbHV0WzBdLnJl
ZCArIGx1dFswXS5ncmVlbiArIGx1dFswXS5ibHVlOw0KPiArCWxhc3QgPSBsdXRbbGFzdF9lbnRy
eV0ucmVkICsgbHV0W2xhc3RfZW50cnldLmdyZWVuICsNCj4gbHV0W2xhc3RfZW50cnldLmJsdWU7
DQo+ICsNCj4gKwlyZXR1cm4gISEoZmlyc3QgPiBsYXN0KTsNCj4gK30NCj4gKw0KPiAgLyoNCj4g
ICAqIFNvQ3Mgc3VwcG9ydGluZyAxMi1iaXRzIExVVHMgYXJlIHVzaW5nIGEgbmV3IHJlZ2lzdGVy
IGxheW91dCB0aGF0DQo+IGRvZXMNCj4gICAqIGFsd2F5cyBzdXBwb3J0IChieSBIVykgYm90aCAx
Mi1iaXRzIGFuZCAxMC1iaXRzIExVVCBidXQsIG9uDQo+IHRob3NlLCB3ZQ0KPiBAQCAtMTc1LDYg
KzE4NywxNCBAQCB2b2lkIG10a19nYW1tYV9zZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QN
Cj4gZHJtX2NydGNfc3RhdGUgKnN0YXRlKQ0KPiAgCQl9DQo+ICAJfQ0KPiAgDQo+ICsJaWYgKCFn
YW1tYS0+ZGF0YS0+aGFzX2RpdGhlcikgew0KPiArCQkvKiBEZXNjZW5kaW5nIG9yIFJpc2luZyBM
VVQgKi8NCj4gKwkJaWYgKG10a19nYW1tYV9sdXRfaXNfZGVzY2VuZGluZyhsdXQsIGdhbW1hLT5k
YXRhLQ0KPiA+bHV0X3NpemUgLSAxKSkNCj4gKwkJCWNmZ192YWwgfD0gRklFTERfUFJFUChHQU1N
QV9MVVRfVFlQRSwgMSk7DQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29t
Pg0KDQpCdXQgSSdtIG5vdCBzdXJlIHdoeSBub3Qgd3JpdGUgaXQgbW9yZSBzaW1wbHkgYXMNCg0K
Y2ZnX3ZhbCB8PSBHQU1NQV9MVVRfVFlQRTsNCg0KUmVnYXJkcywNCkNLDQoNCj4gKwkJZWxzZQ0K
PiArCQkJY2ZnX3ZhbCAmPSB+R0FNTUFfTFVUX1RZUEU7DQo+ICsJfQ0KPiArDQo+ICAJLyogRW5h
YmxlIHRoZSBnYW1tYSB0YWJsZSAqLw0KPiAgCWNmZ192YWwgfD0gRklFTERfUFJFUChHQU1NQV9M
VVRfRU4sIDEpOw0KPiAgDQo=
