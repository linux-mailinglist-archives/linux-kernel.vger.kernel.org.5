Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8D9785950
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjHWN3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbjHWN3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:29:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24899E5E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bcf2de59cso733332866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797291; x=1693402091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZg6bgAj65DnkDj7TlelvOaycLC9ME/S7RGeUkwXOdo=;
        b=jmKK+Xf8XsR3gVS42SSJhuUZSWQEoHuT+GAoUmZf8+Q5Orim8GnjS0viUlzi08ipAF
         L0cAc5cl+36xTA7UB4Thb/z0QNsYE9vF7ctNXiwgBNaHcZcSD7BGE3xHntrl7nqgNFRq
         kIYtkXBOoRs2szhB9ALN0BoGkEEOB1yscvACWGji2IbPLLvpVPJE3sCoHJ2omBNPQyBR
         B6kwwCHnyLGcGm6Mqu4XiThCKxhWgFZPsZKbcLJmFpgh1udqOe1QjaWpch+BS/xr27fa
         mJyKAqp34zhOacGGbKQkMI69UszZ6hpiurH0nJUECEe+R87PpvFcEg+bdeu0AEPmk3nV
         obVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797291; x=1693402091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZg6bgAj65DnkDj7TlelvOaycLC9ME/S7RGeUkwXOdo=;
        b=kwRiWDWADxWVwhtNCPBnDE7kST5KkGhKBbvbFeVo+OOurVx6htX3uxOj6QQW+qUvmZ
         KUX7ehWIMIcQ/kZb+4aiFVrW0a9+/Z+9OrSZ9IfmDADsn9DANYgAgCWN9PeFRSCYogQb
         YEeRDA65xLMmCZIQSLdvpV5KfkfifJX6gOJdYwHTtQ98Q4glDbv64nTrAL32q25UUFHh
         hZnCngDAJVJ/ZDhhrKq50cP9lpNEhhMDsA429wA+CahodDme/9KR4y/q1IFpEs8pr6gu
         duU0Hehdm8+5DsgNHvXuMwhy98ZUDs0kjXb15IYk9KVgHXlxDIPXLLx+BAEtE/s3XuNX
         hp6w==
X-Gm-Message-State: AOJu0YzF/1xRPzzZ2de+jEe3F3arZxnjEqtL9EdpmQRlHOQgPgKfTYD2
        7h2LGKC3HK6tMkmdJzLnIwkzoNPgrQAEKQIP8MY=
X-Google-Smtp-Source: AGHT+IEgmBbu/EB35gp60qOmuaqJ1tie++YGPMdx3CFMYK3hnmgEJafYRR93gCANKtB/myvdhSRVgQ==
X-Received: by 2002:a17:907:2bed:b0:99e:4bc:7da1 with SMTP id gv45-20020a1709072bed00b0099e04bc7da1mr9655354ejc.28.1692797291245;
        Wed, 23 Aug 2023 06:28:11 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:10 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 14/22] nvmem: Kconfig: Fix typo "drive" -> "driver"
Date:   Wed, 23 Aug 2023 14:27:36 +0100
Message-Id: <20230823132744.350618-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=B9jg4+Ngh1jsVDd7mc8vr3DwY4/CybzXw0fiHY62evQ=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glICrGqS5tB+8WBK5dsdUy6ZXMLjrGw4yVdV N9Git9SC9mJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJSAAKCRB6of1ZxzRV N9fxB/9IVP1xJWrWa6GcnzbRkbym2Vz4yN69qSzJzRzIYYXKBjCpgUUhD0Qg6UROzWfH1y1Daxs RNYLIP1UmUCDXAROK4MToV63Xbvp0os6HN3+pmyddHfugPhx8nAPvHwDxL28sIUQldopmScaM/f IW+2bEDdNLm58qppIDA7it55i6Qpt6ZkhsOKR/i6AT5HYbl5qzsBbH16Rr3lmwB3GCyo1PYpVRB YuCs6TH2TB8gu3pAmwvz02FAHGdtTjpR89s0VcuQWBm9gLSF9nnRScaLY+duc7+EGG+A3swpzuX tmAjpUT5OyLAX1YWYqOmzFnqxwtzwCh7SNZ2M/a7jQWIPbeP
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diederik de Haas <didi.debian@cknow.org>

Fix typo where "driver" was meant instead of "drive".
While at it, also capitalize "OTP".

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 5c5d7414f78c..7ab12fc1044c 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -247,7 +247,7 @@ config NVMEM_ROCKCHIP_EFUSE
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  This is a simple drive to dump specified values of Rockchip SoC
+	  This is a simple driver to dump specified values of Rockchip SoC
 	  from eFuse, such as cpu-leakage.
 
 	  This driver can also be built as a module. If so, the module
@@ -258,8 +258,8 @@ config NVMEM_ROCKCHIP_OTP
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  This is a simple drive to dump specified values of Rockchip SoC
-	  from otp, such as cpu-leakage.
+	  This is a simple driver to dump specified values of Rockchip SoC
+	  from OTP, such as cpu-leakage.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_rockchip_otp.
-- 
2.25.1

