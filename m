Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6448E7FCD29
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376788AbjK2DEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjK2DEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:04:40 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8316419B1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:04:46 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso6158019b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701227086; x=1701831886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJGxAu392s/bORKdAjJBrcSJ8FzTjUlfAs3pgZbxfG8=;
        b=hs8pfRPGFma1EueAR2BfbQu6ZGHmezoKnRYlJB+1QWez5uW4HNwTgrlzZEKSaM3hOV
         7PAiCLSZu7G9sli1ScVvO6EHxvxuUo+tbOCjgCJGGWgiyDjanQ6N1IUkzxMK9uOumoo8
         Gq6In8LxsytvM8HW3Q+dNy2uyenZB/lahzkP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701227086; x=1701831886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJGxAu392s/bORKdAjJBrcSJ8FzTjUlfAs3pgZbxfG8=;
        b=mud4WWW7hvtnuSgmSGO+k1SF00vnFT2LlvapfTZlxwsC4Qyb3su9pTy48Gqfgoxz+i
         vLLs1Oe99TFbcANkT6zeI9K9X0kipezcFJEzJD7qrBERuglsjT/qbYJVLP0Fa1Gueu3v
         VbpMwYRpo/Vwibq0f7uLpu7GLg4gx4JQ+ijGZHTN+6zzTBIFdyoE3kzZVvqTFfEg8tA5
         2KeoywWdBklvFkxo0XSLYg+0yO+SIsh6UU/qexiEpx84cOxWl6tHQDjbEb4rS5wgU49n
         ZI92cG/Hc8ay7Hyetq1KsUWAUmE5IusaPHWZTXuprteniwQRMYnw9soR/NNGP+bYKEDu
         R53w==
X-Gm-Message-State: AOJu0YxMDRVNRrdCLYnorUlFlSzloHbrstJbosKkXKFG/HFgP5ALJy6r
        W7R6MNt1PjHho5GfluZRtCsjAA==
X-Google-Smtp-Source: AGHT+IGygOdS0FDYG0MeUfrKyvdo448ZeERsKbGVJU3tooOdVfsvGLB+9h5K3ZINX8K1tfa6iwgshw==
X-Received: by 2002:a05:6a00:10d2:b0:6cb:4bd5:a4c5 with SMTP id d18-20020a056a0010d200b006cb4bd5a4c5mr20961101pfu.9.1701227085930;
        Tue, 28 Nov 2023 19:04:45 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:d7b2:b65d:af69:8a53])
        by smtp.gmail.com with ESMTPSA id u12-20020a056a00098c00b006cd88728572sm4847426pfg.211.2023.11.28.19.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 19:04:45 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: arm: qcom: Fix html link
Date:   Tue, 28 Nov 2023 19:04:41 -0800
Message-ID: <20231129030443.2753833-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This link got broken by commit e790a4ce5290 ("arm: docs: Move Arm
documentation to Documentation/arch/") when the doc moved from arm/ to
arch/arm/. Fix the link so that it can continue to be followed.

Fixes: e790a4ce5290 ("arm: docs: Move Arm documentation to Documentation/arch/")
Cc: Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc: Yanteng Si <siyanteng@loongson.cn>
Cc: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please land this through qcom tree.

Changes from v1 (https://lore.kernel.org/r/20231128002052.2520402-1-swboyd@chromium.org):
 * Pick up tags

 Documentation/devicetree/bindings/arm/qcom.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 7f80f48a0954..8a6466d1fc4e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -138,7 +138,7 @@ description: |
   There are many devices in the list below that run the standard ChromeOS
   bootloader setup and use the open source depthcharge bootloader to boot the
   OS. These devices do not use the scheme described above. For details, see:
-  https://docs.kernel.org/arm/google/chromebook-boot-flow.html
+  https://docs.kernel.org/arch/arm/google/chromebook-boot-flow.html
 
 properties:
   $nodename:

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
https://chromeos.dev

