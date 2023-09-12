Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391A579CACF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjILJAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjILJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:00:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A60310CA;
        Tue, 12 Sep 2023 02:00:16 -0700 (PDT)
X-UUID: c66df716514a11ee8051498923ad61e6-20230912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hs+2uZhjL4ujdojJd+AahTE0J+hKdFkYxtRB41qY/o4=;
        b=lIzj2EbV1l6YtqfSh9Hp88Z070q4Y+Nm9UY5F61CSntZKvAlUezY+TGuJVLleDMPUIKNoBRUI4BrkNCKD2B8StV6qcVwp02o4IAhUWDAR9LVAHUN18cx8bmRR1cemz4B7LU5ysQmHP9J8IkHTUPJr1VZKr1/QCroLMXxXQGHSmA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:b346232c-baa5-4437-b676-c81e15959782,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:ed159aef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c66df716514a11ee8051498923ad61e6-20230912
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1879385404; Tue, 12 Sep 2023 17:00:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Sep 2023 17:00:08 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Sep 2023 17:00:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3yPxN1Ie8f9ZWZVRxDKiqO7USNh7j0AAWbcyVaNt4Yb5PweALe5kpbBGmuLUEhQFMV0yFqiF1xiTXRa7Sw05qZUeO+B7HIxuqOvGgeQxNb9wQ46JAD05OSU17O6zvittyGnazuK26/zu1d1i2jL2s4sfTCR3V2TeJ20FOkxK8eIVhUP+spb0aOM0zVYjb+ezOwRbEcQggo9gxQngInIqk+dxLbUfPYZ+sI9sMLDwEeaSw7Y1Drntp3KHVXcdNI2+l8mEX9/409gFe1R+FCp2r6lKuNWvZr9bApfYvjD0TzdxxaypKOA/lQierMFCy/AUlI+jwACbClgatLK2/QBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs+2uZhjL4ujdojJd+AahTE0J+hKdFkYxtRB41qY/o4=;
 b=dniWvzn3QyrFNXUNVvWhrew4Ql4fWogwHLaLl2IlVOEInXzc7pY8mK6idGpNYs5XPuESADO06+TQMDEfFI9Qm4McagE2ls/OoOGEpHbRGPtd9RkeH6DnL6bqqyhLHAapBReVskYz4o77pX8fUjRRDTeQ5adjGS5impJj8vPBbebEwlGNbsH+XoLcVfkXgRwDRJ/dPkG0xijHQmCj68mcOktn6YbZag06c0Bpt8y8g4oCQ4/NdK6TC9V+N4v7nQuwQyjQuQO33hDPMhL6ZjtXKVCDsV+otHMAJREmYMgZqphEjBjGTYz/7nLVHBuPiP64GBqVHElv9ouu1lS6weulLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs+2uZhjL4ujdojJd+AahTE0J+hKdFkYxtRB41qY/o4=;
 b=hm0KQIzhY8nuuFuGn/CYTJOef2YCtQftfwSQS7VAmaNsaqOhfMvN06Onnfdw0frOSL/oA11E1TmZqCtr9pkB26F1Ug8BOPLmRGOagYo5hMl/Sn19ePb9d9aiEw8Yb9lIb4l9EMLLJLK1F30Iejr96bLZhm/4qgD9HtnD5KD15sA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB5523.apcprd03.prod.outlook.com (2603:1096:820:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 09:00:05 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:00:05 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v4,0/3] Add mt8188 compatiable for DSI cmd packet control
Thread-Topic: [PATCH v4,0/3] Add mt8188 compatiable for DSI cmd packet control
Thread-Index: AQHZ5KihRJlC2TBct02KIAio/N46b7AW5bmA
Date:   Tue, 12 Sep 2023 09:00:05 +0000
Message-ID: <8e10b04be022aa83b36bbfb9cdcae9d14c6594cb.camel@mediatek.com>
References: <20230911120800.17369-1-shuijing.li@mediatek.com>
In-Reply-To: <20230911120800.17369-1-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB5523:EE_
x-ms-office365-filtering-correlation-id: a4cd516b-acb2-4ee6-fa3b-08dbb36ea867
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SpM0ad2hGTOL9PtZKwiqZPZJN+vtCZtqUNAB7EiVPywJjvpMl2IJU1KVMMoxAd3Sp7RQD21SQRuGpeh9PYUTCLhI8G2l7JMg2yQektCA3K+hMXIcr4u5QnnEzxNkXoFGuU8xnG4Ho+bmAyUzTl6YfDiqX5BvngTWvJGGvZSdLEXP0mBK+3t/IHmbwGWaASV9XdD8HqtBKQ4Bq74/19WVpq05lIWNxW0xtc0QxeYZsG7SALkQ81R3eO1R+pyGAoU4VIut6BQH9Mqk5tfjUBr2rKYZHVNXiRJ0FS1L0PiF5uZ8XhzrHXZZsrQm6nCIYEARGoRFCcwjTxG/AuuLkQf6XKfvvhI+XEPWZeGwu5+AzxPDnzcAjl5UKgciNZH8k3BP6Jma8r5EL3d1wQkIA/i/djNjy7vAO4GsgvS1x0HBt60wVboDI2z4cXwfYgha7BQxHmotnaLwfDHEid3eIAApJZpSZJbTc52Z+w5nNyBL09VUBKnRSKkEToAlLXauwWUif9bGZYLzOTTZ1IPDn1zJWLG5VCKC/yrKZz455lf6tnX6cfUqvTBBOHdsDaHCPv3B+3q6YZuw16qFuyPd+TtshBi63IfK9/8UQcDGyW5S4PxE8vzHBItK6U+RYGT/irUNHxq5Y50+BTRHcPoONz+s/HHf86XTFFXGDsdKP8TWyGbkvwipKcLDx/GMG4VM6N1Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(26005)(2616005)(107886003)(5660300002)(8936002)(8676002)(4326008)(6512007)(6486002)(6506007)(66946007)(66476007)(110136005)(66556008)(66446008)(64756008)(76116006)(54906003)(38070700005)(38100700002)(122000001)(478600001)(921005)(71200400001)(316002)(41300700001)(36756003)(86362001)(85182001)(4744005)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0hmR1EwM1gzbWR0T1FFbWx5eG83QTcwRUt5UFI2S3RQODdvTWNTMXMyRGto?=
 =?utf-8?B?ekRDRGVORFpoSFI3L1NzWHJiQXYrZWJBMFUxSXo1VEZrK2J4c1RzZXk5eDE3?=
 =?utf-8?B?Tzdybld4OHZGY1ZiUlA1a1hFZ1ovdDg3K21WWmcyaTRnYzlvNlp2STFjdENj?=
 =?utf-8?B?L0RzeGZCYjE5SThqb0ViUnRGYVJyczN1cHQvNCtzRGhnZFJKT3Z4OEI1aUg2?=
 =?utf-8?B?TjFJYnQ3Y1Z2cXFuK2oyZTQ5N1RxZTNvdmdaeEZTdTdCRUM3ekltK25ibWhi?=
 =?utf-8?B?TjlQNnV0SnJVSDY3T0psZXJDbjM5SndJdTNpRDVnOHg5K1c2eVdCcGM2dXNK?=
 =?utf-8?B?WG9OQml0anJJeXl6VlVoTGp0TnpvT0ZYS0RBVk15Qk5KVlBlclZ5MS9EdG91?=
 =?utf-8?B?MW1jTVdHeWJtdHdhdjJmOGpNS0dkMktIbm9GRGRTS29UclByMys1WXc2K1Jo?=
 =?utf-8?B?VHdDa2owMWZ5ZUdxMTl4akJvK01WeVUvbGVVRnQycXVsQm9qb0lCZUV4bFUx?=
 =?utf-8?B?eXl6ejZuTTZwSklJU1VBcENxN3FRcjdpZVNMQ29NM2NJNytjOTQrdFZWZHRZ?=
 =?utf-8?B?NFh3MCtsNW1xMXdqVi9rVEpLVVVMSWxySHFPOVU1SnRwS2dPUGg5a2VhaWxr?=
 =?utf-8?B?MnBTUVJ1YWFpV25PUGU1OEFUeHZKVDQ5dHRNTEp0c1VicHUwZ3E3cG1VS3py?=
 =?utf-8?B?Uk9uR3MyaWl2U2FOVGtUUUtaTWJibzBubDRvYU5hSHNRR1hlMkRndnB5R0xZ?=
 =?utf-8?B?eVpZbWJYR0tGTG8zWTBubXc2K2pwcFNkYU1HRDVuQjlPeGtLZ2ZEdWo1bVZQ?=
 =?utf-8?B?dVdPV0JTcmN5V01DbSt2bWs5azJHdGZnMXd1Sm03c1UvZFFTN1VjMmI5Ujkv?=
 =?utf-8?B?QVc0Y3R1V3ppUW9jMmhrZGd2YW5aUkpEVGVWZFdQaFdSNjZiMFJ3dERwNEpS?=
 =?utf-8?B?T1hJeVZFbXozR05GT2cyZGt5b2QzeURkY3lwZ1lCVXFqMjFSdC82RitlRVBj?=
 =?utf-8?B?UkVQSnJROGd0M1hob2VYY3FheDNndU5RY0tPV0hRVWVCMjVWOXBYN3NXZVEz?=
 =?utf-8?B?bVdSVk8weUpxVnE2ejZ2RWZ0SzMwc2ZyVEtQeSt1VHRDRGtNWUdQY0NtdUpB?=
 =?utf-8?B?eTV2UmdnNDZabCtIOVlKQkhYeEc1OTFFV1pPdFlhSFBQN2NPY2dEb0RVemFn?=
 =?utf-8?B?TzJySy8wN0k0cyswc1MxclViK1VzeW9yUWV4UVQ1ZmtyQVBSZTBrYzkvVk9C?=
 =?utf-8?B?STdIVUxhcGJiYzJJbHg0L2YzaVVKU2lZazBqdkI3V0ZnWjBJUjJ5V1REMkVs?=
 =?utf-8?B?QVVLaVViT1VHZE5oNGRNamxvbCt3c294UHlHOS9RTTlrTlBuek1DTWRnUjc5?=
 =?utf-8?B?VTYxOVMzUEVjdXFkclE5aWdXVVd0emV4eFRURmc3dVJnaDJpOVpYeHl6ZXZ2?=
 =?utf-8?B?a2trR0M5SjRrZGlWZ044TW94eHRNTE5HZWhNNmVRQzZFYUxQWnFJWkdFaDdy?=
 =?utf-8?B?bVkzMDdKTjBVdFFLdzhwSm1NZ3JnbE5ISW1uTkRuNFQxK1lrQncydWJpWnha?=
 =?utf-8?B?Z1VPL2hoaDd5RStLN0M2QUpnZXQwTHZ5S2QxaDJUVHVUWlNGOGVDR0ErNm8x?=
 =?utf-8?B?dGw0dlZaTHN6aGUyRWc4Tm5JVGZ3ZitZQ05JaVU3bDNJTFkyYU5adWM2ckdT?=
 =?utf-8?B?cGNNWnN5TDMzaEh2eFlTVmRVU01tM3N5TmMrSnNBaXBxZDdaR01rZUh4ZXF4?=
 =?utf-8?B?WVpLWDZtcTUrUHJYekpUZFcrcmt1aytuNWRSVGl6bllFbWg5UGlJNDdQMGdF?=
 =?utf-8?B?YmEyYTU5eWR6QStRa296WmhJOFZ6MkFKNHVPSEtsQTgzZWh2Z2xIS3ZCTDBV?=
 =?utf-8?B?WnI0elllRlVRSHlpd1VSeTArZkJMZVpYQkhNZHpQODVIVzAyWmFqM2tRczY2?=
 =?utf-8?B?b2pXdGxuK3pnQUhhdmRWWFdyTkNIQlJCbDhLekdkWVlWUlRlQjQ5YXhWTm5y?=
 =?utf-8?B?YUcrajIvN2JXczY0RzVpNGw5T1N3SmJOc3lRL3pXblhiaENSRDlaUlBkRnkw?=
 =?utf-8?B?UHBIY1Bhb1llaWVsRklTS2dPZ25neVBWdXk4eFNOM3FCRGYxOGJ3aHlNbThu?=
 =?utf-8?Q?5bu8EhQEt417JS9ahn2wLk3SF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71EAE66FC08CAC479139AE8A0863FA3F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cd516b-acb2-4ee6-fa3b-08dbb36ea867
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 09:00:05.6098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+0wD3JIbV2EHy6cTZLvFQWgKLsmfUNDKfQ1JU9Pr5KlM/B+MPpvW7eC3leJzE3jyhxLh3qZxDOsutnREESLJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5523
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBNb24sIDIwMjMtMDktMTEgYXQgMjA6MDcgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBBZGQgZHQtYmluZGluZyBkb2N1bWVudGF0aW9uIG9mIERTSSBmb3Ig
TWVkaWFUZWsgTVQ4MTg4IFNvQy4NCj4gQmVjYXVzZSBvZiB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVu
IFNPQyBhbmQgRFNJIGNtZCBwYWNrZXQgY29udHJvbCwgZm9yDQo+IE1UODE4OCwgaXQgaXMgbmVj
ZXNzYXJ5IHRvIGluY3JlYXNlIHRoZSBEU0lfQ01EUV9TSVpFIGNvbnRyb2wgd2hlbg0KPiBzZW5k
aW5nIGxvbmcgcGFja2V0cyB0byBpbml0aWFsaXplIHRoZSBwYW5lbC4gT2YgY291cnNlLCB0aGlz
IHdpbGwNCj4gbm90DQo+IGFmZmVjdCB0aGUgc2VuZGluZyBvZiBzaG9ydCBwYWNrZXRzLg0KPiAN
Cj4gQmFzZSBvbiB0aGUgYnJhbmNoIG9mIGxpbnVzL21hc3RlciB2Ni41Lg0KDQpGb3IgdGhpcyBz
ZXJpZXMsIGFwcGxpZWQuIFRoYW5rcy4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IFNodWlqaW5n
IExpICgzKToNCj4gICBkdC1iaW5kaW5nczogZGlzcGxheTogbWVkaWF0ZWs6IGRzaTogQWRkIGNv
bXBhdGlibGUgZm9yIE1lZGlhVGVrDQo+ICAgICBNVDgxODgNCj4gICBkcm0vbWVkaWF0ZWs6IGRz
aTogQWRkIGRzaSBjbWRxX2N0bCB0byBzZW5kIHBhbmVsIGluaXRpYWwgY29kZQ0KPiAgIGRybS9t
ZWRpYXRlazogQWRkIG10ODE4OCBkc2kgY29tcGF0aWJsZSB0byBtdGtfZHNpLmMNCj4gDQo+ICAu
Li4vYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kueWFtbCAgIHwgIDEgKw0K
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgICAgICAgICAgICB8ICAy
ICsrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jICAgICAgICAgICAgICAg
IHwgMTUNCj4gKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlv
bnMoKykNCj4gDQo=
