Return-Path: <linux-kernel+bounces-15207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68E882285B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09870B22C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3C18635;
	Wed,  3 Jan 2024 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="y/yFatKQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0041804E;
	Wed,  3 Jan 2024 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlDcfOGDMVo821yNuIXqhducL8kfwwAmpUoS4l9TdcRZvedWpZ9/KuroUQ6sASKspxEOMSgmPY+U6kxLMZB4iwJ5D5Pg6N8fZodM3Swm5Be7CJnVixSrboepHUmqcsJA4gBefKDHmH2+97Rw/tEoimpm0JNNTzYTkIkKSBxsTMLHtF2Fdrh2I1Fjlz7Uno/zz4Kp0xuDGh/4857pOqSEyxmLNZghg2VryNuTgj9r7cF9hsXyet0ak6kRuYeM2G0K9AX9TUUw6UsT8oX4kF1O1V6eKR5yjjyDcbVi842CR+mzqNeXlRZFVb6JQnXHUVBUzJeNehkujyCSnJVwBUQmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7XY6q1hHzURDCSJAsn272m2uNlivDy635/jnq949R4=;
 b=jjXsD5k4PVdJRbJTeyZ13Jtb/Tr1XMhbGz6C+F6JamOvKH6QHnWNpMmtiJVyR3i2rvC2/Uarop8SU6SteEqqc86Jcz3lIXC8J7xLhfDrOHB/LPhVlQvlPU6lL3tPLGHwnR2cpuDVULZHhi2+sk8A5Nlin239Lao5sh1xm1NTlNSWo8G1mjApe5eW+W/Fcr6fgR7L10EI8WMwHW3a6U7oM4aZuQqBcBEsZ+aKsewrg23R1xf4tYMjYGp/MU3qmIg5Mc8zFO0PhA63DpLUeeYK6Gb1YIGvZOvb4hyw0fk5O1U7JDK/0LmM6SsfaCOQ2tclXJKgbZNqW1RSi4oU8eEMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7XY6q1hHzURDCSJAsn272m2uNlivDy635/jnq949R4=;
 b=y/yFatKQEjRUiKUCfMpJ32w6fKMxdCTivrLppKwZx7X2LJcKTWp+ZVYaJbCZcVTouVeaDC74rCKXDF/hKVcoHUwDSNCqZX0vsWqp18sbLRWYT8NVcW0W6QMOw7NSgMyD/417BVEpaY2O/aqSVx80ZjAz5ubQ/j2tobB+SB5ppcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2245.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:19:10 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:19:10 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: u.kleine-koenig@pengutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	cniedermaier@dh-electronics.com,
	hugo@hugovil.com,
	m.brock@vanmierlo.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	LinoSanfilippo@gmx.de,
	lukas@wunner.de,
	p.rosenberger@kunbus.com,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 1/7] serial: Do not hold the port lock when setting rx-during-tx GPIO
Date: Wed,  3 Jan 2024 07:18:12 +0100
Message-ID: <20240103061818.564-2-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103061818.564-1-l.sanfilippo@kunbus.com>
References: <20240103061818.564-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|GV1P193MB2245:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f1d246-a59f-4310-bb13-08dc0c23e5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xw+9grU9SzQgsPiQCZgwHiWqVAFooyPGuxUUUYRZ3tPBnr3O6kGiAJVl5hssSf+/CYB+yYg/02O0buQqYcHOSZNZJMEUP7LgHkh4FamFvKc34I16mS68RyxkF2j4dh6ORLrgR5tS4CaDJ2cK8lZ63/of1CN69zZi2tJ/0I1Y7bg1kWtNcegW+6OsQKjoDjcCblD6NZBZiMa2FDBszZzDiRMEx/9nqjX2ca2IwW2cKH7tVwfGhogID4favPnlkkUvKQudsUGz4c0m01P0+e+x0LF4p1SBYh+yZk6R/wj9SR7nlbXMforwgl2qIfr/t3oysxV3f22lVbCkK4bkVOhhKI4UlR0KFL/2e7Adw0juaH2p81NRjDdvtt110FaBH3cjc/2et9ULdjuATWKRFw55BTQ9D276SLm5lNbh+JpId2l9JKnH6Lc/Bg48qfHBI3Uy5TkfxB9edW886K2eBWjZM7GhYRl4ZqIYO9AbuU07MDe8lNPgnvMNsXtd7dusyAffI7ejSZp19sNSspS643zrquzt5JV4J6TGYfpBAkAqiX6okIEWpAXAdfx4rBIH/1uC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39830400003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(66476007)(4326008)(478600001)(316002)(8936002)(8676002)(6486002)(83380400001)(6512007)(6506007)(52116002)(1076003)(2616005)(7416002)(5660300002)(41300700001)(2906002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z6rc2GsGjLTaB7jGhYfVQ6E0snFJMaQ826RF8RURvqyBqs5EYXtaYmBPYMzB?=
 =?us-ascii?Q?7sn9veT6HgNhdoe7CuWl/nzFvKvzY3wWKqE6l14q//MaiDHHAY7cXrgiMJvN?=
 =?us-ascii?Q?joFuicbTSAljXLFGZzsrjhrEYMatmwgJ+qpLjas9IbcRWAISodn7jeJt6EFH?=
 =?us-ascii?Q?dX4L4c9Bw66fkHM8gSiRDD8D96Hdsf2kqzGgv0crdKJonLpwlVrB3k7l4MMo?=
 =?us-ascii?Q?lHKxnXh7hzvfjtxXavW/4c9gQrNNN/bvZlM50N5gHSLlFbhFGnj/Kzjk/nBK?=
 =?us-ascii?Q?FuyBnwbhVi978v8PTyQDH7MY0BlVFV7TKL8rINqC+LgoKJ2gawUm8XX/4HWx?=
 =?us-ascii?Q?/MVO2qHayjPDg7yUUiDjRgfTVwLHod87iVL7GIASOFPGTyeiuMGnmLP3s4lv?=
 =?us-ascii?Q?9tIZ4hiY+xY6+3nrLjWpbuHUKclMTO8jFECFSEYNwwRObolHXsrLmmV4i1Of?=
 =?us-ascii?Q?EaY8JQIZnioYKs2iThXTAm4lqZwGhtLBceC+l0+o3y5KvP71rlxv6kCpaz5g?=
 =?us-ascii?Q?KDBtywL0j58AJS0ipvb173ix09L9M+2tXtrmdUrND74L9HXlwU7yBYD+4JSP?=
 =?us-ascii?Q?ekuLEdkl62z3jD9HTj2oBbhZTSkW8+mk+YXUe8RvHxQ/M2trHhOMTsUdGbTI?=
 =?us-ascii?Q?gQNceJFWo8DQs1M5s27CZYgbO9wFNL+7zmm9g0NIaA9v52N56EmKAVasEVY0?=
 =?us-ascii?Q?Xe5ZbnaA/aOP8WjSsGl6Xc2Nyp4LKnzRorzybtVaCHrjow+ligQJBIO3rRju?=
 =?us-ascii?Q?B3A/9yO0yXfp6rtTzwzMaFlvxgH7WYMLw5IfdcXWm/G1BIaIr9YH+cNXvyy9?=
 =?us-ascii?Q?CyHVJiLPSAVpr/Cdh7tcEwdsZCBYXqZsj8vvOYA5EW+WuLKn4V8uGKWQQedE?=
 =?us-ascii?Q?4JK0VBQj9XDNdeQhtOifA1pDfOwstiNsrMs6qo3hzFyh5NxgN3v/N0AFGUUU?=
 =?us-ascii?Q?sWvYe/aDBBdf+O8UCZaftwoWWyGcD7fGNZJQ9kyUuJ6wfYsXvq5XLFeovVR6?=
 =?us-ascii?Q?/t1AsQSp/KyDVV0GV+W3NElGkChX8Xoc7l30AD8aQcMegaxHXSFm+mT9XzVu?=
 =?us-ascii?Q?B5Qo+kLBjemcyVZI/kqZHvJ2U/AX7F+cpN2bU70GwlZLVSlEYcQHqugXX8DA?=
 =?us-ascii?Q?4ueoCzO27KZCZZomGTBO035cxJNXd3LLe7ahMARIQpBunVIoeRl/z5Pzrbxs?=
 =?us-ascii?Q?YPmhqv1zdGUO15Q4Ua23pk85Swl4iFq+DL8RhWe6QLqyq26oX8mPcHkgnjpK?=
 =?us-ascii?Q?u06YiTH2W21pnAC75nFmVJ4tsp6Yo8IV3tW8fL5o9fz/PnYfnL7yzIdfcKSs?=
 =?us-ascii?Q?xZK1PvN+U70sNEbs63/vue9H/xkb80w4+psnISBFfL8J9D7nkSzZrBNm1UUh?=
 =?us-ascii?Q?z3CVs/hYyXba7cqM7rIMsaJKnLj/xVvMgzRagvl2Q0nzDYHdgmoA320KeyDf?=
 =?us-ascii?Q?b3lYbgMUemT+RdW3yCX7ax8EQaiE4IzMV9TBOthSofkHKeAszi4radlRVpfC?=
 =?us-ascii?Q?iHsPVVl92o5Mm4b2TokRXXZ5h+WD9HwoppSXmD0+U0ihxkccBC99kcHaORJ1?=
 =?us-ascii?Q?xLNMPaU5bHsJWR/7TCXDMmsuGngqDx6qmqpAJ99x0V44UJTucL5tXKD/bOH4?=
 =?us-ascii?Q?TQBHbfsKqz/vzmhxgN7WyJYEVRRuVsNccp0kM4IHYRetrb7SXjJP6zyDAQmf?=
 =?us-ascii?Q?lgJUgw=3D=3D?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f1d246-a59f-4310-bb13-08dc0c23e5c1
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 06:19:09.9931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpaUicFCG89A6B5Lp6oNH/8QjyZPJ67MA1FIUihfr+VLDtshDyEKLjmbCARQUv5PrqQ0b9wbWtJbGuL5eUuwAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2245

Qm90aCB0aGUgaW14IGFuZCBzdG0zMiBkcml2ZXIgc2V0IHRoZSByeC1kdXJpbmctdHggR1BJTyBp
biByczQ4NV9jb25maWcoKS4KU2luY2UgdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgd2l0aCB0aGUg
cG9ydCBsb2NrIGhlbGQsIHRoaXMgY2FuIGJlIGEKcHJvYmxlbSBpbiBjYXNlIHRoYXQgc2V0dGlu
ZyB0aGUgR1BJTyBsaW5lIGNhbiBzbGVlcCAoZS5nLiBpZiBhIEdQSU8KZXhwYW5kZXIgaXMgdXNl
ZCB3aGljaCBpcyBjb25uZWN0ZWQgdmlhIFNQSSBvciBJMkMpLgoKQXZvaWQgdGhpcyBpc3N1ZSBi
eSBtb3ZpbmcgdGhlIEdQSU8gc2V0dGluZyBvdXRzaWRlIG9mIHRoZSBwb3J0IGxvY2sgaW50bwp0
aGUgc2VyaWFsIGNvcmUgYW5kIHRodXMgbWFraW5nIGl0IGEgZ2VuZXJpYyBmZWF0dXJlLgoKQWxz
byB3aXRoIGNvbW1pdCBjNTRkNDg1NDM2ODkgKCJzZXJpYWw6IHN0bTMyOiBBZGQgc3VwcG9ydCBm
b3IgcnM0ODUKUlhfRFVSSU5HX1RYIG91dHB1dCBHUElPIikgdGhlIFNFUl9SUzQ4NV9SWF9EVVJJ
TkdfVFggZmxhZyBpcyBvbmx5IHNldCBpZiBhCnJ4LWR1cmluZy10eCBHUElPIGlzIF9ub3RfIGF2
YWlsYWJsZSwgd2hpY2ggaXMgd3JvbmcuIEZpeCB0aGlzLCB0b28uCgpGdXJ0aGVybW9yZSByZXNl
dCBvbGQgR1BJTyBzZXR0aW5ncyBpbiBjYXNlIHRoYXQgY2hhbmdpbmcgdGhlIFJTNDg1CmNvbmZp
Z3VyYXRpb24gZmFpbGVkLgoKRml4ZXM6IGM1NGQ0ODU0MzY4OSAoInNlcmlhbDogc3RtMzI6IEFk
ZCBzdXBwb3J0IGZvciByczQ4NSBSWF9EVVJJTkdfVFggb3V0cHV0IEdQSU8iKQpGaXhlczogY2E1
MzBjZmE5NjhjICgic2VyaWFsOiBpbXg6IEFkZCBzdXBwb3J0IGZvciBSUzQ4NSBSWF9EVVJJTkdf
VFggb3V0cHV0IEdQSU8iKQpDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPgpDYzog
U2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPgpDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5i
dXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyAgICAgICAgIHwgIDQgLS0tLQog
ZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCAyNiArKysrKysrKysrKysrKysrKysr
KysrKystLQogZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMgfCAgOCArKy0tLS0tLQog
MyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14
LmMKaW5kZXggNzA4Yjk4NTJhNTc1Li45Y2ZmZWIyMzExMmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
dHR5L3NlcmlhbC9pbXguYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKQEAgLTE5NDMs
MTAgKzE5NDMsNiBAQCBzdGF0aWMgaW50IGlteF91YXJ0X3JzNDg1X2NvbmZpZyhzdHJ1Y3QgdWFy
dF9wb3J0ICpwb3J0LCBzdHJ1Y3Qga3Rlcm1pb3MgKnRlcm1pbwogCSAgICByczQ4NWNvbmYtPmZs
YWdzICYgU0VSX1JTNDg1X1JYX0RVUklOR19UWCkKIAkJaW14X3VhcnRfc3RhcnRfcngocG9ydCk7
CiAKLQlpZiAocG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8pCi0JCWdwaW9kX3NldF92YWx1
ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbywKLQkJCQkJICEhKHJzNDg1
Y29uZi0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKSk7Ci0KIAlyZXR1cm4gMDsKIH0K
IApkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwppbmRleCBmMTM0OGE1MDk1NTIuLmQxNTUxMzFmMjIx
ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJp
dmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKQEAgLTE0MDIsNiArMTQwMiwxNiBAQCBzdGF0
aWMgdm9pZCB1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlvbihzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0
LAogCQkJCSAhIShyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfVEVSTUlOQVRFX0JVUykpOwogfQog
CitzdGF0aWMgdm9pZCB1YXJ0X3NldF9yczQ4NV9yeF9kdXJpbmdfdHgoc3RydWN0IHVhcnRfcG9y
dCAqcG9ydCwKKwkJCQkJY29uc3Qgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUpCit7CisJaWYg
KCEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpKQorCQlyZXR1cm47CisKKwlncGlv
ZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8sCisJCQkJ
ICEhKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgpKTsKK30KKwogc3RhdGlj
IGludCB1YXJ0X3JzNDg1X2NvbmZpZyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQogewogCXN0cnVj
dCBzZXJpYWxfcnM0ODUgKnJzNDg1ID0gJnBvcnQtPnJzNDg1OwpAQCAtMTQxMywxMiArMTQyMywx
NyBAQCBzdGF0aWMgaW50IHVhcnRfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQp
CiAKIAl1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NShwb3J0LCByczQ4NSk7CiAJdWFydF9zZXRf
cnM0ODVfdGVybWluYXRpb24ocG9ydCwgcnM0ODUpOworCXVhcnRfc2V0X3JzNDg1X3J4X2R1cmlu
Z190eChwb3J0LCByczQ4NSk7CiAKIAl1YXJ0X3BvcnRfbG9ja19pcnFzYXZlKHBvcnQsICZmbGFn
cyk7CiAJcmV0ID0gcG9ydC0+cnM0ODVfY29uZmlnKHBvcnQsIE5VTEwsIHJzNDg1KTsKIAl1YXJ0
X3BvcnRfdW5sb2NrX2lycXJlc3RvcmUocG9ydCwgZmxhZ3MpOwotCWlmIChyZXQpCisJaWYgKHJl
dCkgewogCQltZW1zZXQocnM0ODUsIDAsIHNpemVvZigqcnM0ODUpKTsKKwkJLyogdW5zZXQgR1BJ
T3MgKi8KKwkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3Rlcm1fZ3Bpbywg
MCk7CisJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhf
Z3BpbywgMCk7CisJfQogCiAJcmV0dXJuIHJldDsKIH0KQEAgLTE0NTcsNiArMTQ3Miw3IEBAIHN0
YXRpYyBpbnQgdWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIHN0
cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJCXJldHVybiByZXQ7CiAJdWFydF9zYW5pdGl6ZV9zZXJp
YWxfcnM0ODUocG9ydCwgJnJzNDg1KTsKIAl1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlvbihwb3J0
LCAmcnM0ODUpOworCXVhcnRfc2V0X3JzNDg1X3J4X2R1cmluZ190eChwb3J0LCAmcnM0ODUpOwog
CiAJdWFydF9wb3J0X2xvY2tfaXJxc2F2ZShwb3J0LCAmZmxhZ3MpOwogCXJldCA9IHBvcnQtPnJz
NDg1X2NvbmZpZyhwb3J0LCAmdHR5LT50ZXJtaW9zLCAmcnM0ODUpOwpAQCAtMTQ2OCw4ICsxNDg0
LDE0IEBAIHN0YXRpYyBpbnQgdWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB0dHlfc3RydWN0
ICp0dHksIHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJCQlwb3J0LT5vcHMtPnNldF9tY3RybChw
b3J0LCBwb3J0LT5tY3RybCk7CiAJfQogCXVhcnRfcG9ydF91bmxvY2tfaXJxcmVzdG9yZShwb3J0
LCBmbGFncyk7Ci0JaWYgKHJldCkKKwlpZiAocmV0KSB7CisJCS8qIHJlc3RvcmUgb2xkIEdQSU8g
c2V0dGluZ3MgKi8KKwkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3Rlcm1f
Z3BpbywKKwkJCSEhKHBvcnQtPnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X1RFUk1JTkFURV9CVVMp
KTsKKwkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9n
cGlvLAorCQkJISEocG9ydC0+cnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKSk7
CiAJCXJldHVybiByZXQ7CisJfQogCiAJaWYgKGNvcHlfdG9fdXNlcihyczQ4NV91c2VyLCAmcG9y
dC0+cnM0ODUsIHNpemVvZihwb3J0LT5yczQ4NSkpKQogCQlyZXR1cm4gLUVGQVVMVDsKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jIGIvZHJpdmVycy90dHkvc2Vy
aWFsL3N0bTMyLXVzYXJ0LmMKaW5kZXggMzA0ODYyMDMxNWQ2Li5mYzdmZDQwYmNhOTggMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jCisrKyBiL2RyaXZlcnMvdHR5
L3NlcmlhbC9zdG0zMi11c2FydC5jCkBAIC0yMjYsMTIgKzIyNiw2IEBAIHN0YXRpYyBpbnQgc3Rt
MzJfdXNhcnRfY29uZmlnX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVy
bWlvcyAqdGVyCiAKIAlzdG0zMl91c2FydF9jbHJfYml0cyhwb3J0LCBvZnMtPmNyMSwgQklUKGNm
Zy0+dWFydF9lbmFibGVfYml0KSk7CiAKLQlpZiAocG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dw
aW8pCi0JCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhf
Z3BpbywKLQkJCQkJICEhKHJzNDg1Y29uZi0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RY
KSk7Ci0JZWxzZQotCQlyczQ4NWNvbmYtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFg7
Ci0KIAlpZiAocnM0ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSB7CiAJCWNyMSA9
IHJlYWRsX3JlbGF4ZWQocG9ydC0+bWVtYmFzZSArIG9mcy0+Y3IxKTsKIAkJY3IzID0gcmVhZGxf
cmVsYXhlZChwb3J0LT5tZW1iYXNlICsgb2ZzLT5jcjMpOwpAQCAtMjU2LDYgKzI1MCw4IEBAIHN0
YXRpYyBpbnQgc3RtMzJfdXNhcnRfY29uZmlnX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQs
IHN0cnVjdCBrdGVybWlvcyAqdGVyCiAKIAkJd3JpdGVsX3JlbGF4ZWQoY3IzLCBwb3J0LT5tZW1i
YXNlICsgb2ZzLT5jcjMpOwogCQl3cml0ZWxfcmVsYXhlZChjcjEsIHBvcnQtPm1lbWJhc2UgKyBv
ZnMtPmNyMSk7CisKKwkJcnM0ODVjb25mLT5mbGFncyB8PSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RY
OwogCX0gZWxzZSB7CiAJCXN0bTMyX3VzYXJ0X2Nscl9iaXRzKHBvcnQsIG9mcy0+Y3IzLAogCQkJ
CSAgICAgVVNBUlRfQ1IzX0RFTSB8IFVTQVJUX0NSM19ERVApOwotLSAKMi40My4wCgo=

