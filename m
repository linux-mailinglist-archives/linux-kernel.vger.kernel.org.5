Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3E479CB52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjILJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjILJPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:15:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E1D1703
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:15:05 -0700 (PDT)
X-UUID: d95b948a514c11ee8051498923ad61e6-20230912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=od4FaUhNzlTWCnyOat7KMqouPr0pGGmOJvibLAJYiHY=;
        b=hBDR/lq1S9z9fBoUZAlEAJKQY74+DmiXphD7j7EMN+MO/eAt5m433VfM2rNwdxjNb2LbQpp5BzdaxJ2h5syHoHxo/zM1H7RgLbPDF+KcncpQjG7ffuT8CxCHojGEfbblEJmiiD/fQ5+3SJk68PKlTbwBE+DvymKBeA2fyFFnFW8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:e1f0f9b2-de17-4127-b441-3ded020a745d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:65a1eec2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d95b948a514c11ee8051498923ad61e6-20230912
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1641153467; Tue, 12 Sep 2023 17:15:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Sep 2023 17:14:58 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Sep 2023 17:14:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOnxIDZonJgiFb9ilZpjT/V/2n78Ky4lBAj0IJKV2pA3fg+A33iLM4gZTRfz0x/eXhPnoA5ALliDlUEFfa7nBGiJxvEpKR/Fps3W3QOHYHd4P3kULMjmpxyAChfPRPdd59NopcPIQgVHrQoYrtzls86Gu8l5qAMCHZf+DAMgnhECFG2TaMbfJEg13HlXgSaXTb5OpEmKF16HwRgRG/c4Oltu0unV2VDXAlux4lwlElMEYOFPBdcF3Y9sXTl1GMQfxXUopXbgJLP0AyMuuPNZCPBIkMExODXGE4Bdv4hU/QtI/cPW33xh4AAp39kBa4VMFv85uK/CMEN3vXZT4MLB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od4FaUhNzlTWCnyOat7KMqouPr0pGGmOJvibLAJYiHY=;
 b=D7RD4sIkVpHRd8jstggEcQvpkeUMQL0I1tCWSLfIXl2YkoWig7OCcef49LLseuZrsim321jmW4SJMWR61dSjUbCORXtUEx42YuirFRIZz+q0xdw6ieAK/0rFCM+T8poeAIXhWHQuK+CQJF79nL32YDul8XSTilroGWm+TUOluowwfL6wMgOq6YGxILAvBTSrv/CopBVDHWrJ/jfBESD/jLa7gk92jsaLO5Fcu3DoFOXgVHGPESEIsAfdX1PvvwzRGhxrRkbdKEnlUo0oDb/yGxz6UV4da923NLjoLMpRoB5+3+g/sX70rPLYBsnWXP2KS/DnvYMJH44Oo9uyHwDLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od4FaUhNzlTWCnyOat7KMqouPr0pGGmOJvibLAJYiHY=;
 b=L3Flu9sIIfKmqAHc59zoDPvX07xDDWrXcXtjfP46GTg1v5Nxt6Vw3FmunqkP7ipXsBhX3sJB0tec8XpNfdY6DyPT24DEkl/ESQC6elnKRP/2Cq7Rkf9IkyB8CM6FdOjJb7SYssub1Hu3p861A+48aiTWfn0BUGNf2Sg1mvHCB6k=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB5465.apcprd03.prod.outlook.com (2603:1096:4:101::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 09:14:56 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:14:55 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5] drm/mediatek: Fix coverity issue with unintentional
 integer overflow
Thread-Topic: [PATCH v5] drm/mediatek: Fix coverity issue with unintentional
 integer overflow
Thread-Index: AQHZ4WvO1RbeWk1gxE2cMA+ZoZgmlLAW8FcA
Date:   Tue, 12 Sep 2023 09:14:55 +0000
Message-ID: <c7a7f4ec1cc32825e66978a7fccc9306fd309abd.camel@mediatek.com>
References: <20230907091425.9526-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20230907091425.9526-1-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB5465:EE_
x-ms-office365-filtering-correlation-id: 0fdaf0e8-1e45-4767-86c1-08dbb370bac2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KD0ZIhNQdHSEE3Y05qa5rX7VnRWrn3102tF0+rayw/W2oSF+cRdPaf6p/YsN242+ek9Zgdx44Mo6cjhY+JjApB93jbIuOAveeTB/+iPqMQPXs1W7ucYTyHC+WphaC9uZ/+w5D37dbyEUI3Pj6MHm8JYxVMyl2nre7fMui9GZoy6AmZJBjFg2Znw3wdx46vTnzCNyZIU854/0/A9DZswJPzYgbv1C5L+X6I3ASomTibVyc6fq4KdYVyTXd78T6b3B1asqLh/S7lXaFNV52/gk9hfXBxDwtp9t0ZpvI/kmzrI27w0p87OaU59mFmSQT8I3rsBPzZZtUVWSsc4hipXla41YNzaTGXgOgn5QhTMpIjjeAktT0VKgO46m/GI9hg/BNZZAaVBrgcA9wCMsuuCN9z7c+1ftfRH+/YEciQIWhXQaSXoxyXYKL+uKK2pEL34QWvJg9JhHQhWYt4x3W2JZMY+ziP7CcJorxoawxBFdz853X63fe4UHQ6RqWZH0YYw/kuTYIavqIIXjFxx26psP75PaG9Kjdil+00AwMgiHQF6LHbOs0gcJT/3K9VTQdT3kgc9Sj1Xnpoz246ohD7PCYFZAWzdPBOypJkl7yDiNBPIe9EeuMEZ8LOlVAzRfD2GsRKW6r4jM2bI4JmvCprdf7NghTJ8xQxr1hGhh7wQEBXs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(1800799009)(186009)(451199024)(71200400001)(6486002)(6506007)(110136005)(86362001)(85182001)(38100700002)(38070700005)(36756003)(122000001)(2616005)(26005)(6512007)(478600001)(5660300002)(83380400001)(316002)(8676002)(41300700001)(4326008)(8936002)(64756008)(76116006)(2906002)(66476007)(66946007)(54906003)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUxvK0RPT1cwRmNQSVRyMDNPSUhrTGtPTkpjRVE0eVNWZlhQbDhYb05oQVZ6?=
 =?utf-8?B?cmd3Qm0vdWdNUUw0WnhoZWVrQlVEVEZrL290dERGUGdPS3JydlBZNDFjUDNG?=
 =?utf-8?B?NWxOZkV6V0EveVZkdGtXeHFnVDRrVzJkS3BWMTdwVFB5YU5Sdys5NFQxWHcy?=
 =?utf-8?B?UlBseGI3YWdPZUlTYm1pcTRhVzM1Y1ZBeDI3d1NnemxNNnlEQUY0ZWV4ZWF1?=
 =?utf-8?B?RnBYck5wNTROZ3hVQ0l0NWpZa2xianhydG9EUWRCNnZRRlZDNTNpVGZUWFRy?=
 =?utf-8?B?ZjhZWVMxVHN4bzVYWVVTT0ZwSHQ2Ri9HQmhjbVF0V0RRbURpU3BWaDhOVWZV?=
 =?utf-8?B?dkxTQTBtNlVMc2pzeUtEYnFoUG9QVHdNUkxxdmxXNWJza1hNUjRiaXk4RkZT?=
 =?utf-8?B?S0pCODl3bEpIZ2V1LytYMngvMFczVStDd0c2Z01JVXNGcjk5VGxSU1VLUENs?=
 =?utf-8?B?T1cwSUlaMjc3SHZGbDBHVzZ5aTVucnljSjEvcmIvak5Hc3ViR0xRLzUzQnJV?=
 =?utf-8?B?TGZFNENuU1RTWUZ5RnM2bkUzcSs0SndjRFBCbHJkNmxQUzBMVWE2TThHNTFs?=
 =?utf-8?B?QVJ5dVpEd3pTcEtFOGVCcmlzL2ZHS2p0aUIvdnRJTkNPRTlYMVJsY2dST2Rl?=
 =?utf-8?B?eC8xTkpwOFEyRWl5VzJBWlZWV3B0UjU5VExpdFd6eG5CMDRCYmdQdFQxTmh4?=
 =?utf-8?B?QmZzTTBuVWxmSEN4bVFLUGRjRWtUN3RrUCs1aUVMZWplaStFOG9iQlFTditl?=
 =?utf-8?B?ejRlUy84ZHUwUjZHWjRWalB3ZEhVNktBUURVdGpLOUZ3WU42aEo3V0djSE5w?=
 =?utf-8?B?czJMcGI2cjFrL2N5eGlyMFlvTjRpeWlwejlxZGZmenVXRFBpd3RyTTVOTCt0?=
 =?utf-8?B?ZDh6QWtJK2JscGZpYXFmOElJbHR1UHB0cnNRUHlRcUhVMVM1KzFMUXZQMEhu?=
 =?utf-8?B?K3huOXFCWHRPbUpHUTg1SWNYQWJmMlgycThRUmJUVjRTTFVXcWF1L3BrelBw?=
 =?utf-8?B?Q3FXMHlKdXY5MjRFNGw0bjhFQnpEUmJFcm9wdmJrd21MYklGWEx6dlN5eXlm?=
 =?utf-8?B?N2MzbDVneDRvN254NmtPdktIZWNUTVBtRXBIeDdkRXlrNWoyVnRDVko1bEov?=
 =?utf-8?B?UjBqYzMrUHk0SnZTVW1IcW5SUXNkMFpOZlZLUVI4Qis5UWh1STN3Y0lTQ3U5?=
 =?utf-8?B?NDlreE90ek5XSDUrSGh2OWRqWDg1TlpaMmVaNFRqelppbzNkby9TeklTZ05S?=
 =?utf-8?B?cFlkdTdRdHN3VHJuMTlzNzFwSzE3V2Z3Qmc4cXo0MEQyVEpybnViMVRQeG4x?=
 =?utf-8?B?dUMrT01NYThZRzN0M2hqOEZ0eG1pRVkrbWhwWDNjb2M0VHhLeFdrVEtBMmo2?=
 =?utf-8?B?N2tjUjdmN3h2K1RzclhvOThpMEFPUkltKzVabzB5aTA4aVdwTmNGb0Jockxk?=
 =?utf-8?B?V0thdkJLWVl5WGpwek43TytORTcxWlpBZWVwdUVUd25RQUE4dlRUMThZNVdi?=
 =?utf-8?B?ZHJGUHdZZjNQMVFsNUU1c3lMUGs4UTE0Lyt0b0MvTkV2QUtBMXBhNXEwM3Z4?=
 =?utf-8?B?YktQMDlaYXUreGFyOXZ3UG00RWc4aWtqaURzaEFMVitLdmxKTVNFQVJXUHY2?=
 =?utf-8?B?cDlndFdGVkI2TWhlMy91OXYwUHZFQUlRUXZaWkFMK3BKTDRXQ2RqRVFVeHZ0?=
 =?utf-8?B?dmt3ZFdZUTdQNWlQRXJCOXpzVTQ2RFNnd0Q3VHVmTHRFcUpoSFNHekc1ajNp?=
 =?utf-8?B?dnRDSmN1ZlVJRU1pUXBBRGgzb09xU2NiMG9RSnRmeTlUeHlzL3MzWGl4eFg4?=
 =?utf-8?B?dkFwWDMzMXNDc2d5SURjWjhDRmdONGRkQ1hnc3phZnIrSFZxenpkMVNVNEdX?=
 =?utf-8?B?VmZYb3dhZTZ2MmpKL2JMd3pzZjA2aGg5elFuNHRCQk1LKzl2dnVJQi90VjN3?=
 =?utf-8?B?ZDZBMVd3d204YmlKZlBtZ1lQTzgrdlhDb3dhNDBpY3NjOGl1QmYyS2lQZVox?=
 =?utf-8?B?L2lMamhFcGs0SXlBakxlV29PMzN5dFNXNzJiQWJtTHBsWXNlcEpWRys1alVt?=
 =?utf-8?B?ZVdVVTJubTFJR04yL2lra2pKQ2dhVU5kcWJPcVd6RVdJQVA3ZEl3QjFhTjI5?=
 =?utf-8?Q?rxripNaodiUUiHGJKGgt3QXUz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B137016491D05449AEF709ABC08B728B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdaf0e8-1e45-4767-86c1-08dbb370bac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 09:14:55.3730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JTytwlEm3BwAtgDckD2rynzojsVUVBofciTF6+EGDEN80SHWwO9E8XRP4kAkum38Hy4tp5CzrW+mX2hzbBKWDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5465
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBUaHUsIDIwMjMtMDktMDcgYXQgMTc6MTQgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gMS4gSW5zdGVhZCBvZiBtdWx0aXBseWluZyAyIHZhcmlhYmxlIG9mIGRp
ZmZlcmVudCB0eXBlcy4gQ2hhbmdlIHRvDQo+IGFzc2lnbiBhIHZhbHVlIG9mIG9uZSB2YXJpYWJs
ZSBhbmQgdGhlbiBtdWx0aXBseSB0aGUgb3RoZXIgdmFyaWFibGUuDQo+IA0KPiAyLiBBZGQgYSBp
bnQgdmFyaWFibGUgZm9yIG11bHRpcGxpZXIgY2FsY3VsYXRpb24gaW5zdGVhZCBvZg0KPiBjYWxj
dWxhdGluZw0KPiBkaWZmZXJlbnQgdHlwZXMgbXVsdGlwbGllciB3aXRoIGRtYV9hZGRyX3QgdmFy
aWFibGUgZGlyZWN0bHkuDQoNCkFwcGxpZWQuIFRoYW5rcy4NCg0KUmVnYXJkcywNCkNLDQoNCj4g
DQo+IEZpeGVzOiAxYTY0YTdhZmY4ZGEgKCJkcm0vbWVkaWF0ZWs6IEZpeCBjdXJzb3IgcGxhbmUg
bm8gdXBkYXRlIikNCj4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5A
bWVkaWF0ZWsuY29tPg0KPiBSZXZpZXdlZC1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0
QGJheWxpYnJlLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4g
Q2hhbmdlIGluIHY1Og0KPiBBZGQgJ2NvdmVyaXR5IGlzc3VlJyBpbiB0aXRsZSBhbmQgY29kZSBj
b21tZW50cy4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0u
YyAgIHwgIDkgKysrKystDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFu
ZS5jIHwgMzkgKysrKysrKysrKysrKysrKysrLS0NCj4gLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAzOCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2dlbS5jDQo+IGluZGV4IDlmMzY0ZGY1MjQ3OC4uZjY2MzJhMGZl
NTA5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0u
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0KPiBAQCAt
MTIxLDcgKzEyMSwxNCBAQCBpbnQgbXRrX2RybV9nZW1fZHVtYl9jcmVhdGUoc3RydWN0IGRybV9m
aWxlDQo+ICpmaWxlX3ByaXYsIHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsDQo+ICAJaW50IHJldDsN
Cj4gIA0KPiAgCWFyZ3MtPnBpdGNoID0gRElWX1JPVU5EX1VQKGFyZ3MtPndpZHRoICogYXJncy0+
YnBwLCA4KTsNCj4gLQlhcmdzLT5zaXplID0gYXJncy0+cGl0Y2ggKiBhcmdzLT5oZWlnaHQ7DQo+
ICsNCj4gKwkvKg0KPiArCSAqIE11bHRpcGx5IDIgdmFyaWFibGVzIG9mIGRpZmZlcmVudCB0eXBl
cywNCj4gKwkgKiBmb3IgZXhhbXBsZTogYXJncy0+c2l6ZSA9IGFyZ3MtPnNwYWNpbmcgKiBhcmdz
LT5oZWlnaHQ7DQo+ICsJICogbWF5IGNhdXNlIGNvdmVyaXR5IGlzc3VlIHdpdGggdW5pbnRlbnRp
b25hbCBvdmVyZmxvdy4NCj4gKwkgKi8NCj4gKwlhcmdzLT5zaXplID0gYXJncy0+cGl0Y2g7DQo+
ICsJYXJncy0+c2l6ZSAqPSBhcmdzLT5oZWlnaHQ7DQo+ICANCj4gIAltdGtfZ2VtID0gbXRrX2Ry
bV9nZW1fY3JlYXRlKGRldiwgYXJncy0+c2l6ZSwgZmFsc2UpOw0KPiAgCWlmIChJU19FUlIobXRr
X2dlbSkpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9w
bGFuZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiBp
bmRleCBkYjJmNzBhZTA2MGQuLjVhY2IwM2I3YzZmZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IEBAIC0xNDEsNiArMTQxLDcgQEAgc3RhdGljIHZv
aWQgbXRrX3BsYW5lX3VwZGF0ZV9uZXdfc3RhdGUoc3RydWN0DQo+IGRybV9wbGFuZV9zdGF0ZSAq
bmV3X3N0YXRlLA0KPiAgCWRtYV9hZGRyX3QgYWRkcjsNCj4gIAlkbWFfYWRkcl90IGhkcl9hZGRy
ID0gMDsNCj4gIAl1bnNpZ25lZCBpbnQgaGRyX3BpdGNoID0gMDsNCj4gKwlpbnQgb2Zmc2V0Ow0K
PiAgDQo+ICAJZ2VtID0gZmItPm9ialswXTsNCj4gIAltdGtfZ2VtID0gdG9fbXRrX2dlbV9vYmoo
Z2VtKTsNCj4gQEAgLTE1MCw4ICsxNTEsMTUgQEAgc3RhdGljIHZvaWQgbXRrX3BsYW5lX3VwZGF0
ZV9uZXdfc3RhdGUoc3RydWN0DQo+IGRybV9wbGFuZV9zdGF0ZSAqbmV3X3N0YXRlLA0KPiAgCW1v
ZGlmaWVyID0gZmItPm1vZGlmaWVyOw0KPiAgDQo+ICAJaWYgKG1vZGlmaWVyID09IERSTV9GT1JN
QVRfTU9EX0xJTkVBUikgew0KPiAtCQlhZGRyICs9IChuZXdfc3RhdGUtPnNyYy54MSA+PiAxNikg
KiBmYi0+Zm9ybWF0LT5jcHBbMF07DQo+IC0JCWFkZHIgKz0gKG5ld19zdGF0ZS0+c3JjLnkxID4+
IDE2KSAqIHBpdGNoOw0KPiArCQkvKg0KPiArCQkgKiBVc2luZyBkbWFfYWRkcl90IHZhcmlhYmxl
IHRvIGNhbGN1bGF0ZSB3aXRoDQo+IG11bHRpcGxpZXIgb2YgZGlmZmVyZW50IHR5cGVzLA0KPiAr
CQkgKiBmb3IgZXhhbXBsZTogYWRkciArPSAobmV3X3N0YXRlLT5zcmMueDEgPj4gMTYpICogZmIt
DQo+ID5mb3JtYXQtPmNwcFswXTsNCj4gKwkJICogbWF5IGNhdXNlIGNvdmVyaXR5IGlzc3VlIHdp
dGggdW5pbnRlbnRpb25hbA0KPiBvdmVyZmxvdy4NCj4gKwkJICovDQo+ICsJCW9mZnNldCA9IChu
ZXdfc3RhdGUtPnNyYy54MSA+PiAxNikgKiBmYi0+Zm9ybWF0LQ0KPiA+Y3BwWzBdOw0KPiArCQlh
ZGRyICs9IG9mZnNldDsNCj4gKwkJb2Zmc2V0ID0gKG5ld19zdGF0ZS0+c3JjLnkxID4+IDE2KSAq
IHBpdGNoOw0KPiArCQlhZGRyICs9IG9mZnNldDsNCj4gIAl9IGVsc2Ugew0KPiAgCQlpbnQgd2lk
dGhfaW5fYmxvY2tzID0gQUxJR04oZmItPndpZHRoLA0KPiBBRkJDX0RBVEFfQkxPQ0tfV0lEVEgp
DQo+ICAJCQkJICAgICAgLyBBRkJDX0RBVEFfQkxPQ0tfV0lEVEg7DQo+IEBAIC0xNTksMjEgKzE2
NywzNCBAQCBzdGF0aWMgdm9pZCBtdGtfcGxhbmVfdXBkYXRlX25ld19zdGF0ZShzdHJ1Y3QNCj4g
ZHJtX3BsYW5lX3N0YXRlICpuZXdfc3RhdGUsDQo+ICAJCQkJICAgICAgIC8gQUZCQ19EQVRBX0JM
T0NLX0hFSUdIVDsNCj4gIAkJaW50IHhfb2Zmc2V0X2luX2Jsb2NrcyA9IChuZXdfc3RhdGUtPnNy
Yy54MSA+PiAxNikgLw0KPiBBRkJDX0RBVEFfQkxPQ0tfV0lEVEg7DQo+ICAJCWludCB5X29mZnNl
dF9pbl9ibG9ja3MgPSAobmV3X3N0YXRlLT5zcmMueTEgPj4gMTYpIC8NCj4gQUZCQ19EQVRBX0JM
T0NLX0hFSUdIVDsNCj4gLQkJaW50IGhkcl9zaXplOw0KPiArCQlpbnQgaGRyX3NpemUsIGhkcl9v
ZmZzZXQ7DQo+ICANCj4gIAkJaGRyX3BpdGNoID0gd2lkdGhfaW5fYmxvY2tzICogQUZCQ19IRUFE
RVJfQkxPQ0tfU0laRTsNCj4gIAkJcGl0Y2ggPSB3aWR0aF9pbl9ibG9ja3MgKiBBRkJDX0RBVEFf
QkxPQ0tfV0lEVEggKg0KPiAgCQkJQUZCQ19EQVRBX0JMT0NLX0hFSUdIVCAqIGZiLT5mb3JtYXQt
PmNwcFswXTsNCj4gIA0KPiAgCQloZHJfc2l6ZSA9IEFMSUdOKGhkcl9waXRjaCAqIGhlaWdodF9p
bl9ibG9ja3MsDQo+IEFGQkNfSEVBREVSX0FMSUdOTUVOVCk7DQo+ICsJCWhkcl9vZmZzZXQgPSBo
ZHJfcGl0Y2ggKiB5X29mZnNldF9pbl9ibG9ja3MgKw0KPiArCQkJQUZCQ19IRUFERVJfQkxPQ0tf
U0laRSAqIHhfb2Zmc2V0X2luX2Jsb2NrczsNCj4gKw0KPiArCQkvKg0KPiArCQkgKiBVc2luZyBk
bWFfYWRkcl90IHZhcmlhYmxlIHRvIGNhbGN1bGF0ZSB3aXRoDQo+IG11bHRpcGxpZXIgb2YgZGlm
ZmVyZW50IHR5cGVzLA0KPiArCQkgKiBmb3IgZXhhbXBsZTogYWRkciArPSBoZHJfcGl0Y2ggKiB5
X29mZnNldF9pbl9ibG9ja3M7DQo+ICsJCSAqIG1heSBjYXVzZSBjb3Zlcml0eSBpc3N1ZSB3aXRo
IHVuaW50ZW50aW9uYWwNCj4gb3ZlcmZsb3cuDQo+ICsJCSAqLw0KPiArCQloZHJfYWRkciA9IGFk
ZHIgKyBoZHJfb2Zmc2V0Ow0KPiAgDQo+IC0JCWhkcl9hZGRyID0gYWRkciArIGhkcl9waXRjaCAq
IHlfb2Zmc2V0X2luX2Jsb2NrcyArDQo+IC0JCQkgICBBRkJDX0hFQURFUl9CTE9DS19TSVpFICog
eF9vZmZzZXRfaW5fYmxvY2tzOw0KPiAgCQkvKiBUaGUgZGF0YSBwbGFuZSBpcyBvZmZzZXQgYnkg
MSBhZGRpdGlvbmFsIGJsb2NrLiAqLw0KPiAtCQlhZGRyID0gYWRkciArIGhkcl9zaXplICsNCj4g
LQkJICAgICAgIHBpdGNoICogeV9vZmZzZXRfaW5fYmxvY2tzICsNCj4gLQkJICAgICAgIEFGQkNf
REFUQV9CTE9DS19XSURUSCAqIEFGQkNfREFUQV9CTE9DS19IRUlHSFQgKg0KPiAtCQkgICAgICAg
ZmItPmZvcm1hdC0+Y3BwWzBdICogKHhfb2Zmc2V0X2luX2Jsb2NrcyArIDEpOw0KPiArCQlvZmZz
ZXQgPSBwaXRjaCAqIHlfb2Zmc2V0X2luX2Jsb2NrcyArDQo+ICsJCQkgQUZCQ19EQVRBX0JMT0NL
X1dJRFRIICogQUZCQ19EQVRBX0JMT0NLX0hFSUdIVA0KPiAqDQo+ICsJCQkgZmItPmZvcm1hdC0+
Y3BwWzBdICogKHhfb2Zmc2V0X2luX2Jsb2NrcyArIDEpOw0KPiArDQo+ICsJCS8qDQo+ICsJCSAq
IFVzaW5nIGRtYV9hZGRyX3QgdmFyaWFibGUgdG8gY2FsY3VsYXRlIHdpdGgNCj4gbXVsdGlwbGll
ciBvZiBkaWZmZXJlbnQgdHlwZXMsDQo+ICsJCSAqIGZvciBleGFtcGxlOiBhZGRyICs9IHBpdGNo
ICogeV9vZmZzZXRfaW5fYmxvY2tzOw0KPiArCQkgKiBtYXkgY2F1c2UgY292ZXJpdHkgaXNzdWUg
d2l0aCB1bmludGVudGlvbmFsDQo+IG92ZXJmbG93Lg0KPiArCQkgKi8NCj4gKwkJYWRkciA9IGFk
ZHIgKyBoZHJfc2l6ZSArIG9mZnNldDsNCj4gIAl9DQo+ICANCj4gIAltdGtfcGxhbmVfc3RhdGUt
PnBlbmRpbmcuZW5hYmxlID0gdHJ1ZTsNCg==
