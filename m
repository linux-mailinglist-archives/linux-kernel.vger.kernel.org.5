Return-Path: <linux-kernel+bounces-11017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFCF81E01E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC161C2185A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ACE524D4;
	Mon, 25 Dec 2023 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="w1ji+nWt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1F51C27;
	Mon, 25 Dec 2023 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uhgamo/qxh7U4Z+LczJ/SqVEWiWKp9PVxnvh7Bc8QErvHM/KD8X3PvpisX5PMntWfhiP1sG9yrEDnC3IHPc5Q7HgxywAeiY5Wwd3LFv6uuSf9ATLeVkKEg2cAawW6GasbB/ibJlOrHUJLwaUZE8NqxW+XCYFg6XiXwPqgvg7aAlE/9tNS5m5uhkLj/RZqOY++WSTlfV01DNTYjt/sA5IHzJj4d4iEk/1yDN1XMuRTwparwXmzQG37Hb1qv5juE1gnRSAskXvjxK37zWcjhRT6Zyvk5x+M9cmiGuaEaiFRjQ/D9s/KiHUsFUUhBZPp+hzxs1q8f3GOlQT0KEXtcpNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctoSUvaSE63QhX1RJ/Y+ZsAabtaxgzq3AnK1Gc9jmAU=;
 b=YEMr8QeaKZGTm8HbQlXVpdmzDBiXpH17KgOg5cBBGk0rBC6pEoBo0kSY8d8Gt0id4+MQvWMQiAE9qTK3Zq7EDB3MijfRSEfXIByCxZUfXwvy/ti4cK382w4iFdv2hPkHRa6FNtF/jcdhIBZQi7u9l7BkTcdofTI388g6HSktP3R3+xHUBEU/ym1JB2Iz/dKMl2ksupEFHTK4BzqQSvpqhSmO9bPIoPcadjUBWN90bZn4kwkjvXOiZLLbZmbjZtz7Y70D4k8QX6V38pjfAQKerPVgL4bsA/75302NW6KlQ/55oxsL7283ozp4+fdIjPV2BF3K8xiITm/+o5BOWLBcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctoSUvaSE63QhX1RJ/Y+ZsAabtaxgzq3AnK1Gc9jmAU=;
 b=w1ji+nWtf5OJqGPjcOFRHCeTrVoPQ3mBx+y4OXM7oA0O5Ufk82I4g3cXqBuRACBN7DVPcUqjsRZ6pZrfDIobGGhksKh95DMDw7x3q1BXmRmK+3mKTS0MBxem6ULkoZ5dn9lct5YIXXDeb5ucQpIOx8SB04yKqgaQRvy0Qy3P5CM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB2061.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 11:35:55 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 11:35:55 +0000
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
	stable@vger.kernel.org
Subject: [PATCH v6 4/7] serial: core: make sure RS485 cannot be enabled when it is not supported
Date: Mon, 25 Dec 2023 12:35:20 +0100
Message-ID: <20231225113524.8800-5-l.sanfilippo@kunbus.com>
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
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB2061:EE_
X-MS-Office365-Filtering-Correlation-Id: 25892f0c-64d6-4563-bcbf-08dc053da757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dYRxqpEKapPguGhfz1jXmu2nZjVbz12ASsRhsva6mrhAblV5eZuvhRaB2wZ2B5sipOUJh0czw0Do8NVfAKDpJu71fB2qrJkjb7ypxUtcyMARfL2Vo7q0NFFifIhMmFEcTKqM+3uva2x8mDJjQNJuhh43zch4mj25s9VYZRYfUBIm5Kyb3wnJ6tuU31xXg89gaFX8K0/E8LUatxU/U6QfUMvew6is7hSw9SQH15coGbdpiAPKmsms+p5fxq3Vd8x3A3OIcfZpKLOok45NrNGmMdSNvjwAHJNAektupX9sx7l6B7yUfTG9DApfUEwUhVnkCtYC67DDTDfb3z+SwAjFwY2i4gvWGu4SoOhD1Z7Q8G2tkOMBgQMidrK/RFLnUBH0qUozGmRTvdsBS8M5CpHbzP5GrxtzInQW5fp8W80hgqd16uGew4i3R2EDdhKNinvG5U5MZTHzdmV+zBdz6yn9X5t7kCcWucpF5CVpHqySDF1s3ptQ7FfhsYU2RKsbwEFSnvhP+gvEqm1TD7bAHGV6/Qsg55k/btrfuZJ6ksr4NEeShvbCMjEyFYNlWSPR1WCv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(366004)(346002)(136003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(6666004)(6486002)(478600001)(2906002)(8676002)(8936002)(5660300002)(36756003)(7416002)(52116002)(6512007)(6506007)(66556008)(66476007)(4326008)(66946007)(316002)(66574015)(83380400001)(86362001)(1076003)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnErbFRqdU1ybC8wRVJQbVNpUVhEYStvNkpqWFo2M0VRc3daa004WXRXSkJt?=
 =?utf-8?B?dS93U3h3K1RlNEMwcEhIeUZieXFIWWNQdElRckVPaTczZnZXSGRBV3NWTlR0?=
 =?utf-8?B?ckFGMVAyZVNrcUJpWUZmNStxdjNWK201M0FWZENNNEt2djBHTEJLeTh4ZnB3?=
 =?utf-8?B?UHZjaUMvOG9KOEtVb3MwNTY3UCtteCtOK2s2cjNwUmtBT0p3Vjh5R080NDUy?=
 =?utf-8?B?VGNMWi8rTVpSL0Z5RHIwWk92ZktFcVVMcnhXV0graG56SlJGR0dib3k0RlZ4?=
 =?utf-8?B?eE81eVY3L21DZkRyMERPVUxrRmtJbE1tTnc5NkJKZEkxcUlQSmttWXlJdE1a?=
 =?utf-8?B?RkN5UHh5MDRDWStiaXJxS3IzUGNsU3dsZUhjR1VpWWwvclhYSFNXem8zSDVo?=
 =?utf-8?B?aHg4TUFjcUpKamphMERySGxDa2lvYTBmbHBRd0JwekFLVno3Vk1LTHRuV01z?=
 =?utf-8?B?ckVobXRIT0lHTEFOWWFIZEQyYXp5N2FvTUwvVW1TTm1YWDRlR1c1Nm4wbGlZ?=
 =?utf-8?B?Nm1RN1hsK0hEcnRuSEQ1R1FnaFRSL3VyaXNGWUFpcUFvQnhaRHlZVUFSRnZZ?=
 =?utf-8?B?RlpwU1hZbGd5U2YwckM2dEo0M2dJZHpMQXFxTWZ1K3VINXdkZEQ4dVZWbTNv?=
 =?utf-8?B?TmlKaG04ZjVjemFjTnlzaVJBQ1o2NVlCVFY3UUdtTTlPWllWVXQ3TXlMSXdi?=
 =?utf-8?B?MW80UmIyZDZJeHAvYVV1ZmNOTGJKcWkwR2IxZ1l1V1NWTXBHdUdLbjJ5eFUy?=
 =?utf-8?B?QzFOdFUvVStKOTF6dDNjTW56WVFqMXdqOWlha0JJeTczSUJlZUVYNDVCZzBw?=
 =?utf-8?B?THJYSHY2cWQ4cjNHSW9DUTZFTXRXeWdkeWlyMHBVOVFzcStRWkhrM2c0WGFX?=
 =?utf-8?B?aEpXZzJ5R2N1R01XdUNWUlhkaEI1aXRzZ2c1UWRtb2lYYjl5aDFtRUR1Qkc3?=
 =?utf-8?B?NDRRWkxTSGl3bXZqbmtmeERabmRrR0VBcUh1MGYvWGlLRUFpVDBTcmw1dHp4?=
 =?utf-8?B?S0ZBM040Y0FqRDhMNFlIT0VucjJ6a2UzWU5lbGpUc1MrNWRGWHhnOHNyM0Er?=
 =?utf-8?B?aHB2dDVKSGE0ZVJIeERTaVdEUGhFcFdML1E0YkNzQkRGN3VhM2V6eWdnSE16?=
 =?utf-8?B?ekN3ZkRWTjE4YTAyL2xJa24rM1dSVmFpQk1xRVp1N1NaQXJabm1YVEdhRGEz?=
 =?utf-8?B?dkdzNTEvUTZUQm52SHl4dzhKREZsdTg0VVR2bXJveEluNW5GUHFVRDlyQWZr?=
 =?utf-8?B?NVR1MWFnSzlBaDdjeVdLUmMvajh0aGhBMEJsOUtSQ00yZ0Q2NDgwaWcwcTlZ?=
 =?utf-8?B?RE9hUU11dzRsVUJEZDRNR0dqT0VxWnA2SmRyR3AzQzZTaWI4VldMd3RkYzNq?=
 =?utf-8?B?cS9obXVkeld5L0FxNmVGckhkYytQSkhKUnZIRE5xQ1B6WTBqbkQwaXNYWFFZ?=
 =?utf-8?B?ck0rR2x4azBYVktwQk9yYm9EK2hHKzBrNEJRMk93QVFnVDN4KzlkenRqMDBs?=
 =?utf-8?B?eGRuVWQzWURmNDZnaFFQTkZydjFMSzZ4bjY5VTgxZElLVnRaOFJ2MnkyTDk4?=
 =?utf-8?B?NUNPNGxKYTd0RFh2VjYrRGJ4cHNkSmVpdEJtSFhZMlk2S1cvVlhJTWU4R0w0?=
 =?utf-8?B?VjRjc0U3K09BaXdpMjFUbjRIRnpyY1RGaWswMXZWMkRabFJkKzZxVlAzbi9m?=
 =?utf-8?B?MU5HZVZwSVRQRWFvZXQ0NW5tQ1lDdzhUVmQ4bm1JZWxmSms0UUl0dEpWVlpv?=
 =?utf-8?B?TytCQnFkM0ZNWFNHZFpEdkV1ZjJZVVoxR2FXV0FVWHlXclRKcXBHS05Jeis3?=
 =?utf-8?B?aDVISmFOSVhIRDNhR1EySEtqWjd2d1p2ZHJ4bHZGNkdqZ0x3NVFmWVdUYm5B?=
 =?utf-8?B?T0VNRVVmQXdWNDB6em9xcjVYMVE4cVp3VDd4RStXQ0dIR1lNU3hDZ0JPUkgz?=
 =?utf-8?B?Z3JoMFFEdUV2ZUlnU09yNGM5V2w3eG9LRmxkeGFTZkd3QmhZbTM4RldWZjZy?=
 =?utf-8?B?aGpwdm9FL2dyRTl6RXdkbG5ucVYvYVFrcXRmZlRVQW1qYXFUM29SUFRPUjd4?=
 =?utf-8?B?Y0d2cjJ3T3ZMVlozbXZyTFErSkVHVnJSSmwxdWt4bnlIdzU4SjBXc0dQVmtE?=
 =?utf-8?B?STRoTEQzYjlmZGZVdHMzS0JBUEs1cmo0Nkk1SjZOaVUrMEtjU3VGSGs3UUtL?=
 =?utf-8?Q?E4kI03OvZtKj+vKJV/rLGJo0U2ipXlg+/7RWbr7ZU2Fr?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25892f0c-64d6-4563-bcbf-08dc053da757
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 11:35:53.9842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QLWCILvtFq2cYHxzCXWSN4NIZeG86c6fn5TluajrhQJs1/vGnmwQoKr3rcknazHD830QXfUkLxApUYuw2KwlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2061

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

