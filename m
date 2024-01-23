Return-Path: <linux-kernel+bounces-34774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F76183875B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDCE1F24A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B580D53E19;
	Tue, 23 Jan 2024 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AS6OXfIp"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D12952F9B;
	Tue, 23 Jan 2024 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991330; cv=none; b=Xyo2qfWgRGUFvSYOWJ6+vasM+2GcwHlAmpVuUzLN9bfp9AxOY+Bh0TWHW6Zc/cZQJFpoos+znt9g6mAddpDlMRD5kNQO6ZL/fo2DJ9mqw/SAh+n2Z8nS4m/zl3FfSMa/Bj14kRsFsBwdHvmyU0naLTNKVEenztkI529F+muo4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991330; c=relaxed/simple;
	bh=RgHHqzr5NWmnLXlxghKEAW+Q4qs0X8k7X5GQ9VVgLNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+ptCCJGA8JAmVuw0wS2ejJp9Q87ruvoRvF2Ku8nOsnrah00cA4he9tTQBusZa+wmLBU97on/hgdfgwsGkWaLYtvVgu1QNCFgeUhsD//mEtY1KLJG576Nc2jfpTw7VtgZdSte7gVXzeCABbzBKIPrOvQNeyYjmXVCwtQ5UhMohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AS6OXfIp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6dd7c194bb2so103101b3a.0;
        Mon, 22 Jan 2024 22:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705991329; x=1706596129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkFOHsfA9MHR0dXeHfOoEodd0tqUtDilTWSVFg8lq2A=;
        b=AS6OXfIplKfkXLXSUmMpektiyW9mqqVs7uY/tnU1f6aMR5diozM/K24oYckRXyRmVX
         8v/+0dbw+oFsRbdWqMYHh/D1yWtJaOQJIb4FnLfBrfH2UAUulDK61vZtGwffTPAn4dBY
         SxjO1f7L6r3f3XpBTt88hHdYXiDDXG10awZXVf4cHMVMd0xInlCJ8A7o2URk8K+8ik1k
         C2aBE2Bw5oRApNHv0fiQnIu9obkWEGfhK7fOqg3LRdR+EaFEXuoydBpGhn3A80rS7WOK
         vCe/nsOLhkE/2elngRrnHnDDCkYumBxnDJiRc2fMxsF6PNFgRQ3KVpGE6dSgsMKFjIYq
         +dGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991329; x=1706596129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkFOHsfA9MHR0dXeHfOoEodd0tqUtDilTWSVFg8lq2A=;
        b=pCdyZqN+gy1B5Uf416bPY+L/M11OjAYSu3Dyt74MnEEHvcjY+0j+gQOTByLkRgkRT6
         lhhsUHyx9I7lttZ+hAcSpjGfqzWW7uqpyGVH4xcDik1VKlDRLN/2jbg9opx/e/mwq3+/
         FtUd8vdD3tTMssxOnX0u82EPfl3dSMF0TMJJ39JKbBlMIUWHNL9ldG2l4IqbW9jJoHD5
         RyXpw3OUL3GzpEus7qf0QkDOBXqhfD1WTiMApIdvOXltilPI748P6+g54lWgFq2LsT11
         Sq8XT8dh+DaAO0HYMQvqZJ1yKZR64L5yIMZCvjeBx4L0hbwHvhEHvVTExCdJwBy9msDj
         T9dA==
X-Gm-Message-State: AOJu0YxeqUqu73dOd8WfC94pTPuSEd4Y4ihdxDV7XrXM0e97XdHU8Vj6
	SK36CBiHtm0GUfy0342SHtb/z2bd72R3dcUnZR6YzXIgm+bsQ+hb
X-Google-Smtp-Source: AGHT+IF/hQrvk+VOtVCpGA/hdEpB3exf8GlzYCxELjRspTYKiGKLRS8nxbDEtrAvHN7fVvR2tRDbiA==
X-Received: by 2002:a05:6a00:1484:b0:6da:c8b6:6dc8 with SMTP id v4-20020a056a00148400b006dac8b66dc8mr6756280pfu.13.1705991328718;
        Mon, 22 Jan 2024 22:28:48 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2ac-a4c6-7d2b-d8b3-ed27-1f50.emome-ip6.hinet.net. [2001:b400:e2ac:a4c6:7d2b:d8b3:ed27:1f50])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006d9b2694b0csm10595188pfu.200.2024.01.22.22.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:28:48 -0800 (PST)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V14 04/21] mmc: core: Extend support for mmc regulators with a vqmmc2
Date: Tue, 23 Jan 2024 14:28:10 +0800
Message-Id: <20240123062827.8525-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123062827.8525-1-victorshihgli@gmail.com>
References: <20240123062827.8525-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ulf Hansson <ulf.hansson@linaro.org>

To allow an additional external regulator to be controlled by an mmc host
driver, let's add support for a vqmmc2 regulator to the mmc core.

For an SD UHS-II interface the vqmmc2 regulator may correspond to the so
called vdd2 supply, as described by the SD spec. Initially, only 1.8V is
needed, hence limit the new helper function, mmc_regulator_set_vqmmc2() to
this too.

Note that, to allow for flexibility mmc host drivers need to manage the
enable/disable of the vqmmc2 regulator themselves, while the regulator is
looked up through the common mmc_regulator_get_supply().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Updates in V10:
 - Modify the commit message.

Updates in V4:
 - Moved the voltage defines into this patch.

---

 drivers/mmc/core/regulator.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 005247a49e51..208c27cfa505 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -226,6 +226,33 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc);
 
+/**
+ * mmc_regulator_set_vqmmc2 - Set vqmmc2 as per the ios->vqmmc2_voltage
+ * @mmc: The mmc host to regulate
+ * @ios: The io bus settings
+ *
+ * Sets a new voltage level for the vqmmc2 regulator, which may correspond to
+ * the vdd2 regulator for an SD UHS-II interface. This function is expected to
+ * be called by mmc host drivers.
+ *
+ * Returns a negative error code on failure, zero if the voltage level was
+ * changed successfully or a positive value if the level didn't need to change.
+ */
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	if (IS_ERR(mmc->supply.vqmmc2))
+		return -EINVAL;
+
+	switch (ios->vqmmc2_voltage) {
+	case MMC_VQMMC2_VOLTAGE_180:
+		return mmc_regulator_set_voltage_if_supported(
+			mmc->supply.vqmmc2, 1700000, 1800000, 1950000);
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc2);
+
 #else
 
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
@@ -252,6 +279,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
 	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
+	mmc->supply.vqmmc2 = devm_regulator_get_optional(dev, "vqmmc2");
 
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
@@ -271,6 +299,12 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 		dev_dbg(dev, "No vqmmc regulator found\n");
 	}
 
+	if (IS_ERR(mmc->supply.vqmmc2)) {
+		if (PTR_ERR(mmc->supply.vqmmc2) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_dbg(dev, "No vqmmc2 regulator found\n");
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7e017d6177d5..5b6cfccf7680 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -74,6 +74,9 @@ struct mmc_ios {
 #define MMC_SIGNAL_VOLTAGE_180	1
 #define MMC_SIGNAL_VOLTAGE_120	2
 
+	unsigned char	vqmmc2_voltage;
+#define MMC_VQMMC2_VOLTAGE_180	0
+
 	unsigned char	drv_type;		/* driver type (A, B, C, D) */
 
 #define MMC_SET_DRIVER_TYPE_B	0
@@ -331,6 +334,7 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
 
 struct mmc_ctx {
@@ -613,6 +617,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
 int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 				 struct regulator *supply,
@@ -626,6 +631,12 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 {
 	return -EINVAL;
 }
+
+static inline int mmc_regulator_set_vqmmc2(struct mmc_host *mmc,
+					   struct mmc_ios *ios)
+{
+	return -EINVAL;
+}
 #endif
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
-- 
2.25.1


