Return-Path: <linux-kernel+bounces-50338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE888477A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9F728A582
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621E8154C03;
	Fri,  2 Feb 2024 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPu9JW/Z"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF22153BEA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898909; cv=none; b=i6ZF+OYBDwlEfX8x8H1Csa7+YjMxDNWRLEAyigKKIX8SsM9ABKibs02OTP4AsW21gVYeLY11ghc88ykAjKoOg6/zix4Wa4OQRS0dJ60EO6lq3ss+CK/77ANMjOGsVO5XYf6BAujhASXhhy2/HuwDWVDtvPNmcKqsuxQj+ne8uk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898909; c=relaxed/simple;
	bh=wOwjixvOBb57O21H6kXdK09tVckX+ysQRvWYlwrvOP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bx1SFFHvAQ4kH7UVevNNOHXM6/GyMMNr0dpsNnOaRWWcfmso6KsTtLWg5jO6YeOO7L+pBiMaWJo+fX0NOPDU1/fzCTPunEUum1gyjbKYkqOlF3ktyNrBE/6MQPoOecMbilf8MZvDAZmFknbCFoO7ULvMJmTHYRzLWFLO/bUq2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DPu9JW/Z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a370e63835cso116679166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706898905; x=1707503705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eB0k4Rx8lLFU8UGZ+hmhNdX5P8zfKAzC8GL/lRneZus=;
        b=DPu9JW/ZdTfiKuw2h6Ee3R1cQmIfvD8CaFmuoNczfpt6DW4cYCHVigPnRWDuwuNO9h
         6OAQbEetakM4GCoOJ44xbg08VLyqLq0GqbJYwI9RyyjzUy2RiP6PpdJJvAcLj188Iuu0
         OxL8fXiCtcIgdcQ+VQVQIVDiYh9k8xRolOWjnKZdKu4Wki/f9mHReYm6auiyISe3Cgx0
         +IYM8+kp98mraFwAAhbsSbo3PQVf6EfWs8oYi3KQMYpaKHxTwrlp2fNff/OIkK1C1KwA
         MlxLMeNr/VJ+QPpjLYRKkdffSaCp3qEtfxEM9Fvvh0qYU9OR9eILOl20YPK/PhB0UxmE
         NlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898905; x=1707503705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eB0k4Rx8lLFU8UGZ+hmhNdX5P8zfKAzC8GL/lRneZus=;
        b=jWaGo4Hu7U5KJZqgZNuCHopcwGabSKap+2rIjEAhgY0WPo9whOUJTLSd4AGm5GdGtN
         lJ/+I2kv0P619SYIHi1KonfZL6pQqCNLF4xWgFCVgQt0seC49SIB5My4vP+FWHxhjGMo
         8xT/ZSNiySCvrSp8Vh+9NjyRv8j704xrYlOAbfcgSqrJKUvcbxmw2UGvqKYakjA0tQI+
         kYRTi0MNTvllwhfkdyG+4alaCj1MTnrNopN2KTjBzufUQy09yiKHO7gAMhQAgm2AXw/n
         w+ihbJwySZkd4tv/6jlHVNfdvcixKoEr5LjDxQbixwBaeRBli7d5+hA7CKcXOiS0VbYe
         oklw==
X-Gm-Message-State: AOJu0YzVV16eLElNyAR8GzHh6xGmmEJVRxgKnCxuGLH6uyaw4EjGA6eL
	X0CZe9HvY9jnkqIkGWES+AmqCCsJL+P2DirgMVsoYr86n3nujyRecvCMbM9466g=
X-Google-Smtp-Source: AGHT+IE6jm5HGAIN0rCjyREM4vt4m7D/T1QTDIObDIhTrtpN5IiKIoG5/m2UiAj4iLfdh3zKTb1aUQ==
X-Received: by 2002:a17:906:f8cd:b0:a35:a71d:81fe with SMTP id lh13-20020a170906f8cd00b00a35a71d81femr4241009ejb.43.1706898905610;
        Fri, 02 Feb 2024 10:35:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW/TIVnyczqsRyg640QYg6iDNs9mHz3kkLq0C9UtRkwBIU8TXVenbOt4Lpb0zPjFUNw16w3q9bgTtA8DNk1eiUW9FS2WtQBjQkl4dQ+qo+WaUc34iJcqT2YQOHAgMMLwe7JJuvVEjWv9yMoeUPEs1XmyTvDqctZQhEPXttjRL8Kex5N8Qa8MplVfviwIdp9ofTSKn8xSVsgNuzmBYkV7866ZBcbFHcjSvSLoIGJQXWYdPU8BVy65VtjtVYuyMk8BOb/6hYSmWwGzaNfdlcSfsEeKaHgpE2FvZ+ZCZvYigYTpYvFL0Vlc9h9A53ZugzRR9BfdO9/XOQ1Ab1N5X83NfoxeC+CgEQwuZ2pHe3hAB3u9Dxl4q3WL4S/wAp/o515L0DtvX2pJUeRQMf5Ci8KMd2VZelg3wmDBuGZu+th5u+W+Y7LxIRhypow5hxH8Cj5DJlm5ZraHyf3BubIQJl1TCdxVULnWZcB4tHxOA4Ch1jtzZwe6cNvgZF9ziYqdWC17pcsocJggo4iL4b9NEzaniK9/8xtxX5F9WIWbYHUHnxERKKJZvB5ZGXpZ06F6U8hoQqnVqobNTsln4471/uDHQQe5XutAC3EDa0lsTd/EhOSwF1hOPH+h1uWzAlz
Received: from [127.0.1.1] ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id vh10-20020a170907d38a00b00a36fa497a65sm1051328ejc.110.2024.02.02.10.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:35:05 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 02 Feb 2024 20:34:41 +0200
Subject: [PATCH v4 06/10] clk: qcom: clk-alpha-pll: Add support for zonda
 ole pll configure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-x1e80100-clock-controllers-v4-6-7fb08c861c7c@linaro.org>
References: <20240202-x1e80100-clock-controllers-v4-0-7fb08c861c7c@linaro.org>
In-Reply-To: <20240202-x1e80100-clock-controllers-v4-0-7fb08c861c7c@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3073; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=7hMtsutwFIJfkcmivoNWL+5dN+rIPkFX5C/YyW3SaEk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlvTXIa20qHwErMw3cFeQti7L2hs3BduXyx1x9v
 OmDzj0C+kKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZb01yAAKCRAbX0TJAJUV
 Vq0AD/9O/V+FbPyQakIOdOVxaLa8VTnjOO4hFFO8kuJ5oxEpbFFEXmPvfOYkUoaBhxxWrx9GmK0
 BtRaDY6SA36bNgLNcabThLnIeVk1ydRKIMAtzNi0FGNd9Sgi4UAnNt1rI8Dw30Ql4vvy+msisv0
 ipw/js7oOI+CANkgeAQevTHPcFnbY2HN9uNX17IvhvRnt09wBVj5LCXwwXV4ZLVvnC7GdM/Yssb
 lgt+HjeCEj+qA+9E+eRQQhgCfgdUVjPs7LCDY4yi3A0OyycaTdw7vrIUws5dl5/uey1afwqwH1f
 JQogRacdJY3ouv/EzaxVCBLzkbyXviB5OF6DixH8T0BhknhqY/oUE7VhCISLBsvDk2HPRLpSvUI
 B+xwMTtVMG+/fJwuWErXVEm2QaLlP6ex05ygSSAEaKplsVvewDWsdsJcE5Xm69H0Didw4CB57lT
 KCDZRm7c3riZO4m8uYQN63NSgCTGjlJgHat0qBRHJTyfB2/FyDTnn9mrgnNp3ELR1jzeZZR3Qbm
 D9YUrpNB8TdFaEtOD4ux1Qnt6r110z61FctnGn/FTPPQk155ixFOCYGK8U3yTdPTB3DXsCeGLR+
 CF4yHEq/zKiydBZ39lx2cqGQjFVtTYXtqSbgav9iCiiK1QIY/3CPzTw0TkoKVB/5yrSeBj2ej2l
 ybkEbtVjZMwU00g==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Rajendra Nayak <quic_rjendra@quicinc.com>

Zonda ole pll has as extra PLL_OFF_CONFIG_CTL_U2 register, hence add
support for it.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 16 ++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 05898d2a8b22..8a412ef47e16 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -52,6 +52,7 @@
 #define PLL_CONFIG_CTL(p)	((p)->offset + (p)->regs[PLL_OFF_CONFIG_CTL])
 #define PLL_CONFIG_CTL_U(p)	((p)->offset + (p)->regs[PLL_OFF_CONFIG_CTL_U])
 #define PLL_CONFIG_CTL_U1(p)	((p)->offset + (p)->regs[PLL_OFF_CONFIG_CTL_U1])
+#define PLL_CONFIG_CTL_U2(p)	((p)->offset + (p)->regs[PLL_OFF_CONFIG_CTL_U2])
 #define PLL_TEST_CTL(p)		((p)->offset + (p)->regs[PLL_OFF_TEST_CTL])
 #define PLL_TEST_CTL_U(p)	((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U])
 #define PLL_TEST_CTL_U1(p)     ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U1])
@@ -228,6 +229,21 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_ALPHA_VAL] = 0x24,
 		[PLL_OFF_ALPHA_VAL_U] = 0x28,
 	},
+	[CLK_ALPHA_PLL_TYPE_ZONDA_OLE] =  {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_USER_CTL] = 0x0c,
+		[PLL_OFF_USER_CTL_U] = 0x10,
+		[PLL_OFF_CONFIG_CTL] = 0x14,
+		[PLL_OFF_CONFIG_CTL_U] = 0x18,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x1c,
+		[PLL_OFF_CONFIG_CTL_U2] = 0x20,
+		[PLL_OFF_TEST_CTL] = 0x24,
+		[PLL_OFF_TEST_CTL_U] = 0x28,
+		[PLL_OFF_TEST_CTL_U1] = 0x2c,
+		[PLL_OFF_OPMODE] = 0x30,
+		[PLL_OFF_STATUS] = 0x3c,
+	},
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index a1a75bb12fe8..fb6d50263bb9 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -21,6 +21,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_LUCID = CLK_ALPHA_PLL_TYPE_TRION,
 	CLK_ALPHA_PLL_TYPE_AGERA,
 	CLK_ALPHA_PLL_TYPE_ZONDA,
+	CLK_ALPHA_PLL_TYPE_ZONDA_OLE,
 	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
 	CLK_ALPHA_PLL_TYPE_LUCID_OLE,
 	CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
@@ -42,6 +43,7 @@ enum {
 	PLL_OFF_CONFIG_CTL,
 	PLL_OFF_CONFIG_CTL_U,
 	PLL_OFF_CONFIG_CTL_U1,
+	PLL_OFF_CONFIG_CTL_U2,
 	PLL_OFF_TEST_CTL,
 	PLL_OFF_TEST_CTL_U,
 	PLL_OFF_TEST_CTL_U1,
@@ -119,6 +121,7 @@ struct alpha_pll_config {
 	u32 config_ctl_val;
 	u32 config_ctl_hi_val;
 	u32 config_ctl_hi1_val;
+	u32 config_ctl_hi2_val;
 	u32 user_ctl_val;
 	u32 user_ctl_hi_val;
 	u32 user_ctl_hi1_val;
@@ -173,6 +176,7 @@ extern const struct clk_ops clk_alpha_pll_postdiv_lucid_5lpe_ops;
 
 extern const struct clk_ops clk_alpha_pll_zonda_ops;
 #define clk_alpha_pll_postdiv_zonda_ops clk_alpha_pll_postdiv_fabia_ops
+#define clk_alpha_pll_zonda_ole_ops clk_alpha_pll_zonda_ops
 
 extern const struct clk_ops clk_alpha_pll_lucid_evo_ops;
 extern const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops;

-- 
2.34.1


