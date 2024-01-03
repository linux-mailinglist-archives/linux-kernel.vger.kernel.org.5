Return-Path: <linux-kernel+bounces-15204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DED9822851
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF401C22F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701FC179AE;
	Wed,  3 Jan 2024 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="bb4RoBbm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8C1803F;
	Wed,  3 Jan 2024 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knrgDtx4aHgQffsK9xidO/yhcmTFYP+/x2jL2R1EV1xmh7Sdf+BXwLMdxi7krOJmIj80Q4w9Zy1OogMIW79GzG5K7OZGNSosE7CKdAlPiybBrHyFFVlmbKp7vHel6iYECb5NL80mOfvdjSAhxflp3S/x+ujbCKIkauY9vTpcXbT2qV7JXo0smwfTevCUCBLotBytnKRLa//zoxaYoO5rJbi3A2UY3g5wkxfBUoR2nP1C5aaVirLZDmsydYpLpXrjrOBHetybefdPwJ9oRpYghi4LG6gL2xZS/180KOEpE4bTIgaZkddo5X41O4+rPee/LctK4+PbQl1j+jHCwM9yUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OncriHkcvWJWNFlfsrQo1DKSpaTIWLwBKZU4AvicFoI=;
 b=ZAKEzm/v8FGn5bncOhpWfelx8Ag7bwLP2PktcSOKovoA+/2cPUmEbwzmE5fLaKWsN/SJA9VDwyDjngo4cTZTjdbttgh8EPAkKmhTQ2UEPwg3sIhb2IaAo47anu7Q/Okxf73xU6Wy12bUfoEhlA/KOn/VcchMAnDnuqnlxaMFr+uXY8sb8rcfbcPHOR/1rDtt/sG1p3ycWqNcCe1yTpIg38OTvf+Fi0woJbLgK+6Q3oP49qfFz4xEAIkjG0ECDz91O9/SJl9k1zBc6pjtKfuMF+ceK6+tMZIT4djn2Z7FwUJtqBmeZdRQVxib5ImAW05JSRfyUo6B+pnfaEgLhbbh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OncriHkcvWJWNFlfsrQo1DKSpaTIWLwBKZU4AvicFoI=;
 b=bb4RoBbm4p4U2U0Mniu6VaEzRf9FQF1GxgWdFNRB+Ax1GCfFM8IOi1sa05v8dCIMMWRpRN0/DpzonYCYcRu1bMiV1KcVbPHsA4xl28eCdTHiX6eb+RbXGDU8+WuzVZ5lgnoJ9EEdKgliYZxFqCoGLPqzVjdF4CRVI/uTcqCNLpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2245.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:19:10 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:19:10 +0000
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
Subject: [PATCH v7 2/7] serial: core: set missing supported flag for RX during TX GPIO
Date: Wed,  3 Jan 2024 07:18:13 +0100
Message-ID: <20240103061818.564-3-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ae9fc89-1f2f-47bd-68f8-08dc0c23e62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pdR7HZ0dlxXUEVFFbT9JxESoSnXhvjLBu+JK3I78pq38fVFXD+vzUostfkByuI6357nEqXlH6g3/h6Thplvs+uyd9WINkj1gfMi/NfttvXAFWtPMft/sOPs/Kr8OENmi6anYHEKAAhsIC3FAmItoRAz5tH7DOIHRfiEy0BG+ej0BtAlLMnZq7qyPFivD6cODkDObRFMrb5lvCsC+DbE6k+MV45xqCzzP7G5/6NkWpfReHJk2YbUzlxri0GKZUpDxMxkLgdqwKCjaU+i2fVu76+8eciCd28A54upCKTuMM2UuZaxF/xX7+ymEGuTwIDpbpHL7KAoWelgua5NbIdJ/WtsLzl7Wtp4XcZToG6PYBEeDuqh9zsoNV/jKlq1PPR9BDN/6nj6Pd6n0mSNfhcdrcnKLqeGLiKN1TGHdl4ifemOUIxTg30tibL3DRvKOLXXX5Cw2GHdXpiBkbTG4DlbLMQ5ZV8afSY0fr7PUk7qIr4HH26rOeB9cTv9Pn6UhTFomyufhmuCOsF/PWp3CaMSnsh+/I11o8MH0NdHSVW5BSpezLnrxL0Q3QSdqRMQvXbTA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39830400003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(66476007)(4326008)(478600001)(316002)(8936002)(8676002)(6486002)(6512007)(6506007)(52116002)(1076003)(2616005)(7416002)(5660300002)(41300700001)(2906002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0xFV2ZLYjRSMmEwaitOKzZlNnlLNVRWNGdibTlHTXJLWURDc0lmS0ZPSStV?=
 =?utf-8?B?Z3dUY0ZjVU1xeXMrUy9nNUJpdWduT1JEWU9aYWowb3FvUUZUY3ZpSFNYTUcz?=
 =?utf-8?B?aEk3WmhzK1FZMUgweUJKMnVrbTNSMGpQdFVWcjFoUEppaE85SnBxZCt3cVpk?=
 =?utf-8?B?U0NrTEdQV0J0REdCdW9zVWR2dlRWOERkMk0vMVA4S1ZaMnNVUWk2Wnd3cGZw?=
 =?utf-8?B?eG43Q0NnVGNMNzZxNmcyTkl5NVlkUnlpU3lzaXhRQWFjdmRxZm0xeFg1R0Mr?=
 =?utf-8?B?YjFPc0NwaWl3TjBlVlJpOVJhdW9DdktnVjZHbjRidWdnVllMb2YwYzhSM3RC?=
 =?utf-8?B?UDk2ZUlTWkYvbnFWU2p1Q2tWTytBS21nSEZmYVJodGpjdUVmRjRtdVRvN3cr?=
 =?utf-8?B?Z0NJcXZjOHVPYnBBTmpOV1E3czUzQ3VZUzZBSTBFaVJQZnc3OU1EMnRtSmYv?=
 =?utf-8?B?cGtqNzJmTEJySmZHdnZpQUN0OVhLZ1hqWXZPKy9OU08wbHJtYUkyRjlVMktT?=
 =?utf-8?B?cnpQeXJkckNVS0VjMlpkSVo4Ymxnci83a3Q2cVp3cU9jZzd3K0N6R3VkQ3RU?=
 =?utf-8?B?WFA1VzZaeGpRdzQ2aWhPdUM3eTVJcjlIQUlwT1BiTVQzalJSbGx2OEk3ZGtT?=
 =?utf-8?B?NjBQdURMN1VGdjNSYTF0K1l2QlYzUlk1eGpYVS9YNk0zZzE0b2czcjZvY1ZX?=
 =?utf-8?B?R3FGMjBoNjNhbmtFeW00aUlJZXNpVzhjRGQvYjF2Qmg1c2ppczJQbDF2QU1V?=
 =?utf-8?B?M28yMWU0SCtaazVYRlVQSVhFU0hIeWo0c3pDU2NGUUZFR2tNZmwzK2FOc3dl?=
 =?utf-8?B?bHE2L1Z2UklITGRKMUxvOExlNi92RjhBKzFhRzVVakdYQktreUpNVGFNNG55?=
 =?utf-8?B?SFlQVnhacWV5Wk5JSC9kcGhzMHpxZmFDZWhQeUhwSFl1VysvcjhXbGtqUlpa?=
 =?utf-8?B?Y1Z5ODUwbGtpYWFrMlVEOWJSa085SGllOFp0c0JXR21uODZLY08xVkxJdXQ2?=
 =?utf-8?B?UHlKcGU4Z2ZVTEhPQUNvTU4zVW5xclNzcGIveCtvVXVrQThDWnY4UWdCVFdv?=
 =?utf-8?B?aHhkN0JITU1xaFkyNGVBV1o5NHpieDRla3Nmell2ZFF2MEFkODR0S2NCbDkw?=
 =?utf-8?B?YjRyK2s0VUtYU0R2bEw5c0VsMGVtUXRlWlNaUDBqdDhwK2VPdDV1VS9wWllS?=
 =?utf-8?B?SGdUdDI5U2tYNlRZdmJDOHl4L05KS2h0VEEycWYxY251bFpva2dlMVJyWUJG?=
 =?utf-8?B?L0owbFlsUFVseTFCemJqTHJVVllkUkMxbWFPbTh3eG5rZjRoUGZMY0pmUEFj?=
 =?utf-8?B?U1JISWJVWGZBaWpZRmJ5bjlIK0J4MFNLdGhqMFhQcGJyU3JydG96YjkvYVNR?=
 =?utf-8?B?eld5VE5lV2J5Zlk2TllwdjF0UlBSdGdGY1dFQUErWkM4SjFPTEpuTUpJYVo2?=
 =?utf-8?B?SGhwSVcwZkFuaEZQZW1Wdm11bkYydlZ2Z0xvM2JnRGZIbzBvZndDK2laV0Z3?=
 =?utf-8?B?alVNSzRBVDg4K3FHV3ZybjZuNG9lRDVCNlJ5c0NZUkVLQ1IrK1BvSnRyeTR4?=
 =?utf-8?B?Q1F6YkgzQW1wbmNMYUkybjNPc0hEZUoxeE1iRkdtY1dQWHF1MGxod1gxMmV2?=
 =?utf-8?B?SDBOMnc1WmpzMjVvV3lPU2Vya1kvNXovaXFnczhQaTNKUDVMYTgvM25Cdmc1?=
 =?utf-8?B?V3VaTnFWTnlqUkxQYUNlUHNtVkd3Nmd1eklHRXZRSHlOQ1RrZ2x5TjlhTFRq?=
 =?utf-8?B?L0hJYi85MWJrMDliUlBZZk9PZUhMZjVVS2pPdlNiWVZCVUN0SGlrNEJKRmcv?=
 =?utf-8?B?QWxidERIc0VhWHA1SzhxVmk5YXdJK2RIVmhXQlRPRmU4eFZiWkJnUzRzWG5B?=
 =?utf-8?B?cUduQW5US0MvSkgzaDVKNm43OEtvYUd4L2JFRFBlUktDVnVZQ2lmajZyNW04?=
 =?utf-8?B?LzlwRkN3ZktBWTJIbUQraGg1NHJnaVF0Q0t6bUQvdUREY1Y0b01wOVYvTTJG?=
 =?utf-8?B?bUYvVEVEQytCbHhCanp1dEtKS2R3SWVCY2o3YUhQKzFUYmJYcW5aVWFEYkV6?=
 =?utf-8?B?b3ptd3NHUlRqV3p2cjRyWGd0UWdBNllHUjFCY05PbGMrYmdLTG1zdlhRNGF1?=
 =?utf-8?B?VC8xZW01NTI2YzVCZWhvV1JETStIa1JKV3BiUWdkREtGdW0yR1RZSS9RSWRm?=
 =?utf-8?B?ZXhnMmlBdmJVOUFCOU5TcXRHeUlFclM3RnI4Ukc3MUpCRXFZUUdCNStzV09H?=
 =?utf-8?B?WGt3M2hwQTlVWWljREtCUmtyVmt3PT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae9fc89-1f2f-47bd-68f8-08dc0c23e62f
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 06:19:10.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VDTsV0tbeHMk+3yml99Jgx02/RSDXVbZlUPgA8cCcIuFbsgt1mbBrmeVtyC1TT52xugtBCRoA4+ra5MMEja/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2245

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

