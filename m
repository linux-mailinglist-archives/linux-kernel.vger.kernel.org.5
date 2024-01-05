Return-Path: <linux-kernel+bounces-17909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDAB8254F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B6AB22B82
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA7B2E820;
	Fri,  5 Jan 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="DPttAp0/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2080.outbound.protection.outlook.com [40.107.15.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83A2E414;
	Fri,  5 Jan 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOnRHYuXkiy0LthVVIyclyZHm6wmLWxYfNc5Y05T8HrngxzTTFqY8KMnarjLGEFduEqsWkOHL3MPm0lLUERPpmnoQPmjiVfw3LQoJqjZs0tYkIOi07ToG0Su9DhQdkCsy9baRcCmcZWHMmACVJb9eRpXnbjlBd6xwSTnuIAiSqXpJlzqbZhz1Om+s0qzlmOjAdWiTGDVV3vHUpMPPJ9Wx2nJJGhxM+BPYXW5WhfCTVsHKPVz5klqpNJMncB40N3K+LNiRnFDOfzLVTdxJ8qAAcUFIKkbdX7PpSBD8IvzOHJJNd0WL3nWVVFPemd3sKI/LV7vamTKNP4x289M/+xvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BcGoe+ESDzoCivkDyl+SvQ6vxiyAUtVpHN4Fyf7TKI=;
 b=JzfaphI09etIdPQmmCzjbcl3olLF3wrHrzA2QYltA+TulO1cC/9yAZA5q8rke3dbSMjcieyYz54XrLvd6PSfK7sYP7QFKNtxbQyNrwXKX72npGeUUHUCn35AuSftRUS/2TmPnfH2T8Ry7kNqz5OlF2mxfgX64lrWzuYpAye73dt0gJYZo+mX9a4ECVBMsKAkRlCJSDOA316RwH9XKzc2RgQ4v4QweHq6GXpUCIAEakC9mGNfi+34BrmdcZ8i84Cu7BIvJeIXDBSD5XrusjfVgW3UlxABjGVPxKajkGeFgaA6NTFRcWfhclwWQHSIU1FNL9ujinUFVJOnxFzSpfp78w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BcGoe+ESDzoCivkDyl+SvQ6vxiyAUtVpHN4Fyf7TKI=;
 b=DPttAp0/XMkIb1FvF/YYqLaAUfs+aAu/RaiQngACPmy/amnhIInGdBsPYZfSOfF2JyNGjb2UVPQGQwO/quXOC5p/jGcbWMRtTPq7TciJAVXcOSutoIYTY+RngNHdx+8GxW5aFNVLCWjBWFE6MolfDUEYcqf2dPwmYbwtmiWc4nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DB9P193MB1403.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:12:19 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:12:19 +0000
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
Subject: [PATCH v8 7/7] serial: 8250_exar: Set missing rs485_supported flag
Date: Fri,  5 Jan 2024 15:11:53 +0100
Message-ID: <20240105141153.19249-8-l.sanfilippo@kunbus.com>
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
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|DB9P193MB1403:EE_
X-MS-Office365-Filtering-Correlation-Id: eae7664a-64e5-4ed2-c0cd-08dc0df85413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pclExZA+wfAIN9iDmg6KFEMi71SNqIxCeM23GcC7SOzz6kdmZNeaFfO93dXZuYFJV5NVAej1cB0C4FNPFW/OhBV+K0OGb0ipgZtRcWGG2o3kqalyJaH29OiQQp7y46VBMIbH4B/cddE1lV9tAHMVKwVn+JsmIZfQEodIZBj6Fu8jnebdjm2xKMU1iKvJ7IaYibb80Vq0/XdAp74B7HHxpePQRp6RXgPl5+5aRu/igaZnP7CMefGbUxfJ1Yq7OR5zpKAie4wmub/MHbw+4dNHgocugGQs0EEpn16D2fwtCzE1XdWnHP28HlAeGTb2ahg+0CIkOrVJsZygX30Kwyc6u+I/+AV3FDJQUjHUf9OQdX3pCrkQg0ycrcyvCgPRXx7gP1+lQ2zv2fOh5SjkRznL+IG3e8+bLx9qYzH2BM+BBMJ6UriABnwzGfbfNINl+Kn6dAnU96ciVrQ/lqTKZjgcdPfctGCFQVR2ZAT/pXlj7GdTAEit0Fr+LFqT2hIe5CtmLDUaD6HLdY3n+CPVSvtj4CGEjR2CmPskvXSWgSM/hiVJ/rY75iH0yd7EVimt+TQMMcRuKC0yVCB6uxJhIJSqOU7ayjeftVwOGrLZ7Ti3pdlBTuekYBEU5wP33ZU0abjH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39840400004)(346002)(366004)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(478600001)(2616005)(83380400001)(5660300002)(1076003)(66574015)(6512007)(6486002)(66556008)(66946007)(66476007)(6506007)(52116002)(316002)(4326008)(41300700001)(86362001)(2906002)(8676002)(8936002)(7416002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c05Jc1JncW81M3lFNjhIenR5bkxTYWdLSDl3aE5pK3IzMW5VcmY5Q0FRNzhn?=
 =?utf-8?B?cDE3STU2cXVsZXhycU5ndlNPR1FnZ0JySlV1VGVmREtEK3ZTZUdXd0g3MUpy?=
 =?utf-8?B?MTVvVGUyaW83SlcvdDdvYktZZkY1dmJ1RXFjRzgwTGQ1TDdZMk85N1N0eDFI?=
 =?utf-8?B?c1RmeTg3ZDF2K0phUkRoblFnS05XVDE3UytsQk81ZjhxbFB1SmF5SVpJNlYx?=
 =?utf-8?B?aUxGYWE4c0ExeHE4Y0tYZTM3VisvZXdRQnlDaWhlQ0JtVTB5bkZUajF5MXY2?=
 =?utf-8?B?Q3JEMG5GZkpIcThUekRMUzRzdEtuYjhyY2FncFhyTGozWTJFZVQrQTEydVF2?=
 =?utf-8?B?WDNaOUVvY0hmSW5xNS9mT2I3MTljQjhLS3VMUUhKSCswellzUkpmQ21JNmox?=
 =?utf-8?B?SUdwbTcwLzZNUEVia0h1YnlvWk9qYjFtOFYxa1JFblptdDIyUzNrMHk5bXdl?=
 =?utf-8?B?ODlYQXQ2aURscnhhUnJxRVZTR2trdmtqdUgrMWRhTUJSaGw0VTdJN1VBMUky?=
 =?utf-8?B?QnFkdWFZZ3ZSZGk2RU5uUWJUQVVNSndJYlRtOEo3UUcwQXF1ZFg0TWY4UnV4?=
 =?utf-8?B?djlua08yTHYvMmVpczh0MkgxOW1Ya3RTNnF0Zkw4NjVHc0lvM2ZKSDRyTjhJ?=
 =?utf-8?B?VU1KdzZaWUlBNEdrZDJLVW16bnZYNnkvNDlwdU5wYkVLa0JXWFNralB6UElM?=
 =?utf-8?B?VDFOV1ZPTGt4LzVTSmJUN2dRaXJrUEhLVXkvQTFSZWIwSjBiLzkzNjZ6RnBJ?=
 =?utf-8?B?UFFkWHlMMlFsMDBhSlhackRKM2trV1AwaDJUVVVkcXc4RmZkUDNlY3U4NlVQ?=
 =?utf-8?B?TlVNV1l0K2dvL05VL2FHcjZlbWdsbmxoWnQ3TjU1clVjeGlHUysrR1lQQTly?=
 =?utf-8?B?YzdCUytCdWROWTMrYWtnVlg1UExYWUNBeFZBWDlKbFlOczNkN1VTYWI2WlEr?=
 =?utf-8?B?aDgwU094Q1ZYN3pVMmVuMDZURmZCUm9CL3NZT0hoY1BsOC9Tc1E2UWNJWFRi?=
 =?utf-8?B?NUN0azZGbHF4Y0VobmhvdDBHbWNvVTJzS2V2S2JCQ0grUGxqQUc2bHNsSFF6?=
 =?utf-8?B?M1JERDRpWlVsMHR6bGFueXlPb0s0d1VLenMrblN0Yk0zSlNuWkM0VjVqTkMw?=
 =?utf-8?B?RkI2S05TSXpDcHZUR1FXWmxMMTRqalpYRFV2LzRwdHp2Z3h5OXNoSEIrYTVM?=
 =?utf-8?B?TUZGZzVseWpPQm40a0JVSWkxVGo3UXA5cmVUczhCNUs4RkdWMzZtM2xOcnY1?=
 =?utf-8?B?c1RXTzl3cWVmTEJGYXFWWk5zSFk1K01kei9lTEZuWnBLQmVEWFRjbk1QZ21Q?=
 =?utf-8?B?UmhPQ2Z1THZHKzAzdHZieGxHZHZOQVNOREVaa1ljTWlVQjRlWlREK0NMS2NG?=
 =?utf-8?B?RGtGa0FrVGIrTGNKclQ0NUVqRWpCTE1LZHVmZ1dqRzY4RWdGVVN5REcvMnRG?=
 =?utf-8?B?ZWtVM3g3cXN0aTZ3elRNQUYwN2xaZEdXRGQzaDNoY2ZPNzZ4OGlES3JGL3Bw?=
 =?utf-8?B?K0NPSU9hRTFNSjQvdDZPODk1Y1g2ZkVwWkxlN3Z4aURhU0xEWHg2Nm9ReHBU?=
 =?utf-8?B?Q2x6SDZKVU14dDVDR0FEMGI4K0d1Nnl6V3pJRFFiN2ZDQXBiZXNlMGtiWnEx?=
 =?utf-8?B?VXhKVW1OR3pPNHR6WlE0Y09yU3luR25nWUh0MGVzaUY1ZUJkcU0vdVBCVXRj?=
 =?utf-8?B?cFlod0xzMU4rMkxlS3cxUHNHcy9wVTRRR0wzRzM1RlB1eU9Mc3ViZXZhMGh3?=
 =?utf-8?B?d1JqOFhiNy9TbDMwTEhHVWhRZ3VRQk5PWjViWVdyQlZnR1BWWC90dmR3MFFW?=
 =?utf-8?B?aWdOTFQ5Ujdpd0tkbDJ3QUtWMjJvMXk5RUdqSmNtREhYY1JYNFhTQ0Zyb1E1?=
 =?utf-8?B?dDRtNmZUbWdBVEEwNFV5U2o0cXRSUnc2SllhZE02cEIrTGpoWkpaSHUwek1U?=
 =?utf-8?B?alljU1RsMkZVZkNXdlF0cWJNOS9uc3licEUwTzl4cmtYUEJRaFo3bUhGOWpr?=
 =?utf-8?B?aURUdFQwTlpDSDQ3andBZHFzVm1lRzVtVlRDcU55MjZKemdUWExhMGRSazJk?=
 =?utf-8?B?TkZzWG9mRldtdTVaV0ZybkVaU2RpYWUyeTQ3ajRXanlJeHNCMWpnOEJOT3ov?=
 =?utf-8?B?cDEwME9iTGMydEtmV29BazE0TFh1Z2s2eVRlVlNNQW1vSjViTFZScVFoTlhJ?=
 =?utf-8?B?MjJ0bDdUdERSbW1pY2lKSGlDc3dONEs2UUpFd3NyMkJaOTF1d0xhYXVwdzBz?=
 =?utf-8?B?bjFPZTdZUitKdlcwbkhCOGtVbElBPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae7664a-64e5-4ed2-c0cd-08dc0df85413
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:12:19.4579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pPPALFKj05UIt33mO20FNIQoLp77EGDTHwZ/9MbJZGXLsjtZAOA8hMqdmEGolkOm8ElmiCpgICjhvoaM3wqag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1403

VGhlIFVBUlQgc3VwcG9ydHMgYW4gYXV0by1SVFMgbW9kZSBpbiB3aGljaCB0aGUgUlRTIHBpbiBp
cyBhdXRvbWF0aWNhbGx5CmFjdGl2YXRlZCBkdXJpbmcgdHJhbnNtaXNzaW9uLiBTbyBtYXJrIHRo
aXMgbW9kZSBhcyBiZWluZyBzdXBwb3J0ZWQgZXZlbgppZiBSVFMgaXMgbm90IGNvbnRyb2xsZWQg
YnkgdGhlIGRyaXZlciBidXQgdGhlIFVBUlQuCgpBbHNvIHRoZSBzZXJpYWwgY29yZSBleHBlY3Rz
IG5vdyBhdCBsZWFzdCBvbmUgb2YgYm90aCBtb2RlcyBydHMtb24tc2VuZCBvcgpydHMtYWZ0ZXIt
c2VuZCB0byBiZSBzdXBwb3J0ZWQuIFRoaXMgaXMgc2luY2UgZHVyaW5nIHNhbml0aXphdGlvbgp1
bnN1cHBvcnRlZCBmbGFncyBhcmUgZGVsZXRlZCBmcm9tIGEgUlM0ODUgY29uZmlndXJhdGlvbiBz
ZXQgYnkgdXNlcnNwYWNlLgpIb3dldmVyIGlmIHRoZSBjb25maWd1cmF0aW9uIGVuZHMgdXAgd2l0
aCBib3RoIGZsYWdzIHVuc2V0LCB0aGUgY29yZSBwcmludHMKYSB3YXJuaW5nIHNpbmNlIGl0IGNv
bnNpZGVycyBzdWNoIGEgY29uZmlndXJhdGlvbiBpbnZhbGlkIChzZWUKdWFydF9zYW5pdGl6ZV9z
ZXJpYWxfcnM0ODUoKSkuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpSZXZpZXdlZC1ieTog
SWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPgpTaWduZWQtb2Zm
LWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZl
cnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZXhhci5jIHwgNSArKystLQogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0
eS9zZXJpYWwvODI1MC84MjUwX2V4YXIuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBf
ZXhhci5jCmluZGV4IDYwODVkMzU2YWQ4Ni4uMjMzNjZmODY4YWUzIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2V4YXIuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
ODI1MC84MjUwX2V4YXIuYwpAQCAtNDgwLDcgKzQ4MCw3IEBAIHN0YXRpYyBpbnQgc2VhbGV2ZWxf
cnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVy
bWlvCiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGdlbmVyaWNfcnM0ODVf
c3VwcG9ydGVkID0gewotCS5mbGFncyA9IFNFUl9SUzQ4NV9FTkFCTEVELAorCS5mbGFncyA9IFNF
Ul9SUzQ4NV9FTkFCTEVEIHwgU0VSX1JTNDg1X1JUU19PTl9TRU5ELAogfTsKIAogc3RhdGljIGNv
bnN0IHN0cnVjdCBleGFyODI1MF9wbGF0Zm9ybSBleGFyODI1MF9kZWZhdWx0X3BsYXRmb3JtID0g
ewpAQCAtNTI0LDcgKzUyNCw4IEBAIHN0YXRpYyBpbnQgaW90MjA0MF9yczQ4NV9jb25maWcoc3Ry
dWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zCiB9CiAKIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGlvdDIwNDBfcnM0ODVfc3VwcG9ydGVkID0gewot
CS5mbGFncyA9IFNFUl9SUzQ4NV9FTkFCTEVEIHwgU0VSX1JTNDg1X1JYX0RVUklOR19UWCB8IFNF
Ul9SUzQ4NV9URVJNSU5BVEVfQlVTLAorCS5mbGFncyA9IFNFUl9SUzQ4NV9FTkFCTEVEIHwgU0VS
X1JTNDg1X1JUU19PTl9TRU5EIHwKKwkJIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFggfCBTRVJfUlM0
ODVfVEVSTUlOQVRFX0JVUywKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHJvcGVydHlfZW50
cnkgaW90MjA0MF9ncGlvX3Byb3BlcnRpZXNbXSA9IHsKLS0gCjIuNDMuMAoK

