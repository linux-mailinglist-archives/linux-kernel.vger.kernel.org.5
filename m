Return-Path: <linux-kernel+bounces-11014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F4D81E014
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66671C2151B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549451033;
	Mon, 25 Dec 2023 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="GlbbuC2R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03DB51018;
	Mon, 25 Dec 2023 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vu5VxcvhoEY6ZxdPtfc6pAZ4zs71q+Eh7kAkaTrw1fUOyqOZd42FnUNGyaOW/LcOAFpJ3aTyXKDGMeBaTGWJpEc0MCJaN24cvhdSw7U4CiMzezLTEPaYgKsjTbUPu9gYTbrNIgp2lcNNDClY2WUatGWOpWQmWj+1dY12Jl5jGc0Ihqhnej9H4zSSIh4ZEQ//DZ7z8mIIL/5NB7NsyL5ExFsWmkJQ60vSRNhRbKIrhJtLS1RWvF5BI649YpELZkmwthTD+7b3VPX8d5EbeNDmQ+mD+AO9lNkzN6F4/BDBuJbAtbGSAuDIDnmiVAXjLBVzoYPukVSVJFzyvLnqni+fPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OncriHkcvWJWNFlfsrQo1DKSpaTIWLwBKZU4AvicFoI=;
 b=l3j2QJvBf5xV+7Zd9ePH8FR9Pb6CMisZRrnYiZBGMHKKzru1UuzApVBgv2i5nDpfkmVlPh+l7p3Mr1RCrYjGjA6z8Q+YU/U8behh11oYxLJPkijjRALQ/0GjEdp8h03+NXJPcrujfAlZurf/PMIxQ7GnEDnWOTO75cRyvGdcSixaTWitbTHjVf+esvfrq5QE8eV57PGakikO8skE53ykxXjO8k5bGJBpjXxkBoRuZYnw2M2y/5/96/U29DPy88/sgV9rRRdohUxz60LHDphfunRZO4epfqNuNFNjLM849Auh8plD1Y+F4Ow67MANPLQF1h25meqE8MzymCWD1mcwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OncriHkcvWJWNFlfsrQo1DKSpaTIWLwBKZU4AvicFoI=;
 b=GlbbuC2RWwAfvzJJUMSKb8FR/3AQ+i/P2s8Fxg+FgK2hVX0YTBhy1Q+53IO1OlDOhSJNkA/NuX2nO4UIfyb0P/7t/IO50RWcU/e1jdOyQikaiE8VEDvTYLZWKzCDDAO+56oKw/sfx4ivBvTTXt8brU6hQzGqrgORBJ4EvcXTqso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2070.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 11:35:54 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 11:35:54 +0000
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
Subject: [PATCH v6 2/7] serial: core: set missing supported flag for RX during TX GPIO
Date: Mon, 25 Dec 2023 12:35:18 +0100
Message-ID: <20231225113524.8800-3-l.sanfilippo@kunbus.com>
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
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|GV1P193MB2070:EE_
X-MS-Office365-Filtering-Correlation-Id: 614d6e6d-0513-43d4-4efe-08dc053da6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2mn52qyVxPD4EH/agxW3kt0BqkZR0pCag8np5JcIBalCic51J1bXkQUUlKZ10tz8csAo6qUzhqVPs6DGeOJLz6+3jJmVkbvsnjSfdYUmp4Pi8YargQBzDe2KFMcD3eKI7VRYX/0YqgTqWmrrfBtI8RHsBFZ2ocaQcmUp4NmkVpXcxmOUN3n8fwvtSSkQ1Xgji8E8wkd7YKb1wuKTDACAnXhq+cHMKzuQ9Fnqn55xXv+S6qRllAXWegzR5nfd7ymPGpc8zZNoz1QGIBzQrUy8k8IQrEOCZKKm/zlFR4iJ9vdXJRik1hhSfoh1VL1mRPn7I9nzyco/6HYKym/pRv7K3D/gaac7ZQVNs6R7aLnhEeMCbcB0pQ3Y1Ba4wyfnjkWhwN6advODx065miXGmjdNtdBLy741u9RMO7jxbZeo9aUgXXDkXfFOhQrRkf7HKHd38UH6HaRMCfzW6aaISphbEusd+ag+dVP09thILQjACG0eLaxMArMbCfzhUYlhDY7qNCy0mgAUJzuzWtCEpVoTcSJ+Hmm0uTM2Ux4Yic4LPKR0jS+lPTKnxO3aYsNjgyQj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39830400003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(86362001)(1076003)(2616005)(38100700002)(41300700001)(36756003)(7416002)(5660300002)(478600001)(6486002)(2906002)(6666004)(8676002)(8936002)(66946007)(66476007)(66556008)(316002)(4326008)(6506007)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUFEcC9SQ0N4NjR3THJLOVJ3TlNVa0lPbll5UVJQbVZaemRIeVg4U0JYQTFs?=
 =?utf-8?B?VENmVmp2SFlLcG9rRVBheXJNbnZhaE1keUU0MUlaZ0VGbW1sN0t0ck1wRXJO?=
 =?utf-8?B?VzA1TTZhZng0ZE4wVWsyT1RBRVkzY1pwdC9VWndCNG50VzU3ejVMeUpiOW4x?=
 =?utf-8?B?MHU3L0hodlRYMDg3STUxRVlCT0UvbUVyMkc2WEFNNEhXZXVVZUlxK3V0aC94?=
 =?utf-8?B?RzR4WkxpZkg5L3d6TlRQN2wwYjRlNGxsa0lGMStKK0JrUEprYXRwTkhtb3Z6?=
 =?utf-8?B?WkwxWFQ4K1kxeFEyUHJ0OHFyVXhPRVJGOURvOStreE52Zk9XbE8vNlJVbWVw?=
 =?utf-8?B?a0RQRXFyWGJVZEhtY2dMS1BvNVlNeW1LYU02M1BWSC9iN1VHSnRWejVqUy9a?=
 =?utf-8?B?dWx0ellYRzdWVFRtcHgyNXlNNFVGV1BiNy9zRFlWU3ZsYlNkakRZaTZJQ2Rv?=
 =?utf-8?B?M21aYkZsWE5wajZRSGk5RGpRM2tmeXJnZks1MzhmbmRoQllGK2lJc2RBR0gy?=
 =?utf-8?B?VU5aek9wL3RHR05WZmZmLzhBcXU1MXpRL1hoMU12aFp1Rkw0Y1lZV2RtM1NU?=
 =?utf-8?B?ZXFCN1o3N01obXAwejZkUE1NUElEM3Z1R25hR1M1VlQzZ2JRbUhLNkpZUGlG?=
 =?utf-8?B?a0VoeVBOSWxCVjhZeTlTcUF4SEhlcTEvaVhESFhWcW5GR0JvMWJOZm9zQVJl?=
 =?utf-8?B?ZjBlV0JVdi9uMkpPb2dQUUlvQjNNREVnYzJrQUdqRXQ2TTNDS28xM3EvdzlP?=
 =?utf-8?B?SmZaSXFySGtCcTJTY0g3dXdKSjd3c01HNUhoemZ1blVkYWJSU20wbjAwT0k2?=
 =?utf-8?B?S1lrRUJhVTFza0xNcVprVGhOcWxWVkxCMEJ1UWdGYkVOVDJTVjV5Rm85NTdG?=
 =?utf-8?B?ekhmLzhVY0ZoRURxREJBaGxEZ1VQMlA1SllyTTFCRWZDekdoYWR2a2hiem05?=
 =?utf-8?B?ZlpPNTNSdHg4MGNHcU1hZHlZK1R5dWRvVVlVSjFSMDBUWGtmMEpwVjdReUpa?=
 =?utf-8?B?MmhrZThSeVp6bEJGQVRMajIrNWtBUUp0cjlQTXpzakZILzRLWW41eDFob0E0?=
 =?utf-8?B?WUYxYW80Slk3WHl1UEhpREE3NThsTm85bTc4UlZjazV5TFRBTVIrN1RTZ0t6?=
 =?utf-8?B?L3NuR3AwcXptSG11cUdKclowai9FcGMwSjFzQUR4QXpreVMyeWh4SU9mWjJn?=
 =?utf-8?B?bDdCL3lwYVZUNEcyOFVLenVjSngyRTJCUVdrS3p6dFVvb0wrUTdNS2ZxSTZS?=
 =?utf-8?B?Q2ZWRmlYc0ZNT3ZRN1pEOC95bEphS1dodjU4N2dST0szeFRpQmZkWlVETS9S?=
 =?utf-8?B?UU9rRXlkSzNFQ1ZlOVZtQjlxckg4aGk2OGkvWitZUndxb2NOOTIwNmRwQzdk?=
 =?utf-8?B?VTVObXFlNnVqQUd1S0N3VnV4ZlVOQk02WTJvUUpZTGNZVkxGMHcydjVpeFJB?=
 =?utf-8?B?TEIzbDgxdHpCMjdIRTMySStKcE4yOFpZWEJYcm84bzZlR2V3eVhBNFFuOTdW?=
 =?utf-8?B?bk5ValhkTWpVa3BZcEd6OXdyUGdBWEdGVEoyb0p6VEFBbmZGMUJnQnZLN1hi?=
 =?utf-8?B?aGFFVklsdkhNSFROM3dkMzNNUGVvMVllVlR0Y1NwNEVMcE5zTkpYaEFPRlZJ?=
 =?utf-8?B?L3Zsc0NtN0xCT0VWN0I1MnByQjE3Mm9GSCtLU0VWdGZkbDlrU2x4U200QWwv?=
 =?utf-8?B?V0oxK3NUQXBxQzFicnVNNEtuTHRzM2RCakpmaU5JWmJ0dXJHU3VxZWkxR0xa?=
 =?utf-8?B?dVhtbVpVM29ya3VHR29abmZlRmF4N3ROYTdPV1BGVjdWd2Q5RjRkS2xxbm94?=
 =?utf-8?B?ZWcwdEhSMHdzSHE1TG1xOWhqN1JyemZVeitaNE14MHJoTDR2TmVzWndkbUkw?=
 =?utf-8?B?RFliNzZtc1pXTXhGNUZtNzdPaGZ5VHJCK3dwcHE3Tm80SUFkZDBvOFBTTW1T?=
 =?utf-8?B?bVdxcVplekpFQlNuR0VNdSs0SXhBSDRQUGdoYktzN2ZNR29HWTdlYUpkYWt1?=
 =?utf-8?B?ZHZnZTlwU0xOZ3E3YnhqMnZHUk8ySFF2cWtBemEvTENHRlNBMWlYOXpnbGVZ?=
 =?utf-8?B?ZkFQYjRnZ3U5bjFkdGZVY0tTRGdRczFmU1RjblhhYUdveXEvTHN6cEY0dlRT?=
 =?utf-8?B?VGsvSWZReVlCMHcrYUJNT2pzOEY1REIvaUxhVGVJR1hrM2VxbG5oVm05RktO?=
 =?utf-8?Q?znpgq/xaFmJoxF2ASHRmesHCIjaDGbiIxsR5519oIII7?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614d6e6d-0513-43d4-4efe-08dc053da6a7
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 11:35:52.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gitdj3McloKMuX9Y3machw/f5FmTRZxVhle8mk6UnCosx3MhN4ziB6YJp54uaePWHtIjrqIK5G0rLG9OLniYNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2070

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

