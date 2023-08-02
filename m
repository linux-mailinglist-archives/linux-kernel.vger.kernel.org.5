Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239B376C619
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjHBHGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjHBHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:06:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D891B4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:06:03 -0700 (PDT)
X-UUID: 08b247e8310311ee9cb5633481061a41-20230802
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PDgminW43K3/uTNDzofcH2am3CoST+Un2rAwreQaN2Y=;
        b=J4A0+CiTIXURcqWNzhXGXRFnSKeg4sjLi517XGXAwX513bpWL8bq/dBbx5pRKQUQ98W/9m+ZA4W7ijGE3PH418FCuojNRhfVw2LkRTYl3l6prV3oryGSuUEbSAoKoR/LOJQp2+s3JHXuanVv6PegRW1dE8XZR3P9H4Oh59xgQ2g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:bee89229-e576-43d3-b2a7-72dfe4c8aa40,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:3669cda0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 08b247e8310311ee9cb5633481061a41-20230802
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1633469893; Wed, 02 Aug 2023 15:05:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Aug 2023 15:05:58 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 2 Aug 2023 15:05:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuFngjgy1Un3hs8bkiJfCCO7Oduuq1blfyauI+ZtErohIxIjQDig6M0+H0OEY0sIxXH0OB4QNeYqAec9BeeLUjB2vzw1mgLIOoALTDrqDXnLyOsyiUqB42GeFhN6SCQ6QGuQvw7aW9f6q1+Fv0qDHd9PIapXwrFzunziWhtdo0h3SI7e880DxzkJGUuCEpcFUdav/4J++7lFbQVldrWKuV9G6QC++ZLXNiF2dgdfcBHFymGCfhUnQJXswniM4m4H6qEOQsw7ZD+fF+/O84r7FjGtjtPKKoGEaZubRqy5jtfqM5KlFwK11LJ3/O4B3opeeIPpeQ1s9KqpJKkgpIBfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDgminW43K3/uTNDzofcH2am3CoST+Un2rAwreQaN2Y=;
 b=n1qVp8GR1yicEZ1YGjIin3Q7LnQfwWXf3dVtJuGAX2fenYz6k+jd6vH0l0NpuuYu8yuLXC9niyRLF+90LHuua0jXglP3c/EjHHYATT+w2yws6cbP091Sy7j+/I28xmuHmEwy1VxvcV9IN04KlZc1T7IKd+0jcXGD0kc36FM2/t1TDRn/zpy6uch0lm6mO6+E5zFplFnNJK1Mk7qNKk7275MurFzuw2asxCYoW8nzdvKLBcvhQAu0169Lm+6g/yPwcCbLzRE42kalIX3H3H5UceZ8iLu831wZQQqSQdn6qI4d7y7MbylXLa0ii4T84uORc9R4gfyAtYB91LdcTAqJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDgminW43K3/uTNDzofcH2am3CoST+Un2rAwreQaN2Y=;
 b=PULAjB+UFU9CaWxBVBw4Pv28dc0xexmHqm479Nv7tIeMkHTfq3vv4JCIqoQwcEi+LGTvBduJz3lkhfJ7YA9YMXDMhEn1GZAxXkd3NTxgeHzKD3+Tqt0Wt+hhCrKTl86ypv4cs75QXDI9pjoMo77xJkR2rVHg+u5aUXiKMB9mQRw=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB5680.apcprd03.prod.outlook.com (2603:1096:400:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 2 Aug
 2023 07:05:56 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 07:05:55 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "eugen.hristev@collabora.com" <eugen.hristev@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v7 2/4] drm/mediatek: Fix using wrong drm private data to
 bind mediatek-drm
Thread-Topic: [PATCH v7 2/4] drm/mediatek: Fix using wrong drm private data to
 bind mediatek-drm
Thread-Index: AQHZwKkypTU41zGk0kqR4mBL6m3qP6/O3w2AgASvoICAAAMZAIADDHUA
Date:   Wed, 2 Aug 2023 07:05:55 +0000
Message-ID: <bacae46ecdacf71c47eaa8031ffdbff55e12f66c.camel@mediatek.com>
References: <20230727164114.20638-1-jason-jh.lin@mediatek.com>
         <20230727164114.20638-3-jason-jh.lin@mediatek.com>
         <d74f959b-2255-4587-e99c-2c6b043dc44c@collabora.com>
         <6c07d1bc12c9226bf623da0a46ffaadb151c2175.camel@mediatek.com>
         <448eb511-d4e6-151a-5d57-288feedcacd8@collabora.com>
In-Reply-To: <448eb511-d4e6-151a-5d57-288feedcacd8@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB5680:EE_
x-ms-office365-filtering-correlation-id: 28ee401d-6ef8-4771-ddc1-08db9326ea99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9w/ky2Ah+MfIkzByh8igVuzboe9qMW2zBJE4gezqm/tGWeFOce+BsRB6AllF0IwcnBXROJpAnPwCZBNWxyCt1B4RuMgkxA5ZMub1/1vZsrMEi3jxAH0kA8MJsRJvVWRXaeM+Z3t1vujvm4QO7+lbUOXQQGdREvHTdFrUjL/RDg1P9s9mzEDVtgAIycJR009TFNt42Xrl/orPQIY8LHcxs/yX6v7Ra+GhErOzrssDRDDKvx6x6/lHonycURF7VmbEKmAI9wH9DwMGFWRkOE2VnriVaf7LEwwoXvDDj14qhNhLo2qhvPC/qhlLVFRHHRSZpNtFxcrH6OpjluEWLdqfEmhcL8nNtvEcEtsfQ4I8DrIJrDYv5bPoKhcYk+k22/p5V17+lpo/dUc/nXEsxWxeLkpCbpy0mYxntJFrYYHgO5Ot0Gt56F7yu3p10GrLu0sG7Lz8HVHf25f+YfDDtc06SurVqFHyS4r/YgULDT5KOAaFgkF7GEODyf23iWkHGjJjldWGRK5S7NyeqPCixMx8tuNhd/yTProcO8PE+UbWCLaXtevXFEI0S8WzR00RJjsK4l93SJEi+eb/gOWkrv8fRxePr7s+9LtHvmdMbjLCWbHihzgi6kgv8232qCbAjaDyFCTBxqFTPuk4H601oSFCFTlQEQkWbkMqISK0yuVDKc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(54906003)(41300700001)(478600001)(316002)(6512007)(86362001)(76116006)(4326008)(66946007)(66556008)(66476007)(64756008)(91956017)(6486002)(66446008)(5660300002)(26005)(6506007)(186003)(71200400001)(110136005)(8676002)(53546011)(8936002)(2616005)(38070700005)(2906002)(83380400001)(38100700002)(36756003)(122000001)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b09SOTZNcFhDVG5qMkNBNERkenppZ1I5OEV6b3dFVVlvaDJmeitsR21DUUt5?=
 =?utf-8?B?b0d2c0F4emNreUpXS0pPT1RyRmNsR25vdmV6MndqZ2tXQjZQSEFYVFBFK1dl?=
 =?utf-8?B?UERyN2NMTURGNndmWDFjWklWV1U2ZlNHODkxbVNXWlhhYXYrMkZnbnl1N0NH?=
 =?utf-8?B?V1Nja2M0OEdIV002MVk5OVZwZWtqK3NLdzUyd1IvWmtiaEc3Y05pZElORlZx?=
 =?utf-8?B?ZmhzamFrOFNsQ25PMFpMZXQ0Q29WemR3NXpqMDZKTjc3ZGltVDJHMDN4eUxQ?=
 =?utf-8?B?VFhneWIwSHUxbEdtcjNxWWVvenppeG9RbDJvSjFmdzZJSmJaM2FjQjhlb1Jt?=
 =?utf-8?B?REpPSzBQc0t5ZVRRNGFQNGV0UmdLSEhvdzhoZmNtQlhrd3c0SkRaWVNyWWFN?=
 =?utf-8?B?RUtnMnMreWFGZlRIWXZEWGJBMWRTeVhlR2VoUExEQ3NYYU1xR0Nnd3BmYjk3?=
 =?utf-8?B?TmZWSkFacUcvN04waGp3a2o2UU1ySFA4eDU2L2gwS0ZoWDM1aFljbG9DYUJi?=
 =?utf-8?B?cncrWlhqNmd6cnBlRHJlbFJhd2NLb0NGU043RUd3Rnl6K2NseTliaFZtRGl1?=
 =?utf-8?B?QVJkNGRXdUpMWkNpQkpGQzRXYjd1MzE0V1RaRVhLeHA3MlcwTjBnL1lURWZU?=
 =?utf-8?B?NE1kUXUva0NVa1pKYmZOSjNrMHFRaloxVSsxN2p4NGtqbTVHK1kxd0pmUmY3?=
 =?utf-8?B?ank5ZUxiUG0wQi9lWEc2cXZzRlBGbDI0RlFiMExTN1g3cTBtc0tDVFhmYjRN?=
 =?utf-8?B?SHdYdEZWR1NCSzhUN0paRXIyV2RCaVFuanRrejVaTyt6cjBmaUdHS2xRYTlO?=
 =?utf-8?B?cjJMekpHVTFrR1Z4SERpK01lVXlwZFZ4aUlBcWFsRFNOcDBsalNTMVJZRjBK?=
 =?utf-8?B?MXZSRTdGUWM1TVJnRlQ1bHdQS1FPTkV3TVVHUE5nV09TQ0ovNE1JRlhlOGNI?=
 =?utf-8?B?Rmp0MzRRNHNweVFIMHF2c1l3VGY3d0doZEhBejYyektpZnQ5K3VnWVc5RjRL?=
 =?utf-8?B?MW9LNDZwNnhaZkVaa09KeXc5aUhVVFQyd3NtYnJVSVB2Nmw0WmFXTEV4Tllm?=
 =?utf-8?B?aTdmeS9mNnM1bUxhNHRvKzc4MUx0c29yODBYY2ZOcE1VekkvNEZVTXhQajdt?=
 =?utf-8?B?NHBmNUNEMkRyZ3BoNCtQY3Zzc3JQRlFKZlJycnRlVDV5WVNnRjU3cURTNlY4?=
 =?utf-8?B?OTBzdU8wNy9ML0FjRk1Day9ZNzFrREh5RW9hYU9MR0ZkQ1BZUUh4bytHMHpF?=
 =?utf-8?B?WU1nMWJ2ZmE3Y0ZmYXF6cTlVYXR1UnVyMzE5REhmOW14L1ZKek9VWnpoVVdX?=
 =?utf-8?B?SitUTWhnMk11MjJtVFRoL01rQVkzRVJZZG54OWV3bU9wUkpuL2FnUGluOU9W?=
 =?utf-8?B?QWVtQ3l0U3RmNmhrbkduRFQ4dHhCSCt0NDFTS0llQytPWlFkanpPR3Era3gx?=
 =?utf-8?B?a1ZXT3dya3RQaWIyZktlL2dVQmV0NHhSSVdXYTdkckFUV3lRN1dtaTNqNE1j?=
 =?utf-8?B?ZTJLZnhOZEEvdkdIaWVMM0N6Yy83WG12T1U5MGxycXh1RVlMaUNlc2U3SU0r?=
 =?utf-8?B?NE9rNUpvaVBndHQ2bkVxS1p4M05WZGFpZnFGdldSK1BYUlZsZnBKMjdnemZl?=
 =?utf-8?B?Y2U4MmFFVnp4NHVEU0ZGdWZXZitEN0w3eStrZUFGL1JYcTNOenFITFN1dFE2?=
 =?utf-8?B?T2ZrNGZKemFYalZlakU2RGs4UmlwNkQ4UGlsRm8vRUlTMjBJdkxXOTNrUHc3?=
 =?utf-8?B?dWRxRVlpWXhoOGJRV08rL2d2L0I1QklvL3A4c0h4ekNISzloVDV6OEkyVlFr?=
 =?utf-8?B?ZkFMc1h3RkdOYnVlZ3BWYmI3czZUSlkxeXllZk5qZUpQN3ZMWUVaS1MrN3JO?=
 =?utf-8?B?QisxZkhiSEJhU1VwN3Z4NFR3dmR4NzVoM2txVUFlWE1DbXZBdDRXSGRJYjNC?=
 =?utf-8?B?QTZBaXhOVXkwTTBSMUJnT3hrb3R2Zk9jUWxRTjFWMGlHUUFicEgwWjAvc2tU?=
 =?utf-8?B?RE9PSHBXRXV1c3Q0SE84OVpFUFRUNHREKzF4Z2tLZWJyR2xLL1dzdTVmbUVu?=
 =?utf-8?B?a2tQM01ycnBHbnE1R3R2N1NqUVRIVndCSzIxVFcxZTR2TW41YTc3Z3FSeU5h?=
 =?utf-8?B?NDR2UnVUTEhqaVBlRTZKWFQwQ0FWRFg5MEtVOGxYZ1RndGdXYmUrTnFXSzZZ?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F39794EE8D53F84593696DD36F41C36A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ee401d-6ef8-4771-ddc1-08db9326ea99
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 07:05:55.6930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWMRqs9N4WtVaGHDcUBR+uUqQEtlT/39Fjuvx8CCWGGad3nt/WE7oJjP/aDBXTeY6EqonBG+LztPNW21AqpSaDMRm335CQHKW6fE/F15OZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5680
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXVnZW4sDQoNCk9uIE1vbiwgMjAyMy0wNy0zMSBhdCAxMTozMiArMDMwMCwgRXVnZW4gSHJp
c3RldiB3cm90ZToNCj4gT24gNy8zMS8yMyAxMToyMSwgSmFzb24tSkggTGluICjmnpfnnb/npaUp
IHdyb3RlOg0KPiA+IEhpIEV1Z2VuLA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgdGhlIHJldmlld3Mu
DQo+ID4gDQoNCnNuaXAuLi4NCg0KPiA+ID4gPiArCQkJaWYgKHRlbXBfZHJtX3ByaXYtPmRhdGEt
Pm1haW5fbGVuKQ0KPiA+ID4gPiArCQkJCWFsbF9kcm1fcHJpdlswXSA9DQo+ID4gPiA+IHRlbXBf
ZHJtX3ByaXY7DQo+ID4gPiA+ICsJCQllbHNlIGlmICh0ZW1wX2RybV9wcml2LT5kYXRhLT5leHRf
bGVuKQ0KPiA+ID4gPiArCQkJCWFsbF9kcm1fcHJpdlsxXSA9DQo+ID4gPiA+IHRlbXBfZHJtX3By
aXY7DQo+ID4gPiA+ICsJCQllbHNlIGlmICh0ZW1wX2RybV9wcml2LT5kYXRhLQ0KPiA+ID4gPiA+
dGhpcmRfbGVuKQ0KPiA+ID4gPiArCQkJCWFsbF9kcm1fcHJpdlsyXSA9DQo+ID4gPiA+IHRlbXBf
ZHJtX3ByaXY7DQo+ID4gPiA+ICsJCX0NCj4gPiA+IA0KPiA+ID4gUHJldmlvdXNseSB0aGUgY29k
ZSB3YXMgYXNzaWduaW5nIHN0dWZmIGludG8gYWxsX2RybV9wcml2W2NudF0NCj4gPiA+IGFuZA0K
PiA+ID4gaW5jcmVtZW50aW5nIGl0Lg0KPiA+ID4gV2l0aCB5b3VyIGNoYW5nZSwgaXQgYXNzaWdu
cyB0byBhbGxfZHJtX3ByaXZbMF0sIFsxXSwgWzJdLiBJcw0KPiA+ID4gdGhpcw0KPiA+ID4gd2hh
dA0KPiA+ID4geW91IGludGVuZGVkID8NCj4gPiANCj4gPiBCZWNhdXNlIGRldl9nZXRfZHJ2ZGF0
YShkcm1fZGV2KSB3aWxsIGdldCB0aGUgZHJpdmVyIGRhdGEgYnkNCj4gPiBkcm1fZGV2Lg0KPiA+
IEVhY2ggZHJtX2RldiByZXByZXNlbnRzIGEgZGlzcGxheSBwYXRoLg0KPiA+IGUsZy4NCj4gPiBk
cm1fZGV2IG9mICJtZWRpYXRlayxtdDgxOTUtdmRvc3lzMCIgcmVwcmVzZW50cyBtYWluIHBhdGgu
DQo+ID4gZHJtX2RldiBvZiAibWVkaWF0ZWssbXQ4MTk1LXZkb3N5czEiIHJlcHJlc2VudHMgZXh0
IHBhdGguDQo+ID4gDQo+ID4gU28gd2Ugd2FudCB0byBtYWtlIHN1cmUgYWxsX2RybV9wcml2W10g
c3RvcmUgdGhlIHByaXZhdGUgZGF0YSBpbg0KPiA+IHRoZSBvcmRlciBvZiBkaXNwbGF5IHBhdGgs
IHN1Y2ggYXM6DQo+ID4gYWxsX2RybV9wcml2WzBdID0gdGhlIHByaXZhdGUgZGF0YSBvZiBtYWlu
IGRpc3BsYXkNCj4gPiBhbGxfZHJtX3ByaXZbMV0gPSB0aGUgcHJpdmF0ZSBkYXRhIG9mIGV4dCBk
aXNwbGF5DQo+ID4gYWxsX2RybV9wcml2WzJdID0gdGhlIHByaXZhdGUgZGF0YSBvZiB0aGlyZCBk
aXNwbGF5DQo+IA0KPiBJZiB5b3UgaGF2ZSBzdWNoIGEgaGFyZCByZXF1aXJlbWVudCBmb3Iga2Vl
cGluZyBlbGVtZW50cyBpbiBhbg0KPiBhcnJheSwgDQo+IHlvdSBhcmUgYmV0dGVyIGhhdmluZw0K
PiBkcm1fcHJpdl9tYWluX2Rpc3BsYXkNCj4gZHJtX3ByaXZfZXh0X2Rpc3BsYXkNCj4gZHJtX3By
aXZfdGhpcmRfZGlzcGxheQ0KPiANCj4gS2VlcGluZyB0aGVtIGluZGV4ZWQgaW4gYSB0aHJlZSBl
bGVtZW50cyBhcnJheSBieSBoYXZpbmcgbm8gbG9naWNhbCANCj4gY29ubmVjdGlvbiBiZXR3ZWVu
IHRoZSBudW1iZXIgWzAsMSwyXSBhbmQgdGhlIGFjdHVhbCBkaXNwbGF5cyB0aGF0DQo+IHlvdSAN
Cj4gd2FudCB0byBzYXZlIGlzIGEgYml0IGNvbmZ1c2luZy4NCj4gDQoNClllcywgSSB0aGluayBp
dCB3YXMgYSBiaXQgY29uZnVzaW5nLg0KDQpCdXQgd2UgZG9uJ3Qga25vdyB3aGljaCBkcm1fcHJp
diB3aWxsIGdvIGludG8gdGhpcyBmdW5jdGlvbiBmaXJzdCBhbmQNCndlIHdhbnQgdG8gc3RvcmUg
YWxsIGRybV9wcml2IGludG8gdGhlIHNhbWUgYXJyYXkuDQpTbyBpdCBoYXMgY29tZSB0byB0aGlz
Lg0KDQo+IE9uZSBvdGhlciBvcHRpb24gd2hpY2ggSSBkb24ndCBrbm93IGlmIGl0J3MgYmV0dGVy
IG9yIG5vdCBpcyB0byBoYXZlDQo+IG1hY3JvcyB0byBoaWRlIHlvdXIgaW5kZXhlZCBhcHByb2Fj
aDoNCj4gYWxsX2RybV9wcml2W01BSU5fRElTUExBWV0gLi4uDQo+IGV0Yy4NCj4gDQoNClRoYW5r
cyBmb3IgeW91ciBhZHZpY2UuDQpJJ2xsIHRyeSB0byB1c2UgbWFjcm9zIHRvIG1ha2UgaXQgYmV0
dGVyIGFuZCBtb3JlIHJlYWRhYmxlLg0KDQo+ID4gDQo+ID4gDQo+ID4gPiBJZiB0aGlzIGxvb3Ag
aGFzIHNlY29uZCBydW4sIHlvdSB3aWxsIHJlYXNzaWduIHRvIGFsbF9kcm1fcHJpdg0KPiA+ID4g
YWdhaW4NCj4gPiA+ID8NCj4gPiANCj4gPiBCZWNhdXNlIHRoZSBwcmV2aW91cyBjb2RlIHdpbGwg
c3RvcmUgYWxsX2RybV9wcml2W10gaW4gdGhlIG9yZGVyIG9mDQo+ID4gbXRrX2RybV9iaW5kKCkg
d2FzIGNhbGxlZC4NCj4gPiANCj4gPiBJZiBkcm1fZGV2IG9mIGV4dCBwYXRoIGJvdW5kIGVhcmxp
ZXIgdGhhbiBkcm1fZGV2IG9mIG1haW4gcGF0aCwNCj4gPiBhbGxfZHJtX3ByaXZbXSBpbiBtdGtf
ZHJtX2dldF9hbGxfZHJtX3ByaXYoKSBtYXkgYmUgcmUtYXNzaWduZWQNCj4gPiBsaWtlDQo+ID4g
dGhpczoNCj4gPiBhbGxfZHJtX3ByaXZbMF0tPmFsbF9kcm1fcHJpdlswXSA9IHByaXZhdGUgZGF0
YSBvZiBleHQgcGF0aA0KPiA+IGFsbF9kcm1fcHJpdlsxXS0+YWxsX2RybV9wcml2WzBdID0gcHJp
dmF0ZSBkYXRhIG9mIGV4dCBwYXRoDQo+ID4gYWxsX2RybV9wcml2WzBdLT5hbGxfZHJtX3ByaXZb
MV0gPSBwcml2YXRlIGRhdGEgb2YgbWFpbiBwYXRoDQo+ID4gYWxsX2RybV9wcml2WzFdLT5hbGxf
ZHJtX3ByaXZbMV0gPSBwcml2YXRlIGRhdGEgb2YgbWFpbiBwYXRoDQo+ID4gDQo+ID4gQnV0IHdl
IGV4cGVjdCBhbGxfZHJtX3ByaXZbXSBiZSByZS1hc3NpZ25lZCBsaWtlIHRoaXM6DQo+ID4gYWxs
X2RybV9wcml2WzBdLT5hbGxfZHJtX3ByaXZbMF0gPSBwcml2YXRlIGRhdGEgb2YgbWFpbiBwYXRo
DQo+ID4gYWxsX2RybV9wcml2WzFdLT5hbGxfZHJtX3ByaXZbMF0gPSBwcml2YXRlIGRhdGEgb2Yg
bWFpbiBwYXRoDQo+ID4gYWxsX2RybV9wcml2WzBdLT5hbGxfZHJtX3ByaXZbMV0gPSBwcml2YXRl
IGRhdGEgb2YgZXh0IHBhdGgNCj4gPiBhbGxfZHJtX3ByaXZbMV0tPmFsbF9kcm1fcHJpdlsxXSA9
IHByaXZhdGUgZGF0YSBvZiBleHQgcGF0aA0KPiANCj4gVGhpcyBleHBlY3RhdGlvbiBkb2VzIG5v
dCBhcHBlYXIgdG8gYmUgcmVhbGx5IGVuZm9yY2VkIGluIHlvdXIgY29kZS4NCj4gWW91IGhhdmUg
YSBkcml2ZXIgdGhhdCBrZWVwcyBhbiBhcnJheSB3aXRoIGFsbF9kcm1fcHJpdltdLCBpbiB3aGlj
aA0KPiB5b3UgY2FuIGhhdmUgbWFpbiBwYXRoIG9yIGV4dCBwYXRoLiBUaGVuIGl0J3MgbmF0dXJh
bCB0aGF0IHRoZXkNCj4gbWlnaHQgDQo+IGhhdmUgd2hpY2hldmVyIG9yZGVyIGluIHRoZSBhcnJh
eSB5b3UgYXJlIHBsYWNpbmcgdGhlbSBpbnRvLg0KPiBJZiB5b3UgaGF2ZSBhIGhhcmQgZW5mb3Jj
ZWQgb3JkZXIgb2Yga2VlcGluZyBlbGVtZW50cyBpbiB5b3VyIGFycmF5LA0KPiB0aGVuIGFuIGlu
ZGV4ZWQgYXJyYXkgaXMgbm90IHRoZSBiZXN0IG9wdGlvbiBoZXJlLg0KPiBZb3UgY2FuIGVpdGhl
cjogbW92ZSB0byBhIGRpZmZlcmVudCB0eXBlIG9mIGFycmF5ICwgd2l0aCBtYWNyb3MgZm9yIA0K
PiBpbmRleGVzIGludG8gdGhlIGFycmF5LCBvciwgc3RvcmUgYSBzZWNvbmQgYXJyYXkvZmllbGQg
d2hpY2gga2VlcHMNCj4gdGhlIA0KPiBpbmRleCBpbiB3aGljaCB5b3Ugc2F2ZWQgZWFjaCBlbGVt
ZW50Lg0KPiANCj4gVGhpcyBpcyBqdXN0IG15IG9waW5pb24gLCBieSBsb29raW5nIGF0IHlvdXIg
Y29kZS4NCj4gDQoNClRoZXJlIGlzIGFub3RoZXIgc3RhdGVtZW50IGluIG10a19kcm1fa21zX2lu
aXQoKSBsaWtlIHRoaXM6DQoNCmZvciAoaSA9IDA7IGkgPCBNQVhfQ1JUQzsgaSsrKSB7DQoJZm9y
IChqID0gMDsgajwgcHJpdmF0ZS0+ZGF0YS0+bW1zeXNfZGV2X251bTsgaisrKSB7DQoJCXByaXZf
biA9IHByaXZhdGUtPmFsbF9kcm1fcHJpdmF0ZVtqXTsNCg0KCQkJaWYgKGkgPT0gMCAmJiBwcml2
X24tPmRhdGEtPm1haW5fbGVuKSB7DQoJCQkJLi4uDQoJCQl9IGVsc2UgaWYgKGkgPT0gMSAmJiBw
cml2X24tPmRhdGEtPmV4dF9sZW4pIHsNCgkJCQkuLi4NCgkJCX0gZWxzZSBpZiAoaSA9PSAyICYm
IHByaXZfbi0+ZGF0YS0+dGhpcmRfbGVuKSB7DQoJCQkJLi4uDQoJCQl9DQoJfQ0KfQ0KDQpTbyB3
ZSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IGVhY2ggZWxlbWVudCBpbiBhbGxfZHJtX3ByaXZbXSBo
YXMgb25seQ0Kb25lIHBhdGggZGF0YToNCmFsbF9kcm1fcHJpdlswXSBoYXMgbWFpbl9wYXRoIGRh
dGEgb25seQ0KYWxsX2RybV9wcml2WzFdIGhhcyBleHRfcGF0aCBkYXRhIG9ubHkNCmFsbF9kcm1f
cHJpdlsyXSBoYXMgdGhpcmRfcGF0aCBkYXRhIG9ubHkNCg0KSSB0aGluayBpdCB3b3VsZCB0YWtl
IHF1aXRlIGEgYml0IG9mIGVmZm9ydCB0byBjaGFuZ2UgdGhpcyBhcnJheSB1c2FnZS4NCg0KPiA+
ID4gSSB3b3VsZCBleHBlY3QgeW91IHRvIHRha2UgYGNudGAgaW50byBhY2NvdW50Lg0KPiA+ID4g
QWxzbywgaXMgaXQgZXhwZWN0ZWQgdGhhdCBhbGxfZHJtX3ByaXYgaGFzIGhvbGVzIGluIHRoZSBh
cnJheSA/DQo+ID4gDQo+ID4gRWFjaCBkcm1fZGV2IHdpbGwgb25seSBjYWxsZWQgbXRrX2RybV9i
aW5kKCkgb25jZSwgc28gYWxsIGhvbGVzDQo+ID4gd2lsbCBiZSBmaWxsZWQgYWZ0ZXIgYWxsIGRy
bV9kZXYgaGFzIGNhbGxlZCBtdGtfZHJtX2JpbmQoKS4NCj4gPiANCj4gPiBEbyB5b3UgYWdyZWUg
d2l0aCB0aGlzIHN0YXRlbWVudD8gOikNCj4gDQo+IEF0IHRoZSBtb21lbnQgSSBjYW5ub3QgYWdy
ZWUgbm9yIGRpc2FncmVlLCBJIGRvbid0IGtub3cgdGhlIGNvZGUNCj4gd2VsbCANCj4gZW5vdWdo
LiBCdXQgd2hhdCBJIGNhbiBzYXksIGlzIHRoYXQgeW91IHNob3VsZCBub3QgcmVseSBvbiBmdXR1
cmUNCj4gY2FsbHMgDQo+IG9mIHRoZSBmdW5jdGlvbiB0byBmaWxsIHVwIHlvdXIgYXJyYXkgY29y
cmVjdGx5Lg0KPiANCg0KSSBhZ3JlZSB3aXRoIHlvdXIgb3BpbmlvbiwgYnV0IGF0IHRoZSBtb21l
bnQsIEkganVzdCB3YW50IHRvIGZpeCB0aGUNCmlzc3VlIGZpcnN0IGJ5IGhhdmluZyBhIGxlc3Mg
bW9kaWZpY2F0aW9uLg0KDQpJJ2xsIHRyeSB0byB1c2UgbWFjcm9zIHRvIHJlcGxhY2UgdGhlIGFy
cmF5IGluZGV4IGFuZCBJJ2xsIGFkZCBtb3JlDQpkZXNjcmlwdGlvbiBpbnRvIGNvbW1pdCBtZXNz
YWdlIHRvIGV4cHJlc3MgdGhlIGN1cnJlbnQgbGltaXRhdGlvbiBpbg0KbXRrX2RybV9rbXNfaW5p
dCgpLg0KDQpUaGFua3MgYWdhaW5+DQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiA+IA0K
PiA+IFJlZ2FyZHMsDQo+ID4gSmFzb24tSkguTGluDQo+ID4gDQo+ID4gPiANCj4gPiA+IEV1Z2Vu
DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+ICAgIAl9DQo+ID4gPiA+ICAgIA0KPiA+
ID4gPiAgICAJaWYgKGRybV9wcml2LT5kYXRhLT5tbXN5c19kZXZfbnVtID09IGNudCkgew0KPiA+
ID4gDQo+ID4gPiANCj4gDQo+IA0K
