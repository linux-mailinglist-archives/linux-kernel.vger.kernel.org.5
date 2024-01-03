Return-Path: <linux-kernel+bounces-15211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0664E822865
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1051C22F15
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CBC18E06;
	Wed,  3 Jan 2024 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="hlRPHxUT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9433F18AEF;
	Wed,  3 Jan 2024 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/BoAtEo4+jettHSX3QXWeO2bVAO1urqJw+CpulYdsDwZedK5ybV+SM0QvqeHYSsosyo8rgkxMP4kgOYYfBiUkJ4b/abILDGPeZjDL9rOFZdSa1g4H9OHtBne0UrQ+QNVeMQ9eKguJRz9pvYZqeWfpMck5bKcwIyNGKESYBTnSFtrpVa5Ka7c0/svjrbjdbNGW7Flna7tFyIEdphREmJ+5Gkmzrep/5uMXn48xoGNXuLJrDm0iW2vWEsT1vYRpaga0S6ak8Bptw1s9tCLk6CzuVbaXne07nlNMC+7f9rsyDbtvyS8n5kt3L6Ikxb68YH2MYN6MZ/reHTuvqnEs8vEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BcGoe+ESDzoCivkDyl+SvQ6vxiyAUtVpHN4Fyf7TKI=;
 b=Q11JJE0u/SbCoilMzsMC279WfaNtlEqNoVFNNpeyLJ/8ldhz0Sfq2PEdt1l42cdCCEHIIlKFtt6fTaK29ocIn6yi+5WBNiswZQqH0EAQE6vLh7f2wez/mf4JFtxt8Oblf2JZ3ph/UvC6SJfQBQZlGpGhwDeLkCzXnUkQ3gFhbLEjtnrfQmNMwIEH0sO4i9v3K1Bx4erAzi4oZabjkvNQAjYgzy2q896lmP/85QUhGv05pr2NxYlyhwNtIhJZVqaYt4VDpm8WYwieErT9c0U2T57BgYm5EAxZRslQAl4Ny/2Nj6/ZR+/ZjxnDlutXIlJLS6OTezRsos8cmpHMz7D5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BcGoe+ESDzoCivkDyl+SvQ6vxiyAUtVpHN4Fyf7TKI=;
 b=hlRPHxUTZXM1jLsUtxbGH6StlAXqbRYeDqgOmCTCGw6Kvy3BSB/KAuOiGyFvNjSA1tFRAoJzJu43Z/OozJ/5VCqF/8qCe87kJVAYcXwpK6fflQsw1dPPHHFI+WREp02C1XKxnF87Mv81F9C4VPa8u9vCdxGAPvZQWMzyR2KnuUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2245.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:19:14 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:19:14 +0000
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
Subject: [PATCH v7 7/7] serial: 8250_exar: Set missing rs485_supported flag
Date: Wed,  3 Jan 2024 07:18:18 +0100
Message-ID: <20240103061818.564-8-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5442ca88-43cd-41ab-1b81-08dc0c23e881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i0i10wbcsseClDcPxXTkxp/eOzY6dlwiOAs0k+BQIj8AUmIg2obd0kyrGUMwwjsG31dn5ymS7u68aaoRjGIVb0+MRI9Nk7cbdyLf3wDbxVCxj90w9tmj4GPGToPeYvLFqsYtU6XRw31oC2ShLehceFSe0f3XZiN7t4ywP2qJYVx7u7ubvmVWpDsHpQ90t3AjNPrUDelzColVcHhB6LPKmEdviHa05n+UdKKybHOHW8gZ4JEXoq+JyQXa8Ucba1tTRaxLUKp+0sZfIIhelh2B2790beSH7x5r7Xud7LuaqQefcG+JJp+7UmQ5z5naFBrMQ1VHtNjZFSB2SD3MZU9p9Z+EwVUTMUqlbxiLb2I6Nzx9dG5Y3FALs1tq7hrc04h73uRjQ5ymzg81oLogmX9sJmmTmHjahIzhhygC2QTDOQIZoawdsFi+YPSzHuLNZwY+cxKKXqCTS0jj+eEldBYQNE2tm8IFp77EkfKz3ZKAehUM/ePoUduO2GjAcAaK7kvFfzV2GU78Boy8j1zJL2vieDnaEdLylpY9VXYV3zHh7UzRVo8VAFGmwxZi0ZDWLFd9H6efcW7ZLQOsExQd9hhvB0x4i0eiIg8n6LFw94BHlBC+d8zQveLHctLgqEScwtnx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39830400003)(366004)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(66476007)(4326008)(478600001)(316002)(8936002)(8676002)(6486002)(83380400001)(6512007)(6506007)(52116002)(1076003)(2616005)(66574015)(7416002)(5660300002)(41300700001)(2906002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUVCdkhXc3BIdExPMi8rcmJCTjJoTzN6K04xNi92V1pKc0J3aE4xZlAxa3Q1?=
 =?utf-8?B?TkdzY2hVWU1UUnNsbmxYWld5cGdIa1Z0QU1vVzN0a2xYbHRNU1lPZXhTQlYr?=
 =?utf-8?B?SE5SdkRRNFRBaVJOR241eENVTDNoaGQxa1pYODV1THVSQzlPOUpNMmMybmov?=
 =?utf-8?B?b1dnS2NlbkozQkQ1NHZVUUVoOUhETHQvTU9xYkUxV0FhTmcvMzZ0dmsyT2Vz?=
 =?utf-8?B?Zlo0bWVPbkhZbzFVcjNWK0ZGNWFSVTFyUmZyZG5ob256YlVlYWxpb1AreXZH?=
 =?utf-8?B?RTUzakl6TlhVWVRTR3FlRUdZUTBzSG1nb1czWk5WL0NrNVVJeWRZbENjdmlJ?=
 =?utf-8?B?c2dseWNmV1dmY0orc0pRVVh6eEhraXMralhNdmpLbWNCWGZSaGlER1hBdEFD?=
 =?utf-8?B?TlJQZHltZ2ZzOHpTOE9LK0V4LzF2UFNjWGNidVVBUkcyclhsc2RJLzlwek52?=
 =?utf-8?B?Y051ZGhwVzY5OXpTQjZKc2RhUFJ5dEJsNVgyYVJ1UHlEUFdvYXFKQytKM0Qz?=
 =?utf-8?B?aWRmNm8wbU41U1l2RVVpaHA5NE9pek1OanhOL3oxZVd5NXEwUU1jMnpWalRh?=
 =?utf-8?B?aGNTR2FKSnFLWFhiSlNWOGNlK2FRUWJlMy9SdTFYbmlmNDhyMUpIRGR3dGl1?=
 =?utf-8?B?VWs0b3hwZzJBV01ZaUpKVVU0eWVGR3FVNnlrT1FweVI1NjRPeE52Yy9nQW5O?=
 =?utf-8?B?cGVHbkdKSkFWcldaclNvU1g3bnpPNjBld0o5dVRJdTY1YlQwMmdIRlN4K2pG?=
 =?utf-8?B?YWYvZFNOcUN2Um5rcmgxOUxsVHhweWg5Wmt0T1FFZUo2WlZ6VlFTSDlLNVBm?=
 =?utf-8?B?eTA3NGpEd0Jmd1lUTjVYODFKbzZTSkJiZVpieGd3WGlFV3AyUTNaUE1uNThK?=
 =?utf-8?B?eDJFdW5XQnJ4ZWtNbEh3N0hOeUhrc1RjSlY1T1Q4QkZnNXRlbTFJSDhOVGxM?=
 =?utf-8?B?QzFFVytxQXYrRkJ5dmRZUGo5ZFV6dWM5VXpoM1c2VmpPOC90M2x0VE1aY2I0?=
 =?utf-8?B?U2UwWjIrL2FEMnlxRzB2dm5MWFhrVUl2a1BGUjlQejQvQUd4aGdjZXBZazJl?=
 =?utf-8?B?Q3ZCTndPS0k1ME93aEx1N2QzVWtZczd5L1RkaGZBcHQ0MXA3WlNVemdUdG9j?=
 =?utf-8?B?eHMwWjllWkJHWU5IUWlhdU5BN2xjZ2lNT2swa0ltL211bzJ0N2J3Qlg4aUxV?=
 =?utf-8?B?eHM3bDQ2RDFkdzVjcHpidkx5bUx1Q1VmRlZ6UWg2bHdmaUpzc3FMUFNZQzMz?=
 =?utf-8?B?aW40VUtVQzRyQ3ViQndRdmF6NVlTR2NtR3BsNkh6QjlZUWtRM3U5ZU4vOEE1?=
 =?utf-8?B?akFnTFgrc3l4TExIbTZsTGcyUTlaRFhPQ2JZQ0pES0NPMUtVb3BJM1pUdWpY?=
 =?utf-8?B?ZG5iRWJwRHV5aE1wTWlQM2NnOHhtWWF1S3ZxbGVpZGo4ZlE0REFmWWJDaklN?=
 =?utf-8?B?MmgzOW96TDhBczNidmRpSGI0L1RLZ0ROZUlZRmdzaXg4N1g5aW1iWFRPWml6?=
 =?utf-8?B?bXEvL1RTWmVhUVEyTENsL3hNMWRZeGhLVDRPVnNyZmkyck1CQ1pZc1hBNnVU?=
 =?utf-8?B?QkJUWER0RnJZNUhLVm9DL0hsR3NjczNGOEVjdXRSVnBSakR0SWJldC90VmI0?=
 =?utf-8?B?YlI1OExoWksvUUdMNmdrS1pFdnVmMFNGMDAzNHhQTHJuaXNHWW9WVjI4RlNL?=
 =?utf-8?B?T3BMV2ZPY0V5R1pNaFdwOVZXeFY2L1BuQ3hFWGFmWThWTVlxdFY4N250R1Zl?=
 =?utf-8?B?OE1pMkU3RWdTRW5VKzlDMFJlZjlSSkVqby9CbEpESzJOOUNVSjRVek9QamtT?=
 =?utf-8?B?TlVGdDluN3ppc2g0NWwyUlIrU2Q2V1FSUmJlTkpwdHZyTE9xdXlNZEZSQzFl?=
 =?utf-8?B?bHNvR0RwTVVLUzhmSFMrSWM4czl2K1Evb21rS3FwMVdFM3BDUjVhcXhXUFlx?=
 =?utf-8?B?R1dvTm5uRklxbUorbTd2SWJXUWkyWGVVck14amFoaU1QZncvR3IvNzVaTDN3?=
 =?utf-8?B?bE81TmlvMVNSMk4xWEdrbmQ4Q3pBMDkvcVBkZGViWWg0NkhXbFFzSFpSb0Iw?=
 =?utf-8?B?bHFZN0YyZnpSMjdoa0FTbjE1citGenI3ZEQzTlg0YysyaEtTR3hhNWhZbHRL?=
 =?utf-8?B?TWpsZXl6azFEVW9UdDVBRkUvMjlOTStWZnhGSk1nd0tCU0hlaDRpeHVQK3NW?=
 =?utf-8?B?RncrV2pqV3g5TWxGZG1XVUtQVFczcGFFN1A1a3JtcWtMTHk3alI4QzhteHV4?=
 =?utf-8?B?QmtpUTNCcDZqZGNyVHFHRnhISUN3PT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5442ca88-43cd-41ab-1b81-08dc0c23e881
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 06:19:14.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThHwi2955tpYL1VnFuPrqJoY5gVfMa7LI713tMIqHSqQjRm0h1Up4J6qzYhdDE5guumhg+khpNMKXf4g48I5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2245

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

