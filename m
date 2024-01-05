Return-Path: <linux-kernel+bounces-17908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B5A8254EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9E11F2379E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F642E65F;
	Fri,  5 Jan 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="J4oShjNu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364A2E40B;
	Fri,  5 Jan 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOMA1eUQsjxYQT73u5GF3XbLSTqiO+/28/a7MYwt2EmSlUlD6DausqaaYSykPlCspzAQpTqdvOQnI3luMKNL/ru97xG4g86d4qEf+dKleCobTpYTleJY/EjeqwyLQVqkYZhxygQ2xqVjsnweFKISwKOsjpEjOGvZzqOmR3l1LD5alB72yfzgIBOsfwlhI0R2ORRCnPSX8kSjb3r8Z7CCtKIymq14YeojqqJPu3f7pkba5hRG5JEP6Sry2jFOYDda3/5zHaOeRQfdnmCrEalAFhG5ScJ/KI+gwYwxx/Pm5+qzQlTVRL9gX6By5YA1c1bkJJ5WYsRGJMYkQgXMYqY03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrTCdaXp4RpigukbEw/E4R9h20jHnCpK5qa1aIze2JA=;
 b=WCA26vCwF2ZupWSgm09Gh8MejcDVcntyi0U4UJSqGjr3cUpWU1JR5b4By8y8YX3Hnct6oA4T9D3ktshJnZ9pf7EMVUltbetGTLJ0Hv+wI5q8Sr7+N3hi8lz89qvgiWyUqusutTnBPlQgAk8cD2M+nDH85ioKbA8de2A2qv5rd4eRfdsVyqBgkzZNK2Vk2bwB9jRdAu/hOygbREpPphApAufveNVbFm9jtQEMxIQWJM/82Z/aFGU8vAVMJHOv01ElIZ3wbVTzAdudd09v+Q8JIZI7zsD+QkMPpCeoGBH7mZViiHdcA+Hw8VSmSMiuxiz+VWLLFtGW/8ndQtdzLE7XpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrTCdaXp4RpigukbEw/E4R9h20jHnCpK5qa1aIze2JA=;
 b=J4oShjNuAeUBDVNh+HFp0ApML6KsJdZWsCvrZaI0fyjwzQ/Kc4kd5OgV0Eg+uIcBBLpdRH/SHiUOev68/zLJ25dpH9NkFcaQSj9Q4d7Xs7BHMkfQ/B5AmuAkVossf5cQqm5Iu45GpE6EVXDGAeK4SS4JJs5imKEcDXszOzOu1KA=
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
Subject: [PATCH v8 3/7] serial: core: fix sanitizing check for RTS settings
Date: Fri,  5 Jan 2024 15:11:49 +0100
Message-ID: <20240105141153.19249-4-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0f9d0a11-92fb-4370-5141-08dc0df850c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Npi7DARQ6mcOFrEijT2MqAzd8f2HH75iT4+1Hi/9x9ukllogheVpq7RjaErlbakdwpq40biLKCp2Sf8PuNodd+0WXyi555r6LH2iYWWyBBe3q35E+7lhlMDoanUBrOmaaZ8SvK6feqQ8EgeGOSghg6GzjZEHb/n/fJ5KRj+gNRrcQflS1kPUl+Wdkx77pizladznaLWgX0kdhBvPAwjng2h7VLAk7JroOfY2TjbqOSR4WyvtwXLJ3C4HBs6B+k0E6HmE5I44mcgA9ONR8vrADUPigj3J8LQYsE9krmnO7dtYPaes4cefwrhsPIt1Bf3EN5FAUojDrmaJUb48KhEIzqoCzSjVok/QK+dNQ8GuX4e40ofuASpv8Jrn44TcsK6prl0RImsKvc8UrhJivGQvSEYZMWINSIdVl2dKBToampFJsgdQgZ1gbcuFAUTwWttwP/iDzUii63rulOiLw+CVMgums1JMCaHeET0QmLqYB/qOGYEv/XNuGHQD6TXI8pJWQOQGcO1VZFvBXbkU47tVe29rMWW5MEGneCYHNw6swoaayBs+p8BVxr2bOZOU6Sbt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(52116002)(6512007)(478600001)(6506007)(66946007)(66556008)(86362001)(66476007)(6486002)(83380400001)(38100700002)(66574015)(2906002)(6666004)(2616005)(1076003)(7416002)(4326008)(5660300002)(41300700001)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3o3T3dla29xcjRXTUVMRTA4S0hZNWxqY2dIMW4yb081VnErcW8zdzNvY0Jw?=
 =?utf-8?B?WHcxMERjRnNrbGJlZnozd0NaZlZmdjZMeGY4UFEyWS9VQ0hmMXVzODNMSm1y?=
 =?utf-8?B?VHZtM1RYL2txTUFaU1YrMWpyMUtyVDg1K3BlYWwyMHMxdVV2NGV4Ky9tZVl3?=
 =?utf-8?B?UG5PK1RMeGtLTGhjeGt6b2tOQ1R4OWR3NFprYUVDeVF2ZjNkK3RyQ1NuQ2xE?=
 =?utf-8?B?YXU1M0ZCL1hVeFhjT2NVYnpqb2pQV09FRmtJcnFOZ2hPeWxXUzI3K0o2elNL?=
 =?utf-8?B?N0RjWW9MbzdSUkd2RFM1TjFiZlgwTkZlVEFKRG9hQ0VGclBMUmhSS3M2TkxY?=
 =?utf-8?B?YklCTWEwTGdtdEQ2eWlYbXNvbnRkVDMzVCtvSmpsZ2JncTFiUUh3dUZNZjNP?=
 =?utf-8?B?MVpvenJnREFvT0pvM3drT1dJU2VWTWx5aENLZWFpZVRCcm9sWVB1cjRNcVcy?=
 =?utf-8?B?cm5vSU9uNTQySjI5eG9aRWFwSjVWQTRzaEdHVk5QeWV6UEM2RE81L1o2eWJY?=
 =?utf-8?B?L2doV25ySHhxYmZISHRIQ1B3WTNZclRwVWdJMFhUaWJ6RHJpL2QyaUh2bjdU?=
 =?utf-8?B?RnFMUGdiWWthOHFIR1A1d1BPcm85SDN2NFJmbThvMW9aVVJKWnhualVYSjJO?=
 =?utf-8?B?RU1hWEtEY1YwS0tTemNINjFWUUd1d0VuU3gyUUMvWllNcGg3SUtGdmROcDRl?=
 =?utf-8?B?cFRJRnZGS2srYTN0YXJhUzBCbHpuUHpKQjIwY1FreFFOVVFIeWFMV2FkREZD?=
 =?utf-8?B?RjVROXVVRE1XS3V0ZURRUHVscSs1bGRkMnZVNkFhT0krL3NaNGxPN1ptNDRW?=
 =?utf-8?B?T0J1ekt5NWJUTnRXTXRVcjhac1VCM0Z6eWVZNVpCNmxOWEJ2S2NGdWYxanpl?=
 =?utf-8?B?MVBXbXNaN3ZCZnlEbkhGRURNY3VpeXdvQzg5UUJXV1NXeE9JM2dCTlkyRnk1?=
 =?utf-8?B?MlB2T1dVcXhNV2p1M3RrVEJlQjlIejdtOXFlSXNIU1laR0ZEcEd2N1lrTXRC?=
 =?utf-8?B?d0dVeUVjWTFNeUZRT1FoS01CZ3JRZzZ1ODR0dEs0TGhIUy84dmRpWm5QWWVv?=
 =?utf-8?B?SFVEcmZjZHhIaE8yblo1eVBWY0dGZXVEdS9TR0NFQThQTUI4UlhUUkk5dGNR?=
 =?utf-8?B?Y2VNZ2UxbDJoTDFZcjdmNVZHVmJNNkQzTFA4eTZSOG1Vc2x0Uk5IZmVzd0hO?=
 =?utf-8?B?WWxyODNKS3NHVjdXUjRKTXRoL2wvc25pejJLY3hNZmxwaWhHU1d5bE1JWmxI?=
 =?utf-8?B?dTZWWURxWEJnRnlkdi8yL0lLSGo4NlVZZDV1SExvQU5CQlFSTXk3RktQZGoy?=
 =?utf-8?B?aFJvdDZtN0JzanhUcDN3MHlWcjZWNFo3V3ZtdnpNQ1laaDJqbnVsRjdlRkFt?=
 =?utf-8?B?eW55VS9nRlpLT2NJZ1NEc1YxWldobTI3eERWYlhVOWkweFdQQmFtUkVRRGVp?=
 =?utf-8?B?NlBlMTJzYUx0ZTIrdzlKWUhIdXBSODZidTQzWm5YY3ltNDhLZjVoeDJWTlEy?=
 =?utf-8?B?Zi9mZkx1bFZtZURqQUpEZmhNY1VDM0h1NlQySnZOcjczQ1AweUN2Q2RFZ3NB?=
 =?utf-8?B?QnFkWUV4K21DR3QwSjI5NERMNDNoQk9qWnVBVDFzSDVDMWt2YlZIcC90WHVM?=
 =?utf-8?B?NGorWFc1OSt6eVRqWnB5aHJ5aW1SaE5oYUtLdjNKMjhrSEd6WUhuRDFlSWQv?=
 =?utf-8?B?K0NRWmhLMXp2R1FBZSt2UUlmSUxyWG5GNzlHcVZOSDgxTCt5NUdlVHZ2alV6?=
 =?utf-8?B?TEV6M0dua0pCRFI3UFFhZGZvTTg0V2hDUEprUUNYZS9DRUlzdW9jWkNRQ2d6?=
 =?utf-8?B?NVpveUI3Qnhwa1luajVBUzJTRC9lTFZmbFFZdHVGS1pZRElUakthSmg5aFIx?=
 =?utf-8?B?SXBjTVJCUVJlTU5IYUgxREs4Y3lCMDhueTNGNVYvMWRxTjdaUEtlWmxsRzFu?=
 =?utf-8?B?UE5QaWxhL2tIV0g1NTlXMzBEZlVlMGI5T3FSQ1FsRjJVem1GbGYrZ3NJVVRH?=
 =?utf-8?B?QzJLb0VqMGpJR1IyY213VllaQSt5SVcyU1ZDTVA0NGd1TXVYQTJ0Z1FBWTE3?=
 =?utf-8?B?akNGRkpBSlVlMVkrdDBheDJ5aHcyYXhmeWtFVDBXaHFjM3JvY1p6MlNpTHlX?=
 =?utf-8?B?NE9mdXZpazNrOUlWWWQxVkNmVXVkR2taRk4wa3pjNVlXa21HUG5aN3lGd0U3?=
 =?utf-8?B?b0wyVzBXN1pkR2VHeFU0UHF5Ym1oQ0hLb3BiZFo4Z2FvMHJ5NWtCMDQvV2Mz?=
 =?utf-8?B?UFZtdzBZdElZYmVGTyswNnIyZVlBPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9d0a11-92fb-4370-5141-08dc0df850c5
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:12:13.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKs109ZPNINBRfKQpAiQtq22vD5U3Gfyv+53ZPp+1rvgkIPbumGcRhoYqRc6tUoODLVO3sB1oxPEGrEmFWRbSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1538

QW1vbmcgb3RoZXIgdGhpbmdzIHVhcnRfc2FuaXRpemVfc2VyaWFsX3JzNDg1KCkgdGVzdHMgdGhl
IHNhbml0eSBvZiB0aGUgUlRTCnNldHRpbmdzIGluIGEgUlM0ODUgY29uZmlndXJhdGlvbiB0aGF0
IGhhcyBiZWVuIHBhc3NlZCBieSB1c2Vyc3BhY2UuCklmIFJUUy1vbi1zZW5kIGFuZCBSVFMtYWZ0
ZXItc2VuZCBhcmUgYm90aCBzZXQgb3IgdW5zZXQgdGhlIGNvbmZpZ3VyYXRpb24KaXMgYWRqdXN0
ZWQgYW5kIFJUUy1hZnRlci1zZW5kIGlzIGRpc2FibGVkIGFuZCBSVFMtb24tc2VuZCBlbmFibGVk
LgoKVGhpcyBob3dldmVyIG1ha2VzIG9ubHkgc2Vuc2UgaWYgYm90aCBSVFMgbW9kZXMgYXJlIGFj
dHVhbGx5IHN1cHBvcnRlZCBieQp0aGUgZHJpdmVyLgoKV2l0aCBjb21taXQgYmUyZTJjYjFkMjgx
ICgic2VyaWFsOiBTYW5pdGl6ZSByczQ4NV9zdHJ1Y3QiKSB0aGUgY29kZSBkb2VzCnRha2UgdGhl
IGRyaXZlciBzdXBwb3J0IGludG8gYWNjb3VudCBidXQgb25seSBjaGVja3MgaWYgb25lIG9mIGJv
dGggUlRTCm1vZGVzIGFyZSBzdXBwb3J0ZWQuIFRoaXMgbWF5IGxlYWQgdG8gdGhlIGVycm9ybmVv
dXMgcmVzdWx0IG9mIFJUUy1vbi1zZW5kCmJlaW5nIHNldCBldmVuIGlmIG9ubHkgUlRTLWFmdGVy
LXNlbmQgaXMgc3VwcG9ydGVkLgoKRml4IHRoaXMgYnkgY2hhbmdpbmcgdGhlIGltcGxlbWVudGVk
IGxvZ2ljOiBGaXJzdCBjbGVhciBhbGwgdW5zdXBwb3J0ZWQKZmxhZ3MgaW4gdGhlIFJTNDg1IGNv
bmZpZ3VyYXRpb24sIHRoZW4gYWRqdXN0IGFuIGludmFsaWQgUlRTIHNldHRpbmcgYnkKdGFraW5n
IGludG8gYWNjb3VudCB3aGljaCBSVFMgbW9kZSBpcyBzdXBwb3J0ZWQuCgpDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZwpGaXhlczogYmUyZTJjYjFkMjgxICgic2VyaWFsOiBTYW5pdGl6ZSByczQ4
NV9zdHJ1Y3QiKQpSZXZpZXdlZC1ieTogSWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGlu
dXguaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBw
b0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIHwgMjgg
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlv
bnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9z
ZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXggMTIw
NDEwMmQ3MTYyLi5mNjdmYjZhMDQ5ODMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9z
ZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBAIC0x
MzcxLDE5ICsxMzcxLDI3IEBAIHN0YXRpYyB2b2lkIHVhcnRfc2FuaXRpemVfc2VyaWFsX3JzNDg1
KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJpYWxfcnM0CiAJCXJldHVybjsKIAl9
CiAKKwlyczQ4NS0+ZmxhZ3MgJj0gc3VwcG9ydGVkX2ZsYWdzOworCiAJLyogUGljayBzYW5lIHNl
dHRpbmdzIGlmIHRoZSB1c2VyIGhhc24ndCAqLwotCWlmICgoc3VwcG9ydGVkX2ZsYWdzICYgKFNF
Ul9SUzQ4NV9SVFNfT05fU0VORHxTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQpKSAmJgotCSAgICAh
KHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfT05fU0VORCkgPT0KKwlpZiAoIShyczQ4NS0+
ZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpID09CiAJICAgICEocnM0ODUtPmZsYWdzICYg
U0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EKSkgewotCQlkZXZfd2Fybl9yYXRlbGltaXRlZChwb3J0
LT5kZXYsCi0JCQkiJXMgKCVkKTogaW52YWxpZCBSVFMgc2V0dGluZywgdXNpbmcgUlRTX09OX1NF
TkQgaW5zdGVhZFxuIiwKLQkJCXBvcnQtPm5hbWUsIHBvcnQtPmxpbmUpOwotCQlyczQ4NS0+Zmxh
Z3MgfD0gU0VSX1JTNDg1X1JUU19PTl9TRU5EOwotCQlyczQ4NS0+ZmxhZ3MgJj0gflNFUl9SUzQ4
NV9SVFNfQUZURVJfU0VORDsKLQkJc3VwcG9ydGVkX2ZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfT05f
U0VORHxTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7Ci0JfQorCQlpZiAoc3VwcG9ydGVkX2ZsYWdz
ICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EKSB7CisJCQlyczQ4NS0+ZmxhZ3MgfD0gU0VSX1JTNDg1
X1JUU19PTl9TRU5EOworCQkJcnM0ODUtPmZsYWdzICY9IH5TRVJfUlM0ODVfUlRTX0FGVEVSX1NF
TkQ7CiAKLQlyczQ4NS0+ZmxhZ3MgJj0gc3VwcG9ydGVkX2ZsYWdzOworCQkJZGV2X3dhcm5fcmF0
ZWxpbWl0ZWQocG9ydC0+ZGV2LAorCQkJCSIlcyAoJWQpOiBpbnZhbGlkIFJUUyBzZXR0aW5nLCB1
c2luZyBSVFNfT05fU0VORCBpbnN0ZWFkXG4iLAorCQkJCXBvcnQtPm5hbWUsIHBvcnQtPmxpbmUp
OworCQl9IGVsc2UgeworCQkJcnM0ODUtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VO
RDsKKwkJCXJzNDg1LT5mbGFncyAmPSB+U0VSX1JTNDg1X1JUU19PTl9TRU5EOworCisJCQlkZXZf
d2Fybl9yYXRlbGltaXRlZChwb3J0LT5kZXYsCisJCQkJIiVzICglZCk6IGludmFsaWQgUlRTIHNl
dHRpbmcsIHVzaW5nIFJUU19BRlRFUl9TRU5EIGluc3RlYWRcbiIsCisJCQkJcG9ydC0+bmFtZSwg
cG9ydC0+bGluZSk7CisJCX0KKwl9CiAKIAl1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NV9kZWxh
eXMocG9ydCwgcnM0ODUpOwogCi0tIAoyLjQzLjAKCg==

