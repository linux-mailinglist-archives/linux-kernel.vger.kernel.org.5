Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515CB753E49
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbjGNPBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbjGNPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:01:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6828D1BD4;
        Fri, 14 Jul 2023 08:01:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so6752197a12.1;
        Fri, 14 Jul 2023 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689346878; x=1691938878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OBiuXyNTy9aeHUsfvyqBHVosTB7b4gg8TsCFhpUvqn4=;
        b=XfAD/DafZbSVSiMjR9lYFamyWdiGMGRrT8yuGyCxh7lAj0OF48e8VBQERSx7/Kz3Jy
         FZmWDto+LoelVYG/6sMMkJ0UOX8lIOn9WxnX41onAVpo/97SacKCvUCB4zgS53zLLc5j
         H5WV9ltzloa725w/qrVuRJY3HsCZtgCXPnxOm966vKFPM3STSg99jTndNuhP9UZQ36Tq
         L6EgkReMesSodfuWKbvXnZn5xkONXP4pZpHJNHPIMfmOmSE6jzVQCG9r+mnl7W6tp2no
         BmGKKed2QWBVN9kvOzYYCOVxZrr4Z5Hxo/CIcya9Vz4h57uWTnvO/KDUWw/tTBK/0Krs
         xEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689346878; x=1691938878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBiuXyNTy9aeHUsfvyqBHVosTB7b4gg8TsCFhpUvqn4=;
        b=gWApjvDbEHugxD3h8SDknbcV3FNI1kg5JP1vb1+paUzWebMmb7LqrKgD4Dc/79JFIv
         1vbadwXHMgkrb/ulye1Zvov9ADvExL8uw4cmpzZFN4yk31SSNWRggZclXlzwm2bMKcKT
         reW8FoNDqQ5bGtvKnfD9hh+eDMbiFLdEmcsWVcasctEjEaVjKwN/d5nxoINILWEVmZjW
         6FNYf0VUuofxn2taMX8EcWUtQZYqmRW2eQCqwidggShoktg1Q3syhHgq5+uhuaEg34+v
         saepN4YjFgplHo0gmfNrQSX86kY+vKBKqbsXJ/qGzf4KCswiH/B3EpJhjPUf6qQLtwxD
         zN0Q==
X-Gm-Message-State: ABy/qLZJ4Zp7sw4VHBrPwZhquQy6Y7q4+aZgOd256hZC++aQvfClIgNL
        C8q0NRWtDjOkcDxZXamHM1w=
X-Google-Smtp-Source: APBJJlGZSJEhe35uZt2LG+EAKzrk1g4oIdIDQc/dv4+9CYi4WJ8TsT9Xpt0xtHjhWZZ6jlvq+Fww6w==
X-Received: by 2002:a17:906:20dd:b0:993:d920:87d2 with SMTP id c29-20020a17090620dd00b00993d92087d2mr3581918ejc.30.1689346877330;
        Fri, 14 Jul 2023 08:01:17 -0700 (PDT)
Received: from localhost (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090671c700b0098cf565d98asm5495728ejk.22.2023.07.14.08.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:01:16 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memory: tegra: Prefer octal over symbolic permissions
Date:   Fri, 14 Jul 2023 17:01:16 +0200
Message-ID: <20230714150116.2823766-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

checkpatch recommends using octal permissions instead of symbolic
permissions. Switch the debugfs files to use the former to silence
these warnings.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/tegra186-emc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 83981ae3ea86..4007f4e16d74 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -212,12 +212,12 @@ static int tegra186_emc_get_emc_dvfs_latency(struct tegra186_emc *emc)
 	}
 
 	emc->debugfs.root = debugfs_create_dir("emc", NULL);
-	debugfs_create_file("available_rates", S_IRUGO, emc->debugfs.root,
-			    emc, &tegra186_emc_debug_available_rates_fops);
-	debugfs_create_file("min_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
-			    emc, &tegra186_emc_debug_min_rate_fops);
-	debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
-			    emc, &tegra186_emc_debug_max_rate_fops);
+	debugfs_create_file("available_rates", 0444, emc->debugfs.root, emc,
+			    &tegra186_emc_debug_available_rates_fops);
+	debugfs_create_file("min_rate", 0644, emc->debugfs.root, emc,
+			    &tegra186_emc_debug_min_rate_fops);
+	debugfs_create_file("max_rate", 0644, emc->debugfs.root, emc,
+			    &tegra186_emc_debug_max_rate_fops);
 
 	return 0;
 }
-- 
2.41.0

