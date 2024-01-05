Return-Path: <linux-kernel+bounces-17911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAD58254F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE89D283C6A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2E2EB1D;
	Fri,  5 Jan 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="X4yanZ/f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2080.outbound.protection.outlook.com [40.107.15.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F92E652;
	Fri,  5 Jan 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLauKdM8GrYIQkQbUFaKq/DfLSq8tG4C2U0qlHIoFyYttTQjTBoXQIrHxDXeqvVSw9u2/xuU8gRbsEuLEdV19o+9icnRBAA3bPv+/zl4YGdUja1To1aoyIWCPiVDBS4qzPeBs9Z/Rx9/iDx1oRqIi8a/wvcraJBrptJwZz2FVdOy0MRr4P5fmak9bqPNE6zsSVSLW7OzIKEzOiFCZZJfhlyyj31AMvTD2KarF4Va4sgJaJ85qQyZWLhVq4U+HT+jJ6YOv1OtjHHYUgBRKPGeBDmPiCv40p33P8Xu0yo7Ni5TBNrWNM4ch5iwn/4EBhEstK4ZeGjFpcILCVEr5hKTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aG14v1l0mNKMp5n7ZH3UkcOWh/FnIG3dYuQfg/M+qPs=;
 b=XT/qUy9uO8JAvJBHdTjAsZOMk6Y9Uq7CYz+jIrBm7vYAAmwRZJ3IHgFORrtcwylqAGQfQmpa/bmS2XsfslbIwCNouc8vnnULqFxRNZ94h1jOePu8mam0Gm+s1BpZFfEqYibGpGb9YEu5tCYRur5p9q3AG2DrY4jWP/bYeAvoLaf4EJtDNe9lZUl5kWOFJzaSNiN3yg1UCJq5iX3bjiu+31ol0g8J+8z3G4qdOUEvd0x64m5xhUoe2P8ESvDxU48ilR8AL4kIODfEzpcPfQ+OZcz4QLrnVozQKgCZWUZFlXY7q7PrbYhUb+op+k1rRljAN0mQGbDYkkYzaz/3vXwcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG14v1l0mNKMp5n7ZH3UkcOWh/FnIG3dYuQfg/M+qPs=;
 b=X4yanZ/f/oZgGQcZz+ma9CBBSUKpKx1uEle5+dCzEZAlPL+6qU1usaimqA1hKJE8rfM8WWRRUnz7m300pnDak7JzYWivXf11hGYbaFrcbmnU0CkV+C95Pq97scXIvV+lkcW2VRjI9DdIsEa4PDwncdaXlF7+HXO3Y2l3PjJMWh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DB9P193MB1403.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:12:18 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:12:18 +0000
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
Subject: [PATCH v8 6/7] serial: omap: do not override settings for RS485 support
Date: Fri,  5 Jan 2024 15:11:52 +0100
Message-ID: <20240105141153.19249-7-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6ab6fdf-e054-45f1-9e7b-08dc0df85371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R6/SgkcEoxjAk8kKHxgrt9h24fYdsVaYgu5RaU+dxI6L7uAx2o7JBWwGnJr87+gx7WZKAnOBZWGJ9789A4PC2dfyeR5Vqok1/oGZxZ4bUF9KS0DDup4kpc6I7xvG0i+6uMxzSKOw8EPqMAfjznpX02h7T3/CbFycGqNexWwhQc4YotOPoMdxeZt3CInJIy4s4g5MN0Na13OWX98XA4q+q7S7sxb5hyBlXTw4FQmKTmXzvDsDkcQdhQJTTWeJO8kzm9mvff/c+t46NY1/h577fWi5vqzmCR+XpS8gNDwVYJOTYNdc8onZi5i3Hw8mGqpc8k0ct+0/Asg/od1tzmTppWHxNzYERygulYJR1nFp4NFT9npKjf9ZKplRT+Sm2v0Oe+4Py0OgQK83lWKi0p0HaczbdeEKUmsgkqSZT67g7RZsDj/bumNgOASNI9PB5/wA8NBCnO960eklOCOejf/Ib+6Um4SHah17AC/xVYQ+Sut+H7yE/8+bKmBPyiexmPmJ7ZN7FZKcnNVO77QTY+sMv8hNSYzM2LXWsns7ZY4xSRkclQUZfmtXNOS2PJMDRvS9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39840400004)(346002)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(478600001)(2616005)(83380400001)(5660300002)(1076003)(66574015)(6512007)(6486002)(66556008)(66946007)(66476007)(6506007)(52116002)(316002)(4326008)(41300700001)(86362001)(2906002)(8676002)(8936002)(7416002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmJvV0FMcHVPL04vejVxUFpvMnJwVEpTeVFEaUZjc2RkRHVGcTd1eW9FbFZE?=
 =?utf-8?B?aGhBRGFRM2NIMHF3eHhTV2lWL3M4Q0pGWFF0Uk9VNzEwVVhrUFdaWGphTzJT?=
 =?utf-8?B?SDM4K3UxUUh2MEVreklWaUdnM3l1S0JkTzJ2NmQxdTY2NDBUbGFUREljR1BZ?=
 =?utf-8?B?Y09pYnd1TU0zSVpOS3NzbzEzWmRzZ2RNU0xWVFBPdkp1eHZPZ2h2Y2hCOVlE?=
 =?utf-8?B?cXlaNzkwNnljeG5wVE9LZzhIT3ZBOHpFNi94U0NPdHFGU1BjMy84UE5Sd3F3?=
 =?utf-8?B?U1Q4aWN3RmxuY0NRNW9Yck1idjNJMWlDOFJ4cWJEVHZrN1FMbUtGVGJtVkRu?=
 =?utf-8?B?cWNpRkNZeVFuLzlyblIxM2lVOTNQc3I1Q2lxUjlRa0dpSVdwQlpGZlVBREVL?=
 =?utf-8?B?UTV1bWQxdWt4dVJwR2hhRjRheDlleUhrcW9pdzZEcTFKNUtOcFRtM2tTeDRT?=
 =?utf-8?B?V2VQNDgzYWxMWHcvVVdXZTVRZ0I1WnEzMXJKc1VleUJ3bkVJeGgxcjFoQ2xD?=
 =?utf-8?B?cnJpRmh4M0xpYTdKRXJPZ2g4TGZwTmtIdTlOSEFkVDI5MTNsSHNBekRJSGpz?=
 =?utf-8?B?VjVzUFZ0ZnJzWEhaMnlGQ3J6V2ZVYnoxc0JRLzExWEI5Y1JMQnI1S2JNWmFJ?=
 =?utf-8?B?VVE4dEtUYlQxdHdzU0t0ckJ5eHpyWVhnejhIRTBnTjVGOXpvejF1VlltS2hV?=
 =?utf-8?B?dlI5THJleHFHSzQ3MkFTRnpRYU9ibXErbW52TU5QeU8wd3ovZzIzV1NpRGo1?=
 =?utf-8?B?N0tpZ0o4NmhmaWVLWUZnNTBsYmtwVk5GSWZoMGFFVFNWK1VyZXV1cmhUV3RT?=
 =?utf-8?B?U2RvcFlpRjJEdW90WXV1TVBFeUt1RzB2TXdINmFGeW5pWUhGb2dIclhBd3Q5?=
 =?utf-8?B?WnFHbXFaUUF1eHBvZmF3KzFDa2pFZ1doRWxtUUhLQ0dxUk55Y0tuWnBXZmRS?=
 =?utf-8?B?SGFucU5qazJCamMyL0ROamIzR0NEYTkyTVFBMnNoTXU5a0lPZXdveS9PWFlY?=
 =?utf-8?B?ZUUzVnI3NXJ3OVVxWDZTdkpRTWVKNFFsQ2oyT1NDcGhNbGRsK1NTenRTL1do?=
 =?utf-8?B?V3dlUEdrSHhTemlGeG9mZ3lnMld5OHV6VWw2cHRnRFNOYWgwVGQ0b1lFVjNx?=
 =?utf-8?B?dXhZYUpPaVhZb2V4dEJwTDNCU2NYQnNOMG9oSmlhQjlYNklCVURuQ3h3cHhu?=
 =?utf-8?B?VGdhdTkybEVtWUNFVDNpZE9GSWF0RFdIR2gyMmxaQVozSE1UWkRMYlFyaWtl?=
 =?utf-8?B?VUQrWStlZXFEZ0RBZHIxVW1BY1preGdYRnNucWN2UVF0Y2lyeXFtMEVDUFc3?=
 =?utf-8?B?d0hNTnlXUFFBVWJzYjZjZUM0MzVic2JWQTlqcmZwaDArbkdkckR6ZXJVVklW?=
 =?utf-8?B?bkl4Q1VGYnF5cVVzU1hoM1o3WkY2ZkFqSnlUcWl4TG01b2k4RnNtOFJtVWJQ?=
 =?utf-8?B?YUpuZXBZTjg0Sm5RMDBmRUVRMGVPekYrdE4rVVAwUkJIVk5mNm9qSDYyZzUr?=
 =?utf-8?B?KzB0TXFoczdnTW1ORTNpbXYwSUdYMW5kZXpIY2kvc3R5MGVWdUZEY1Q2cGRj?=
 =?utf-8?B?OGhZdU9WVUdHWm83akFRK1dNcFk0c1ZlcTRmUjhUZ04zcEsyRWNsWmpXVzNs?=
 =?utf-8?B?azl6bnZkMVFqNnQ5eG1HaFJrZTJPUFNSNVp1UGJvazgxVHVoK1NZTS9zWk1H?=
 =?utf-8?B?U1JNdkR6Q2NRSzFVY1I0VldaTVpVOG93UzVJVmoydk0wc3JZSU9jUHRaQ05L?=
 =?utf-8?B?Um9sV3RaQ2RiQm1vbndCNExyODBaY1c1d3A3a05mRTRyZXdRMHR2R3R0b1VB?=
 =?utf-8?B?NzlVbDQ3czIzQjE3MXhPVGFCeUJlbFlGeHRFTGVjS0NGNEszQ2xYdmlPd3gw?=
 =?utf-8?B?cTdnUVZjZlVWSGVScGlxalZudm1taWx6bmkrY2hhVGZsNERaS0czSTV1SjVS?=
 =?utf-8?B?b1VZVi82b2lMT0lPb3NVYlFFTFR3TXdkb1J0UnQrZHVJbWZOTVNSYWVMTVB0?=
 =?utf-8?B?VnEySjBJeVdXMFRmQ3Q1N2Y5YmlIUnVmZUpTUkFydHJBU29uMGRhU2ZjdTh3?=
 =?utf-8?B?bU5ISkpBc0wrTUlham9UYkNHVEVrK2RJcHlNUzhtVVA3UGlwZGEzQitPMDJx?=
 =?utf-8?B?OTNQYkNSbnlocU1kS284WmtrSXZnZCtMYlVycGJqNGw2OEVzRzBodUpjZG1y?=
 =?utf-8?B?c1U1Uk9uTkpDL1IrMzhaYTFGc2pUQjJQbmlJNkhxalZJNXVPNERaUUlmNkFX?=
 =?utf-8?B?cm94WGVBZXpYSnpjYXQ2akcwWnVnPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ab6fdf-e054-45f1-9e7b-08dc0df85371
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:12:18.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVnGjhFn0Z9nWiU+W2V5ebZygC+epw2MsQHz5hmgpUfsXSGv+4YwjdA9kkWsLz8Or4V1k/eto/M6ceg6Muo6Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1403

VGhlIGRyaXZlcnMgUlM0ODUgc3VwcG9ydCBpcyBkZWFjdGl2YXRlZCBpZiB0aGVyZSBpcyBubyBS
VFMgR1BJTyBhdmFpbGFibGUuClRoaXMgaXMgZG9uZSBieSBudWxsaWZ5aW5nIHRoZSBwb3J0cyBy
czQ4NV9zdXBwb3J0ZWQgc3RydWN0LiBBZnRlciB0aGF0Cmhvd2V2ZXIgdGhlIHNldHRpbmdzIGlu
IHNlcmlhbF9vbWFwX3JzNDg1X3N1cHBvcnRlZCBhcmUgYXNzaWduZWQgdG8gdGhlCnNhbWUgc3Ry
dWN0dXJlIHVuY29uZGl0aW9uYWxseSwgd2hpY2ggcmVzdWx0cyBpbiBhbiB1bmludGVuZGVkIHJl
YWN0aXZhdGlvbgpvZiBSUzQ4NSBzdXBwb3J0LgoKRml4IHRoaXMgYnkgbW92aW5nIHRoZSBhc3Np
Z25tZW50IHRvIHRoZSBiZWdpbm5pbmcgb2YKc2VyaWFsX29tYXBfcHJvYmVfcnM0ODUoKSBhbmQg
dGh1cyBiZWZvcmUgdGhlIGNoZWNrIGZvciB0aGUgUlRTIEdQSU8uCgpBbHNvIHJlbG9jYXRlIHRo
ZSBhc3NpZ25tZW50IG9mIHNlcmlhbF9vbWFwX2NvbmZpZ19yczQ4NSgpIHRvIGhhdmUgdGhlCmNv
bXBsZXRlIFJTNDg1IHNldHVwIGluIG9uZSBmdW5jdGlvbi4KCkZpeGVzOiBlMjc1MmFlM2NmYzkg
KCJzZXJpYWw6IG9tYXA6IERpc2FsbG93IFJTLTQ4NSBpZiBydHMtZ3BpbyBpcyBub3Qgc3BlY2lm
aWVkIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKUmV2aWV3ZWQtYnk6IElscG8gSsOkcnZp
bmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogTGlubyBT
YW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJp
YWwvb21hcC1zZXJpYWwuYyB8IDI3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL29t
YXAtc2VyaWFsLmMKaW5kZXggYWQ0YzFjNWQwYTdmLi5mNGM2ZmY4MDY0NjUgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jCisrKyBiL2RyaXZlcnMvdHR5L3Nlcmlh
bC9vbWFwLXNlcmlhbC5jCkBAIC0xNDgzLDYgKzE0ODMsMTMgQEAgc3RhdGljIHN0cnVjdCBvbWFw
X3VhcnRfcG9ydF9pbmZvICpvZl9nZXRfdWFydF9wb3J0X2luZm8oc3RydWN0IGRldmljZSAqZGV2
KQogCXJldHVybiBvbWFwX3VwX2luZm87CiB9CiAKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc2VyaWFs
X3JzNDg1IHNlcmlhbF9vbWFwX3JzNDg1X3N1cHBvcnRlZCA9IHsKKwkuZmxhZ3MgPSBTRVJfUlM0
ODVfRU5BQkxFRCB8IFNFUl9SUzQ4NV9SVFNfT05fU0VORCB8IFNFUl9SUzQ4NV9SVFNfQUZURVJf
U0VORCB8CisJCSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYLAorCS5kZWxheV9ydHNfYmVmb3JlX3Nl
bmQgPSAxLAorCS5kZWxheV9ydHNfYWZ0ZXJfc2VuZCA9IDEsCit9OworCiBzdGF0aWMgaW50IHNl
cmlhbF9vbWFwX3Byb2JlX3JzNDg1KHN0cnVjdCB1YXJ0X29tYXBfcG9ydCAqdXAsCiAJCQkJICAg
c3RydWN0IGRldmljZSAqZGV2KQogewpAQCAtMTQ5Nyw2ICsxNTA0LDkgQEAgc3RhdGljIGludCBz
ZXJpYWxfb21hcF9wcm9iZV9yczQ4NShzdHJ1Y3QgdWFydF9vbWFwX3BvcnQgKnVwLAogCWlmICgh
bnApCiAJCXJldHVybiAwOwogCisJdXAtPnBvcnQucnM0ODVfY29uZmlnID0gc2VyaWFsX29tYXBf
Y29uZmlnX3JzNDg1OworCXVwLT5wb3J0LnJzNDg1X3N1cHBvcnRlZCA9IHNlcmlhbF9vbWFwX3Jz
NDg1X3N1cHBvcnRlZDsKKwogCXJldCA9IHVhcnRfZ2V0X3JzNDg1X21vZGUoJnVwLT5wb3J0KTsK
IAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwpAQCAtMTUzMSwxMyArMTU0MSw2IEBAIHN0YXRpYyBp
bnQgc2VyaWFsX29tYXBfcHJvYmVfcnM0ODUoc3RydWN0IHVhcnRfb21hcF9wb3J0ICp1cCwKIAly
ZXR1cm4gMDsKIH0KIAotc3RhdGljIGNvbnN0IHN0cnVjdCBzZXJpYWxfcnM0ODUgc2VyaWFsX29t
YXBfcnM0ODVfc3VwcG9ydGVkID0gewotCS5mbGFncyA9IFNFUl9SUzQ4NV9FTkFCTEVEIHwgU0VS
X1JTNDg1X1JUU19PTl9TRU5EIHwgU0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EIHwKLQkJIFNFUl9S
UzQ4NV9SWF9EVVJJTkdfVFgsCi0JLmRlbGF5X3J0c19iZWZvcmVfc2VuZCA9IDEsCi0JLmRlbGF5
X3J0c19hZnRlcl9zZW5kID0gMSwKLX07Ci0KIHN0YXRpYyBpbnQgc2VyaWFsX29tYXBfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIHsKIAlzdHJ1Y3Qgb21hcF91YXJ0X3BvcnRf
aW5mbyAqb21hcF91cF9pbmZvID0gZGV2X2dldF9wbGF0ZGF0YSgmcGRldi0+ZGV2KTsKQEAgLTE2
MDQsMTcgKzE2MDcsMTEgQEAgc3RhdGljIGludCBzZXJpYWxfb21hcF9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQogCQlkZXZfaW5mbyh1cC0+cG9ydC5kZXYsICJubyB3YWtlaXJx
IGZvciB1YXJ0JWRcbiIsCiAJCQkgdXAtPnBvcnQubGluZSk7CiAKLQlyZXQgPSBzZXJpYWxfb21h
cF9wcm9iZV9yczQ4NSh1cCwgJnBkZXYtPmRldik7Ci0JaWYgKHJldCA8IDApCi0JCWdvdG8gZXJy
X3JzNDg1OwotCiAJc3ByaW50Zih1cC0+bmFtZSwgIk9NQVAgVUFSVCVkIiwgdXAtPnBvcnQubGlu
ZSk7CiAJdXAtPnBvcnQubWFwYmFzZSA9IG1lbS0+c3RhcnQ7CiAJdXAtPnBvcnQubWVtYmFzZSA9
IGJhc2U7CiAJdXAtPnBvcnQuZmxhZ3MgPSBvbWFwX3VwX2luZm8tPmZsYWdzOwogCXVwLT5wb3J0
LnVhcnRjbGsgPSBvbWFwX3VwX2luZm8tPnVhcnRjbGs7Ci0JdXAtPnBvcnQucnM0ODVfY29uZmln
ID0gc2VyaWFsX29tYXBfY29uZmlnX3JzNDg1OwotCXVwLT5wb3J0LnJzNDg1X3N1cHBvcnRlZCA9
IHNlcmlhbF9vbWFwX3JzNDg1X3N1cHBvcnRlZDsKIAlpZiAoIXVwLT5wb3J0LnVhcnRjbGspIHsK
IAkJdXAtPnBvcnQudWFydGNsayA9IERFRkFVTFRfQ0xLX1NQRUVEOwogCQlkZXZfd2FybigmcGRl
di0+ZGV2LApAQCAtMTYyMiw2ICsxNjE5LDEwIEBAIHN0YXRpYyBpbnQgc2VyaWFsX29tYXBfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJCSBERUZBVUxUX0NMS19TUEVFRCk7
CiAJfQogCisJcmV0ID0gc2VyaWFsX29tYXBfcHJvYmVfcnM0ODUodXAsICZwZGV2LT5kZXYpOwor
CWlmIChyZXQgPCAwKQorCQlnb3RvIGVycl9yczQ4NTsKKwogCXVwLT5sYXRlbmN5ID0gUE1fUU9T
X0NQVV9MQVRFTkNZX0RFRkFVTFRfVkFMVUU7CiAJdXAtPmNhbGNfbGF0ZW5jeSA9IFBNX1FPU19D
UFVfTEFURU5DWV9ERUZBVUxUX1ZBTFVFOwogCWNwdV9sYXRlbmN5X3Fvc19hZGRfcmVxdWVzdCgm
dXAtPnBtX3Fvc19yZXF1ZXN0LCB1cC0+bGF0ZW5jeSk7Ci0tIAoyLjQzLjAKCg==

