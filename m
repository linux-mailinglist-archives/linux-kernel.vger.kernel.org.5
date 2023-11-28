Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE47FAEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjK1AUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbjK1AUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:20:49 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BA41B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:20:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ce28faa92dso37136415ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701130854; x=1701735654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9LcCMDmTSdehjuq3j0tEJnIQIb6+TDJYhvhvJwU+wo=;
        b=j0HaNRlM9mX4bZwsZGFVAiz0eTkwB/pdJTDOabkRfx0fXjD+BG8NEjs+UgHvBdx9p8
         SZUt107ra1xcyurkJA4DZwHGWm3OG5s2lXKYeoM+M6wy12DdKJuRDLngUnCBOQwt2njK
         etgNzmp1epSToBuG6kIer8nyHFs7tD6fboSXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701130854; x=1701735654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9LcCMDmTSdehjuq3j0tEJnIQIb6+TDJYhvhvJwU+wo=;
        b=UPueqrqo6fYriFcMLnLbHnpHlC5Dx0M1l89kKuWAf8nHHBfBguFAHVrHA4jgY72hr9
         wtsWx8EL0jG1afmu0IDpST23TETppkBhHwLs3Q8VqlbWEDOudxnWXiu0rPIIwS0WzIxw
         JBg41R2d/5hnBNF/6/33SZyZKdXJWbCvOUWGApLPmGX9GKZjI/DreoMUCggsjcymfP9U
         P2d39nMzP8G5g+SMuFkaKEP+QoboMdZqtveWzaXCMIdtqjgdBdHdhH/dRTcdGaOxkXX8
         gplp21D9YmDm/vMOMtt0zXEs6hsI4CRP9Km8o1kDvsgrUoXHl1QtbGywG8ApfOuxfeTt
         1osA==
X-Gm-Message-State: AOJu0YyhEFa2g08bClYvaj7RZQl1woVa7UePZOoRb6KhYpEZMm98mvdu
        zDgcs8r/ewN5XVbSPhwqp0lO3A==
X-Google-Smtp-Source: AGHT+IGFzSIOfg8sKm6Au/0ACHEqu0Oge23/jZd49oSPNDz1XcwfEzxfUkI9Gck94hxyHvZcKR6OQQ==
X-Received: by 2002:a17:902:d303:b0:1cc:2f70:4865 with SMTP id b3-20020a170902d30300b001cc2f704865mr12921138plc.26.1701130854419;
        Mon, 27 Nov 2023 16:20:54 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:6438:b5d1:198e:8bb0])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b001c60c3f9508sm8878786plz.230.2023.11.27.16.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:20:54 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] dt-bindings: arm: qcom: Fix html link
Date:   Mon, 27 Nov 2023 16:20:51 -0800
Message-ID: <20231128002052.2520402-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
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

