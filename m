Return-Path: <linux-kernel+bounces-17906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233F88254E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4287E1C22D56
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4C2DF72;
	Fri,  5 Jan 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="xIgIn/g9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2C2DF62;
	Fri,  5 Jan 2024 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezpO/WuQlYeaPlhfJJGWvXmj1fi/71Xj240Vj9g5DAXhSry5PTIf+w8lQyvqu/z25wdQjQKQw34HGGeMmWjwpPZMlGTxoWdx9F6HHrgGmCXoYyuQXMlrwFxTcwzkFYUCZp2AaQpk5/FBgAA1T80/kByYRt+NqS3N9XOaGgGDK+FjIsq8nzcK612wX50gh5BwtJqDHSLHxOqztqmbsw67aAheN5EVM5Wvn1Rx67/J8zrhNxSjpt0R7An7TEL/l2bO5KMgfkNdNpzvqU1EAZehuIxNzugl84t/Ixbh4QBzyCTII6RL+KcHesiHTf7aoXo+V3vdP7X823LRcv6JQPjfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08tY/p64qe3JTx/fl3vp5vN6HV6IIz26ikwTn6Erw4M=;
 b=WH3tkmAcdTeTQdOxKevgvs/GDLnoD79/B7+gPJb7+mBNo4jXAlwiFDRdFdYyUm410avHTOXBTog28Or7wNOevy2CbmSeaBdOlR7LqNGgmDvQBNyOLqTteoti6vKJ5kdXZrjwoTVDiMxDzV+1xkuituq3g/slVGixMkGs4yXbJEtELefAjT9UwOO5qUjuewijk3AkokMYeK8Wd1bSixCiFfT6ro2aHEzZ+FdmHq7tsy3HZyvLEOKTBF6lJVNas26CdzNoIjiyXTVlpzSnnQ83clVZO1OEAxWxjB9rjUYyvf7EidjbOCK4RD2zrI7jiGqGTO1GrhTmQXTA86OLNrri6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08tY/p64qe3JTx/fl3vp5vN6HV6IIz26ikwTn6Erw4M=;
 b=xIgIn/g9e/MvI3R33fVdtTa97/V1sCsD7Wd8RpSIJiwmdGjbvad/eqi6mRSi4Dua3uDA/x2hIBVylxOaHPnkkDRePH1FP56GDwipJhoqD/DBGDs6wwkCrvnzCXc7jZQ60S0IFRA7OzPoOl8yC0w3KPE1g0Zlk6r2NC9ff7+GO3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM9P193MB1538.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:12:13 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:12:13 +0000
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
Subject: [PATCH v8 1/7] serial: Do not hold the port lock when setting rx-during-tx GPIO
Date: Fri,  5 Jan 2024 15:11:47 +0100
Message-ID: <20240105141153.19249-2-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105141153.19249-1-l.sanfilippo@kunbus.com>
References: <20240105141153.19249-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::11) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM9P193MB1538:EE_
X-MS-Office365-Filtering-Correlation-Id: 603bc360-aa28-4985-4403-08dc0df84ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oxe1DYxMJQTpGEWY3LZdg3W9U/EQwWhuFE26xuSF1aAXemLq4H+mDvgvrRxDtXFo3pQKfpjptFXL/ylhc2UuczZSSI3sofRA1qvdmHB79P3EeXoGkmJJPXVk4yl4HIhFWs9TZvUNKjpRgQa1ul3OKAMyqtB6WahW9Aqv/4bxjiogSSn4GB6mUReJjj8QscE7Air2yiNO7Yt8hra9tohFY9fFRIyVriEBZdVcOxe+5H74p0KWBYSBH8K1YJevr84JFlVe9mBLD+Yg3n3J6LQy+GGB98Bat3EXAveHA4h6B+YeB2BodPZtmSEVqEUuZ0FraaCuGG+QXExEaHcYkqi8CeXj6dVfd/Snk+FZsTLs7M1x98b/nOe+iNJOwDd+uxA81GezDEzKsRhij64ZhFK3lXEeTfXvc9F7Gh4Cj0yGmLJgW6j5yiOisf6l7Sy94tsZHveBv9HQtU/orcDnDik1FTmBbunec19Ghz+9vqdYUm5ai34zoVots7iDWC4KNbYVWvjXMq3phZLLogkXPoxVzpsJBfOZt/u4kuVWNq+aGHxZVLAu5fRQffpATGBvBndE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(52116002)(6512007)(478600001)(6506007)(66946007)(66556008)(86362001)(66476007)(6486002)(83380400001)(38100700002)(2906002)(6666004)(2616005)(1076003)(7416002)(4326008)(5660300002)(41300700001)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zmDd+0EkATo54gzNXsg09YLp3vKBbmELhGcI9Y18tra+o6WayCbmpKLOzGix?=
 =?us-ascii?Q?xyFGSTYWJ80xvfYX3r2v3bZbe3wV55Qu2VtcK+PCe0phOzUOoS4ZXU99aPFZ?=
 =?us-ascii?Q?UAblGI0i4LageeuW2E/VPzy5ZGbERKgrfuvbXKbqo1SgN7PizDngtjegzTNE?=
 =?us-ascii?Q?1NalOYnfCPClPzSg83Av8EfTyC0ZIuC/+IhI+X3A/lpOvHH2m2GnN3+GoKoB?=
 =?us-ascii?Q?lxGDhK6yl0usVLh/eraGCYyqZrGt2cA4dQCR5p+xrQxl9CDRIGhbbwiH71lC?=
 =?us-ascii?Q?ZzXarWwh6XpLptOzgwOg9TZL46yrEKvo3yVzrPT0vjIGsRuVoPygIl4keHG+?=
 =?us-ascii?Q?VYtWRb+GL1/SH81Z4+zjUpBsSsOd13K7CTURH57zKO2+KC44UOoh0D15jj6d?=
 =?us-ascii?Q?OLwkXTnBknNo9xz6R2qXd8xR/iotv0g1FZMz6JsHaXtl2Uy2Yhor+FxehFSG?=
 =?us-ascii?Q?KmF2YNbVurgQpHmnUKjaAvzvj4tKk+M1/lxgN/j0ZpEI2SM77twRPiVortRL?=
 =?us-ascii?Q?OoEFHhRe5i21xQvQmznjF3eCH5IsRRfsk8PN0xnyliANVNcMn3JONyCI6g96?=
 =?us-ascii?Q?X0l5ikHfyPu2WcZWQ+UkYZi92XXj3FJ2hrR+r5DAZ/Ygge3AsN7IfaritVWD?=
 =?us-ascii?Q?sbKwtIOkgFfaetI0JsGAR+8YH/XEMkoIb00hSyLD3SzQ4+SKvNa5Vyzcstbi?=
 =?us-ascii?Q?nt9IqhoEkkV1mBrJESLPwF9+0tTddgBdhOH+qOHmG+ffKZ8q/r97PwUdJXvu?=
 =?us-ascii?Q?dEfzoCSLqFE6c/8a8TTtoem2YwifAVK0/PkmifuH5N0Fw1Bx/NpQL+GA9zji?=
 =?us-ascii?Q?GAuf8SlyiqWjFQvp7qQHyiqycol094M7Gp1HBga7oKv0TtmMGb8J0f/0hkCd?=
 =?us-ascii?Q?wdmskG5s14kk0TkxmAUUVrsr6+3GhuuKpmoA/Y2UGzbfW0Royje4LqpfthFN?=
 =?us-ascii?Q?DbNalat3sF9iykwkLmTltZ43wVdyeRYs7v+dnjupEsiY/q8DhMRJOsKFNmAQ?=
 =?us-ascii?Q?n/VZH45hdW0hTpFkUtVM1GBNCOIezZG47ttxtt9Xgjndr55ujMG3MJgEgpMn?=
 =?us-ascii?Q?8n49NzuDWLhf2/i6O3d2dcSMatvFxZeo7nniHebrEkpWzoSnhSHqU0AoZdNW?=
 =?us-ascii?Q?hjGGR/VkQxQo+d+MLYoZfsO8a3swbDsWv+ue6xCBXqREICaxQCCJNB7ODYPX?=
 =?us-ascii?Q?oPN/U2UibtcqLxr0R4yCbX8vlhoqSlTQoQxpInrd3zxaBnjRbcF9Bxeg7r+e?=
 =?us-ascii?Q?AUZxNsFvo1Q4jHHzTuGU0AsM9y6KjFd5SLRyjgIkizcdgu2sxrDgM3Pl4xJp?=
 =?us-ascii?Q?b5d8/RNWqoz+MoVmDea6nw6NEFelU8zSZg2FE+/ecEujsXt4Q9EYHVAfWZ7m?=
 =?us-ascii?Q?qLxNPWiupZ4PO/Au9/yuspNGfDi8BmZ77hrjA7Dg6j/NGufexr97cGO2ETnH?=
 =?us-ascii?Q?Tc5UzE/SGdTmMIQKLoQRHatA7vqwobtiBp6X4iGG+y1aygh8BHY9eeTelQwG?=
 =?us-ascii?Q?68dwAq6aqA8uvlpWzRk23BIO0KTbtlRwCpk2R7m4TLV49+HuOyh36bEEW9u8?=
 =?us-ascii?Q?//JOcbJh3mbXpnUef/A/guYWRCDsYnaIHYUfL/VgieKyMuGuGWUUuIY7KCZG?=
 =?us-ascii?Q?1EHXd8675MQc43H9iDM6mJEwzLE7EAroFt9Ox5olt+Mpyl8jMG3rvne/PqGD?=
 =?us-ascii?Q?UziYfQ=3D=3D?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603bc360-aa28-4985-4403-08dc0df84ff8
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:12:12.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMs1JZs1AOxaf/GiR/+CaHy7kq2nfWvV9YZFS+PYxZSvVC2WtV8jKT2Ll/wZgVjaxZyywL7bcHq6OY9Vbaucfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1538

Qm90aCB0aGUgaW14IGFuZCBzdG0zMiBkcml2ZXIgc2V0IHRoZSByeC1kdXJpbmctdHggR1BJTyBp
biByczQ4NV9jb25maWcoKS4KU2luY2UgdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgd2l0aCB0aGUg
cG9ydCBsb2NrIGhlbGQsIHRoaXMgY2FuIGJlIGFuCnByb2JsZW0gaW4gY2FzZSB0aGF0IHNldHRp
bmcgdGhlIEdQSU8gbGluZSBjYW4gc2xlZXAgKGUuZy4gaWYgYSBHUElPCmV4cGFuZGVyIGlzIHVz
ZWQgd2hpY2ggaXMgY29ubmVjdGVkIHZpYSBTUEkgb3IgSTJDKS4KCkF2b2lkIHRoaXMgaXNzdWUg
YnkgbW92aW5nIHRoZSBHUElPIHNldHRpbmcgb3V0c2lkZSBvZiB0aGUgcG9ydCBsb2NrIGludG8K
dGhlIHNlcmlhbCBjb3JlIGFuZCB0aHVzIG1ha2luZyBpdCBhIGdlbmVyaWMgZmVhdHVyZS4KCkFs
c28gcmVzZXQgb2xkIEdQSU8gc2V0dGluZ3MgaW4gY2FzZSB0aGF0IGNoYW5naW5nIHRoZSBSUzQ4
NSBjb25maWd1cmF0aW9uCmZhaWxlZC4KCkZpeGVzOiBjNTRkNDg1NDM2ODkgKCJzZXJpYWw6IHN0
bTMyOiBBZGQgc3VwcG9ydCBmb3IgcnM0ODUgUlhfRFVSSU5HX1RYIG91dHB1dCBHUElPIikKRml4
ZXM6IGNhNTMwY2ZhOTY4YyAoInNlcmlhbDogaW14OiBBZGQgc3VwcG9ydCBmb3IgUlM0ODUgUlhf
RFVSSU5HX1RYIG91dHB1dCBHUElPIikKQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9y
Zz4KQ2M6IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KQ2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlw
cG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgICAgICAgICB8ICA0
IC0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIHwgMjYgKysrKysrKysrKysr
KysrKysrKysrKysrLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jIHwgIDUgKy0t
LS0KIDMgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFs
L2lteC5jCmluZGV4IDcwOGI5ODUyYTU3NS4uOWNmZmViMjMxMTJiIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3R0eS9zZXJpYWwvaW14LmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCkBAIC0x
OTQzLDEwICsxOTQzLDYgQEAgc3RhdGljIGludCBpbXhfdWFydF9yczQ4NV9jb25maWcoc3RydWN0
IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW8KIAkgICAgcnM0ODVjb25m
LT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgpCiAJCWlteF91YXJ0X3N0YXJ0X3J4KHBv
cnQpOwogCi0JaWYgKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvKQotCQlncGlvZF9zZXRf
dmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8sCi0JCQkJCSAhIShy
czQ4NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X1JYX0RVUklOR19UWCkpOwotCiAJcmV0dXJuIDA7
CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIGIvZHJp
dmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXggZjEzNDhhNTA5NTUyLi5kMTU1MTMx
ZjIyMWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCisrKyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBAIC0xNDAyLDYgKzE0MDIsMTYgQEAg
c3RhdGljIHZvaWQgdWFydF9zZXRfcnM0ODVfdGVybWluYXRpb24oc3RydWN0IHVhcnRfcG9ydCAq
cG9ydCwKIAkJCQkgISEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X1RFUk1JTkFURV9CVVMpKTsK
IH0KIAorc3RhdGljIHZvaWQgdWFydF9zZXRfcnM0ODVfcnhfZHVyaW5nX3R4KHN0cnVjdCB1YXJ0
X3BvcnQgKnBvcnQsCisJCQkJCWNvbnN0IHN0cnVjdCBzZXJpYWxfcnM0ODUgKnJzNDg1KQorewor
CWlmICghKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSkKKwkJcmV0dXJuOworCisJ
Z3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvLAor
CQkJCSAhIShyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKSk7Cit9CisKIHN0
YXRpYyBpbnQgdWFydF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKIHsKIAlz
dHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSA9ICZwb3J0LT5yczQ4NTsKQEAgLTE0MTMsMTIgKzE0
MjMsMTcgQEAgc3RhdGljIGludCB1YXJ0X3JzNDg1X2NvbmZpZyhzdHJ1Y3QgdWFydF9wb3J0ICpw
b3J0KQogCiAJdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUocG9ydCwgcnM0ODUpOwogCXVhcnRf
c2V0X3JzNDg1X3Rlcm1pbmF0aW9uKHBvcnQsIHJzNDg1KTsKKwl1YXJ0X3NldF9yczQ4NV9yeF9k
dXJpbmdfdHgocG9ydCwgcnM0ODUpOwogCiAJdWFydF9wb3J0X2xvY2tfaXJxc2F2ZShwb3J0LCAm
ZmxhZ3MpOwogCXJldCA9IHBvcnQtPnJzNDg1X2NvbmZpZyhwb3J0LCBOVUxMLCByczQ4NSk7CiAJ
dWFydF9wb3J0X3VubG9ja19pcnFyZXN0b3JlKHBvcnQsIGZsYWdzKTsKLQlpZiAocmV0KQorCWlm
IChyZXQpIHsKIAkJbWVtc2V0KHJzNDg1LCAwLCBzaXplb2YoKnJzNDg1KSk7CisJCS8qIHVuc2V0
IEdQSU9zICovCisJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV90ZXJtX2dw
aW8sIDApOworCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfcnhfZHVyaW5n
X3R4X2dwaW8sIDApOworCX0KIAogCXJldHVybiByZXQ7CiB9CkBAIC0xNDU3LDYgKzE0NzIsNyBA
QCBzdGF0aWMgaW50IHVhcnRfc2V0X3JzNDg1X2NvbmZpZyhzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5
LCBzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAogCQlyZXR1cm4gcmV0OwogCXVhcnRfc2FuaXRpemVf
c2VyaWFsX3JzNDg1KHBvcnQsICZyczQ4NSk7CiAJdWFydF9zZXRfcnM0ODVfdGVybWluYXRpb24o
cG9ydCwgJnJzNDg1KTsKKwl1YXJ0X3NldF9yczQ4NV9yeF9kdXJpbmdfdHgocG9ydCwgJnJzNDg1
KTsKIAogCXVhcnRfcG9ydF9sb2NrX2lycXNhdmUocG9ydCwgJmZsYWdzKTsKIAlyZXQgPSBwb3J0
LT5yczQ4NV9jb25maWcocG9ydCwgJnR0eS0+dGVybWlvcywgJnJzNDg1KTsKQEAgLTE0NjgsOCAr
MTQ4NCwxNCBAQCBzdGF0aWMgaW50IHVhcnRfc2V0X3JzNDg1X2NvbmZpZyhzdHJ1Y3QgdHR5X3N0
cnVjdCAqdHR5LCBzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAogCQkJcG9ydC0+b3BzLT5zZXRfbWN0
cmwocG9ydCwgcG9ydC0+bWN0cmwpOwogCX0KIAl1YXJ0X3BvcnRfdW5sb2NrX2lycXJlc3RvcmUo
cG9ydCwgZmxhZ3MpOwotCWlmIChyZXQpCisJaWYgKHJldCkgeworCQkvKiByZXN0b3JlIG9sZCBH
UElPIHNldHRpbmdzICovCisJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV90
ZXJtX2dwaW8sCisJCQkhIShwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9URVJNSU5BVEVf
QlVTKSk7CisJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV9yeF9kdXJpbmdf
dHhfZ3BpbywKKwkJCSEhKHBvcnQtPnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X1JYX0RVUklOR19U
WCkpOwogCQlyZXR1cm4gcmV0OworCX0KIAogCWlmIChjb3B5X3RvX3VzZXIocnM0ODVfdXNlciwg
JnBvcnQtPnJzNDg1LCBzaXplb2YocG9ydC0+cnM0ODUpKSkKIAkJcmV0dXJuIC1FRkFVTFQ7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYyBiL2RyaXZlcnMvdHR5
L3NlcmlhbC9zdG0zMi11c2FydC5jCmluZGV4IDMwNDg2MjAzMTVkNi4uZWM5YTcyYTViZWE5IDEw
MDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYworKysgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYwpAQCAtMjI2LDEwICsyMjYsNyBAQCBzdGF0aWMgaW50
IHN0bTMyX3VzYXJ0X2NvbmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBzdHJ1Y3Qg
a3Rlcm1pb3MgKnRlcgogCiAJc3RtMzJfdXNhcnRfY2xyX2JpdHMocG9ydCwgb2ZzLT5jcjEsIEJJ
VChjZmctPnVhcnRfZW5hYmxlX2JpdCkpOwogCi0JaWYgKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190
eF9ncGlvKQotCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfcnhfZHVyaW5n
X3R4X2dwaW8sCi0JCQkJCSAhIShyczQ4NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X1JYX0RVUklO
R19UWCkpOwotCWVsc2UKKwlpZiAoIXBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvKQogCQly
czQ4NWNvbmYtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFg7CiAKIAlpZiAocnM0ODVj
b25mLT5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSB7Ci0tIAoyLjQzLjAKCg==

