Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E187628AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjGZCTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGZCT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:19:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349961BD6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:19:24 -0700 (PDT)
X-UUID: d55fe54c2b5a11ee9cb5633481061a41-20230726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QRV6YIRtrkc6Jc9ttOS1oS+LFojWtWSoAXAAqe0CEhM=;
        b=rAOQTprjexaeqUrVGzUwLeoWFaDB3Qz63qUZjPQQqyA1MQ7BplAsmKy6WPROFb7DBPqOJbfpZqib/v2A1TkFPq9hqIFoz4VlU8haBe8qwoPRhEuUZEKrcSdu1v1b25MpxEOKGWbHRp7DKIej+c3L+EbWB6zgOhMwYZY/uQSCAuA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:784ce11e-2ff0-40ad-9557-d948e828c4b1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:2cb253d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d55fe54c2b5a11ee9cb5633481061a41-20230726
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1528055063; Wed, 26 Jul 2023 10:19:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jul 2023 10:19:21 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jul 2023 10:19:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR5dFqxYZUm4uwYzXGRP95JMfDwLlOd8kd/NelZnIm68JcVeFjFWUVEDqUdQEA6IQ5ZpMzN7ZFNZlRenGQs2IWs6gSJAMgl+FIgJLUVEcSluJJlWAqq6fs9b6foSh+jMhn8M8vL+tblue2Nbi9aZNKdSohTI8SK4hIIsAHkjTZelMuHHDWQSNtfOpbtuZUorBsqzZJFJ2ewEW4XiGBYQCd2hu8N3RBapYsVJftcJpK8ZdN7KPCHxVRqFTZLfmF2MyYVxpJ4rKarp50FDGljaHlH02sjzisSUh6JDNl2U+Ap6OOISY3JHypm19oPM18ZcrtXnU27FK1flDZF/aGZifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRV6YIRtrkc6Jc9ttOS1oS+LFojWtWSoAXAAqe0CEhM=;
 b=TijCqTgLWo2kz2PbyCqYIDsgm7KjeRSeQHKw6gsMgzyH6v7K88Q7iC/oyzmtW2VDR/p5BWH8YUcAbtzv2OikASf5UO72brFcTrrW+LNJUTPgDp+bMhWc4XFyJSgEZ8wcppCnDWYTj2Il65w8Qru4Zu8kxfH2Rh0/tNWbJBfxuohdOANJJFwCBwRguWA1nTLsmMItP07aDW/ECwgXZG6Uck2jgj42feQN4ZqV90C326UY9lVFCQy2zDQqji01o0N6ChiXxasKDN++9S6zyi+99TMXaaiRa0aOHyerIu4K1kStzgVxZgH1HohpeBPYsNIsd4obMl0TDeQaBHJIAqacJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRV6YIRtrkc6Jc9ttOS1oS+LFojWtWSoAXAAqe0CEhM=;
 b=JAoiMM/Rb+cLtA3YbagNglgb6Gw4F+21uvOP74FNE6z+KIw0XHMdiCwUx+r9JF7UKYs5M7agBmzJN9bEstxSTclamuTMLk1sjp66wqGzGXBWDTrTsLvF0t8MkQiCRQhotYQ07wYJVeUwtuN0o4l5eSo/BhtQn4OwWOB5vRCIlVI=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by KL1PR03MB7504.apcprd03.prod.outlook.com (2603:1096:820:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 02:19:19 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::a88d:fbad:5956:fd1a]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::a88d:fbad:5956:fd1a%2]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 02:19:18 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/3] ASoC: mediatek: mt8188-mt6359: support dynamic
 pinctrl
Thread-Topic: [PATCH 1/3] ASoC: mediatek: mt8188-mt6359: support dynamic
 pinctrl
Thread-Index: AQHZvquHbd20P9+WpES+HRrZk+KuQK/KD8AAgAFCEIA=
Date:   Wed, 26 Jul 2023 02:19:18 +0000
Message-ID: <69690b530fb46d6adad1732d570c8cfad9c0f23c.camel@mediatek.com>
References: <20230725035304.2864-1-trevor.wu@mediatek.com>
         <20230725035304.2864-2-trevor.wu@mediatek.com>
         <5314542c-9a99-fad1-93f6-4f72c8698715@collabora.com>
In-Reply-To: <5314542c-9a99-fad1-93f6-4f72c8698715@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|KL1PR03MB7504:EE_
x-ms-office365-filtering-correlation-id: 2ab13de6-99da-4a29-946f-08db8d7eb74e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nynk3t6SBcXCkZU3PYSM08Hn/H1E4xQ9xEyN5KrFq3krE5RlS7PXF8D3iwntwMeHhO7HP5+5bfmiNc1hpU0KMRSkwZQhw3fVCiPmpAEK+fMP/PjeYYQsWbZ+28xJNeSiHKYQZzE0R0tLwoNz1nHuC6SgVXtMqji/iIjGr4pOWsmEIWqqx/2CYCDeLObLh82hr1NyF7Ld7baqo2BJiwgBNqlbMzMulr3CBIG0qfwtXjw8xYcb4m7/MA+dst/HZRZQIL1ZoN3bYeujN3tBMfiQr1WO7yAW43fI1CVn7MditKP51CsncKiJh3+K8+BO0UEsfMYFX95yoI6F7JYZnmIRmU4c48abAVTBrR14Up5t6+8bmUdprYseNH16wkR9Ji7ZEh+LhPmilSsjiwHHqk9nD+zTMekiBIpG/fBY50dgLM69rr5qHpvAtfccmyiZVN/bxaalEXfGh8JafECVY1XxW7G2zs6WTuvh2Ut1zZWz7n9i9fxf0RnzbcgXZG2vHDTXzhkfU9EySBUTlOko1Wtn6j60H7elSHVjRV7ZwEddXYmaa9yEin5XrZFcl0Kio05fu4cF7mJq5zT8KTO8YchCbIum/SPNJL2Y2ZE6Bxxnp868AVI4+pPrXYupdgjBEii2Txh3804Aa3fON2YiHcOdQlDOBtJgqQtSyR7YzVDiznieONXcobzraiT94Ma8yM2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(7416002)(54906003)(2616005)(186003)(26005)(6506007)(66476007)(66446008)(66556008)(4326008)(66946007)(76116006)(64756008)(316002)(6486002)(38100700002)(91956017)(83380400001)(110136005)(122000001)(478600001)(8676002)(38070700005)(5660300002)(8936002)(2906002)(41300700001)(86362001)(85182001)(36756003)(6512007)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0pqbGR2UWV4WkRlZ2lmNmRpbEd6ZXFBVzdsTXdLTXJvVzBMeUM2QmxpUkc1?=
 =?utf-8?B?UE84bUlPVFkzVldNSDZhSFVkcU9kUTMrWWVPV0Fsb1J1WVI0b25MWE0xckJQ?=
 =?utf-8?B?dU1WaVNPZ1pNT1I5T2M5Q2VtK1RsbmVOQnZXd3Y4amdYdXBud2RwMHBXM0pm?=
 =?utf-8?B?ZTVJYkJ6VTAxRUcvRkxmTFB0YkM5ekNHbnYxc1hlNk9rWEwxRmJoMGdXN0Zx?=
 =?utf-8?B?RUVTNE50dzc4L3Azckl2OEdPSnFtay8waVhrdVdwcE1aUkJLMFNraDYvOGJa?=
 =?utf-8?B?dXE5TWZNWlN5amF2eGZCT0Fub3JJRFdjeWxsanRwVjN2bDhBQ2M5ZXM5Wk9r?=
 =?utf-8?B?cEFPanRaM0tJUU9qU2NOQXlqQ0gzNERCTE82K2hHR1kvVXFMN3VTbUZuRkVZ?=
 =?utf-8?B?UTJuc3hnRitSamRuMWhtblQzMnVYUDVJcEMyZXJTYXEraDdSZzJKSHdyWVhi?=
 =?utf-8?B?dnhmVHJlSnB3d09SdXNxWnMxdUdHVC90Z3Y0a2VnZnBvRTFTOS91U1VreFZp?=
 =?utf-8?B?TStkdElZWkorNkdMTnFhRUJnQkRxeW1ySFJhTk1reFpIQmpwcjhRNi9JWGlP?=
 =?utf-8?B?bUdsb28wUGtiMDRQRHF3UXhSSVZ4WURGSUQ1dlBNOHNmV2VnZ2hJWWpMS0Ny?=
 =?utf-8?B?azhZcEhMWjloRCttaXQrME4rT0gwcXJYVGh2aW1GK2xXVlhTamtsZC9nTndo?=
 =?utf-8?B?aVNZV3RiR09Uek9DcUZRZEZ3VnE2YXlaNXRQU2lsZWEzMlkzcFNUdnIya2JH?=
 =?utf-8?B?Yys0OGNhTUVyaitxMXpISS9IQTBmaXhEeCtnZXcrNXhBQkxCd3A4TnUrNk83?=
 =?utf-8?B?ZGVCbHhoMFYvN0cwYmg5ZGNNVDI3cEthNWNNVThTWVVZVzczajZvUkpSQXNj?=
 =?utf-8?B?OEVKczdvWEVqL0ZFRURkY1lPU3VXMmtCMWk0YkU2MkpzYysyeW9qNGJ4THdh?=
 =?utf-8?B?VThwM2ZLRFp0Q1ZQWmdlbUkvRTFETk04U2ZBUk5tbkd2T1ZkT1gxanFmRFFN?=
 =?utf-8?B?ckpleUl3cDlaT2FoZENKdnQwS3M3NzhuRmx1MllTTE5sMHc0VEtVWnNQRHAv?=
 =?utf-8?B?SWFNWUY1dXExZFNacDRJaXhVYXQ5U29ESnZTcFJTRWJFOVFrdklzS21LSmw5?=
 =?utf-8?B?TkF5dVRLZHpveUovQ1hCY3plVEIrNXowQm5GN2tlak05VzNIOGc1NFlTMk9m?=
 =?utf-8?B?d25YU0g5d3V3NU95alRwSG1RZS9US2xVcWFIc2V5ODF2d01rY285YVI4MDZ1?=
 =?utf-8?B?Nlk0L1VLYzVQVnQ0UkJGUzgwVVIxakkrbmlxQkNLNFNrUEhiVFVSSDdmclcr?=
 =?utf-8?B?aEJPankvb2dSOUdPV0R4akpSQURuM3NIZ2NncmxHRmlqdWhVK01DbVUyVTdx?=
 =?utf-8?B?cForcWpmNWFtUHhhWXN6ZlVBUDZ1My9VVXgrYVBxZ2VGTGl3Y0gxR3B1bWlY?=
 =?utf-8?B?SDRtcm1YUTNpRGlzdFFIeVQwYi9UNzFjZmVteHVoRXppNG1EalA5Ty9PbWRL?=
 =?utf-8?B?VHNQdnhkV1lKeTNEL1JKZVRIMkh0aXViTlV3cjd1RDc0WXlOZW5VanNXT0RM?=
 =?utf-8?B?TWJnT1hXNDg1ckk4aVBFMWZFblM3UStxRE11U2NKTTJSZVhIVnQvNjM1M29n?=
 =?utf-8?B?NWppZkp1UE9aQU1KQlF3TCtkMDUrVmYveVUzQTRDeURaWTdlUUdmOEsyUE9q?=
 =?utf-8?B?ZzdSSmdPUE9WbGpSYUtLeUhJeXFRSUFMUDNTbllXcmk2NEhaRUY0M01RZUFT?=
 =?utf-8?B?UmxhUkpYQ3BvWGZTUVlUWFRVVXRGeGsrYWU2ckhjcUxDbDRtNmh1TFBZU2R4?=
 =?utf-8?B?YXFIRXE1eFVWWDVsNkZscGhETDcxTjdHUE9OU00xZHpDY3hmZGFVRUkxUEE4?=
 =?utf-8?B?QnVzVU1idFdiVUh2VWVRdFk0c1N5K0xYc05pSnpTUVZMQ3poaTdBd2tGT0R3?=
 =?utf-8?B?LzlBMDlwVFpobndQNnhGSkMySnZEanNoMTZHTzdLYWFQb2h1TkIzL3ZjdVBQ?=
 =?utf-8?B?cnp1dUN5LzVnQ1VJUFdpRTNrOE11RU9IeEtyWUlWUGNUU0lMc0dCaytiUGtK?=
 =?utf-8?B?L1NNNEorcndjOUc4VHM1SURZZ2VwNUluV2hWOEt6dG80Q2dmNjlza0pMY3BI?=
 =?utf-8?B?Ukcva0lYaCsySUZwT3BoUVhycUl0NkFxNTY2QzNPb2pteGZDMVAvV01FMS9z?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8A54FF55864084D8D7B525915C38BEA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab13de6-99da-4a29-946f-08db8d7eb74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 02:19:18.3507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2a1l+5SsQVbMhVdBHNYBIoLS7uAhXUKHHmAmoU4tNvcI8YUHHWrENiZbVnzBlgiR8x2p4uZnfho7vkdM2x1MyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7504
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTI1IGF0IDA5OjA2ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjUvMDcvMjMgMDU6NTMsIFRyZXZvciBXdSBoYSBzY3JpdHRvOg0K
PiA+IFRvIGF2b2lkIHBvd2VyIGxlYWthZ2UsIGl0IGlzIHJlY29tbWVuZGVkIHRvIHJlcGxhY2Ug
dGhlIGRlZmF1bHQNCj4gPiBwaW5jdHJsDQo+ID4gc3RhdGUgd2l0aCBkeW5hbWljIHBpbmN0cmwg
c2luY2UgY2VydGFpbiBhdWRpbyBwaW5tdXggZnVuY3Rpb25zIGNhbg0KPiA+IHJlbWFpbiBpbiBh
IEhJR0ggc3RhdGUgZXZlbiB3aGVuIGF1ZGlvIGlzIGRpc2FibGVkLiBMaW5raW5nIHBpbmN0cmwN
Cj4gPiB3aXRoDQo+ID4gREFQTSB1c2luZyBTTkRfU09DX0RBUE1fUElOQ1RSTCB3aWxsIGVuc3Vy
ZSB0aGF0IGF1ZGlvIHBpbnMgcmVtYWluDQo+ID4gaW4NCj4gPiBHUElPIG1vZGUgYnkgZGVmYXVs
dCBhbmQgb25seSBzd2l0Y2ggdG8gYW4gYXVkaW8gZnVuY3Rpb24gd2hlbg0KPiA+IG5lY2Vzc2Fy
eS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1t
dDYzNTkuYyB8IDIxDQo+ID4gKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
bWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1tdDYzNTkuYw0KPiA+IGIvc291bmQvc29jL21lZGlhdGVr
L210ODE4OC9tdDgxODgtbXQ2MzU5LmMNCj4gPiBpbmRleCA3YzllMDhlNmE0ZjUuLjY2N2Q3OWYz
M2JmMiAxMDA2NDQNCj4gPiAtLS0gYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1t
dDYzNTkuYw0KPiA+ICsrKyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LW10NjM1
OS5jDQo+ID4gQEAgLTI0Niw2ICsyNDYsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfc29j
X2RhcG1fd2lkZ2V0DQo+ID4gbXQ4MTg4X210NjM1OV93aWRnZXRzW10gPSB7DQo+ID4gICAJU05E
X1NPQ19EQVBNX01JQygiSGVhZHNldCBNaWMiLCBOVUxMKSwNCj4gPiAgIAlTTkRfU09DX0RBUE1f
U0lOSygiSERNSSIpLA0KPiA+ICAgCVNORF9TT0NfREFQTV9TSU5LKCJEUCIpLA0KPiA+ICsNCj4g
PiArCS8qIGR5bmFtaWMgcGluY3RybCAqLw0KPiA+ICsJU05EX1NPQ19EQVBNX1BJTkNUUkwoIkVU
RE1fU1BLX1BJTiIsICJhdWRfZXRkbV9zcGtfb24iLA0KPiA+ICJhdWRfZXRkbV9zcGtfb2ZmIiks
DQo+ID4gKwlTTkRfU09DX0RBUE1fUElOQ1RSTCgiRVRETV9IUF9QSU4iLCAiYXVkX2V0ZG1faHBf
b24iLA0KPiA+ICJhdWRfZXRkbV9ocF9vZmYiKSwNCj4gPiArCVNORF9TT0NfREFQTV9QSU5DVFJM
KCJNVEtBSUZfUElOIiwgImF1ZF9tdGthaWZfb24iLA0KPiA+ICJhdWRfbXRrYWlmX29mZiIpLA0K
PiA+ICAgfTsNCj4gPiAgIA0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xf
bmV3IG10ODE4OF9tdDYzNTlfY29udHJvbHNbXSA9IHsNCj4gPiBAQCAtMjY3LDYgKzI3Miw3IEBA
IHN0YXRpYyBpbnQNCj4gPiBtdDgxODhfbXQ2MzU5X210a2FpZl9jYWxpYnJhdGlvbihzdHJ1Y3Qg
c25kX3NvY19wY21fcnVudGltZSAqcnRkKQ0KPiA+ICAgCQlzbmRfc29jX3J0ZGNvbV9sb29rdXAo
cnRkLCBBRkVfUENNX05BTUUpOw0KPiA+ICAgCXN0cnVjdCBzbmRfc29jX2NvbXBvbmVudCAqY21w
bnRfY29kZWMgPQ0KPiA+ICAgCQlhc29jX3J0ZF90b19jb2RlYyhydGQsIDApLT5jb21wb25lbnQ7
DQo+ID4gKwlzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldCAqcGluX3cgPSBOVUxMLCAqdzsNCj4g
PiAgIAlzdHJ1Y3QgbXRrX2Jhc2VfYWZlICphZmU7DQo+ID4gICAJc3RydWN0IG10ODE4OF9hZmVf
cHJpdmF0ZSAqYWZlX3ByaXY7DQo+ID4gICAJc3RydWN0IG10a2FpZl9wYXJhbSAqcGFyYW07DQo+
ID4gQEAgLTMwNiw2ICszMTIsMTggQEAgc3RhdGljIGludA0KPiA+IG10ODE4OF9tdDYzNTlfbXRr
YWlmX2NhbGlicmF0aW9uKHN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpydGQpDQo+ID4gICAJ
CXJldHVybiAwOw0KPiA+ICAgCX0NCj4gPiAgIA0KPiA+ICsJZm9yX2VhY2hfY2FyZF93aWRnZXRz
KHJ0ZC0+Y2FyZCwgdykgew0KPiA+ICsJCWlmICghc3RyY21wKHctPm5hbWUsICJNVEtBSUZfUElO
IikpIHsNCj4gDQo+IGlmIChzdHJuY21wKHctPm5hbWUsICJNVEtBSUZfUElOIiwgc3RybGVuKHct
Pm5hbWUpID09IDApIHsNCj4gCXBpbl93ID0gdzsNCj4gCWJyZWFrOw0KPiB9DQo+IA0KPiBUaGF0
J3Mgc2FmZXIuDQo+IA0KDQpJZiB3LT5uYW1lIGlzIE1US0FJRiwgdGhlIHN0cm5jbXAgZXhwcmVz
c2lvbiB3aWxsIHJldHVybiAwLiBIb3dldmVyLA0KdGhlIHJlc3VsdCBpcyBub3QgZXhwZWN0ZWQu
IEkgcHJlZmVyIHRvIGtlZXAgc3RyY21wIGhlcmUuDQoNCj4gPiArCQkJcGluX3cgPSB3Ow0KPiA+
ICsJCQlicmVhazsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKCFwaW5fdykN
Cj4gDQo+IEp1c3QgYSBuaXRwaWNrOiB5b3UncmUgY2hlY2tpbmcgZm9yIGBpZiAocGluX3cpYCBs
YXRlciBpbiB0aGlzDQo+IGZ1bmN0aW9uLCBzbw0KPiB0byBpbmNyZWFzZSByZWFkYWJpbGl0eSBw
bGVhc2UgZG8gdGhlIHNhbWUgaGVyZS4NCj4gDQo+IGlmIChwaW5fdykNCj4gCWRhcG1fcGluY3Ry
bF9ldmVudCguLi4pDQo+IGVsc2UNCj4gCWRldl9kYmcoLi4uKQ0KPiANCg0KT0suIEkgd2lsbCB1
cGRhdGUgaXQgaW4gdjIuDQoNClRoYW5rcywNClRyZXZvcg0K
