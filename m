Return-Path: <linux-kernel+bounces-11015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB1481E017
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70441281F73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176EB51C2B;
	Mon, 25 Dec 2023 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="q3qNevDO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941C5101A;
	Mon, 25 Dec 2023 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpC5wcYTiAAzADkbjRVWnNVIHJ3oc0NjNXAxyD+DQhs2kPHX7YKYBbMbWsca034lTmVRqTUVR4vdlbH03vgjlMVqk7U/AJcnmzXDpxUXR1j3Qzb2iOlELyY9eEQRCz05cvJtOgA5a/VPn8Xct74ltvtTGEPGRD/lMMw29MZVs39metjd6MQt0pLD+nfvz25TN8TKEXMBY85pBis/mh95+LxDwr0tKq5ugh0S/0OnWz2D6pT09H6AfkETrdYFOfa4+bzn324cHB3FkdznJkl0ZKj69Enrvww6HH56fN3XVWjImRsHMx01Z+SdfV4du/Iot6SshQfM4k8lbi5ak8Eylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrTCdaXp4RpigukbEw/E4R9h20jHnCpK5qa1aIze2JA=;
 b=RX0VOlqsxwAelafUxxyEz52H7AQErRF+3uMufOn3TtuSLIn+XzX0wSLkByfP5cC1yFg9qdXYBbrPTGcd5JLZ3tKgGJaKV/hTmfZjBfTt/oblDmMXbSIRiqXgIXjWyuqbTuChryJHanpXiLMJjcmq6vJoVuqLqsjhaGiQg4Hx/6zjmJa6zu8tNlfNvvwrxzolGzB5INkyt/aibGRK46KlDDKON/o/Dem4fA8Is0qTsiwsRBjv9LuHT7vG41wvJa7/IAMpL4s8ZHYNH0tdRbITA5gYSv35M/6yJnXZXsmW9+0M0n3jZAR6ksZLEW9Pl/7VO1oZcWZ0P4vYiiNDVwaaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrTCdaXp4RpigukbEw/E4R9h20jHnCpK5qa1aIze2JA=;
 b=q3qNevDOoMSWtTdU9thGwvjR74myYQvod685CZebiuKxMBGj64UkeTLW+dBdZhI2pAYoN4F/bRXBY6oghXRxNbxDLYQgnm0Ft8QzeLqElzymoCTsWIRU2m7TpKlu3mRTTGugscoEYc1DCKQl7Z20NDueTo0EuGI6nMzc9l1+2Uk=
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
Subject: [PATCH v6 3/7] serial: core: fix sanitizing check for RTS settings
Date: Mon, 25 Dec 2023 12:35:19 +0100
Message-ID: <20231225113524.8800-4-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: 56ccb621-1b1a-4440-85ea-08dc053da6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tKYCaaPah3qoqQ7coyRN2F484bUDQK7mx30jI9/oUyi7kFetL17EqK5Pqwq7/Yw3x2+/lyT8XX3n9UM/P2h/rjscdBLX/sFBy1Qubs7JmZACkLs/gQFiorIoqBWSJ9NrIwEb112JJqpdg/Ot1eYKwtoLEs8ap8nKaykPZ6URcrZuDtR/AsGIY6/cCiovED8fAhfUIHSTgr/bZcg4tgwIGso84qFR3vUf+0jnohmxazrYRBAkMNTkceNWubpe9nb09WsoKrpTlYP/ljEjN0HkkYyurYjgYfLCHlkAHycR5iUI2y0odaPwwjxPCQR6SRh6dXp5yUX+Z3wqNbcCm3RHow+arR5ghwp33clpOWmFfM22Tdrt65SoyBJX1cQGbJKXKNIEFCovr3lUG0ztDiEHf45HsxqbxkJcv1YtkuBoS/zQmgl7GEfN1REspYDcllweM8PZgMMYwC7RtIhh1NgP9WpQwxebBMVq3YquN5VMLCAwCKdkkUuCsOZvXy0YY98Vfl8YP7Ega2P9hxbrQ1jvdqVn0Duk7ITXuLen9WAYZtMgSzXg6ja6xvCbVLQWcPTi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(366004)(346002)(136003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(6666004)(6486002)(478600001)(2906002)(8676002)(8936002)(5660300002)(36756003)(7416002)(52116002)(6512007)(6506007)(66556008)(66476007)(4326008)(66946007)(316002)(66574015)(83380400001)(86362001)(1076003)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUFra1hFSFUrRzBBNEM4SnUxZWI5cTZGdHhWYW1oWDRWZGErK1cxTzNtd0k4?=
 =?utf-8?B?ZWQ2NHpGZkxuUktGZWlRVnJJZjhTVWI5Z05kR0xaa3dqTjYycXdYTzN3ZTBX?=
 =?utf-8?B?b1JKYkRoRDdsaDI4bHhQMnNwd0ZZS0ZXcFV0bm5BNVJ4Z25IWExHVVYvMzhn?=
 =?utf-8?B?VmEvSmd3QTgwRHBYNG9vTmpDWFZwSUVGRjZ4RWo1dkVIOXY1WFpWOVo0WGtv?=
 =?utf-8?B?R0ZaTHl2NEZzODNZM05YK2JXZUY1YXlnM0paUjdHM1RyVytjYStCSXIyRVoz?=
 =?utf-8?B?cWFBbEh6S0pIcUFSYWdUZ1ovT2t2RkR6TFZhaE5yQTY4N2VQRjVPUjkzbzhn?=
 =?utf-8?B?S1lMU0tzWW9XSVF0VlBYMVFmRU4vaTZNVThRVnZhbnA3ZTdQb01vNjEzMjJI?=
 =?utf-8?B?b3IvR1FXTW43eFFrbjQxYUpkS2tXTHo5eXhwcjh1a0R3R2tSL3VjVzU1WDQy?=
 =?utf-8?B?WVl5QzVaS0U0Njh6bnZNUjBFaitrWXEvdHRJMUlxUHB5Njc2bzBFbFJqcThJ?=
 =?utf-8?B?R3RhYzB0T0pMNTVHVm1nRzNHZ25zakV3V1pKWVFGV21HTHE0RnlDaFlud1Rj?=
 =?utf-8?B?QkJUVDhYQ1lNcTJScDVXODFseHRZWkJkS3lKZ3ZCbXdtamJLZHNNUjhMdkpw?=
 =?utf-8?B?Rk1kbzhvTFo4VzFvZVZWVFBpYzdVZzBkRzVNbW9yK1BOSG1JQ1ZST2E0OFN6?=
 =?utf-8?B?amhzQlgrbDZnRmVwVEdxbmQvNGx5cVhkUTRESmtkclBYYkhsek5JWDZRZGpv?=
 =?utf-8?B?dEVQcDlNaU5nWUE4cnlZbDFkZmJYUE5TeXp5UHJGRlJwVXpaR3huVVFvUGp0?=
 =?utf-8?B?RlU2d1ROLy95a2FSTXl4NmpvbnpTNjdxVmRhZlJOaUdCQlpYKzRNeExDeGVy?=
 =?utf-8?B?UXVtMXR0cTNxd2Jneks2VURoTmxqdHNWWTlqUDhIZXBJUkptMGpRVlg1YitP?=
 =?utf-8?B?bWlJTlRBcDhUZEdVY0tBNFpsNkgrQVVzT3BMeUR0VFlYamtJYk1CVlV4Vngy?=
 =?utf-8?B?YXpYT1JZWG1wWTIvbU84VG83RzNrQzN0MUJVTytLSTNBN1VVQXZvMFAwbGpD?=
 =?utf-8?B?ZWxObXg3cDg0SExlcHQ4ci9wUjJnd0FjcjN6R0l3eTdlNnliOFhOSjlQNUdC?=
 =?utf-8?B?QXIyT0xLczhZYktreXowSzNSNndlaXNWWWNMVzYwYlJDb2hZZzlIc3NMclVH?=
 =?utf-8?B?ZFNic09NMXgzUXF0aVJwZ21Gc20vbVgxZHRxT1JJNkZmR0kyT0gvSHYxVzUz?=
 =?utf-8?B?ZFlucWhuZWkzR0kyTlhyUlIycUE3d1p5bVZDTjluVkxEN25pWVVzZStKemk1?=
 =?utf-8?B?Qlo2YlR6VjNQYU84dTdnY2xZL24yMXN3cmZKMURZUE8xOHl6dnJmTFVJellx?=
 =?utf-8?B?WDl6Sy9YR2VHUGlzQU5oN0UyMU1RZERSZGNUM0M0Nm5CTURrM09rQ2FLS00y?=
 =?utf-8?B?MVpEUzZiNGRiRXRqaVM2cngwUjcxeUJFS0trL2wwOTd2WUhDeHRkMU5RRXA4?=
 =?utf-8?B?WkFWcmx0MHVWQnpTdktHbnMvN3FpVWZ4WUhVSlJaVlgzeEtrWDNHMDNZV3Iv?=
 =?utf-8?B?VW5JaWptbm5EVnRzRUYzZ1hQS0k2K1BYUndEalN1UnNDcndqS0JUQ05jcldx?=
 =?utf-8?B?bzVzSHJqck44TlhQS2R4b2lReVg3b1dmS0JhdTRaaFVtTDBqU3EzZGFoanVy?=
 =?utf-8?B?YUlCMmRSK2h2Y1hlaWdXWEpSY2RoYVV1VlBMdVNhMFJMQWpHR0pjTjJab0lB?=
 =?utf-8?B?ZSs4a25aN3ZDOUFaYTEvMVhSUjdIVzUwd1BIUWcyMmFjQUp3RjJGWHpoTnlO?=
 =?utf-8?B?cFlVSVVQYmFNQnE5TDBmemFLckwyelE4L1BCaVNUUEduTCtPaUV4MXpkc0VN?=
 =?utf-8?B?SWZ3bE52VEpGbGhIMFQ2bFovTjRwL01RbWlyU0FrcmtEUnhyb2tVbVEvUW5P?=
 =?utf-8?B?MXpNakFpQ1BqWStFWFRoaDhZMndmZGxWVVFsN0IxWGJXTkZoQnFTTU0wWXJx?=
 =?utf-8?B?aFRpZDJqeHBjYUZrSitBUFhDYVA0a3lYVi92S3NYL1Nvc2Q3MzJKQll4U2pr?=
 =?utf-8?B?azRzZFN3S005U1crYTU2SzZTeXlVR1FPUm9KTmJ1Z1JWMEpSTWRmc0FXdE1y?=
 =?utf-8?B?M2hUSGE1MHUrZHJoVW9JbzRzU3h1YzdoMHk4VXlqc2Era0kzUHNaa2xaR0FF?=
 =?utf-8?Q?PHepLd/iv378N+u977+IOib+dj43QJGL+Z+vJF1LDhTU?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ccb621-1b1a-4440-85ea-08dc053da6ff
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 11:35:53.3842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrewWoKd3gv5sQ5zK3ViorQwpYJy753VNrJaXDkRlCld3NkOkIUt0QtNLVcF7tuJhF7ih/twgZOJgZjMVpgBwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2061

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

