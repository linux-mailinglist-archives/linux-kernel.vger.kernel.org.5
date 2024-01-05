Return-Path: <linux-kernel+bounces-17912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890568254FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C219283C0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6680F31A94;
	Fri,  5 Jan 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="S/8SUKsg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29942D7B0;
	Fri,  5 Jan 2024 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/QPTRoJPsHYzI7Y/eZi8f48OO6K+1YbYVmB6BkSqAIjT7SGQugK54lk/WgNWUJuxPpWi/TqqD7AAJmlJF0ZyR7Dy/Jv4DwJCF1Mm2YgqgI6Vqilld5EIPRUvREtID14QfAHiWTtl6duNX88w5sW7QEp7v8TjUm7P2DndS0dUsp34y2k6QGlXjoH21l3gSOuan0OgOeZ72DIx6647TzhEQxSfwUeGSyyyivU3V2YO7DqxUm6c+H7hHITIMK1QUVIPVRoeINRLzwitwV9EacepO9sP02c2IeAOCZV0mxKsLnAAWF5dS1EJw9+zfT182R8MrgQJYc0tOuxrSi3GYmrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO90q+6gxUPedgZTk9T0oK698FDczikJmPxC4jA222g=;
 b=R4Zqkxe5ntveX9ULH7nAeWgXtGDbpXaIu3I4KwCo+0Opn/WyVFXdXzUKteDog5sNyjqWVXpKQQdUyHd5YDbQcCwPIBDUPL5puZGM3hvpgwX340hHWZzxXm/6RFY+z6fllmsTjSvKJSKc1G2v2VFrIc4q98nOMnLWb+nXiRuskdjoMsMGzgBuMVbGV3YsjM396HMciOW/mf7z4X4/6UUOAKDkKYvxBfbhtdWx4BdjgPWMtTVLacHOJWQrGE4V3bNhn8zJaoVhkpyiPvWKJvTYKul+N+9d96rZzMPkl31ceAzWpC6pKyeDe/9ca/QpSAeIwiHt2E3TILl5sw7J0+E7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO90q+6gxUPedgZTk9T0oK698FDczikJmPxC4jA222g=;
 b=S/8SUKsgb6ZvPyKEW3G7bHLLjcnakHCwQk6KbH1eGc8ubt6BTWToeGZZxaGSwSH4/9/4wGWaqiJMm7yCW+R8BhhcCamWFJeBgAeXl6XEyW5rDbfXMM5CTjNLLjgO1jK//pkMARRaXjnnbQgif4q/yTS5l1rN6MEf814owlHzLKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM9P193MB1538.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:12:18 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:12:16 +0000
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
Subject: [PATCH v8 5/7] serial: core, imx: do not set RS485 enabled if it is not supported
Date: Fri,  5 Jan 2024 15:11:51 +0100
Message-ID: <20240105141153.19249-6-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: b1625078-dbf0-4cdc-83ec-08dc0df851d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zkrSp1WpqhNISZxhdP2n9577Lf+dwFRdRHq5Q8OERXCKHkBRZdFQkNewckBDRs6vFXPGa1wQtxjI+bCdocAkcqyxDELvaoKmqe8WbJcZk6KYenm/MxH9n9kyEFyDdU+mG58NvELBav99A45UrPBIZx/lkAkkbRVnM+0jR7XmQ7wqprGaCTia9n6yZaLnpDhvByu24I78ItL8QDWSLT4MkodysWY2ZOXMfEgFrH4inFEaNl3lY/xLWKnloUdNK4V+GbMncI0PaHktfwQzj+HjX2M0TBvvBnDOiyazJPpS6P8fKmsgXoHyNvxGSFRDDgyOL76m8MY+Jepe3hnN2pWNEh43dRpahgjOF3cQNVfAjGx2l2Ud01kXhktHhJa75rv9bkGb3lL6M10uqK1Yr4P2gsQtEwvaGrgSRBCnanTiT+edAybTpi2EswRkskx1nGxotI4G5qPNH2ms6HJmFEjvD378t3Blhs+f/4ie6FZ9M6AbfSreCC4Gh6P3E2LlVLbNEp43HB/E0r2TIHvvHiQT1qjx1IpRf4yz28DKSoKAd3OTS1Kt22TRv4IiQdX5mbjw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(52116002)(6512007)(478600001)(6506007)(66946007)(66556008)(86362001)(66476007)(6486002)(83380400001)(38100700002)(2906002)(6666004)(2616005)(1076003)(7416002)(4326008)(5660300002)(41300700001)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0NxdThsVGxpM1lGZmlMRVlVS0lVVEhpZEpXRTB2VzVFK3pUU0NlWnBhSXFS?=
 =?utf-8?B?UkRrRjRhK1M0RjN4VVNVL01VRVZCUkFiOUxVTmtLdW5jTGdGS1ZWbXZTd1E0?=
 =?utf-8?B?aHoya3RudVBIaXBYQy9XVjFkLzBZS2hZMUx5TlFQaG9rQXpHMkNVWDN5VnBw?=
 =?utf-8?B?STdqaVlra3IvbW9pcnpMRklpSG9qN0ZublhLa0lYVjdnZm9FMzFXYnl5NzQv?=
 =?utf-8?B?M2hPV1E3R0NLSVFPbTNJTHVrdG5RNTRCb0VaeVBRMTJ4aDhuMHVSVnoreWtS?=
 =?utf-8?B?aXBXRzBBQ29FME1QU05jcXh3MXhMRHNHWHdXWXlkaTRhZDJzZ0RDNStGMkla?=
 =?utf-8?B?aDdMb1oxRzZmQWRpR3VoL0UrRVk2c1F2ZkRNWWh0L0x2cFgzdG1JYS9tSnlk?=
 =?utf-8?B?UG1oeUFxSXZpRGRuNkZQNlpxTG9qYzFUNkw3TTJUaFdBZEFWcVNUWkhjK0cx?=
 =?utf-8?B?aVRkczJKT3J2eHpkQU8vL2ZvOVdPSzR0a3JTaHN5TW16cGpLdWRWSlRIR2Vz?=
 =?utf-8?B?UFo3YmI2QkJqellac1B4aVlESzVoeDV4QVBBNUxta3ZnUmNjZ25IOHQzVnk1?=
 =?utf-8?B?TXBkVnBicFVLTU0vYVVRakVqUm5EUVoxdk5TcXNIelBYZmZBL1hSSXB1TDFx?=
 =?utf-8?B?bERXeHVpMlVKS0htVkZNejBsczFhMzJtazFFMm1OMGdlb3ZCamsraGhTZnpk?=
 =?utf-8?B?ZXNsM1M5NkRDK3pLMXRZbStWL2dVb3V5aElodzNqd0NvQXM0TTJVcnN2YXlx?=
 =?utf-8?B?djBxblVlUXpMenpCUXFyWUVKM0NTdTBocWI5Rkl2by8vT2p4bFUzY09SbFFF?=
 =?utf-8?B?OENobHpvWUVRL25MQksyWVBkc1VTVWd2MTVoVUhSVnY0WGhJWlZzTWR5Uk5n?=
 =?utf-8?B?aDZiQnBNWU5IdFhWN1BmUW01RkcvREw2cEMxVkhMMXpHYjVRYkVWWWp2ZDhN?=
 =?utf-8?B?Wk05b1FUUi9jTEhPT0ZFWTVkRmpqNXBMS29Od29IeTkxUDU3UURMbk5UZ0V0?=
 =?utf-8?B?OVVhWU1NcktqRnFCZ2JTQW15M0J3MXhXL0VkOE8waXRldmp2QzRqUWtRYTFx?=
 =?utf-8?B?Wnh5VkZnSWpHamEvbGNkMllkSjdCLzFnMTZ1MDZGVkR4QytCUUkyay9xekt3?=
 =?utf-8?B?eWxxNTlkd1plQklYTTRPVW1laDE3bExXVG4wV2hqNGd1UW5MbXpYSWtNWEc5?=
 =?utf-8?B?TDl4QjN1RVhWNXMzYWVZazBCY0ZzOGVBaG9YeVBJbTBjZnlpWDBsTHQvOXFS?=
 =?utf-8?B?MTVyci9zZ0xJa3Z4RHpTWU1ndng2NnZJajZsVUp4aXcvdURJa1hCUmRQRnRD?=
 =?utf-8?B?dVN2RTNlNDF3eG95cWxreEgwMTRidlp1TnUvdVFWYzJ1dDhaUlRQMzg2VUlz?=
 =?utf-8?B?NEdHRzU0OGM4RktUYWUzNzdoOWpQWlFvQ3BiQy9OdEp3WDh0eGZrTXRiQkoy?=
 =?utf-8?B?SVBTSzNZMHd5Z3dzbThYRFZteXFRd3JHT1RCY2ZPbzAyMDErT2dQMFVvN3F3?=
 =?utf-8?B?ekIzVUZwYTdzNVdvYkZDdDdHSy9mVTNXTnc3dUI3Qmk4SmY3dXNJbERPQkZy?=
 =?utf-8?B?L044aGlJdWI3NjduRVVWTysrdjFjN1lIWUxSb3FPdnJHMnFqYUtlVkUyUVRi?=
 =?utf-8?B?VEJDMXlzOEhSZTUwb2t6aW5rLzlYWEpCOGZkYXlFMG94OVRxbkIvNVRUdnFF?=
 =?utf-8?B?ZGpkNGViYmh3dXcrWmVjejdpYldiVE9NK0hnR29NSGNiR1A4WkoxT0M1aGtj?=
 =?utf-8?B?ejVkdE5KMENZQ3ROazhULzdITldwRC9ocU1leVU2UGlXRDkxR2pSUVdDUkx5?=
 =?utf-8?B?VllvWEN4OXJvaWhNRng3eTk1dFQ1ZE5hWlc2UXVkRTc1Myt1K0NFZU1UUXdD?=
 =?utf-8?B?YmtkaTRROVdRZzBML3BiM01XMHVzczAyUHFZVEFzWnFTSzF0UkZPQWFqUTBR?=
 =?utf-8?B?b09hUTlvQXYxYXpTcko4M2JncnFCbHRNcUNCU1NXWFFzVjVmRmluSk1SVjZM?=
 =?utf-8?B?akYzV3ZSbGhWaG8yakJld2hIVm53b3BUOUxnZmdoU3FXQm4vc0hyNWNLOEVX?=
 =?utf-8?B?TFFreTJYNlRCMFNCSFZsQ1gyNEtSWUU0eC9sRkVNSnhsbk5lQ0FJSGVCVUdZ?=
 =?utf-8?B?bGJ5ZXBsOWRQTDlaYjBhdlpka3pCM1Nxd0VUY1h4Nm9CYlNzLzJGMTRJNDFO?=
 =?utf-8?B?Q2crQWx0bExhd2hZQi9CbmM0L2FERmt6WEgxOUI2c1hWZnYxUTdwUEZzVXVK?=
 =?utf-8?B?UWJGTmRYNnBVaXF3Y1hvaVlVUldRPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1625078-dbf0-4cdc-83ec-08dc0df851d7
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:12:16.7359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ga+VbiUBD5SXtC4BDn1IouYSM/sF6+VEI8cboMWmc//Qqj5m37LAi7aUZa2nzlaGr8fuBKhHBPc7MXEGlUTxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1538

SWYgdGhlIGlteCBkcml2ZXIgY2Fubm90IHN1cHBvcnQgUlM0ODUgaXQgbnVsbGlmaWVzIHRoZSBw
b3J0cwpyczQ4NV9zdXBwb3J0ZWQgc3RydWN0dXJlLiBCdXQgaXQgc3RpbGwgY2FsbHMgdWFydF9n
ZXRfcnM0ODVfbW9kZSgpIHdoaWNoCm1heSBzZXQgdGhlIFJTNDg1X0VOQUJMRUQgZmxhZyBuZXZl
cnRoZWxlc3MuCgpUaGlzIG1heSBsZWFkIHRvIGFuIGF0dGVtcHQgdG8gY29uZmlndXJlIFJTNDg1
IGV2ZW4gaWYgaXQgaXMgbm90IHN1cHBvcnRlZAp3aGVuIHRoZSBmbGFnIGlzIGV2YWx1YXRlZCBp
biB1YXJ0X2NvbmZpZ3VyZV9wb3J0KCkgYXQgcG9ydCBzdGFydHVwLgoKQXZvaWQgdGhpcyBieSBi
YWlsaW5nIG91dCBvZiB1YXJ0X2dldF9yczQ4NV9tb2RlKCkgaWYgdGhlIFJTNDg1X0VOQUJMRUQK
ZmxhZyBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBjYWxsZXIuCgpXaXRoIHRoaXMgZml4IGEgY2hl
Y2sgZm9yIFJUUyBhdmFpbGFiaWxpdHkgaXMgbm93IG9ic29sZXRlIGluIHRoZSBpbXgKZHJpdmVy
LCBzaW5jZSBpdCBjYW4gbm90IGV2YWx1YXRlIHRvIHRydWUgYW55IG1vcmUuIFNvIHJlbW92ZSB0
aGlzIGNoZWNrLgoKRnVydGhlcm1vcmUgdGhlIGV4cGxpY2l0IG51bGxpZmNhdGlvbiBvZiByczQ4
NV9zdXBwb3J0ZWQgaXMgbm90IG5lZWRlZCwKc2luY2UgdGhlIG1lbW9yeSBoYXMgYWxyZWFkeSBi
ZWVuIHNldCB0byB6ZXJvcyBhdCBhbGxvY2F0aW9uLiBTbyByZW1vdmUKdGhpcywgdG9vLgoKRml4
ZXM6IDAwZDdhMDBlMmE2ZiAoInNlcmlhbDogaW14OiBGaWxsIGluIHJzNDg1X3N1cHBvcnRlZCIp
CkNjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+CkNjOiBTYXNjaGEgSGF1ZXIgPHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClJldmlld2Vk
LWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+ClN1Z2dl
c3RlZC1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5k
ZT4KU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNv
bT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgICAgICAgICB8IDcgLS0tLS0tLQogZHJp
dmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCAzICsrKwogMiBmaWxlcyBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkv
c2VyaWFsL2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCmluZGV4IDljZmZlYjIzMTEy
Yi4uMTk4Y2U3ZTdiYzhiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKKysr
IGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCkBAIC0yMjA2LDcgKzIyMDYsNiBAQCBzdGF0aWMg
ZW51bSBocnRpbWVyX3Jlc3RhcnQgaW14X3RyaWdnZXJfc3RvcF90eChzdHJ1Y3QgaHJ0aW1lciAq
dCkKIAlyZXR1cm4gSFJUSU1FUl9OT1JFU1RBUlQ7CiB9CiAKLXN0YXRpYyBjb25zdCBzdHJ1Y3Qg
c2VyaWFsX3JzNDg1IGlteF9ub19yczQ4NSA9IHt9OwkvKiBObyBSUzQ4NSBpZiBubyBSVFMgKi8K
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGlteF9yczQ4NV9zdXBwb3J0ZWQgPSB7
CiAJLmZsYWdzID0gU0VSX1JTNDg1X0VOQUJMRUQgfCBTRVJfUlM0ODVfUlRTX09OX1NFTkQgfCBT
RVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQgfAogCQkgU0VSX1JTNDg1X1JYX0RVUklOR19UWCwKQEAg
LTIyOTAsOCArMjI4OSw2IEBAIHN0YXRpYyBpbnQgaW14X3VhcnRfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikKIAkvKiBSVFMgaXMgcmVxdWlyZWQgdG8gY29udHJvbCB0aGUgUlM0
ODUgdHJhbnNtaXR0ZXIgKi8KIAlpZiAoc3BvcnQtPmhhdmVfcnRzY3RzIHx8IHNwb3J0LT5oYXZl
X3J0c2dwaW8pCiAJCXNwb3J0LT5wb3J0LnJzNDg1X3N1cHBvcnRlZCA9IGlteF9yczQ4NV9zdXBw
b3J0ZWQ7Ci0JZWxzZQotCQlzcG9ydC0+cG9ydC5yczQ4NV9zdXBwb3J0ZWQgPSBpbXhfbm9fcnM0
ODU7CiAJc3BvcnQtPnBvcnQuZmxhZ3MgPSBVUEZfQk9PVF9BVVRPQ09ORjsKIAl0aW1lcl9zZXR1
cCgmc3BvcnQtPnRpbWVyLCBpbXhfdWFydF90aW1lb3V0LCAwKTsKIApAQCAtMjMyOCwxMCArMjMy
NSw2IEBAIHN0YXRpYyBpbnQgaW14X3VhcnRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikKIAkJcmV0dXJuIHJldDsKIAl9CiAKLQlpZiAoc3BvcnQtPnBvcnQucnM0ODUuZmxhZ3Mg
JiBTRVJfUlM0ODVfRU5BQkxFRCAmJgotCSAgICAoIXNwb3J0LT5oYXZlX3J0c2N0cyAmJiAhc3Bv
cnQtPmhhdmVfcnRzZ3BpbykpCi0JCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIFJUUyBjb250cm9s
LCBkaXNhYmxpbmcgcnM0ODVcbiIpOwotCiAJLyoKIAkgKiBJZiB1c2luZyB0aGUgaS5NWCBVQVJU
IFJUUy9DVFMgY29udHJvbCB0aGVuIHRoZSBSVFMgKENUU19CKQogCSAqIHNpZ25hbCBjYW5ub3Qg
YmUgc2V0IGxvdyBkdXJpbmcgdHJhbnNtaXNzaW9uIGluIGNhc2UgdGhlCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJp
YWxfY29yZS5jCmluZGV4IDI4YmNiYzY4NmM2Ny4uOTNlNGUxNjkzNjAxIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
c2VyaWFsX2NvcmUuYwpAQCAtMzYwMCw2ICszNjAwLDkgQEAgaW50IHVhcnRfZ2V0X3JzNDg1X21v
ZGUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKIAl1MzIgcnM0ODVfZGVsYXlbMl07CiAJaW50IHJl
dDsKIAorCWlmICghKHBvcnQtPnJzNDg1X3N1cHBvcnRlZC5mbGFncyAmIFNFUl9SUzQ4NV9FTkFC
TEVEKSkKKwkJcmV0dXJuIDA7CisKIAlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzJfYXJy
YXkoZGV2LCAicnM0ODUtcnRzLWRlbGF5IiwKIAkJCQkJICAgICByczQ4NV9kZWxheSwgMik7CiAJ
aWYgKCFyZXQpIHsKLS0gCjIuNDMuMAoK

