Return-Path: <linux-kernel+bounces-17910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFD48254F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751082842C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580692E85A;
	Fri,  5 Jan 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="hskFSoS1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC92E418;
	Fri,  5 Jan 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIu4ZLUlgMNtn20eAZqPvn9CUZOQvENTPh1uw5WWnG1SKFO65kubymgB1ukY2u8Yl20W3bL6VSy1dqSj4xlB/Joiy7lgJaZ3Q/kjn18zlCtl9g70IqYpxf9FM3enonPd1e0NfuU0JZibdRJ85H7TEwl+C8YlLvpNwj2bHLtxfPZyu4VqNz/KHgV8wUQQM47xwuiB9ULp5HfKYl0/Q/ZSFGAUEQWsRRq5eEw0nzj85nrAIEy5VdN2rJ4h1BWXAHLsCFNyUOWQEw09ugbMh6NulcF3A5H3EQvhYU8lS2hasiKRZzhy/2lkyaXwTLr2COv42Ptd5wC51fZRq1M5vDaH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctoSUvaSE63QhX1RJ/Y+ZsAabtaxgzq3AnK1Gc9jmAU=;
 b=WY9Utj8zaphMFYCcf9xvn53oVr/J7X9+LgpvPc/jERx+WrT5FXnDGHG174FkGT1/Z3Al2IjfV20Awk0ACpeJOI4xbVabR4EdRF/cPj9vxkEUNsFPhgI80qfLz6fTIBkueumLFZj0FAd6pynVxkUP21O0nF9JgwvBMT4OD+s1FZOhDxKMsEa/KBIeMJrmNwX/c9P6KveyLztLZEl8k3k+fl78+xQwna0tEO3bUQFeS5CILGWfbeiMewPguscQ7ZjpVrQ0g9q2oIJ7BEIemcvYiF9ykf3waiyhAjPMCWF4V/uryatnjTN/b3F4kqJI0eo1FEY+gTPk13d2MzrD3TZkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctoSUvaSE63QhX1RJ/Y+ZsAabtaxgzq3AnK1Gc9jmAU=;
 b=hskFSoS1sKRoH3JrGD/NrtLM8rNenRjt2qXlsaHxJphpNeJNjN+lhToeGCUMK6SEnEO4HRw8VU42l1p54GwlXfmz3k6kd2VdNR/vDhv7GXnjVZ0bhSXbSwwKIv6BO4nvJqT7gDB6y90FPj9lN6VVP1p4BofVlA2u9svbHMp+Gn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM9P193MB1538.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:12:14 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:12:14 +0000
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
Subject: [PATCH v8 4/7] serial: core: make sure RS485 cannot be enabled when it is not supported
Date: Fri,  5 Jan 2024 15:11:50 +0100
Message-ID: <20240105141153.19249-5-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105141153.19249-1-l.sanfilippo@kunbus.com>
References: <20240105141153.19249-1-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
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
X-MS-Office365-Filtering-Correlation-Id: 9996ae0f-1580-44d8-c3de-08dc0df85137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hqOxhL61v9xa51MrUBdeVXgbNudvQcPF0xAoNNw4aeuhMwCLAlryMOJRWkVJcVWmuJZ3PA1EoGfy8Gnln8zFSJbe91K2pf3XQGbhtAlXs5gTaVfJq82Rx85FcxQxRF7KnOtWX5PPI3zGrotYEVdTemcRM7x6yYCHqfpVhwm0sE7NH8u95HDBxpJ73+nZSR2VpZ6YV1dIPZw5VQPepPoD0ITn2WMehD5hTt3EYXTiMQVRTu0ajfFPE5DOn4FBelI7pekQHqTd1GOWVv7iNZFkT7+fRej0mUKsZtbYmDGToY6jGiCck/wKzBBCoz21hvZugxDvp2wP12E9U/DIWldEb9t8TCWYcR9QoCsEcgaiGk2WOyfCHcZoK9CSBq/MRat+TXxiESIPtbWGKDOTCGX546iHWigqyqqrp9h99HjSyDXdvrCRkMAjpyPc7N0TTYab0r0yIQcyqWRLoYwpmlquheBsoUZPxzpxKhlVdn6Hb1xyzmgoJquTOPMikpB4NMJoax3U+QQ6BSVmufNDq1whI+RRWZKzoI3LD4jbpKY0MsCdYBkoGzZ8+KAhAFjmDtIY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(52116002)(6512007)(478600001)(6506007)(66946007)(66556008)(86362001)(66476007)(6486002)(83380400001)(38100700002)(66574015)(2906002)(6666004)(2616005)(1076003)(7416002)(4326008)(5660300002)(41300700001)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkdVaGY3dHU2SHE1Nnlhd1NRNVhabDZNZlhBZWZTcGFtVmpWYTIxUWFJZVQw?=
 =?utf-8?B?TXBrMUYzWXN6dm9HbkQ5U1BNV1RaUDlFZXY5dGlVVUxZOFl4MEhKZ3dXQkl5?=
 =?utf-8?B?ZWJVNHd2czNVUkF3UnBoL2Z4VTMyTTNVT1hzTnBxZkd6T2hvZVR1SVlzNkcv?=
 =?utf-8?B?Y0dQSExpOVJUdklBaC9xY09wWTlOc1B1bW1jYlFuMCsvczVZc1FXMkhrcS9U?=
 =?utf-8?B?YjRTWEVBdHl0Y1p6OStaWTRvdnRpZkh4Z1Nmczh3ejV4dWREanlDT3F5cTBH?=
 =?utf-8?B?M0c4dHJ0T3N6bCtwbUlBOGJDbUtOSUZveWpDQ2s0WDRyTXExODNGcUpUNElT?=
 =?utf-8?B?UXEwcEZCV2U1bERCbFJzbGRqT3ZaeGI3K0IzSlA1anVNZ3hyMTltUjBudFBJ?=
 =?utf-8?B?cVcvVFU3bkljaWhsTnpQK0Q4MFQ0U04vcHVmMUZUSzdsbHpDSklUOVNBVHVm?=
 =?utf-8?B?QWpQeWVLZEhqcVdmUU5pZy82bFIrOThyT2ptT3Nqc09VbWthQVNpTGY5eUFW?=
 =?utf-8?B?V0RSU0JscGkyZWM1Ukc0K0hqRkpSbnN0SVFpb0NrRW5kcllxUnpRWWRDSXEx?=
 =?utf-8?B?TGtwRFpnaElsOUZHeG1wZ3k0aUhoWm40bThTb1FEY0xRRlFTUDFKQ0JNRVdS?=
 =?utf-8?B?bEZFa01kS2FEaDRpenJ5bFdNVHFLS1hrQkVnVmg3Ri9DejBxVkJSb1o3ZUha?=
 =?utf-8?B?b0NEbERNbllUTHNjMzIzam5iWjFPUEJZQWVyd0tuTlJueWE2bnNMQ04wNkdJ?=
 =?utf-8?B?NkgxNDBRTldtc2xXMnN4MG1wMTJJckZhdldMOVhMNDBtQnZqWFZ4OHhOQ2ZB?=
 =?utf-8?B?ZDZZcGFIaS9vQWJRYlpHZFZab2x5ZWxlUHFzdW5oSy9vL2ZvZ1AwS05SZysw?=
 =?utf-8?B?dDVTRjV5ZE0wQWRxL2UwbnZpRE03eTBpbXVVVDFjTXNGR3RQbmIrbDZ4OFU5?=
 =?utf-8?B?OG41aWpxT0tRVlM2SjROeTJ4bEM3L2VBalN2OE9xZVBkZ2xXZmxIUXJpSlJK?=
 =?utf-8?B?RldvQWlyRzVjYW9QWksrZW0yMGZQNERzYWM4d0hKV2tEMnJLeUFNM2ZzdXRP?=
 =?utf-8?B?bHBmd2hQZUFXU1h0VVZDb1FFTlczOHZkV2kxNWRrQkppMmp0T0RwbVE0UGlY?=
 =?utf-8?B?RkhSRzNvdkxFTE5BK25BTHdlWnF6SW14cXZ1MGJZTkpuR0l5NVMzSjZPT2N4?=
 =?utf-8?B?ZWgwMjg1a0hEV1lNdXNyRkR3ZFJKYnBqOUNQemYvd2Y0U09MZjJhNFJZd2FB?=
 =?utf-8?B?NmNZSVc5bDJIVk5iajljSFBsd2hQOW5NUE14Z0ZWa0pGQ3VsYnhwdU9uZGpU?=
 =?utf-8?B?YU5QYXB4bXJwWWs0d0JjdVBxVmo2RGFTTkdWTWZUTUttZHJWUWM2ZjRkMDJO?=
 =?utf-8?B?TS96eGRIUnhBSkFteUtXZ0JsT1kyVWxIR0lDQjVsY1lTeUJ5bDdEVlovTHRJ?=
 =?utf-8?B?N3hCNFBXUkRoRUJkZGh4bTJjUDIwZ2xTa2dEbzFiZ1FYNHFaQkV0NERnZVdo?=
 =?utf-8?B?aFhxYUR0eUVoZG5JTFNOa2ZxTnoxM2VSOTA0TXZwc2U2aUhRRlpiYUNNaTdV?=
 =?utf-8?B?RlJoRHlDTDJCZFljN0pETUhBQUpKNkVtbjd5UlNJT1RpMXpMU2dnSXV6NDlG?=
 =?utf-8?B?TDBHcEFoSForTEVsVStVZnFRMW9DRWRPTjZNOVhtbENpR1EzLzdVNHVsVllJ?=
 =?utf-8?B?TEorTHdtUzBmbVY4MDhORXphWm1IK0FEd09wOWR3WVZCbElmRmlqbERTVzI2?=
 =?utf-8?B?Q2ZpcmZVdmU5WkoyR29yRmxrSllGSXY4NGk0b0FmREQ5Rnp2M3l4bnZqU3FF?=
 =?utf-8?B?Y1BxQ2dkKzlHci9YZ2xmdWtpZldpbk43a2ErVWJYdHVZQVJCc1lld2F4dEto?=
 =?utf-8?B?MzI2Q0RwOHVpbk1aK244MWdPc2xnbmh2eE95V3IxMVNkd0xLUzFIWWRhcW4z?=
 =?utf-8?B?d01QalEyM2tUN0hrWHArZmNhcElvWUsrOTczZzdScFh1VEFGQ2ZNM0xwSklJ?=
 =?utf-8?B?YzRtd3puSmY5SzFaQjJZdTJjMk8ydi9nSk5YWjBIczVRaGc3U1FrT3l5M1ho?=
 =?utf-8?B?TGJ1MWNvTFpKYVp6cXZMSzhTdENWU2VtdUlxaVFCbitreVdQQUo0QzhFeHlY?=
 =?utf-8?B?R2hQVE43bmRmWEhKZFlZWThLbDZTM2FXbjJYNnUydE5nM2tZVFU3d1RPMTEv?=
 =?utf-8?B?ZHlZcytaMEliUG42NThndWdPenlnTmJ6NklHamt3c1F4WHhyWXg2anZCL2di?=
 =?utf-8?B?UkgzaEh3Rkg3VThKcTRDWUlDQU93PT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9996ae0f-1580-44d8-c3de-08dc0df85137
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:12:14.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OMxQ1nk6vEfxu5K6lxlHNDF5KU9o0R2FBKnjca4OFlRdjMIV5qs8LSjgPH4Qt4nhZTlOQymbd18bwiUas3W6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1538

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

