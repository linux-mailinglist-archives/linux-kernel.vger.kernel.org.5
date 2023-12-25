Return-Path: <linux-kernel+bounces-11020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD5881E025
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0297C282126
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F69853806;
	Mon, 25 Dec 2023 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="no0UPUwQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149EF52F8F;
	Mon, 25 Dec 2023 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFMvX2cqB4MV0caLkGCbYe38JMLpp3gOkodkG7o8LkCohpkAZ4hKT0hJKCbIQ5N3omFJcctyCguqgc8zR+od2KKs2fIeEk5pwAOJhtJ7bXRg6Wj0qwxdIXM+rI7MTd+zkd1yacd9PbVS4tzqwGiAhiIBKTYWkG9iure+addGErnt1TGdP4qE7J3guOXd0AicI2kqkQB8dkbB9b2RbwmyVpBhMy5qSvD/3BbfkQ1F8if86E5yPWD05k6JnlaQhOCczdOp0qmdp6+2RoWGgKHi0IKPF8hXVA7q6yVbCvR8A3v0dz/3PE3QVj4j8RjkH+huZXu1XOidXcMUb+7IhbDpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ROGmuOC2TLqjECCgazHB9VmmEt4XgeMwjvGKQa0cQI=;
 b=DS2AiYxJCcigOl9SWHlQJbSjNDZHdkZY8AIkRK8DkfS0vdcNblNRQamMApihyA4s5TQUBT8lq+xB8SWumnhSEXTfVIXYFxyhmMP+v2co+Cwq6S3gliDLz6BBMWfJ2jZQhiJ2PhDC8KYlH/gB3ys/sapzwFG6sUqYNLsd3R3kO+l6Z6jbJbzRnUyFqJxTVhea6UTZHeD7QtiP1UZmcVjNOEWlWoYhsAbIPH05K5surnjoogHE9wbOyMKJ24zHL00cbcUqAZmnJCzwCNTmjMXxJamcM+zSlkoxxXXlgOKzvDhF2dBNjFSBL8PNZ9WWGkt6TOVf3gbWED8FJt315M4BWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ROGmuOC2TLqjECCgazHB9VmmEt4XgeMwjvGKQa0cQI=;
 b=no0UPUwQ6FA6scLTzxETjAPz8yXSmAp//CSh2wr+8G8g/7dqcTvVB5NdIXe601as15kztalLT7PptROvgsZMjhZTjFqDjQGSC3+78pcMtudcNH1wdQn5v7YowiSRV9qNDA8s64rTlh/j940j4tHdgZXoEWreyd6Ll8W8b0s9nRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB2061.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 11:35:56 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 11:35:56 +0000
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
Subject: [PATCH v6 6/7] serial: omap: do not override settings for RS485 support
Date: Mon, 25 Dec 2023 12:35:22 +0100
Message-ID: <20231225113524.8800-7-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225113524.8800-1-l.sanfilippo@kunbus.com>
References: <20231225113524.8800-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: 7e8ec249-c1a4-450b-2ab8-08dc053da808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vx2UV8R5h3VLPB4KJlIRch5nVKThQ9aHSrs32vQcxB09mHjEddEiFH5N4EHIhbp9g+SMf4HJbatuj9jrgKP866ljcmRf2rbU7jXamIHO7t59FEktR09Z0qQhgWqqlSj2Km4m3g3mK9XdNGNrTTVuPnh9+lE1elfPAseBiUCBrOG6ZhY7Q1f63odIBKZilF+VtG+SdgjKaiqalAxdFCom5Nvotx4WUopsagJJZHiUYqhgDtbgwUnbHowNO5HvStKezAs9Ajb8JsHF3XsrER+VvJ3xk7MMj291b3AdV7WY1ThyI+xgPSzhpSJcK0vbhhY4PgOPFGXFX2oRANcw/B15yqnJtUUzr3AaAET863QFe+bGrzFLdbEc/zxOre91EZfLGI267eDP9bnmqU/aANWbSloFwmpuyqrQdg0y8yQrVk4XOqa5Vc7VrbxqfTRAvlRvQ1FuuQPzoGjv2eXMhbf+NpJZ49Kj0qHNbM64fh6NOKRyGa6xD2UDRlAumilMk9pmZ7SmBMkOjTkrzgHPN/AzCu5yxvAQvT6bxNzyMBqmwlFTn5EsRmtIo2cbYa0hw3RX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(366004)(346002)(136003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(6666004)(6486002)(478600001)(2906002)(8676002)(8936002)(5660300002)(36756003)(7416002)(52116002)(6512007)(6506007)(66556008)(66476007)(4326008)(66946007)(316002)(83380400001)(86362001)(1076003)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2TlGRWmsH/EkwMNsS1FPAce1CRSDyYmZ98XMFI76VFzms6H9xBeL+12GfPaF?=
 =?us-ascii?Q?MsauB16mJ661Lko2tcSDNPfXwdfFwS5wl6cLJir1bZTlj4gtENySeg/B3XeX?=
 =?us-ascii?Q?8lDx7RHO3wsZ+oJwT5qhKIKikO8erNgI74EiE8xLXtS9cQF/1BXlFiTUqbeb?=
 =?us-ascii?Q?CVaWDE9rzT3PAz8s12o7EIg3U4gDu50EdnY7Hp5v5AftflpUH+KC9JB76qN+?=
 =?us-ascii?Q?XUBIgcv+TXuLkFNhIplXnJ2hGrGa3ZtdmSv5nGnTKTJccmRrqhcbNi0RmicO?=
 =?us-ascii?Q?iwKt6NnI3RDLgjQaJo5jYFN3Fvd+nFNfsnwSFf8+hWQpSno6/jscMA2+8+sP?=
 =?us-ascii?Q?RExXLhMU4WNrQErplhUy6HwdSkFRiezAAPIwzUIui6BzDOB4pAYSoHM6edWe?=
 =?us-ascii?Q?maayhHkDegqokIalDFLbyramlmlHc3znsd3G9eznXGTikUWicHMGgGCN+JtD?=
 =?us-ascii?Q?WDJiUR7CdAI5KCpxxaeOCS5PyS8SLHh4URYpHLjc46pcBH9HutkLUVmm7kt/?=
 =?us-ascii?Q?TKwf+tbLs1lnV7C145jFXMIjmbNmwP5YGvOe+b3Xz5LKBJXap5NEvrVX/7DQ?=
 =?us-ascii?Q?x0ydyFbbd2O/pnUmUgkNXYC5yJSOVKiAbGwVnFJztSsMgGZ+hPKi7Zb24nDX?=
 =?us-ascii?Q?CqrVwk/4yW9pQHGnJjw56Z8b1QD5FWQYHNOoRAfMR9Zi8/IsXOPRxip1iKZr?=
 =?us-ascii?Q?hGp9PlRw6zK8AJgqvuMFlduHr5WzLrpjQqNpOnNGKfLodI9PKgjgjoH8yb1Q?=
 =?us-ascii?Q?cXOCGhLIekXZkNheL/jGjT1drHq9GXCfDeZnZGsHk4WSLF8mTUpiQyFalqhc?=
 =?us-ascii?Q?yJE/BbA87B1AlbrqRr1XLKcZ9nD48+iEfNKQUZmYgfJu3oxF191NoQ5kH2rh?=
 =?us-ascii?Q?6SO5WvVjHQJLvERbZaaTDGri6hYmeinuwTDl/IMa2wcXyvrdt/VgctLORl3U?=
 =?us-ascii?Q?i8jogWCZX1xG93Eja3cI6xpvcj15rpEKGUBzfWccYh8bGg4gP6WelTSFIW1K?=
 =?us-ascii?Q?NAFhp86mw72xfL9bXpQ0ZerZAiVLAvWZcRTT00N1fjyJIZt60kz4HWTLEj9H?=
 =?us-ascii?Q?HKQT82NrhhVHI37pxF3kxfB0M341qtC16oT5YeMwMWzbZRfj73WD7XJKS5cb?=
 =?us-ascii?Q?GDQ7MmoF+wjl03Kawm6HKLkHYkdDQBv/4qc6UY/fmX06e3PPqmtXlkGQ0RtP?=
 =?us-ascii?Q?uAsgGe4iaY79GSl7GW5YNarZgzTwh283nU08QYRbQ05/OWkUL4gte/pxWAbq?=
 =?us-ascii?Q?A4hwVwILqQ2BiEiKahMdMekUDm250ba/rt/E0nRdQpvXfoAABDGRw1b5pz2C?=
 =?us-ascii?Q?7mvdQonxUdlXkS3PHAuZCPDCvHeCmNN/2vbFJCMGthEjGdT5VYmibc3ngoI3?=
 =?us-ascii?Q?yE/IUjEl87ZgjxkbMGXMT7MpoGkiJ9g3ZYk0nfr19gfJN6Abl6sxhzW1FYR+?=
 =?us-ascii?Q?Fu6RGK+5eHT0qJg+s3aN2iS1XYP7/yAUt9YA5LkDeKbe/rBUmeibEFdLPXci?=
 =?us-ascii?Q?ckuINjfgRIOPnQRqgDzPOZZtVFuN3Btbp97spltTQ5087enkAqL7zdWzt96d?=
 =?us-ascii?Q?nMehDKmRBMieJB7CnN9CSsOyI+yqh5XcecGhBTATF9pYMbfgPr8LWiCpcI+m?=
 =?us-ascii?Q?as2Y9ccbqH14mhwEHYTgihnJpK+9oxEVjzJ0vQ3TWqwV?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8ec249-c1a4-450b-2ab8-08dc053da808
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 11:35:55.1328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jivhMEjxjQ7hctgKLt4/1a0f4GQMAzY2ydnYFwLA5+VZKIs/M78JN9XKJsq9iwnyTvzYXb2zQ7bvdhKaBWOcIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2061

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
ZXJpYWwuYyB8IDEzICsrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL29tYXAt
c2VyaWFsLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvb21hcC1zZXJpYWwuYwppbmRleCBhZDRjMWM1
ZDBhN2YuLmI1NjNjMTA5Y2FhOSAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL29tYXAt
c2VyaWFsLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL29tYXAtc2VyaWFsLmMKQEAgLTE0OTcs
NiArMTQ5Nyw5IEBAIHN0YXRpYyBpbnQgc2VyaWFsX29tYXBfcHJvYmVfcnM0ODUoc3RydWN0IHVh
cnRfb21hcF9wb3J0ICp1cCwKIAlpZiAoIW5wKQogCQlyZXR1cm4gMDsKIAorCXVwLT5wb3J0LnJz
NDg1X2NvbmZpZyA9IHNlcmlhbF9vbWFwX2NvbmZpZ19yczQ4NTsKKwl1cC0+cG9ydC5yczQ4NV9z
dXBwb3J0ZWQgPSBzZXJpYWxfb21hcF9yczQ4NV9zdXBwb3J0ZWQ7CisKIAlyZXQgPSB1YXJ0X2dl
dF9yczQ4NV9tb2RlKCZ1cC0+cG9ydCk7CiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKQEAgLTE2
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

