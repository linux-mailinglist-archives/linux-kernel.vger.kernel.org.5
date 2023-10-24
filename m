Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E437D4CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjJXJkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjJXJkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:40:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488C0D7E;
        Tue, 24 Oct 2023 02:39:57 -0700 (PDT)
X-UUID: 486a530a725111ee8051498923ad61e6-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=o7X/J6iha7iAmO/vOHJrDsz+t6GEhzfaW4LMOFqFk90=;
        b=qkgHUBOLhy/VE8eoWsR/Eg15Tf0OZRzSN2vLQjL/AS7VmKlsfrC2aDSuXsSyIpLHBhKDJb4hS5XM1rteUQovhK0/0Z6+EOq9p205De6q1OS+cjKkPy8ldTTUUJZJv7n1j9xKzD629hNXmW8x965RSR343GDw6l/1tnel1XXRZsE=;
X-CID-CACHE: Type:Local,Time:202310241725+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:825c60e8-a489-4ac6-9605-f95093ad48ca,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:501241d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 486a530a725111ee8051498923ad61e6-20231024
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 759444310; Tue, 24 Oct 2023 17:39:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 17:39:51 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 17:39:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxBgcxoUkpukzxzfWyR72xiIdP/plNTo+mg1YocZ0o0XF/hA3niAE0Zb9AhVvw0p2Fp7PjWC9deu4qPz76YKem1y4CkOyJfnHb8ViIXYclqMMTt/Y7lboxHwvfxL+5g3RPnMGHkXLodQXMW/9mNMNdA9nNNdNIrYJtQK5pcB+NAS/EkYGin4tI28famIyvb5i+a5eazBfzsDtssqig3d2T2aCmZ8HsYvuDkea8XFwi9Grag2btMP47d99zmgZNh+tPwL7DS+6WzQn0lXwr8XPhATTpJf/eineVx2r8EaXP+aY9UAhxK3CKALYmRv+iK4JTH5hDH9kjsrPLrhDv7rDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7X/J6iha7iAmO/vOHJrDsz+t6GEhzfaW4LMOFqFk90=;
 b=AECxY3OXAJ6FTezXVb9qx7ZHVyNUoZnVYBWJtUMX5ATXMkqKgshvOlZcQCryZVevSTSRlz9IyMQeKvbH66APST4IgYrlUTiYFr0sCAaHyhAc3oQRg4lbZ+9NmPTBz7q2pTotVDevr/GNSlkU6WWzNj/W+5XTwfzpoRV1SWFeonIO8rJUI34ALFZZG7S6A6PNRBrul6bKQg01Rj3nuvXTbSI+C7pndXAzCfORiB+yMalkMHsGuutHkvfL/2n+tZ87z7WgJiJkjuhY/pqRiWHHk4YzRT2wJHy4TMKTc28srdwIR5UmYKmb7fVUGH7qK082jUvs6tl1aVYuYEVVcVRnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7X/J6iha7iAmO/vOHJrDsz+t6GEhzfaW4LMOFqFk90=;
 b=pxvzdzNzacrQMEqiuwRDOeFn5E+K1ab/NBZ8pDv4rf6Mo6GKpvHtwqPHIkYu6fA1RiXbJV1M7/x+JiuKEBZVGMOKyXfPtkYHhKTjQLOAQcIoWus46KX2oATbPPcKZJLeEeWe+oNanMD1G2TNMUderG7QwX6u09WI9Eu7d/WhVv4=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by KL1PR03MB7405.apcprd03.prod.outlook.com (2603:1096:820:cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 09:39:48 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::7a6f:69a8:742c:af8f]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::7a6f:69a8:742c:af8f%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 09:39:48 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "johnson.wang@mediatek.corp-partner.google.com" 
        <johnson.wang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v10 15/24] drm/mediatek: Remove ineffectual power
 management codes
Thread-Topic: [PATCH v10 15/24] drm/mediatek: Remove ineffectual power
 management codes
Thread-Index: AQHaAlEpjCqpdSIYNkmXJD+uq8dQA7BYs2yAgAAD/4A=
Date:   Tue, 24 Oct 2023 09:39:48 +0000
Message-ID: <b606d465335db31235d9472d71c498eea10c3726.camel@mediatek.com>
References: <20231019055619.19358-1-shawn.sung@mediatek.com>
         <20231019055619.19358-16-shawn.sung@mediatek.com>
         <1f85f397425fa3332bd594e4b953593a1665287f.camel@mediatek.com>
In-Reply-To: <1f85f397425fa3332bd594e4b953593a1665287f.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|KL1PR03MB7405:EE_
x-ms-office365-filtering-correlation-id: 759b1e10-fd84-4dc7-3342-08dbd4752a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1VdcTRaN03fbAEbvYypIhctPt6T7P/ktU4PQSuL5VGRFxFOi4MWV8/h1J6OQXnSwf9BSh5TshAv1HbZ6VX3cOQyNRbosv2UKCe9vvmoavL9HbWvofOGfm4Qv5Qqfk1fjpR3h2RejEDX7KCBw7HuBHsHfN1bgRON/Eq3BqABHZL7tC/PX3LLWvsFC94d9Pgj9lCyEF7bcXj6/52JwkX8XhFM2S8pEuLp2K6IkO/kk1LxEFmq5WJzyvfOAYrR2Q5PHyIVlubXDerKNCcsitpnU14EFwwcipD5OcoNyubWNEtTULT2/xhbxzIfdx+dhd98jYGJx3qMr6e6KD9vH9Vlb/EenEvdwysVDdmMsTKhFZ9xwEs9BqYeuFJ4vvtrYsz/Y51KjWMUyMuZhoYhEhMqh03pY2lsctbS2eszGuOL2qzHJb0yk6hS6LzCWwrw1PiEN+ibyEc3es6xcmd/3vaTJjxFDZBlh5jfF52LE6Xo/2orCUnBF0cI8rUFkrGTkBHV7ofmGVOOQCzyBv/W3Vprx5g7e8DZIBQgygU4yseghaJ1GZILTZ6f5WhHrc+j4xLHDXb60t28QDkxEnkwpuJzAIuLZHTJwb3D2RWNsHWH82K28I1wx5RvxvLijufTCmysGtxt9+nRecT8jzypsxj2ZisPj7BlL/UK5z+OyR1xKBWc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(38070700009)(4001150100001)(38100700002)(2906002)(41300700001)(54906003)(7416002)(86362001)(36756003)(5660300002)(85182001)(8936002)(8676002)(4326008)(478600001)(71200400001)(6506007)(110136005)(66446008)(122000001)(64756008)(76116006)(66476007)(66556008)(66946007)(316002)(2616005)(83380400001)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elBPOTNUeWlQLzhoVmowbDArNk9tbDB5bnc3YWhGeTRpdDFpWmJRWVY3ZnhB?=
 =?utf-8?B?SGlVcm1jYmczTzVJQVhZTnk1Q0lkQndBcnpFWTJ6R29sOWNOa0pTYkdvVGdH?=
 =?utf-8?B?Y0VNZjRJWWZxQ1c5eVhlVXpsNkJBaGpwLzUycE1lNCs2K3FQd1hGK2I0bGlo?=
 =?utf-8?B?RTNtemlaeXhWbVR1TkdzcldsR3M5VEMxUVVhdGlsTkRseHRWM1V2b2ZDdGVL?=
 =?utf-8?B?QlhnY1owVmc2d1J2cEZWanNqYW0zQmpaYXRRUmRlQVcyME04WmZxSnoyRk04?=
 =?utf-8?B?WVZnK1JFMjIzU2JaMmw4eDZSRFdkU3A5ZkR0OTJqVURXamZ3YU5lWXc0UWI1?=
 =?utf-8?B?WHBVYWhHbi9SalZqRTlIc3MweDJFVGljYlFzeUprMGV5SktpQ0FqRGxRNDJ1?=
 =?utf-8?B?WVJKLzdNcyt6WG1UZk56VXIwaE80U2NnYjhnZjJoUERJOExGZFdBSDJ2ZnAy?=
 =?utf-8?B?bFNoWGtRVEFJeXdRQjlMZzdobjArSTNXL2xNRW0rZDQrYjFKQy92ZklnajZw?=
 =?utf-8?B?QlZmdUZHdFc3ZXdMWS9IWmN6NC9QckkvNkhzaUNkRTJqV0JIOXZGS3hSK00y?=
 =?utf-8?B?eGhDYXp6bnJSSFpKOTdxOGd0dW5JYjFoQzJNb015czdNYmlTNFhGdFdJdU0r?=
 =?utf-8?B?L0ppU1BZenRqR0lySzN1ZjQxaFJPQy83KzVFVzdoM1hBMVYzL0JwV1dTYXZJ?=
 =?utf-8?B?WHhvU004c1pmbGduMDNubDU3OWc2ZFc2Y3ZsQ3NFL3ZIYmxtY3MyT3ZDSTRY?=
 =?utf-8?B?VTVPVHdFZEdQRmZ1alhvUUZ6cTBLeXBkS1NOSGhId01NRlhOc1lTV1pkR2tW?=
 =?utf-8?B?Y0ZwYU9obC9wSEVJd0p0czJENDZnbk5KZUdQeGtGRi95Q3VSK00zSmpRQXpO?=
 =?utf-8?B?ZjE5MmNSZXpDRUJFM3dqTzF6NjY1bmdENmFYTU5CZ3IyNy9VWWVTN2VlaGNY?=
 =?utf-8?B?ZHVvWE1ONGNxdGp3dXlHVFFVT0xYTnRBODhrRzRvN0E2QklDRk4ydlVuOEpM?=
 =?utf-8?B?OTdSMHkzdzdNMXRrUXNFd0ZHRCs4NlNwT3hQVkY5VDg4Q3paajJSekFsWkIv?=
 =?utf-8?B?M0h0WkNxa1RjS1JFemIwb09qVTgvRG5aeURiYVdGQ2Z1MWliYTIvV25hcXVL?=
 =?utf-8?B?MDhTM3dUS1dBWnNJUTBaSHVwT25jYWgwZDRVeVhKa1VFd3JLTnNjNFV2aFNS?=
 =?utf-8?B?b2ttL1pTb1Q4RWgvaXA1N2lMUC9tam8wdnowU213ZFdlektNNjJaU21zclBS?=
 =?utf-8?B?KzBmL0k0TVVIVDJZWkd2eTVTQ2dNWk54dEZNeVhMc29GTXB3eU9jdkpsajU5?=
 =?utf-8?B?ZzJQd0V0T0xEeTljbHBWK2pDVXVvd3Q2dWNRa1E4MFN0emxHMXBVMlBjcUo3?=
 =?utf-8?B?bzJjcEYyaGU3Ri82U3FMTmlZcTcvT0c1UXdtNXlJaWg1VzNEQzkvN1lCSTB1?=
 =?utf-8?B?eHNmM3d3Y3dldm1KWWNwVmI1WjRkd0sweXFuK0RZNEtSMU9TZnNIcThCZnFX?=
 =?utf-8?B?cjd5T1FwUENXNjBvSjlpUUIxK0N6MllVc2JUK2ZvMEJSUzVyeXBLL1ZES0Ru?=
 =?utf-8?B?WWVYR0lFSGt0c09qT1RSTWczcWNYK1pjWDRjenpNZFc3d3JHRTl1Skoza3Ri?=
 =?utf-8?B?T1c0MmV6THdNQjNjcEcvMWZIRHNRQ0V4L2VWZklDU05sU1pMWTI5Rk9GSGZQ?=
 =?utf-8?B?NHk5MmlHeWZEamEwSE9VU20yV1ZPbWJUdHJHRlNmL2xySGJVWG1iVlkxUitw?=
 =?utf-8?B?dmZFRFJuWkxHR25Pdnp3bTBTSUFHZWNKSnljcWZpTnFoaDEyakpvdk1GZlVI?=
 =?utf-8?B?OWZ1T0xXdWdGSE5mSmlGU1ljN3RVWFRnUjR1SStyL1U2THBzNDNCcnpGNXJs?=
 =?utf-8?B?UVpJTkJPelpuTVMyeS9MbEJKMlZVcURNRzBObWh1UkpMdnFVZ0RsejZIVUc3?=
 =?utf-8?B?YXJ1d1hJbStKdDM3UENwYWFVM3FKR0lUNVBCNmlyK0d4Q3QzOVI4VHAvRCtv?=
 =?utf-8?B?NmlXTUsyNENDMUtKSWtpSUI2djlPaitHekthRVRGcVVpSTZkOXIxamF3T2dQ?=
 =?utf-8?B?c2Jscm5vR1RraHkybVFNZGdpNkJrbzhsa3VSZmREOWxhRkhUVWFVQnViNGRs?=
 =?utf-8?B?REJsMHlyM2xvYnhjbVRtRnU1ZGtNc3M5YjB2TnYySm8wY1FRNUJpa2NYS3Z0?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <705E33F0E22AEF4986D0A0CE5497A5A8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759b1e10-fd84-4dc7-3342-08dbd4752a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 09:39:48.3792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVE030nJCrTWXefCnGjUBB0dusKjml4kI9fsV7oysjCrEVASHz8YXz5VHb9156cCN63dEgzHCsKeGUucHrygTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7405
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.379500-8.000000
X-TMASE-MatchedRID: Y6GLOewO+JjUL3YCMmnG4ia1MaKuob8PofZV/2Xa0cK8k69NWNRZfPeJ
        lqUEMxA/A1bYR9JdxfO9v9L+KFaMuW+K2RTOFgGNh2VzUlo4HVNAq6/y5AEOOne9QDr8+LTcT/d
        mRd5jU4CJ5/VtcrgaKhKqjdlR+seHVJTV35UngiPil2r2x2PwtRQK/sD1nu4xfmHrLgoJIlwORS
        dM8kPk0J+CIvdU2ytiWSbyW4vPZbSPIr9Wpu0YXOYAh37ZsBDCfS0Ip2eEHnylPA9G9KhcvZkw8
        KdMzN86KrauXd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.379500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5A920AD8CFBE1FDE10B773CE465506E78A02F6CD3129A5D859621C7F523D84022000:8
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_WIPE_DEBT,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFR1ZSwgMjAyMy0xMC0yNCBhdCAwOToyNSArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBIc2lhby1jaGllbjoNCj4gDQo+IE9uIFRodSwgMjAyMy0xMC0x
OSBhdCAxMzo1NiArMDgwMCwgSHNpYW8gQ2hpZW4gU3VuZyB3cm90ZToNCj4gPiBEaXNwbGF5IG1v
ZHVsZXMgd2lsbCBiZSBwb3dlcmVkIG9uIHdoZW4gLmF0b21pY19lbmFibGUoKSwNCj4gPiB0aGVy
ZSBpcyBubyBuZWVkIHRvIGRvIGl0IGFnYWluIGluIG10a19jcnRjX2RkcF9od19pbml0KCkuDQo+
ID4gQmVzaWRlcywgdGhlIERSTSBkZXZpY2VzIGFyZSBjcmVhdGVkIG1hbnVhbGx5IHdoZW4gbXRr
LW1tc3lzDQo+ID4gaXMgcHJvYmVkIGFuZCB0aGVyZSBpcyBubyBwb3dlciBkb21haW4gbGlua2Vk
IHRvIGl0Lg0KPiA+IA0KPiA+IEZpeGVzOiAxMTlmNTE3MzYyOGEgKCJkcm0vbWVkaWF0ZWs6IEFk
ZCBEUk0gRHJpdmVyIGZvciBNZWRpYXRlayBTb0MNCj4gPiBNVDgxNzMuIikNCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIHwg
MTggKysrLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDE1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2NydGMuYw0KPiA+IGluZGV4IGJjNGNjNzVjY2ExOC4uYzdlZGQ4MGJlNDI4IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+IEBA
IC02LDcgKzYsNiBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ID4gICNpbmNsdWRl
IDxsaW51eC9kbWEtbWFwcGluZy5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbWFpbGJveF9jb250
cm9sbGVyLmg+DQo+ID4gLSNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ID4gICNpbmNs
dWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4
L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRp
YXRlay9tdGstbXV0ZXguaD4NCj4gPiBAQCAtMzYyLDIyICszNjEsMTYgQEAgc3RhdGljIGludCBt
dGtfY3J0Y19kZHBfaHdfaW5pdChzdHJ1Y3QNCj4gPiBtdGtfZHJtX2NydGMgKm10a19jcnRjLCBz
dHJ1Y3QgZHJtX2F0b21pYw0KPiA+ICAJCWRybV9jb25uZWN0b3JfbGlzdF9pdGVyX2VuZCgmY29u
bl9pdGVyKTsNCj4gPiAgCX0NCj4gPiAgDQo+ID4gLQlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9h
bmRfZ2V0KGNydGMtPmRldi0+ZGV2KTsNCj4gDQo+IGNydGMtPmRldi0+ZGV2IGlzIG1tc3lzIGRl
dmljZS4gSW4gbXQ4MTczLmR0c2ksIHlvdSBjb3VsZCBmaW5kIHRoYXQNCj4gbW1zeXMgaGFzIGl0
cyBvd24gcG93ZXIuIFNvIEkgdGhpbmsgd2Ugc2hvdWxkIGtlZXAgdGhpcy4NCj4gDQo+IFJlZ2Fy
ZHMsDQo+IENLDQoNCkRpZG4ndCBub3RpY2UgdGhpcyBkaWZmZXJlbmNlIGluIHRoZSBkdHMsIHRo
YW5rIHlvdSBmb3IgY2hlY2tpbmcuDQpXaWxsIHJlbW92ZSB0aGlzIHBhdGNoIGluIHRoZSBuZXh0
IHZlcnNpb24uDQoNClRoYW5rcywNClNoYXduDQo=
