Return-Path: <linux-kernel+bounces-138301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A521989EF89
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0226C284EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F70158D60;
	Wed, 10 Apr 2024 10:06:26 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54E156C77;
	Wed, 10 Apr 2024 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743585; cv=fail; b=Ypj9bzKB+idNTayOI5wWGICRc2Yxci0PABpLOvFoA0Mzl9hTdRHqC8tTzwUC3mRD8lfpGJDL3AV2f7kTq+x6XVSyoJtzAB3Pv4tOvlJXWOO9KRI3YiDnX781Rxv4WxgLDoP35z3S3i0MzWomr6FFgiCEfoymJnlUeCfllhNJU8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743585; c=relaxed/simple;
	bh=2iWRar7Cn4250EEChDPfwP5nD8TtWIKjATHii4swP4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IaKt2Rch/miegTKFzTXT9jGMbTeQg+dHZy7W21vMzCOj5eqal8PVctAX/tUSxfXbY5/ozAlwcL0M8M1WfvfwqBRLWB04t9w6p79UvsW7sk2eVdHwXclaus0ZvGC70cIazI0nXNyqSZAEQXFd+hg3emHgnZ4Tvem9s0TJ0y/ZisU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYAjkpgZ8VxAvp0heh2KTKdSthCosc20xmJCzkSRTYtfNj4mH/bkkQuxE0LG9RIEN6LD4CADJ4VPo4q1jwJyGBU30ZbRCo0ZtdEcwTEWjoIOlc+oXnLClj6HblsdIJ72zhw3HAYmwmJrnkBLLYQMvP8/yceJ8diGHTP+Np3pWlD9zZ3YEk+fn6m3T+uzk1b8qrtj2LitAFLdHImQOS50bi7isZVM1BYqKPLBa1H2Apb8JGaz53lN0/hir8mguIYy363FiIkqy+5p4Xe/52nPLCj8lzQZrG4VFgHCP7L9Cvxlyn0VlZXEJo0yaj1/99S0VTv2OLw3isgTQpGTlW0KJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/5MChuanEqmbBcI5dd7l05/xpiV8Fdo3YJTMWDUkzk=;
 b=Qd/mGYJz0Cd0NjbCQ507uomNfB7mlU0PA/VWFrLbSsUWeyJwqku3XL5EUplCx1X1+maq9IzcxJL/BkAjmcm1f3VY2DF5t/ubZTvmgGa/b/dOo9dowzFFf186YzWndtxjvpZhc0W7WJ46AuOIp8r3oWy2VgiKYYrZRa70Cum3GaaRZpJ0CFyNl2yY9FE1cFjtuAMA1wF0duSBv99fWhGaGetQEn+MZVGqJGOHuFZyRby5nujY9+V0O1ggAp+W/YGs4XrRF207Iqp5e5z2w4G4BUG911Axzv82GTBokyaFCfc60rwXI33J/cBJ36u71/ITUIYiWqrpCIpW3Y5LXQSaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1132.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 03:31:56 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9]) by NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 03:31:56 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] clk: starfive: jh7110-sys: Add notifier for PLL clock
Date: Wed, 10 Apr 2024 11:31:47 +0800
Message-Id: <20240410033148.213991-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410033148.213991-1-xingyu.wu@starfivetech.com>
References: <20240410033148.213991-1-xingyu.wu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0002.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::23) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1132:EE_
X-MS-Office365-Filtering-Correlation-Id: 5096103e-13fb-4616-a8f6-08dc590ec571
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	poY8uf4Bdt7w+S3yoDuXOgUVg7laUlIO3wKcGvq0XRLjLazPAadmmPtoaRYxaIxdK7rjVDZBH/RmboRlaeKPFPTsi/Yxb30Qt6gWwECdHYS6NaMcZB1SZOysDCwR6Kma/5lrfZtAO1KwBKdKpixnNEq4G1T591n/kgTvNY+d8pcem29pWLjl82A5ZgqjVHiaT1mF/khKB3J7+OntWDMg1YpwYJk9rq2/aqO5zY7x+W8BJ6rJOWKspdXypQqac+w5st2aCH8IwrAYBQ0G83imAS/130GwXgcUAihyNK8ib2zNy3CMCLO22qEzdvknbDl1OgkP5Rk+RQfphFjtBwXrUi2tJXDTzcEvHOoQx2hq62fRb0XuZB4kdrtTpGXEVUDruJzSUlgYp5iXblUBdoYOyFPwtZ3/F8e+kW8Eek00pky8Ph3MfvYRpHLw2CrPxpyXaYPME8Kk28wQL1O7H9aPfTr5eI7dZ8t9FaSSMFkBWXa8cbGsRHE8071kLyjJqDCVzvTSFm3bwV+165BdQr44SZgXtL8fQ7ptC9RDilRrIVimu1tVZTTcjKwLJjTtri6TQhMpDIDk+zxs08xoPHMJeb1VcroclKoobfaxtpdzo84BKqhe7mha7ZO2/juwYJfr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l+2e8M1TfT57hcKmg7pNgC6bz/D0WiWnNuLpGEen6xcCazdOXfGHqLfXTZPK?=
 =?us-ascii?Q?ZTtX5OdlRKEWTOIG2cljya/DH0+sd0/NbaF6N3gwzoiowLeJlg9exBcvvJe9?=
 =?us-ascii?Q?D1bdN6s8QnKX+06dlHKLGbbuejwPRiQvfBBVmuseHwNNt9+tnybBYngh68W1?=
 =?us-ascii?Q?wRTcWc+xwnBRPRmPOOHIPXQFgwy2wqbi31zNv5B/GFqJnv/cx/3CPwRM8MDb?=
 =?us-ascii?Q?STDbaQPl6ig1zifSr/6RjgrGO1HgAQqX7yMqmAStwVuXNRyLICYeQTR1V1Sr?=
 =?us-ascii?Q?0SnoV4d6dq41Zyg0IXDXMrn9+Bg1uUPvo6YNXQydJog+cP1tCy8lrSrOFzPW?=
 =?us-ascii?Q?UnW+ScI8m/6MmyByerqYgLHk8IIO8KFoHrKM008yxFYtP/+B9m//9Gj8SUpa?=
 =?us-ascii?Q?3ecqbohfPizUpuZyINSDdO5HxSr41G/N+56HZQsaQswqtYj1otPNg0ZlSVmr?=
 =?us-ascii?Q?TV533JoJTiKKW5dftcDJyGKP+zv6g6CgQeR98HCdnrnUBboHIFY3/m1kv1pk?=
 =?us-ascii?Q?px6LzUoyT4tXg1sFFC8UKeuV3akKxoUA5UfdQyuAr2tzCaGffprLrvrQQcIg?=
 =?us-ascii?Q?QwYhLtfn5zsDeNi0+oEu0i57JwBPfqZ4xvsbHtm2rL6VI3VuhOHx3270T8ai?=
 =?us-ascii?Q?KsSKoi3ZhuOzxGE8IG0Bus9LyMf9F9ZQ6of7rt348vnDEhjcv5QriQAwYXN9?=
 =?us-ascii?Q?8zRVvM45S+Z5ul3o5twL/vYUTLliWvnPWlF9ufCb9NcDLrZ/jSLRM96S0ioM?=
 =?us-ascii?Q?K4jSfHokZzII9UbOEqCbo7geGjknCzAmfqHK5DfvGpikyn8f85lffdHVOw+3?=
 =?us-ascii?Q?njDjljxzPjMzK59Xt8luWPxOS/xVltOkWDuZG5S+pBIOXdlL8/rsBE8TPma3?=
 =?us-ascii?Q?fo3sfITJLLgoGRvV9U8V3O6xn8Zv78kS3cG5/yWD2JTsphsluvdEyZwnPThj?=
 =?us-ascii?Q?QUSWPnsuM2RlaFPwryXL1sQ3NBbWUe2YLpWf6qCiGC+zB2VCzwPsCDfMZtbP?=
 =?us-ascii?Q?BDaZiIIknTyxh9rQKUfYFAJOFuZ1/ikfaRwk6JlzKXbtHOwzXhaBXsWGZH8h?=
 =?us-ascii?Q?IwBwC0z2sZY3WziBfnP/Ch43TR0xLDDobTgTeS1Ta7qWp2y6che3qo/wBljk?=
 =?us-ascii?Q?ptTAjBPnYIzb+iygCYM540lcvZO4//OSlaGzL7o+VlDWggPFFI8ejK6nof9L?=
 =?us-ascii?Q?1irx48YY3X1zRzFEMdPCMZNSOetyji8de4n25PctALEwqy1/WtUBdtAyNP77?=
 =?us-ascii?Q?KjyUoDdlMgUQj74j59tlPCUa0msEzjxLWiJAPzBHsyg0vn3CkiZigrvcAouE?=
 =?us-ascii?Q?iGe999ExMqVoZXRSlmJ0FBgu8VYXvAwmEmUiKw+qRVqsryFYBrspedGQUji8?=
 =?us-ascii?Q?Iiyn/DH5uksoIv8y0ZAehvs45w1rgDb6UzjumcXxKW+BCdUnJwdCaVSHG8Hx?=
 =?us-ascii?Q?qEUYKFUGn10oLApLAkxslwhChGYmglfnwbXoA8V8/Cgy3OQfCvL0U5QISqjW?=
 =?us-ascii?Q?wwiNAQoy3jVIOP6i7mjiUGV66kmb4w+2CAur07/+DoabI9c4Jwqy6LmlXoj7?=
 =?us-ascii?Q?m+gRXe6yphE5Ku5qMrBM9Z766Kr/2k5TgHfu5TbxfF8WBgOpXSokfvJl/d0d?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5096103e-13fb-4616-a8f6-08dc590ec571
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 03:31:55.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GBMUxZ0L6iTmJEMhwPhqTd1AeqIQsN55hfdcecg9XELQWKVMzmsbOXIoMXCiX/lRFCrg6Ey61RrVsDNPOiOIlzvmfrDbl93X/+zJvzHQ6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1132

Add notifier function for PLL clock. In the function, the cpu_root clock
should be operated by saving its current parent and setting a new safe
parent (osc clock) before setting the PLL clock rate. After setting PLL
rate, it should be switched back to the original parent clock.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 31 ++++++++++++++++++-
 drivers/clk/starfive/clk-starfive-jh71x0.h    |  2 ++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 8f5e5abfa178..adf62e4d94e4 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -385,6 +385,32 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
 }
 EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
 
+/*
+ * This clock notifier is called when the rate of PLL0 clock is to be change,
+ * The cpu_root clock should save curent parent clock and swicth its parent
+ * clock to osc before PLL0 rate will be changed. And switch its parent clock
+ * back after PLL rate finished.
+ */
+static int jh7110_pll_clk_notifier_cb(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	struct jh71x0_clk_priv *priv = container_of(nb, struct jh71x0_clk_priv, pll_clk_nb);
+	struct clk *cpu_root = priv->reg[JH7110_SYSCLK_CPU_ROOT].hw.clk;
+	int ret = 0;
+
+	if (action == PRE_RATE_CHANGE) {
+		struct clk *osc = clk_get(priv->dev, "osc");
+
+		priv->original_clk = clk_get_parent(cpu_root);
+		ret = clk_set_parent(cpu_root, osc);
+		clk_put(osc);
+	} else if (action == POST_RATE_CHANGE) {
+		ret = clk_set_parent(cpu_root, priv->original_clk);
+	}
+
+	return notifier_from_errno(ret);
+}
+
 static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 {
 	struct jh71x0_clk_priv *priv;
@@ -413,7 +439,10 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 		if (IS_ERR(priv->pll[0]))
 			return PTR_ERR(priv->pll[0]);
 	} else {
-		clk_put(pllclk);
+		priv->pll_clk_nb.notifier_call = jh7110_pll_clk_notifier_cb;
+		ret = clk_notifier_register(pllclk, &priv->pll_clk_nb);
+		if (ret)
+			return ret;
 		priv->pll[0] = NULL;
 	}
 
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
index 23e052fc1549..e3f441393e48 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
@@ -114,6 +114,8 @@ struct jh71x0_clk_priv {
 	spinlock_t rmw_lock;
 	struct device *dev;
 	void __iomem *base;
+	struct clk *original_clk;
+	struct notifier_block pll_clk_nb;
 	struct clk_hw *pll[3];
 	struct jh71x0_clk reg[];
 };
-- 
2.25.1


