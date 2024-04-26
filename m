Return-Path: <linux-kernel+bounces-159978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B798B3715
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F129F1F22256
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E497D145B24;
	Fri, 26 Apr 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zb1EK3Cf"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC55145B11
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714134016; cv=none; b=ktuRe3FmrnkQjL6qI5JrFJ5ZAjXtgUWaGNM+HAgMJcVffaHO94xqpZa5Uygw2Nc3rdVJmZT7KCVqeOQesJye6OabVnGSqxEZmWRMlMfxhvq3CNq+jKUr1iW1emMreEzKFFyXz6iuPdMF2el4xMN4QelE8a68sshwbBccxP0fqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714134016; c=relaxed/simple;
	bh=R7zQTIZdvG02VCBq8bLB7RM5nOeAXTmdLzXWGj0scFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O08s7bi8yaXb1Ztotul34QLNxlod1Gw9Z4zJOf83+PP4Tw6ekSkh7BJxXm1elFxQmtbYJXbACq68T100TF731A3Z4FHwsA5ch9LPsXWCxnSZlGF8gtyoABCEbV6AztSaf18OOw9obi7lanktoNhDkAqUuRBmjNA6CP/7h9K6VS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zb1EK3Cf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3476dcd9c46so1545879f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714134013; x=1714738813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCHTamsKWOa2PSWA2iiAOyEQMuVi7F/H9xo5LBfeSLo=;
        b=zb1EK3CfhCl+fQjqFaKbRO04jEjst0jWqUjatOZQSNA+xVRQS2X7k8w0LgyS7Ghg+k
         SoKbynY/2HnZGD5gGYqs7ytONzCntuZ09ojJt+1SbxCCy7Bfbx6QP73n0vZruMddsIoM
         opAIeDfNTxKwtgbWi3bHIvpXHNAVjt6aU6om7wbi/IEZAcrkYjiGfCLbs1xjGlQ086UC
         IMS/yp2L/fMgpvPFWq2zBs+dSH/Cv5ZGTegd2X53VMQNY5P3IUTy7sIM4p45ZiifMUOM
         kXj6p81uhhjLKgTE2Bub+pobiivJrxHl86k+7CjckHPS5JLHTZuQZO2w5Mg46H9RW0gx
         4vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714134013; x=1714738813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCHTamsKWOa2PSWA2iiAOyEQMuVi7F/H9xo5LBfeSLo=;
        b=rnBy1JIRtXVTb4tJiMzc5Qm+KJY9jKeg/rZLgftFftpRWFsTYtHs7nCMkt++qUZpaI
         wKfe0p/RqKVt9EAkoJWuRuxCXtVtZ7Tt1l8pxu053CH/Mp/rROpqLYHwh5IVw4KdJpDF
         FBupjrCTdBmSkZJ/LX2yTVLkhN8EpfInirn0nMJRWgMVkfqucT4t78Kbu2mzM+ecU9Qw
         63ya43sMADXbN8T9RaBCegJsQrTnWHH8iJX7SE5n5l6uDHj4+hLq8kU4uJg8PO15dW8e
         HFWGuvOp3PDFANB7kim8E2ShSIycB40nDTcWjWUf5Gwk39qkxnPAdvv8Q9Hf1zlkOLM3
         4efQ==
X-Forwarded-Encrypted: i=1; AJvYcCUscUfZ0Q9okOOLNLPyT9huvY7DQgFriN7JfCpDcoWGAjHVOaFu+p9MyAXpy2xpybK59RNu/yOtLKc4VuXMz1ASElCVpMjuLfYiOGGv
X-Gm-Message-State: AOJu0YyZC609glwLsWukP8AuvcW+aM/q9DnvTcch1RPxlI0V36b60j1l
	xDDUMOKOPHOfYIBj1lievFb4Ga0UVjFc0oZiMlTpeSZfmPuN3zuu3KAOm57GkH4=
X-Google-Smtp-Source: AGHT+IGykyOc3M8ynwChyDnZq7IZSW2Q3KnP2WV/KJ4TVvvg2h6K+hdAd40QyDlKrbfmVhpzBmI2zg==
X-Received: by 2002:adf:f60d:0:b0:34a:983:6b34 with SMTP id t13-20020adff60d000000b0034a09836b34mr1788556wrp.39.1714134012773;
        Fri, 26 Apr 2024 05:20:12 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:63cc:9bae:f542:50e4])
        by smtp.gmail.com with ESMTPSA id q2-20020adff942000000b00346bda84bf9sm22478146wrr.78.2024.04.26.05.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 05:20:12 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/6] scsi: ufs: host: ufs-exynos: add EXYNOS_UFS_OPT_TIMER_TICK_SELECT option
Date: Fri, 26 Apr 2024 13:20:01 +0100
Message-ID: <20240426122004.2249178-4-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426122004.2249178-1-peter.griffin@linaro.org>
References: <20240426122004.2249178-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option is intended to be set for SoCs that have HCI_V2P1_CTRL
register and can select their tick source via IA_TICK_SEL bit.

Source clock selection for timer tick
0x0 = Bus clock (aclk)
0x1 = Function clock (mclk)

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Will McVicker <willmcvicker@google.com>
---
 drivers/ufs/host/ufs-exynos.c | 9 +++++++++
 drivers/ufs/host/ufs-exynos.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 66e52c3607e2..66093a905986 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -50,6 +50,8 @@
 #define HCI_ERR_EN_N_LAYER	0x80
 #define HCI_ERR_EN_T_LAYER	0x84
 #define HCI_ERR_EN_DME_LAYER	0x88
+#define HCI_V2P1_CTRL		0x8C
+#define IA_TICK_SEL		BIT(16)
 #define HCI_CLKSTOP_CTRL	0xB0
 #define REFCLKOUT_STOP		BIT(4)
 #define MPHY_APBCLK_STOP	BIT(3)
@@ -1005,6 +1007,13 @@ static void exynos_ufs_fit_aggr_timeout(struct exynos_ufs *ufs)
 {
 	u32 val;
 
+	/* Select function clock (mclk) for timer tick */
+	if (ufs->opts & EXYNOS_UFS_OPT_TIMER_TICK_SELECT) {
+		val = hci_readl(ufs, HCI_V2P1_CTRL);
+		val |= IA_TICK_SEL;
+		hci_writel(ufs, val, HCI_V2P1_CTRL);
+	}
+
 	val = exynos_ufs_calc_time_cntr(ufs, IATOVAL_NSEC / CNTR_DIV_VAL);
 	hci_writel(ufs, val & CNT_VAL_1US_MASK, HCI_1US_TO_CNT_VAL);
 }
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index 0fc21b6bbfcd..acf07cc54684 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -222,6 +222,7 @@ struct exynos_ufs {
 #define EXYNOS_UFS_OPT_USE_SW_HIBERN8_TIMER	BIT(4)
 #define EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR	BIT(5)
 #define EXYNOS_UFS_OPT_UFSPR_SECURE		BIT(6)
+#define EXYNOS_UFS_OPT_TIMER_TICK_SELECT	BIT(7)
 };
 
 #define for_each_ufs_rx_lane(ufs, i) \
-- 
2.44.0.769.g3c40516874-goog


