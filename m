Return-Path: <linux-kernel+bounces-131427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93958987BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75641C20935
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CE51350CF;
	Thu,  4 Apr 2024 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hhe3K7Yq"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E393134439
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233644; cv=none; b=id4VcpBYv9bQYxO0v9YTq+ve5Wol7P6FfhtW6xpIZh+455gIj0wtHrsK2mK6w1VezrlAJZrNdlBRVybjsc52ANq1nOBBea6QVfnx5twqZPbfZgqYwO+2/ukM2eoEVg9d2D0rOM7HYeq5JrPTm9fC1J8e/cpYu75uPnNN1p4C3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233644; c=relaxed/simple;
	bh=ZHKCf97OijWc2VffmsZBpB7qLb+gSrxVQc/YXEeVJNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYLIGKYw/l7hLnSMB+JHi0rC6sgoh0CEG5205+TJzxA9we6E1xJ4k+yaSgrz/oyi9BF6T1cYJ+FkkTk+K6fJ+JDt+WkIaAY8bd0cvbHmdog2OpzIuzm5WY5f6UpCM7TKnVw+v80B0m0wSOqFUIO4Bw1P0nD3MIPljB6pxidH7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hhe3K7Yq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4162b016168so3160545e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233641; x=1712838441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyUUQp6WOxRvluHXSIvI5EfrW3GeehtIyQz6Nkgdpu8=;
        b=Hhe3K7YqTmMEQoghiyRYr/zoAn+h5++tRlrhAsHCzfFkGdmj5HZCeAkqX5Yr5bIK3x
         5lE+aUw/9fRGz1WyaASMmqrYLqolatlpj3JV2N/J1XtVRRMR2QAL4p9hslMeT/JFkphV
         tpMX7f94nQ2zt6YnYPyEvEQDkbigRUgMu1hT7KgzdjeqyWKpUYmja3jV3DoJCAo5Gsgj
         tGz3yb6WASJRZ2QDuBu3S4jSBd9XZjVNOpSF46jvkrSBWVS87lK5qdGa2mOzdqvj44sg
         O2oE1XirsTmQ16+K+sSfQLwbmNC+l8KqZonbogP0FL3SF2e3brWjPKG0TI+iqh43ugjB
         QjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233641; x=1712838441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyUUQp6WOxRvluHXSIvI5EfrW3GeehtIyQz6Nkgdpu8=;
        b=b2bGA5ZI2TwuajWYtCx3O/WLlY4+4albVyiRtuH7piY9fVJPdmGPCUsGbMvkw2NYeX
         hGioVA2Yc6Wy3mPkXYxR7NdkTky1hozxRZ9xLapxrAlyp1w7ybwKRvGwYkPvS/5tfXC/
         kjQ0eIRAukVZ3zKB6awrI+W0j/O8YJQaSkYDy88BUcIxAPqqtGnJVjxRKpJ29OLiLvxT
         ukQZYWvH0Zg9Fz6mhGr0rXo6/KysMMPPXYS4s1TfNuoxrCBO4Laj3j0t+XDPu/BdbhKL
         wbj97s7t+i4yFqOpoImTeb+4qokjgZj+dXJstgWcMvb2S7aRPpWXQEjzzy1emtu4iG35
         0t3A==
X-Forwarded-Encrypted: i=1; AJvYcCUl6YIUG9olA1aChSLd77FBmlKbKleF1l3SFDhEmhQpsnqVdRxLhlA0Psok1RRnSTmcHa57ynAH4bmtsY1YpEjUQdIzhscRykKXLgCA
X-Gm-Message-State: AOJu0Yytv5q4ppiJWRYDS5+A7cr5RC3w1U26q/7LYeKiJAIZi0QRqnca
	QW0yLFrEFI4F4e6N4AkZgWPeKUIbDmr0tZ/hxe+ZZlE9K20yc2XKUtO30XUNnl4=
X-Google-Smtp-Source: AGHT+IEMnaWns3sPAMJ91nDBk0kRT98vdLD6EXIhsFu+f4lEueXgTLnJxBfN0OJHTHTi8CWqnrfg8Q==
X-Received: by 2002:a05:600c:1f84:b0:415:6cd7:9967 with SMTP id je4-20020a05600c1f8400b004156cd79967mr4750373wmb.10.1712233641601;
        Thu, 04 Apr 2024 05:27:21 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([148.252.128.204])
        by smtp.gmail.com with ESMTPSA id bu14-20020a056000078e00b003434b41c83fsm12106303wrb.81.2024.04.04.05.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:27:20 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	chanho61.park@samsung.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 12/17] scsi: ufs: host: ufs-exynos: Add EXYNOS_UFS_OPT_UFSPR_SECURE option
Date: Thu,  4 Apr 2024 13:25:54 +0100
Message-ID: <20240404122559.898930-13-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240404122559.898930-1-peter.griffin@linaro.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option is intended to be set on platforms whose ufspr
registers are only accessible via smc call (such as gs101).

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 4 +++-
 drivers/ufs/host/ufs-exynos.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 734d40f99e31..7b68229f6264 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1186,7 +1186,9 @@ static int exynos_ufs_init(struct ufs_hba *hba)
 	if (ret)
 		goto out;
 	exynos_ufs_specify_phy_time_attr(ufs);
-	exynos_ufs_config_smu(ufs);
+
+	if (!(ufs->opts & EXYNOS_UFS_OPT_UFSPR_SECURE))
+		exynos_ufs_config_smu(ufs);
 	return 0;
 
 out:
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index a4bd6646d7f1..0fc21b6bbfcd 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -221,6 +221,7 @@ struct exynos_ufs {
 #define EXYNOS_UFS_OPT_BROKEN_RX_SEL_IDX	BIT(3)
 #define EXYNOS_UFS_OPT_USE_SW_HIBERN8_TIMER	BIT(4)
 #define EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR	BIT(5)
+#define EXYNOS_UFS_OPT_UFSPR_SECURE		BIT(6)
 };
 
 #define for_each_ufs_rx_lane(ufs, i) \
-- 
2.44.0.478.gd926399ef9-goog


