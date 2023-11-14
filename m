Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1C17EADC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjKNKPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjKNKPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:15:00 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47A3D41
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:14:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso40175825e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699956890; x=1700561690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRDQG90whNGruPKHBuSb0fwlNjOLqK156tQl7yY601s=;
        b=US393F4UYxK7bCLxY/3lub1L5LkCGPWtNZjESc+RxTLquhIm5M3sAL5JZMxqzgXvvP
         lVrt4UiUErKJNkG+b/33FH8bBIvO+E6veDoI+z3Z9fmRWAndN8W7gGn0xkAt38RBhuDu
         lh7tNBnHmQo9yNNI3oPEimbi9bQMvoTwoJYqkd4QqHsWDJk0vHUNEeNpTxZf68lQNX/+
         ZArnRk5qJPI5lPoUjWueX4zZrQlhRuq0lAMvM8sjIhOu65PM8/6vnH7jt7wDblZ1YY/Y
         6L1bTVLSPGLXwDvOtnvqddOk5jKZugEmMb/A8VAgp7nRl0xqFRzVg4kt/p/6VQWSVmQO
         pOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699956890; x=1700561690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRDQG90whNGruPKHBuSb0fwlNjOLqK156tQl7yY601s=;
        b=adq0zjQ7bS9oMCmFug1w9Di8/VfFPOjucrJ9sVlkZjITLWG2aworTKNG+4czNqsHIR
         7pjqH0gwkUUgfaBOJwm0jChkbwztjiPu89C2aWfRHnjqYr/5TwQWt6VdC71RZow4eqCV
         +r/CKoL+8+ojR/jPBnSpZJ37muc92/yq7HlDJubehY0Oued4pMGloqCjgbKCAYH4zFi+
         dNr5m7KqrDtUV8eP9O7uCL9WtFmFQblwWk4ukZ+WFiHtPuLjfLpG1pKSSAVAgAoxOtDu
         qXBwSeZOVd56y/pxp5sH2bbRYT4G7aruUO/JSgApy6+otOZXSiNm1Y45wmJzIDYVgZpb
         jQeQ==
X-Gm-Message-State: AOJu0YzfySrI7xEJAMYt3QlBGHBwBkq2BMSQAJ4Zx27Z3+RvEOxfglTu
        rGEUuPQ8PquMnC5m9w+RcjQclw==
X-Google-Smtp-Source: AGHT+IHmsBNotjLNrikShfJJvLrq11qapucSps8g7MZLwa+tjWVJJCpV7UxEKCvxDB7DcdqG+/7Vxw==
X-Received: by 2002:a05:6000:146:b0:32d:8ac4:d23f with SMTP id r6-20020a056000014600b0032d8ac4d23fmr5433225wrx.29.1699956890236;
        Tue, 14 Nov 2023 02:14:50 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4202000000b0032d886039easm7335585wrq.14.2023.11.14.02.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:14:49 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 14 Nov 2023 11:14:43 +0100
Subject: [PATCH 1/3] dt-bindings: clock: g12a-clkc: add MIPI ISP & CSI PHY
 clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-topic-amlogic-upstream-isp-clocks-v1-1-223958791501@linaro.org>
References: <20231114-topic-amlogic-upstream-isp-clocks-v1-0-223958791501@linaro.org>
In-Reply-To: <20231114-topic-amlogic-upstream-isp-clocks-v1-0-223958791501@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=831;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=tPtJJ4m8r/duCINFRVQmq1vnhsfEoL+l4IqBBJv4OFw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlU0iWrW3bJixBh86isYE3uIDZg0edHMEQSNsOH/tr
 2wGdcu+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZVNIlgAKCRB33NvayMhJ0anlD/
 wIbIB19tLkjnhKjUpQ6bxJq1f1aWQ1KhjVUIpQ7ASlwxyFig16JMn8WUBIGhvjnLWqfSzl35us30L5
 UHO40qf3vj4ZRTwjEeJ3+3ut4Ifd1l+a/DZa/r7sLT2nO4PYBqjdoGhLCEmjywyah0a4yTosnqOl49
 uFPChwRBc+gB8t4179Ew79CaOQVsDj5V0HJ9e6YGHfprV9Nkbcb2PvTMja93Yd/aaAl6xE0Bq+TYaT
 1ZiKTkPqmERwpBQTCQObCQXk5vnK8RejXUIJ3zkn/hk65BRFDilS056YsYn9N9XePaFdwfZEc6RJEo
 xj2TwDruehIwRanthgjnlc6k1+iDL3PMLe770Ghsr1Zd2A3o28TnSVIMVX3Oy5IOPQ/BYQ61Ykc0jW
 OcgcsST7i+BXnFDHh5VBlAd3wLNq0zxB6Y0kdrUJYDmu///jxUzvauhhu+IR9f8PYqxwZ5QaAA9aSh
 SMbslJdDNd24tNIiV49IVwkkaqmpZrYznVlkPnh6cizZUoQVK9LSF465viJBIEHSHSdDeg0WTDBuEa
 roceDDkzbDqH+9M8DhE+Js0UK0ZytEyXYARScxFh5buD5wrn2reCjg2camoSUyMElS2/0mUIo6DufP
 UwBTTgQ1X/YGXn2w8rdLdKWQ3qvxkd9LKURzAVJTXPmCYaFxEAv+b/snXHGw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIPI ISP & CSI PHY clock ids to G12A clock bindings header

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/dt-bindings/clock/g12a-clkc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index 636d713f95ff..fd09819da2ec 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -281,5 +281,11 @@
 #define CLKID_MIPI_DSI_PXCLK			270
 #define CLKID_CTS_ENCL				271
 #define CLKID_CTS_ENCL_SEL			272
+#define CLKID_MIPI_ISP_DIV			273
+#define CLKID_MIPI_ISP_SEL			274
+#define CLKID_MIPI_ISP				275
+#define CLKID_MIPI_ISP_GATE			276
+#define CLKID_MIPI_ISP_CSI_PHY0			277
+#define CLKID_MIPI_ISP_CSI_PHY1			278
 
 #endif /* __G12A_CLKC_H */

-- 
2.34.1

