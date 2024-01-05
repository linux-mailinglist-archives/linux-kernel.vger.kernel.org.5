Return-Path: <linux-kernel+bounces-17905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8061A8254E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3751F237F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0127B2D78D;
	Fri,  5 Jan 2024 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="XO1dwhz/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA342D78C;
	Fri,  5 Jan 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guoN0MLtnqbcJw6hklUEPBiyIMHfpL4C28AQynC3JsdC+V3kOXhVUvObRJ6RTPuqeu+Ouik+9JeizJTnbTiWGG5/KEkfloHxHcRKqtKH/kUjWnSZQw78cRz37hqlTGaGZ0mGQ7xKxCHjXSQBpK+7ISypgIbAvDXhndF4gj2kDMUrWCuMeDrilS5ko/vad5ZSVQn6wsXcsXvth9A0ne24OxzuEp5FTeDvorq0u4QAqRSE1nHxlbpZOLwPPTi8v2ktJ/Zd38eMc3UHE++MiBAJNOD1CEZrnskXyhnX7FM2dQ+msXnwRq1lSd5orpWxxbtBaqfwAGO+zLScWaSK9+Cq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cpMPjBdfdRl/+MN0UH/cwlNrNoO8hWs78fWOsxhrNU=;
 b=OYrr+w1+kI0zbA7fIkkUykkDq5qJr+Yye0JtqGjCrPT5IDg014PmFGZ9kQ1jHyBJ+Zr9bal1toUC08x4DoNNzO8dGjCaBFkGxgi3EFIF+OoiFm2BnOunHJOt5LIaoJAJs8PXY/ELzp/vEtbM/YVBcjA53Nl6cBrJJJp+BrWkPt4xx7Lc9M829iB9iUAo8JwrN+AwVVABVmqVDRRG3uLvBa6Frj5k0nNxYj+WLQxDnw/jSHchUXro2jtSSXpYxMpcUgSyfN4pTFIGK5DmpkBQqrrndcs4P/IK2xGaHT8RNZ7SwkXRw97JqLEQUleHT9YkmaXIyG9JElmNaEwtzxHdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cpMPjBdfdRl/+MN0UH/cwlNrNoO8hWs78fWOsxhrNU=;
 b=XO1dwhz/bbhlRvgp3ZjscOUcW3dZQ/RUGF4DCnimuXY7WtnLfsvuuZUNl2PrYNVoZaUZj1HRbyMc4PitqXAYSMS4tFjGrndXb94g+m0L2MJ7OFie1mvYgyilxFqy9cmvkJqKWXEqVr0XhYxhtO6ERBVXm2nHaFzwiIEb8ge1Dwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM9P193MB1538.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:12:12 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:12:12 +0000
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
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v8 0/7] Fixes and improvements for RS485
Date: Fri,  5 Jan 2024 15:11:46 +0100
Message-ID: <20240105141153.19249-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: c3c3838f-0f9a-4180-0c98-08dc0df84f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eEO2FvSTDDCDnKeLzpHNOuyXRmtFtQNZmff8UaR2a+Yez4fCkPt744wm9BJZtvlpVJxU4rLDjo2SJvwVQ6WdlOXAR9qbv1wTrg+HW7DXUM6NCWjdMYgj51O8Zgk1FcCSqR1otx1hZUWql0Y2w0xkb+wb2LveqIFF9gfxltE32JZJUhaXR51/TaVd3ZZDAorI1vdgxNLrB9u6hnuPNj4eDVc9gC4YJIzCdyAmZwBPpjnpmJRMlLm2G4xXRSAB12wCK6O25WzZZiMH1Nw7ioqvT6HLhwhzuW0Tpr56HUCfZP62w65PBYtl12biCd8/zbKjoO8Muwwgbg0+5yhah0kCi40lHRB2i1N/TmiJdMXV+3kMWPkb9ke2AJL8HCOmHeUlZM/+cguGCxRfjutlmrPj7Fvdzed0CCSE7c3NKcirksHOWsCnaeLXftKazUP3nfB9jFwIVrhK4qPJgsHdT61fRLGynz3U9HkQuRBtH8rnZ/6NF1q8kXQ9Ih+xXwOTuoZFCTLHOHeCHxFTpTszNaY+aunNXTURIIFZoMjzTFyeGf6F/Kwl4pqTg+7JCy8LG2Rt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(52116002)(6512007)(478600001)(6506007)(66946007)(66556008)(86362001)(66476007)(6486002)(83380400001)(38100700002)(2906002)(6666004)(2616005)(1076003)(107886003)(7416002)(4326008)(5660300002)(41300700001)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUhiWFd6aEJzVnVkeTNGS1R3WmVCeDlSV3dWWHN2RG9HSTVxdXl4b0FyTE5j?=
 =?utf-8?B?TnRPb2pLUmNGTWRkSW5MdVF0Rnh3NDdsK0hmcllDSk1neWlLbHJqT3dpMmda?=
 =?utf-8?B?MnBBSTJjUjNvTTA4bk5TUHZHNk1uUFZVazZsNlJERTNMV3haTDErY25jMWhB?=
 =?utf-8?B?V1R4M2pINU1ZYTE4U3lXcnR2YVVTcUJ3dENIdStnb2tCek9ETDl0Y1ZLMlpZ?=
 =?utf-8?B?RzZLQnNwM0pGQWJOeitYUUw3UW5CSEZNOGFLWi9QUzB2YjJIQ0owMEdhaU1N?=
 =?utf-8?B?Wkc3SjNmK0pjRlBzSFFtbFVPeTB3SldUWlpMcjJ4RWVFTi9CRjVUWnVpUDNr?=
 =?utf-8?B?SlZWUDc4cXN4YWs5S1prcS8zWmphRlFBNDJkTGhMNFVXdElDWlNIOThTVHdS?=
 =?utf-8?B?SHdNTGk0eHNZZ3VFOEkveGp1dzJJSVUzTFovdVhONy93c0RURVI1cDVOTFZH?=
 =?utf-8?B?SEZmQWprOHRuZkVOTHZkMy9LeSs0dnFteW90d3MzY2MwNHhnd3QwMjBHRU4r?=
 =?utf-8?B?ZU9vWmM4aXpEVHhuaDdKT1FKU1BPMlNveXpOUUltZGoyQ2Y2RlUxVDgvK1lD?=
 =?utf-8?B?ZDM5SUpxSEJBbEZtc1JsM0I5b0l3VEJ0UDdlRSs0SnluTzBRSEZlQTBzZWtZ?=
 =?utf-8?B?MHVRa0NuUmRCQVFRNkNva2poUHZ5b0ZZcnQ1VVJQcE4yNzRrSzhnT2xxaFBT?=
 =?utf-8?B?ZEUwYkorS0orRUpKTjhGOEVKTHBZY0VxRTVqbmZWb0R6MmhsK1VSUjVXQ3Ew?=
 =?utf-8?B?d2l2QjdocnJDNUY0aWUzOFE5L2ZmMzU1L3hZZjlZcVp0Zm1UT05xUnRMU1Nw?=
 =?utf-8?B?bERNT1N6MlRJN1l5WWxQUUNCZG5XVEMrZ1RqelZoVzF0SmliWW5TWWNyZjJy?=
 =?utf-8?B?Uy9JVkloOWsyRzAwM3ZiUUEzSzZ5WnU1dCtwZHpmWkx3MDFKc1Z3cENmN2Zo?=
 =?utf-8?B?a2doV1orRjdwalpNejlRTUtuRGxxTTJuMDlnNWw1QkNIQ0dEZ3JWODBWTFFS?=
 =?utf-8?B?UkIrUWs1eVJ6MWdHcEptZ0JBUVZFMC92VkZUTHlLQ3k2Mm8wN29iVEU4Z2hS?=
 =?utf-8?B?cGsxUEp0ZXJQMWdnSC9kYXNCRWRjNkRBS1pCK0Z4QlhxbldhZUpWdE5ac1lK?=
 =?utf-8?B?c2FlTXh5MUhTNDlyL1RiNlBKU3NCTEJhYTJWVDNKWUVkdlFvZ1RndmYzZUJQ?=
 =?utf-8?B?VjJsNEJzV0hIRElnSmJ2cVFpVHh5M0lJQk4zQlBuUWJ3M1lnNVVPckFybWgx?=
 =?utf-8?B?WFoyQTFGNk43em1xTDFZS3VLYkowN2ExRkVoUWNOcUZMN3dOaVVnTXRtVGhk?=
 =?utf-8?B?RU5zbTBsMmFKK2Z0b0hWclJ5cENXS2RkWjRtRG5GTk1ldXVENEZWOWE1eTNS?=
 =?utf-8?B?MWo2aCtTYVRhRXFmS1RhV0tublFycnFZNFFxYVN6VnNyNXdHZmU2RTBpcTRV?=
 =?utf-8?B?c3ZQaHJCOG1yRnN2UTZXS053dWkvSHNSb29Vc0ZPZysxbC9MUWJBbzE4bXU4?=
 =?utf-8?B?OEdWVlV6SjB3MUU4elp4YnJnTHg4M1dUZitZODEvZjBnVWQyV0hiRUx0cnRV?=
 =?utf-8?B?TEt5aGVraFJJTFZFTUZlU3ZjZjRZZk8vME5hWmNtVm1VUTcraEU5cjJkTGRV?=
 =?utf-8?B?b1RWU0pvclA3OUpGRG9JWHNndndqaG9KanM2ZUpzazdnbzJ5amNIS1ZhT2dt?=
 =?utf-8?B?U3hGSTQraEEvVU83MEtoaS9PakVFeERtYmppVlNYWjdvdWZWR0hqNFF2UjRy?=
 =?utf-8?B?eG8vQnZUcGgzMExwclZvQTZxRk1ONC9xT2Y3OGNOb01JcXZSRlFFZW9XVmx3?=
 =?utf-8?B?a0MyOEdVL1MvWWJvSEZicTd2SDJRSzlZUEhJbnl2Yk8yRXZBN0cvMU45ZHdx?=
 =?utf-8?B?elMvRTZ0b0F5SzZpMHoyRlhhZGRQZUlMZzdWYkxKUzh2V2hVOXhxSTJPWXlh?=
 =?utf-8?B?dk1IWDMyTHhxQ3RlZDYzZkpkeXJKeEUxRFRQRkV2emJTeGlJV0gvdlZnYzg4?=
 =?utf-8?B?bTNZZGk4Y3Q5dnFVdjBWQ1ExcTd3MHpIUjVyU2Q1TDhnNVIvb3JvYS9RZnRT?=
 =?utf-8?B?bXRvam12QW03ZFdpMUp3UitkVTV4Z1R3d3ZsdTRWK2tka0s5OFN3VXNzbHVW?=
 =?utf-8?B?MFpnYjgrZ2p6aGJEWS9YVDM1RHlMdFRnQ0lMSVA4R0l6VTR2dWJzWm5HTGN2?=
 =?utf-8?B?cGNKVm5oYWhyY253QmFQa3FDbm9YejlXa0FYa2RhVlJ3L0FKUjRtd3NIUmtB?=
 =?utf-8?B?MVZkRlNRc0hrQlNGb2FLbC9uS0pRPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c3838f-0f9a-4180-0c98-08dc0df84f81
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:12:11.9303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2Av5WwwALKPa8xoZpiHANjotXs3aUaSNX5OCw6Cx+tBnh7TZ8rnzonAtAnzlRJcsfHw3BkFO5VvCOxBPkOtjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1538

VGhlIGZvbGxvd2luZyBzZXJpZXMgaW5jbHVkZXMgc29tZSBmaXhlcyBhbmQgaW1wcm92ZW1lbnRz
IGFyb3VuZCBSUzQ4NSBpbgp0aGUgc2VyaWFsIGNvcmUgYW5kIFVBUlQgZHJpdmVyczoKClBhdGNo
IDE6IHNlcmlhbDogRG8gbm90IGhvbGQgdGhlIHBvcnQgbG9jayB3aGVuIHNldHRpbmcgcngtZHVy
aW5nLXR4IEdQSU8KUGF0Y2ggMjogc2VyaWFsOiBjb3JlOiBzZXQgbWlzc2luZyBzdXBwb3J0ZWQg
ZmxhZyBmb3IgUlggZHVyaW5nIFRYIEdQSU8KUGF0Y2ggMzogc2VyaWFsOiBjb3JlOiBmaXggc2Fu
aXRpemluZyBjaGVjayBmb3IgUlRTIHNldHRpbmdzClBhdGNoIDQ6IHNlcmlhbDogY29yZTogbWFr
ZSBzdXJlIFJTNDg1IGNhbm5vdCBiZSBlbmFibGVkIHdoZW4gaXQgaXMgbm90CnN1cHBvcnRlZApQ
YXRjaCA1OiBzZXJpYWw6IGNvcmUsIGlteDogZG8gbm90IHNldCBSUzQ4NSBlbmFibGVkIGlmIGl0
IGlzIG5vdCBzdXBwb3J0ZWQKUGF0Y2ggNjogc2VyaWFsOiBvbWFwOiBkbyBub3Qgb3ZlcnJpZGUg
c2V0dGluZ3MgZm9yIFJTNDg1IHN1cHBvcnQKUGF0Y2ggNzogc2VyaWFsOiA4MjUwX2V4YXI6IFNl
dCBtaXNzaW5nIHJzNDg1X3N1cHBvcnRlZCBmbGFnCgpDaGFuZ2VzIGluIHY4OgotIHJlbW92ZSB3
cm9uZyBzZXR0aW5nIG9mIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFggaW50cm9kdWNlZCB3aXRoIHBh
dGNoCiAgdmVyc2lvbiA3IChwb2ludGVkIG91dCBieSBJbHBvKQotIGZpeCBjb21taXQgbWVzc2Fn
ZSBhcyBwb2ludGVkIG91dCBieSBJbHBvCgpDaGFuZ2VzIGluIHY3OgotIGZpeCBlcnJvcm5lb3Vz
IGNvbmRpdGlvbiBpbiBzdG0zMiBkcml2ZXIgZm9yIHNldHRpbmcgdGhlCiAgU0VSX1JTNDg1X1JY
X0RVUklOR19UWCBmbGFnIChwb2ludGVkIG91dCBieSBNYWFydGVuKQotIGZpeCBjb21waWxhdGlv
biBpc3N1ZSBzcG90dGVkIGJ5IGtlcm5lbCB0ZXN0IHJvYm90CgpDaGFuZ2VzIGluIHY2OgotIHJl
c3RvcmUgUlM0ODUgR1BJTyBzZXR0aW5ncyBpZiBzZXR0aW5nIHJzNDg1IGNvbmZpZ3VyYXRpb24g
ZmFpbHMKICAocG9pbnRlZCBvdXQgYnkgSWxwbykKLSBkcm9wIGNoYW5nZSBmb3IgdWFydF9nZXRf
cnM0ODVfY29uZmlnKCkgCi0gcmVwaHJhc2UgYW5kIGNvcnJlY3QgY29tbWl0IG1lc3NhZ2VzIChw
b2ludGVkIG91dCBieSBJbHBvKQotIHJlbW92ZSB1bm5lY2Vzc2FyeSBzdHJ1Y3R1cmUgbnVsbGlm
aWNhdGlvbiAoc3VnZ2VzdGVkIGJ5IElscG8pCi0gbW92ZSBhbGwgUlM0ODUgdGFza3MgaW50byBv
bmUgZnVuY3Rpb24gKHN1Z2dlc3RlZCBieSBJbHBvKQoKQ2hhbmdlcyBpbiB2NToKLSBkbyBub3Qg
Y29tYmluZSB0aGUgZnVuY3Rpb25zIHRoYXQgc2V0IHRoZSBSUzQ4NCBHUElPcyAoYXMgSHVnbyBv
cmlnaW5hbGx5CiAgc3VnZ2VzdGVkKQoKQ2hhbmdlcyBpbiB2NDoKLSBhZGQgY29tbWVudCBmb3Ig
ZnVuY3Rpb24gdWFydF9zZXRfcnM0ODVfZ3Bpb3MgYWZ0ZXIgaGludCBmcm9tIEh1Z28KLSBjb3Jy
ZWN0IGNvbW1pdCBtZXNzYWdlIGFzIHBvaW50ZWQgb3V0IGJ5IEh1Z28KLSByZXBocmFzZSBjb21t
aXQgbWVzc2FnZXMKLSBhZGQgcGF0Y2ggNyBhZnRlciBkaXNjdXNzaW9uIHdpdGggSWxwbwoKQ2hh
bmdlcyBpbiB2MwotIERyb3AgcGF0Y2ggIkdldCByaWQgb2YgdXNlbGVzcyB3cmFwcGVyIHBsMDEx
X2dldF9yczQ4NV9tb2RlKCkiIGFzCiAgcmVxdWVzdGVkIGJ5IEdyZWcKCkNoYW5nZXMgaW4gdjI6
Ci0gYWRkIG1pc3NpbmcgJ0ZpeGVzJyB0YWdzIGFzIHJlcXVlc3RlZCBieSBHcmVnCi0gY29ycmVj
dGVkIGEgdHlwbyBhcyBwb2ludGVkIG91dCBieSBIdWdvCi0gZml4IGlzc3VlIGluIGlteCBkcml2
ZXIgaW4gdGhlIHNlcmlhbCBjb3JlIGFzIHN1Z2dlc3RlZCBieSBVd2UKLSBwYXJ0bHkgcmVwaHJh
c2Ugc29tZSBjb21taXQgbWVzc2FnZXMKLSBhZGQgcGF0Y2ggNwoKCkxpbm8gU2FuZmlsaXBwbyAo
Nyk6CiAgc2VyaWFsOiBEbyBub3QgaG9sZCB0aGUgcG9ydCBsb2NrIHdoZW4gc2V0dGluZyByeC1k
dXJpbmctdHggR1BJTwogIHNlcmlhbDogY29yZTogc2V0IG1pc3Npbmcgc3VwcG9ydGVkIGZsYWcg
Zm9yIFJYIGR1cmluZyBUWCBHUElPCiAgc2VyaWFsOiBjb3JlOiBmaXggc2FuaXRpemluZyBjaGVj
ayBmb3IgUlRTIHNldHRpbmdzCiAgc2VyaWFsOiBjb3JlOiBtYWtlIHN1cmUgUlM0ODUgY2Fubm90
IGJlIGVuYWJsZWQgd2hlbiBpdCBpcyBub3QKICAgIHN1cHBvcnRlZAogIHNlcmlhbDogY29yZSwg
aW14OiBkbyBub3Qgc2V0IFJTNDg1IGVuYWJsZWQgaWYgaXQgaXMgbm90IHN1cHBvcnRlZAogIHNl
cmlhbDogb21hcDogZG8gbm90IG92ZXJyaWRlIHNldHRpbmdzIGZvciBSUzQ4NSBzdXBwb3J0CiAg
c2VyaWFsOiA4MjUwX2V4YXI6IFNldCBtaXNzaW5nIHJzNDg1X3N1cHBvcnRlZCBmbGFnCgogZHJp
dmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9leGFyLmMgfCAgNSArKy0KIGRyaXZlcnMvdHR5L3Nl
cmlhbC9pbXguYyAgICAgICAgICAgIHwgMTEgLS0tLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvb21h
cC1zZXJpYWwuYyAgICB8IDI3ICsrKysrKystLS0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJp
YWxfY29yZS5jICAgIHwgNjEgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KIGRyaXZlcnMv
dHR5L3NlcmlhbC9zdG0zMi11c2FydC5jICAgIHwgIDUgKy0tCiA1IGZpbGVzIGNoYW5nZWQsIDY2
IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQoKCmJhc2UtY29tbWl0OiA2MTBhOWI4ZjQ5
ZmJjZjExMDA3MTYzNzBkM2I1ZjZmODg0YTI4MzVhCi0tIAoyLjQzLjAKCg==

