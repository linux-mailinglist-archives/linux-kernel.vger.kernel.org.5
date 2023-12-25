Return-Path: <linux-kernel+bounces-11016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F0F81E01A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57E21C217EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7EC51C5A;
	Mon, 25 Dec 2023 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="QNvQ8c4g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AF75102A;
	Mon, 25 Dec 2023 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpWz0EEmYtlUsz1NWSJoBt8BOBF5lH7rrpIH/2nFCdWLPnXjeW71uBixkaDNCxwCCwaw7vlcdhGeDRIGYhaxpdLTNidYWBkjyQK6PkMMHpFoTTRiQeHH6EHVTRCZVc3tHXBOzc1KH+fMSD9W9MEodBuKERYMwFWpMYlK0G85t745HJmJwlB0+QSbnk4ohve5FLVq5kbsPNd0k6WJaCdCVZT5wh/asaKLnl9JTrnJL3/0O6NhLyOokyROyKFXt9Yr4UQzizuj8xKBMBdSTXzENDjr12r82VbubY29gK4M7/SXr8G7XTJdbwNnRvpvWRdVOjqDn9DXF6LP3MXQ0lm0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TC+21YnKQMHFgAz2YduVy8ekn/I7Y9I8WDYbieztEk=;
 b=JItsaISwsdVODEf6M872IlrjPcyFwS0dJUvnG6GgiGJUAVfSbvfelxkFCpinBaHdRAVOYo+p6M80jpqAWbvqF+BDn7n2IsNfW8mvrf95WiZ8nkaIcmr4zpnWS60HNGYxcBhzwpdwQkU98XDBAYfAtTklmbJOw7ODia7+poy7ot1S2AclunN/0q02jQcFkoXOR+BNUHCEToNBQ3M4jdit2/YegmcXexJbrVVQab/bpQlmXfxufTIaSvgTx05jBt62meKwlepQ8oxRPuPoC+BYZCg84eds5uHJO7778PhWA20GXedBifieF5ZOtN1XW1E9oRUH2s68A1gCpbxNSV3F3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TC+21YnKQMHFgAz2YduVy8ekn/I7Y9I8WDYbieztEk=;
 b=QNvQ8c4gl8aCvMgaXIkLggINom/yZ0ohE72J1J0wcuFQqjf33T3rdZy8IAILZOBIAJYJMjyblrBOobEjWHr6T1hqEhRJCU9+G/H7fHlSlDiK8sgU2eHyr2H21KjOqHoAGzQEfpl6FbwSNvqGh7oUNZTQyT6KQxqGSXIDUjjKuwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2070.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 11:35:54 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 11:35:54 +0000
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
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	stable@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH v6 1/7] serial: Do not hold the port lock when setting rx-during-tx GPIO
Date: Mon, 25 Dec 2023 12:35:17 +0100
Message-ID: <20231225113524.8800-2-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225113524.8800-1-l.sanfilippo@kunbus.com>
References: <20231225113524.8800-1-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: 44124829-273c-4d47-2c69-08dc053da643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6jJfUYkdSoDse7HWl5mRa96dswVKDFkIfRdGILJs+YD1orEe5kETVepAbbwEBgwoWZUy4pmPbBy+ijgPWAECHzWeaEmYMP0wB+CdtYoOHereDyBb0QGzV6ZgXrAshtWRKCbAXlmcvsAonKc7AREfQ9mzAYZIZXVpdTYSBQhf0p9zNn9U0kbXmUHD7qVDHe6On77OsWMKAQ4WtVv97vFKxeZJNBA3lnEN0J8MSo0cSPqaFhVfAHN6LPMmV9jtEkUa7SWzQ/MxRPgqoEAhdAcIQoSzPGc3kn2jqjw04LsGlZbR6h7oj1I730NEw1F5GLY9SWacPtPm2ZcfYPxBrN06xIGRluxrl1codMqB3voAYYnEhlGSk6h6Jc5I8ydguwtHtA9GBdLOxAAvp4TuMTSeGFRWisrK3rbGiUx0572VkSL+ZLKPmH7GuuPS4wDC+iqPDRcfq+QkPx+1gsM4VyJtNNnjdSa5mrcLeXHirbvQ7FxfcFlCEI0CyhueEwy8tSy1ncE0KZqMfwaO4SYEz1IS/uZ2JQueEArelpA49QgEJRT3JvScES0XhuuuqtSNQhHm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39830400003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(86362001)(1076003)(2616005)(83380400001)(66574015)(38100700002)(41300700001)(36756003)(7416002)(5660300002)(478600001)(6486002)(2906002)(6666004)(8676002)(8936002)(66946007)(66476007)(66556008)(316002)(54906003)(4326008)(6506007)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0o5ekFsano0MlE1cERGWktpNzNiNzRKRnI3eHNDUGhPVjh0N3lxMkZvQzlv?=
 =?utf-8?B?clQ4Qk9md0Z3aTUxSktlWE56QllBQ1lHWklFbEdiRStlam9weG1kTmNhR3V0?=
 =?utf-8?B?Lys4RjR2WGdha3BJM1F5K2g1eWtHNHYxNjdJUUhpN2FnWkc0dVFBYU11OTRt?=
 =?utf-8?B?UzlXNzZURjEvSERzeElWbzZQTUkzN2RCcm51MGRBUlUvUDdRbXBYS0dxUy9E?=
 =?utf-8?B?Q091Rk1hWGh4Sm9PRVZqL3Bvem5NOFUxdUh4Yk5Yd1NCZGNXQ0hBRitlSlBj?=
 =?utf-8?B?VUlqZm4wTk5DVnF4cWloTG9nMWo4Z3p0dW92eVR4LzJIWEZZYzZjR09yZ2ZL?=
 =?utf-8?B?SFgzak52OXU5ZVQxK1F5RW9XZ1Q2TjJOeUI4eUV3U0IwZG9VSGJxVGp6cU8x?=
 =?utf-8?B?Q3FQbFQ4eDBEOHlmMzh0TlZ2RzAwemlKa1hvUTZsTWI2NWZCZWMxcE9NbDRo?=
 =?utf-8?B?Y2lkaEE4QTQyNUIyNk95M1FFMXBnb2N4WnY3ZS9tY1pDL3JiZ21ERlZjcC9R?=
 =?utf-8?B?QWE2UVJ1bnVkQzJDMFFJM0xFUW03ak15QWxnV29GRnU5R2lZYld1SUVoT0x6?=
 =?utf-8?B?c0Npd1Iyb3QxblJxZ3lwVm1vVFRDcDJOdW01YnlMRUFFbG9qdTRwZ28vaEFI?=
 =?utf-8?B?dkhZUGFhSW9XZjB6QytCTFRyM0hkclQzbmREWDFHbzZwWTVGdzBHU2l4Mmlu?=
 =?utf-8?B?WXJSbU9zbkErN3ZDQ3JWZ1NmY0svNjM3QUY1bVI3dTdxVytEM3FVMmcwQStP?=
 =?utf-8?B?Z1NIRVdiMUtId1FyYzJPaTRtdlIza21XTmFSazlDSEExK2dZYzFQUzQ5WmVr?=
 =?utf-8?B?OXhqR2RoOWcwbk9jamNvdi95U2lnQUh3WTk0ODk3SXl4UFZmYzEzNTdVRllt?=
 =?utf-8?B?VThyNkZDR2lhRzdDRUhXZ1k2WldZZUM4dnFPOVkxckxVS2RDMHNxQTQ4YVpz?=
 =?utf-8?B?KzgyYUE2ckpqdzF0RG0zTFpIaUlxWi9TOWpiTlliTmluVTdUZCtEMUpkM3BO?=
 =?utf-8?B?dkNpbUYwMWg0UGRudEcyU2JmaXBNVEJ6ZkxDWmJHTnEvVjlxMU5rRVlIQjlI?=
 =?utf-8?B?NlVFM0hwK1NpaW1oTVNoc2pGYzRVamtFUjI4enBWNEM3dUV4YUlKRmlKdzdw?=
 =?utf-8?B?ZkFqM3pCSnpVMDRIcWhkMkMybnNCbzh4Yk9vTVg4dWZNWFlac3oxVnhWLyt2?=
 =?utf-8?B?QmFLWXczcFhBN25kMGM3b0JKeitZVHhzN1Zqb1VKdy9UQ2hKbUdES2tSY0Z3?=
 =?utf-8?B?SldSb1JMT0dPclhrQjJuL1dFMlNLWi9MUlF6WC9wZTBuTE5xSzZqVlNzdkVD?=
 =?utf-8?B?QlkyS2hMUVhKZXNCZlhKak1SQXBhV3N1U3lLVjN5WUVzTE9MYVZ5cVo2MFJC?=
 =?utf-8?B?bWV5RW5iVnpqcHdyMHBkT05DUzkxaWRzYWRrMGp1Qi8rNk1kSFFESWdVUk5t?=
 =?utf-8?B?ajl2RlF6N2xOMGtvL0RBejVEWXpyS20rUDVVcUNnUXlRWmhJMUR1RS9KQkVG?=
 =?utf-8?B?YkV0TlFpcHFkbGJuM3M3RDF5NkJNNjFNb0R1aFJGSU5wZ2JTUjMweDZMbE44?=
 =?utf-8?B?S0kzaXVLTUxCTFg3ZWZZUEE1QzlMdWcwTlZ3N2V4aEp6ZXRVcEtZeXVKVEg1?=
 =?utf-8?B?K3AwUEpCMGpHRC9obnk0VTVJMWl1dUdqaEoweVpGZTg5OFdtSXYzUkwrazB6?=
 =?utf-8?B?QkFQKzMvcjVyWmIyOVJhb3ZNSXI0aFI3OWJKOGpCYXYzY2JURFpBOStuSmYy?=
 =?utf-8?B?Z3lUaU9RNHRQRDBISE9WYXgzQkVhWTltdnpMbVY1R2pFZE9VaGpTMFNFVzFm?=
 =?utf-8?B?N1pjSEsvU2h5Qm1lMWVDUDY1S0Ixb1IzSkg3WUR5RnRjOG1EdnBRUW1ZV1lr?=
 =?utf-8?B?VjN1dnVVdFFOL2lzb0lQZUZCYllWZVBhblFuRXBteUhIT2RacmllSVluTjNT?=
 =?utf-8?B?T3pKaGNaR0kyQXR6NXU2MFpJcWpZWkI0Z0VyYlhjRkJoVzkvQ2FWSmNWMkRp?=
 =?utf-8?B?cDBqWTBXaXNtSFVDWW1rL2xleDdzOWZON0UrUW1tZVNGUkJZOElPcU8wWWtt?=
 =?utf-8?B?RWRPdU9DSUZoZGpoc1FYZlU3RUlJcW1NVmJIWmkwNmlocUxtNFJPVERudkJa?=
 =?utf-8?B?cmtDUzBHTVFVaEVFanJtMy9McWVzNDhkS3ZXVWp4TE0vQzJ1Rk93T0R2OHhK?=
 =?utf-8?Q?US9hXy40hmH8MDZRc3mVVnwgTAmuSp7tt7KxbMvwKRaD?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44124829-273c-4d47-2c69-08dc053da643
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 11:35:52.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk5hTa9PCnqEfH4FDfetHkjhmJyFeeuN39dA3C2Zz5599yjxvsALmC8bsgofMEX5qYo2wmNWjqURSiujMxEdHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2070

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
Z2VyLmtlcm5lbC5vcmcKUmV2aWV3ZWQtYnk6IEh1Z28gVmlsbGVuZXV2ZSA8aHZpbGxlbmV1dmVA
ZGltb25vZmYuY29tPgpSZXZpZXdlZC1ieTogSWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5A
bGludXguaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmls
aXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyAgICAgICAgIHwg
IDQgLS0tLQogZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCAyNiArKysrKysrKysr
KysrKysrKysrKysrKystLQogZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMgfCAgNSAr
LS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9zZXJp
YWwvaW14LmMKaW5kZXggNzA4Yjk4NTJhNTc1Li45Y2ZmZWIyMzExMmIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvdHR5L3NlcmlhbC9pbXguYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKQEAg
LTE5NDMsMTAgKzE5NDMsNiBAQCBzdGF0aWMgaW50IGlteF91YXJ0X3JzNDg1X2NvbmZpZyhzdHJ1
Y3QgdWFydF9wb3J0ICpwb3J0LCBzdHJ1Y3Qga3Rlcm1pb3MgKnRlcm1pbwogCSAgICByczQ4NWNv
bmYtPmZsYWdzICYgU0VSX1JTNDg1X1JYX0RVUklOR19UWCkKIAkJaW14X3VhcnRfc3RhcnRfcngo
cG9ydCk7CiAKLQlpZiAocG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8pCi0JCWdwaW9kX3Nl
dF92YWx1ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbywKLQkJCQkJICEh
KHJzNDg1Y29uZi0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKSk7Ci0KIAlyZXR1cm4g
MDsKIH0KIApkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9k
cml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwppbmRleCBmMTM0OGE1MDk1NTIuLmQxNTUx
MzFmMjIxZCAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysr
IGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKQEAgLTE0MDIsNiArMTQwMiwxNiBA
QCBzdGF0aWMgdm9pZCB1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlvbihzdHJ1Y3QgdWFydF9wb3J0
ICpwb3J0LAogCQkJCSAhIShyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfVEVSTUlOQVRFX0JVUykp
OwogfQogCitzdGF0aWMgdm9pZCB1YXJ0X3NldF9yczQ4NV9yeF9kdXJpbmdfdHgoc3RydWN0IHVh
cnRfcG9ydCAqcG9ydCwKKwkJCQkJY29uc3Qgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUpCit7
CisJaWYgKCEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpKQorCQlyZXR1cm47CisK
KwlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8s
CisJCQkJICEhKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgpKTsKK30KKwog
c3RhdGljIGludCB1YXJ0X3JzNDg1X2NvbmZpZyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQogewog
CXN0cnVjdCBzZXJpYWxfcnM0ODUgKnJzNDg1ID0gJnBvcnQtPnJzNDg1OwpAQCAtMTQxMywxMiAr
MTQyMywxNyBAQCBzdGF0aWMgaW50IHVhcnRfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQg
KnBvcnQpCiAKIAl1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NShwb3J0LCByczQ4NSk7CiAJdWFy
dF9zZXRfcnM0ODVfdGVybWluYXRpb24ocG9ydCwgcnM0ODUpOworCXVhcnRfc2V0X3JzNDg1X3J4
X2R1cmluZ190eChwb3J0LCByczQ4NSk7CiAKIAl1YXJ0X3BvcnRfbG9ja19pcnFzYXZlKHBvcnQs
ICZmbGFncyk7CiAJcmV0ID0gcG9ydC0+cnM0ODVfY29uZmlnKHBvcnQsIE5VTEwsIHJzNDg1KTsK
IAl1YXJ0X3BvcnRfdW5sb2NrX2lycXJlc3RvcmUocG9ydCwgZmxhZ3MpOwotCWlmIChyZXQpCisJ
aWYgKHJldCkgewogCQltZW1zZXQocnM0ODUsIDAsIHNpemVvZigqcnM0ODUpKTsKKwkJLyogdW5z
ZXQgR1BJT3MgKi8KKwkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3Rlcm1f
Z3BpbywgMCk7CisJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV9yeF9kdXJp
bmdfdHhfZ3BpbywgMCk7CisJfQogCiAJcmV0dXJuIHJldDsKIH0KQEAgLTE0NTcsNiArMTQ3Miw3
IEBAIHN0YXRpYyBpbnQgdWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB0dHlfc3RydWN0ICp0
dHksIHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJCXJldHVybiByZXQ7CiAJdWFydF9zYW5pdGl6
ZV9zZXJpYWxfcnM0ODUocG9ydCwgJnJzNDg1KTsKIAl1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlv
bihwb3J0LCAmcnM0ODUpOworCXVhcnRfc2V0X3JzNDg1X3J4X2R1cmluZ190eChwb3J0LCAmcnM0
ODUpOwogCiAJdWFydF9wb3J0X2xvY2tfaXJxc2F2ZShwb3J0LCAmZmxhZ3MpOwogCXJldCA9IHBv
cnQtPnJzNDg1X2NvbmZpZyhwb3J0LCAmdHR5LT50ZXJtaW9zLCAmcnM0ODUpOwpAQCAtMTQ2OCw4
ICsxNDg0LDE0IEBAIHN0YXRpYyBpbnQgdWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB0dHlf
c3RydWN0ICp0dHksIHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJCQlwb3J0LT5vcHMtPnNldF9t
Y3RybChwb3J0LCBwb3J0LT5tY3RybCk7CiAJfQogCXVhcnRfcG9ydF91bmxvY2tfaXJxcmVzdG9y
ZShwb3J0LCBmbGFncyk7Ci0JaWYgKHJldCkKKwlpZiAocmV0KSB7CisJCS8qIHJlc3RvcmUgb2xk
IEdQSU8gc2V0dGluZ3MgKi8KKwkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1
X3Rlcm1fZ3BpbywKKwkJCSEhKHBvcnQtPnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X1RFUk1JTkFU
RV9CVVMpKTsKKwkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3J4X2R1cmlu
Z190eF9ncGlvLAorCQkJISEocG9ydC0+cnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5H
X1RYKSk7CiAJCXJldHVybiByZXQ7CisJfQogCiAJaWYgKGNvcHlfdG9fdXNlcihyczQ4NV91c2Vy
LCAmcG9ydC0+cnM0ODUsIHNpemVvZihwb3J0LT5yczQ4NSkpKQogCQlyZXR1cm4gLUVGQVVMVDsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jIGIvZHJpdmVycy90
dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMKaW5kZXggMzA0ODYyMDMxNWQ2Li5lYzlhNzJhNWJlYTkg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jCisrKyBiL2RyaXZl
cnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jCkBAIC0yMjYsMTAgKzIyNiw3IEBAIHN0YXRpYyBp
bnQgc3RtMzJfdXNhcnRfY29uZmlnX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVj
dCBrdGVybWlvcyAqdGVyCiAKIAlzdG0zMl91c2FydF9jbHJfYml0cyhwb3J0LCBvZnMtPmNyMSwg
QklUKGNmZy0+dWFydF9lbmFibGVfYml0KSk7CiAKLQlpZiAocG9ydC0+cnM0ODVfcnhfZHVyaW5n
X3R4X2dwaW8pCi0JCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV9yeF9kdXJp
bmdfdHhfZ3BpbywKLQkJCQkJICEhKHJzNDg1Y29uZi0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVS
SU5HX1RYKSk7Ci0JZWxzZQorCWlmICghcG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8pCiAJ
CXJzNDg1Y29uZi0+ZmxhZ3MgfD0gU0VSX1JTNDg1X1JYX0RVUklOR19UWDsKIAogCWlmIChyczQ4
NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpIHsKLS0gCjIuNDMuMAoK

