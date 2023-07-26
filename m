Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B011F762AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjGZFlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjGZFl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:41:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377C210CB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:41:26 -0700 (PDT)
X-UUID: 0c7be69a2b7711ee9cb5633481061a41-20230726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YjJdDtaCoUrOGEcXRehkGWGq0MoAOrISo/ecKFlB/lU=;
        b=YR9OVk/qb4DpsHajAmmpuLX4cwL73m6qW/RNaOuCsSbwLE0DKStHTI3YewgWTC5YbjpxLx2U+/6jGy4X0qQEwh2yanp1+8HRHFtnpFZwJdUpmYdqdpG6ZdaFbutbzFoqvUobWeAQK4pXPvNqG0LbjENX3mrQAvw48bFbBjQ5ErU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:75df9da4-0ce1-47a5-a802-5b14f660c323,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:7670ccb3-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0c7be69a2b7711ee9cb5633481061a41-20230726
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2029946861; Wed, 26 Jul 2023 13:41:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jul 2023 13:41:19 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jul 2023 13:41:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A77YqzJAz0yjhBD53M5HFzOuJDcojj7rcq5rXODpphOgi3Ng6ha1I1d3dwUavvQFwZGGmOmx8azKMB+UyEKyL8+E2tQkqYpnFNSFOwLdpDZNIyMfGVC29XOzi2k4N2bwaPyrwa0TyJpXlUklu9JvY/CF99yc0tOGZsN6wqMIHh4E0hcYjIXimC2rDH6ERVCI4tVTe4FT7j/bVDGDFKaw0h0H050qDt4PzHwfaoXOtvFY1IRDEPtJ6JpT9Xe0wmIufzA+ot4H3i2jQjzfLk+bS/mgyr4fykr04NFtmrgxrzX1ndDC64SfnPiFYmDvyJ1t9q0PuZblZKmf4dmWEy8cng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjJdDtaCoUrOGEcXRehkGWGq0MoAOrISo/ecKFlB/lU=;
 b=Eh4k3Qf1v6FWge1Gu/lh6ek2l1LEoou6kAD9ss2hGdX6TqhHuboYLvntafzMrlnJODz/yEM6gx/UgMn2me1P/MRGzhgQSLcTVRFurTEuBXlSbmq2vunzqezEKyTYzZQwCanrz9hSbknzRM28ef3W4lmBz+eHSYBl0Y4MnNierm488p4UHG+CO5hKeLg4swKYGEuJyz8qjcCk9F8C0iCg9IF++nJJgHuKuir+CLH4SlloNFNW08DUVB98RdK12bQWEFPr3EnAlIaOej0ZhjK3IdFyODz4K8IJq6VmEQzyxlKECLeeNuApV7spLcIt/MRIi189uRaWjmlpy5sL4Pa09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjJdDtaCoUrOGEcXRehkGWGq0MoAOrISo/ecKFlB/lU=;
 b=Kxelyp5xdkAkavLD+Ip9KCui5cDvERFJLxXMgbGYPha05gDzl6tvoaJceORVwhphtxuhrqezula+f+Fr2jWuaqkxfhQMnAdfv4RFkJ2j8TY9y2ywrqmmRj6rymLJlSc5wHodaoGn6ZrzMZ/+Mv/JSgK0nfgvxE+PUpwktCzEjOM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7427.apcprd03.prod.outlook.com (2603:1096:400:40f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 05:41:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6609.026; Wed, 26 Jul 2023
 05:41:16 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2 3/6] drm/mediatek: mtk_dpi: Switch to
 devm_drm_of_get_bridge()
Thread-Topic: [PATCH v2 3/6] drm/mediatek: mtk_dpi: Switch to
 devm_drm_of_get_bridge()
Thread-Index: AQHZuhXc9/G0G4OGk0+2ewuRsPheuK/Lk2qA
Date:   Wed, 26 Jul 2023 05:41:16 +0000
Message-ID: <d7265ef4cf8f302abfda4c29c31254f6fdb39a9e.camel@mediatek.com>
References: <20230719075056.72178-1-angelogioacchino.delregno@collabora.com>
         <20230719075056.72178-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230719075056.72178-4-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7427:EE_
x-ms-office365-filtering-correlation-id: 119b117e-49cd-4e85-c331-08db8d9aedfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RdC73Vr8XC+dLbme1D0GOJbJKct8pIhksDbqGPwnzGphOq/I+D/fAFg2UD/NlhZ3FYW5UW/e4j7TczcU/4w70GgHuLUK/AaGEf756LOsE2s9NcL7WLXozx0BdTxZvZti4PuhgheyH0Rmf1Yf81feGZqq3O4d8SBKgxCo5Hu48s+ACtkphg9nWm9rqljX0j//eIlaCorUhbM2+md6GXp52ge6HIfTZKsvpH2VNglpTeWgkgFcLFnxmeih1bRxWxiuBo+KUGTJCF6QPIidvsvrNMkRXBccn1ant8jdG921nD/zS6l6Eky5S1x+sT1EIlD1RXqrNXfnLF4jRpJSfG+Sx8Ud6FeNYSORNm7tKBXxDbGiVLBb5QWggXfpBx3OmXM5yUix7tuExHsbiJr+lpj49fbzZc1HyOEURoq3UDkptuN1KTQiaobs35iXImH6sNRmuXy4WzA4fnFN6Dh6bedf2wyYQDvmBu/Y7JTNwf2dD5WmXI1NzxFmz1Euod/152aC/yz9eT25+H1kgqczNQoER3czZVlBsVyKeB8UtRZkKxPMqsNRNF/nc4M3jmtiIrJ72KTNoWKqKUsV+Hdf23tDl6zCNrgH6BxZnKTdg3rC1AG1Tp5Lc8ii6oCTVFF7Gp8Xt4jeU6o/sIhx/K6zoT0eYo5oHvvFrJNx4kzc3s68Glg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(2616005)(66946007)(64756008)(66476007)(83380400001)(66446008)(85182001)(38100700002)(36756003)(86362001)(41300700001)(38070700005)(5660300002)(8676002)(8936002)(122000001)(54906003)(6486002)(478600001)(71200400001)(110136005)(66556008)(4326008)(186003)(316002)(6512007)(2906002)(76116006)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXM1WDVsdGhaYmgyejdlTGxseGlOQUo0Zm8zWUQrS2ZPaVBhbHRiNEFXdUJn?=
 =?utf-8?B?SEs2VHVtMXNnTkpqS3JTc2xZU0M4UXVCNHlpdmtDUFFlWi9heHpHRDhGb2E5?=
 =?utf-8?B?VGRSWGlEeHYrcTA4eE5BejI4NG52ajhCV2VPY2JvME1aNCtlOEw2T09LQWtQ?=
 =?utf-8?B?Q0hPZFQvTTNiLzFvb2NJQUVxbkJjaCtDU3ArWnZ3dEJodUNzT3RHbC9jakd1?=
 =?utf-8?B?SXpZMC9vNXpVZTRMWTdvQXpXcWkvZllCN0F3RVdBaExTdy84MFU0azJXUUxN?=
 =?utf-8?B?dWpndjBZam12MjhtTHhEZkF0anU5K3REdjBBcDhHZkJwM1RMSXNZYml6M1Zl?=
 =?utf-8?B?VVYrRFVsK0VpSzhZTE1hU0RBREhEbzdia25EUXlyUzE5b252dndmeFhoTXBX?=
 =?utf-8?B?c3puTkJsVk9RenZtUFJhaU5aUG5FN2VkYjUvK3ZFNGloYkxEemV3blgzMWM0?=
 =?utf-8?B?WnAyM0JXL1FxME5UTE4rcC85YkpHdEZxaEQrbGVJdE5uYncvVWZzOE1tKzNa?=
 =?utf-8?B?bE5Ba0p5NjA4VHY5VFdCOTJhVGFaN1p6VFBnWDA1RjVkYkJQcTVNcTlOelFr?=
 =?utf-8?B?WVRtUjVwL3Rod2Iwc251OWZ6OVQxNzFxUkcwNFZiZ0ZGTWFTVlgrdFJMbVRV?=
 =?utf-8?B?SGErRWVyUm5PcXA4S2RqNWk0bFpkb0c2R1o0enBlbDZtaXIvMExVZFh3bkpR?=
 =?utf-8?B?dkpUZEZvTXA3dTNkTnE4MW5oOTMxUCtqbjNqNG9ndUhydndYSW5laHdoM3VC?=
 =?utf-8?B?RHc5WWlpV1E0b21EendkZzJUamY1c2t4dDZIcEtQNVVVRThUTFZDa0oweStq?=
 =?utf-8?B?LytuRHpZS29tTnk5NzVnTVlyYXBNdzV0Z0Rka0NtODVSajY5SDlkUVB5Ymx0?=
 =?utf-8?B?UUZycEpZeStNRmJpRUxYVytmZ09jYTUxZDdHeEJxTUxOcWFaa1JDWVd2MjJi?=
 =?utf-8?B?Tlcza3hCWDVla3B6eEljcUV4b0VnUVgvYUhrNmk2emFURHZpS1hqS3NoaUFq?=
 =?utf-8?B?UFZOSjdZd1hNQ2wvUWt5cnhpcHV5RWZtdlptb1o0ZnFRelEwYzF3UjJFZWZ3?=
 =?utf-8?B?OXN1US9RdHMrSUp1NENiQ0REeThYeUhsSGpvdWkxT1RVL2xiN2xKQWtyeFJu?=
 =?utf-8?B?N3JuVVU1a3dJTVZJc1F5dU1TWjVCSW1RL2tuV0Nlb2JwYUVjc1ZJOVhGSFE2?=
 =?utf-8?B?czRqZGtmV0wvRUJHYVpkVG1uNmRmUDhSSHdWWGZ4QXhzdVFBa0psdDU5Um13?=
 =?utf-8?B?aFBjaWFKLzZRblJIdjhYaWdEdWxJQjB2MVphaUVhalYvaGl6Y0wxRFpSMHZw?=
 =?utf-8?B?NWorS0F3QW9iZmxGTEpUalYwc2Fjb1JWMVBKYU1BN3U2S0JQOFoxY3dpVE1K?=
 =?utf-8?B?My9EMDZoVElHQ3lacEpWdmFCY1NvbEdtdWpBcDNSRjh4b1RUazVJTWhjMDhT?=
 =?utf-8?B?Y0hSUEZqZHB3QkZta3FtS3B6K1diMHh1N3llS3pTdE9YaGVhTkFtNzMxOE5y?=
 =?utf-8?B?Umlzb2R1UmpEbWhacTRka3I0Rk8zWVBPYXp5enBHeTZQWnBWYUYrNUREeXM2?=
 =?utf-8?B?Y05nUnNXR01ndWpQQjQyTldVVzdJamdxNGwxbWtsK3RUTElIbWZvYmgzMVMv?=
 =?utf-8?B?L1Qza3h3UVJqdU5zQkdER0cvMGNyd0pIUnQ3S2IwVW12dzdDRnN6dlluL3JJ?=
 =?utf-8?B?WkRCL3V4d093Z3Fmb05aMHlDcng1VVZTam9LRHYvRjJhcnIzbXNIMW1QZ0to?=
 =?utf-8?B?d3hib2tRbTIvZVFic3VpNW9GME0vRE1lTmRxSnNPeGE0TkJ6WnhsSUdnZmJM?=
 =?utf-8?B?a1F5aG5NZ2tidVFMK05mdDFqc3JSY1E3WERKU0RJSFJlR00rZmRLUWgyblRN?=
 =?utf-8?B?R1VLRkhkR1BuMDJkZUZVNFZFNWZXZThLVy9ZdkxmeDFoNzNmWjlLaUdZejVP?=
 =?utf-8?B?N1BiT0FGaEQ0d1NaVUw2c0hiSmhvY2F3andJbjltYkp1ckF3VFRjTGpENXFQ?=
 =?utf-8?B?UUpSb1d5R0djaDE4WTVoYkZYYmtFUUlpMkhXeUoyV0RVa1l0OW02MDJXQmti?=
 =?utf-8?B?TWRLamNqMDY2UFVZQkJoREU4WjVOSlpWeE5hVkdGcFY5VmxJMzhhQzI4VzhK?=
 =?utf-8?Q?vxLgvrH+DM0VOW2PPq2jWZWCY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A5C95A200C8AE4AA3527262DD1AE827@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119b117e-49cd-4e85-c331-08db8d9aedfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 05:41:16.0226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mrno/bCkaH3ZF/xQePKnrPiNoJbcP56cKMhmIC0G6iQGUCh8ZslbsbTcPP1rDH4/PcU2m9M/6uRHC8lkB3dr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDIzLTA3LTE5IGF0IDA5OjUwICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRnVuY3Rpb24gZHJtX29mX2ZpbmRfcGFuZWxf
b3JfYnJpZGdlKCkgaXMgbWFya2VkIGFzIGRlcHJlY2F0ZWQ6IHNpbmNlDQo+IHRoZSB1c2FnZSBv
ZiB0aGF0IGluIHRoaXMgZHJpdmVyIGV4YWN0bHkgY29ycmVzcG9uZHMgdG8gdGhlIG5ldw0KPiBm
dW5jdGlvbg0KPiBkZXZtX2RybV9vZl9nZXRfYnJpZGdlKCksIHN3aXRjaCB0byBpdC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lv
YWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBSZXZpZXdlZC1ieTogRmVpIFNoYW8g
PGZzaGFvQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwaS5jIHwgMTAgKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RwaS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGku
Yw0KPiBpbmRleCAwM2EyYjkwMGJiNTAuLmU5YzVhMGY0NDUzNyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RwaS5jDQo+IEBAIC0xMDYzLDEwICsxMDYzLDEwIEBAIHN0YXRpYyBpbnQg
bXRrX2RwaV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWlmIChk
cGktPmlycSA8PSAwKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIA0KPiAtCXJldCA9IGRybV9v
Zl9maW5kX3BhbmVsX29yX2JyaWRnZShkZXYtPm9mX25vZGUsIDAsIDAsDQo+IC0JCQkJCSAgTlVM
TCwgJmRwaS0+bmV4dF9icmlkZ2UpOw0KPiAtCWlmIChyZXQpDQo+IC0JCXJldHVybiByZXQ7DQo+
ICsJZHBpLT5uZXh0X2JyaWRnZSA9IGRldm1fZHJtX29mX2dldF9icmlkZ2UoZGV2LCBkZXYtPm9m
X25vZGUsIDAsDQo+IDApOw0KPiArCWlmIChJU19FUlIoZHBpLT5uZXh0X2JyaWRnZSkpDQo+ICsJ
CXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihkcGktPm5leHRfYnJpZGdlKSwNCj4g
KwkJCQkgICAgICJGYWlsZWQgdG8gZ2V0IGJyaWRnZVxuIik7DQo+ICANCj4gIAlkZXZfaW5mbyhk
ZXYsICJGb3VuZCBicmlkZ2Ugbm9kZTogJXBPRlxuIiwgZHBpLT5uZXh0X2JyaWRnZS0NCj4gPm9m
X25vZGUpOw0KPiAgDQo+IEBAIC0xMDg5LDggKzEwODksNiBAQCBzdGF0aWMgaW50IG10a19kcGlf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIA0KPiAgc3RhdGljIGlu
dCBtdGtfZHBpX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAt
CXN0cnVjdCBtdGtfZHBpICpkcGkgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCg0KTW92
ZSB0aGlzIHRvIHRoZSBwYXRjaCBvZiAiU2ltcGxpZnkgd2l0aCBkZXZtX2RybV9icmlkZ2VfYWRk
KCkiLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAtDQo+ICAJY29tcG9uZW50X2RlbCgmcGRldi0+ZGV2
LCAmbXRrX2RwaV9jb21wb25lbnRfb3BzKTsNCj4gIA0KPiAgCXJldHVybiAwOw0K
