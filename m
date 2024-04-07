Return-Path: <linux-kernel+bounces-134110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555489ADB8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D85DCB21831
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 00:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4ECA92F;
	Sun,  7 Apr 2024 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="lL7/rb1j"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2133.outbound.protection.outlook.com [40.107.7.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8C5223;
	Sun,  7 Apr 2024 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712449654; cv=fail; b=rbkCqwyPNFBCwISTsEBM4WQq9rYlJJI/YakywV0EvJMAJYd5sbJCafmkVzbdgXLZd/A+0/oDXxwvFwBF9fK2NGxyn4fYpUlT7cFZ4Fa3vuJUNsYh76dDdSIK/MvcMmr1Mx4rbmm2BDJaEKKhZX2Ibnx+9xNygGWMe7d9DIdbzZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712449654; c=relaxed/simple;
	bh=Rr9NZCiaKnacCzfVQBb1m07cWvZaVYxn1gopvjw3YJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fyyHDU1l4xFFu4vRnEHEg8VAzR+6mS+6cEaXQNpwZ5qBI+Q1HrJ1UoqNOOCOuqk6klPlopD3iy2TRU87GlTEugHnc4hqUPPc3luDNv4CAcBrtpwIZ37E1MyGS6pRcQ+Z4wxEowy14ntDDrGiB18Dq8LSTz1RnIvaoJLkoAk3sow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=lL7/rb1j; arc=fail smtp.client-ip=40.107.7.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn5Wnuqjzi7W+NpuiECOw6efvaXXd41hY4RQK5ANNBg+xtjtrgyVErzAGK8PCM8xUthjWTN2+lD9Tsi6hJDidsykBnqrCb6B4+oy2qHLDQ6L0x5qX1BmkL2nILGq0dxcaxIIBYtV1av1tU1eRMCKXD3tPfRt8cJWFoR9m21uHFrC+EoNmWTRrfkKFrfjWEsnB8ZqrsposqG3oNv1kWMrGOeJpTZq9NrkGOgCfbnXAq8JWk6V7PV1W9XQDVc5jFlLtPgM8FAs4dsI27yjBKnNG3Dj6p3d/cJE2LAprUPqHRKB7LYFBPDbiEv5iT3DOh7PC/K/WA2PvmLFKBwuY7Rinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr9NZCiaKnacCzfVQBb1m07cWvZaVYxn1gopvjw3YJU=;
 b=OVYWrcvjRgLBnsUUjHXHvEXzfR200oiwu+Ss+Ja9jiselUuYawBZRV80XCH81lLA2h4SAF7ioqjXAc9imgMWGDOIh6VwTaHNI7H/4WdVlBBsH6J8N2qtl6y+NFy3JHFZGzJfL2MDlXE1dO8KtWfEVF4oqU1Y7UUEx8A5/SxCV5Ng+3g/h4hxxA8pwLGCr6BfCVSAFkF/24Qigbrpyfxv5J9+oPV0B3leedcMsiV3u6mY3ASPbXqz73ToZB+tJlkKvtgxvvscPOWGZhx5TEpQLSzcp2+NGWPB2rLORiTpP2EutPcLUT9orqL7rNqkI1Wq3oeBQ/NGVyVwgWEif5vGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rr9NZCiaKnacCzfVQBb1m07cWvZaVYxn1gopvjw3YJU=;
 b=lL7/rb1jkGvFvY+uv1s6L54u5KtzKW9D2hMsp378/5KPMNTVObQqTDHATnHGp/hG7EEcBfzJxXLlcRVyBWm3JxmwfKTkOfLOmJHpYQL7eBSwx2meDfX6sPxf19Hm4bjH+Bz/sDW3P6unoVFcXBlC/tTuaj/Lzmv00ylPZLBh9LM=
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DB9P193MB1339.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:26c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 00:27:24 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::b435:c513:2483:90b8]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::b435:c513:2483:90b8%4]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 00:27:24 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: LinoSanfilippo@gmx.de,
	lukas@wunner.de,
	p.rosenberger@kunbus.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 3/4] serial: 8250: Remove superfluous sanity check
Date: Sun,  7 Apr 2024 02:27:08 +0200
Message-ID: <20240407002709.16224-4-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240407002709.16224-1-l.sanfilippo@kunbus.com>
References: <20240407002709.16224-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0319.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|DB9P193MB1339:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5GUoSE/nLAgtNbhJFmwl/BhIufyik0dz1TMpGixRLY6o7rQ47/stnE/P6ehKS4Sc0icxgETPHzgkeuwRIT1jNCyMJ2JJORqN2zL+gZNv8CIWqlAAziJUObDcKltaJSpPgY5EcOulyOyQArs/85GRyImVng1qUebyE7Zj25HT0Z823mPfG1aMIYwvleyBQYwTlR/vN4L1gKC/hY55YSf55LRNZWacfjg45OKPJMUIfLaMcnLZzdCEEBn2hL790EtuaoeVgc7bATCjj5AM6Y57CN/Q/RQYa+SJV+7zqDmhapXLwHAgSn4hSyqmjRiqRrhkLmcxYNs3cQASEHavfov+QjIMeyExiqqWmJrjyJzTrKmnPYH1gmPuaz05v/I0KYAnvxNVU1oNGi7qHzfiT8OH0l9C13SXUCNAvWaa47X3eW3QbeyYETUj588i1yMk4CvR7blG3o3kB+V0UnzEX3jm+EcVGcmxnef7iwCOT/K94YGbYwcFeka9Fwu5RJqqGH+9epuGruJ3a5imotqljadZG1k/eXpbAMi7H9HHEfT/JgTqMYaUD6xD14NmKCFNlJQPY2RLAw9ySxogldPaPJRPgtw49qeTZKmci91SzsquJeSxHVz286Ubh5fhz1F4ukpS7xwlCCTIwrBZNoa5g0cGrKlqBqNNsOeZVIfJRGYPWXE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DaTzPY0pSHagPeuKNZykFRIJo95diRlB8BSYbAnQZjoERcLObDPuJUsLfO/d?=
 =?us-ascii?Q?m3zDhwmyrXtWcWe9bTgIhLXiQFuZ0niwMmGiEuRbpnwbHaJ+bA9rKVGBnX56?=
 =?us-ascii?Q?j3wqOZcOoGI9hfVWQBtR+bfpIZjIFXdYsyEVyMN2CNGwCiKogGRVRvl2lPC2?=
 =?us-ascii?Q?CClE1UNSK8NvRfnBS+Lp9zRoFjLzB1apasNHba7hjJ/U9fpnXkLhMXb92kF+?=
 =?us-ascii?Q?Kr8b3vl3lRDwtRgT4KdOTatR5v0BbWdvii7eTTjb3/32p0ZX6DXjWP/z7o+H?=
 =?us-ascii?Q?x44gq3J+PwjNCDSAiSq4OYji4sLG5WA59O2TsU0h+v+AqglQtA6ZCi+dAnhD?=
 =?us-ascii?Q?iBpM+oDksmKTJ2E9QQf3WmaOFdNUr//SerkVOSB484/abL6FmKWLcSqmAZ28?=
 =?us-ascii?Q?nOf4HoVvuMkQPRKhJBUDlITHlRXHU29kDBcKDvdTOdodj6ylAHsZUNtEgKMQ?=
 =?us-ascii?Q?WwenzyDGdJMgpMnVypkyy7QA8NuUrjSe0DHU5RLD7dzSfIjshoUftLEyGE1b?=
 =?us-ascii?Q?YLGuDS0Lg2o+ommjwqGH3OnVyrt6MIBKzD6AGt5ADyh0xCkO3jQz8WuUqswo?=
 =?us-ascii?Q?q/XlmdXJmNnnk7m4H9aJ59r1jket/J5bOnfBHU/lfxEbjZXWqpvej99TT52Z?=
 =?us-ascii?Q?4upt7K9QBDR7LNhlSUjzjlAdzXfGU+fZuux/ls1TT6NsmJxwRNfZV4KEh9YB?=
 =?us-ascii?Q?v+f3+w9MjV/tb8BrFMkKKlLQVUSHIxmHm4J9BjO5vYQQBt6zolALlcGwrloE?=
 =?us-ascii?Q?XF78loYZzZ1cw7NFqKotM7rHJv40UcRVbQ2jkxGhOWqj3guAtNeLDWl/2rkt?=
 =?us-ascii?Q?HadIFHUcKegpySNTo5hSnL+4haQpn+M2AKUvx09A/qpbfNURpGuowqJXxNYt?=
 =?us-ascii?Q?JgfRSItdt/+WpTphYG9Hgh+hmOTOs3mJ4Hrntj0in41OZk1977TkByGxDoiw?=
 =?us-ascii?Q?zwPXvnx25pcnvnxu8RDZJoSCpRVvcpiPrb/kej2mo4KEMYDbUdoCVoavyKv3?=
 =?us-ascii?Q?ZPCt6x4o65n0LzwEJfIV/uJFV1wUFonHMEa2dDrMK3FelMF8T9SZUGRy3+SF?=
 =?us-ascii?Q?Emqp77KxUoZZdHvuexmJKZ+U/BOxtU4vmBWQuwDqeMTuQ2A0EBlvnA2vetMY?=
 =?us-ascii?Q?J5rUOSMhdu4MrigzslBc12utdUdglujK3vimTYiWIoT6W3DT8soMWaUOuyNb?=
 =?us-ascii?Q?USFEpg2VvmujOHW6N+aPXO0JWVrb9A+3as06N5YuW+vDVamlu3lmuBTF8/he?=
 =?us-ascii?Q?qnBdtuWavBnYJXG3uDLWduCh8yJyyE7mH7Sp2P27Dn3sdxltX6A9k4f7Dt6/?=
 =?us-ascii?Q?nvFpGlb1yGJ5a+IrXSmCvG4aLalPUAZLB+gxEmsbtWOBokJ9+ERheaRzZk9Z?=
 =?us-ascii?Q?XQtPBoKANcgENy1YJGZxQUJzGnQUxZWSSx5rdkMcrjEmtpp0fvcG6nmHazfb?=
 =?us-ascii?Q?6KaPqasJ4dSrStDEHcM/ZQPGpNd3TQ5l70pvDC3/Yj1B2cAZuyTy4kkCcTe+?=
 =?us-ascii?Q?hBwbhBzo47Lu9RkqSqfkCJajOQLIR4Bps/vHtH7bETgLRxFR50Q91pkgBpyP?=
 =?us-ascii?Q?+0GylDQNZ2UBEfo5rbuaTRaF6vklMyoctC9HxhfOCDUVWQiScmR8twx9fitx?=
 =?us-ascii?Q?5eBK1yyQws/sOuLzpYYdps2rnZMJGMBr7FqPnzzmiCpd?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7120d938-fb79-45af-ebbc-08dc56997e8b
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 00:27:23.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbYaw1kVWIHexVWyb8YSONdMROPU+NO7QDcAQlU0rY0xfLjQ/FM5qof0KlR4zM8bPoTki82dDo9RugVgX6IzQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1339

VGhlIHNlcmlhbCBjb3JlIGFscmVhZHkgY2hlY2tzIHRoZSBSUzQ4NSBSVFMgc2V0dGluZ3MgZm9y
IHNhbml0eSwgc28gcmVtb3ZlCnRoZSBzdXBlcmZsdW91cyBjaGVjayBpbiBzZXJpYWw4MjUwX2Vt
NDg1X2NvbmZpZygpLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlw
cG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYyB8
IDcgLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
ODI1MC84MjUwX3BvcnQuYwppbmRleCA4Y2EwNjFkM2JiYjkuLjg2YWI2OTI1NzM4YSAxMDA2NDQK
LS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMKKysrIGIvZHJpdmVycy90
dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMKQEAgLTYxNiwxMyArNjE2LDYgQEAgaW50IHNlcmlh
bDgyNTBfZW00ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlv
cyAqdGVybWlvcywKIHsKIAlzdHJ1Y3QgdWFydF84MjUwX3BvcnQgKnVwID0gdXBfdG9fdTgyNTBw
KHBvcnQpOwogCi0JLyogcGljayBzYW5lIHNldHRpbmdzIGlmIHRoZSB1c2VyIGhhc24ndCAqLwot
CWlmICghIShyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpID09Ci0JICAgICEh
KHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORCkpIHsKLQkJcnM0ODUtPmZs
YWdzIHw9IFNFUl9SUzQ4NV9SVFNfT05fU0VORDsKLQkJcnM0ODUtPmZsYWdzICY9IH5TRVJfUlM0
ODVfUlRTX0FGVEVSX1NFTkQ7Ci0JfQotCiAJLyoKIAkgKiBCb3RoIHNlcmlhbDgyNTBfZW00ODVf
aW5pdCgpIGFuZCBzZXJpYWw4MjUwX2VtNDg1X2Rlc3Ryb3koKQogCSAqIGFyZSBpZGVtcG90ZW50
LgotLSAKMi40My4yCgo=

