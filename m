Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F318033BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjLDNBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:01:51 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA928D7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:01:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40859dee28cso44202205e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694914; x=1702299714; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zv/eJcHawXXFoFHawlDfjkpiHN2LaBMOvdkHEZ54RT0=;
        b=YL9GK0K1xo1FnldTAU/rLk6HGtwTMKJ5rHac23ob3n8WXryEejiUFetMroYq7OKSCW
         5u3b/OQejK8DUerxG1WTiUqFyHXPjAQaXW5VwwyQqhlUjGg/dQq0AITuZLssCyk4gDTA
         FD+lxqtEegNbzo0i1IlqXhmhAdmYCY9GamGvAAyxNxd9XsuiVTbjpPmAG/gIlkc0Q0Ay
         MgXNKcugUYy47ntcixvDzA7/uQio9Gml+K4GcV2N+I6T+jvgcg/58klm4+NOgf1KFSIR
         nRPqfCXM//k+cctYo8sByHO4nIcdv4xCwmhRdeuvPiflHNdQPrwNS+p509N3aG2rs5X+
         hy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694914; x=1702299714;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zv/eJcHawXXFoFHawlDfjkpiHN2LaBMOvdkHEZ54RT0=;
        b=LqcCarsfgdhpn8ZlZxguBcRU8GyAlmyN093K2NNLim2mepkP4sfqjlyPhnNsThXyhb
         y3UwRh54efgKy9WukeRmON654p1XgwL0GICPTUEiCpHAv6lid1LZNwSz9cXhMPBkHLA1
         I/SiRthE64KM1r8363UDBEmmpKJxnkNZuZ314VP1h5yNn47xIhzoXfRo6b7nwbMCGpYs
         0t5Fub/oLjb30eAJyvxv15fXUBFTCIS1Mjj001cc9Pk/whs2aCJDdrlkACge/me6j3L1
         sYWY16c/KPDoHpK2jg7TKxFKoqa+fDmMOjttFDroS1lyE7GXMgcGuO/pyrF+A5dkCvva
         A9uQ==
X-Gm-Message-State: AOJu0YyqsqI8685H+Nbuaedq1N3QW3jzzTUoNjfboDr6UUIRBCOZdKoq
        dvaYuvgv6Z+LmYgnEb414W4tiw==
X-Google-Smtp-Source: AGHT+IHLK74clg3zu7Qh7K95BwgXcZW9Dd26WnIA9pNWnWKFMKj2MgNLr7yuo5H2cdX2hlrwcDO1QA==
X-Received: by 2002:a05:600c:3ba4:b0:40b:5e22:961 with SMTP id n36-20020a05600c3ba400b0040b5e220961mr3046777wms.80.1701694913864;
        Mon, 04 Dec 2023 05:01:53 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d6992000000b003333abf3edfsm6347879wru.47.2023.12.04.05.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:01:53 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 04 Dec 2023 14:01:47 +0100
Subject: [PATCH] arm64: defconfig: enable GPU clock controller for
 SM8[45]50
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231204-topic-sm8x50-upstream-gpucc-defconfig-v1-1-e615df0c4af9@linaro.org>
X-B4-Tracking: v=1; b=H4sIALrNbWUC/x3NQQqDMBBA0avIrDsQEyvSq5Qu7GQSZ2ESMiqCe
 PeGLt/m/wuUq7DCq7ug8iEqOTX0jw5omVNkFN8M1ljXWzPglosQ6jqdT4N70a3yvGIsOxF6DpR
 TkIiOnSc7Dl82E7RWqRzk/H/en/v+AbVYMyZ3AAAA
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9Lgr5FF8Qm0y+cs1KGIfxO8WY1rCY8E3tNFMlyO7N5I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlbc3AbZInq107ENvDdSegbav0n1QdyLBPQL6JQmnz
 zcYOnsmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZW3NwAAKCRB33NvayMhJ0Y+oD/
 91m5aNgwUUjgT3VnxYJO+y9rrRCb/jV+/Js5EK0cudv/X5SB8CB6MLzUX1LvMrpTU381POrBd8QZJl
 lEKQe5wiG+p/qz/5gx8UxOJ+s9ekXZ5bEQ/A6MoMSjaxIwRF9hSCn/QVD5smA77D53cDewmjG1cyY7
 pZcbSnfoGmVRG0QcSmrY4hJHpPOkWVkMXWx+f9SznP2KG803AnGirAJD4TKD1ITv/MRD3eePsi6lrm
 SjM2qDcEcfcKhQOu+7lo8m2RPUeO2JTBEQ2S6hw+OCt/RHsPPIg0HuW5RMmKUICYU6LgUooS4PrBxq
 mXTtASnfgZZIXGhNFOTUQZKL2nkG08VJjtN/W3z0w4GbP6eU5eT4ovX5+UilLmEQYtyIzwsNeSzff6
 z1aLGL/NuDIHDaCZ81pXs1xOGdgK5hGQHB4tynmd5pg3OiBkKWqVaIMIqkkF3EYRX8QEXbtb0BSUuM
 uMK7c5Nallhq+Qn7GJVZKYtVcEhIh9Ehj8DePGVubufcwCa4ruMfCdpLmSh1c42xwmnP1SDQNi3okD
 tK5LAxVLIEYHn3PXQb2NitDJvpjccnxMN/RxXOd+ekhpnvWLpgjHDygsgTI5DZcoEvOsXU9yIG06nn
 AS+qWbkUq74WeEzZDaf/PcoW62CQxIIdaoZNc8x2yoTQIS54i+3rFof6OrLA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable GPU Clock Controller for SM8450 and SM8550 to allow using
Adreno GPU on these SoCs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5ad2b841aafc..56aebbdcdd40 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1266,6 +1266,8 @@ CONFIG_SM_TCSRCC_8550=y
 CONFIG_SM_GPUCC_6115=m
 CONFIG_SM_GPUCC_8150=y
 CONFIG_SM_GPUCC_8250=y
+CONFIG_SM_GPUCC_8450=y
+CONFIG_SM_GPUCC_8550=y
 CONFIG_SM_VIDEOCC_8250=y
 CONFIG_QCOM_HFPLL=y
 CONFIG_CLK_GFM_LPASS_SM8250=m

---
base-commit: 9046d05c6ad632a271fc4173624e26f396975a80
change-id: 20231204-topic-sm8x50-upstream-gpucc-defconfig-3e3dc264be08

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

