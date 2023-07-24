Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B517375F551
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGXLkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGXLkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:40:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6A3E64
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:40:04 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fba1288bbdso6289020e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690198803; x=1690803603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkaTBeASYu8P0h7GTLxOpD3T0h5M1j1+XIcBVhBejCw=;
        b=TmpjHofSYLVfVJNedt0O7I7sIBvRnxc1Ld/aw4IzK8oJs3k6TQXF8h0x4h+POY+/c5
         65oVGeD/qaicON/k64VhctooQEsyGkFg/fCGvm458v2BsL/TVXIFz2MSyv0lq18WUFGV
         +f+jHgcJjKXeQpjXcstCN40yqf/dQ2w2EX1Esmn4CIL4RDreLu8DPei7+SWH/PImHlBz
         7di/x8gDopi+o3n1DQkuOO4k1jselKHrCb3ZSCDHRSWWTE76+4Jb4e/hL+2RYaNYEa+A
         9pVA6Kz1IwGT33zhWvjCqj7MGgAba9Rv12P11DRocgnHyHxbtg5ZX0RaX8FdP6Ymd/8B
         JKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198803; x=1690803603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkaTBeASYu8P0h7GTLxOpD3T0h5M1j1+XIcBVhBejCw=;
        b=hn/E4xgHBG7Uf2s6IhCvPIg4bbDL6fgGl7z3Yn/y+OI55sZU9t581Fj336zo3qCeNH
         Q2d4Hzqj0WInn0+3vOgF+BkNY/Gb+dNNLtAW8nRK5OXSpycAkTXGSwTUiCFldEg/GppW
         0PRIhaScNrguKeYmPYvfVIm1MZp6YPjgavLmAxQfN0u3K6r6KyrON4/HvrqEMvGGgP0v
         KgLKLyleJGpMcQ5emE7oHgyDhqPF0MKLGuwcEHFJNCGL1TX00qJrYpXxc0MIM6qeKwtJ
         zMv0uiZ/PXvQkSgX8BVGVVosnRMDEVeh3Nm2K1O97om1b0+8vEyPkx9E3iSrtBz8Q4hA
         u7cg==
X-Gm-Message-State: ABy/qLaG0P+/wzA4boStxHWo8q6rovn4kI7F707tZJHhQ+4oZKYk0bYd
        STZn3pbp7SXj5mGlaxbXgjXeUw==
X-Google-Smtp-Source: APBJJlH0+gvt/maOnNTBdDlYacWoBXnnvhUrQ/EO7mWnjfF8Gq+FLsqc3zbSP4To5aMzoQ76U+wSDg==
X-Received: by 2002:a05:6512:743:b0:4f8:5e21:a3a9 with SMTP id c3-20020a056512074300b004f85e21a3a9mr5070585lfs.45.1690198802939;
        Mon, 24 Jul 2023 04:40:02 -0700 (PDT)
Received: from [192.168.1.101] (abyl203.neoplus.adsl.tpnet.pl. [83.9.31.203])
        by smtp.gmail.com with ESMTPSA id u1-20020ac24c21000000b004fb881e5c23sm2168977lfq.47.2023.07.24.04.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:40:02 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 24 Jul 2023 13:39:58 +0200
Subject: [PATCH v2 3/3] arm64: defconfig: enable Qualcomm SM6115 LPASS
 pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230722-topic-6115_lpasstlmm-v2-3-d4883831a858@linaro.org>
References: <20230722-topic-6115_lpasstlmm-v2-0-d4883831a858@linaro.org>
In-Reply-To: <20230722-topic-6115_lpasstlmm-v2-0-d4883831a858@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690198796; l=785;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hEAbD0xgwC03VcKuSXGbzmZXyqv8HA2q8JevzuYpv3w=;
 b=ERjNz1vReCRC3dDYlHXbQ1VlkzVZzSxXRlX00NBwQDLB98nOU3vnIGSVQIaAATG830boIMcTk
 Oob798ysbfZB4+1PryOMWbTgpV1CH7GiqFpLjpgmPBME+foFcUyI3S8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Qualcomm SM6115 LPASS TLMM pin controller driver for
providing GPIOs/pins for audio block on SM6115 based boards (e.g.
QTI RB2).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6cbf6eb59378..6911101db09e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -587,6 +587,7 @@ CONFIG_PINCTRL_SDM660=y
 CONFIG_PINCTRL_SDM670=y
 CONFIG_PINCTRL_SDM845=y
 CONFIG_PINCTRL_SM6115=y
+CONFIG_PINCTRL_SM6115_LPASS_LPI=m
 CONFIG_PINCTRL_SM6125=y
 CONFIG_PINCTRL_SM6350=y
 CONFIG_PINCTRL_SM6375=y

-- 
2.41.0

