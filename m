Return-Path: <linux-kernel+bounces-116910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E1088B071
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329D6C06DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4C819D1D6;
	Mon, 25 Mar 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqZzTyzl"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEDA15219A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365000; cv=none; b=gN5cei4u8k0LJ/j5r2Lz834bkXErrrqBgzuF4DZq5Q15vGwXPFXuCyGgbg5i6neJvoCtzIugWZrdZx9CjjOOVvl0IVuGh+dXS1m7hAtn5fck50UMijksMHdrvflZ8S66pHgHFhLRGdvQzKTGwAhEeu8vFdMTql5MuPAq5RtmBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365000; c=relaxed/simple;
	bh=hnsfiSsJKInr4JylyhW7C8X4DcUP5JxEtf5koT8x+g4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLByP7zAPbWk7hnv7rXu3EC8yYAPDJE7ngl9cNUgNIJM4I7MQ+2V/iEf00uG0dqLIBV+6SZt+PBieugZ1ep1v8PxeycCz2av69F57j1biJMzxzr/Fx5q1BdDbjQPQFLBzse1M2x7baqgDzkmsUwR3Ka60A6bkcWy5SEIgnmeoyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OqZzTyzl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c01c2e124so1714410a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711364997; x=1711969797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkiDF6CyURpbjnTnlPpjl05T1hEzDiWol01BVqEjgn0=;
        b=OqZzTyzlPSDtrzS3A8kWEfX6hk/0mDanMqjsH2PiWAy7ljlnwKtWbRD4ZasB+gcKy5
         kewhrY1qAlOsG4PNv7yAtPft68jdP0vDR/Zncm+mbpgLtbq7lhTaCJbNIm22ONOM9Sdk
         TQb0sNTBrYZK4UHvVLxLLRpjPp0PStybYNaG86PXgTIdbCk+pLhCAfAXDQnSo6131hU+
         dZT9Up7MeMl/UdE93KLsJ8KqJNwDEqSbAjZNy9U/4LlivVkzJ/Sq+2wXKNUQNtO0kh55
         s1uoiSOjh8UHo/h+iSPLruL18ZrMMlkPfdQmilYIG4IDJSCCajGwXwKH6vCDqkNxvfvA
         nXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364997; x=1711969797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkiDF6CyURpbjnTnlPpjl05T1hEzDiWol01BVqEjgn0=;
        b=gAEfL7IjDClMVPhICgu9SmMgTGD4OQdNxF1bKPNU3Q0YA5e2o+iNUrR8+//F2n43lW
         Bo2d9eTv1CrKdyk6ZG94DDDLqo/aWH/gn5zIiGL0BZH00AFLww0xcXEXq+6FUnZZ/OJq
         /Zoinx2etctRsrz3E/jCJZK8aNe3k8nKckyUWOv4mR3CZsm+iIuMFxB1q5haVPoBms0x
         LRbm4nLyEZqrJqewnIKjYK3kqQokRZWOEI8NFk+4eSBR2k/Bew+wquLY/gEodB1r0IqD
         /7IZcVLOkKGyQa1IZblgmdj13pJfw6cwHV2a3kMnmuz+TECi5Oge2AehT9betLv7vBqw
         Oc6g==
X-Forwarded-Encrypted: i=1; AJvYcCXjE4VZfgMJKQhiS4N94ap0uZpIOQh642WKKtM4acZgXIi4Oib1v4LxK5/EZBeEHJntKvDTdcxChME19CHOm9UnNi4ANPmiN/sk6q6/
X-Gm-Message-State: AOJu0YxnhDLI7S0kVoX2rmqxO7nE7S454MJICzD8Lmb340FxdhXDUo80
	KXidL8s39TPi+QhXcDnQoKsXRqaTSvknvZzBPJV8w6uwsQGSE9DePjLvNFrk+QAmpGGplRn9HP0
	aEaHbTg==
X-Google-Smtp-Source: AGHT+IH9TSrIC7QtJmG03uKPHI/ELP1eaER4qsSJYwbOZWNokRrIEfgYq/tcfovPtsZPYh42Ua+sNg==
X-Received: by 2002:a17:906:94e:b0:a46:b4c7:341c with SMTP id j14-20020a170906094e00b00a46b4c7341cmr4381705ejd.58.1711364996940;
        Mon, 25 Mar 2024 04:09:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id bw26-20020a170906c1da00b00a4650ec48d0sm2972367ejb.140.2024.03.25.04.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:09:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Mar 2024 12:09:49 +0100
Subject: [PATCH v11 3/7] clk: meson: g12a: make VCLK2 and ENCL clock path
 configurable by CCF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-3-04f55de44604@linaro.org>
References: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-0-04f55de44604@linaro.org>
In-Reply-To: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-0-04f55de44604@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Nicolas Belin <nbelin@baylibre.com>, 
 Jagan Teki <jagan@amarulasolutions.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8195;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hnsfiSsJKInr4JylyhW7C8X4DcUP5JxEtf5koT8x+g4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmAVt9/A/6HByhZ4Me2YdPSbrWA7xwKr5A8fgQaIsI
 3xfHXWKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgFbfQAKCRB33NvayMhJ0eknEA
 DL1fA1oGxXTuOcm2I7RkRz5exbQYM/tbnx0isdM53QjxzMylI8nV5lKJoIN3/hgV/Nr9VR48YeDmw0
 VoYtLei4XZKjoqZks4k/zbr6IYyvHFlDep/eNtkqKMEQQD7efb6PWikhkcIWqghdWbhpJ0X+2LdoS4
 7pfXjiSZvDUJ1p71+ySAkSStVcvFfUI+aI1+2RMgf+OoJQgGDc6M2BhzS8N/aSgN78rDGwKAFV8gQM
 XmHLvKIcK+G+qVNvTiMiC35TqUejT6J4olAm9euh9RM6K36GkIfL3p+sisaxwpTV4H+2YPYcQRbaoT
 1j0NBXfF6GVtnuf3ovWOcAY94lKnYLGPZwp49VqmauVrEd6PCpoyd/ToQR3udo4o9kIq0v90oQq5pS
 ZX0sZ5zgeelWGWi5H+shGtj9zdMUHNJSoXxf/I2t0LySBkASh2iKMB+2CPjJsNzrXuTkOd/QTGiLq+
 J84JEyELVcwD/JYiP4Nz3Fex7hURDQ6hEjAFP4DbdZqHeoL4S5GzMrsv1kyhzn8/n+N4iy2mOl8vT2
 N+Av03kUON/yNrsYSZmDTG+FmC2iQ7CkUuQqOqDAsH0rgtBMz9hT09kMosRaB0jztO0l9pYFr3hBV0
 2Tl/RKBODngA0k6xakLKjJyIeygzVvaehfkP1tAGVg+3RbjdFDzujeUQdxbw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

In order to setup the DSI clock, let's make the unused VCLK2 clock path
configuration via CCF.

The nocache option is removed from following clocks:
- vclk2_sel
- vclk2_input
- vclk2_div
- vclk2
- vclk_div1
- vclk2_div2_en
- vclk2_div4_en
- vclk2_div6_en
- vclk2_div12_en
- vclk2_div2
- vclk2_div4
- vclk2_div6
- vclk2_div12
- cts_encl_sel

vclk2 and vclk2_div uses the newly introduced vclk regmap driver
to handle the enable and reset bits.

In order to set a rate on cts_encl via the vclk2 clock path,
the NO_REPARENT flag is set on cts_encl_sel & vclk2_sel in order
to keep CCF from selection a parent.
The parents of cts_encl_sel & vclk2_sel are expected to be defined
in DT or manually set by the display driver at some point.

The following clock scheme is to be used for DSI:

xtal
\_ gp0_pll_dco
   \_ gp0_pll
      |- vclk2_sel
      |  \_ vclk2_input
      |     \_ vclk2_div
      |        \_ vclk2
      |           \_ vclk2_div1
      |              \_ cts_encl_sel
      |                 \_ cts_encl	-> to VPU LCD Encoder
      |- mipi_dsi_pxclk_sel
      \_ mipi_dsi_pxclk_div
         \_ mipi_dsi_pxclk		-> to DSI controller

The mipi_dsi_pxclk_div is set as bypass with a single /1 entry in div_table
in order to use the same GP0 for mipi_dsi_pxclk and vclk2_input.

The SET_RATE_PARENT is only set on the mipi_dsi_pxclk_sel clock so the
DSI bitclock is the reference base clock to calculate the vclk2_div value
when pixel clock is set on the cts_encl endpoint.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/Kconfig |  1 +
 drivers/clk/meson/g12a.c  | 72 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 8a9823789fa3..59a40a49f8e1 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -144,6 +144,7 @@ config COMMON_CLK_G12A
 	select COMMON_CLK_MESON_EE_CLKC
 	select COMMON_CLK_MESON_CPU_DYNDIV
 	select COMMON_CLK_MESON_VID_PLL_DIV
+	select COMMON_CLK_MESON_VCLK
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 90f4c6103014..083882e53b65 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -22,6 +22,7 @@
 #include "clk-regmap.h"
 #include "clk-cpu-dyndiv.h"
 #include "vid-pll-div.h"
+#include "vclk.h"
 #include "meson-eeclk.h"
 #include "g12a.h"
 
@@ -3165,7 +3166,7 @@ static struct clk_regmap g12a_vclk2_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = g12a_vclk_parent_hws,
 		.num_parents = ARRAY_SIZE(g12a_vclk_parent_hws),
-		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+		.flags = CLK_SET_RATE_NO_REPARENT,
 	},
 };
 
@@ -3193,7 +3194,6 @@ static struct clk_regmap g12a_vclk2_input = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_sel.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 	},
 };
 
@@ -3215,19 +3215,32 @@ static struct clk_regmap g12a_vclk_div = {
 };
 
 static struct clk_regmap g12a_vclk2_div = {
-	.data = &(struct clk_regmap_div_data){
-		.offset = HHI_VIID_CLK_DIV,
-		.shift = 0,
-		.width = 8,
+	.data = &(struct meson_vclk_div_data){
+		.div = {
+			.reg_off = HHI_VIID_CLK_DIV,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.enable = {
+			.reg_off = HHI_VIID_CLK_DIV,
+			.shift   = 16,
+			.width   = 1,
+		},
+		.reset = {
+			.reg_off = HHI_VIID_CLK_DIV,
+			.shift   = 17,
+			.width   = 1,
+		},
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk2_div",
-		.ops = &clk_regmap_divider_ops,
+		.ops = &meson_vclk_div_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12a_vclk2_input.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
+		.flags = CLK_SET_RATE_GATE,
 	},
 };
 
@@ -3246,16 +3259,24 @@ static struct clk_regmap g12a_vclk = {
 };
 
 static struct clk_regmap g12a_vclk2 = {
-	.data = &(struct clk_regmap_gate_data){
-		.offset = HHI_VIID_CLK_CNTL,
-		.bit_idx = 19,
+	.data = &(struct meson_vclk_gate_data){
+		.enable = {
+			.reg_off = HHI_VIID_CLK_CNTL,
+			.shift   = 19,
+			.width   = 1,
+		},
+		.reset = {
+			.reg_off = HHI_VIID_CLK_CNTL,
+			.shift   = 15,
+			.width   = 1,
+		},
 	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "vclk2",
-		.ops = &clk_regmap_gate_ops,
+		.ops = &meson_vclk_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_div.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3339,7 +3360,7 @@ static struct clk_regmap g12a_vclk2_div1 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3353,7 +3374,7 @@ static struct clk_regmap g12a_vclk2_div2_en = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3367,7 +3388,7 @@ static struct clk_regmap g12a_vclk2_div4_en = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3381,7 +3402,7 @@ static struct clk_regmap g12a_vclk2_div6_en = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3395,7 +3416,7 @@ static struct clk_regmap g12a_vclk2_div12_en = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3461,6 +3482,7 @@ static struct clk_fixed_factor g12a_vclk2_div2 = {
 			&g12a_vclk2_div2_en.hw
 		},
 		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3474,6 +3496,7 @@ static struct clk_fixed_factor g12a_vclk2_div4 = {
 			&g12a_vclk2_div4_en.hw
 		},
 		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3487,6 +3510,7 @@ static struct clk_fixed_factor g12a_vclk2_div6 = {
 			&g12a_vclk2_div6_en.hw
 		},
 		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3500,6 +3524,7 @@ static struct clk_fixed_factor g12a_vclk2_div12 = {
 			&g12a_vclk2_div12_en.hw
 		},
 		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3561,7 +3586,7 @@ static struct clk_regmap g12a_cts_encl_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = g12a_cts_parent_hws,
 		.num_parents = ARRAY_SIZE(g12a_cts_parent_hws),
-		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 	},
 };
 
@@ -3717,15 +3742,22 @@ static struct clk_regmap g12a_mipi_dsi_pxclk_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = g12a_mipi_dsi_pxclk_parent_hws,
 		.num_parents = ARRAY_SIZE(g12a_mipi_dsi_pxclk_parent_hws),
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
 	},
 };
 
+/* Force as bypass by forcing a single /1 table entry, and not rely of boot value */
+static const struct clk_div_table g12a_mipi_dsi_pxclk_div_table[] = {
+	{ .val = 0, .div = 1 },
+	{ /* sentinel */ },
+};
+
 static struct clk_regmap g12a_mipi_dsi_pxclk_div = {
 	.data = &(struct clk_regmap_div_data){
 		.offset = HHI_MIPIDSI_PHY_CLK_CNTL,
 		.shift = 0,
 		.width = 7,
+		.table = g12a_mipi_dsi_pxclk_div_table,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mipi_dsi_pxclk_div",

-- 
2.34.1


