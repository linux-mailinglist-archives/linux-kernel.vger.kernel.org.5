Return-Path: <linux-kernel+bounces-6656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBB1819BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7038D1C22395
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DFF200D5;
	Wed, 20 Dec 2023 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoeyxpNj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09523208A9;
	Wed, 20 Dec 2023 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so6781438a12.3;
        Wed, 20 Dec 2023 01:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703065927; x=1703670727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvAwavagWNrO/Q9Vdb9xCDrUrBaPNjWgjY6N/TwA0bg=;
        b=EoeyxpNjAYBcXs7/0a3cLTdaLkdj003S1RSwCZxfWA67SiVOSY9eYYS3N81MJz7+LT
         bssg1DE9y5EEIaCRoV+RQFeD085QOfiGRbmB5KiIeTlLyyhJn7Jh3VLiebfbnJ/gY28L
         RZU/GWEJdLEM3Mib+VUyXQQIz3toYwKcIXcxUTFIUtdQUA7wOtXeoP2ETH7SWikjiDgR
         K4VzUNU54Pspp+fBwDJTdOpynPI0UDqfpDFvi3LGPfGSqmVAgr2/XQ5Yi+Uwv4rjhTQM
         cMV9NsTf730Amnb6ErDOZZQgEsFOw2IS8M2o2wbzMUy2fdNGy+nU4P9B5LgDlJlsulv0
         wKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703065927; x=1703670727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvAwavagWNrO/Q9Vdb9xCDrUrBaPNjWgjY6N/TwA0bg=;
        b=FfqZokVUkJqroeDNNf2JIIPxpKKXtCO3FbgDH1ovScIJA7liFWDQRKDTVdQUI52YiK
         YeuSGSWXQjOzq9nKA/IK/OybO0NSlFHILvTz78qqutSpk3sC3ma2Wa730TDINMkG5OGz
         ci5fhG4lRsOB56JIeYroF5ruTRjg8v0Hn7hl/70KxhkX3a8sX4En1jwIMZvxsHegvuDi
         CNQraygkj7inhGYPeA+D3ltUYOMrrLqmqFqlwBOfr9O7L0tSpY07PE0ynLJHL4Eo0GNz
         Gc1jQ/P8VGcOn9IoQWwQTJ3GD+jvDK4eZTevZH0WI1B07yo4kpfnlh6OfTV60S6Xy44c
         VLMQ==
X-Gm-Message-State: AOJu0YyTnsbYW4Nqou7Fvw2g6QwoGHF82OgCLHRUsvbET0MioygeHjYf
	TlKmIXpBQ6M4HjIqY8GlqPQ=
X-Google-Smtp-Source: AGHT+IHJLTFVlMeVWUfl2R/aVxV5HUEVW0LFkZhbSzhOrR+n633yl76oiQKvS23mYKEl1VoOE8yaXA==
X-Received: by 2002:a17:906:1787:b0:a19:a1ba:8cd6 with SMTP id t7-20020a170906178700b00a19a1ba8cd6mr9779000eje.116.1703065927014;
        Wed, 20 Dec 2023 01:52:07 -0800 (PST)
Received: from localhost.localdomain ([154.72.162.158])
        by smtp.gmail.com with ESMTPSA id st3-20020a170907c08300b00a1c4fde4e88sm16596791ejc.18.2023.12.20.01.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 01:52:06 -0800 (PST)
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
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [RFC PATCH 1/2] cpufreq: sun50i: Add support for D1's speed bin decoding
Date: Wed, 20 Dec 2023 10:51:40 +0100
Message-Id: <20231220095141.27883-2-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231220095141.27883-1-fusibrandon13@gmail.com>
References: <20231220095141.27883-1-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for decoding the efuse value read from D1 efuse speed
bins, and factors out equivalent code for sun50i.

The algorithm is gotten from

https://github.com/Tina-Linux/linux-5.4/blob/master/drivers/cpufreq/sun50i-cpufreq-nvmem.c#L293-L338

and maps an efuse value to either 0 or 1, with 1 meaning stable at
a lower supply voltage for the same clock frequency.

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 85 +++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index ccf83780f..28afbe558 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -25,6 +25,66 @@
 
 static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
 
+struct sunxi_cpufreq_data {
+	u32 (*efuse_xlate)(u32 efuse_value);
+};
+
+static u32 sun20i_efuse_xlate(u32 efuse_value)
+{
+	u32 ret;
+
+	switch (efuse_value) {
+	case 0x5e00:
+		/* QFN package */
+		ret = 0;
+		break;
+	case 0x5c00:
+	case 0x7400:
+		/* QFN package */
+		ret = 1;
+		break;
+	case 0x5000:
+	default:
+		/* BGA package */
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static u32 sun50i_efuse_xlate(u32 efuse_value)
+{
+	efuse_value = (efuse_value >> NVMEM_SHIFT) & NVMEM_MASK;
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
+struct sunxi_cpufreq_data sun20i_cpufreq_data = {
+	.efuse_xlate = sun20i_efuse_xlate,
+};
+
+struct sunxi_cpufreq_data sun50i_cpufreq_data = {
+	.efuse_xlate = sun50i_efuse_xlate,
+};
+
+static const struct of_device_id cpu_opp_match_list[] = {
+	{ .compatible = "allwinner,sun50i-h6-operating-points",
+	  .data = &sun50i_cpufreq_data,
+	},
+	{ .compatible = "allwinner,sun20i-d1-operating-points",
+	  .data = &sun20i_cpufreq_data,
+	},
+	{}
+};
+
 /**
  * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
  * @versions: Set to the value parsed from efuse
@@ -36,9 +96,11 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
-	u32 *speedbin, efuse_value;
+	const struct of_device_id *opp_match;
+	const struct sunxi_cpufreq_data *opp_data;
+	u32 *speedbin, efuse_value = 0;
 	size_t len;
-	int ret;
+	int i;
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev)
@@ -48,9 +110,8 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 	if (!np)
 		return -ENOENT;
 
-	ret = of_device_is_compatible(np,
-				      "allwinner,sun50i-h6-operating-points");
-	if (!ret) {
+	opp_match = of_match_node(cpu_opp_match_list, np);
+	if (!opp_match) {
 		of_node_put(np);
 		return -ENOENT;
 	}
@@ -66,17 +127,11 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 	if (IS_ERR(speedbin))
 		return PTR_ERR(speedbin);
 
-	efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
+	for (i = 0; i < len; i++)
+		efuse_value |= ((u32)speedbin[i] << (i * 8));
 
-	/*
-	 * We treat unexpected efuse values as if the SoC was from
-	 * the slowest bin. Expected efuse values are 1-3, slowest
-	 * to fastest.
-	 */
-	if (efuse_value >= 1 && efuse_value <= 3)
-		*versions = efuse_value - 1;
-	else
-		*versions = 0;
+	opp_data = opp_match->data;
+	*versions = opp_data->efuse_xlate(efuse_value);
 
 	kfree(speedbin);
 	return 0;
-- 
2.30.2


