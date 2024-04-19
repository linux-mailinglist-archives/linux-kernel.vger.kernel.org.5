Return-Path: <linux-kernel+bounces-151441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE6F8AAF04
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76C7283C07
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC5F12D1F6;
	Fri, 19 Apr 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="IpyHiG4E"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813408595F;
	Fri, 19 Apr 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713531639; cv=none; b=rcsQXcOoTDT4Hy00wV9QmtJy52fltGmlDGISK95LFee0OQYs8Bc3bIml+DbbNq+GoUojcmWozH4pJ3t/72h9V5XgiTUwEqD1VfYikyq/KxudHlgxjjWVtsLM035EJgZBKveNji483+bhfM4Kx8QzVgrqKLG/SvJ7+opsmsWnGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713531639; c=relaxed/simple;
	bh=9bxe72JpCFMQ24vxi/QOpLvZW6NAkRsRl03i3boZSgk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6pGmkVcdwbNjtrcc4dEXHG/jBnTGk32cK4i2TuqkxWWQCFMmvkKkIO9dyIXH28c+Smq7ygv30SofhVdCXQG1iAEC7Vmy9rrNSLMYV0fSxn4OHUJILZSsj+84MdUgCuwGXgpb1OctrkIGqhG21kcCze+PLi7abqh2EH4+xY92EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=IpyHiG4E; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A2AB1120008;
	Fri, 19 Apr 2024 16:00:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A2AB1120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713531627;
	bh=rhiBm6kx67P2OaOpLZaHQSe0pYlnbV4Cwe1bDHuVQOs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=IpyHiG4ESE9cVeiyF3VbbFrsIDZM6v1rbk1UpEP4lYiW+4e1y0ppCgm2C35FRNu1z
	 ssm6ZBqZqH+3vs6CpGwS8Uo1c1k74RdGlFQTkVD1tM7m6Rz3ioPCO5UWqHIBNmHO5f
	 awKTe5JH38JVDWfAoLwRypBb/DxMnfOjIhkLDq69VY9Q5KnWb96UX/8UMYtSyQN/GW
	 pdq1ywUiBhAWO7pWeFQoMkGjxib0JSDzB7ET1phflfqZq2p3FRDRE8PHECVhu6Nv2z
	 KrGtAEmqui8tE2UPAPGbtVh5NUIDOq6QANhEqcs6PKYRLzxi1LhHIJsU45OEX9wnLF
	 +O4X36YeimOEw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 19 Apr 2024 16:00:27 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Apr 2024 16:00:27 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH v3 2/6] clk: meson: axg: share the set of audio helper macro
Date: Fri, 19 Apr 2024 15:58:08 +0300
Message-ID: <20240419125812.983409-3-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
References: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184806 [Apr 19 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_smtp_not_equal_from}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/18 23:49:00 #24865988
X-KSMG-AntiVirus-Status: Clean, skipped

These macro will be used in upcoming audio clock controller
for Meson A1 SoC.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/clk/meson/axg-audio.c   | 138 +-----------------------------
 drivers/clk/meson/meson-audio.h | 143 ++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 137 deletions(-)
 create mode 100644 drivers/clk/meson/meson-audio.h

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 9cd6b5c3aa7e..ee0698bf4383 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -17,6 +17,7 @@
 #include <soc/amlogic/meson-audio-reset.h>
 
 #include "meson-clkc-utils.h"
+#include "meson-audio.h"
 #include "axg-audio.h"
 #include "clk-regmap.h"
 #include "clk-phase.h"
@@ -24,52 +25,6 @@
 
 #include <dt-bindings/clock/axg-audio-clkc.h>
 
-#define AUD_GATE(_name, _reg, _bit, _pname, _iflags) {			\
-	.data = &(struct clk_regmap_gate_data){				\
-		.offset = (_reg),					\
-		.bit_idx = (_bit),					\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = "aud_"#_name,					\
-		.ops = &clk_regmap_gate_ops,				\
-		.parent_names = (const char *[]){ #_pname },		\
-		.num_parents = 1,					\
-		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
-	},								\
-}
-
-#define AUD_MUX(_name, _reg, _mask, _shift, _dflags, _pdata, _iflags) {	\
-	.data = &(struct clk_regmap_mux_data){				\
-		.offset = (_reg),					\
-		.mask = (_mask),					\
-		.shift = (_shift),					\
-		.flags = (_dflags),					\
-	},								\
-	.hw.init = &(struct clk_init_data){				\
-		.name = "aud_"#_name,					\
-		.ops = &clk_regmap_mux_ops,				\
-		.parent_data = _pdata,					\
-		.num_parents = ARRAY_SIZE(_pdata),			\
-		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
-	},								\
-}
-
-#define AUD_DIV(_name, _reg, _shift, _width, _dflags, _pname, _iflags) { \
-	.data = &(struct clk_regmap_div_data){				\
-		.offset = (_reg),					\
-		.shift = (_shift),					\
-		.width = (_width),					\
-		.flags = (_dflags),					\
-	},								\
-	.hw.init = &(struct clk_init_data){				\
-		.name = "aud_"#_name,					\
-		.ops = &clk_regmap_divider_ops,				\
-		.parent_names = (const char *[]){ #_pname },		\
-		.num_parents = 1,					\
-		.flags = (_iflags),					\
-	},								\
-}
-
 #define AUD_PCLK_GATE(_name, _reg, _bit) {				\
 	.data = &(struct clk_regmap_gate_data){				\
 		.offset = (_reg),					\
@@ -83,97 +38,6 @@
 	},								\
 }
 
-#define AUD_SCLK_DIV(_name, _reg, _div_shift, _div_width,		\
-		     _hi_shift, _hi_width, _pname, _iflags) {		\
-	.data = &(struct meson_sclk_div_data) {				\
-		.div = {						\
-			.reg_off = (_reg),				\
-			.shift   = (_div_shift),			\
-			.width   = (_div_width),			\
-		},							\
-		.hi = {							\
-			.reg_off = (_reg),				\
-			.shift   = (_hi_shift),				\
-			.width   = (_hi_width),				\
-		},							\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = "aud_"#_name,					\
-		.ops = &meson_sclk_div_ops,				\
-		.parent_names = (const char *[]){ #_pname },		\
-		.num_parents = 1,					\
-		.flags = (_iflags),					\
-	},								\
-}
-
-#define AUD_TRIPHASE(_name, _reg, _width, _shift0, _shift1, _shift2,	\
-		     _pname, _iflags) {					\
-	.data = &(struct meson_clk_triphase_data) {			\
-		.ph0 = {						\
-			.reg_off = (_reg),				\
-			.shift   = (_shift0),				\
-			.width   = (_width),				\
-		},							\
-		.ph1 = {						\
-			.reg_off = (_reg),				\
-			.shift   = (_shift1),				\
-			.width   = (_width),				\
-		},							\
-		.ph2 = {						\
-			.reg_off = (_reg),				\
-			.shift   = (_shift2),				\
-			.width   = (_width),				\
-		},							\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = "aud_"#_name,					\
-		.ops = &meson_clk_triphase_ops,				\
-		.parent_names = (const char *[]){ #_pname },		\
-		.num_parents = 1,					\
-		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
-	},								\
-}
-
-#define AUD_PHASE(_name, _reg, _width, _shift, _pname, _iflags) {	\
-	.data = &(struct meson_clk_phase_data) {			\
-		.ph = {							\
-			.reg_off = (_reg),				\
-			.shift   = (_shift),				\
-			.width   = (_width),				\
-		},							\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = "aud_"#_name,					\
-		.ops = &meson_clk_phase_ops,				\
-		.parent_names = (const char *[]){ #_pname },		\
-		.num_parents = 1,					\
-		.flags = (_iflags),					\
-	},								\
-}
-
-#define AUD_SCLK_WS(_name, _reg, _width, _shift_ph, _shift_ws, _pname,	\
-		    _iflags) {						\
-	.data = &(struct meson_sclk_ws_inv_data) {			\
-		.ph = {							\
-			.reg_off = (_reg),				\
-			.shift   = (_shift_ph),				\
-			.width   = (_width),				\
-		},							\
-		.ws = {							\
-			.reg_off = (_reg),				\
-			.shift   = (_shift_ws),				\
-			.width   = (_width),				\
-		},							\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = "aud_"#_name,					\
-		.ops = &meson_clk_phase_ops,				\
-		.parent_names = (const char *[]){ #_pname },		\
-		.num_parents = 1,					\
-		.flags = (_iflags),					\
-	},								\
-}
-
 /* Audio Master Clocks */
 static const struct clk_parent_data mst_mux_parent_data[] = {
 	{ .fw_name = "mst_in0", },
diff --git a/drivers/clk/meson/meson-audio.h b/drivers/clk/meson/meson-audio.h
new file mode 100644
index 000000000000..cbcdbd487d4a
--- /dev/null
+++ b/drivers/clk/meson/meson-audio.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+
+#ifndef __MESON_AUDIO_H__
+#define __MESON_AUDIO_H__
+
+#define AUD_GATE(_name, _reg, _bit, _pname, _iflags) {			\
+	.data = &(struct clk_regmap_gate_data){				\
+		.offset = (_reg),					\
+		.bit_idx = (_bit),					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = "aud_"#_name,					\
+		.ops = &clk_regmap_gate_ops,				\
+		.parent_names = (const char *[]){ #_pname },		\
+		.num_parents = 1,					\
+		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
+	},								\
+}
+
+#define AUD_MUX(_name, _reg, _mask, _shift, _dflags, _pdata, _iflags) {	\
+	.data = &(struct clk_regmap_mux_data){				\
+		.offset = (_reg),					\
+		.mask = (_mask),					\
+		.shift = (_shift),					\
+		.flags = (_dflags),					\
+	},								\
+	.hw.init = &(struct clk_init_data){				\
+		.name = "aud_"#_name,					\
+		.ops = &clk_regmap_mux_ops,				\
+		.parent_data = _pdata,					\
+		.num_parents = ARRAY_SIZE(_pdata),			\
+		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
+	},								\
+}
+
+#define AUD_DIV(_name, _reg, _shift, _width, _dflags, _pname, _iflags) { \
+	.data = &(struct clk_regmap_div_data){				\
+		.offset = (_reg),					\
+		.shift = (_shift),					\
+		.width = (_width),					\
+		.flags = (_dflags),					\
+	},								\
+	.hw.init = &(struct clk_init_data){				\
+		.name = "aud_"#_name,					\
+		.ops = &clk_regmap_divider_ops,				\
+		.parent_names = (const char *[]){ #_pname },		\
+		.num_parents = 1,					\
+		.flags = (_iflags),					\
+	},								\
+}
+
+#define AUD_SCLK_DIV(_name, _reg, _div_shift, _div_width,		\
+		     _hi_shift, _hi_width, _pname, _iflags) {		\
+	.data = &(struct meson_sclk_div_data) {				\
+		.div = {						\
+			.reg_off = (_reg),				\
+			.shift   = (_div_shift),			\
+			.width   = (_div_width),			\
+		},							\
+		.hi = {							\
+			.reg_off = (_reg),				\
+			.shift   = (_hi_shift),				\
+			.width   = (_hi_width),				\
+		},							\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = "aud_"#_name,					\
+		.ops = &meson_sclk_div_ops,				\
+		.parent_names = (const char *[]){ #_pname },		\
+		.num_parents = 1,					\
+		.flags = (_iflags),					\
+	},								\
+}
+
+#define AUD_TRIPHASE(_name, _reg, _width, _shift0, _shift1, _shift2,	\
+		     _pname, _iflags) {					\
+	.data = &(struct meson_clk_triphase_data) {			\
+		.ph0 = {						\
+			.reg_off = (_reg),				\
+			.shift   = (_shift0),				\
+			.width   = (_width),				\
+		},							\
+		.ph1 = {						\
+			.reg_off = (_reg),				\
+			.shift   = (_shift1),				\
+			.width   = (_width),				\
+		},							\
+		.ph2 = {						\
+			.reg_off = (_reg),				\
+			.shift   = (_shift2),				\
+			.width   = (_width),				\
+		},							\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = "aud_"#_name,					\
+		.ops = &meson_clk_triphase_ops,				\
+		.parent_names = (const char *[]){ #_pname },		\
+		.num_parents = 1,					\
+		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
+	},								\
+}
+
+#define AUD_PHASE(_name, _reg, _width, _shift, _pname, _iflags) {	\
+	.data = &(struct meson_clk_phase_data) {			\
+		.ph = {							\
+			.reg_off = (_reg),				\
+			.shift   = (_shift),				\
+			.width   = (_width),				\
+		},							\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = "aud_"#_name,					\
+		.ops = &meson_clk_phase_ops,				\
+		.parent_names = (const char *[]){ #_pname },		\
+		.num_parents = 1,					\
+		.flags = (_iflags),					\
+	},								\
+}
+
+#define AUD_SCLK_WS(_name, _reg, _width, _shift_ph, _shift_ws, _pname,	\
+		    _iflags) {						\
+	.data = &(struct meson_sclk_ws_inv_data) {			\
+		.ph = {							\
+			.reg_off = (_reg),				\
+			.shift   = (_shift_ph),				\
+			.width   = (_width),				\
+		},							\
+		.ws = {							\
+			.reg_off = (_reg),				\
+			.shift   = (_shift_ws),				\
+			.width   = (_width),				\
+		},							\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = "aud_"#_name,					\
+		.ops = &meson_clk_phase_ops,				\
+		.parent_names = (const char *[]){ #_pname },		\
+		.num_parents = 1,					\
+		.flags = (_iflags),					\
+	},								\
+}
+
+#endif /* __MESON_AUDIO_H__ */
-- 
2.34.1


