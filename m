Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172287ACFE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjIYGPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjIYGPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:15:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A2FCE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:14:54 -0700 (PDT)
X-UUID: c0debe005b6a11eea33bb35ae8d461a2-20230925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EkYDMdLqq6GFBpe09xJ9QEf954mkAgqQEbbo7bgc0JY=;
        b=XkEbAucp801owsroBzHZvehZzEU+ITPXw5q+mIjbTuUpzj97TCJ5y1jnizLSbjGQMGDOYho7kM1WZXhkDujDRE0/1LQpwvBbkvUrZTyAJstD/2L9NhOE+bM5aT+7/fnMLiow8m02BLeovc4/fb0WnJYEQvp3x+g/JohJifDxYio=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:8193c446-8d63-4b08-a0d4-dc70ba3e0d54,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:330318f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c0debe005b6a11eea33bb35ae8d461a2-20230925
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1074804685; Mon, 25 Sep 2023 14:14:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Sep 2023 14:14:15 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Sep 2023 14:14:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwwfLwpi88XPlHkNIsCKfYMTiu9l1iZjG+vCVaVJvJHrdm7JeE2eCSO9+YcVJ25eDEhWktu1ys9fDXPM5W57Sqt8NG8SXJ+6N3hiVNF7c9r8LdFLVYha1biOY+lQc8yXESy8Tnjlkap2NA4AdKi7v7wvFZS7JFvacnsHI3EGpZnhELFvY3O9DdJmib6go5ptsw+wCIvB8n0bkpEsOZ+xywnl2va5qonCEQDC48LQr84bXLpg/oqWUn/as+WW8IY+fG7uiXYFCVvsVYCxysguGYBkOXqyqw1nrE44DRkq85OWrlYzw3vahSqYJAGnRYbMdhyy5IGPfVLxyQqP9UPYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkYDMdLqq6GFBpe09xJ9QEf954mkAgqQEbbo7bgc0JY=;
 b=eejCGsLwEMnHysVjBuZwrigZtWCQi5wjK8RIiEAhkhqp2hL/0PeNjFVi9kW6jvTH7vvEI/eMwR+THkFtx7QU+Was7XibBFnvMrT06TDtXwNsO3RtE4Vq7IZv/XkbJHV/mz9LZtme5DRHdlNgLKge9RbUpcMn03eUFgBAYFFNksEGucclsYGehYd123K1khT0DAawOSiNSbdY1T7zxPOk8VAc+ssvjrcJestEQNv+3U1TOtI3wYMVEcyPBNi1cHAavrupb+YM/7CJjVFFsnGVF7vu5LKPD5Bo9ddS0HbDZrLgWUdSJZgCQM7E5HYTITx62163+IMucrGBqe9/29rZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkYDMdLqq6GFBpe09xJ9QEf954mkAgqQEbbo7bgc0JY=;
 b=bRRkzdgwEuiUxID3xRd0E2nCuBae0EjDSmdUMvdKAfWvhF2ZUX2vkv+rmp69AbMTZ2IdF0amP80YKscTS1rPU+iTFsbzMeRM9Fxj3BTzLONWlZ5UTiGy+UC9+27LInTZ7dish8ZyIyACEk/c+4nCdHNlyrRaihMo8Bh38MmAKzk=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI2PR03MB6664.apcprd03.prod.outlook.com (2603:1096:4:1eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 06:14:12 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 06:14:12 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
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
Subject: Re: [PATCH v9 4/7] drm/mediatek: Add encoder_index function to
 mtk_ddp_comp_funcs for dpi
Thread-Topic: [PATCH v9 4/7] drm/mediatek: Add encoder_index function to
 mtk_ddp_comp_funcs for dpi
Thread-Index: AQHZ6gBM3G+dkzxDYU6DhX2+bT5yC7ArGv+A
Date:   Mon, 25 Sep 2023 06:14:12 +0000
Message-ID: <7220fae43e2439012ab0340021029c337f561c8b.camel@mediatek.com>
References: <20230809181525.7561-1-jason-jh.lin@mediatek.com>
         <20230809181525.7561-5-jason-jh.lin@mediatek.com>
         <96832cdaa57a97768fdb16d08f39afa75120aec8.camel@mediatek.com>
In-Reply-To: <96832cdaa57a97768fdb16d08f39afa75120aec8.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI2PR03MB6664:EE_
x-ms-office365-filtering-correlation-id: f266e1da-a2aa-460a-bda7-08dbbd8ea321
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBS/CJMZeYimB/vGguJAFdrUGe3OpNYwzndUos5clQutgUhAixMdwla2UAJcxo4Lg+RPCnVNRT/1ymTopur98fTFllaLn8en3IFjP3cmwFoGzPk/m0XpSj0Ip+fzgf5T5fvxkWRHVB55g5f5WAMT/OPCyl3MqEDDCJo9iliSeJyyU+FPPYQPovtpw88tw7MGW4DsG3rU2EMkcN99SVTNa2nioEt+kFBGgZ6v/R7sqgVY5OHabsO67KHBIrXB4gDT4jPJPPLG0baFww/ZinNSBl7yf3z2Kc/hAgWh4MCe0Yl52qSOvaiNHSlBpb+cMwg3Jvgf4MDVL5Sf3pvJDJXH/HAqiycN5VNIf53hTaMKTtw7dWvNWgJx10Hy4Is6xuXPzFklxUEN0aCe2uyGnFGR1TUQf0LaqFD+8BfPdfKrYhjMPhFZIZjvBCwrZakqQWKj/OTy49xtzbY6Ofz6k4Z6xhGrSHpFfhgmWVkfrcwUv/MURE30WvVtwIOvwiNXaTzZ08LGgMNEoqHx2B6IQPa4WqLKShnFmnTb50oMX6u+sWzUiQAlRKPRpXvPaW/Tze+riW9V0UNbI3+ZWwF/gPRZXAcOZGMkL0cITuSSitl0yyXtR+5+4r9Q9zCCIGDzeAFOwV63VMeYvL4UiIt4dIj7ad6z6lyAnvdB4WnusPSsVUE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(91956017)(316002)(26005)(66946007)(66476007)(66556008)(66446008)(110136005)(76116006)(5660300002)(2906002)(64756008)(54906003)(478600001)(8676002)(4326008)(41300700001)(8936002)(6486002)(6506007)(71200400001)(6512007)(36756003)(85182001)(2616005)(38070700005)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajZKeFVVR21vWGJwdzR4VFV5VDhITTR4Rm1SOGxWRG9HdjJyVXlsZHpXd2M4?=
 =?utf-8?B?cHVaNENteUQ4d3JQREpqSTlIb3l0NURlbzZJRWVrMEJERXZmcGp3UmkyUDdY?=
 =?utf-8?B?Qm5ZalFRRnR3ZWhRRzIxVmFIMUVoQ1Brb0tBbFhNY2NWcGdrWmVFaHJFOFQ1?=
 =?utf-8?B?L29mKzJyK1lUcWNhVzNsY1pzbXVnSjRXNzJybEpmUzR3c3VKV3hZTCtzdXF6?=
 =?utf-8?B?aXBhbTVoc2IzWEV3UERCRGNHMDVoL1M2aFhvamYrUjUxcmdickpYT01ZS2Jy?=
 =?utf-8?B?SVZmZGhqME8xQlBINjRrUXJTcm9SVi9PeXBqTmxSNEVSZjNUam84dURXcitP?=
 =?utf-8?B?ekNlaXphckI0a3ZTUk15dnJYcEF2b1Q2b3EyL2x5aEg3ZWthSi9qZllFYm01?=
 =?utf-8?B?dCtCcUl3bGVpbG0xOGE2ZHE3VVlyUFcvdjlPRzRVbFl6Y3Q4Ykl2ay8zQzRs?=
 =?utf-8?B?Q2N0cnk5YmFuYTN5V3BWYk9mUjVsS1V0ektYeDBldEs4OGJUSHVIUjl2RUNB?=
 =?utf-8?B?dUoxWEN6TjliQVpPR3F5K2FIalU2QlhSLytEWWFpaXlPdnFWZ0ZuemFEeUlT?=
 =?utf-8?B?TFFZNFMwT3MyZmI2d2FzTTRUSldpVTFhbFI2WWZNVkRzMUkzM2R1eDZRY2F0?=
 =?utf-8?B?TjZFQ3k0RDNLbnA0K3JUeCs3YWc3OXdrQ1p5ZjJuaUlvWEZSSVEwaEk2NHhF?=
 =?utf-8?B?bFRhdjNobG5JU0RNc1JCaXYybmZlTGxYUnlRVG8zQzV1em1LZStTZmZobGIz?=
 =?utf-8?B?RkxaQ1ZCMmJ6bTF1bU1PRWtoQlUxYmVIQjIxUUdjRGZQT1h4V0xOVmlwQllI?=
 =?utf-8?B?WGlKR0U3ZThmOHlWWUpodXR3N1N0Slk2QjhBTGMvdE5sQVBzczFLSXplTUh1?=
 =?utf-8?B?OGpqY3lYcFJDUjhVVnExdjZ3azdnbTF3YkFsMFlVQkJQWE1aTlpZeUlLdWdv?=
 =?utf-8?B?V2ltT0dMZUU2eDdaL0FHMWZDUWs0WU9TSlYrYjZpTU1LQkNXUEZ6ZS92TmRE?=
 =?utf-8?B?R3A3U3AyRUpKMXJwZzhtbjllVTVsYkhRUXJqbkdXY2lKUVhleGJna2lqSWxj?=
 =?utf-8?B?cTErd3RuSFkzVnh3VURXN0lUQkhURXhVQTZQK1NiRHFmYzc2UDZZemthNVc0?=
 =?utf-8?B?U3hMOXRCb284dkdtYW53S05Hb0FkeVp1MGVpbkdsVGVyNXBQVTJ2cDk2d00z?=
 =?utf-8?B?eHUzaXM4QlQwYnJWakxhVHlMVXhaUE4zUnZSZG9WNGY3ZDZ6NmZXQUgrbW5V?=
 =?utf-8?B?a3R4RVhBYUdnZXM0NjM0dHFzUEJQVE5wdmx0L0dOTklYWmZGU0wwVTM4OVZv?=
 =?utf-8?B?UmsvRTdPT09Bb0d4bW9sbTVNV1VNNEs5WEpnL1IyMlFQSHVlVCtzNUR4VDRH?=
 =?utf-8?B?UloxQ1ZyU0l5SXVYTzlZN2ZnbjJjK2l1M3dpelV2UFpTZVo5RUljMXNwZ1pt?=
 =?utf-8?B?QUdDTU11SXl4b2tpbVM5STRNcmFsVW5FTXVudDVVemJNRTlKaXVsMXZMZWlO?=
 =?utf-8?B?aVp4S1QxTEZLVStyNlB0K1lSUHRVRUREU2J3NUtZMFFTcWFYSlp6aXArTits?=
 =?utf-8?B?a3A5KzlvdC9RRUZ4WDdsSDN5NnF6MXV5YXlNOWV5U2FkRmRoV29DR1lxLzJJ?=
 =?utf-8?B?bTJkRnV1bWdObjlWVzJzQWZBa3JzTmw3bmNIMFMzN1JOcjNyaEFLdVkvNnFy?=
 =?utf-8?B?QmxQZjhXVnRLdnlQTW1xUm5LaW1wQnFJY1pMVXZkaklRaDlmRCtzR3l3VGwr?=
 =?utf-8?B?YmhTNWwvQVBkbGJza29xRUJYK3FHaWd6aUxPVVNqbjdja3k3c1hLZEVUdEJY?=
 =?utf-8?B?dTNuSmtJcE43bjFaK2VIUDZXcEFndUN6eTFFWGJ0K1hMM0orbjVQL3J1M2lG?=
 =?utf-8?B?dk8vSkhRbkVGOVRQUVZLSzNUOTcrYmdTdlU3L3VsSDh0cEFLY1hnb0NqdDFa?=
 =?utf-8?B?TzlMa3hhQzRBOElzRm1TdGhrQ2x3MUROK3dhakVQbkJwSGZQVkhYcERYd0E1?=
 =?utf-8?B?QVBhU0hNWTIwUHIvVFBZTFMvdUk5K1pueE1oSFBQLytaREE1MmF0c1dtdnFq?=
 =?utf-8?B?S09CUlFEbFlaR2NEcmtheTRweUVYMVp4VFBNUUYxMjlXemlsSHNYNlNtSm1T?=
 =?utf-8?B?M0UvMkxIQzM0VHlNUjk5UmxGLzg5WWZyRnQvMksrdmIyZTZVeUpWYVZCV0h1?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2633658C6133F459B4881C1DA5149EF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f266e1da-a2aa-460a-bda7-08dbbd8ea321
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 06:14:12.2903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YluE93Lr0L5MFlfb0TNlf5FExpFqjXLjVu+tQbQZjnEVjO7MqeKarby9skr7SWaQdUDbJehXcuRgPnTCGiuEW0FBrIwzkcCCuJLROsQf26E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyMy0wOS0xOCBh
dCAwNzoxOCArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIFRodSwgMjAyMy0wOC0xMCBhdCAwMjoxNSArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IFRvIHN1cHBvcnQgZHluYW1pYyBjb25uZWN0b3Igc2VsZWN0aW9uIGZ1bmN0aW9uLCBl
YWNoIGRkcF9jb21wIG5lZWQNCj4gPiB0bw0KPiA+IGdldCB0aGVpciBlbmNvZGVyX2luZGV4IHRv
IGlkZW50aWZ5IHdoaWNoIGNvbm5lY3RvciBzaG91bGQgYmUNCj4gPiBzZWxlY3RlZC4NCj4gPiAN
Cj4gPiBBZGQgZW5jb2Rlcl9pbmRleCBmdW5jdGlvbiB0byBtdGtfZGRwX2NvbXBfZnVuY3MgYW5k
IHRoZQ0KPiA+IGltcGxlbWVudGF0aW9uDQo+ID4gb2YgbXRrX2RwaV9lbmNvZGVyX2luZGV4IHRv
IGdldCBpdHMgZW5jb2Rlcl9pbmRleC4NCj4gDQo+IFNlcGFyYXRlIHRoZSBjb21tb24gcGFydCBh
bmQgZHBpIHBhcnQgdG8gZGlmZmVyZW50IHBhdGNoLg0KPiANCg0KT0ssIEknbGwgc2VwYXJhdGUg
dGhlIGNvbW1vbiBwYXJ0IGF0IHRoZSBuZXh0IHZlcnNpb24uDQoNCj4gUmVnYXJkcywNCj4gQ0sN
Cj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5A
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3BfZHJ2LmggICAgIHwgMSArDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHBpLmMgICAgICAgICAgfCA5ICsrKysrKysrKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kZHBfY29tcC5jIHwgMSArDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2RkcF9jb21wLmggfCAxICsNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9kcnYuaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNw
X2Rydi5oDQo+ID4gaW5kZXggMjI1NDAzODUxOWUxLi41ZjA3MDM3NjcwZTkgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ID4gQEAgLTQ0LDYgKzQ0
LDcgQEAgdm9pZCBtdGtfZGl0aGVyX3NldF9jb21tb24odm9pZCBfX2lvbWVtICpyZWdzLA0KPiA+
IHN0cnVjdCBjbWRxX2NsaWVudF9yZWcgKmNtZHFfcmVnLA0KPiA+ICANCj4gPiAgdm9pZCBtdGtf
ZHBpX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gIHZvaWQgbXRrX2RwaV9zdG9wKHN0
cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gK3Vuc2lnbmVkIGludCBtdGtfZHBpX2VuY29kZXJfaW5k
ZXgoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiAgDQo+ID4gIHZvaWQgbXRrX2RzaV9kZHBfc3Rh
cnQoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiAgdm9pZCBtdGtfZHNpX2RkcF9zdG9wKHN0cnVj
dCBkZXZpY2UgKmRldik7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHBpLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4g
PiBpbmRleCA5NDhhNTNmMWY0YjMuLjNkNmIzYzIyOGYzMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcGkuYw0KPiA+IEBAIC03ODIsNiArNzgyLDE1IEBAIHZvaWQgbXRrX2Rw
aV9zdG9wKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCW10a19kcGlfcG93ZXJfb2ZmKGRwaSk7
DQo+ID4gIH0NCj4gPiAgDQo+ID4gK3Vuc2lnbmVkIGludCBtdGtfZHBpX2VuY29kZXJfaW5kZXgo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbXRrX2RwaSAqZHBpID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKwl1bnNpZ25lZCBpbnQgZW5jb2Rlcl9pbmRleCA9
IGRybV9lbmNvZGVyX2luZGV4KCZkcGktPmVuY29kZXIpOw0KPiA+ICsNCj4gPiArCWRldl9kYmco
ZGV2LCAiZW5jb2RlciBpbmRleDolZFxuIiwgZW5jb2Rlcl9pbmRleCk7DQo+ID4gKwlyZXR1cm4g
ZW5jb2Rlcl9pbmRleDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBtdGtfZHBpX2Jp
bmQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlICptYXN0ZXIsDQo+ID4gdm9pZCAq
ZGF0YSkNCj4gPiAgew0KPiA+ICAJc3RydWN0IG10a19kcGkgKmRwaSA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kZHBfY29tcC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5jDQo+ID4gaW5kZXggZjExNGRhNGQzNmE5Li5lZmZhYWE3NjliNDYgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gPiBAQCAt
MzA0LDYgKzMwNCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzDQo+
ID4gZGRwX2RpdGhlcg0KPiA+ID0gew0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBf
Y29tcF9mdW5jcyBkZHBfZHBpID0gew0KPiA+ICAJLnN0YXJ0ID0gbXRrX2RwaV9zdGFydCwNCj4g
PiAgCS5zdG9wID0gbXRrX2RwaV9zdG9wLA0KPiA+ICsJLmVuY29kZXJfaW5kZXggPSBtdGtfZHBp
X2VuY29kZXJfaW5kZXgsDQo+ID4gIH07DQo+ID4gIA0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19kZHBfY29tcF9mdW5jcyBkZHBfZHNjID0gew0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+ID4gaW5kZXggZmViY2FlZWYxNmExLi4z
MjZjYjU3YTE4YzkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZGRwX2NvbXAuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcF9jb21wLmgNCj4gPiBAQCAtODAsNiArODAsNyBAQCBzdHJ1Y3QgbXRrX2RkcF9jb21w
X2Z1bmNzIHsNCj4gPiAgCXZvaWQgKCpkaXNjb25uZWN0KShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdCBkZXZpY2UNCj4gPiAqbW1zeXNfZGV2LCB1bnNpZ25lZCBpbnQgbmV4dCk7DQo+ID4gIAl2
b2lkICgqYWRkKShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtdGtfbXV0ZXggKm11dGV4KTsN
Cj4gPiAgCXZvaWQgKCpyZW1vdmUpKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG10a19tdXRl
eCAqbXV0ZXgpOw0KPiA+ICsJdW5zaWduZWQgaW50ICgqZW5jb2Rlcl9pbmRleCkoc3RydWN0IGRl
dmljZSAqZGV2KTsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIHN0cnVjdCBtdGtfZGRwX2NvbXAgew0K
