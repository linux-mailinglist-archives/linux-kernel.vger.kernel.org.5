Return-Path: <linux-kernel+bounces-8180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022D581B339
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4A21F21B32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5284F202;
	Thu, 21 Dec 2023 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD3OZTXs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A051037;
	Thu, 21 Dec 2023 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55114c073b8so738118a12.1;
        Thu, 21 Dec 2023 02:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703153442; x=1703758242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QMQp28PVkuOsPBKyVgYS5Ymf4YAkrOuT5kryWvtFrk=;
        b=dD3OZTXsWaE2Qxbt7RAzojjdSjm6kyFbtmc1CtDzPYGiN7SrwjAM9hpJFy4DFUFwQ1
         FR/kbtzCW4LdYyCrbOE+6wrGf84SIclaipe4pqnZg2WG2Apqq95mhQUr3PJsp/Unba9q
         2xiTj5dxoU1O5fUb0lFj0WYUrjPS0q+P5pM1QKh3lEZYMNG1Eg9fvZLU2FBX9yJqP5iL
         C1XeVwXkIweqbBqJ3Bct8Ddb6wv725wy4n3dlFplDJQe/+TGQuKWg6PANzKwjzLYgzJU
         7N8aROe0jOUjFlLaFK9ohpvQW9dt3ADAKKUTPQvqEEgXOZ9dpe6QQzd7sUGHHFc3qC+3
         jjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703153442; x=1703758242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QMQp28PVkuOsPBKyVgYS5Ymf4YAkrOuT5kryWvtFrk=;
        b=kbtfO3W6q+W0fvVelFkZpGK4tVe6ZB5G6Lj98bf15vplRib0ZjN3YXfbsL1RVeHtiJ
         054+fce71I08EoBWsMpfu1nuHqZEFssdA+Y0xDAAr1JQWSWzBegEwQAl2F49Fyqvv+Ed
         5wYBOacJ5DwXdY4QXFmoDmmnCi8KsQXhUXY3P25wxy4pcfyAh3QD5JxguHgBwKtqRK7c
         zkM3bSdIpLi7v6IW/6zhbsn35vHfA5XcRghVoqX2TMElnDCRACO6l7outXlyfPlu7T6B
         CVoxf9MGa15u9I+osz8WnbDw5ZoEMz/eM9LRmnyHomDbxRjMbUdou40TEV7T4nzbdorR
         5zFQ==
X-Gm-Message-State: AOJu0Ywea8OXv50fboFwqEO6yq+4gJBjpQQggdAOKjsqVVm7AcOd6hit
	CofIbNEMzv1GHqvRXCCVEwA=
X-Google-Smtp-Source: AGHT+IGXjrE90/2KzHJgTFiU2ndSeAIZdngOEf0GUcN28R/bVeQcO0PAgHNRNaNMWci22btJbMGnsQ==
X-Received: by 2002:a17:906:5306:b0:a26:9fa0:5b4b with SMTP id h6-20020a170906530600b00a269fa05b4bmr363273ejo.226.1703153442340;
        Thu, 21 Dec 2023 02:10:42 -0800 (PST)
Received: from localhost.localdomain ([154.72.163.204])
        by smtp.gmail.com with ESMTPSA id x7-20020a170906b08700b00a25f5dba09dsm784928ejy.145.2023.12.21.02.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:10:41 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [RFC PATCH v2 1/3] cpufreq: sun50i: Refactor speed bin decoding
Date: Thu, 21 Dec 2023 11:10:11 +0100
Message-Id: <20231221101013.67204-2-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231221101013.67204-1-fusibrandon13@gmail.com>
References: <20231221101013.67204-1-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make converting the speed bin value into a speed grade generic
and determined by a platform specific callback.

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 55 ++++++++++++++++++--------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 32a9c88f8..fc509fc49 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -25,6 +25,38 @@
 
 static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
 
+struct sunxi_cpufreq_data {
+	u32 (*efuse_xlate)(u32 *speedbin, size_t len);
+};
+
+static u32 sun50i_efuse_xlate(u32 *speedbin, size_t len)
+{
+	u32 efuse_value = 0;
+
+	efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
+
+	/*
+	* We treat unexpected efuse values as if the SoC was from
+	* the slowest bin. Expected efuse values are 1-3, slowest
+	* to fastest.
+	*/
+	if (efuse_value >= 1 && efuse_value <= 3)
+		return efuse_value - 1;
+	else
+		return 0;
+}
+
+struct sunxi_cpufreq_data sun50i_cpufreq_data = {
+	.efuse_xlate = sun50i_efuse_xlate,
+};
+
+static const struct of_device_id cpu_opp_match_list[] = {
+	{ .compatible = "allwinner,sun50i-h6-operating-points",
+	  .data = &sun50i_cpufreq_data,
+	},
+	{}
+};
+
 /**
  * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
  * @versions: Set to the value parsed from efuse
@@ -36,9 +68,10 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
-	u32 *speedbin, efuse_value;
+	const struct of_device_id *match;
+	const struct sunxi_cpufreq_data *opp_data;
+	u32 *speedbin;
 	size_t len;
-	int ret;
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev)
@@ -48,12 +81,12 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 	if (!np)
 		return -ENOENT;
 
-	ret = of_device_is_compatible(np,
-				      "allwinner,sun50i-h6-operating-points");
-	if (!ret) {
+	match = of_match_node(cpu_opp_match_list, np);
+	if (!match) {
 		of_node_put(np);
 		return -ENOENT;
 	}
+	opp_data = match->data;
 
 	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
 	of_node_put(np);
@@ -66,17 +99,7 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 	if (IS_ERR(speedbin))
 		return PTR_ERR(speedbin);
 
-	efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
-
-	/*
-	 * We treat unexpected efuse values as if the SoC was from
-	 * the slowest bin. Expected efuse values are 1-3, slowest
-	 * to fastest.
-	 */
-	if (efuse_value >= 1 && efuse_value <= 3)
-		*versions = efuse_value - 1;
-	else
-		*versions = 0;
+	*versions = opp_data->efuse_xlate(speedbin, len);
 
 	kfree(speedbin);
 	return 0;
-- 
2.30.2


