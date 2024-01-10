Return-Path: <linux-kernel+bounces-22272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B96829BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C4F1C221B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889AA4B5B3;
	Wed, 10 Jan 2024 13:48:00 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2044.outbound.protection.partner.outlook.cn [139.219.17.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906848CF0;
	Wed, 10 Jan 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP2hzX9ymHbAzia5+Ol5an9lInAwUPBMAEmotz9QrCAtnbUuwOFnkyyGCEqpsI/oBj1f8mLQnvKgko+zpTMheFwCiJ/UgkzGSj0ED9cEpyiuq4ewGzLuK2tY0jSf86a35FtvBOEIstup3UJnaaaXbz8sHHCQqq6n0Ux7iKUZ0b+XwR9LinUpvgzSSbThjdXqF6Fw7crFyFgXVUy9xSRibeg7a/6PII55Ff6M5G8C/EPisaQ0SAJYsINCSXUv7oCBn76vRYiT8IsJrHTaBvab84OSXc+kwCZeW+0n7Wseex8Ju33rKGQ/Dst2p453lp9KmVn68Zz6lHdTfFyqxxj1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kF8zk8SysyBKwe0A4Yai6sY1nW9euDRfLL1DlkFZiME=;
 b=n8JoPvKcx76y0fe4nj7HLantqrkuR2yzZmzUZGR2oWwhx7vUKSFQp9FBFVJ+YKozcQ6TTrpCPUtXfUBMkdQT1ALzc7tjJM90+nonfxlgpuOXyiQ9w5a4bugN9TtMdH1YCE7y1SyyxUKv3UDDckOjarejEH63sXfEpUdWziVUQIvjBO3d0OnBG9jCnX0KV0xKEaHiNk00FDd3WFQ38FWW5GR4Zrjty4aXVp1ykA5ZISmqaXNkmnrCkcFNcese2YqTe+FNIVWUqD2NxSBMIlQP/8OMoLzamzUwxKhrkxg51b+b8OpiSqmNWoQxS/HO/z4Hc0w3MROqTqV0VHORz8RZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0865.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:31:49 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:31:49 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: kernel@esmil.dk,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	emil.renner.berthing@canonical.com,
	hal.feng@starfivetech.com,
	xingyu.wu@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	jeeheng.sia@starfivetech.com,
	leyfoon.tan@starfivetech.com
Subject: [RFC v3 02/16] reset: starfive: Convert the word "jh71x0" to "starfive"
Date: Wed, 10 Jan 2024 21:31:14 +0800
Message-Id: <20240110133128.286657-3-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0865:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a960370-3c5b-4958-583e-08dc11e07fd1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u0wb+HqQlYJui5YK1RfiV6ENm8zUwTmeXUI5yeVSQz4xQJlko90/1bTT1IVF4ImbM/AGwPkn2///ztsbGjt3R97imk6MQafMmZtFi1KKsthxNl0QE2UfOy7bIkDHuVCw1v2yhTBBJ4DZBZPj2SVpdwjNVuLebc5+5jFoZ1JBqCsumcwwnNmcehoYhUYfn0BgOIf7tJQqr2T69JyKe3kRhTqFkfmg2XwjOJHPmEkMUHKs4Qo8fxUdnlk67TFUQP59ukcKyGke9/GrNpdSvRAa3gTDQ48XIwlU5AsE+lZ34ikgbkzf08vPUSSiyxh6afmVGWjModj2b3CxhBDlvMJ05tQ+8S7arsbcyMVsu88jvKxSm6SdSr453FL+1mSA6QZ/WXnQ/0tTBY4ZOHS9HZPNbnlKXGhI33LJ7IoT5CYWcVoN0sOoIsJxnvhCpPow28itnGLbq0xji7yy9n4JJQGzRDIiC7poFTVp5LbQ4N5FJlnup/zdx7cuP9rvPwo0tKtbmfXCApOryB2wtT3W2jaqZ3CPNxdXQZ5fRtN6d+WHHhiiY53Ypku75Fu57+M8DiItgRzHERCYPYMuvy+Vs5hIDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39830400003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41320700001)(6666004)(508600001)(55236004)(52116002)(2616005)(107886003)(1076003)(26005)(38100700002)(40160700002)(38350700005)(921011)(86362001)(40180700001)(36756003)(41300700001)(4326008)(7416002)(83380400001)(5660300002)(2906002)(8936002)(8676002)(66946007)(66556008)(66476007)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P3exgadEEYXC+28ag6d8QNzHmKXJCAvEGuOOpNUFAdxPm45nNULbvXfcfMF9?=
 =?us-ascii?Q?vIuYLgakSvC7e1mUQmmthabBbVhvLtCp/eXki4lMIKMa9RrAr5cxNQh6bG6D?=
 =?us-ascii?Q?JddbAfSHQEESMMVD0OW2nsBqOCcqYQN5HWsEnsRzlV5xSGpkyfyI1fKc+44M?=
 =?us-ascii?Q?SlIxJYGIYftv/idO91xjVsWR8DYpIby/KAYOWweM8hi4dFWXfjIKWOO9ihqZ?=
 =?us-ascii?Q?v9dDWRZWvusFmY+X2C9qZm0GyNWRIObasnpT2doHOJX8slA01A3/ij2U6erL?=
 =?us-ascii?Q?yjdNZjyvjv+9uhEctr4B+wXgPCOXhsdFYg4H3pbYl0NHIF9CjqWfzmR1Gqoq?=
 =?us-ascii?Q?V4YzjjuV05KpnihIqZvanbAaQm/kgVqFrIj22ZMm2Mdl63jHX1TGaQcc5XP3?=
 =?us-ascii?Q?KZK5MNx6yTze13RQ+EfgM2e0TDFKqhNiKbXWLd2K2x/ZTKD4cUKOIXsFf9HR?=
 =?us-ascii?Q?AJjpCcOtAnK4mYTO80FYGBVxwIU6pPxaItaZPpoWbEkgPbcUuuTN1ZwRL4mH?=
 =?us-ascii?Q?za4eSgLYVnwDser81rgfvzJ6MOHcYW/bRkJ/BDWj9jGaMKm1hCOuGwWsdwWG?=
 =?us-ascii?Q?zSQUb5VGyCb7LbuHDd0ark11MoYzSJvXNvNZYQirxc+4BxkkdbO0DZ2kIpfo?=
 =?us-ascii?Q?zePis160PMWwCPssvvN/JTRs6wS6U0poZRtS/nupqvBPd/RdVoN0AJQged3V?=
 =?us-ascii?Q?7IoFvE8ioTLV7mFfnQvo06lU75JYD6ccvy0FZDzeqw9Qn3E11AxyCi8UnrHN?=
 =?us-ascii?Q?OmjpCSTswIL8F4yMwEba0Ontu+Lf2rx5R0DD1LpxrXYFewD9wWl5+LK3SbIw?=
 =?us-ascii?Q?L08EXk8FNGH5Zx/B7CFaYDZKp923RiDEJxfoNiBN5rAB3ghFcYNNQFN1u5wf?=
 =?us-ascii?Q?3xsDTVhmWmKNEwiJjLkXjWypt6r9kLv2TJBdRUlwbTKJQlBxYexWjq5M8u6n?=
 =?us-ascii?Q?wDsY7znua9kGEqbd/z4XD3zmCLsuTI2G6iM20z5nTNGM+svBZeSCelPqxwkI?=
 =?us-ascii?Q?SSnm7oHT9e+YfRRvK+YpMf9PEYCULbOUgluDHrQBZw51zWaqqEgM8w+SJls1?=
 =?us-ascii?Q?GEaIuyYCluVOdB2Awh7dTBEvH6fJh4PIA+16HhYOVrNiTqHvpkorxCepUQZK?=
 =?us-ascii?Q?Ub53gT+PEr+uBf5X0iF/2iuuA1HeRXOl4Vk7apbuz2p2JzKSE5CSBFUuJAJB?=
 =?us-ascii?Q?VMonj79/5836O9qGBd8YCJH9yW1PQ2gVqHw77jDpLkBWcQTjIFo6yzvBqIQG?=
 =?us-ascii?Q?IQjRsealMAomAZ2phITmNxBkLL0TGN4QcDaLHpVhU1N8kyxxTYLq0Ypnq34K?=
 =?us-ascii?Q?zmZtilv8yp+BiIeW2v4pe3llnnOQupXs3J30qW5cYKJ7krm388bcWpS90Tqi?=
 =?us-ascii?Q?GUg/VZGRBIKHXXyz+AXcvyd9LEejrPkNNL9FEDP4usGngSzu9XKYc6V023Y6?=
 =?us-ascii?Q?BnHNbvah/JpHB73hU+7c5VJPQHLYScjL6RVZqC4UYQL+XnVJOY0KQEjh6J+1?=
 =?us-ascii?Q?tJFuasnpxKyVPAxPkCUBWHxHkjl11yHsbsaxGE6o8UInMe7jOYUFas/ilYIL?=
 =?us-ascii?Q?OzfmiSJbJONsWX8MVklUkohg1prjs/Ldiy5ZALP7U2wCv+eIUjqar4zSD/Ld?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a960370-3c5b-4958-583e-08dc11e07fd1
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:31:49.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7ioOh7b3LP76UHOTayai3dgBoyYOlmDzaO4LoXIu3sWPgvvrRUWXolj5AleRqMkbdRxbWlL33JiZD7uRiAf18e2XB5qWkS/iZT5y9F3A1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0865

Function names that consist of the 'jh71x0' naming convention are
renamed to use the 'starfive' wording.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../clk/starfive/clk-starfive-jh7110-sys.c    |  4 +-
 .../reset/starfive/reset-starfive-common.c    | 64 +++++++++----------
 .../reset/starfive/reset-starfive-common.h    |  8 +--
 .../reset/starfive/reset-starfive-jh7100.c    |  2 +-
 .../reset/starfive/reset-starfive-jh7110.c    |  4 +-
 include/soc/starfive/reset-starfive-common.h  |  6 +-
 6 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 6e45c580c9ba..e63353c70209 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -345,7 +345,7 @@ static void jh7110_reset_unregister_adev(void *_adev)
 static void jh7110_reset_adev_release(struct device *dev)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
 
 	kfree(rdev);
 }
@@ -354,7 +354,7 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
 				     const char *adev_name,
 				     u32 adev_id)
 {
-	struct jh71x0_reset_adev *rdev;
+	struct starfive_reset_adev *rdev;
 	struct auxiliary_device *adev;
 	int ret;
 
diff --git a/drivers/reset/starfive/reset-starfive-common.c b/drivers/reset/starfive/reset-starfive-common.c
index dab454e46bbf..8d8dec9e5d7a 100644
--- a/drivers/reset/starfive/reset-starfive-common.c
+++ b/drivers/reset/starfive/reset-starfive-common.c
@@ -14,7 +14,7 @@
 
 #include "reset-starfive-common.h"
 
-struct jh71x0_reset {
+struct starfive_reset {
 	struct reset_controller_dev rcdev;
 	/* protect registers against concurrent read-modify-write */
 	spinlock_t lock;
@@ -23,16 +23,16 @@ struct jh71x0_reset {
 	const u32 *asserted;
 };
 
-static inline struct jh71x0_reset *
-jh71x0_reset_from(struct reset_controller_dev *rcdev)
+static inline struct starfive_reset *
+starfive_reset_from(struct reset_controller_dev *rcdev)
 {
-	return container_of(rcdev, struct jh71x0_reset, rcdev);
+	return container_of(rcdev, struct starfive_reset, rcdev);
 }
 
-static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
-			       unsigned long id, bool assert)
+static int starfive_reset_update(struct reset_controller_dev *rcdev,
+				 unsigned long id, bool assert)
 {
-	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
+	struct starfive_reset *data = starfive_reset_from(rcdev);
 	unsigned long offset = id / 32;
 	u32 mask = BIT(id % 32);
 	void __iomem *reg_assert = data->assert + offset * sizeof(u32);
@@ -61,34 +61,34 @@ static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
 	return ret;
 }
 
-static int jh71x0_reset_assert(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int starfive_reset_assert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
-	return jh71x0_reset_update(rcdev, id, true);
+	return starfive_reset_update(rcdev, id, true);
 }
 
-static int jh71x0_reset_deassert(struct reset_controller_dev *rcdev,
-				 unsigned long id)
+static int starfive_reset_deassert(struct reset_controller_dev *rcdev,
+				   unsigned long id)
 {
-	return jh71x0_reset_update(rcdev, id, false);
+	return starfive_reset_update(rcdev, id, false);
 }
 
-static int jh71x0_reset_reset(struct reset_controller_dev *rcdev,
-			      unsigned long id)
+static int starfive_reset_reset(struct reset_controller_dev *rcdev,
+				unsigned long id)
 {
 	int ret;
 
-	ret = jh71x0_reset_assert(rcdev, id);
+	ret = starfive_reset_assert(rcdev, id);
 	if (ret)
 		return ret;
 
-	return jh71x0_reset_deassert(rcdev, id);
+	return starfive_reset_deassert(rcdev, id);
 }
 
-static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int starfive_reset_status(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
-	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
+	struct starfive_reset *data = starfive_reset_from(rcdev);
 	unsigned long offset = id / 32;
 	u32 mask = BIT(id % 32);
 	void __iomem *reg_status = data->status + offset * sizeof(u32);
@@ -97,25 +97,25 @@ static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
 	return !((value ^ data->asserted[offset]) & mask);
 }
 
-static const struct reset_control_ops jh71x0_reset_ops = {
-	.assert		= jh71x0_reset_assert,
-	.deassert	= jh71x0_reset_deassert,
-	.reset		= jh71x0_reset_reset,
-	.status		= jh71x0_reset_status,
+static const struct reset_control_ops starfive_reset_ops = {
+	.assert		= starfive_reset_assert,
+	.deassert	= starfive_reset_deassert,
+	.reset		= starfive_reset_reset,
+	.status		= starfive_reset_status,
 };
 
-int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
-				   void __iomem *assert, void __iomem *status,
-				   const u32 *asserted, unsigned int nr_resets,
-				   struct module *owner)
+int reset_starfive_register(struct device *dev, struct device_node *of_node,
+			    void __iomem *assert, void __iomem *status,
+			    const u32 *asserted, unsigned int nr_resets,
+			    struct module *owner)
 {
-	struct jh71x0_reset *data;
+	struct starfive_reset *data;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->rcdev.ops = &jh71x0_reset_ops;
+	data->rcdev.ops = &starfive_reset_ops;
 	data->rcdev.owner = owner;
 	data->rcdev.nr_resets = nr_resets;
 	data->rcdev.dev = dev;
@@ -128,4 +128,4 @@ int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_no
 
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
-EXPORT_SYMBOL_GPL(reset_starfive_jh71x0_register);
+EXPORT_SYMBOL_GPL(reset_starfive_register);
diff --git a/drivers/reset/starfive/reset-starfive-common.h b/drivers/reset/starfive/reset-starfive-common.h
index 266acc4b2caf..83461b22ee55 100644
--- a/drivers/reset/starfive/reset-starfive-common.h
+++ b/drivers/reset/starfive/reset-starfive-common.h
@@ -6,9 +6,9 @@
 #ifndef __RESET_STARFIVE_COMMON_H
 #define __RESET_STARFIVE_COMMON_H
 
-int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
-				   void __iomem *assert, void __iomem *status,
-				   const u32 *asserted, unsigned int nr_resets,
-				   struct module *owner);
+int reset_starfive_register(struct device *dev, struct device_node *of_node,
+			    void __iomem *assert, void __iomem *status,
+			    const u32 *asserted, unsigned int nr_resets,
+			    struct module *owner);
 
 #endif /* __RESET_STARFIVE_COMMON_H */
diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
index 546dea2e5811..122ac6c3893b 100644
--- a/drivers/reset/starfive/reset-starfive-jh7100.c
+++ b/drivers/reset/starfive/reset-starfive-jh7100.c
@@ -51,7 +51,7 @@ static int __init jh7100_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	return reset_starfive_jh71x0_register(&pdev->dev, pdev->dev.of_node,
+	return reset_starfive_register(&pdev->dev, pdev->dev.of_node,
 					      base + JH7100_RESET_ASSERT0,
 					      base + JH7100_RESET_STATUS0,
 					      jh7100_reset_asserted,
diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
index 87dba01491ae..c4dd21761e53 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -53,13 +53,13 @@ static int jh7110_reset_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
 	struct jh7110_reset_info *info = (struct jh7110_reset_info *)(id->driver_data);
-	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
 	void __iomem *base = rdev->base;
 
 	if (!info || !base)
 		return -ENODEV;
 
-	return reset_starfive_jh71x0_register(&adev->dev, adev->dev.parent->of_node,
+	return reset_starfive_register(&adev->dev, adev->dev.parent->of_node,
 					      base + info->assert_offset,
 					      base + info->status_offset,
 					      NULL,
diff --git a/include/soc/starfive/reset-starfive-common.h b/include/soc/starfive/reset-starfive-common.h
index 56d8f413cf18..16df46a074bc 100644
--- a/include/soc/starfive/reset-starfive-common.h
+++ b/include/soc/starfive/reset-starfive-common.h
@@ -6,12 +6,12 @@
 #include <linux/compiler_types.h>
 #include <linux/container_of.h>
 
-struct jh71x0_reset_adev {
+struct starfive_reset_adev {
 	void __iomem *base;
 	struct auxiliary_device adev;
 };
 
-#define to_jh71x0_reset_adev(_adev) \
-	container_of((_adev), struct jh71x0_reset_adev, adev)
+#define to_starfive_reset_adev(_adev) \
+	container_of((_adev), struct starfive_reset_adev, adev)
 
 #endif
-- 
2.34.1


