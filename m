Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609257B5944
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbjJBRAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbjJBRAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:00:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707ADE1;
        Mon,  2 Oct 2023 10:00:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31f71b25a99so10506f8f.2;
        Mon, 02 Oct 2023 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696266028; x=1696870828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64nOEqf6/mjPbfcle6tVHCIMmPQhDPH56TTUSyH+RFM=;
        b=aIy3mFuvz7Llw1SYC1etGsUvvRuSbgA+XCSNe/qA2KbH5XEL9RKE681JAilNrpjglj
         NqBw8RIf8Gf94stoft6I95EPZTDYvikUxyWFOGd08bLo7qjvZJKm3231bTPxyeaD9GUs
         skwxsrsyZFHMIhu3NjRIgpAZLZM4+TlxSoIFijLzOpUT/lOcauVE9i3Xm5e41tM//TC9
         PVY1NZOjK9BEpdE64s3GWDHchGbN4IYi6Mr4vdViPUxdFhjVdNEXn6Gjvficre3Wjuzs
         GItko1Mgla/0aZvR8P1K6n9KIbWxbjZ6kwmRK60ZjX2B0r8/a4oJeTx60DELQ/zm8VaT
         snGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266028; x=1696870828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64nOEqf6/mjPbfcle6tVHCIMmPQhDPH56TTUSyH+RFM=;
        b=EB+Id5sVIhrMr69hEqU9+i0qcOu2It2Em2zBjgN7H7B7TGDxhunoJWiQnIzYNoTyd5
         5p7Qum/3ajqMTv4PJA1aklmUnF2AZhrzf+4vKFFx09A9YCbVDDFucb6X8bm93HghKCFV
         xiMaA7HYMH4yU47jJsaeiqNGe9Q8qLsRDI53I93HLrBX2KJIJCgqlR6seiGK5LASf2Ed
         sNKAcnTXK7vo8pJvf3ZwlZN65/0xfPtzE2s5hI9h3SrGfBfmm2NQDjB5iuN8otg6L9ZT
         bQDisYuenswv9QdG2FXwltOOH0Tt5sfzw2ln6QNm8PNfDxi59MAYkAkrGsYaZbJsxDJc
         v1dw==
X-Gm-Message-State: AOJu0YyP5ezAIU5NGBqnuVEf0wlSYvKzlZrW1RW3+6avt1RVM3NH5Hn4
        Yusw7051YKmyL6MwQJRTKsQ=
X-Google-Smtp-Source: AGHT+IHpcMlgO+FESOdL7EI4eJDVfSdlQRwVtLaTvR3QI4UuoRJ/vT5SXk3mgLz5PVu1tjXbHe3UIQ==
X-Received: by 2002:adf:e912:0:b0:31a:d8c0:cb8b with SMTP id f18-20020adfe912000000b0031ad8c0cb8bmr10447917wrm.25.1696266027424;
        Mon, 02 Oct 2023 10:00:27 -0700 (PDT)
Received: from archlinux.local (BC249365.dsl.pool.telekom.hu. [188.36.147.101])
        by smtp.gmail.com with ESMTPSA id s16-20020a05640217d000b0053420e55616sm11338426edy.75.2023.10.02.10.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:00:26 -0700 (PDT)
From:   =?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Subject: [PATCH] clk: qcom: gcc-msm8953: fix stuck gcc_usb30_master_clk
Date:   Mon,  2 Oct 2023 19:00:21 +0200
Message-ID: <20231002170021.192740-1-trabarni@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to downstream dwc3-msm source this clock has FSM dependency on
gcc_pcnoc_usb30_clk so enabling it would fail if latter isn't enabled.
This patch add works around this issue by changing parent of
gcc_usb30_master_clk to gcc_pcnoc_usb30_clk. This is acceptable because
both clocks have same parent and are branches/gates.

Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
---
 drivers/clk/qcom/gcc-msm8953.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-msm8953.c b/drivers/clk/qcom/gcc-msm8953.c
index 3e5a8cb14d4d..20639340e8a6 100644
--- a/drivers/clk/qcom/gcc-msm8953.c
+++ b/drivers/clk/qcom/gcc-msm8953.c
@@ -3645,7 +3645,7 @@ static struct clk_branch gcc_usb30_master_clk = {
 		.hw.init = &(struct clk_init_data) {
 			.name = "gcc_usb30_master_clk",
 			.parent_hws = (const struct clk_hw*[]){
-				&usb30_master_clk_src.clkr.hw,
+				&gcc_pcnoc_usb3_axi_clk.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
-- 
2.42.0

