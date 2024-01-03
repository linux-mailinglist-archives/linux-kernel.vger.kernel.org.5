Return-Path: <linux-kernel+bounces-15210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7A7822862
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4B41C22F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B01618B1C;
	Wed,  3 Jan 2024 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="bdUyPiDT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2045.outbound.protection.outlook.com [40.107.13.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565118629;
	Wed,  3 Jan 2024 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iz9vcKkxykTiUgdsbDA0ZmjUNKdxVALyNByDwGCUo3SPnjV9USRIYRw538+xrO1RNQ4PJQfgt+IzJVvV6Z6IczuJscrKmm2cMC6V+R3SXiY9rMJYrVOQsRbC2lZ/PKgEzluCzqDRgzjb8UApu2PdmQCWqkQI6VyGYor8sQQvrFi6pxCFSyFZZONQB2X7pkITWqzvomwGmMSRi/mc6/GTkUL5I2LtpYTSg3tWHPkrNK0QQ2lufZJ0kljj2iNWxaGdM+yv+kwlfv2WtPkdSoV4KMmeVcrQb34MxrBLch7KrYo5XLM2xh1WFqUH4GuP/GM+QTH5q0+jPvHUnnO+ISnRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVOZN69khZ6LoPJoQx+tVmoQmuWZgx7tuQy8+yaM6uM=;
 b=eJ279wtP4t8h119hS3ymUnVlq/CQmnS/pxw4+TCtne0iwPiDoS2pLCBzNxs3uWJUoia+AeTdT+WdKcjSztuejSLpZev9S9k//n6ixMLx9DruHp0WQiQXui9DP/HR+vjkIi4h/1zoMMcFk84PGVpVSih/Jz7/wl3At6KR3N6NKgXnVKYAdFvpuAre7YW7lbCmLj9e4sK0E8fgumMad5YaUAx76idDCGxAWHdaU/uc4fT5EvfOY5adq6wmzA/9iXz9vC7uetbsjHdWThuXgmS2jB3wwxh8nwXq9Skh1RavZwsCAyGbdV1jLO8DtIE5mKgMY5+j5nFCCpXtV+R+OWZ7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVOZN69khZ6LoPJoQx+tVmoQmuWZgx7tuQy8+yaM6uM=;
 b=bdUyPiDTZkdvpipiGBmP9bTa8zFt6f5AfTHXY+Y425RswxHT8KoI1LDh8n3iPOIVsVE6TcrUB5KQPxcnjdAGPWgqHU5BhFkyNJgyBh1PPyRZJYWRVShJa3uDomg3bKJe2bm1I9Gk8xLoKuFvgDz/kSA7BQVfDSFiwNt7/q7y/6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2245.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:19:13 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:19:13 +0000
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
Subject: [PATCH v7 6/7] serial: omap: do not override settings for RS485 support
Date: Wed,  3 Jan 2024 07:18:17 +0100
Message-ID: <20240103061818.564-7-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103061818.564-1-l.sanfilippo@kunbus.com>
References: <20240103061818.564-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: fd13a624-49f3-4740-5a9a-08dc0c23e800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HnQusRXrUpgMw5oKPnZ/1oprMx2kv2LhOU2IWqfvtwvBQaraOXKcbHaFeTSBHA/EI//uzut+IK446QKxjn9/bBfr/+KfA63o71R/xq3DfRy7Q4HTzV6OCua9P7P/VW6Nk2XMNHVqnWKLMDJOMB5i579c06dzWKWF+M7Wic7JRWViAS6MSiKP6ovYCAulv50LkQgGC+InVyxI0c5ibKTCM3BoqoibX/qVNdgLcGLuJDWbgAKpeSBAouZgbyHym1VVFr5F4wiYbVgfx401DusiHnYUqJDTdKPKgg0Tu7VgPXW/wwQ/fECJK/3lsinecDUc597pU4hvmAYJg1D0DYP7NGGONfM0LfcnbZaA7UtpMiuoUwfluopP+pDZ1aj6lNv1OBU9bwNjztxmZRGiOSVhuAgKo1JoRRmXbPJsKPs32TRMG8Wik6zV+3/wTgH/ZyBowvp5QrP4oYHcsioqhBJm6MpW05FPlH4IWRnNkTeMHSIsr3cx+k1XIxn3Tc5pIlEl2eOx67NtEvlosisiloLVf/SZkJN6JnEvMtY25dP0K3hj4iFtRUluSnj5BEPxi/fb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39830400003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(66476007)(4326008)(478600001)(316002)(8936002)(8676002)(6486002)(83380400001)(6512007)(6506007)(52116002)(1076003)(2616005)(7416002)(5660300002)(41300700001)(2906002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hwE/F+ApB8FgPkbN73DhiuQxQ1HTSyN4nDoLoLfUWIukNFkr+WqEJi+ZHgTv?=
 =?us-ascii?Q?PG8KemceT3jRE7dg8Nf+x1Hy5iLO663rAEYxK8bplM/RQCd4ORk2vqMqa8Z2?=
 =?us-ascii?Q?Avs1rwFGhhXWb0gBevn7YwccxPWu5Aap1EgEUZzDdN8icX/KweiNKnw7RzdR?=
 =?us-ascii?Q?REfaXc7wMWWZBDiLz67LBg8IsM+9d8N7uUUO6Ode8tCTrreZVvbE2spdQ6l2?=
 =?us-ascii?Q?YWDC/haAKsNG0tZx3gl0u14emyPB7o+JDsvXWBprUSqsEeo9+6UapDYU6ptk?=
 =?us-ascii?Q?7gdQw1ZLlFU7+6bJPwqE1tXj1H89XvJV3PmMnZ1yRsa/VhSycY2/37DQwWjC?=
 =?us-ascii?Q?qkjo67qPNhB6AfHj9L4/cHvM3Hf8wKk2sDFj3ZWyPKJ0biAMuh+fT1RMSRdm?=
 =?us-ascii?Q?C85k6Bp6UDUOqBcsfan6ct7u3Cbmq8hUTvebLyFS0PyRyI06pA9/Q/0K5rqU?=
 =?us-ascii?Q?gKy0MiHRboE6OCbV1Zp0c3arvZPaeTkAwhrX0bJgkpPyQH+R/saz2xfQvoSI?=
 =?us-ascii?Q?VWzCoy5as+VCaBD+MqctmeX4AXHd28mHsjmweqAIXy7FNU4yBS/zYVfcUFnT?=
 =?us-ascii?Q?aImdfZRD/wc+yLJ5bNLncrNsPZQkfbTFlj6RG0NRvzwhXmV1bvAgVeW1IlAM?=
 =?us-ascii?Q?yBGN9FHUD1+6AVDfNrkKYmNhAfYYqm1DhusPvbPldFAvZMOpIcbYJi2PEFKy?=
 =?us-ascii?Q?VgQWWiSqcAg0LKsDNajx3/6YzDAnxHdjnGpS5DEtXCb2cAVKQL5yJTIWpqU5?=
 =?us-ascii?Q?0g5/B7LuSciexKZXg7OoAENrckAgPuvSV1Zw/VDXid1iKZKshe5fc/EIJNl9?=
 =?us-ascii?Q?QDCDRtrqPNnkiXIekpE1tE3s8OF/K6Wl/lepeC0DcqmKSKNGnN7wEbg0R6Xt?=
 =?us-ascii?Q?Kov0osYl+cuvLGXgt6pOwtiqFjPPGabeGb+jl0g3UouIN0Ei1I03OeZQenqV?=
 =?us-ascii?Q?3RH12H+n9UQ9wgxXqj8Q0cblg3W5qp23rt6xR/ZFlydY5Q4zvORznnyD4XvB?=
 =?us-ascii?Q?aOKIxG7LZTtKnomh96M/u+VAnKCALSeJALxbBvL17kjiqDAPJ9XIWtv4dcfW?=
 =?us-ascii?Q?ZGSzVH177gVYGpdYPm2KWzePTO1k5ovuEHdWkiRfEpRBBCrHxCjQMIeKvHiu?=
 =?us-ascii?Q?XHH2t2fht79xHiZW7A7FZ9XairaH7Z7RL2zq9OPKpI9D9BDcVtBnFA0reOAd?=
 =?us-ascii?Q?yoZc6PDTujKuUFfNRypEffW0BtViNGCuwbCc+H2EGaGXZLZAOHv8lxIRUhxL?=
 =?us-ascii?Q?6A6VfmuUJfs/xyD7PDNCG1pVZZTJNX7WbOSq755/7skYw1ZqYrj5+RdvGxvN?=
 =?us-ascii?Q?g/NkXQJ1Uwv9mWI4OCdRV4nqGVbGf9vSWDwO4Bf0bRQ8Wof0xRu1dWv01sX4?=
 =?us-ascii?Q?wg2CUW2qAss7ZZGbGjbcFbUm329kedbZo/KFpyhDtwNU63ga6wBEvQuyqGsb?=
 =?us-ascii?Q?x/0cZ6MHN6dppq8/5jwWMKkR7J1o2l5HdPW15rVwdNKvY3sX4krvq2FjTtt5?=
 =?us-ascii?Q?QppnlKSxVjHqB5NYlhc66goYqf6Ii1O/r1Mev9NepH03HmX+TW/NKTrcBi5N?=
 =?us-ascii?Q?4GPbsA8VI6ExGW3LO5uqj3tpEhlBStqGv0GQ7D7etf4W1RWebh7m3mTjYhKO?=
 =?us-ascii?Q?VfxLqfiWuNQY66tTXqS82/FTsrQ7feKBo4lxuQPFR7yC5/qgMX9PaEfGeIv4?=
 =?us-ascii?Q?ja0a+A=3D=3D?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd13a624-49f3-4740-5a9a-08dc0c23e800
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 06:19:13.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkSHq0AOPn1xEZ5t56r3aQSFzqc5CFup1SoHC3z0ihiwNQbLuAsyfqO25HDOK6tYs2kkI1d59kdA4HOcvZdAGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2245

VGhlIGRyaXZlcnMgUlM0ODUgc3VwcG9ydCBpcyBkZWFjdGl2YXRlZCBpZiB0aGVyZSBpcyBubyBS
VFMgR1BJTyBhdmFpbGFibGUuClRoaXMgaXMgZG9uZSBieSBudWxsaWZ5aW5nIHRoZSBwb3J0cyBy
czQ4NV9zdXBwb3J0ZWQgc3RydWN0LiBBZnRlciB0aGF0Cmhvd2V2ZXIgdGhlIHNldHRpbmdzIGlu
IHNlcmlhbF9vbWFwX3JzNDg1X3N1cHBvcnRlZCBhcmUgYXNzaWduZWQgdG8gdGhlCnNhbWUgc3Ry
dWN0dXJlIHVuY29uZGl0aW9uYWxseSwgd2hpY2ggcmVzdWx0cyBpbiBhbiB1bmludGVuZGVkIHJl
YWN0aXZhdGlvbgpvZiBSUzQ4NSBzdXBwb3J0LgoKRml4IHRoaXMgYnkgbW92aW5nIHRoZSBhc3Np
Z25tZW50IHRvIHRoZSBiZWdpbm5pbmcgb2YKc2VyaWFsX29tYXBfcHJvYmVfcnM0ODUoKSBhbmQg
dGh1cyBiZWZvcmUgdWFydF9nZXRfcnM0ODVfbW9kZSgpIGdldHMKY2FsbGVkLgoKQWxzbyByZXBs
YWNlIHRoZSBhc3NpZ25tZW50IG9mIHJzNDg1X2NvbmZpZygpIHRvIGhhdmUgdGhlIGNvbXBsZXRl
IFJTNDg1CnNldHVwIGluIG9uZSBmdW5jdGlvbi4KCkZpeGVzOiBlMjc1MmFlM2NmYzkgKCJzZXJp
YWw6IG9tYXA6IERpc2FsbG93IFJTLTQ4NSBpZiBydHMtZ3BpbyBpcyBub3Qgc3BlY2lmaWVkIikK
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBv
IDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvb21hcC1z
ZXJpYWwuYyB8IDI3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL29tYXAtc2VyaWFs
LmMKaW5kZXggYWQ0YzFjNWQwYTdmLi5mNGM2ZmY4MDY0NjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
dHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNl
cmlhbC5jCkBAIC0xNDgzLDYgKzE0ODMsMTMgQEAgc3RhdGljIHN0cnVjdCBvbWFwX3VhcnRfcG9y
dF9pbmZvICpvZl9nZXRfdWFydF9wb3J0X2luZm8oc3RydWN0IGRldmljZSAqZGV2KQogCXJldHVy
biBvbWFwX3VwX2luZm87CiB9CiAKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IHNl
cmlhbF9vbWFwX3JzNDg1X3N1cHBvcnRlZCA9IHsKKwkuZmxhZ3MgPSBTRVJfUlM0ODVfRU5BQkxF
RCB8IFNFUl9SUzQ4NV9SVFNfT05fU0VORCB8IFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORCB8CisJ
CSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYLAorCS5kZWxheV9ydHNfYmVmb3JlX3NlbmQgPSAxLAor
CS5kZWxheV9ydHNfYWZ0ZXJfc2VuZCA9IDEsCit9OworCiBzdGF0aWMgaW50IHNlcmlhbF9vbWFw
X3Byb2JlX3JzNDg1KHN0cnVjdCB1YXJ0X29tYXBfcG9ydCAqdXAsCiAJCQkJICAgc3RydWN0IGRl
dmljZSAqZGV2KQogewpAQCAtMTQ5Nyw2ICsxNTA0LDkgQEAgc3RhdGljIGludCBzZXJpYWxfb21h
cF9wcm9iZV9yczQ4NShzdHJ1Y3QgdWFydF9vbWFwX3BvcnQgKnVwLAogCWlmICghbnApCiAJCXJl
dHVybiAwOwogCisJdXAtPnBvcnQucnM0ODVfY29uZmlnID0gc2VyaWFsX29tYXBfY29uZmlnX3Jz
NDg1OworCXVwLT5wb3J0LnJzNDg1X3N1cHBvcnRlZCA9IHNlcmlhbF9vbWFwX3JzNDg1X3N1cHBv
cnRlZDsKKwogCXJldCA9IHVhcnRfZ2V0X3JzNDg1X21vZGUoJnVwLT5wb3J0KTsKIAlpZiAocmV0
KQogCQlyZXR1cm4gcmV0OwpAQCAtMTUzMSwxMyArMTU0MSw2IEBAIHN0YXRpYyBpbnQgc2VyaWFs
X29tYXBfcHJvYmVfcnM0ODUoc3RydWN0IHVhcnRfb21hcF9wb3J0ICp1cCwKIAlyZXR1cm4gMDsK
IH0KIAotc3RhdGljIGNvbnN0IHN0cnVjdCBzZXJpYWxfcnM0ODUgc2VyaWFsX29tYXBfcnM0ODVf
c3VwcG9ydGVkID0gewotCS5mbGFncyA9IFNFUl9SUzQ4NV9FTkFCTEVEIHwgU0VSX1JTNDg1X1JU
U19PTl9TRU5EIHwgU0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EIHwKLQkJIFNFUl9SUzQ4NV9SWF9E
VVJJTkdfVFgsCi0JLmRlbGF5X3J0c19iZWZvcmVfc2VuZCA9IDEsCi0JLmRlbGF5X3J0c19hZnRl
cl9zZW5kID0gMSwKLX07Ci0KIHN0YXRpYyBpbnQgc2VyaWFsX29tYXBfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikKIHsKIAlzdHJ1Y3Qgb21hcF91YXJ0X3BvcnRfaW5mbyAqb21h
cF91cF9pbmZvID0gZGV2X2dldF9wbGF0ZGF0YSgmcGRldi0+ZGV2KTsKQEAgLTE2MDQsMTcgKzE2
MDcsMTEgQEAgc3RhdGljIGludCBzZXJpYWxfb21hcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQogCQlkZXZfaW5mbyh1cC0+cG9ydC5kZXYsICJubyB3YWtlaXJxIGZvciB1YXJ0
JWRcbiIsCiAJCQkgdXAtPnBvcnQubGluZSk7CiAKLQlyZXQgPSBzZXJpYWxfb21hcF9wcm9iZV9y
czQ4NSh1cCwgJnBkZXYtPmRldik7Ci0JaWYgKHJldCA8IDApCi0JCWdvdG8gZXJyX3JzNDg1Owot
CiAJc3ByaW50Zih1cC0+bmFtZSwgIk9NQVAgVUFSVCVkIiwgdXAtPnBvcnQubGluZSk7CiAJdXAt
PnBvcnQubWFwYmFzZSA9IG1lbS0+c3RhcnQ7CiAJdXAtPnBvcnQubWVtYmFzZSA9IGJhc2U7CiAJ
dXAtPnBvcnQuZmxhZ3MgPSBvbWFwX3VwX2luZm8tPmZsYWdzOwogCXVwLT5wb3J0LnVhcnRjbGsg
PSBvbWFwX3VwX2luZm8tPnVhcnRjbGs7Ci0JdXAtPnBvcnQucnM0ODVfY29uZmlnID0gc2VyaWFs
X29tYXBfY29uZmlnX3JzNDg1OwotCXVwLT5wb3J0LnJzNDg1X3N1cHBvcnRlZCA9IHNlcmlhbF9v
bWFwX3JzNDg1X3N1cHBvcnRlZDsKIAlpZiAoIXVwLT5wb3J0LnVhcnRjbGspIHsKIAkJdXAtPnBv
cnQudWFydGNsayA9IERFRkFVTFRfQ0xLX1NQRUVEOwogCQlkZXZfd2FybigmcGRldi0+ZGV2LApA
QCAtMTYyMiw2ICsxNjE5LDEwIEBAIHN0YXRpYyBpbnQgc2VyaWFsX29tYXBfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJCSBERUZBVUxUX0NMS19TUEVFRCk7CiAJfQogCisJ
cmV0ID0gc2VyaWFsX29tYXBfcHJvYmVfcnM0ODUodXAsICZwZGV2LT5kZXYpOworCWlmIChyZXQg
PCAwKQorCQlnb3RvIGVycl9yczQ4NTsKKwogCXVwLT5sYXRlbmN5ID0gUE1fUU9TX0NQVV9MQVRF
TkNZX0RFRkFVTFRfVkFMVUU7CiAJdXAtPmNhbGNfbGF0ZW5jeSA9IFBNX1FPU19DUFVfTEFURU5D
WV9ERUZBVUxUX1ZBTFVFOwogCWNwdV9sYXRlbmN5X3Fvc19hZGRfcmVxdWVzdCgmdXAtPnBtX3Fv
c19yZXF1ZXN0LCB1cC0+bGF0ZW5jeSk7Ci0tIAoyLjQzLjAKCg==

