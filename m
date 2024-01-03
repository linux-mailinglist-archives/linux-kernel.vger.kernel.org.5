Return-Path: <linux-kernel+bounces-15208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BB682285C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1CC1F23B29
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288291863E;
	Wed,  3 Jan 2024 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="Ca8VPXCR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2045.outbound.protection.outlook.com [40.107.13.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E621805F;
	Wed,  3 Jan 2024 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReUKFJOc8pdC2BrwrsbPflFcKyFRh+Wpq9fX+/ax8XoQp4M19foKlMaLvVj3n5RK0hhHwqcTf8HaOZOU3JXn8u6evNZ3iLptd5a+Kx/uO8PX8mYtexTImJvp45hMUEatioCSRutSoLQFPoxV0m3XO+pwVkhVksTms63p+GNWsSSNX29RvB9s3Mljbe6b9v2Pi1IBP4wUIUfORCFB7xF82oKRCGXzreg/pLyI0/EriEnE2Jad9D/S0RWJVh+I+GSrZcHxG027vqJ7H4IKGjS9TGx3U7q1lupYOZgD53FjNYjsweofX0Qui4lzMSYVF0ckM3gKxkPsp0+vbC+jBCrj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctoSUvaSE63QhX1RJ/Y+ZsAabtaxgzq3AnK1Gc9jmAU=;
 b=ZEP9dpNrckSUD6EFp3FDT/kpbI3oNke4Z3RkGGGuX/yMWxE2PU60CXw4EXTiHl0q/ATuGmubK8mRmw0qK8726kzzvfhrDTuYwWeeyqVNzSMFBFQzTXP9N2O9iPN3+oaRD1aZmwSRQAetZUnERAmP3seccfKam04zHrtG28yEbEvPAbqLKPzhajBgBMY7pcDNyi8E40PWt7UwGj+F1TSwPPh7JRhQU2eS9Pz9jrthGloiRNSGXQhHbl3AQ5ir9LfJQHGfqPRvluJEIkgeQlLSFMvEbrffN9x5u2d3F9MfzbB7j6l4FPLAwa0BYswpetNgZvdNqWiefxT2wyKpM2XgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctoSUvaSE63QhX1RJ/Y+ZsAabtaxgzq3AnK1Gc9jmAU=;
 b=Ca8VPXCRa7PQmXsd2VayhtfZGWVYNjyQY1gklE8qQcjjiCKPXlYxs4uRgX5b/u5aOgKgTmE6upoHtrX+EKNCLTMvX86kptqTex9CdT0en7G4MZhEnQPvsYongas6nPXYq8/pdc2veqILdjh5fr47u+wOmoGWXw4sftkKGSnfbPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2245.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:19:12 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:19:12 +0000
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
Subject: [PATCH v7 4/7] serial: core: make sure RS485 cannot be enabled when it is not supported
Date: Wed,  3 Jan 2024 07:18:15 +0100
Message-ID: <20240103061818.564-5-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103061818.564-1-l.sanfilippo@kunbus.com>
References: <20240103061818.564-1-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
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
X-MS-Office365-Filtering-Correlation-Id: cf558815-7adb-4749-d8e8-08dc0c23e6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GRht9JduYW7VypezqdPVybv0kO+0Mh2jH+U7904wTxlNudmDOeZJeyjTIpyDXGYUnfH76zPm/63sm6yET6phHquD9u6XGu8oHal6A9ELQuDtpRm3Fzvxaayg5YHL+NuJM9BnS271Ram+ly5LbKZtk6GNAS/NaQBwIeeSQuX8FvBFiD5+m1oE/NxQvl8BlI/lbH9Obhf66jUu3Rq1lDo8FxvQBEVNVs2ALRWR37IJZ+2yNH7TJ5+PNoYmtA6IDGsjKAE8t2Qh51RdkiomrFowUYPNKZlugSxJHlrdfzNle0ALdmJrBLG7ef4pFpNe2z0GjJZLGEAsl1vnYj/SstHr90wJ7zgOhLXC+QkQEje4Ur0v4ctvxcyyJ3jGDAwxttW0yqBJtCRV+ANyAE6og3zxmjyt4hcZNTHTOtcI90vAjXM81wk5pkYYJdb1Fbf/iVK1N1GkaSJasBoLNLu1UwZNJwfFbkkY13mxLPlQOSTnwxbZyerFTR9V8QX/Tsoxz0PLgDqH1CiN91JqxwpEwjC7LUxy0FVXHBNRlG+9n8BWcZJXcj2EtkFTGYqIjAhNJ7s0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39830400003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(66476007)(4326008)(478600001)(316002)(8936002)(8676002)(6486002)(83380400001)(6512007)(6506007)(52116002)(1076003)(2616005)(66574015)(7416002)(5660300002)(41300700001)(2906002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXNUazZCTXIxNUV6RC91d1ZXTWQ5OUhlVVdWNWFpSXM2TXQyWWNKZm0zVTZn?=
 =?utf-8?B?RkZCUTBsd0VQaVR6elZ5cWVKSHJIY1V3ck54ZlNMMXNIempnK1JsRVJxcFV4?=
 =?utf-8?B?L2JxVVdvR05udmVPQ1VqNksveS94U2VQdm5IZjRWTCtQMkZpOGVPcWJOMHUz?=
 =?utf-8?B?YStBM2F5MTd0c01WNUc0aHp2akpYVmlLMGpVbnpEYXkrQTdWMXRXNW5jZzM3?=
 =?utf-8?B?Nzl1QzAxbE16djBhQnZNN0s0QnhrYnppRTZDVUloZC9GU1RHc0E3aXdjVHZB?=
 =?utf-8?B?aWVyOHBwa1JhRnRtcGtJZlhxeGlwWUFnN2pzUk45U2tSTkhrTldKaElHOFBv?=
 =?utf-8?B?NWp5aUhJclk0bEswT0JrYVg0dEF5cjhqQk91Q3lMZy9uVWFoWTIzNTF4QWd5?=
 =?utf-8?B?ZHV4ZHR4YXNGaWplOC9SRjBjWGZ1OUVjTTZ2bjc4a2k5R3FXUEYwZzV2UERx?=
 =?utf-8?B?TkpNMGFFNlhjNnd3ZnRMVzZjTDBlOC9JcHcxQ09ReWhqRzBPVmV1anpaNVA4?=
 =?utf-8?B?WG5pNkRmWXRQbXk2NGpNWHZVZ0t4VWRRdUpFaVYyQUhHRi9KZkNoem1tdEZH?=
 =?utf-8?B?SFd6UzMrd05EV1gvWVRZRzBBSU5OWm1xcEZRWXBqMHRmRERHUHpxR1ovaXFB?=
 =?utf-8?B?TUs3MHQreUs0a0hoTXVtS0xReEdFNzQvSlNPUnJxUXlDSWk0ZDVBYlVIcG16?=
 =?utf-8?B?bG5EYWNSbnRVcUd4RkpnWVRpUzYxSE9DdXFIcFJwcmxVT3o5QXZSY2ROa0tJ?=
 =?utf-8?B?RHJya0lBemlCb0xmMHZ2SWh0RHlJUllKSjZlZXMvZE8xRDRxV3FGVTRVUk1R?=
 =?utf-8?B?Vm5VMU40RWpkRnVNMEdaandKK3lrbXhNZE4wN0VzK054QmhGc2NHc0tTUEVm?=
 =?utf-8?B?S2VHbXZnY1FVTkVmMy9vMGljVHVLTU5iWU5lUXJyUXJEMHVhOVNSb1AxZzZ1?=
 =?utf-8?B?VXhLYm5QTmVsbEo0OWZCb3B4VUk0ejF0RzNSbjNYRG5BYU9tdzR4RWdEY0J3?=
 =?utf-8?B?emphTDdGT2taNHVTZUdWZGE1R1FWMk1PQTlpSiswM2VMTWR1VmR3R3J0WkRE?=
 =?utf-8?B?Q0lFMU00VzNFdkxlM29mcWwyMGEyNlFHMTE1SVVjZzIzeWI3UTY2UENBa0lr?=
 =?utf-8?B?algxby9xNkZjNW9wZ244aFFkenNzK2ltMVdidkpKSGF1RzBUdmJHNUp4ZkI0?=
 =?utf-8?B?ZVJZOVBTc2xEUmY5Y1o0N0JjWVJ1RThEYTVDZW1EdGhOcmt0SUhVbFdyQWpq?=
 =?utf-8?B?NlhUSHJxZlR2SE9DYXgrWDI5enZmSlc3b1laZjcrdE8ydFZvdXoxekpqQ09N?=
 =?utf-8?B?cVMxTzlBN0trVlkzNFZKaHBtLy9saEdNek9GZDB1R3FqQkhhRTRhNFV4NjJG?=
 =?utf-8?B?SUIzMmJrL2VubzJ2VkZKZm9TODg4bVFXaVFSaFEwOS9KR3p3ZG5KSlBxSVRF?=
 =?utf-8?B?ZE5QcWs0YjhxSSthWGZuSzZiT1kvUC85NWc2MzBkbFRMc3hwVnlDU0R0dHdU?=
 =?utf-8?B?YUY1ZXBJd2plM0EyYWdqM1h5OVV0dGVacXpTRzJDK3NBZVJOUlBJbG9wOUVF?=
 =?utf-8?B?V2FBU3VqQllyRExleStWUW9Yc2tvT21aN2VvNUdjNUQydys1anpCd2UrWFkr?=
 =?utf-8?B?Tm5nMFMrSnpUQ3Z6VXE1Qlg3U1pGYi9zdlVlWXRRSkpSR1FaWnYyVFRiM3Bs?=
 =?utf-8?B?K3lxNElnL0ZPaEZEUjYreFg1UVF5VlhoWXBNMFlXRldiT2U0Zjlmb3VjUDA5?=
 =?utf-8?B?T2R6TGl6QjlaQ203Q3Z4dCs0OWdiKy9zd21laURIbE9VK0RSZit0UmFYT1pH?=
 =?utf-8?B?RkRadDZhNm5ncTFpbFMrdzNZZ21wMjU1ZUgweVJVREcxODZPZzQyWjNvSk1r?=
 =?utf-8?B?RVN3amNRaGVEMGk0ODhZSEFGSjdjY3d3ZFpHUDdMZERCaUdtQjBhamlZODN4?=
 =?utf-8?B?cEZYNHNQTUdkV2UyTytsaTN2cXNVOUlpblVlU3BPRXIvczBsSUVHNG51MHRz?=
 =?utf-8?B?cjdKZThUN1NORG9MbXJpOG9CVExHd2xzVGdXVjlPODNKMG83SytBdC85ejdv?=
 =?utf-8?B?VnVQZkFDNFlVQjNwZmFwTE9XWFFmWnZ6OExRcGxjNVVJeGJvaE5FYjNMR3pL?=
 =?utf-8?B?aEN4Mit3Y3ZGRnhNSG1Ia3dmQzlNSTF6eC94UEVVdHNYYlVFNTlXdEFneHRF?=
 =?utf-8?B?bEhaaUxRZlBkOTkrVnFFeHdOWmlhVVU3TXNoT1IvbjJEOHE5VGxXZVZoODZl?=
 =?utf-8?B?QXUxOUo2ay9tVGY1QTBTblNLTURBPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf558815-7adb-4749-d8e8-08dc0c23e6fe
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 06:19:12.0145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6lpGXtb5wpnRlmfl65T9cl789+8p2JTTJbTkkK1LvitBt5vkjurjW4pkOxa5rC4XDZ2Rvi+izbsMmFZTJsGUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2245

U29tZSB1YXJ0IGRyaXZlcnMgc3BlY2lmeSBhIHJzNDg1X2NvbmZpZygpIGZ1bmN0aW9uIGFuZCB0
aGVuIGRlY2lkZSBsYXRlcgp0byBkaXNhYmxlIFJTNDg1IHN1cHBvcnQgZm9yIHNvbWUgcmVhc29u
IChlLmcuIGlteCBhbmQgYXI5MzMpLgoKSW4gdGhlc2UgY2FzZXMgdXNlcnNwYWNlIG1heSBiZSBh
YmxlIHRvIGFjdGl2YXRlIFJTNDg1IHZpYSBUSU9DU1JTNDg1Cm5ldmVydGhlbGVzcywgc2luY2Ug
aW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgYW4gZXhpc3RpbmcgcnM0ODVfY29uZmlnKCkKZnVu
Y3Rpb24gaW5kaWNhdGVzIHRoYXQgUlM0ODUgaXMgc3VwcG9ydGVkLgoKTWFrZSBzdXJlIHRoYXQg
dGhpcyBpcyBub3QgbG9uZ2VyIHBvc3NpYmxlIGJ5IGNoZWNraW5nIHRoZSB1YXJ0cwpyczQ4NV9z
dXBwb3J0ZWQuZmxhZ3MgaW5zdGVhZCBhbmQgYmFpbGluZyBvdXQgaWYgU0VSX1JTNDg1X0VOQUJM
RUQgaXMgbm90CnNldC4KCkZ1cnRoZXJtb3JlIGluc3RlYWQgb2YgcmV0dXJuaW5nIGFuIGVtcHR5
IHN0cnVjdHVyZSByZXR1cm4gLUVOT1RUWSBpZiB0aGUKUlM0ODUgY29uZmlndXJhdGlvbiBpcyBy
ZXF1ZXN0ZWQgdmlhIFRJT0NHUlM0ODUgYnV0IFJTNDg1IGlzIG5vdCBzdXBwb3J0ZWQuClRoaXMg
aGFzIGEgc21hbGwgaW1wYWN0IG9uIHVzZXJzcGFjZSB2aXNpYmlsaXR5IGJ1dCBpdCBpcyBjb25z
aXN0ZW50IHdpdGgKdGhlIC1FTk9UVFkgZXJyb3IgZm9yIFRJT0NHUlM0ODUuCgpGaXhlczogZTg0
OTE0NWUxZmRkICgic2VyaWFsOiBhcjkzM3g6IEZpbGwgaW4gcnM0ODVfc3VwcG9ydGVkIikKRml4
ZXM6IDU1ZTE4YzZiNmQ0MiAoInNlcmlhbDogaW14OiBSZW1vdmUgc2VyaWFsX3JzNDg1IHNhbml0
aXphdGlvbiIpCkNjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+CkNjOiBTYXNjaGEg
SGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ClJldmlld2VkLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5j
b20+ClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5j
b20+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxf
Y29yZS5jCmluZGV4IGY2N2ZiNmEwNDk4My4uMjhiY2JjNjg2YzY3IDEwMDY0NAotLS0gYS9kcml2
ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2Vy
aWFsX2NvcmUuYwpAQCAtMTQ2OSw3ICsxNDY5LDcgQEAgc3RhdGljIGludCB1YXJ0X3NldF9yczQ4
NV9jb25maWcoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSwgc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwK
IAlpbnQgcmV0OwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKLQlpZiAoIXBvcnQtPnJzNDg1X2Nv
bmZpZykKKwlpZiAoIShwb3J0LT5yczQ4NV9zdXBwb3J0ZWQuZmxhZ3MgJiBTRVJfUlM0ODVfRU5B
QkxFRCkpCiAJCXJldHVybiAtRU5PVFRZOwogCiAJaWYgKGNvcHlfZnJvbV91c2VyKCZyczQ4NSwg
cnM0ODVfdXNlciwgc2l6ZW9mKCpyczQ4NV91c2VyKSkpCi0tIAoyLjQzLjAKCg==

