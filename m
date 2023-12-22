Return-Path: <linux-kernel+bounces-9643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6020F81C8DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E691F233D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2EA17743;
	Fri, 22 Dec 2023 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeTHMtxW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDE718038;
	Fri, 22 Dec 2023 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cca5e7b390so13081021fa.3;
        Fri, 22 Dec 2023 03:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703243684; x=1703848484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7DGrzlVlvs9gxszkU6Ibjz+3jgxk5y/rrrR3fSlR9s=;
        b=YeTHMtxWJp7jS93mOEFbRCry4RaBNETlvTc7SnDFOK/OAlxSWixk5TpAcivMRLvEBa
         YoSTe7FHSvxESXRHceeqgrY0Qmw6TdOW43Qv9HkX1SYTwBgkPk6gogUAI9yT59RR5ZIg
         ueSnNYQcK7u/cxUQPnofmhkcyA6KrtwyY+iBcD6Cok3xJJX4+LhyGWAA0oEQK06RwICZ
         2xUrHp2v6VGTUkMY02WqCrBh9PFl80N2BNQlC3sqn2yG7Q2Ip7EF3HYIILKe1WADjYdp
         xvW1a0MQG/Qu9EzLY4eUSQKxRyRCX3ENbTnHimYfxdq+qW4z0rqbWWRHuObziHtTxNKP
         xXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703243684; x=1703848484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7DGrzlVlvs9gxszkU6Ibjz+3jgxk5y/rrrR3fSlR9s=;
        b=FWgHSXScmNA1+vy7sA3pUch8aUokwOp2xV6RiX8U/ovUr3gWTs53TjFEXgWyKKEMt0
         XKQlSzwYm0mqXAYGVFp5ijJYzdhZnvmgglOlJOtr3RfE/bTUx3zo8mWb3g9B7v3eUw5g
         lkGxmBK0bf+4NRXKi3/XdFUn6NxKKz8rSEL4JuikVS/H8D2vh9qFbpLbzWkaTReJbbBn
         bWhOTX6Yra++yBk7XTDVxH4v+olyXxeuHNb+cOONaxqjLuZp/r61RLF/CtMjE9gRs/X4
         SfAwiaII4Qr8/cRpS2Q70dSBLoRyLc8AFx0NO9VLABQM5l6Xop/tYeolrGQqzHPOxdOU
         z8hA==
X-Gm-Message-State: AOJu0Yx6s+N3oNfSjTS3GX3qisqxCpJ8w7GH9Cffy+xns3LBITgM6AF1
	w7uvBk5K7aqwMh/YYhFp6uY=
X-Google-Smtp-Source: AGHT+IHg0MuEsdR3YNmYjR54tmAi0CP4dEHlQyIUYDid2LMDCv5m0mmnyatup9/AcekOKefeZufagg==
X-Received: by 2002:a2e:2ac2:0:b0:2cc:5dc2:3f09 with SMTP id q185-20020a2e2ac2000000b002cc5dc23f09mr542885ljq.44.1703243684017;
        Fri, 22 Dec 2023 03:14:44 -0800 (PST)
Received: from localhost.localdomain ([154.72.162.91])
        by smtp.gmail.com with ESMTPSA id es15-20020a056402380f00b0055267663784sm2420469edb.11.2023.12.22.03.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:14:43 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
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
Subject: [RFC PATCH v3 1/3] cpufreq: sun50i: Refactor speed bin decoding
Date: Fri, 22 Dec 2023 12:14:05 +0100
Message-Id: <20231222111407.104270-2-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231222111407.104270-1-fusibrandon13@gmail.com>
References: <20231222111407.104270-1-fusibrandon13@gmail.com>
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
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 58 ++++++++++++++++++--------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 32a9c88f8..e8c2a1dc3 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -25,6 +25,38 @@
 
 static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
 
+struct sunxi_cpufreq_data {
+	u32 (*efuse_xlate)(u32 speedbin);
+};
+
+static u32 sun50i_efuse_xlate(u32 speedbin)
+{
+	u32 efuse_value;
+
+	efuse_value = (speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
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
+static struct sunxi_cpufreq_data sun50i_cpufreq_data = {
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
@@ -36,9 +68,9 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
-	u32 *speedbin, efuse_value;
-	size_t len;
-	int ret;
+	const struct of_device_id *match;
+	const struct sunxi_cpufreq_data *opp_data;
+	u32 *speedbin;
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev)
@@ -48,12 +80,12 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
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
@@ -61,22 +93,12 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 		return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
 				     "Could not get nvmem cell\n");
 
-	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	speedbin = nvmem_cell_read(speedbin_nvmem, NULL);
 	nvmem_cell_put(speedbin_nvmem);
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
+	*versions = opp_data->efuse_xlate(*speedbin);
 
 	kfree(speedbin);
 	return 0;
-- 
2.30.2


