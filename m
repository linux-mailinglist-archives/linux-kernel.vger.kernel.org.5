Return-Path: <linux-kernel+bounces-50334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54511847791
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4725B1C218A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8173151CF0;
	Fri,  2 Feb 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckYIbap3"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989A15144C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898902; cv=none; b=PyGdQIWlCHJUoADQ5ofm+scrlhabgC5Tt2ihyRJjUkD0zIkpTY/n3qgZofRCdMYsZxBsV9pST41naz4fEeraZH3IC2TExblJtm+X4TISd9YH3xuiCvo/vrAwyE9ujzTsE+03wCPfPT254YIFzb2hzH0yfEYMKpAD3DKJ2eLiF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898902; c=relaxed/simple;
	bh=vnNZdrva/GeFt81JLdOrHZAe6+/2CrTRGADyIRb3/zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpehOBleyK+PatRIg/D9ZrClH+VUQ7NZ0PQX5gmvWN4dPTtGro1m+RtTlorKEmfMBy8GqT5m5ysWkC6VaWcALMVjnzWJvTO0XdoQnn4S9sBghWe8ZedlA7de/3MOmc50VO0YqYuZTx1+cQzSZID7rV/mA261KYCLwfbpdYNveZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ckYIbap3; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5113a8c01acso701688e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706898898; x=1707503698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMBye1t5UXcNhXWhmik2JmMhzzuBlYhDgwEz+d1O4h0=;
        b=ckYIbap3kARHlzHvTFcg4CidztsCNepTmD2Ioe0GfmWkVdXk5G3yl4hJ7FARW/C7qf
         VJTAaFThNmOkUPc5BsLq4g7aZ11rlzu+EeSrt9TIynee5mkCEb0odz9SwYUAD88rxucV
         six3JYNuLy9D8gre3wTwrI7Exn4IRZgmf3O/QpLjU/ZdW1pUu7wD8sG/go6kEbIZabwc
         a7qWzDrW7bqOOJCgyOH1cYk9Em6XeiEo5VDw6k+97KGelsqOxGNdaGNmekZfnoYMjbhA
         hN6Aa4wTkdzSab5zc+hmq6bifPkPJezlo1j/idl+tLopPG6e2fAiu7Wgw1VK0ivRB0tN
         Gv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898898; x=1707503698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMBye1t5UXcNhXWhmik2JmMhzzuBlYhDgwEz+d1O4h0=;
        b=dOJF4BADzTQoB7Yr7LIDIX2e1dhCWUcluEJcz28Rxqx+hBUrfuiRoY55Hou2UFeGWF
         3ycCYCJCXlO+/0nXwcG3xjg40DAY6eVZnp4QYxjz1uimnm2dRCp+8D/OzsOGeyr+IQQm
         b5/tkw9oKpt0iYSwiALaAnZUrHifSmP5J24kDmZvk1RHYXXgPhdgVWFs7SMIE4A78mSV
         HxqUdXFMRYajO5JkPpxZ65Fv7YjQ0VpyCfmsUmLAbJ39jOCAyE94GRJUkoz/b4mRxa7a
         fz4YB9Cg4Sl0A0dnuiNVrgzWzQxMF9noBKB0QmItPGegm5PHsSu11vQgQAqlrW9ZcVyQ
         IaXQ==
X-Gm-Message-State: AOJu0Yy6ziboVjubiEbuSLTk5QtT4Ptc+1Ra7D/cVG+sWXcqj4kt0Bch
	QiD40Q/YYmoLZlNIz0M4E9FGXMeZRXIsnYhKSUCgy4AhIXjh+H9jU+j3hNZufj0=
X-Google-Smtp-Source: AGHT+IHz3Rk5MLbjocbU+WUmhvHh3j6jfO7ERtAEQUBNJhGeSp96g/VgyaeRS4R/crlAULgHV6wlDg==
X-Received: by 2002:a05:6512:4020:b0:511:300c:d40 with SMTP id br32-20020a056512402000b00511300c0d40mr2445419lfb.22.1706898898639;
        Fri, 02 Feb 2024 10:34:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXp1GhpA6KNkHvC8w+2yyWauiKrvfd2pZewiPxTt92uwMeFJsnMiNbxTFyiYdcPnf9YKG5IXi/IREJZ6G4jAjNfAfGzUoDbhZ2/6TPwvM+0XITNGtbj6elSUkU/jSv75LjowR6pdiWodpMK/sCLHVEDv2WL+tZ7eVqL7QsqGANGgE9FIQQrAVabXBfGLUKv6K+bMJES5pQLeo2AXpUdFXHcPx6P/0oL+FH/7k/yFU+YbsWRzfAnMifP1CH7sSsv/+KEyT9hQKrY4WWyOqARsicnXrHGLqgMkHf5FrrNnZIPsIRV9LwsV+9s8W/iSho44dfm0sNi1kWStw3BEnmBYNzL6xAnSUSi1s8b8RrbYHjF/SZbYgN6aOOwp0TjhEW0zgqsPbXroJ1CaxqeflNmpqgbskH6LofWzrawuIpDeL6G7fW5tAz8BQ2XcYYbqMIeAZztmXpV1o5a6V4HQUhyF+DqVqlegXNRsJMWvgnAqyTn6zgv/hbPtMuh6L2GVsxusiXzUXV9L76ReraOt05DYVqN4NpVqJW/PF4yrXAB3VIVZcU8iFZV9GQ13oVEfXsR5UIK8Nmr+taKuvPHRAxLyelmcna03rzCNreEDbzWx54fJn1haNgBuf150FVi1b/M2nHA1gzcCS9FhcH17ZAfOXdu4NTPJ2WAuCLlMk8=
Received: from [127.0.1.1] ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id vh10-20020a170907d38a00b00a36fa497a65sm1051328ejc.110.2024.02.02.10.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:34:58 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 02 Feb 2024 20:34:37 +0200
Subject: [PATCH v4 02/10] dt-bindings: clock: qcom: Document the X1E80100
 Display Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-x1e80100-clock-controllers-v4-2-7fb08c861c7c@linaro.org>
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
 Abel Vesa <abel.vesa@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5379; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=S9TmHat1VTKPTNTwEMUe7uLg3aArQF0Wrx9YkgJDDBU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlvTXEHcrCbBu9y2xmIO0q854sRYtddeSob+UCI
 v8DQ3Ioj/eJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZb01xAAKCRAbX0TJAJUV
 VuIAD/9jUvyVx5ICcyPqw2ArVb62cigjwS/oUSyUtKDtx7We1vvzQnFjhXcrGJhRcp7M2jTWzcX
 HoI16/XHBpDJRS5zXWktH4sgxWvq7OgvoLgiyYsqUQikgRU05vRrtcZlFzMEoYvdwRat1KLIHNG
 FZpqH6H2Ogna5wKRekJ1ruRtxJ9WFmd0ZdZ2Gd7IEZdgAURgK61R6XKxRXAeWU/bheLGKz1LxHD
 XDvNwllcdiSKoe+kPUer0H7V407/5gPb/RUIcCQ/9XObwMxz2fzBilHmaa3dwN56Ppbe6Ld+kcd
 /g1lOD4ZqXl2LNLpqRrHQVoQbRO4EAzfNaHXVNF3hjy4MmjOGL8btqPqq7LC8LdISpbm5J3lumz
 b6hiaulwHsoaj3gTrcWGbzcUWPnb+NkClmIW5WcTbB8qnxCsD8BHJMC61eGeRzew1BFIqAu/Spi
 vlacn5Wk6MjlnCPTj83B7hJ3BJ4d7lVtUQnF/9aYnT1Kho/FvoG5VuIDe/Q7JLOtZ/T3CBWdukg
 VKzmjwTHFf0Ka9CJTzNqExGckhrqTM3EaOx5oq3glLFdgE2GlAd0mha6mQ5ZT1U3spVYAqhaw/j
 1m+pbsPYv09w9k0QVBT8B/qU9LlLuOj50c6Z/gdVcJU74BktqLT61uP3Dq3kLNWOnmGU9uSGPPR
 Jj1XPa9TLylQsqA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Rajendra Nayak <quic_rjendra@quicinc.com>

Add bindings documentation for the X1E80100 Display Clock Controller.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |  2 +
 include/dt-bindings/clock/qcom,x1e80100-dispcc.h   | 98 ++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
index 369a0491f8d6..bad0260764d4 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
@@ -17,12 +17,14 @@ description: |
   See also:
   - include/dt-bindings/clock/qcom,sm8550-dispcc.h
   - include/dt-bindings/clock/qcom,sm8650-dispcc.h
+  - include/dt-bindings/clock/qcom,x1e80100-dispcc.h
 
 properties:
   compatible:
     enum:
       - qcom,sm8550-dispcc
       - qcom,sm8650-dispcc
+      - qcom,x1e80100-dispcc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,x1e80100-dispcc.h b/include/dt-bindings/clock/qcom,x1e80100-dispcc.h
new file mode 100644
index 000000000000..d4a83e4fd0d1
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,x1e80100-dispcc.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_X1E80100_DISP_CC_H
+#define _DT_BINDINGS_CLK_QCOM_X1E80100_DISP_CC_H
+
+/* DISP_CC clocks */
+#define DISP_CC_MDSS_ACCU_CLK					0
+#define DISP_CC_MDSS_AHB1_CLK					1
+#define DISP_CC_MDSS_AHB_CLK					2
+#define DISP_CC_MDSS_AHB_CLK_SRC				3
+#define DISP_CC_MDSS_BYTE0_CLK					4
+#define DISP_CC_MDSS_BYTE0_CLK_SRC				5
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				6
+#define DISP_CC_MDSS_BYTE0_INTF_CLK				7
+#define DISP_CC_MDSS_BYTE1_CLK					8
+#define DISP_CC_MDSS_BYTE1_CLK_SRC				9
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC				10
+#define DISP_CC_MDSS_BYTE1_INTF_CLK				11
+#define DISP_CC_MDSS_DPTX0_AUX_CLK				12
+#define DISP_CC_MDSS_DPTX0_AUX_CLK_SRC				13
+#define DISP_CC_MDSS_DPTX0_LINK_CLK				14
+#define DISP_CC_MDSS_DPTX0_LINK_CLK_SRC				15
+#define DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC			16
+#define DISP_CC_MDSS_DPTX0_LINK_INTF_CLK			17
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK				18
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC			19
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK				20
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC			21
+#define DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK		22
+#define DISP_CC_MDSS_DPTX1_AUX_CLK				23
+#define DISP_CC_MDSS_DPTX1_AUX_CLK_SRC				24
+#define DISP_CC_MDSS_DPTX1_LINK_CLK				25
+#define DISP_CC_MDSS_DPTX1_LINK_CLK_SRC				26
+#define DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC			27
+#define DISP_CC_MDSS_DPTX1_LINK_INTF_CLK			28
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK				29
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC			30
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK				31
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC			32
+#define DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK		33
+#define DISP_CC_MDSS_DPTX2_AUX_CLK				34
+#define DISP_CC_MDSS_DPTX2_AUX_CLK_SRC				35
+#define DISP_CC_MDSS_DPTX2_LINK_CLK				36
+#define DISP_CC_MDSS_DPTX2_LINK_CLK_SRC				37
+#define DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC			38
+#define DISP_CC_MDSS_DPTX2_LINK_INTF_CLK			39
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK				40
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC			41
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK				42
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC			43
+#define DISP_CC_MDSS_DPTX2_USB_ROUTER_LINK_INTF_CLK		44
+#define DISP_CC_MDSS_DPTX3_AUX_CLK				45
+#define DISP_CC_MDSS_DPTX3_AUX_CLK_SRC				46
+#define DISP_CC_MDSS_DPTX3_LINK_CLK				47
+#define DISP_CC_MDSS_DPTX3_LINK_CLK_SRC				48
+#define DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC			49
+#define DISP_CC_MDSS_DPTX3_LINK_INTF_CLK			50
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK				51
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC			52
+#define DISP_CC_MDSS_ESC0_CLK					53
+#define DISP_CC_MDSS_ESC0_CLK_SRC				54
+#define DISP_CC_MDSS_ESC1_CLK					55
+#define DISP_CC_MDSS_ESC1_CLK_SRC				56
+#define DISP_CC_MDSS_MDP1_CLK					57
+#define DISP_CC_MDSS_MDP_CLK					58
+#define DISP_CC_MDSS_MDP_CLK_SRC				59
+#define DISP_CC_MDSS_MDP_LUT1_CLK				60
+#define DISP_CC_MDSS_MDP_LUT_CLK				61
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK				62
+#define DISP_CC_MDSS_PCLK0_CLK					63
+#define DISP_CC_MDSS_PCLK0_CLK_SRC				64
+#define DISP_CC_MDSS_PCLK1_CLK					65
+#define DISP_CC_MDSS_PCLK1_CLK_SRC				66
+#define DISP_CC_MDSS_RSCC_AHB_CLK				67
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK				68
+#define DISP_CC_MDSS_VSYNC1_CLK					69
+#define DISP_CC_MDSS_VSYNC_CLK					70
+#define DISP_CC_MDSS_VSYNC_CLK_SRC				71
+#define DISP_CC_PLL0						72
+#define DISP_CC_PLL1						73
+#define DISP_CC_SLEEP_CLK					74
+#define DISP_CC_SLEEP_CLK_SRC					75
+#define DISP_CC_XO_CLK						76
+#define DISP_CC_XO_CLK_SRC					77
+
+/* DISP_CC resets */
+#define DISP_CC_MDSS_CORE_BCR					0
+#define DISP_CC_MDSS_CORE_INT2_BCR				1
+#define DISP_CC_MDSS_RSCC_BCR					2
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC						0
+#define MDSS_INT2_GDSC						1
+
+#endif

-- 
2.34.1


