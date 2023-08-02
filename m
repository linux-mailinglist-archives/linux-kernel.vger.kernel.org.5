Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060B576C975
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjHBJ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjHBJ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:26:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986BBE7;
        Wed,  2 Aug 2023 02:26:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3179ed1dfbbso3160621f8f.1;
        Wed, 02 Aug 2023 02:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690968409; x=1691573209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fwoyyCSuhDlyEJpT+9RmMbXec0qXFgA7vWKF7hLqGbo=;
        b=JzBvHdCsM3egtnmHaiRGiM4DHOnCHceRoF5WCIhTJLKJiuKiIH6XbbD0Qh29JMeWUj
         H/sh4Q/0D7ITEst34Ox0wqTY5xbJZQaAFTWJKqqJGGN7fMRWoJ87EvCyDes1bOTdDpus
         fyGyvuMvsSSpV+snkbcntAKC8lRdEUqDP9lf+sl7Mvw2yND7PIBHQyrYxI8ysvaQ6e6z
         OCOdt/GlhQfoGzYBhK3W+QqwaahwDX3Ssy2enYurHlEvAOB1HPFpzb/VPQKbEkKO2uVy
         QrMkAj5uTAzw1KxvSD9YbhX3JuAc5PmKbiozTXQXTgeDDCAYoGkfehgjRgGuTRvOcYVS
         qPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690968409; x=1691573209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwoyyCSuhDlyEJpT+9RmMbXec0qXFgA7vWKF7hLqGbo=;
        b=boMwpyMBuFWdzdzKljgG91rEa2QaHIyByFpes0mr5tCogtz2EAlzSTM9Bb9nX3CGws
         Alzr00tYU9qHiw/FiNKOEyY5K91Imt0G2ifw+YWG97yzyOjlOj3Z7jo4i7/wFPBSg+DG
         6PJuprndIc+WcGYa11wKka0UHSmI5hEGwKMyyim8Ue3idBfLS9SKbAnvoPObObquBRTM
         dj0dW52KUdCvMDkcOhw1jk6bEVTpTMZCRn1LHTfz8VvT50bfx5Cj3hyPbaLdsu/5CnZt
         4V5nIikMLPoypG6E06DIXL4IrspT76wZGf+Z6+B4o37eLsjurEW/H8nRohiHKVbntg07
         snbQ==
X-Gm-Message-State: ABy/qLaFO2zSspyOHI6Ar4WBCnGTeKo2IL6VO1lY33+wTW+r9PBJE4/v
        Weaz49o0xlE8qhV858LTNTyLd2ZzAgM=
X-Google-Smtp-Source: APBJJlEb5zTBNuqlYSoO2JKsMjIf2j+Z4ACLA9XHiQDBSAUg5JRNZoUxSlX8phk1tCds1y3YMx5ozA==
X-Received: by 2002:adf:f091:0:b0:317:6a83:767a with SMTP id n17-20020adff091000000b003176a83767amr4494392wro.51.1690968408538;
        Wed, 02 Aug 2023 02:26:48 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id o3-20020adfe803000000b003143b7449ffsm14732480wrm.25.2023.08.02.02.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:26:47 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, sboyd@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, kernel test robot <lkp@intel.com>
Subject: [PATCH] clk: ralink: mtmips: quiet unused variable warning
Date:   Wed,  2 Aug 2023 11:26:47 +0200
Message-Id: <20230802092647.3000666-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF is disabled then the matching table is not referenced and
the following warning appears:

drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmips_of_match' [-Wunused-const-variable]
821 |   static const struct of_device_id mtmips_of_match[] = {
    |                          ^

Silence it declaring 'mtmips_of_match' with '__maybe_unused'.

Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS SoCs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-lkp@intel.com/
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/clk/ralink/clk-mtmips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
index 1e7991439527..6716394b28a3 100644
--- a/drivers/clk/ralink/clk-mtmips.c
+++ b/drivers/clk/ralink/clk-mtmips.c
@@ -820,7 +820,7 @@ static const struct mtmips_clk_data mt76x8_clk_data = {
 	.num_clk_periph = ARRAY_SIZE(mt76x8_pherip_clks),
 };
 
-static const struct of_device_id mtmips_of_match[] = {
+static const __maybe_unused struct of_device_id mtmips_of_match[] = {
 	{
 		.compatible = "ralink,rt2880-sysc",
 		.data = &rt2880_clk_data,
-- 
2.25.1

