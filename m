Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB1D7D901A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345456AbjJ0Hm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0Hmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:42:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14FF192;
        Fri, 27 Oct 2023 00:42:45 -0700 (PDT)
X-UUID: 66075474749c11ee8051498923ad61e6-20231027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RBByflb5c6ZUK9BbCZD/O1VzwXb4hlxA6ZKtmi7CW7I=;
        b=uDBaLxgxt3xlCe4XAqbTOcC0XDdhAsblfV3yB6lNtoFoXgfIVskiXKIZdYWxMQcw/P2GW1e+T0gGIn9YugNlxn9ypuv0hUB2OkR1D9+WWo14MboM2GfWpyGFwpB8mbJZXg6OSbf6g145/XrgziPOe7uuUSzcmZII+A/g20f+dT0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:45eb889c-f3bc-4dc3-bd0b-8918316c54e6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:8047d7fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 66075474749c11ee8051498923ad61e6-20231027
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yu-chang.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1818456667; Fri, 27 Oct 2023 15:42:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Oct 2023 15:42:36 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 27 Oct 2023 15:42:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOlnL+MsDRuauhTnvZoFr1xFo8aViCFobXZxzGaqd/vyj/nF1uCylqQu0JihE8PrcprG2BABBMOGfkOjwu+16/JytxIqsDIcpYhH2oS6e3Q0PCvuat2VYtBIzeBgAhnyW3LGPGBkpPpHO2IlUjY7159EBJX0PAm+Y94R7nD8eYiADIE+AFKY/ok1qOoemfFMOpWusJS+uySAA9kozz9ui41vyYFX4lC02gEjwu/Atp1Hx4UpJPSmZlLi03mRz/zwt8oXP3mQgKPK3WJS1JJaSpM6ClHk3fnQLsU2bVKnOHgTzwsd8orJwn3dSp9oFAYcIX2dZSJjgaOR+n69i1JYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBByflb5c6ZUK9BbCZD/O1VzwXb4hlxA6ZKtmi7CW7I=;
 b=TUGdwF1MvuXkCwmqYc835C38wW0HqnBmf/Xae4UFEpQ/Uyuvjr3vh3Pxq0BEWGM32t/vzpWXB9pRCC3KhvEiaVRvdMK7ypwTC31CEtXogBJMp4YQl+Zx/4ihMaj6Cfw0EhWSx2Kro8/ZFxd9JSF1GyM7guvL7ICKt8IRVvb06JvVH1Azw3xKj1dI8KycApzQ6d7oUZpqCRWpdcovtgihcd3OnwHYzUc5Ds7LaEqOM97tIF3hZ7kKWT8hrwLw2FzKcvwNMhKeuc+4YxUTcKbPE43vvInW5QzwtdRZfxhpeXL5TBbCmIl+zrBUcui38M+kBsYajoUKtg2UroiZ/XupMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBByflb5c6ZUK9BbCZD/O1VzwXb4hlxA6ZKtmi7CW7I=;
 b=adz9+VmJhYrZMoStn9EoS5vG2EE8Mtqn4WX3FlaZTcNSDrjBiWIwyKKhc1sHc5uA0TC23Rh2k6lH55T84EG9o0F2VvjRjAWNo2AqyfLAUSOt8ob7tMPC+NY2cHk6LHWcyXEm1ZyI8wn4uiuqlQ0ucKK1Ob2FAA/t8HrKHK75a3g=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by PSAPR03MB6265.apcprd03.prod.outlook.com (2603:1096:301:9e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 07:42:34 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::eae7:2692:e6a8:e278]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::eae7:2692:e6a8:e278%6]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 07:42:34 +0000
From:   =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= 
        <Yu-chang.Lee@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH] clk: mediatek: mt8188: probe vpp with
 mtk_clk_simple_probe()
Thread-Topic: [PATCH] clk: mediatek: mt8188: probe vpp with
 mtk_clk_simple_probe()
Thread-Index: AQHaCAEOpE53qx8tMEeQ8E3pMUSPoLBb87EAgAFOl4A=
Date:   Fri, 27 Oct 2023 07:42:33 +0000
Message-ID: <aeb71e4321637fdebd414acf58480e520afd2b15.camel@mediatek.com>
References: <20231026113830.29215-1-yu-chang.lee@mediatek.com>
         <a7321404-0c8f-430c-b14c-7ffc9e4fc5d7@collabora.com>
In-Reply-To: <a7321404-0c8f-430c-b14c-7ffc9e4fc5d7@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|PSAPR03MB6265:EE_
x-ms-office365-filtering-correlation-id: c5a9c1e1-f6af-494a-f998-08dbd6c04872
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: omBOmMclso5jA9HxBnS7PEatLiVWXO7+e+myvwL4S06kmKrHP1umoOgZkelzKzAaHE4MDVhq3aelEepUtBJb8ZeocJw27Ihgq83qwSQevN1QCenkSxc42nytxIGp9PKp17Z/rB45NhfiAolAkmTCQ5cStYqcPODGuuS7NXgTsXxyos/utvoQtCAw+B4TqXdcCaQOV+vXtp0p9RsWEHiz3FoA/eEUezJFUM+Orj+/V719Cd8gBRsRcAuSninohDvP87M9hsDr0l+HUuZQIjXdrYOkUSsUkH9LGbPIg2O5BSFz8pLpNXLpQUPob+oeArY/4h0CYlBy5np6UVooIr9gRTzaDZe99XzLtcyyO9H+Y5KgGX2FI/F4mM56g3Hi6trM5llYlMHLdqai2p9MWJHil80HgnwAND9Eiw1A3I63tiLc3E5MfJtKDdm7rX++vZRMgmLgAyyDjgLibn94IaAZw8Qw2v0gYw//cxKxbp1ibNFGtXtbMLXaTJr+1f0f6eDxpWa3l9JZyuHZV83x/DlnW234NLn+mnhO3wj26LH2p7ryKx3nNPxBBLzdADFrredo7PifaYp4zk/gjRepUvZmnKV3Qr6b+sK4oMVGDwiWkvJYpX3lvV6l0yqwAiuLmd/44G+4+ofPFv5RGsv45X+qTV9ClfIfpYofzxaBiJ9DU5E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(71200400001)(122000001)(8936002)(2906002)(4326008)(83380400001)(8676002)(6486002)(7416002)(4001150100001)(5660300002)(41300700001)(86362001)(6506007)(6512007)(316002)(91956017)(110136005)(478600001)(26005)(2616005)(38070700009)(76116006)(85182001)(54906003)(38100700002)(64756008)(66476007)(66946007)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDNsSkt0bENDZGZCYmRsODJvRzZkaGZmcVhOWU1sKzJlMDlaS0wwNmdNT2Vp?=
 =?utf-8?B?eE8vcVFXQ2YyUlBiUUFJWmxobFpuT3FWY1I4NXUrbGo4S21WdWNMQ2RDdFhw?=
 =?utf-8?B?a2lRcFBZbXR1dHRlcTk1WXNOQXVZWE9vMmE1WVNjTTdpWUI0Z0ZGTWtRM3dk?=
 =?utf-8?B?bndFL0dvenZtOGtINFlGQXlQbklKWVJIUFg2Y2NpMFo0VW5wZkR2cE9WZEtm?=
 =?utf-8?B?N2NHcWpJR2hZcXltT0hQTGZmcUt4NUhmWEorTWxvSnpNb3Bzc3FIM1B5ZTlE?=
 =?utf-8?B?RHNiRDk4TkhJRENlR0RLT0prWFVxNTlLRUxUL0FBTWM4MUc2SWxZQWNnL1VS?=
 =?utf-8?B?YlBIemxZazRkc3BZWXB1YjFWRHA1UDY2cEh5ZXJTOHpOR0FFS0p2eDVpaUJj?=
 =?utf-8?B?VGZMT2Y4d1huSUk4QTY1a0ZheU5PNFdpYUtpaEhqVk1wL3hudDNYYzJnUXND?=
 =?utf-8?B?NE9Ic2RaMVNHWnFDRGJBdlQxRlJpRHFsUHpvNGwzZzgzakJHYkR1aVlaclZB?=
 =?utf-8?B?Y09pMGY0NFNZbzg2SHRuSlUzM2RFUDRWdmx0SEVSeC9ZMm5sSUd4ejhLVGd0?=
 =?utf-8?B?bjJuOXFZczgvMnRQbnFtOFpYZU5GR3lxdkVJSkpsNVNtTXRDQUVLL044MmU1?=
 =?utf-8?B?R1d0dTIyaWJVVEE5aS85VTNmRlJjZmNCZlIrbSsya1RRRVJSNjFKRFc4R0xZ?=
 =?utf-8?B?OENQWTJKQU9mbU1PZjg1UExERVBJNHExdDNuN2RMTjQ5WWdPZTJyeG4rM2pP?=
 =?utf-8?B?eUZod2JBWTFiMWprVTNiLzE0MHVEMllkSTBGaXhTRWxZREtDcnlBNHk5MVRx?=
 =?utf-8?B?N2Y5TDNPd0MxYjhYdWZqcU05K2JkODZqTGFiWDVMdWdZV1FjajhYUy9VOS9P?=
 =?utf-8?B?RTBwUDlPbEl4ZFcyRU13K3VpS1FteTl2aksrWDJqRC90a3BlOEdLN01idW91?=
 =?utf-8?B?VU42NThYNGtkWDJVaDNleUJIdTlBWE94S29jRWpQbDZUZWRNdEJJVHMrT0dk?=
 =?utf-8?B?Z0lISkdqemc4QVhIZVJWVXRqdWQzN2krc25qSmN4MHhXdFhyMWNoWmJyeS8v?=
 =?utf-8?B?M001Tkxld2Q3QUNkQzhBRVFpT2xxN09oMGFWUnlCQ2VrYW1SWXNXckdGR2I2?=
 =?utf-8?B?TVRtTHRoaGdIOWJaRkFJZHZraTNwdk93OVdvUTRtMVFrOFN5U3FYVlNjMTEx?=
 =?utf-8?B?VW5IazhwbkdMQk9TSHRPYmQ5L3B6aFVvMU50cVdiYzFReGwxKzZpNUhqSHVS?=
 =?utf-8?B?eEUzWGtPbFlsUzVpcXIvYlltdVVLcXhkN3poNm91dEdsN241WTQxbnRFOU5V?=
 =?utf-8?B?NTh0U1lzSDJYYlQ5UlV3TFFnVjFTWVNhWFpjUDJVQkd5ZXNFQWV3c1VUd1Zy?=
 =?utf-8?B?eFRlRTlaRWtBSVo4YjlqSWZJUzFOcVNNem9BNXN3bkZ2amVrVmt4blM2VlJN?=
 =?utf-8?B?ZEhncXhqNGc2RTZNenJ0MjVsaWQwZUJ4NWc1eGhmT2kvTzhLNnJxNUlpNG9p?=
 =?utf-8?B?Yi9jNzJXcVoxZHBYeVpGZHJWb0NnWnpIb2Q5Ris5SW1WeGFoeDJCOWRjZnNk?=
 =?utf-8?B?dFJLVk1NWnFFTnVEUlk1TjJlMGZScDRncGRRR1NmeE15R2lVTVJyTUdzblc3?=
 =?utf-8?B?cW5STHdkUXpoTlVYMXZ4K3lsM3J2K2xVeEtJTkhsblRaNWR3L1d4SmZiMWxR?=
 =?utf-8?B?OTVOTTJOT2RBVU9GM3Y3eDZtQ2VxWDlhb2ZBRmYwL3Jkb0I2SmxwazdWQlBx?=
 =?utf-8?B?TGQ5VE9ROXJNVFNoaEFUL3E5Vml2OGhNWUpzSWNDQ09JZ1IwbFZuV2FHVWtT?=
 =?utf-8?B?L2Qxa0gvZVJ1RDAzNnVlSk1McTUyQ0t3dGZvT0p0NHRMYXp0VVR5OEx3OVgw?=
 =?utf-8?B?UWREWHBhaWUxcUJ0V3dDOUJYN1FMaWhCWXJkbkxwUE1GaFlNU25VY05CV25L?=
 =?utf-8?B?RmV3Ry9FWm1iRW9LUkZkTExJWlptOVhSQWVORnZ1cHlGVXJCREFvRjN0OXNQ?=
 =?utf-8?B?Z0JnRUpEUEtyazY4dTA2T280RmxZMUQyTnZRT1FsdUZmZzF1UkJwKzIxK1ps?=
 =?utf-8?B?QmIvQ21NeDhaOWdtS3U2Y3JUY3RRTk0zRWdGWndlUS9wUnRYSHZZZ09WMTd4?=
 =?utf-8?B?TTE1UVhHYTRqdXBnQlBJMVdkanA0dDVrRGtaak9DNVBmcldQZ2RvMFhnOTFj?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <365B4E938C18114B965AD05FC61E4FF4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a9c1e1-f6af-494a-f998-08dbd6c04872
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 07:42:34.0072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqHO8157y0wkopJM/+H489Lwcn9h4RhTOb3In4/ZXp1xbs4lhis9EPOQxhQk+5Uf5Kl9uGmcmDNmPzYGKZarJUaXm17ysinaUl2iah3uil4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6265
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.645200-8.000000
X-TMASE-MatchedRID: GagEC7nsA0TUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
        bY7xfgXY9KE7L0nJx0rKknPXtE9CiKFm8ewFh41RQIDtzftQ0iMsCc2iFTIxreOxOq7LQlGLbpP
        Wj/4l57JuC2SUR+pa+arajnL1V8pgR5d+7Y10dxm8coKUcaOOvRLXa2P1m93z2oLGTNKlb9dSY/
        pNZG3UKZxfvfHP0HUioZJhW5/fKzFHgaXzNtZX0x+WEMjoO9WWTJDl9FKHbrkKogmGusPLb1i5r
        +TKtIsrrxb2mrj2TkO2q4RAeMRmGWsS7dJUh+kDoMfp2vHck9UxXH/dlhvLv3OMCXNrYTWiNuGE
        1/yHeZvi8zVgXoAltj2Xsf5MVCB1jaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.645200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9FC35EE0C9A58B950A8A912F71064D75660C0E4D1EB699396693382F92F194302000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTI2IGF0IDEzOjQ1ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjYvMTAvMjMgMTM6MzgsIHl1LWNoYW5nLmxlZSBoYSBzY3JpdHRv
Og0KPiA+IHN3aXRjaCB0byB0aGUgY29tbW9uIG10a19jbGtfc2ltcGxlX3Byb2JlKCkgZnVuY3Rp
b24gZm9yIGFsbCBvZiB0aGUNCj4gPiBjbG9jayBkcml2ZXJzIHRoYXQgYXJlIHJlZ2lzdGVyaW5n
IGFzIHBsYXRmb3JtIGRyaXZlcnMuDQo+ID4gDQo+IA0KPiBTbyBWUFBTWVMwIGFuZCBWUFBTWVMx
IGFyZW4ndCBkZXBlbmRhbnQgb24gTU1TWVMgYW55bW9yZT8NCj4gDQo+IExpa2UgdGhpcywgaXQg
ZG9lc24ndCBsb29rIGxpa2UgdGhpcyB3aWxsIGV2ZXIgd29yayBmaW5lLCBzbyBpZiB5b3UNCj4g
d2FudA0KPiB0aGF0IHRvIGhhcHBlbiwgeW91IG11c3QgcHJvdmlkZSBhIGdvb2QgZXhwbGFuYXRp
b24sIGFuZCB0aGVuLCBzaW5jZQ0KPiBNVDgxODgNCj4gYW5kIE1UODE5NSdzIFZQUFNZUyBhcmUg
cHJhY3RpY2FsbHkgdGhlIHNhbWUsIHlvdSBzaG91bGQgYWxzbyBjb252ZXJ0DQo+IE1UODE5NQ0K
PiB0byBkbyB0aGUgc2FtZSwgYW5kIG1ha2Ugc3VyZSB0aGF0IGV2ZXJ5dGhpbmcgd29ya3MgYXMg
ZXhwZWN0ZWQNCj4gYmVmb3JlIHNlbmRpbmcNCj4gYSBjb21taXQgdXBzdHJlYW0uDQo+IA0KPiBQ
bGVhc2UsIGV4cGxhaW4uDQo+IA0KPiBUaGFua3MsDQo+IEFuZ2Vsbw0KPiANCkhpIEFuZ2VsbywN
Cg0KVGhhbmtzIGZvciB5b3VyIHRpbWUgYW5kIHRpbWVseSBmZWVkYmFjay4gSSBkb24ndCBmaW5k
IG10ODE4OC12cHAxIGFuZA0KbXQ4MTg4LXZwcDAgaW4gbXRrLW1tc3lzLmMuIGFuZCB0aG91Z2h0
IHByb2JlZCB0aGVtIHdpdGgNCm10a19zaW1wbGVfcHJvYmUoKSwgcmVmZXIgdG8geW91ciBjb21t
ZW50IG9uIGluIHRoaXMgcGF0Y2gNCiJjbGs6DQptZWRpYXRlazogU3dpdGNoIHRvIG10a19jbGtf
c2ltcGxlX3Byb2JlKCkgd2hlcmUgcG9zc2libGUiLCB3aWxsIGJlIGENCmdvb2QgaWRlYS4gT24g
dGhlIG90aGVyIGhhbmQgbXQ4MTk1IGRvZXMgaGF2ZSBkZXBlbmRlbmN5IG9uIE1NU1lTLCBzbyBJ
DQpkb24ndCB0aGluayB0aGUgc2FtZSBjaGFuZ2Ugd29yayBvbiBtdDgxOTUuDQoNCkJlc3QgUmVn
YXJkcywNCll1Q2hhbmcNCg0KPiA+IFNpZ25lZC1vZmYtYnk6IHl1LWNoYW5nLmxlZSA8eXUtY2hh
bmcubGVlQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1tdDgxODgtdnBwMC5jIHwgMTQgKysrKysrKysrKystLS0NCj4gPiAgIGRyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDgxODgtdnBwMS5jIHwgMTQgKysrKysrKysrKystLS0NCj4gPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OC12cHAwLmMNCj4g
PiBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxODgtdnBwMC5jDQo+ID4gaW5kZXggZTdi
MDJiMjZmZWZiLi4xOGZmZmExOTFlZTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvbWVk
aWF0ZWsvY2xrLW10ODE4OC12cHAwLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9j
bGstbXQ4MTg4LXZwcDAuYw0KPiA+IEBAIC05Niw2ICs5NiwxNSBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG10a19jbGtfZGVzYyB2cHAwX2Rlc2MgPSB7DQo+ID4gICAJLm51bV9jbGtzID0gQVJSQVlf
U0laRSh2cHAwX2Nsa3MpLA0KPiA+ICAgfTsNCj4gPiAgIA0KPiA+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IG9mX2RldmljZV9pZCBvZl9tYXRjaF9jbGtfbXQ4MTg4X3ZwcDBbXSA9IHsNCj4gPiArCXsN
Cj4gPiArCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtdnBwc3lzMCIsDQo+ID4gKwkJ
LmRhdGEgPSAmdnBwMF9kZXNjLA0KPiA+ICsJfSwgew0KPiA+ICsJCS8qIHNlbnRpbmVsICovDQo+
ID4gKwl9DQo+ID4gK307DQo+ID4gKw0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2VfaWQgY2xrX210ODE4OF92cHAwX2lkX3RhYmxlW10NCj4gPiA9IHsNCj4gPiAgIAl7
IC5uYW1lID0gImNsay1tdDgxODgtdnBwMCIsIC5kcml2ZXJfZGF0YSA9DQo+ID4gKGtlcm5lbF91
bG9uZ190KSZ2cHAwX2Rlc2MgfSwNCj4gPiAgIAl7IC8qIHNlbnRpbmVsICovIH0NCj4gPiBAQCAt
MTAzLDEyICsxMTIsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQN
Cj4gPiBjbGtfbXQ4MTg4X3ZwcDBfaWRfdGFibGVbXSA9IHsNCj4gPiAgIE1PRFVMRV9ERVZJQ0Vf
VEFCTEUocGxhdGZvcm0sIGNsa19tdDgxODhfdnBwMF9pZF90YWJsZSk7DQo+ID4gICANCj4gPiAg
IHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGNsa19tdDgxODhfdnBwMF9kcnYgPSB7DQo+
ID4gLQkucHJvYmUgPSBtdGtfY2xrX3BkZXZfcHJvYmUsDQo+ID4gLQkucmVtb3ZlX25ldyA9IG10
a19jbGtfcGRldl9yZW1vdmUsDQo+ID4gKwkucHJvYmUgPSBtdGtfY2xrX3NpbXBsZV9wcm9iZSwN
Cj4gPiAgIAkuZHJpdmVyID0gew0KPiA+ICAgCQkubmFtZSA9ICJjbGstbXQ4MTg4LXZwcDAiLA0K
PiA+ICsJCS5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNoX2Nsa19tdDgxODhfdnBwMCwNCj4gPiAg
IAl9LA0KPiA+IC0JLmlkX3RhYmxlID0gY2xrX210ODE4OF92cHAwX2lkX3RhYmxlLA0KPiA+ICAg
fTsNCj4gPiAgIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoY2xrX210ODE4OF92cHAwX2Rydik7DQo+
ID4gICBNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDgxODgtdnBwMS5jDQo+ID4gYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9j
bGstbXQ4MTg4LXZwcDEuYw0KPiA+IGluZGV4IGU4ZjBmN2VjYTA5Ny4uZjRiMzUzMzZkNDI3IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxODgtdnBwMS5jDQo+
ID4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OC12cHAxLmMNCj4gPiBAQCAt
OTEsNiArOTEsMTUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfY2xrX2Rlc2MgdnBwMV9kZXNj
ID0gew0KPiA+ICAgCS5udW1fY2xrcyA9IEFSUkFZX1NJWkUodnBwMV9jbGtzKSwNCj4gPiAgIH07
DQo+ID4gICANCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgb2ZfbWF0Y2hf
Y2xrX210ODE4OF92cHAxW10gPSB7DQo+ID4gKwl7DQo+ID4gKwkJLmNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTg4LXZwcHN5czEiLA0KPiA+ICsJCS5kYXRhID0gJnZwcDFfZGVzYywNCj4gPiAr
CX0sIHsNCj4gPiArCQkvKiBzZW50aW5lbCAqLw0KPiA+ICsJfQ0KPiA+ICt9Ow0KPiA+ICsNCj4g
PiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIGNsa19tdDgxODhfdnBw
MV9pZF90YWJsZVtdDQo+ID4gPSB7DQo+ID4gICAJeyAubmFtZSA9ICJjbGstbXQ4MTg4LXZwcDEi
LCAuZHJpdmVyX2RhdGEgPQ0KPiA+IChrZXJuZWxfdWxvbmdfdCkmdnBwMV9kZXNjIH0sDQo+ID4g
ICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+ID4gQEAgLTk4LDEyICsxMDcsMTEgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQNCj4gPiBjbGtfbXQ4MTg4X3ZwcDFfaWRfdGFi
bGVbXSA9IHsNCj4gPiAgIE1PRFVMRV9ERVZJQ0VfVEFCTEUocGxhdGZvcm0sIGNsa19tdDgxODhf
dnBwMV9pZF90YWJsZSk7DQo+ID4gICANCj4gPiAgIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJp
dmVyIGNsa19tdDgxODhfdnBwMV9kcnYgPSB7DQo+ID4gLQkucHJvYmUgPSBtdGtfY2xrX3BkZXZf
cHJvYmUsDQo+ID4gLQkucmVtb3ZlX25ldyA9IG10a19jbGtfcGRldl9yZW1vdmUsDQo+ID4gKwku
cHJvYmUgPSBtdGtfY2xrX3NpbXBsZV9wcm9iZSwNCj4gPiAgIAkuZHJpdmVyID0gew0KPiA+ICAg
CQkubmFtZSA9ICJjbGstbXQ4MTg4LXZwcDEiLA0KPiA+ICsJCS5vZl9tYXRjaF90YWJsZSA9IG9m
X21hdGNoX2Nsa19tdDgxODhfdnBwMSwNCj4gPiAgIAl9LA0KPiA+IC0JLmlkX3RhYmxlID0gY2xr
X210ODE4OF92cHAxX2lkX3RhYmxlLA0KPiA+ICAgfTsNCj4gPiAgIG1vZHVsZV9wbGF0Zm9ybV9k
cml2ZXIoY2xrX210ODE4OF92cHAxX2Rydik7DQo+ID4gICBNT0RVTEVfTElDRU5TRSgiR1BMIik7
DQo+IA0KPiANCg==
