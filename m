Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BE57C633C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376734AbjJLDVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjJLDVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:21:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC80A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 20:21:11 -0700 (PDT)
X-UUID: 6173f21868ae11eea33bb35ae8d461a2-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=i1HqIMPIkZDYpFQL+Tha7mypqu5CJGxh38+p5WwweAY=;
        b=D7oKI+u7AfT5DQzUn41Hjo4ovysLz5dnVJhKVHd0EZM6x5n6A7k7ZEqQYE7quURVz9fIb/k5gbuYpz2APgysH55V22hNLlfSEB+5lb6DgdAqTKI1ZFdsJKXkEp3DiyiOhbCVjTL9ZuR/n6ssEJ7TkoTVxpC8LABdM7ET/9TCSxU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:1ad24786-02a2-421b-a562-228c97c926ba,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:603dd5bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6173f21868ae11eea33bb35ae8d461a2-20231012
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1452375930; Thu, 12 Oct 2023 11:21:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 11:21:03 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 11:21:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFXLRyIOLxVzUZ1HYPY6xEFpdnoWkUmhL3AWr19Rn/KONqYjt4ywcTTUhOM0F0ehSB7yzjQ67zvpvV6D4gSI015OYwWOcYc2FKXsCp0doOK/gREAh62qt6np2LOWixlj0x2bzG+l2CBCDLHvsn45bR0eYOZvcDBVpbjJysBMON5o70XkeP8UDSySUJOFXksdEu321Wp9BRVMGYMW5hdtptiPcMaVq99tcSUY70NvemFRRYCzmepg7TS6n6nkWHYeU4MM5vLm5g+wxnHS3Gp94g51uQLg6SktBm1VWL4ZaZE0dImG1l3PNSTzqmjcz3gp5gAER0dpRYVXWbGalR1zMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1HqIMPIkZDYpFQL+Tha7mypqu5CJGxh38+p5WwweAY=;
 b=GVeyFAXm9I7XOp/gX3nUi4WXOCsPlKgOgS9fsjup4J3igK3W0/lWJAP8OB2QoXJbommYiW5jC9eIstHpn+4sV/DyzOr370evb5NF5xx2c1PCUT3NovR58MWRZNbU1Hukgo0YGLzLQNHAqz4v/PspNlGZGrIb2jcFg8wTfCkCs2lx+ek+BD4Qxme1G7+7KL90pRpKXQx8Hfm3P0ZnzPSrooTyvVl8RejWb2oyIsFG/4anq2+F0bsy85rp24NpwxzXf0to9ABV4dJucX+BtpeC2eB85pZlC3C1J0NKIy4XqEASmtC/wSkvXtxirz17Ab6JAaqlw6mvzvvtlBOK+SyIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1HqIMPIkZDYpFQL+Tha7mypqu5CJGxh38+p5WwweAY=;
 b=Z/nRTEGnL4SOPLx91bqrp+5VrIcBaGpvWDs0FH/W/6Ja8kWbMZZgDNLhB4vkCKAy0++Lqd84YWv05lhF7N7U7XUxheFteTrm9QJ/YU9gJ8i6TzvDDmjcjcCEhA84pZOTyx1Zsfc4jQjlVPNmJboGaG7w+m1/TTSPCstAtC8yYBQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB6216.apcprd03.prod.outlook.com (2603:1096:301:bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 03:20:57 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.041; Thu, 12 Oct 2023
 03:20:57 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>
Subject: Re: [PATCH v10 11/16] drm/mediatek: gamma: Add support for 12-bit LUT
 and MT8195
Thread-Topic: [PATCH v10 11/16] drm/mediatek: gamma: Add support for 12-bit
 LUT and MT8195
Thread-Index: AQHZxqWQ81uSx6/NC0uBQh5mrEZw3bBF6O4A
Date:   Thu, 12 Oct 2023 03:20:57 +0000
Message-ID: <e0487568eaa06e41badb9486f9187540ed159f28.camel@mediatek.com>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
         <20230804072850.89365-12-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230804072850.89365-12-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB6216:EE_
x-ms-office365-filtering-correlation-id: e835aa5d-9501-4f7a-e852-08dbcad24078
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oi+Z9HfJ6flLxbGTy+fowxR5CHhIwxQOD76hTzqKfikKeqXDJYvUfqoI3KllTUbWA1fnnYrbaIAmvE75sWNCwiWaa0QufZlX+yYSUkvbKheMeki+to4PpWQBgHCXso8q7bLObzROmGensx+om1xOihkqZM5Nb77Dd7J6GFOZ0/NyanbxBJNrAE3g0IGRehoJSBgFjPzXKM8OcZQlKtwtp6RdmyxJGws1SiMSRezZl6gi1k5WqjS7Fd0vJ5614dABfcgHKcUXUcaOb1HyldI1sNuTPq+jtOmEr1u0p5u3Iipo2vevsW2lK71n9kOq2faolDxzfwCe3Pvu+sH5UQ5mBZjG6pcVbQaBgf+E+ruCTOlR8EXdjF1AOxS6SryxKVDDsUHvCoMJVkR9hKd9CqwoM6jMEcUQ0V5ELXFjSlPP3Y84stjL2lDrvbYjHImVXutIKmqtRqFPpXNvnP6TNnKLKlHFAGr9R/6jw+YzNJ2ba9+8a0MCe3IuWQ4yPCcBoJAdvTldf29R/gzbVTx2hhd9ctXVx1EPJhvwL2IJ1s3jkp1joXooO4VETN+XHOyLeRcaoXAUZ9gljR5Wg260Q57/YwS5NTv4d3cqHyJneyAxsrmftHUmRsYSmiu+2wblcIooci/12iLmiPZrex11yafJKjLK1ERy8eUvnZvNyEKX4bs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4326008)(478600001)(8676002)(8936002)(2906002)(5660300002)(41300700001)(66476007)(64756008)(54906003)(316002)(66946007)(66556008)(76116006)(110136005)(66446008)(7416002)(6486002)(6506007)(83380400001)(2616005)(26005)(6512007)(38100700002)(38070700005)(122000001)(86362001)(36756003)(85182001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnM1ekhWZjlHT3RnL0hQTlk3Mm1zN0JZU3VLRVlNeXdiMnJHdk50c0xsbldu?=
 =?utf-8?B?YTV2R3h4QndlOWpEaTRpOXh4M1VUL2dFNVkza0l6bERSZTZKTFRUSHYrN0Nx?=
 =?utf-8?B?b0hJQ1E4SDdRcS9aeUVWb3BINzBqeHQwY21qeERaTnFPV0VLb1NlY0tTMTMz?=
 =?utf-8?B?cVFKNE15b3FzRWZ6bkEzUmdZRXVLL1puMDZJL2VMdGdQelZ3S3ZLWk81SlBz?=
 =?utf-8?B?MzdwbmpTMXQxay96WURyOFBqSURUbzVETnpWd25UNVFheUhMemsycVFvNlFi?=
 =?utf-8?B?VWU5SXFqNFJYYWtVODFaZEdZV3NPTThHbWZKSllGRVlWZWpKakFGRnF6ZmZG?=
 =?utf-8?B?ODhneld3YVp3aTlmMkV5dDA4cDYzNDcwUmhhTnczZjNIOExhY1B2RTlYdlh1?=
 =?utf-8?B?RTIrY1haSE5HZGNMRlJnaTI5TU84dURZNW81R243a2F6VTdRa3F6ZVJsay9Y?=
 =?utf-8?B?SEVnYjgzRCtoYkRDaUpvbk9KSFZNSms3UENFUUIyTXp1WnZ1c0ZWT3IrTXZh?=
 =?utf-8?B?cklEaHhBbVc5a2hIL1orNWlRaEY5bzYrVXUrZEI1NmhSTXUzRExZVGtXNUpn?=
 =?utf-8?B?TG1sd2IvcndrZzFsS1lKL3VicjNSNU4rSDgrb2JKRmxKcGlxWmV3YUxSTnZY?=
 =?utf-8?B?U1VJazI4SGNhY0U3ZGF1R2UrSXJmZnBjOTR4MDBHTHU5eS84V3BtWVdEcUxR?=
 =?utf-8?B?eVRKSUIxWXhqZ2pOVVpwK0RiSnZQYVJkeTJKSXlDZVRMYXBYcEJWNEg1Vkp3?=
 =?utf-8?B?TEprcXNoMndPNzQ5SWozZVJ0bGhRTG84TlNRdEkybFNaQ1JtdnFRTnAwVmpr?=
 =?utf-8?B?QjEvTkdPV2R6SEVSOHpidnJOKzNJQ1ZCTm9IKzl5V0pmSFMvWkVybGc1ZlBs?=
 =?utf-8?B?ajIzV1BpejRJSk90N054VEk4cEJidTREMldkTnNwTWhvdzh3SDBDRS8waE5M?=
 =?utf-8?B?VVJqNDhOOEluekJDL2xHckR2TTdlTVY0eFFFVVJSYW1oTkNCK1VpakwzM0xC?=
 =?utf-8?B?YlNoNm5aV2doRVpMenhNN3A3d1J3NE9USSt5bkV5djZVYnFaL0xtNXNqU1VV?=
 =?utf-8?B?RElvNEZwU1IxT3Q1cDFWL205d3pWNVJFakYwb3BXZjA2Z3dWejU1Ri9mN1VH?=
 =?utf-8?B?eGJBclU4ejMyTFZRY2MxRyt0d2QvekJ0REZHZHMwU1cyRUhmdE9YNTJzT2xw?=
 =?utf-8?B?a3VrWEZJcUVGUGhLTWJ6UWJCdllzNjZqVUoydGRwMXQ0WExweXJ4VW1GdE03?=
 =?utf-8?B?NExXcWRpVGRnRUFvaS9qcDZibGhzZHpQWWh3bDkyZmhnMHNiNVA0YUY4bWht?=
 =?utf-8?B?b2U1UitXUGlYdTYzMUk1b3dPNnl2aUwvdlVBZlJ5SERGcmRpY3VmRExKOXl2?=
 =?utf-8?B?LytoRFljU3BVOXl2Z2EwbDhBUkcvT0xRQ3JqNVhGZFRzVm9xSk1nSnBMWENO?=
 =?utf-8?B?bldHNTE4T1JxbGNaOTdhUEQ3ekJ3RXhFWjVKWXhHbHpIVWJZa0ZOS09IaS9Q?=
 =?utf-8?B?cWFoTytKRlEydmhrYysvN05wQ0R3SGVKK2pwYlJGWTEzeHF1eGhOa052Rm1F?=
 =?utf-8?B?cElDRHlhVDZ1R01rTU5kdHJUbVl0L1ZkbTdxczB6NEVkUk9sMnF1bmJ2Q0hn?=
 =?utf-8?B?Z1BJN0NhY2Nya0xtcHgrVFMxM01FZkM0K0dmckMzeUJIS2VEcURIR0ZZZTlL?=
 =?utf-8?B?TUJ3bHgzb2pIUWRxWUc1RmZDUzRPNFdUMUlxckxvS3BBelU5emZKNFdXdEtr?=
 =?utf-8?B?cVJ4cTFkWGhGYUxESHNZaHZCM2JZUmFvaGtKOUlaemZmdi9iVmlHcC9YNWR1?=
 =?utf-8?B?VVk3bTBrSnloMXNRcm5VVWQ2VUFHOHY2ZHJYUWNTaW9UZi9LNGpPVVMzaHho?=
 =?utf-8?B?dkJZNllPWmtEYnp4RS9PWDVrSXNTOFJmL2dwcnhmaHdrYVN0R0Vja0VodmMy?=
 =?utf-8?B?RXYvaDFKVGczc29Xb1lCQ1dnS0RURGJqelkrMG13Q054U296WElwSWpEenRE?=
 =?utf-8?B?K2JxaEUxdUk3dC95R3ZaOGNBcVBzTlZXbkpaSU41Z0ZlTjg4TnhpYmdHck5r?=
 =?utf-8?B?TEo2TG91d0cvWFY1Q2QzMExWY3VaM3hPZ1VBRkNKMGVrWS9SVkgzdXBYcTFn?=
 =?utf-8?Q?XvBz27ZE8ROt1ry4JJmO3dsts?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCC1A315FC349742910E75975E69D541@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e835aa5d-9501-4f7a-e852-08dbcad24078
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 03:20:57.6131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRcd22Ju9vOey91DFzwFFlHtdKgCdTXQiONVhoBJ0oqXBQD4pUiEg26cuDBo/w07PR8BehV2nxPN8TE6G0yvLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6216
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.635600-8.000000
X-TMASE-MatchedRID: y/2oPz6gbvgNtKv7cnNXnSa1MaKuob8PC/ExpXrHizxcKZwALwMGs+O/
        ytE9sHcwuqUw+eljx/Ms4TYPtim38zWr0WquUWBgQ4srjeRbxTZMkOX0UoduuRS11FlOYRoh0TV
        /E4HoomkM4/EABi8RhTryc/h2dYIRbn83JMqUbr24jAucHcCqnacJxWZ5/lR8+3n3Z6rbGhMJ/a
        H0DaAUBcSimB4DMfjpj/sB7Iy2G6uDiNkfvbHj3khEDfw/93BuROshHNu2/QZXPwnnY5XL5Cqz9
        bm0+YwH54nl68YYSZ/KcryS5gvpLgzyMxeMEX6w0gVVXNgaM0pZDL1gLmoa/PoA9r2LThYYKrau
        Xd3MZDUmric0udCy3Nk3YGZNIobWry6Sqx2wYCHafedrXYnl6hVAx+dL2ApL
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.635600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 228FCCC35F3B3A0D3DACE2110D4B75686ADEE8F14B72CA5B74C2D956214C805A2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gRnJpLCAyMDIzLTA4LTA0IGF0IDA5OjI4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIDEyLWJpdCBnYW1t
YSBsb29rdXAgdGFibGVzIGFuZCBpbnRyb2R1Y2UgdGhlIGZpcnN0DQo+IHVzZXIgZm9yIGl0OiBN
VDgxOTUuDQo+IFdoaWxlIGF0IGl0LCBhbHNvIHJlb3JkZXIgdGhlIHZhcmlhYmxlcyBpbiBtdGtf
Z2FtbWFfc2V0X2NvbW1vbigpDQo+IGFuZCByZW5hbWUgYGx1dF9iYXNlYCB0byBgbHV0MF9iYXNl
YCB0byBpbXByb3ZlIHJlYWRhYmlsaXR5Lg0KDQpTZXBhcmF0ZSAxMi1iaXQgZ2FtbWEgc3VwcG9y
dCBhbmQgbXQ4MTk1IHN1cHBvcnQgdG8gZGlmZmVyZW50IHBhdGNoZXMuDQoNClJlZ2FyZHMsDQpD
Sw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+
IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IEFsZXhhbmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMgfCA3NCArKysrKysrKysrKysr
KysrKysrDQo+IC0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspLCAxMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfZ2FtbWEuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9n
YW1tYS5jDQo+IGluZGV4IDNmMWM2ODE1ZWE1YS4uN2QyZjgwNDJhY2UwIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYw0KPiBAQCAtMjYsMTIgKzI2LDIw
IEBADQo+ICAjZGVmaW5lIERJU1BfR0FNTUFfU0laRV9WU0laRQkJCQlHRU5NQVNLDQo+ICgxMiwg
MCkNCj4gICNkZWZpbmUgRElTUF9HQU1NQV9CQU5LCQkJCTB4MDEwMA0KPiAgI2RlZmluZSBESVNQ
X0dBTU1BX0JBTktfQkFOSwkJCQlHRU5NQVNLKDEsIDApDQo+ICsjZGVmaW5lIERJU1BfR0FNTUFf
QkFOS19EQVRBX01PREUJCQlCSVQoMikNCj4gICNkZWZpbmUgRElTUF9HQU1NQV9MVVQJCQkJMHgw
NzAwDQo+ICsjZGVmaW5lIERJU1BfR0FNTUFfTFVUMQkJCQkweDBiMDANCj4gIA0KPiArLyogRm9y
IDEwIGJpdCBMVVQgbGF5b3V0LCBSL0cvQiBhcmUgaW4gdGhlIHNhbWUgcmVnaXN0ZXIgKi8NCj4g
ICNkZWZpbmUgRElTUF9HQU1NQV9MVVRfMTBCSVRfUgkJCUdFTk1BU0soMjksIDIwKQ0KPiAgI2Rl
ZmluZSBESVNQX0dBTU1BX0xVVF8xMEJJVF9HCQkJR0VOTUFTSygxOSwgMTApDQo+ICAjZGVmaW5l
IERJU1BfR0FNTUFfTFVUXzEwQklUX0IJCQlHRU5NQVNLKDksIDApDQo+ICANCj4gKy8qIEZvciAx
MiBiaXQgTFVUIGxheW91dCwgUi9HIGFyZSBpbiBMVVQsIEIgaXMgaW4gTFVUMSAqLw0KPiArI2Rl
ZmluZSBESVNQX0dBTU1BX0xVVF8xMkJJVF9SCQkJR0VOTUFTSygxMSwgMCkNCj4gKyNkZWZpbmUg
RElTUF9HQU1NQV9MVVRfMTJCSVRfRwkJCUdFTk1BU0soMjMsIDEyKQ0KPiArI2RlZmluZSBESVNQ
X0dBTU1BX0xVVF8xMkJJVF9CCQkJR0VOTUFTSygxMSwgMCkNCj4gKw0KPiAgI2RlZmluZSBMVVRf
MTBCSVRfTUFTSwkJCQkweDAzZmYNCj4gICNkZWZpbmUgTFVUX0JJVFNfREVGQVVMVAkJCTEwDQo+
ICAjZGVmaW5lIExVVF9TSVpFX0RFRkFVTFQJCQk1MTINCj4gQEAgLTc3LDE0ICs4NSwzMCBAQCB1
bnNpZ25lZCBpbnQgbXRrX2dhbW1hX2dldF9sdXRfc2l6ZShzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYp
DQo+ICAJcmV0dXJuIExVVF9TSVpFX0RFRkFVTFQ7DQo+ICB9DQo+ICANCj4gKy8qDQo+ICsgKiBT
b0NzIHN1cHBvcnRpbmcgMTItYml0cyBMVVRzIGFyZSB1c2luZyBhIG5ldyByZWdpc3RlciBsYXlv
dXQgdGhhdA0KPiBkb2VzDQo+ICsgKiBhbHdheXMgc3VwcG9ydCAoYnkgSFcpIGJvdGggMTItYml0
cyBhbmQgMTAtYml0cyBMVVQgYnV0LCBvbg0KPiB0aG9zZSwgd2UNCj4gKyAqIGlnbm9yZSB0aGUg
c3VwcG9ydCBmb3IgMTAtYml0cyBpbiB0aGlzIGRyaXZlciBhbmQgYWx3YXlzIHVzZSAxMi0NCj4g
Yml0cy4NCj4gKyAqDQo+ICsgKiBTdW1tYXJpemluZzoNCj4gKyAqIC0gU29DIEhXIHN1cHBvcnQg
OS8xMC1iaXRzIExVVCBvbmx5DQo+ICsgKiAgIC0gT2xkIHJlZ2lzdGVyIGxheW91dA0KPiArICog
ICAgIC0gMTAtYml0cyBMVVQgc3VwcG9ydGVkDQo+ICsgKiAgICAgLSA5LWJpdHMgTFVUIG5vdCBz
dXBwb3J0ZWQNCj4gKyAqIC0gU29DIEhXIHN1cHBvcnQgYm90aCAxMC8xMmJpdHMgTFVUDQo+ICsg
KiAgIC0gTmV3IHJlZ2lzdGVyIGxheW91dA0KPiArICogICAgIC0gMTItYml0cyBMVVQgc3VwcG9y
dGVkDQo+ICsgKiAgICAgLSAxMC1pdHMgTFVUIG5vdCBzdXBwb3J0ZWQNCj4gKyAqLw0KPiAgdm9p
ZCBtdGtfZ2FtbWFfc2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRybV9jcnRjX3N0YXRl
ICpzdGF0ZSkNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2Rpc3BfZ2FtbWEgKmdhbW1hID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7DQo+IC0JdW5zaWduZWQgaW50IGk7DQo+IC0Jc3RydWN0IGRybV9jb2xv
cl9sdXQgKmx1dDsNCj4gLQl2b2lkIF9faW9tZW0gKmx1dF9iYXNlOw0KPiAtCXUzMiBjZmdfdmFs
LCBsYmFua192YWwsIHdvcmQ7DQo+ICsJdm9pZCBfX2lvbWVtICpsdXQwX2Jhc2UgPSBnYW1tYS0+
cmVncyArIERJU1BfR0FNTUFfTFVUOw0KPiArCXZvaWQgX19pb21lbSAqbHV0MV9iYXNlID0gZ2Ft
bWEtPnJlZ3MgKyBESVNQX0dBTU1BX0xVVDE7DQo+ICsJdTMyIGNmZ192YWwsIGRhdGFfbW9kZSwg
bGJhbmtfdmFsLCB3b3JkWzJdOw0KPiAgCWludCBjdXJfYmFuaywgbnVtX2x1dF9iYW5rczsNCj4g
KwlzdHJ1Y3QgZHJtX2NvbG9yX2x1dCAqbHV0Ow0KPiArCXVuc2lnbmVkIGludCBpOw0KPiAgDQo+
ICAJLyogSWYgdGhlcmUncyBubyBnYW1tYSBsdXQgdGhlcmUncyBub3RoaW5nIHRvIGRvIGhlcmUu
ICovDQo+ICAJaWYgKCFzdGF0ZS0+Z2FtbWFfbHV0KQ0KPiBAQCAtOTIsMTQgKzExNiwxNyBAQCB2
b2lkIG10a19nYW1tYV9zZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QNCj4gZHJtX2NydGNf
c3RhdGUgKnN0YXRlKQ0KPiAgDQo+ICAJbnVtX2x1dF9iYW5rcyA9IGdhbW1hLT5kYXRhLT5sdXRf
c2l6ZSAvIGdhbW1hLT5kYXRhLQ0KPiA+bHV0X2Jhbmtfc2l6ZTsNCj4gIAljZmdfdmFsID0gcmVh
ZGwoZ2FtbWEtPnJlZ3MgKyBESVNQX0dBTU1BX0NGRyk7DQo+IC0JbHV0X2Jhc2UgPSBnYW1tYS0+
cmVncyArIERJU1BfR0FNTUFfTFVUOw0KPiAgCWx1dCA9IChzdHJ1Y3QgZHJtX2NvbG9yX2x1dCAq
KXN0YXRlLT5nYW1tYV9sdXQtPmRhdGE7DQo+ICANCj4gKwkvKiBTd2l0Y2ggdG8gMTIgYml0cyBk
YXRhIG1vZGUgaWYgc3VwcG9ydGVkICovDQo+ICsJZGF0YV9tb2RlID0gRklFTERfUFJFUChESVNQ
X0dBTU1BX0JBTktfREFUQV9NT0RFLCAhIShnYW1tYS0NCj4gPmRhdGEtPmx1dF9iaXRzID09IDEy
KSk7DQo+ICsNCj4gIAlmb3IgKGN1cl9iYW5rID0gMDsgY3VyX2JhbmsgPCBudW1fbHV0X2Jhbmtz
OyBjdXJfYmFuaysrKSB7DQo+ICANCj4gIAkJLyogU3dpdGNoIGdhbW1hIGJhbmsgYW5kIHNldCBk
YXRhIG1vZGUgYmVmb3JlIHdyaXRpbmcNCj4gTFVUICovDQo+ICAJCWlmIChudW1fbHV0X2Jhbmtz
ID4gMSkgew0KPiAgCQkJbGJhbmtfdmFsID0gRklFTERfUFJFUChESVNQX0dBTU1BX0JBTktfQkFO
SywNCj4gY3VyX2JhbmspOw0KPiArCQkJbGJhbmtfdmFsIHw9IGRhdGFfbW9kZTsNCj4gIAkJCXdy
aXRlbChsYmFua192YWwsIGdhbW1hLT5yZWdzICsNCj4gRElTUF9HQU1NQV9CQU5LKTsNCj4gIAkJ
fQ0KPiAgDQo+IEBAIC0xMTIsOSArMTM5LDE1IEBAIHZvaWQgbXRrX2dhbW1hX3NldChzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdA0KPiBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpDQo+ICAJCQlod2x1
dC5ibHVlID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGx1dFtuXS5ibHVlLA0KPiBnYW1tYS0+ZGF0
YS0+bHV0X2JpdHMpOw0KPiAgDQo+ICAJCQlpZiAoIWdhbW1hLT5kYXRhLT5sdXRfZGlmZiB8fCAo
aSAlIDIgPT0gMCkpIHsNCj4gLQkJCQl3b3JkID0NCj4gRklFTERfUFJFUChESVNQX0dBTU1BX0xV
VF8xMEJJVF9SLCBod2x1dC5yZWQpOw0KPiAtCQkJCXdvcmQgfD0NCj4gRklFTERfUFJFUChESVNQ
X0dBTU1BX0xVVF8xMEJJVF9HLCBod2x1dC5ncmVlbik7DQo+IC0JCQkJd29yZCB8PQ0KPiBGSUVM
RF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX0IsIGh3bHV0LmJsdWUpOw0KPiArCQkJCWlmIChn
YW1tYS0+ZGF0YS0+bHV0X2JpdHMgPT0gMTIpIHsNCj4gKwkJCQkJd29yZFswXSA9DQo+IEZJRUxE
X1BSRVAoRElTUF9HQU1NQV9MVVRfMTJCSVRfUiwgaHdsdXQucmVkKTsNCj4gKwkJCQkJd29yZFsw
XSB8PQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEyQklUX0csIGh3bHV0LmdyZWVuKTsN
Cj4gKwkJCQkJd29yZFsxXSA9DQo+IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9MVVRfMTJCSVRfQiwg
aHdsdXQuYmx1ZSk7DQo+ICsJCQkJfSBlbHNlIHsNCj4gKwkJCQkJd29yZFswXSA9DQo+IEZJRUxE
X1BSRVAoRElTUF9HQU1NQV9MVVRfMTBCSVRfUiwgaHdsdXQucmVkKTsNCj4gKwkJCQkJd29yZFsw
XSB8PQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX0csIGh3bHV0LmdyZWVuKTsN
Cj4gKwkJCQkJd29yZFswXSB8PQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX0Is
IGh3bHV0LmJsdWUpOw0KPiArCQkJCX0NCj4gIAkJCX0gZWxzZSB7DQo+ICAJCQkJZGlmZi5yZWQg
PSBsdXRbbl0ucmVkIC0gbHV0W24gLSAxXS5yZWQ7DQo+ICAJCQkJZGlmZi5yZWQgPQ0KPiBkcm1f
Y29sb3JfbHV0X2V4dHJhY3QoZGlmZi5yZWQsIGdhbW1hLT5kYXRhLT5sdXRfYml0cyk7DQo+IEBA
IC0xMjUsMTEgKzE1OCwxOSBAQCB2b2lkIG10a19nYW1tYV9zZXQoc3RydWN0IGRldmljZSAqZGV2
LCBzdHJ1Y3QNCj4gZHJtX2NydGNfc3RhdGUgKnN0YXRlKQ0KPiAgCQkJCWRpZmYuYmx1ZSA9IGx1
dFtuXS5ibHVlIC0gbHV0W24gLQ0KPiAxXS5ibHVlOw0KPiAgCQkJCWRpZmYuYmx1ZSA9DQo+IGRy
bV9jb2xvcl9sdXRfZXh0cmFjdChkaWZmLmJsdWUsIGdhbW1hLT5kYXRhLT5sdXRfYml0cyk7DQo+
ICANCj4gLQkJCQl3b3JkID0NCj4gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9SLCBk
aWZmLnJlZCk7DQo+IC0JCQkJd29yZCB8PQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEw
QklUX0csIGRpZmYuZ3JlZW4pOw0KPiAtCQkJCXdvcmQgfD0NCj4gRklFTERfUFJFUChESVNQX0dB
TU1BX0xVVF8xMEJJVF9CLCBkaWZmLmJsdWUpOw0KPiArCQkJCWlmIChnYW1tYS0+ZGF0YS0+bHV0
X2JpdHMgPT0gMTIpIHsNCj4gKwkJCQkJd29yZFswXSA9DQo+IEZJRUxEX1BSRVAoRElTUF9HQU1N
QV9MVVRfMTJCSVRfUiwgZGlmZi5yZWQpOw0KPiArCQkJCQl3b3JkWzBdIHw9DQo+IEZJRUxEX1BS
RVAoRElTUF9HQU1NQV9MVVRfMTJCSVRfRywgZGlmZi5ncmVlbik7DQo+ICsJCQkJCXdvcmRbMV0g
PQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEyQklUX0IsIGRpZmYuYmx1ZSk7DQo+ICsJ
CQkJfSBlbHNlIHsNCj4gKwkJCQkJd29yZFswXSA9DQo+IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9M
VVRfMTBCSVRfUiwgZGlmZi5yZWQpOw0KPiArCQkJCQl3b3JkWzBdIHw9DQo+IEZJRUxEX1BSRVAo
RElTUF9HQU1NQV9MVVRfMTBCSVRfRywgZGlmZi5ncmVlbik7DQo+ICsJCQkJCXdvcmRbMF0gfD0N
Cj4gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9CLCBkaWZmLmJsdWUpOw0KPiArCQkJ
CX0NCj4gIAkJCX0NCj4gLQkJCXdyaXRlbCh3b3JkLCAobHV0X2Jhc2UgKyBpICogNCkpOw0KPiAr
CQkJd3JpdGVsKHdvcmRbMF0sIChsdXQwX2Jhc2UgKyBpICogNCkpOw0KPiArCQkJaWYgKGdhbW1h
LT5kYXRhLT5sdXRfYml0cyA9PSAxMikNCj4gKwkJCQl3cml0ZWwod29yZFsxXSwgKGx1dDFfYmFz
ZSArIGkgKiA0KSk7DQo+ICAJCX0NCj4gIAl9DQo+ICANCj4gQEAgLTI0NiwxMSArMjg3LDIwIEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3BfZ2FtbWFfZGF0YQ0KPiBtdDgxODNfZ2FtbWFf
ZHJpdmVyX2RhdGEgPSB7DQo+ICAJLmx1dF9zaXplID0gNTEyLA0KPiAgfTsNCj4gIA0KPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9nYW1tYV9kYXRhIG10ODE5NV9nYW1tYV9kcml2ZXJf
ZGF0YSA9IHsNCj4gKwkubHV0X2Jhbmtfc2l6ZSA9IDI1NiwNCj4gKwkubHV0X2JpdHMgPSAxMiwN
Cj4gKwkubHV0X2RpZmYgPSB0cnVlLA0KPiArCS5sdXRfc2l6ZSA9IDEwMjQsDQo+ICt9Ow0KPiAr
DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZGlzcF9nYW1tYV9kcml2
ZXJfZHRfbWF0Y2hbXSA9DQo+IHsNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3
My1kaXNwLWdhbW1hIiwNCj4gIAkgIC5kYXRhID0gJm10ODE3M19nYW1tYV9kcml2ZXJfZGF0YX0s
DQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1nYW1tYSIsDQo+ICAJ
ICAuZGF0YSA9ICZtdDgxODNfZ2FtbWFfZHJpdmVyX2RhdGF9LA0KPiArCXsgLmNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTk1LWRpc3AtZ2FtbWEiLA0KPiArCSAgLmRhdGEgPSAmbXQ4MTk1X2dh
bW1hX2RyaXZlcl9kYXRhfSwNCj4gIAl7fSwNCj4gIH07DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxF
KG9mLCBtdGtfZGlzcF9nYW1tYV9kcml2ZXJfZHRfbWF0Y2gpOw0K
