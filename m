Return-Path: <linux-kernel+bounces-11018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F54E81E01F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFAE1C21831
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06FA52F6B;
	Mon, 25 Dec 2023 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="Zye2U2YB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EAA51C4B;
	Mon, 25 Dec 2023 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rspezn2A+8+j/QoqsyDCeaBO3dukP5aLKQr2I+FMwBmT0oAe8y38N72c3nlhY2NkeolXQBZFHAI+daXjme8kKc3FCdtuFYdQWuGi8hU7XupKhov+rT9UDtYGxzSGf0zo4myNWSPTKe51woVqM+pJmC/2WKf3o3kkCIgSnrh6748bRkjV4zDdIsEjvl6rEgRUcIdkwd1V/svjFXJfTo+YSwNIOZ00MPpeTCS/ry6AY30TxITFBEDk/FIjkJewtoNdU4z8RkLjPap7YNszKSjuVLUw3jN0owcqExM8wPr2r99eF/mDEDbotZQnSsGlQwM8FCGd0MS5FnXF5i2kZ1ur4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFWJohsEz9g08kvn6dCzs+3MtoEumjqn9pcqLCvl7Zs=;
 b=meZbuyluaYnqTjU14MF8KdRCxg0R9RdJ/Rz63ILtmvbz4NDIPyzvlncrkUu+vmCW5g8wxKw7BzR+iPCUTztRVxDIX7L4xKL5LCOMJhCuIwgDGVATHTqufzRegqa7X8qGzYxk2GDXV6538grN/HHZcNKAxrPn1bSj1lHuCjf8Ekx8eb3UwEpA0u8SLta4D41E/BhpenrV25oXNectIEruAYZx/7/XV0imnx7NgJAMoOsOgs0qzoNkLxAXvxDeTdZNTez+R0Xx1vAOdE7YUXtovggvTSc+zVP7DvgUfc9oBDI2R8MvMpTTRo4FRbbJdoLSuMMUJSCi4ky6bQ6Cv3Pxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFWJohsEz9g08kvn6dCzs+3MtoEumjqn9pcqLCvl7Zs=;
 b=Zye2U2YBBjChYVlm17M97qWEoyzN7gKrbrx0IjRPoCzvsmBwObtrK0cyi9i5WQ9HgSqN68EEfy5Wkg7fNgfn/Z6bAkJOOIcyFwzKTrMVXY9Mj9Smjh45d5TcaIqgB+b8hYYAORjKRVzbHgc1z6c7LW3cZs8d57yacmmkqVqQKCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2070.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 11:35:52 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 11:35:51 +0000
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
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	LinoSanfilippo@gmx.de,
	lukas@wunner.de,
	p.rosenberger@kunbus.com,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v6 0/7] Fixes and improvements for RS485
Date: Mon, 25 Dec 2023 12:35:16 +0100
Message-ID: <20231225113524.8800-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR5P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|GV1P193MB2070:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9c6546-88a4-4237-6d82-08dc053da5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mbSr7W9ONtJXtp+X1aMRab9D6mDJYX3hF2o5tcYm5GiBcDAikdUlm6ON1k3BPvbiWW+yML5/Z8dzw/+e5fzRvZSvlfuv4+P/V9TgL0wG+XBz+WRhei4vn//HEJ77395h6CHKJW1j91gd4gKHsO1x3S7CZyMdLluhBP5szPlB2PjLSJmtBZOffAiKcsAsAsNehb97MIFQXZ91QG2Sun7WeBppQ7T1QITT4Pqo9aZ/FMfsZRs4nwCCM//MSH/3Eb05lZ1VXU4rBrPNOtfjFkUg7Lbb1CqX/2HAVOolsGfkOMC7etM0jsMmBkg5qtoZIFW33+fegpgTD7G/hJVXrGHS/dMQfoOKEO/wsnSrnjWlz1CokftYmlxLYm7l2q67+hx3wFrQmvlDNT/8w+dPlBKXXt9mBS5SaL7Bw0Hd1qAwovWwJSGESWVFhlzCry6o0m/1IVgHXvWwrdugMdJOYjfUvZSMXEZfLrxsGkFnloFtADaPLs2fa5lhJ/bj9psA4euWHYlxVwBa1omu8HzJCYdJDZAQOOhZgB2+xCmocj8JBuGc4IZ/wXerxJLx/3gLhLtf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39830400003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(86362001)(1076003)(107886003)(2616005)(83380400001)(38100700002)(41300700001)(36756003)(7416002)(5660300002)(478600001)(6486002)(2906002)(6666004)(8676002)(8936002)(66946007)(66476007)(66556008)(316002)(4326008)(6506007)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkR0Z3p1TGVlM3Z4SmtCTFltdzdTeXFXN3ZYdCtIN2lBaWtFcXJ0dVNGZkFJ?=
 =?utf-8?B?ZnlvNWlmeStpUDFsTzRwaW8zc3dVNnhpc1VPNVVkRXQrZTlGTktOSU5IMWo0?=
 =?utf-8?B?a2U0NE1NM3J0WlhKMUxwR21lanhHZ3lXV1Q3SElLMTRnMnFmOVQ3a0VJVzgr?=
 =?utf-8?B?aXRYN0pCazk0ZzJCTDN2WlVPRGdaZlIrazhXWVRibGw5TnVVYndXNGVpWU9x?=
 =?utf-8?B?azJOeS9VajgwZzhieEJsMmZuZldsajFxcHRTdHVwUjdhbE1XTysxazNnL0tO?=
 =?utf-8?B?MXJJbDBZYUxmVU5MMkVqeFpVYTdvRWZiVEEyeXNjeXFhOVpLVEtwR2VySERS?=
 =?utf-8?B?b1JTM2dsZ2pyejZxV21CZENIMEw1RFc2VS9qdFkrb1d0SkVsREZlWE1jUllP?=
 =?utf-8?B?Y0JSYS8rWk0rU2JqZE94OUhDYVNkMFVHWUpyRGdaTTQ0enVxUTBPYjdpMFhT?=
 =?utf-8?B?cUNVdXVCa2tvYzdjYWgvZlNCYUowSW5HaVNkSHZrcXhFVFdmSzZ0QWRlUU5U?=
 =?utf-8?B?U3U1bGxPNEZERzRFZ0FVQVpCYmhIbTVsT0F4Vkh0RU51UmhJazEzRjdTNVRi?=
 =?utf-8?B?b3lGVTZ5T3I2RGVPaGVhL0NLWEN1YjJNT3Z3ajZYWmNocmF6RjlSQm0yQy9j?=
 =?utf-8?B?c2k5djMxQjcxTnFRZUc4d2xuTUNUdHhvNEk0NjdjSDhIdTdrWXJpaGtPYW5I?=
 =?utf-8?B?Nm5oZmtXdThCNmFENS85VkxpSkxDbzgxTEpxSWI4cHlWQTJEM05kekh3SnJF?=
 =?utf-8?B?ZVZGdDFXTzdEbUFXbWV6REM0NTI4UkVMVkFhQzVkTkljZUFlbm9yVjlmVXQz?=
 =?utf-8?B?c29GRWUxUm55Z05EajM2K09BVG5HZkNxYUE0TTkyYmk4eGRFejk1RXNWSGFK?=
 =?utf-8?B?WXN0QXBlV0s3U2FqenptQTExVGJiZE1JdENZbnFIM0htaXZSZStOL3AvNmVi?=
 =?utf-8?B?RncwNnBabU5TY2MrWTFTR1JwNzM5aldicHFzUlIxcWZ6R0R1eGFOK254akRS?=
 =?utf-8?B?OVVlUGpJVDJiN3BKa3p6b2tZSVRhVEk4OVFQVGR0eW1sN3VaSy9jUjRkMnFr?=
 =?utf-8?B?YUJpR1VDcGlKOFBvd1NMamo2NnRrekRTcko3WEl0QW5jZzB1UlJ0TThQNmo2?=
 =?utf-8?B?NERtZytFb3Z3Wi9WL3BLNTBwcWNjOEZUUWVNNWJIbSswZStvVmY4MEpxaGNC?=
 =?utf-8?B?aUtIZEppYmlJdnhTNytqdFdJbUcwRENXaGFndmphSVNubCs3QjBCcnhkRDd1?=
 =?utf-8?B?TlRmejY2NUN0K2N6TXNpUmxPWktMZWY5eVJ6cGdFUDBLZlNzRGtSWXVCcDdl?=
 =?utf-8?B?ZjBIYnY5U0pZMHk2WFgvZXJBWTBTZ2Zwb2VyY3p5a2hLWlcvM2RWVWhxUGxI?=
 =?utf-8?B?RFE0OTg4YVVWOWdiZkhTUzhSY3V0MjJXQTlXZmlZQ2UyR0phaVM2cHhNVDZ1?=
 =?utf-8?B?cUNocm9rdjA5MDk1eUxmRkRwdTRUdFBPQk13bWl2VGtwcHQraTRRZXBhTnRR?=
 =?utf-8?B?SW52STFzWDNEakFtS2I1K1RaOWVFekc2S0RjUGYyRzhyVHNzNUpRUHVSNzFn?=
 =?utf-8?B?Mjlya1VTNE55bW5QVVBhLytaTmprZlVKZGxPdUVzUVoxMEY2THhDaGw4cCtM?=
 =?utf-8?B?UWZPTDRmNHNDdWVySVNOSEc4OGgwYkxVSEtvZkV0MUMvSFl4T2tXVll5UjM1?=
 =?utf-8?B?bnkwdjV4NlV5TDBjeW91QU92SytSL2g4WDZLOHMzTmYvNnNHbGhKNHNVUmtt?=
 =?utf-8?B?SlJUS3UvZTVIdTFXcktpcGt3MWdUZXZ5YzB3YVFBSDluc2w2cGw1ZmlGMjFO?=
 =?utf-8?B?L3hpaFEwZytoeGxiUll1Y0JtQVBIZ1dGVmtsUTBESlVyOUZobUZuSm5tSEFI?=
 =?utf-8?B?T21jbDNyRmdrSWxHS3lVWjdPbjRjcWFqWE1aT3BxYTBMVlJTdFcycWxlWkc4?=
 =?utf-8?B?UjMyZFhRV3RtR1cxTHZPMEkreDZ3dXVwS3NYdGUyNkFnem5ra2kzWHlGNkZN?=
 =?utf-8?B?MER5NTBMZGEwZHp0SVpxUnNVVXc4QTc4TEovaGc5S1VoTS9pbVphTFl5NThJ?=
 =?utf-8?B?aE54ZVJJQXk1Y25zUGx0NzFDR0NReWdlUm51UHB5YitHb1B1MGw4dk8rb3h5?=
 =?utf-8?B?SlBlMnd0bElEK2M2Z1BzUm9QTWk0UCtuWVpQQllROTVmc1laakNaVmYwaFJH?=
 =?utf-8?Q?x0y7wPYdOLnt52yWUoHEZRjBnPifsyqDAUnmF4RNnJuF?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9c6546-88a4-4237-6d82-08dc053da5c2
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 11:35:51.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2gfae/gO3g23Mau6LCTx80ZOjSCNnoIS5Z9HmKngrjVw/C1DOOtAQL0cZQBDy6AT+t6r1Kakc5m71QrnDmWxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2070

VGhlIGZvbGxvd2luZyBzZXJpZXMgaW5jbHVkZXMgc29tZSBmaXhlcyBhbmQgaW1wcm92ZW1lbnRz
IGFyb3VuZCBSUzQ4NSBpbgp0aGUgc2VyaWFsIGNvcmUgYW5kIFVBUlQgZHJpdmVyczoKClBhdGNo
IDE6IERvIG5vdCBob2xkIHRoZSBwb3J0IGxvY2sgd2hlbiBzZXR0aW5nIHJ4LWR1cmluZy10eCBH
UElPClBhdGNoIDI6IHNldCBtaXNzaW5nIHN1cHBvcnRlZCBmbGFnIGZvciBSWCBkdXJpbmcgVFgg
R1BJTwpQYXRjaCAzOiBmaXggc2FuaXRpemluZyBjaGVjayBmb3IgUlRTIHNldHRpbmdzClBhdGNo
IDQ6IG1ha2Ugc3VyZSBSUzQ4NSBpcyBjYW5ub3QgYmUgZW5hYmxlZCB3aGVuIGl0IGlzIG5vdCBz
dXBwb3J0ZWQKUGF0Y2ggNTogaW14OiBkbyBub3Qgc2V0IFJTNDg1IGVuYWJsZWQgaWYgaXQgaXMg
bm90IHN1cHBvcnRlZApQYXRjaCA2OiBvbWFwOiBkbyBub3Qgb3ZlcnJpZGUgc2V0dGluZ3MgZm9y
IHJzNDg1IHN1cHBvcnQKUGF0Y2ggNzogZXhhcjogc2V0IG1pc3NpbmcgUlM0ODUgc3VwcG9ydGVk
IGZsYWcKCkNoYW5nZXMgaW4gdjY6Ci0gcmVzdG9yZSBSUzQ4NSBHUElPIHNldHRpbmdzIGlmIHNl
dHRpbmcgcnM0ODUgY29uZmlndXJhdGlvbiBmYWlscwoocG9pbnRlZCBvdXQgYnkgSWxwbykKLSBk
cm9wIGNoYW5nZSBmb3IgdWFydF9nZXRfcnM0ODVfY29uZmlnKCkgCi0gcmVwaHJhc2UgYW5kIGNv
cnJlY3QgY29tbWl0IG1lc3NhZ2VzIChwb2ludGVkIG91dCBieSBJbHBvKQotIHJlbW92ZSB1bm5l
Y2Vzc2FyeSBzdHJ1Y3R1cmUgbnVsbGlmaWNhdGlvbiAoc3VnZ2VzdGVkIGJ5IElscG8pCi0gbW92
ZSBhbGwgUlM0ODUgdGFza3MgaW50byBvbmUgZnVuY3Rpb24gKHN1Z2dlc3RlZCBieSBJbHBvKQoK
Q2hhbmdlcyBpbiB2NToKCi0gZG8gbm90IGNvbWJpbmUgdGhlIGZ1bmN0aW9ucyB0aGF0IHNldCB0
aGUgUlM0ODQgR1BJT3MgKGFzIEh1Z28gb3JpZ2luYWxseQogIHN1Z2dlc3RlZCkKCkNoYW5nZXMg
aW4gdjQ6CgotIGFkZCBjb21tZW50IGZvciBmdW5jdGlvbiB1YXJ0X3NldF9yczQ4NV9ncGlvcyBh
ZnRlciBoaW50IGZyb20gSHVnbwotIGNvcnJlY3QgY29tbWl0IG1lc3NhZ2UgYXMgcG9pbnRlZCBv
dXQgYnkgSHVnbwotIHJlcGhyYXNlIGNvbW1pdCBtZXNzYWdlcwotIGFkZCBwYXRjaCA3IGFmdGVy
IGRpc2N1c3Npb24gd2l0aCBJbHBvCgpDaGFuZ2VzIGluIHYzCi0gRHJvcCBwYXRjaCAiR2V0IHJp
ZCBvZiB1c2VsZXNzIHdyYXBwZXIgcGwwMTFfZ2V0X3JzNDg1X21vZGUoKSIgYXMKICByZXF1ZXN0
ZWQgYnkgR3JlZwoKQ2hhbmdlcyBpbiB2MjoKLSBhZGQgbWlzc2luZyAnRml4ZXMnIHRhZ3MgYXMg
cmVxdWVzdGVkIGJ5IEdyZWcKLSBjb3JyZWN0ZWQgYSB0eXBvIGFzIHBvaW50ZWQgb3V0IGJ5IEh1
Z28KLSBmaXggaXNzdWUgaW4gaW14IGRyaXZlciBpbiB0aGUgc2VyaWFsIGNvcmUgYXMgc3VnZ2Vz
dGVkIGJ5IFV3ZQotIHBhcnRseSByZXBocmFzZSBzb21lIGNvbW1pdCBtZXNzYWdlcwotIGFkZCBw
YXRjaCA3CgoKTGlubyBTYW5maWxpcHBvICg3KToKICBzZXJpYWw6IERvIG5vdCBob2xkIHRoZSBw
b3J0IGxvY2sgd2hlbiBzZXR0aW5nIHJ4LWR1cmluZy10eCBHUElPCiAgc2VyaWFsOiBjb3JlOiBz
ZXQgbWlzc2luZyBzdXBwb3J0ZWQgZmxhZyBmb3IgUlggZHVyaW5nIFRYIEdQSU8KICBzZXJpYWw6
IGNvcmU6IGZpeCBzYW5pdGl6aW5nIGNoZWNrIGZvciBSVFMgc2V0dGluZ3MKICBzZXJpYWw6IGNv
cmU6IG1ha2Ugc3VyZSBSUzQ4NSBjYW5ub3QgYmUgZW5hYmxlZCB3aGVuIGl0IGlzIG5vdAogICAg
c3VwcG9ydGVkCiAgc2VyaWFsOiBjb3JlLCBpbXg6IGRvIG5vdCBzZXQgUlM0ODUgZW5hYmxlZCBp
ZiBpdCBpcyBub3Qgc3VwcG9ydGVkCiAgc2VyaWFsOiBvbWFwOiBkbyBub3Qgb3ZlcnJpZGUgc2V0
dGluZ3MgZm9yIFJTNDg1IHN1cHBvcnQKICBzZXJpYWw6IDgyNTBfZXhhcjogU2V0IG1pc3Npbmcg
cnM0ODVfc3VwcG9ydGVkIGZsYWcKCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2V4YXIu
YyB8ICA1ICsrLQogZHJpdmVycy90dHkvc2VyaWFsL2lteC5jICAgICAgICAgICAgfCAxMSAtLS0t
LS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jICAgIHwgMTMgKysrLS0tCiBkcml2
ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyAgICB8IDYxICsrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYyAgICB8ICA1ICstLQog
NSBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCAzNiBkZWxldGlvbnMoLSkKCgpiYXNl
LWNvbW1pdDogY2ViNmE2ZjAyM2ZkM2U4YjA3NzYxZWQ5MDAzNTJlZjU3NDAxMGJjYgotLSAKMi40
My4wCgo=

