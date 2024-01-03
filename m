Return-Path: <linux-kernel+bounces-15206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4806B822856
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A421C22FA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1F5182AE;
	Wed,  3 Jan 2024 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="L8zvlucy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2045.outbound.protection.outlook.com [40.107.13.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7F1179B8;
	Wed,  3 Jan 2024 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6RJPARFzI/7wHNpOsGcAMzNtpZendogO3Qc8C1h5F2Z6kicfPmrLnmTl/d3xuwpF4b7V1/4rPX63HYyOXffhcO4OMKXZn3x5VVYTXagOTEgS3PqAhelhWP2lUmoTN3Pvr9ioawDSJZ5DS19yo+qTtSYLlY6/SLY9pgCwS5q9iiydo5DHrrAvI1n9Di7ZGwW6Mfrl4aWLEyvPA7aMbpDWBFZnFy0Cu/Mtr08GChVgDuvAINPkWsbYzdJogcnsTL2B9cFr0hAX/7AmvrgznugZnxtP+R/yiS6OYSkVV4jmKrWlnSf+3hA28qfTqCoGgng1/Zjga30FSULKlhwU4zCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrTCdaXp4RpigukbEw/E4R9h20jHnCpK5qa1aIze2JA=;
 b=gp4Kt72cvdZbU5o6dciSGsAwQAH+PEoQAQMD4ZuCyG54p3Pm0yP4BH/yYdNjAK2GaTx4qH+6fsK3r49w7IvID4HlTPgR0QL4rgmXuD4iVb/0bgsZxO2iGq53qYMSZUquz9l5hu7D4/KyNfhUyLbueMFgzm2dLn+pEdLKOvi6/tAeYi86SOO9XgBqhqDFlCZ0JRgl8s9mPhZXeTaL5yBsK4hBfv33uUiAQSEXA/YiDkcVmt3oDkTbaUUqgQy6e+DkR6NQZOgCgLUpaw8gwWXbm7Ph2GudXlu4IG1jWy9olS1IfCPwNNwgYX9exfDjyGI8RS2o7yKfzHJvnJ5VgdROuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrTCdaXp4RpigukbEw/E4R9h20jHnCpK5qa1aIze2JA=;
 b=L8zvlucyZ66BpXgAfYsx35nRkZt19wMp826M51pUnsOtOcsuYmci2E/FpUvsJrOFEZd7yUgyMDXmqC6zMykDI9s2+9Um83b6DaRDpyqdWcSLdZAmN928+I477kR0ZBnqCc+sruNwLnaiyPPZabZszYf+0MCglgvXqJcY+5h5e8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2245.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:19:11 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:19:11 +0000
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
Subject: [PATCH v7 3/7] serial: core: fix sanitizing check for RTS settings
Date: Wed,  3 Jan 2024 07:18:14 +0100
Message-ID: <20240103061818.564-4-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: de4ec4de-fb17-4a40-efa4-08dc0c23e695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GRQNwK2l+hoH/xiv122yDy31H4LSMjhdq3n7O73w8Ilvr6duClDRZNTxzpVv/CRMs84dli8hVMS+DnQ1kmA4Sg+pd+5rUUSwc1BPNMglqnn2P6iS3l1V261RRi7us//B0KW/e6ohStvpsMTV4wBgUh1B+k5p0jfye2v8setIwaSQNpvNWil+B5hURYcq7LTe2zRMiwNdCjA0fy6ShPDRnvYthk+HLe1B/sDso87KJnV5GD4eO7CdeD7AJARIRSuhlq7j6LcmST/fFRAKlfD/LEHc8yS6nrlrq6xaA6bMjVuZJ8903MuhOm6NuXCOrV69GNSKMNDEFVfjGzjhHcOwwxsec7QOXuKX8zq0r3n9yzQDdZ16u8H+qBw04FQWpxmL5/otBVX8W5BY5VfB0kb4RPjqGyIeSiMWDBAzqsO64MBQkg0P+Efg78tbCpnV4Wn+/QXXF8EczARsMJDd0MozrukEIuNvPb8P9MZMeNzmBPFUJItLq/IQXB7Kz0/iGr3ycjyCeQ8/KVWfyfN3kCTqDRQlsS7360Hu5auAdgbkXdinvanIHg+svUMMG5ihh21N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39830400003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(66476007)(4326008)(478600001)(316002)(8936002)(8676002)(6486002)(83380400001)(6512007)(6506007)(52116002)(1076003)(2616005)(66574015)(7416002)(5660300002)(41300700001)(2906002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzFFMHh2akM0RGNPUlNGYk5MbzF0UGkvMW81N1JpSlQ4VFN0SjFFZjFlWjhS?=
 =?utf-8?B?N3Qxbnc2d1RIUk5PL3F2ejRnbTJSUGVkd2NXclhxODBIRXhQWi92WkVNUUtq?=
 =?utf-8?B?UU1GS3BEQ09SMDdkSzJheHBmWVJMcmJkTUU2aVBNMEF3aTBoTWhHNk0yK3NZ?=
 =?utf-8?B?ZzdYNWxrRFRLeTRtTE5ia1F6WWhQOFp1ZDQwUWtKWGNCVFowS0ZSVURJWTlz?=
 =?utf-8?B?ZkhFcWliYjJIUEFFNEZvZklNMEZaM2FzbDl6MkJUTUFmM0EvNXFocEQ5SG11?=
 =?utf-8?B?K1JRdmt1R1pScGpydUh3WEl6Z1YvcHIwYkNDQ2RVWUVtQVlBUjBhVjRjRVdC?=
 =?utf-8?B?eU1TMzVjbjc4L29kaTI0am9iMXhYNGdVUkhJR2dBMzA0cVBya2pUSW56RXU2?=
 =?utf-8?B?ZGJTSDR2Q1lURmpkYmV1QVc4RGd2QzBTL1MrRTdlRTQvN1puMjdjZnYwVlVU?=
 =?utf-8?B?Ymo1V21UeUJVSHpYeUhzSy9vZVBhUGVMRVhycER5OU1kcURyQVBlUlVkdGZp?=
 =?utf-8?B?S1FCZWlyNE5lTnFiSHZKVisvb0VJVldVc2FRbkZnbHlMQ1ErL3dBS1Bqd0RG?=
 =?utf-8?B?eG1ac25nRHNOWWt3alhxdXFzV2FmaklXWHkzaXloVWduODlTNFE4NElpM1d5?=
 =?utf-8?B?R3FpQVRPYm5JenVJSklvZU5xS1ErQkFOL29nSVl1V0ZVTnhkeFN0MGpHd3Z6?=
 =?utf-8?B?czJUM2dMQmhhYTBTVDNVKzZyM1lBT1l1UXh2YUM2ekFEVWM2N29UcUNGVFQy?=
 =?utf-8?B?Yk1qT1VUSjY4YUdGR0FQTmRtcGlPMXVNWENGcHc4bHUvUjZUZTdqbnMxNDIr?=
 =?utf-8?B?VjFBUWcxY1loVkl0SWxheWR4ZkhXYjNUanRqYmFIRzdiWlFUbzVDaFFmN01T?=
 =?utf-8?B?VXArUjc4MmpDQnpselp6Q1o2MFlPdTh5OTR1WDllcklwVnYrbDd2N2hMREpE?=
 =?utf-8?B?UFRSc29PWWtFdGI4cVlOZUlnaXhKd3NLSEJYMnpSd2Z4THF1bE5iVlFWWGIw?=
 =?utf-8?B?eWMxTUxxTlBjWGdLSUR4UUpVQWY3V1RSeVZaSUcwQ21wTFpUc2VETkdsRzNt?=
 =?utf-8?B?aVQyeFJ3aG5nVFVsQkdNOHdTM0NST2JDc1U3NFpHMjNnSFhtb3RFclJzLzBy?=
 =?utf-8?B?NXdKTlV1Y0J5RjhaSE1RYmppK1A4SHlpQnNHcERLaWJ6QTJod0orR29rUjB3?=
 =?utf-8?B?ak5CR3dCa1NqZjlja2djb0Y1ZTBLY0RjcFFWeXpXb0hrbjdLQzNwUERPSzFi?=
 =?utf-8?B?QUd1b1h1NC9JMXFzalhESGpjUnNGL2tGcE1HTnl5WXBxUXAxck9FZDNlMy94?=
 =?utf-8?B?c3VuQnZIV2FGU0FpaHlmMVZhNktzUDNIQW0wSGhRMWRqdzBOT0pwL0tocEJ1?=
 =?utf-8?B?QytLVGJvTGZsaUdkL2ZpbEFranN4WHVJWDkyTXd1R3c5cDM5Mkd0dElLTDFa?=
 =?utf-8?B?alZnRGcwa2dhOSt1KzFNUkRudDF5Y1FjUTBoaWMwSUJ3QnVqUEFPbVhQK01J?=
 =?utf-8?B?REN6aXN5T1ZXZEcwanN2VjJrSnJlTXhHa0hFbVZFVEtJKzBFbHRRZmc2eVBL?=
 =?utf-8?B?Rk9vaHcrSlNCQkJxcE1Sc0h6MlNMdUpwRzVOZ2JRMk42bm5lOHBtT3pXdm9q?=
 =?utf-8?B?aFdKRVdwdWpYd2Vma09tRUdnNjZBVGhOUlhRZ0piS0pLSUs1N09YTS8rd1Fa?=
 =?utf-8?B?K0NxRUE5ZjFIaG1vZ2gxY1F4QTJiS2M1NEt3SE5VZGJibGNSbGV2T0Q4NVds?=
 =?utf-8?B?OU81WGVIOHhmUTNWSXJoVVlyVHhvdmZhdDBHSnlxQjNhRWxodVV3blVlSmI0?=
 =?utf-8?B?b1dnMm1nTXlLZVR2S2RBNFdWUU0xTXVjdkpSN3EzS1pLRXpUSFVraVBWMlhH?=
 =?utf-8?B?azZTMG42UFA5TXg2aThENU03bWNxbUF4cDJCNEFsTlBHclhkbnpyam1yN0R6?=
 =?utf-8?B?Q1o3QXN5N2J3STl0ZVFBcGovcUJKeWdJSXFIcmM3TFhweXJSTmoxRFA3emNB?=
 =?utf-8?B?MXBlQXIvUTlMcE9Dd213MGJ5RTR2ck5nVUNsOWZHaFhiVGUwTm0rYTV1UnBQ?=
 =?utf-8?B?OEZoRUsrb2RzNFFQcmRjdlpvZ1NYRTR5RTlTMUtkTzdyRnR5UDkrZzYzVlYw?=
 =?utf-8?B?OU9ER1hWTW16ekh3T2ZSN295NmtMWlkvS3JPK3J5RjM0NHJDenk5WHJTQVo3?=
 =?utf-8?B?Y1Z3VytKNXYyeTNLTWV5bkNCM1hXUXNHUGhYWGY2SFAvbHJBeERwbnh0RGlt?=
 =?utf-8?B?YjR2QmthZnMxR3lXREhrdnY1bzlRPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4ec4de-fb17-4a40-efa4-08dc0c23e695
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 06:19:11.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFCljxlJHEUCbJAY90YvxGRsYjpe4+x9sw80Xf70nX5Bi1Gc0/18nalKYrsdK12V/EXeNnlAcSWn12Z6Eq7Hjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2245

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

