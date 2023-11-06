Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035407E1A81
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjKFGxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFGxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:53:21 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21E09C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:53:17 -0800 (PST)
X-UUID: 233eac147c7111ee8051498923ad61e6-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TBSK4/+eQ+thoZSkj0f2Xc3FICcTP2w5r3Pc3LLwZDk=;
        b=ognMm/hKejZ5ie2MruSfDVXH9VQzRxlh4tAm8klQDagdcCxuAJXLjMoaRkTULS532Abu4dq39j8rPVepUi80hwFrqVmGkYSMmgx3jbBaT9NCBO/9n7TCtoaY0lmq4OeqjfRE2wOzRa3sucX53LG4T9PoxjBwesxU9UoPbQHtnQs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:6d3b9b8b-034d-4989-959e-d239d57e2211,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:44910e95-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 233eac147c7111ee8051498923ad61e6-20231106
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 580551253; Mon, 06 Nov 2023 14:53:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 14:53:04 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 14:53:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL8rnMh808or1k6n/fiDcjtg0Ct4KrwCl4ZrjwVHPLlDdzbbNYqjuTC1kYmYwACco1XxkYFc/00b6PFvDeaOOmBgRJom7GF7i/o5VftxV64TsokRqMBMFsyLgpGE0W3MhXPycV9JcwX/+QqAqapB0C+Tihn4cHWa7oOPsmHoMbRwX/liWaaCQvVUv1IMsnOE2MlonGlesL/1gGTBy/r3mu79Jujpg75jvGQqU7rNyiaxiJToKqcQXH04bP3GMT5G+s7MWgXYDKEEu1YPktCZOmkHARfx6ph3fFK5CfxuOaZg82coXdV9ok0PSB0abllkg8I5BqJsnHaeYWin8mru3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBSK4/+eQ+thoZSkj0f2Xc3FICcTP2w5r3Pc3LLwZDk=;
 b=K/QxK4cMN+gLkxhP2ddzZ3DLidjZQbxv6Yjd7/U5RfHP1SpnSfEu9QbabA7mw2KDqSK1yU7/2KITL6sftillKtD3qRpt2rfqni2ztjp8a6SnaPkfUBsk24PjunPlIUw52Cc2OaOnKYnr5AkEm8dkEx4np6Z68fBtw8d1ZJyutfL4OBoELoKIipMxfZyvPbwtZKVFx5tj6hBMgGGCPz2thlnwcWvoGvb93JHBaKb4fOaECCIC9p7nXGbnsHJxR25lFD+mtfg8y+tn9hdB9s83U2nMAQq3p3lSxaOHlKk7a/G2noEvtTDbmmWr+JbrVRWZBnTmkbKUHSNM1COgZZ1J4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBSK4/+eQ+thoZSkj0f2Xc3FICcTP2w5r3Pc3LLwZDk=;
 b=fMpEy9XMLxb+C6sP8p8F+eYnTXFKrCsSoBN8a81p5MkabddZMkNoHyXWWFTD4qB5RWtp0viwD3R1p57z9t0ZTHTzXNKkEQyaxMw9Bfh7LUd8kic7nkQ7P+pxkrIhqUvsb6PaPaR5a9yvsZwW14RM1dZmcSZOBbhYNGODFfpIZ7I=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB5853.apcprd03.prod.outlook.com (2603:1096:400:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 06:53:02 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 06:53:02 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Topic: [PATCH v2 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Index: AQHaBWrwfSB0SbM3skmo1MYcSwwgkrBs8OwA
Date:   Mon, 6 Nov 2023 06:53:02 +0000
Message-ID: <710408f06752201686f4b3587af1656d36e3654d.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-9-jason-jh.lin@mediatek.com>
In-Reply-To: <20231023043751.17114-9-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB5853:EE_
x-ms-office365-filtering-correlation-id: 9aec0d5f-7f48-4553-90f3-08dbde950524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yE3xORbj1B2HD9rU4B2kI40AbX2YKPKR9lZd6CzZ/FQZhGyIUhrANHs5hyGj/wDz7KV0T18XGarZ54/1DFcvyP37fgzaJ6C408zsURnpEfjlTtzPbNsfX0Oz5OD9cLncSdgBGhWZdWxbsLsBENQyRYJYh0ig7Yx7a6cQ+kBm9r79DmqFI18mCGAmnHslY1erL/Yex5Drj2CNSDH19JYYb6vfEz1xuzIMfb8j4oqDlxOILTm9aP6olHPc8rlVHqZrU0PTX+zZBKCAV9WiJKTXqocl/Yi5GCY3UtaYkM/VIsxppw51uJxIkPZlsYnA/dDnlX09Kmh0aFaFpDQGVp99I3u56Oe/bIga4Vt2HO383GYKMpuutXYhToe9XSEvrBJZTYrKCHbMB+r9tAZKgSJNVRkPyW4+8BIL1roHqxHITFN0gaVl9OMtpcAmTumQIObg8tr4jupPFLAuXGvRs/znyBuOP0fEhNBjDmO/7J/tX+syDEpNUgikDAbVR3qc2KhFza3wSTMaM71JDkZcn/gl7GjcTX0N3rqVbzLZWuxwBobma9KrIu1QXKeKIqvgRwednZzYyMZI/2DLV7pZUKPde5S7hgEeGVF7PpPRJobcJTralQNEmK77rV9ZPUlmHY6MTscMvM+eo4h5xXq5y25qH0jhG0Qru4yYZr9aaESvQ7g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38070700009)(85182001)(36756003)(4326008)(83380400001)(8936002)(8676002)(66946007)(26005)(316002)(66476007)(66446008)(54906003)(110136005)(64756008)(66556008)(76116006)(5660300002)(15650500001)(2906002)(7416002)(41300700001)(478600001)(6512007)(6486002)(2616005)(71200400001)(6506007)(122000001)(86362001)(38100700002)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHJ2TEg0a1NTc0tFZi9maC9wMW1CNDRBTnJaY3QycC9TaGI1S2dwaDR6RUZt?=
 =?utf-8?B?cVJDeGwyaVVBdHJlTG1oZjNSbWhLSElkcFdaRE5QMGtRd3ZlYmhkYWRpS0p4?=
 =?utf-8?B?OUhZbXJvQmx2NFhZWlR5dlBMWk9CT1BLYzVrVFJrUDRLYlVaZW8zSkR5VTZi?=
 =?utf-8?B?M3B3RFE5ZW9XZldGVlNZdEl6b0d3aUFIemNVdFJjWG5aV1hjdnVkSFQ5TzR3?=
 =?utf-8?B?SnA3YXA3Q1IyNFZQdFB5cm16R3d2d240NG9URUJBV2xFelNFVnI1anVQbmIy?=
 =?utf-8?B?VUxVaE9peU85TU1RV3dRdXJnV24rc01hTnlPWGdoRVBlNGRTck9kYlRXbHhC?=
 =?utf-8?B?S3J6K1RuSFR2TW8zODZ3RzNLdFlEUTJuRlJqQmZTZmdnWnY4RDdVNkk1T3VF?=
 =?utf-8?B?R0FiUG5Tb05pTDl3UFhndzZ1MlVNbmtaVWpxdWhza3ZYRStCUW15MXdUUXhT?=
 =?utf-8?B?NWJiL2UxY3BrT0wxalZoYlNqQm52YW1SbWhXWGdJQUhXd1d0cXp6RytUaGNS?=
 =?utf-8?B?T1VJNWFOQnBSNnRyOHlFUzNTRFZZM2hRWm45bEttL2RLVDlSUEVoNE1kOWpE?=
 =?utf-8?B?RlV4TitNWlU2WWhvRFVoQi9UOUo0WjhQNWRERktEU25Zc2d2OGxWZWZJRUZQ?=
 =?utf-8?B?bEE5N0kyTVh6LzRhclhoc2hWbzRLWEgvU1VWc2xEV0xjem05OFhGcFphcHVM?=
 =?utf-8?B?ZEVDWFBTYk1tcGtIbEdBZFI4NnNPaFdaNDl6UkxrTys1Tkt5KzZ3ZDc0QTJJ?=
 =?utf-8?B?b3hML2dwWXBZOUJMVmNzNDh0ajUyeGtsb1BFWlVjeDkrcU9hVVVidHJoYTBt?=
 =?utf-8?B?bWx3UVdJcTVLVGN4cWwvb0JSbGVWa3JuTng5d205LzJPb0ZrZTMvSHF4Q0d2?=
 =?utf-8?B?SVJxTGFlZXVBaTVDNnFId0paSE1aalhiZFpzNU1wYnkvNy93ZTNGdHZSbmRa?=
 =?utf-8?B?SjBkREI4NHhBaFhCYmVZajVveFd3WE1zOVM4SUZkN1Vnei9ZTlQvc0VINDBr?=
 =?utf-8?B?TEdXNVRBeVEwaHo2eS9hUHdWVFVaUXVFa3JJKzFEVEgxbDVReW5yNmNLdUlK?=
 =?utf-8?B?Ym4rQ2FDM2tCanBQWE9PQlgyc0xHWVRoKy92K0Zja0R6UFRZZnVXUjhjdnVm?=
 =?utf-8?B?cjZIWWVoZW1jSHJ6S1ZnQkd5cnkralArb2k1TXlocDRBS3BLdEpScUlPb0xG?=
 =?utf-8?B?Q3o3V1VHZ0lFcEx5bHVqOVZxejFqcXltY2NuN3Q2Vi9ORXdPRGovazhXRHJX?=
 =?utf-8?B?aHVodE84ZXBzbGQzMjdmWkplekFpanMwVWlaM0Rod1ZGK1ZlU3dEaEdtZDRJ?=
 =?utf-8?B?QVNkRERwQTM3aklTYVlxKzlXVXFQL1QrSGFpK1BnNTY2U05tbUwzSE03YXFo?=
 =?utf-8?B?R0pIZ0NVZ1V4ZmxhRit2M0w1ZmxMOGFDS0NndFZpbStXVWlpRm8zZUZqbG8r?=
 =?utf-8?B?UndERUVjTzhQczM3SU8vYS9yNU0xdW0wc21zM2FKazUvTUpBa091VnBFQktK?=
 =?utf-8?B?aE9VWDZrVlhDNElCdFpHSFRybWc3V3BQT3ZsQmJBRDNjMVZxdE10U0VNdjJa?=
 =?utf-8?B?ZG02MTR5ZkVVdDJKYm1NVUVNWkZmS1VHdks3dGlyZ0R6MEhpL25RZmEzaEdZ?=
 =?utf-8?B?SXp0N0VuV1NSZjE5d2hVZXdLYVVZVC83WHptcUE3dmFSTlRaWTN5V0ptTi96?=
 =?utf-8?B?YjVaVHBFaFI2UkxGd3ArMmgrZWNyZ2NSSEx5TGdYV0YrMWxNWC9xdENCVUJC?=
 =?utf-8?B?OERiaUNOWldSRSsxaVZWZUthWm1ZVW5qb2pnQWdSYnJBV295ZzJlU1FnNDc1?=
 =?utf-8?B?NDlaN1VQd3ZUZ1hOaXZWbWpnUEpJTkR4b0w5bDhHOFAwY0M3aUlYU3lPQ1NG?=
 =?utf-8?B?VkZNemYrL3lBZThzMndkRHpqZ212RStGaWFxYTVGWUJZNmo5VnpzT3NSdlYr?=
 =?utf-8?B?Z2Vxa0NjTjlybFNwNWdzSmM3R3UrT3hZN2duMU85U3JQS2pndUdCRTRKWXRy?=
 =?utf-8?B?eTl6bHJWZ0Y3UTg1Zi84aElIanZ5eFg1Qm1DUHp0V0RYVkoxRVlPMXlzVzhw?=
 =?utf-8?B?QVB2QkI1UmVNTGNxWEdUY3kzQ1VTZXFQTGs0SThsck54ZnpjWm5KN0pwdnhR?=
 =?utf-8?Q?YrJxRxB821QEc94KCtzlj9tMN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F3AD723B9A290419B117117D5AEC3B8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aec0d5f-7f48-4553-90f3-08dbde950524
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 06:53:02.0560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NC7d1/RqwAVDAEHw18BbRNGWHOYSmr8GcS4sk7mbNRV/agzXH+xmwBdoP7WpkuWf8f4e2Wlx5vJWcNghjx8y0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5853
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.520100-8.000000
X-TMASE-MatchedRID: y/2oPz6gbvj4OiVTWoD8RCa1MaKuob8PC/ExpXrHizz3bBqxmjinTbs0
        9RsYKeKEiUqxWFzqa/9QGF7v4Up8Fw9FV6kNYiPHbc297PAGtWaQoBr+SFneJHPBWZjlMys2mnE
        k8Dlkh76VMlcqqHWd7dUvsMhDJV3vnh05MEIv7NddtN+hx8BZv5yDP1rrUdvhFRlN8zTSzj76p1
        jlhLAJAuYsPL+HjAe5slTuxC8wFiUlzKAf/CCChI7Su3QulAZ5LoYOuiLW+uVqKibMZp4C8E8JU
        10YmY3BdVJmOg3Y5nfscsjyBKk23a+/EguYor8c0gVVXNgaM0pZDL1gLmoa/PoA9r2LThYYKrau
        Xd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.520100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: A1C47380D2991DBB3B90745313934A50AD4E4D7CAC1B52CF73C510C57DCCABAD2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjMtMTAtMjMgYXQgMTI6MzcgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gcGF0aCBmZWF0dXJlLCBHQ0Ug
aGF2ZSB0byByZWFkL3dyaXRlDQo+IHJlZ2lzdGdlcnMNCj4gaW4gdGhlIHNlY3VyZSB3b3JsZC4g
R0NFIHdpbGwgZW5hYmxlIHRoZSBzZWN1cmUgYWNjZXNzIHBlcm1pc3Npb24gdG8NCj4gdGhlDQo+
IEhXIHdobyB3YW50cyB0byBhY2Nlc3MgdGhlIHNlY3VyZSBjb250ZW50IGJ1ZmZlci4NCj4gDQo+
IEFkZCBDTURRIHNlY3VyZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xpZW50IHVzZXIg
aXMgYWJsZSB0bw0KPiBzZW5kaW5nIHRoZWlyIEhXIHNldHRpbmdzIHRvIHRoZSBzZWN1cmUgd29y
bGQuIFNvIHRoYXQgR0NFIGNhbg0KPiBleGVjdXRlDQo+IGFsbCBpbnN0cnVjdGlvbnMgdG8gY29u
ZmlndXJlIEhXIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
bi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9t
YWlsYm94L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgIHwgICAgMiArLQ0KPiAgZHJpdmVy
cy9tYWlsYm94L210ay1jbWRxLXNlYy1tYWlsYm94LmMgICAgICAgIHwgMTEwMg0KPiArKysrKysr
KysrKysrKysrKw0KPiAgZHJpdmVycy9tYWlsYm94L210ay1jbWRxLXNlYy10ZWUuYyAgICAgICAg
ICAgIHwgIDIwMiArKysNCj4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmggICAgICB8ICAgIDIgKw0KPiAgLi4uL2xpbnV4L21haWxib3gvbXRrLWNtZHEtc2VjLWl3Yy1j
b21tb24uaCAgIHwgIDI5MyArKysrKw0KPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRx
LXNlYy1tYWlsYm94LmggIHwgICA4MyArKw0KPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1j
bWRxLXNlYy10ZWUuaCAgICAgIHwgICAzMSArDQo+ICA3IGZpbGVzIGNoYW5nZWQsIDE3MTQgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
bWFpbGJveC9tdGstY21kcS1zZWMtbWFpbGJveC5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9tYWlsYm94L210ay1jbWRxLXNlYy10ZWUuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGlu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1zZWMtaXdjLWNvbW1vbi5oDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLXNlYy1tYWlsYm94LmgN
Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtc2Vj
LXRlZS5oDQo+IA0KPiANCg0KW3NuaXBdDQoNCj4gKw0KPiAraW50IGNtZHFfc2VjX2luc2VydF9i
YWNrdXBfY29va2llKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiArew0KPiArCXN0cnVjdCBjbWRx
X2NsaWVudCAqY2wgPSAoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbDsNCj4gKwlzdHJ1Y3Qg
Y21kcV9zZWNfdGhyZWFkICp0aHJlYWQgPSAoKHN0cnVjdCBtYm94X2NoYW4gKikoY2wtDQo+ID5j
aGFuKSktPmNvbl9wcml2Ow0KPiArCXN0cnVjdCBjbWRxX3NlYyAqY21kcSA9IGNvbnRhaW5lcl9v
Zih0aHJlYWQtPmNoYW4tPm1ib3gsIHN0cnVjdA0KPiBjbWRxX3NlYywgbWJveCk7DQo+ICsJc3Ry
dWN0IGNtZHFfb3BlcmFuZCBsZWZ0LCByaWdodDsNCj4gKwlkbWFfYWRkcl90IGFkZHI7DQo+ICsN
Cj4gKwlpZiAoIXRocmVhZC0+b2NjdXBpZWQgfHwgIWNtZHEtPnNoYXJlZF9tZW0pDQo+ICsJCXJl
dHVybiAtRUZBVUxUOw0KPiArDQo+ICsJcHJfZGVidWcoIiVzICVkOiBwa3Q6JXAgdGhyZWFkOiV1
IGdjZTolI2x4IiwNCj4gKwkJIF9fZnVuY19fLCBfX0xJTkVfXywgcGt0LCB0aHJlYWQtPmlkeCwg
KHVuc2lnbmVkDQo+IGxvbmcpY21kcS0+YmFzZV9wYSk7DQo+ICsNCj4gKwlhZGRyID0gKHUzMiko
Y21kcS0+YmFzZV9wYSArIENNRFFfVEhSX0JBU0UgKw0KPiArCQlDTURRX1RIUl9TSVpFICogdGhy
ZWFkLT5pZHggKyBDTURRX1RIUl9FWEVDX0NOVF9QQSk7DQo+ICsNCj4gKwljbWRxX3BrdF9hc3Np
Z24ocGt0LCBDTURRX1RIUl9TUFJfSURYMSwgQ01EUV9BRERSX0hJR0goYWRkcikpOw0KPiArCWNt
ZHFfcGt0X3JlYWRfcyhwa3QsIENNRFFfVEhSX1NQUl9JRFgxLCBDTURRX0FERFJfTE9XKGFkZHIp
LA0KPiBDTURRX1RIUl9TUFJfSURYMSk7DQo+ICsNCj4gKwlsZWZ0LnJlZyA9IHRydWU7DQo+ICsJ
bGVmdC5pZHggPSBDTURRX1RIUl9TUFJfSURYMTsNCj4gKwlyaWdodC5yZWcgPSBmYWxzZTsNCj4g
KwlyaWdodC52YWx1ZSA9IDE7DQo+ICsJY21kcV9wa3RfbG9naWNfY29tbWFuZChwa3QsIENNRFFf
TE9HSUNfQURELCBDTURRX1RIUl9TUFJfSURYMSwNCj4gJmxlZnQsICZyaWdodCk7DQo+ICsNCj4g
KwlhZGRyID0gY21kcS0+c2hhcmVkX21lbS0+cGEgKyBDTURRX1NFQ19TSEFSRURfVEhSX0NOVF9P
RkZTRVQgKw0KPiArCQl0aHJlYWQtPmlkeCAqIHNpemVvZih1MzIpOw0KPiArDQo+ICsJY21kcV9w
a3RfYXNzaWduKHBrdCwgQ01EUV9USFJfU1BSX0lEWDIsIENNRFFfQUREUl9ISUdIKGFkZHIpKTsN
Cj4gKwljbWRxX3BrdF93cml0ZV9zKHBrdCwgQ01EUV9USFJfU1BSX0lEWDIsIENNRFFfQUREUl9M
T1coYWRkciksDQo+IENNRFFfVEhSX1NQUl9JRFgxKTsNCg0KVGhpcyBpcyBhIHNhbXBsZSBjb2Rl
IG9mIHJlYWRpbmcgc2VjdXJlIGRhdGEgYW5kIHdyaXRpbmcgdG8gbm9ybWFsDQp3b3JsZC4gSSB0
aGluayB5b3UgaGF2ZSBhbHJlYWR5IGNoZWNrIGFkZHJlc3Mgb2YgY21kcV9wa3RfcmVhZF9zKCkg
aW4NClRFRS4gVGhpcyBpcyBhIHNhbXBsZSBjb2RlIHRoYXQgaGFja2VyIG1heSB0cnkgdG8gcmVh
ZCBhbnkgc2VjdXJlDQphZGRyZXNzOg0KDQoJY21kcV9wa3RfYXNzaWduKHBrdCwgQ01EUV9USFJf
U1BSX0lEWDEsDQpDTURRX0FERFJfSElHSChoYWNrX2FkZHJlc3MpKTsNCgljbWRxX3BrdF9qdW1w
KHBrdCwgcmVhZCk7DQoJY21kcV9wa3RfYXNzaWduKHBrdCwgQ01EUV9USFJfU1BSX0lEWDEsIENN
RFFfQUREUl9ISUdIKGFkZHIpKTsNCnJlYWQ6DQoJY21kcV9wa3RfcmVhZF9zKHBrdCwgQ01EUV9U
SFJfU1BSX0lEWDEsIENNRFFfQUREUl9MT1coYWRkciksDQoJCUNNRFFfVEhSX1NQUl9JRFgxKTsN
Cg0KUGxlYXNlIGV4cGxhaW4gaG93IHlvdSBwcm90ZWN0IHRoaXMgaGFja2VyIGF0dGFjay4NCg0K
UmVnYXJkcywNCkNLDQoNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJP
TChjbWRxX3NlY19pbnNlcnRfYmFja3VwX2Nvb2tpZSk7DQo+ICsNCg==
