Return-Path: <linux-kernel+bounces-17907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF20F8254EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5B8283D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58CA2E41C;
	Fri,  5 Jan 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="r7DJohUJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEE2E3E4;
	Fri,  5 Jan 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToW98U5UXN+ZU/GJpPLQhGwKINY+tiRHXkol8eSWxEiOqwlj5GWppMsBSEilxRsK56FLS8CviYjmRsXMzIqdyKtZjxRXn4NmQ3c1Jpf/h7qi/lmb6JZP/2yaQxDJXHhiWwdUZuutQlbBR45AGlQldmq7ZDroqdB7NidnvJL6DjDF+VDivaHBJOEC6mQv1cX473qdw/8yPu4l/jh94Lv8vVDAbxIqS6U0YxWpD1aftmVxAe/sF+br6TOmh9nbBArPZU6hMNSHKKWGGUpqdrIcyjWcYUe19Mlg00zptGtCcZIPWWjG4y61lPC4K7Yf/yXke8QnJ1F89nVNsWEc8m0Vrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OncriHkcvWJWNFlfsrQo1DKSpaTIWLwBKZU4AvicFoI=;
 b=oEx3SYztbzWEv2h9I0tmMgmESEASOXDa8hOqqMmcMopJs/s0pwZxsCi9Dhlb3LlLdAGkPJudLdetdLxvJjMs6Kc3ugZfm9M/0Z1uyf8QHAJ37rl1U2bTfXV1hiAWzmdfv+7delwJ+U8nupdCy+rzhq0TX5aueIu2xvI4kh2pb7yXEaMTLUCXOTEdP7XfPbC0tNc3mZcetgieKSKqt6GqN1aShGBXYAnnRXXZxXtQEpzTLgHkAIi9bwXRlKCssaZjbzg7WCrwv0jhsSptc1VmNy8Td2ulrTaf+Vu7nsM6PhN/uvPCHyj3efR1O8RH6JlVRJ+kP/a6hfnQOrpaNlmj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OncriHkcvWJWNFlfsrQo1DKSpaTIWLwBKZU4AvicFoI=;
 b=r7DJohUJc6gEM0YnUOqxMDtK6sYWRq89XAF9H3Osx3p+qzV7sC1diuULSADMXgmBR7L9AzJ2nl5KfdvcH0mORpNgnlMVspClQww8+t1I4sGqcr3jO0kBs+eTWsEvC71S+je5jUjyllwRw+aV0LU/rYWQTlHsYRbVo2+16KSQPck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM9P193MB1538.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:12:13 +0000
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
Subject: [PATCH v8 2/7] serial: core: set missing supported flag for RX during TX GPIO
Date: Fri,  5 Jan 2024 15:11:48 +0100
Message-ID: <20240105141153.19249-3-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: e7694866-e269-417f-ca95-08dc0df8505e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	osqh4yZfWZ4V17rCDgFzfUeyTa0shGbwc4I2+cxMyBdiiaRn1oew0RKvGyq9mCYf1lFRUylc3IckAF1L7DPbuZWQrpqxLXPowDlijlBWEWSNY56OdXeiMULHLcjjK2e15JdTJ21hE65RtnEp/CDytxiYKdFzDf/W29FNEjtLccRz3JfixEpnJOcczlEaFZG3XdYDAV0AP3UX5jo+DIju/rBTQkh2HBT2GyLB8Cxe1ahn67/8r1CK1MZHP4JCxcpJIHfi5t08v8xZeLCDw3iDOrTloP0HxKVe3AwoAEiyw1GL89QNPPnoiOpT8TQq/oiKnCs9H4jXIv4whhNHT6vOpERaoYLWK0rHOiYA2LpCGp9jDocO0FfXcq+nrAS0jZTkwdhr+DV5pKfpUd40sG6EhruIyvlrMbunHJi31AsDU3JwkoNAad2NhDeVPrhJwCe+4XxPpi2A4Se/HMe38wuuydQ/oxPqI7Ffy9IPM1U2YXkH8wEYtNFQnEyv7W49Au5aUG/ZRUWOeyIS+X+ufO/1lJu8Y/CcO8WN6VWQve+9AE5pGqHneV/+xkZztWw8SDMs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(52116002)(6512007)(478600001)(6506007)(66946007)(66556008)(86362001)(66476007)(6486002)(38100700002)(2906002)(6666004)(2616005)(1076003)(7416002)(4326008)(5660300002)(41300700001)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGQyaWlLVXVBQjV3U080MjV5QndYYTIwSFdENDhTNlN1TXpLMXFCazJqaERJ?=
 =?utf-8?B?azBuait4RFZBL0J2OExGdUYrQU1RUkVTVW14aVJYekJRMXN0SUxJc0VjOTdp?=
 =?utf-8?B?TUJoVmU1MzNsQjFpYWtKcHZwa2ltYjgzU1BFbis2OGR1MHNwWGY4TGtsaURI?=
 =?utf-8?B?MjRvTEFlWFE5Tlk5SzVkcVNUUzdSM3ZBWndUTDErUFh1Njlrc1VyTHErVnE4?=
 =?utf-8?B?djJsOUxCUEwyb2FkR0x4S3dxTWt4VlNEcmFJbGJlTkp2VGwrZE4zTURjREgz?=
 =?utf-8?B?bmpUUnVLZlJicGZPVVRDdUt2akFXWUd4QTRVMWJwRDEwbjhFb1EwbVZnZEh3?=
 =?utf-8?B?TXQ5K09Dck5UcWp2NHh1amRLd3BMZFlwRHJDS2ZBMG5Ldyt3OFRvbWhLVjhw?=
 =?utf-8?B?TzV3TlIzRTJGNTdqQjREREk3MDdKR3hQSW9uYUVweTB4dzVFeTJIT04vTy8v?=
 =?utf-8?B?R09VVkphemdzY2M3NE9sTTAxQzJZc29iOVhpcVlncTROcUFGNVEwajM1RVVa?=
 =?utf-8?B?TWdKMXpsVHNyZ3VXQUJxazR5cXZvMS8xTzhlNGl5dVF3R1VBdVB2TjdqWmxx?=
 =?utf-8?B?L1NLaXp6VVR2UjZmMEJuNDNTTXU3RmZZSkJLeW5zbldQamowMHFBaE5sMjFZ?=
 =?utf-8?B?cmZzZWh6emlmMnkwcjduRUxqWHpldzlzYy9mcHZ1VWJDVVdpNHpUU2lydGNz?=
 =?utf-8?B?MUNLeldPWlgyRXhKcHg0TWRPeVFBaWtYM2NUaWNmSVdCMHlYbnJ4NDdrOURn?=
 =?utf-8?B?bU83NW9tMmRxOFFNcnZmb1RMTXFzaEV3RUgvakdka2tjTkZiVFQwZDZLWThq?=
 =?utf-8?B?d2J2amRTRGN4NEVyYTVTdythMVY0WFptMi9yQkE0Y1JUQU16R2RvbDhrdGtS?=
 =?utf-8?B?WUg2MWN0RlFESWpLWlRxVzdDblNVWmJ2SisxcFpsMk9WZlR5Y05QamV0L2dJ?=
 =?utf-8?B?WFVWTmF1cXM2ZlpNVml3V0VKVjBXL2Z4QzRVb0RWcFcyMm9TRTVYdk5tOERL?=
 =?utf-8?B?RkNkVnh0U2JDWEhaaWdDL0VtZmVidDk5TE15bjJ5MkkxWHU1dnhybzB1ck1Y?=
 =?utf-8?B?ckxZTW1HcHk1c1RuZ0U0akp5MkVDRkhiNlkxMi9NMUtpYzlwVUxEa3p3d1o2?=
 =?utf-8?B?cTM2bnBNL0dJVmhoU1NSOWQycTYzSFgvdy9iR1J6ZHluQXdJcGFscUY2a044?=
 =?utf-8?B?eWdNNXA5MG43dFF4aSsveFBXRjlPbVRnVHBWbzlYN0VSUDArZmNZbGdiY3JX?=
 =?utf-8?B?OTArUWx0WFA3MGRiVWkrL3FWMm5YZnhOTWRhUVJEb0NiaHpHeDRoQ0d1TGhj?=
 =?utf-8?B?MHJxYjFFaVhpMmhRaTI1QzNFMkljc00rTDBXNmNibnlpcERyMXhQYjJjcDhr?=
 =?utf-8?B?bURkcldaNW5Gb01JWXBJNGlraW5leHlyNGtoSW93UGc1ejBNb0dQa3NnRDVl?=
 =?utf-8?B?U0lFeTg4TXBJQWJLamY2ZkxOTGZCc2lTZkFGd1B3TFlKVFRESThtLzdtYjhJ?=
 =?utf-8?B?dU1qWEhMOXZwZkZxOWVLaDZnVGcwSXFGYjl0SEE3TFJTSkJkU1hBU2xKUlVZ?=
 =?utf-8?B?QmFHUWRRbEZmdXZnWDh4eEh2TWF1MXRzOVdQYm50Um94S1FvbDBOVURFVXpF?=
 =?utf-8?B?L010dnVzOFc5NnhkcUk5V3d0a3BwWld6a0xpY0psLzRPd1BvYlJuYlJNY1B3?=
 =?utf-8?B?eVI3VTB0cFNLMS9aazdSaDhRamlFRTEyRFJGeGlPOHdpd0FUbW1yYndEcy9l?=
 =?utf-8?B?Uk15OU9OUjNaVVFzLzJ3K1grbEpDU0l6bUpQeXpEL1ZGQkxjYW9tQmFXUVpV?=
 =?utf-8?B?WGhDL3hzMjNob1ZxODQ5c09pL0x3TkJFb0s1VUNVZXJ5QTg4V01mSGpUSHB0?=
 =?utf-8?B?dk5ybmQxUzltdFVxSWV4eUJ3QWp5RjA1MEJEOFFyWmxPMExaR3BGdk90azF4?=
 =?utf-8?B?UmtmUFlhSWhaK1F3bGF6cTdoOGZheEo1S2IxWlMwcUlvdktvK3lzblIwSVV0?=
 =?utf-8?B?Q0RlNXVFMm80WjM3Unl5NmN5UmY5aWo0a1A2Z2VJR3JZdnl3akxLdjJ4TGpT?=
 =?utf-8?B?R1FDdTNGRW5oZkZzTkhxUEpMV3pNWXpxQUgyM0hzalpIT29lVzBmQ01YZ2Zo?=
 =?utf-8?B?S2FoU3hxSVNIV2l2VC9OdEcrQldPcFNENGxFL0pIcUt5aE82NGt3WHR1Rlhq?=
 =?utf-8?B?ZXBRS1JuYXFSamxjNHdnb29ZKzc3V3cxbStDMTBXdCtsaUJ6QURIUGFSR0RH?=
 =?utf-8?B?dURxT1czM21RRWVTU0daN1l0Q1BnPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7694866-e269-417f-ca95-08dc0df8505e
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:12:13.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmOBhBnc+nitfPS+ygu8XUuUVnIQslKXJ8uIH5gCDEZbUrFLjUPojocTBlDeeyvA/0kH6FtXRKWTTqKPoVJlvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1538

SWYgdGhlIFJTNDg1IGZlYXR1cmUgUlgtZHVyaW5nLVRYIGlzIHN1cHBvcnRlZCBieSBtZWFucyBv
ZiBhIEdQSU8gc2V0IHRoZQphY2NvcmRpbmcgc3VwcG9ydGVkIGZsYWcuIE90aGVyd2lzZSBzZXR0
aW5nIHRoaXMgZmVhdHVyZSBmcm9tIHVzZXJzcGFjZSBtYXkKbm90IGJlIHBvc3NpYmxlLCBzaW5j
ZSBpbiB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NSgpIHRoZSBwYXNzZWQgUlM0ODUKY29uZmln
dXJhdGlvbiBpcyBtYXRjaGVkIGFnYWluc3QgdGhlIHN1cHBvcnRlZCBmZWF0dXJlcyBhbmQgdW5z
dXBwb3J0ZWQKc2V0dGluZ3MgYXJlIHRoZXJlYnkgcmVtb3ZlZCBhbmQgdGh1cyB0YWtlIG5vIGVm
ZmVjdC4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiAxNjNmMDgwZWI3MTcgKCJz
ZXJpYWw6IGNvcmU6IEFkZCBvcHRpb24gdG8gb3V0cHV0IFJTNDg1IFJYX0RVUklOR19UWCBzdGF0
ZSB2aWEgR1BJTyIpClJldmlld2VkLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBs
aW51eC5pbnRlbC5jb20+ClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxp
cHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCAy
ICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2Nv
cmUuYwppbmRleCBkMTU1MTMxZjIyMWQuLjEyMDQxMDJkNzE2MiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3Nlcmlh
bF9jb3JlLmMKQEAgLTM2NDIsNiArMzY0Miw4IEBAIGludCB1YXJ0X2dldF9yczQ4NV9tb2RlKHN0
cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCiAJaWYgKElTX0VSUihkZXNjKSkKIAkJcmV0dXJuIGRldl9l
cnJfcHJvYmUoZGV2LCBQVFJfRVJSKGRlc2MpLCAiQ2Fubm90IGdldCByczQ4NS1yeC1kdXJpbmct
dHgtZ3Bpb3NcbiIpOwogCXBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvID0gZGVzYzsKKwlp
ZiAocG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8pCisJCXBvcnQtPnJzNDg1X3N1cHBvcnRl
ZC5mbGFncyB8PSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYOwogCiAJcmV0dXJuIDA7CiB9Ci0tIAoy
LjQzLjAKCg==

