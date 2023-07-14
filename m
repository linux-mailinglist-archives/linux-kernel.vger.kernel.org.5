Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AEC753668
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjGNJ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjGNJ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:27:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB612D55
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:27:24 -0700 (PDT)
X-UUID: a08ecc1a222811eeb20a276fd37b9834-20230714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qA4b2FKDbkjW0aSuqcIQg7pscgBbR9tVUJ3a4C1d20o=;
        b=TqZIyFeWO8htxYMBYp11Lrs7cQpgWk7t3GRCe2xPK7HlMwCo7Qqo6mAIPILRKyyVzB5dCZDGjr1keUbbuLiPD+9YMD2jHqaNj6qPLqPEEqIXZleAxBriFVfYCz2hbNc6VnL+/jOC3Drl8Ar0PVFi1YZT2IRqXC3jI8akQfTR76o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:9e7bdec2-083c-42dc-b1b7-e6fbae1db399,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:0a91a98e-7caa-48c2-8dbb-206f0389473c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a08ecc1a222811eeb20a276fd37b9834-20230714
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 55664591; Fri, 14 Jul 2023 17:27:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jul 2023 17:27:17 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jul 2023 17:27:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDy8NFbvrcmepotcYbXxSVKDsnE/4mH6eJmsxuDZU/F/oCV8xEc5vTcorIzeTSlYuHGN/VgQdB2s26AKtKmuUKcPZz2V5nCV31S5PUv5hgA+mE52A1XdNdfHTCZAx2h/DljTYQFLkzdTtRkB6XMXc5cMVi0Zc8dWxolGq73n3ZFS4mI2DPWObqbgp2i3FVOupI/k9jliDOfo43KKfhpklpDq9y51xSx9PWT6inj3J2NYHxglhgMijhlGLOsYxc6QZK/Df2V2EzcHxrHAkm77VQfcHaLmLqIJ6GiI/VGeC/nQMmNjonpISFx4VOevHem3OpQk68ankzo1I9eyh5RT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA4b2FKDbkjW0aSuqcIQg7pscgBbR9tVUJ3a4C1d20o=;
 b=LYTnmuXq1qejJySLr+PBw9GhqhYDV2lLl5B52Qi1vp+Ho/kBnmhOQ9zrA0oOdQWrEdvOrIvxMErHGHlw97+EdyigP//0nnoe0hl6pQfeuRDsPYYMIj5v4RrUFYtluJ6t2o7QHYJQJqobluOyoJQlwZDR118FnP8JRVlzR1PUW+BzHqb4UWbMSnRV5OIQNvCtj9XGIuGIngpi3ee2yNuDp2APPzCmP+t2Ub80c+6dNAqDMQXeiXw0DoCCTa6onZ6AI6v9CUBYv+VPUfswh0b/Oj0YNPHvCHtohvazNlE2Bdd9/aCETS2dPz1jm0XhlHpWAaWuS+24ODUongmyQggH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA4b2FKDbkjW0aSuqcIQg7pscgBbR9tVUJ3a4C1d20o=;
 b=K8/UB1s1SLTxmYpLS1qDRmLAYGLbknmBeM+rJVTRtk9EH/ZaU5xyD4JjHQ9MTE1nEPadm0+1ZvuRRvH63f+87pzbUU4GRzdeb4ndVEPqI6l8TvW5vJ/nPgPye9qOPMUG/eW1c7LBKMiXAy7nU+h8qEEsW2ujxK/o96aXumpJQhk=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by TYZPR03MB5549.apcprd03.prod.outlook.com (2603:1096:400:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 09:27:14 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::a4a4:6568:36f8:a4d9]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::a4a4:6568:36f8:a4d9%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:27:14 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2] drm/mediatek: fix uninitialized symbol
Thread-Topic: [PATCH v2] drm/mediatek: fix uninitialized symbol
Thread-Index: AQHZc/dS0+UnhHpH9UKQpbsnSvSsEK+5gs+A
Date:   Fri, 14 Jul 2023 09:27:14 +0000
Message-ID: <ae96299cffaacdbf51beae96e3a257c95a04ac95.camel@mediatek.com>
References: <20230421021609.7730-1-nancy.lin@mediatek.com>
In-Reply-To: <20230421021609.7730-1-nancy.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|TYZPR03MB5549:EE_
x-ms-office365-filtering-correlation-id: b1b7683e-8680-495e-1799-08db844c8241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: piftb9G+4lHTC2JwMTZsoqWlRC+YEwBfD9dWqWg1xel+81eNITgOLv4jChlEat6vdtVMG/lDa2f7f2K02ci08NiSg1Xx/znm9QgrKXZjij1ovJPBhChbMvoi8w0bUCVOYznTb+nM1DO1YKmIKU2NsonKF1uAJobRYxSqHSaqvx7siFI4UngWZwO/SRemBZq3zQrFnqfFYuDOYKYDUl4HICobYuooG25JMkpGNncYe0963kAObLJZVI8/G7RQWfhHCOCG2msHRlwx7jdh88iLl7ktOH39djjUJVylQAWArDdo1sUFOU5iiR7YZH8KSENxvm5M9boWvjoFNQ3b2JlVBWQwO2k3OWyF6GAwiGf/AgjiPQuz1WWGtd3b5aQ0Uqa0tbBccMJQDZbk1k8XBF+KwS7EgGs39MKMVtXbBlHXfiwB5dChaYGW+bG4Eo8w34KDRSvaNit4b/IuZQJ6rojyp6dyCgAGL8btcP47j9SQKRavO01OT6PlwdCwZe6ne4o8zgocaCsIrIz0agVgXI3xNY33cOgTqJh+dlcvUke5H5ZgldfR7QR5DcTys8MVi7QdAKY6ijC5QZ2Cp5T7oAVQnsvklK4zKEm7cCh8fdmN7dOBPO1+2cb6w+udBYo+vnBvFaFlZTmZEu6nmXkgT4sO1vu8x/txksy4MnEH6EPLcSE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(2616005)(6486002)(186003)(36756003)(85182001)(83380400001)(6512007)(6506007)(26005)(71200400001)(107886003)(64756008)(66946007)(66446008)(66476007)(66556008)(4326008)(91956017)(76116006)(478600001)(110136005)(54906003)(122000001)(316002)(38070700005)(41300700001)(5660300002)(38100700002)(8936002)(8676002)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0xIclNDQmNSK2xnQUdkTjhLQklsZHBmMW4waWJEYmNocktsL016bjlwaGxj?=
 =?utf-8?B?bVppcDJEL0E2S1NXVkNnNTdDWnBET3J6TVRoWDByaER2U0M3K3hzdzYzdGFU?=
 =?utf-8?B?MmNVZ0ZoUVl6b3lSeE83VXluMHM0SFgyaTkzSXpsUXljWVFsUGx2NWVEcnZ1?=
 =?utf-8?B?dWY3WHNPb012UW9saWc1Zk10RGkyOEF1Q0h0SXdlQWMwdW8xUGZaN1VMbzkv?=
 =?utf-8?B?Rk8vdzRmZGJZL3dXRDNNaDNjelk4dFBZVEQ5cEt5ak9zUTRjZi9ha0dTbmxB?=
 =?utf-8?B?TkF0dXdDajgvK29VUURMVXQ1OGFKK2x4N2FkQmkzT2Z6VGN1YndRWUVUZXVE?=
 =?utf-8?B?VkI2MlllMEp2SlpscGNyNzBBU2srSGd3aE05alB4UkZFVUROM3VGT0tqTjkx?=
 =?utf-8?B?S2hjYkZhUmlpTmhGeW1Kc2d2bXkzMnlRUHduT2Z6OE1XTW8wanFraUZpVlI1?=
 =?utf-8?B?dDh0Nm1XMUoyUkFScXk3WGN5WUNrUFZpcmpFbmdGVW1SNXJ1OEM4V1FrUzYz?=
 =?utf-8?B?NitKNDNGa0lNZEtEWFRwNG9maDRUR2NyM09uc2d3YXJickgvSS82bEp4OER5?=
 =?utf-8?B?bGk3VTdrMWhRTUFLR2ZYWmJzNTU2RzhIUW1lOUU5UTc2QkJhdHhWbytwR0tZ?=
 =?utf-8?B?d1hpWmFoNFdpRUtRM2svcS9pZytFWXZjZXNUY2NlOElBSHVNSzlKQzFiTTZm?=
 =?utf-8?B?TGgyMTNnUWZ4Q0N1R0ZEa3Q4ZXYrZFdJcWtkU1FRRGh6K2V3MFdBVm9HRHdN?=
 =?utf-8?B?WERsL1JoamhrbXo0L3pqb0I4QndUNTNqaWcyd25SRzNiQ0FzQlo0Znp0bm5T?=
 =?utf-8?B?YXYvWEltY1dHTTgzMUluQ0hST0JRRUlKcGxJcnZBQWZJU0xpWUN5N1ZhRGwz?=
 =?utf-8?B?MFNNSUo5Z2lCZUt4VWhSNlBKYncyckRYR1pUcXhKL2pFZXJIU2sxVExtVi9T?=
 =?utf-8?B?Qm9NYXYrWmxrUzFzdDVDU0RaczNQNWdrL3VkcnlVTXI0ZkViVnFHVWdxSjZq?=
 =?utf-8?B?ZUF1K081WG9vM2ZGSERGbU42RmtMeFlkL2l0V3p3SVg1bXNIVGNueFhYSy9y?=
 =?utf-8?B?cFc5Si9YRnBvYlpkM0RiaGgwYzFBSTYxdWloT01TNFlqais0WVd3UmEwa1Z2?=
 =?utf-8?B?UXFMRjgwYlVGU0VyWXp3aTEydkRBMHhLaUoyNTMrcVFJUVh6bVNPVzBUeURx?=
 =?utf-8?B?ckRJUmdtaTI5aFZBWEpEMkRzeElMZEo5MXI1UjJpbk9lL2RTUHZmaVJodVpZ?=
 =?utf-8?B?RG5Ba3pKTkdscTN1aFNORFNzaDBQZS85OVVvMEhkbUovbGxZNDNncVlGeFpi?=
 =?utf-8?B?MjFPd2lMUEVPSFI3WU9aME1udExvajVTQ25YcytkV3FqN3o0QXk5a0ZBL3pX?=
 =?utf-8?B?M0pIZDZXczNSWkdNMk5OeW5BVDBMU2lxSjB2bHk2N1d6SG1KSWx0a2Mybnla?=
 =?utf-8?B?MVp2ZUEyczRmdGtWcmM0TitiVXhnazRXeW1GTTJBSjFBTjkrLzFlcytBTXZZ?=
 =?utf-8?B?N1ZTbUVTWlk5VThpTkZTQUZWcmsyWENaTENhNExjMk1FZ05uSkgwTTEwTmhk?=
 =?utf-8?B?c3h2WVk4REtkN21Kc0VLK1ZTc29SWk5uTXc2Y3lWR25iOXNBeHRqQWpUZjBG?=
 =?utf-8?B?ZlZDZGhQNVJyMnl3Z2wzbmJRRmRDWEZXTDNOeCtmOWJJNzJhKzlmZFpXaWFT?=
 =?utf-8?B?a1FSK1dEbjlaWVdxWjVuR1BlUFBhZDFKanJ2TUdCcnZkb2I4NU1UcTlkZXhu?=
 =?utf-8?B?aGxQUzNxVHdXUGs1YXFuWFdNTlVzNGx5UGljNTAxMkVLSDM1RWJnQjRrWjlk?=
 =?utf-8?B?MmZyVlBQMXhJeU5qN0toQnV4TkFzRmx1VVByU3NoUVhQdTljaU9XenpIaWkr?=
 =?utf-8?B?UFhLNHhlVlFNSlczYTU0V1kwSWpQZ1lxUnVVN2trTkp5N01tTjBwQWtZNkps?=
 =?utf-8?B?UFBrNzlNbCs0WTRjcC9DVk1tb3o1bEpTOWJIZWJnUGh4Q0xMTEI4YW9qNE5X?=
 =?utf-8?B?MStKaVc0WlVMSjdsQllNOVVpSk41cnREYitzbFdiSDFrbjYxKzV2NG4vYzV1?=
 =?utf-8?B?eTFReXc4T2VTRkVPdlJhTFVoREdtVGQ5cFpoc2U1aDVnbU9ITlFMRDBMeFRW?=
 =?utf-8?Q?6ZjB1vIB76aX+hd6wRyQtvrm7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F183907D78C655428590645225D05662@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b7683e-8680-495e-1799-08db844c8241
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 09:27:14.0510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQdE1Kx/EFVsMlyMj7mAS6Z3PCAE6VswhStsSuNxfLg/t3309Ir05gTErSTSsXOUzWNRtdZYR5bGXu6cYLWn9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5549
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE5hbmN5Og0KDQpPbiBGcmksIDIwMjMtMDQtMjEgYXQgMTA6MTYgKzA4MDAsIE5hbmN5Lkxp
biB3cm90ZToNCj4gZml4IFNtYXRjaCBzdGF0aWMgY2hlY2tlciB3YXJuaW5nDQo+ICAgLSB1bmlu
aXRpYWxpemVkIHN5bWJvbCBjb21wX3BkZXYgaW4gbXRrX2RkcF9jb21wX2luaXQuDQo+IA0KPiBG
aXhlczogMGQ5ZWVlOTExOGI3ICgiZHJtL21lZGlhdGVrOiBBZGQgZHJtIG92bF9hZGFwdG9yIHN1
YiBkcml2ZXINCj4gZm9yIE1UODE5NSIpDQo+IFNpZ25lZC1vZmYtYnk6IE5hbmN5LkxpbiA8bmFu
Y3kubGluQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+IHYyOiBhZGQgRml4ZXMgdGFnDQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyB8IDUgKysrKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBpbmRl
eCBmMTE0ZGE0ZDM2YTkuLmU5ODdhYzQ0ODFiYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IEBAIC01NDYsNyArNTQ2LDcgQEAgdW5zaWdu
ZWQgaW50DQo+IG10a19kcm1fZmluZF9wb3NzaWJsZV9jcnRjX2J5X2NvbXAoc3RydWN0IGRybV9k
ZXZpY2UgKmRybSwNCj4gIGludCBtdGtfZGRwX2NvbXBfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5vZGUsIHN0cnVjdCBtdGtfZGRwX2NvbXANCj4gKmNvbXAsDQo+ICAJCSAgICAgIHVuc2lnbmVk
IGludCBjb21wX2lkKQ0KPiAgew0KPiAtCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmNvbXBfcGRl
djsNCj4gKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpjb21wX3BkZXYgPSBOVUxMOw0KPiAgCWVu
dW0gbXRrX2RkcF9jb21wX3R5cGUgdHlwZTsNCj4gIAlzdHJ1Y3QgbXRrX2RkcF9jb21wX2RldiAq
cHJpdjsNCj4gICNpZiBJU19SRUFDSEFCTEUoQ09ORklHX01US19DTURRKQ0KPiBAQCAtNTg4LDYg
KzU4OCw5IEBAIGludCBtdGtfZGRwX2NvbXBfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUs
DQo+IHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsDQo+ICAJICAgIHR5cGUgPT0gTVRLX0RTSSkN
Cj4gIAkJcmV0dXJuIDA7DQo+ICANCj4gKwlpZiAoIWNvbXBfcGRldikNCj4gKwkJcmV0dXJuIC1F
UFJPQkVfREVGRVI7DQoNCkluIGxpbmUgNTY2LCB0aGUgc3RhdGVtZW50IGlzDQoNCmlmIChub2Rv
KSB7DQoJY29tcF9wZGV2ID0gLi4uDQp9DQoNClRoZSBjb21tZW50IHNheXMgdGhhdCBvbmx5IG92
bF9hZGFwdG9lciBoYXMgbm8gZGV2aWNlIG5vZGUsIHNvIHRoZQ0KY2hlY2tpbmcgc2hvdWxkIGJl
DQoNCmlmICh0eXBlICE9IE1US19ESVNQX09WTF9BREFQVE9SKSB7DQoJY29tcF9wZGV2ID0gLi4u
DQp9DQoNCmFuZCBsYXRlciBpdCB3b3VsZCByZXR1cm4gd2hlbiB0eXBlID0gTVRLX0RJU1BfT1ZM
X0FEQVBUT1IsDQpzbyB0aGVyZSB3b3VsZCBiZSBubyBwcm9ibGVtIG9mIHVuaW5pdGlhbGl6ZWQg
c3ltYm9sLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICAJcHJpdiA9IGRldm1fa3phbGxvYyhj
b21wLT5kZXYsIHNpemVvZigqcHJpdiksIEdGUF9LRVJORUwpOw0KPiAgCWlmICghcHJpdikNCj4g
IAkJcmV0dXJuIC1FTk9NRU07DQo=
