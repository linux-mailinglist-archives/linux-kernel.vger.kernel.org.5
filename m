Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE17E1B38
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjKFH3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjKFH3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:29:16 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB51FA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:29:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so6989401a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 23:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699255750; x=1699860550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gMY8XgfOVGFN02oDlW75nDwRvfuviQhI7p4H++WJRxY=;
        b=tn0usp89NEc1dtYPAl6FLcyVVEPGOLom/Cr1Gfo+dgr9UL7M112+wsWG+3KeB+Z8pg
         ++FeKLc792jteNpDdBpZDzTuV5jO8oYNnHqiY/vn5MSKNXJlHb25nAiWhUa3GfjLbpXR
         nDb4wALPlk6Ohte0WV5t4UENVkCccC75Xy5TJS3lga+1orjydcQQAPpm4fR9biZWnFMg
         f89NqRGUfoYsK8XkLGiQzMryu22Jx1/QlLYqGvUnHxMlXNmsEL9r4AsFpQFYLhs3CWli
         PN/deUa+tr9bP1rJjUSzmMwLQqa/fPgkzQGMztYmrYZY4W5+AtOEh4oZWHygJZ/zdoX6
         Mdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699255750; x=1699860550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMY8XgfOVGFN02oDlW75nDwRvfuviQhI7p4H++WJRxY=;
        b=nA/aj1S+pS97mOxETUKeB/pM3DN3Sn8eV0j+5RIaJAFFWbLp971qWpfszBTPgPNs9z
         HXRP9Rz2j6tIHP/zOiXxVBaVechr3qqeIEXRfcVOIQI9WobqWoW96NAmU3JzzbPWnZGk
         Oh1+zax8xIoMzcwiuIyo2My19HUmhU3+P3iX0k0dmV5lOsRgwjD1p1uyAJPJFdCeQuTU
         xAev9Y/DvpLq0YAC3avwbcEMNTaQIL4kcdQAy5xLF4a8DNHBWLAEQ16j51s4/T30xlPf
         W231x8nzjbeHiytvdztS11oyXlLnKE9lCIJ+A0FsXg9Ht8tz6zUHKj+nYBShhDdNJNtI
         g6fA==
X-Gm-Message-State: AOJu0YzQo5DigqGI2yChCsgX3j/u46IT39OlcFBIl+k6VYkuOCdig5pH
        khfyp91tolN1fWPq+kXlQK/b/G06jfdBp+Kwn5U=
X-Google-Smtp-Source: AGHT+IFc0t4kpfyyh0BzA0QtRV1xWbIBGoMZWFHigGpEKb9RAkVUEMAGFn/9TEX76Y+IEX7T+2mCoA==
X-Received: by 2002:a50:cdc2:0:b0:543:57a8:a470 with SMTP id h2-20020a50cdc2000000b0054357a8a470mr15565822edj.19.1699255750590;
        Sun, 05 Nov 2023 23:29:10 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u14-20020a50c04e000000b005412c0ba2f9sm4113640edd.13.2023.11.05.23.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 23:29:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: defconfig: enable newer Qualcomm sound drivers
Date:   Mon,  6 Nov 2023 08:29:08 +0100
Message-Id: <20231106072908.24387-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the sound machine driver for Qualcomm SC8280xp soundcard (used on
Lenovo Thinkpad X13s laptop), Qualcomm WSA883x (speakers on X13s) and
Qualcomm WSA884x (speakers on boards with Qualcomm SM8550 like QRD8550).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b60aa1f89343..a8f8c9cecf74 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -920,6 +920,7 @@ CONFIG_SND_SOC_APQ8016_SBC=m
 CONFIG_SND_SOC_MSM8996=m
 CONFIG_SND_SOC_SDM845=m
 CONFIG_SND_SOC_SM8250=m
+CONFIG_SND_SOC_SC8280XP=m
 CONFIG_SND_SOC_SC7180=m
 CONFIG_SND_SOC_SC7280=m
 CONFIG_SND_SOC_ROCKCHIP=m
@@ -977,6 +978,8 @@ CONFIG_SND_SOC_WM8960=m
 CONFIG_SND_SOC_WM8962=m
 CONFIG_SND_SOC_WM8978=m
 CONFIG_SND_SOC_WSA881X=m
+CONFIG_SND_SOC_WSA883X=m
+CONFIG_SND_SOC_WSA884X=m
 CONFIG_SND_SOC_NAU8822=m
 CONFIG_SND_SOC_LPASS_WSA_MACRO=m
 CONFIG_SND_SOC_LPASS_VA_MACRO=m
-- 
2.34.1

