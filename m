Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188AB784E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 03:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjHWBea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 21:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHWBe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:34:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B4E45;
        Tue, 22 Aug 2023 18:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMjtDSqPunjreLIdcjWyvwnwMD9B0ka6y/Eyr8yo1i82UM39KizVOCn8RGsVzNvkBV5uKcoKPZUt2lPtUI3ujKfNum88eR8RVuwUX5F8QeTs+mlvGogZQWbc3V3VQDVYrJfwY5SCgGj9fmdEXJa3wyDeoZNbX9ENVwL5c3DcwEeZxU6t/DRXYQ4yVe5UW02EcBHqJyqSLcxuWhEWRR9u2YN9d0m2wxG+lwWAmaOD3Zbs+Z5Rj6XNCBOzsbf1kIRvCuq1ftG6iJoOkhdiSo5c89Ylb9aJNux9MLGcR64rxunPtGdnGxMFFhR/bcFW6Y17BzNO5yGDfQDgnv7ydgRsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/Um3/nQT+8qSxy0Tkr8GF5XbzP0GPtDNqw05pMKmyo=;
 b=mDsx1Qmc/ZTQpc6thOJfZwPE9X4gDGI3YNBBAyRy9TBmFNES7PiqiYOslbqrl/EzfM52OCPN38TXwobcLD0dT3MuHL3j+qytQGy5JNRCYzx5kSybEFd6a5+mSMSRZaEtiA9EmAP0Ijkpao+ZHb/xA1L0Q8FQNkYjzRplEHKMrfh1cvBr9lBcJTA7L213LwomyEUWOTuouTxYcW3AVW4NQz61Lx4Xf5P7j4rJCnxllThdWmHwJKESBhXaNvrD5qNjOWcJvUVoQAMvT3Ukiw3W+Z7WdwnSeAF4IF4PMVJA/oljJMx7p6Sgt5ZNUbILCjc706g7TulYdv5YRiLZoSzAnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/Um3/nQT+8qSxy0Tkr8GF5XbzP0GPtDNqw05pMKmyo=;
 b=FFI/K/y6V31MikOUeG4qb2EqrWG8BAfz6S210KXHoWBNwe5udG/1C55WTGBYhEfAXU05uGmkhIeSQRt/qYaH04DXwTTyJzmD2ae+dzRZZLNvH1Q5i3ZPLScmTcGFl5nxioBrwiM0uA18DbFyJhtpAolzCL2RLOc5sjP6J7fIRvA=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PA4PR04MB9664.eurprd04.prod.outlook.com (2603:10a6:102:262::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 01:34:24 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%4]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 01:34:23 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: amphion: handle firmware debug message
Thread-Topic: [EXT] Re: [PATCH] media: amphion: handle firmware debug message
Thread-Index: AQHZ1LzV5jRtb6Fhy0+zH53Q9869m6/2udWAgABfusA=
Date:   Wed, 23 Aug 2023 01:34:22 +0000
Message-ID: <AM6PR04MB6341A4AA8D9FA47C250EDE05E71CA@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230822055207.31575-1-ming.qian@nxp.com>
 <7106092378907b360b75f5ffc1c5ecdeeba2d5b4.camel@ndufresne.ca>
In-Reply-To: <7106092378907b360b75f5ffc1c5ecdeeba2d5b4.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|PA4PR04MB9664:EE_
x-ms-office365-filtering-correlation-id: 6c704807-d40b-4a40-66fb-08dba3791445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z+J9zS1hmv+95KdUgtWFnJt7VHxtaRK3MNRzTxZF3HcLrQq/oN5CPgtY6uv43txBqWM0qz2xmI68OKf15nrIxJreBJIWIp8UXuuKy6TGtbyqhYZmScLxtmTN2YW+NJjOJ+HwMIMe7fOO2FfjxZKEJgC+GnB466H8ENh8Tz6yId+isgGKkL3mXec4/4A3biJ23+eAxGe1UHM/0Q7BH7uzb6SdhBBG+PL6VJUW7Sh8vUbS4NCARH/xp6wwNPvKiw10vDPdu5UmMjL4P9d5vQFp1rKxG+IrWd7TRELfLySsKSWeRUCdbX54zjWp0kMQWAQ1paJRTmQMlBkf9F0v0PwMAIAuY9qMiai3bMVqHdghBJuJS2DJvnqqSHFXJD5dylcmmrVqCcPAiWQaH1Fi9M65Cd/qd7fulZQiBniOybREgfMda3DeWcMuMI6+RduvM9FfTgy+Tb47emqnm+MWc4NrVutq5alrEDxRqDnZbViyHJQqey3q3xwTcOXNPwobC+7/FuBvAJ5UrqJbl3FZ1muYEnAkskTE4czzzWfpH28rUAwx21AIyOgh7IVv0r7CBnXnbyrPuwdQGPX4+4ne3mTuNO4iRu3gLJQv6FfZFKdZ1SAuvAjgUDhkC5RoM38G/mnK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(186009)(1800799009)(451199024)(8676002)(66574015)(52536014)(8936002)(4326008)(44832011)(5660300002)(38100700002)(86362001)(38070700005)(122000001)(9686003)(71200400001)(26005)(7696005)(6506007)(41300700001)(83380400001)(478600001)(55016003)(64756008)(15650500001)(66556008)(66476007)(66946007)(33656002)(110136005)(76116006)(316002)(54906003)(2906002)(66446008)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm1JYy9PQTFHYXdCU1pWdVNqTjdMV3kxREpIUXpmYkVtL1pIV0hTcW1uK0Jv?=
 =?utf-8?B?K1E3WTBTSVBCVE5IR3o3NGFGeEJZLzAwU3JTczNZOU5oK3Y3WmMzUm94QmtZ?=
 =?utf-8?B?djdPamp2cWkySldCRWVIY2thbnN1Uk5oL0lMSGdxcEJVZ2JTZmU2eWJwVkFp?=
 =?utf-8?B?WVFIT2tNN3NrVDl0OG56WWpHSjJCWFdURG8wRnpwblFuWmZIdldwbCttR3A1?=
 =?utf-8?B?YW5pQVRzd0UzQ0swR3RhckZocjRlNzhONXJlMTBOVy8yS1BIckVFQjJnV1V0?=
 =?utf-8?B?b2gxSDNqVW02Q2t2Ulk4SkwyOU1mdzhka3pDQXJqRnBLYmtLWGdZVVhQdkpq?=
 =?utf-8?B?ZnRTUDRBeTZIS1lWTk5QSjJ1Q2JQdzdvR1BqUERzdzliTE5tbUhld0s0MVJN?=
 =?utf-8?B?U2F6REFIblhhck5aTldsWDdXOWxxMzJsK3p2UlhLSmMzN3dtNE9rUXkzWmxx?=
 =?utf-8?B?T3MrZHE0Rlh6OTBJeUgvemVxbjFlNjQ2VElCajRaSHdLaGVJZkNITm1aTW5W?=
 =?utf-8?B?TW43dkF3aTU4eFhuQW5nYTJSYTdQUmE0VHFyTjk3ajJOTFlYK2lLd28wbG5Q?=
 =?utf-8?B?WHZONDZSYjdLTnF5QnA4cnpRbFIzUkw1eGo5MEVIclpncGYwYkVBZkNkcE1E?=
 =?utf-8?B?R0hxaUlkYngzZElHd2Q5T0NYWmErOTQydzNzMytsdGtrVXQ2OVZYTEZjV0xo?=
 =?utf-8?B?T0doc2J3bHhodUw5dHFvRzAwRTVPR1FHOXdjNG8vbUl4aElwRWw5aWx5Vzl1?=
 =?utf-8?B?bkZ5d0JlSy9GdzVFQUU1VjkvVjNYN3AyaWFHQ1VBWlFCbURkcjdMS3c0WW1h?=
 =?utf-8?B?b2ZFWEJZNHhzQks2aWRiVTh1VnJ5OTEwOGZYQkcvb0ZjQWcrNnNyNE9VVDM4?=
 =?utf-8?B?SkVkblBJUzBQNkNZTytvTmRJa2t2WnNRRjJob0F5M1VlOVJDRGl0UGM0dnBv?=
 =?utf-8?B?MHZPSnZ3TlRtcGFwTFAvajRwOTdNNTZYekg2SkExOE51WGVYZ2R0dE1talhq?=
 =?utf-8?B?UERNS2Z1SXl3cnVTZVZTc1Z0MWdnelNVVDBXWnUrZVI5eVhQT1MySDNGclJW?=
 =?utf-8?B?cTJqUTFIc0dKRHhFdHRieEFlWkZpam9Na1pnaVJ6N2ZxbURoWTMxeFhJK1Rl?=
 =?utf-8?B?TU5qdzRVMkJVb2dJVjVWaWM5QkNyVk8zYnZRNE9XbkdpQzcvRWRoTlJ6WE95?=
 =?utf-8?B?K2hVUW9tWDFlL2tkek9WLzNETm5jcDJNQzBDT3NIaTNCQWhUQlB3ektYWjZH?=
 =?utf-8?B?TTFuNG9nV2FRaU9ISStXbW5Pc1JqSEtKMXF2TXh4aGEwOVdMQzVKNUgvZU5N?=
 =?utf-8?B?a1gwbmt4R0xSeTVMN1M2TE83bmNmSU9JTjFkdFRYemZwd0FBRWFpYnJ6RFhx?=
 =?utf-8?B?ZEVCVkpvRDlaQVVvWGdHcGtmeDJwTWNZUmpXdTM0UDFqa1Q2RkI5bUxVbENU?=
 =?utf-8?B?M0FvM1NKZzBOZElpbjVWMTF1c0UzV2hjRmVxazZGcHNyaVRWRzNwRHl5UENE?=
 =?utf-8?B?UTFQSE8wM0phWmFndU1vbVd3MFZOVzNkdkNYZFBvQnhNUlRqcWk2dloveVo4?=
 =?utf-8?B?Zzh2Q0VKUDNaL05GTFBzLzd1bG5RRER6ZDNNQ1kwYnFad0htbEc0cXkxckgy?=
 =?utf-8?B?UlQyalZySm1DN2dvWTZTaEo1QlYrb0xaV3V4YkVLNU5uSm1ZVHRocXJyM0hs?=
 =?utf-8?B?cWV4eWQ5RGRnbzM3YXlmSU8xTkdOTHNWanRsc042VE9wYjFPWEk3UUc3RlA5?=
 =?utf-8?B?QXV4N1VlNDcrL3o1RnNKUDNrdDVySkZEaGtmSCtDdzU3WHVZaTREcG5XbjNY?=
 =?utf-8?B?cjZYUFdhZXg1QWNkWXBwVEtZZVFja0puQk84a0xPeGRBY2Fzb25qVEhCUEhJ?=
 =?utf-8?B?ZHp4OTFBWjlMRE85YmVyM1RzN21sVU8xaDZ2RU94Wm5CUGV4L2kxZ2tOc2lQ?=
 =?utf-8?B?U0dhaUw2SCtKOEpZbnRXbks0VWhkMDRML3pHNVhTbUJaS2ZDdXExS1UvVmpQ?=
 =?utf-8?B?V3d0eXIrQ3BhVFg4a0JqMkdOYTVZdm1NL25LVnhXZFBiTkZGRGhQWm5sV2VH?=
 =?utf-8?B?VDRVZzJFWFpIK3FUNWxEUk9yeExSbUJ4Ymd5T0pGL1Y4TXo5a3N1Sm1YdkY1?=
 =?utf-8?Q?IKrk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c704807-d40b-4a40-66fb-08dba3791445
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 01:34:22.9033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZ4lQfrXpzhB8SGmC4pZf5aV9eQO4ip8ljLzYXbGxErFgAYgP27/+ZqVLKq5g6TMRe6MKnQ8J8YmJRfYcWFq6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkhpLA0KPg0KPkxlIG1hcmRpIDIyIGFvw7t0IDIwMjMgw6AgMTM6NTIgKzA4MDAsIE1pbmcgUWlh
biBhIMOpY3JpdCA6DQo+PiBkZWNvZGVyIGZpcm13YXJlIG1heSBub3RpZnkgaG9zdCBzb21lIGRl
YnVnIG1lc3NhZ2UsIGl0IGNhbiBoZWxwDQo+PiBhbmFseXplIHRoZSBzdGF0ZSBvZiB0aGUgZmly
bXdhcmUgaW4gY2FzZSBvZiBlcnJvcg0KPj4NCj4+IEZpeGVzOiA5ZjU5OWYzNTFlODYgKCJtZWRp
YTogYW1waGlvbjogYWRkIHZwdSBjb3JlIGRyaXZlciIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBNaW5n
IFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9hbXBoaW9uL3ZwdV9kZWZzLmggICAgfCAxICsNCj4+ICBkcml2ZXJzL21lZGlhL3BsYXRm
b3JtL2FtcGhpb24vdnB1X2hlbHBlcnMuYyB8IDEgKw0KPj4gZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9hbXBoaW9uL3ZwdV9tYWxvbmUuYyAgfCAxICsNCj4+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L2FtcGhpb24vdnB1X21zZ3MuYyAgICB8IDkgKysrKysrKysrDQo+PiAgNCBmaWxlcyBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vYW1waGlvbi92cHVfZGVmcy5oDQo+PiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1w
aGlvbi92cHVfZGVmcy5oDQo+PiBpbmRleCA2Njc2MzdlZWRiNWQuLjczMjA4NTI2NjhkNiAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfZGVmcy5oDQo+
PiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X2RlZnMuaA0KPj4gQEAg
LTcxLDYgKzcxLDcgQEAgZW51bSB7DQo+PiAgICAgICBWUFVfTVNHX0lEX1RJTUVTVEFNUF9JTkZP
LA0KPj4gICAgICAgVlBVX01TR19JRF9GSVJNV0FSRV9YQ1BULA0KPj4gICAgICAgVlBVX01TR19J
RF9QSUNfU0tJUFBFRCwNCj4+ICsgICAgIFZQVV9NU0dfSURfREJHX01TRywNCj4+ICB9Ow0KPj4N
Cj4+ICBlbnVtIFZQVV9FTkNfTUVNT1JZX1JFU09VUlNFIHsNCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X2hlbHBlcnMuYw0KPj4gYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X2hlbHBlcnMuYw0KPj4gaW5kZXggYWYzYjMzNmU1ZGMz
Li5kMTIzMTBhZjllYmMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2Ft
cGhpb24vdnB1X2hlbHBlcnMuYw0KPj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBo
aW9uL3ZwdV9oZWxwZXJzLmMNCj4+IEBAIC00ODksNiArNDg5LDcgQEAgY29uc3QgY2hhciAqdnB1
X2lkX25hbWUodTMyIGlkKQ0KPj4gICAgICAgY2FzZSBWUFVfTVNHX0lEX1VOU1VQUE9SVEVEOiBy
ZXR1cm4gInVuc3VwcG9ydGVkIjsNCj4+ICAgICAgIGNhc2UgVlBVX01TR19JRF9GSVJNV0FSRV9Y
Q1BUOiByZXR1cm4gImV4Y2VwdGlvbiI7DQo+PiAgICAgICBjYXNlIFZQVV9NU0dfSURfUElDX1NL
SVBQRUQ6IHJldHVybiAic2tpcHBlZCI7DQo+PiArICAgICBjYXNlIFZQVV9NU0dfSURfREJHX01T
RzogcmV0dXJuICJkZWJ1ZyBtc2ciOw0KPj4gICAgICAgfQ0KPj4gICAgICAgcmV0dXJuICI8dW5r
bm93bj4iOw0KPj4gIH0NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2Ft
cGhpb24vdnB1X21hbG9uZS5jDQo+PiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92
cHVfbWFsb25lLmMNCj4+IGluZGV4IGY3NzE2NjE5ODBjMC4uZDM0MjVkZTdiY2NkIDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tYWxvbmUuYw0KPj4g
KysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tYWxvbmUuYw0KPj4gQEAg
LTc0NSw2ICs3NDUsNyBAQCBzdGF0aWMgc3RydWN0IHZwdV9wYWlyIG1hbG9uZV9tc2dzW10gPSB7
DQo+PiAgICAgICB7VlBVX01TR19JRF9VTlNVUFBPUlRFRCwNCj5WSURfQVBJX0VWRU5UX1VOU1VQ
UE9SVEVEX1NUUkVBTX0sDQo+PiAgICAgICB7VlBVX01TR19JRF9GSVJNV0FSRV9YQ1BULCBWSURf
QVBJX0VWRU5UX0ZJUk1XQVJFX1hDUFR9LA0KPj4gICAgICAge1ZQVV9NU0dfSURfUElDX1NLSVBQ
RUQsIFZJRF9BUElfRVZFTlRfUElDX1NLSVBQRUR9LA0KPj4gKyAgICAge1ZQVV9NU0dfSURfREJH
X01TRywgVklEX0FQSV9FVkVOVF9EQkdfTVNHX0RFQ30sDQo+PiAgfTsNCj4+DQo+PiAgc3RhdGlj
IHZvaWQgdnB1X21hbG9uZV9wYWNrX2ZzX2FsbG9jKHN0cnVjdCB2cHVfcnBjX2V2ZW50ICpwa3Qs
IGRpZmYNCj4+IC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tc2dz
LmMNCj4+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tc2dzLmMNCj4+IGlu
ZGV4IGQwZWFkMDUxZjdkMS4uOTk5ZWZlYWViZmQ1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tc2dzLmMNCj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vYW1waGlvbi92cHVfbXNncy5jDQo+PiBAQCAtMTgwLDYgKzE4MCwxNCBAQCBzdGF0
aWMgdm9pZCB2cHVfc2Vzc2lvbl9oYW5kbGVfcGljX3NraXBwZWQoc3RydWN0DQo+dnB1X2luc3Qg
Kmluc3QsIHN0cnVjdCB2cHVfcnBjDQo+PiAgICAgICB2cHVfaW5zdF91bmxvY2soaW5zdCk7DQo+
PiAgfQ0KPj4NCj4+ICtzdGF0aWMgdm9pZCB2cHVfc2Vzc2lvbl9oYW5kbGVfZGJnX21zZyhzdHJ1
Y3QgdnB1X2luc3QgKmluc3QsIHN0cnVjdA0KPj4gK3ZwdV9ycGNfZXZlbnQgKnBrdCkgew0KPj4g
KyAgICAgY2hhciAqc3RyID0gKGNoYXIgKilwa3QtPmRhdGE7DQo+PiArDQo+PiArICAgICBpZiAo
c3RybGVuKHN0cikpDQo+PiArICAgICAgICAgICAgIGRldl9pbmZvKGluc3QtPmRldiwgImluc3Rh
bmNlICVkIGZpcm13YXJlIGRiZyBtc2cgOg0KPj4gKyAlc1xuIiwgaW5zdC0+aWQsIHN0cik7DQo+
DQo+SSdtIGFsd2F5cyBhIGJpdCB3b3JyaWVkIHdoZW4gYSBzdHJpbmcgaXMgYXNzdW1lZCBudWwt
dGVybWluYXRlZCBhbmQgaXQNCj5jb21lcyBmcm9tIGEgdGhpcmQgcGFydHkgc29mdHdhcmUgKGZp
cm13YXJlKS4gUGVyaGFwcyB3ZSBmb3JjZSBpdCB0bw0KPnRlcm1pbmF0ZSBzb21ld2hlcmUgYWxy
ZWFkeSA/IFdpdGggdGhpcyBiZWluZyB2ZXJpZmllZCAob3IgY29ycmVjdGVkKToNCj4NCj5SZXZp
ZXdlZC1ieTogTmljb2xhcyBEdWZyZXNuZSA8bmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEuY29t
Pg0KPg0KDQpIaSBOaWNvbGFzLA0KICAgIHRoYW5rcyBmb3IgeW91ciByZW1pbmRlciwgSSB3aWxs
IGZvcmNlIGl0IHRvIHRlcm1pbmF0ZSBhdCB0aGUgZW5kIG9mIHRoZSBhcnJheSBpbiB2MiBwYXRj
aC4NCk1pbmcNCg0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgc3RydWN0IHZwdV9tc2dfaGFuZGxl
ciBoYW5kbGVyc1tdID0gew0KPj4gICAgICAge1ZQVV9NU0dfSURfU1RBUlRfRE9ORSwgdnB1X3Nl
c3Npb25faGFuZGxlX3N0YXJ0X2RvbmV9LA0KPj4gICAgICAge1ZQVV9NU0dfSURfU1RPUF9ET05F
LCB2cHVfc2Vzc2lvbl9oYW5kbGVfc3RvcF9kb25lfSwgQEAgLQ0KPjE5Niw2DQo+PiArMjA0LDcg
QEAgc3RhdGljIHN0cnVjdCB2cHVfbXNnX2hhbmRsZXIgaGFuZGxlcnNbXSA9IHsNCj4+ICAgICAg
IHtWUFVfTVNHX0lEX1VOU1VQUE9SVEVELCB2cHVfc2Vzc2lvbl9oYW5kbGVfZXJyb3J9LA0KPj4g
ICAgICAge1ZQVV9NU0dfSURfRklSTVdBUkVfWENQVCwgdnB1X3Nlc3Npb25faGFuZGxlX2Zpcm13
YXJlX3hjcHR9LA0KPj4gICAgICAge1ZQVV9NU0dfSURfUElDX1NLSVBQRUQsIHZwdV9zZXNzaW9u
X2hhbmRsZV9waWNfc2tpcHBlZH0sDQo+PiArICAgICB7VlBVX01TR19JRF9EQkdfTVNHLCB2cHVf
c2Vzc2lvbl9oYW5kbGVfZGJnX21zZ30sDQo+PiAgfTsNCj4+DQo+PiAgc3RhdGljIGludCB2cHVf
c2Vzc2lvbl9oYW5kbGVfbXNnKHN0cnVjdCB2cHVfaW5zdCAqaW5zdCwgc3RydWN0DQo+PiB2cHVf
cnBjX2V2ZW50ICptc2cpDQoNCg==
