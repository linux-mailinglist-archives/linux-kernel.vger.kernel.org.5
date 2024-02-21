Return-Path: <linux-kernel+bounces-74975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC4285E0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A144A1C22035
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDEF80BE0;
	Wed, 21 Feb 2024 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yYxDp5ff"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018EA80034
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528334; cv=none; b=YD2kFZOUH5vKojGY2Rw+szqkhdZdE3LYkWluKGbuWTBAUjSBgqK+mL3HIA9rYi4tZ3iXOsZBG1ZJ2yWuY8eT+wdEE8sq6NlI03xhfQ404izH/ReobWX/c49X+pkakAGHXNU44KS+2ZGzGK/U/cLxR8kjw1H94EhH7xrFaCq7KTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528334; c=relaxed/simple;
	bh=ruExk+3EVLbRjE0gQXVzGZ8dGRhGxHdE9Mjc5UHJiCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pB+wH7cMzI9Zk6Ow5XlR91JWp1tY52zBKOs2k4BI+k5D8N9+uKJPJ2tLMXAn92XPC/EcvGdHLNpZRiYx0dsuPIzPTxgA26dS8PxoKH8Lku2jgFLyUz8ZQr20/iNecKfFx6hUuhjR5zp8Cp5ZpzfT6kAVUJCcSInBu5fVBIZ1w88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yYxDp5ff; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4127706e48cso4533275e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708528330; x=1709133130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phRSbqPQtjTITh3A7Rz+mg0BFNfzjESlEJDyy2/XwFI=;
        b=yYxDp5ff4Hqy+ezd2nJg8Ja09q2SVxpsFpm3ZodcV1MCjrXQWiG/BlcmS+kXYinUd+
         Lmf8yr3x32VnzuOPx+jRXwQ9d4GJ9AbgmTXDDz5E9AFBi9oFkPnS187i3mvR1zr25Fp+
         hsDYetOHPEKQsVeNydjKnpfHG7QXdKHDl7WUrmKzUJxmXby1dORC/kkSfjexieoSw98T
         dD6oYOkG7xRgB+OnT4wMNgFLRmYqglw+8LxTj7fb+tOO1o2/oTAKeWxRnmSJ4DuZIreX
         xYdwV/2+JORlgXxg7Y6ES9oQc1T7s1Um2v2s57uIxgr6i/20xKNnwgPFqzMQ+74PJlsU
         kv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528330; x=1709133130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phRSbqPQtjTITh3A7Rz+mg0BFNfzjESlEJDyy2/XwFI=;
        b=oNeAVXtH5lR8/qN1P3dlXucNDl1L8H94+W8YyvBqGv426dR6TqV/j2AaPlFZChdWFx
         yAWfKO9HD0h2m2f1o4cs7C8BGUhT5nokUXcH0HOPdIxxFQaDoSsaTR6l0kK2eowKcOxJ
         xYvQQpGuZO2n5PiXsJXR3eOUbIE0uiDancWkuPk21QlpAq9DlN0LDEYYkj4nrRRUhGk/
         H5hb+7jgX7VvXwP9KIyHPEX7gD3IO1zRMDRfAWqk7pMKNzTHi7EVXeqamgovgbkh0t/G
         om+se1I9BnFiPzOBfeKG9ElJ7wgSefgCSqxRCp4qkK7Tc9Z1vemaVFO5UMF7rfvLjKOJ
         jWTw==
X-Forwarded-Encrypted: i=1; AJvYcCUhrborQEW3v9RHnT9tFIZ38XQFnTv20DUNiFWPwiDBTS8jjvb4PRpZVQwL1cNz/F/hdeW1eGIbHcJmrXgwCx90S87yl8wEgG7t++Wg
X-Gm-Message-State: AOJu0YxwOtOi87J+521oQ8LXkG6UKPhYSxhSAz85QIVESBtV8sqn20K1
	Qgp+qXWKLlDFp9+uLW9CZj1GP28J3Ka6kCJkLf/A5ZoXYg1jpj5Di1Y4wblBxxo=
X-Google-Smtp-Source: AGHT+IEeRU4MfkeafbqILY5kXFWxrlUsTufKp1YAOEcBHiEhDE6BI4BT3nlSA0stwDgg/5oJv/ywgw==
X-Received: by 2002:a05:600c:4747:b0:412:71af:8af5 with SMTP id w7-20020a05600c474700b0041271af8af5mr2971550wmo.16.1708528330296;
        Wed, 21 Feb 2024 07:12:10 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1b1a:d907:d735:9f9e])
        by smtp.googlemail.com with ESMTPSA id bg22-20020a05600c3c9600b0040fc56712e8sm18725342wmb.17.2024.02.21.07.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:12:09 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH v5 3/5] pwm: meson: generalize 4 inputs clock on meson8 pwm type
Date: Wed, 21 Feb 2024 16:11:49 +0100
Message-ID: <20240221151154.26452-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221151154.26452-1-jbrunet@baylibre.com>
References: <20240221151154.26452-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Meson8 pwm type always has 4 input clocks. Some inputs may be grounded,
like in the AO domain of some SoCs.

Drop the parent number parameter and make this is constant.
This is also done to make the addition of generic meson8 compatible easier.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 53 +++++++++--------------------------------
 1 file changed, 11 insertions(+), 42 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 40a5b64c26f5..a02fdbc61256 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -60,7 +60,7 @@
 #define MISC_A_EN		BIT(0)
 
 #define MESON_NUM_PWMS		2
-#define MESON_MAX_MUX_PARENTS	4
+#define MESON_NUM_MUX_PARENTS	4
 
 static struct meson_pwm_channel_data {
 	u8		reg_offset;
@@ -97,8 +97,7 @@ struct meson_pwm_channel {
 };
 
 struct meson_pwm_data {
-	const char * const *parent_names;
-	unsigned int num_parents;
+	const char *const parent_names[MESON_NUM_MUX_PARENTS];
 };
 
 struct meson_pwm {
@@ -339,62 +338,32 @@ static const struct pwm_ops meson_pwm_ops = {
 	.get_state = meson_pwm_get_state,
 };
 
-static const char * const pwm_meson8b_parent_names[] = {
-	"xtal", NULL, "fclk_div4", "fclk_div3"
-};
-
 static const struct meson_pwm_data pwm_meson8b_data = {
-	.parent_names = pwm_meson8b_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_meson8b_parent_names),
+	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
 };
 
 /*
  * Only the 2 first inputs of the GXBB AO PWMs are valid
  * The last 2 are grounded
  */
-static const char * const pwm_gxbb_ao_parent_names[] = {
-	"xtal", "clk81"
-};
-
 static const struct meson_pwm_data pwm_gxbb_ao_data = {
-	.parent_names = pwm_gxbb_ao_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_gxbb_ao_parent_names),
-};
-
-static const char * const pwm_axg_ee_parent_names[] = {
-	"xtal", "fclk_div5", "fclk_div4", "fclk_div3"
+	.parent_names = { "xtal", "clk81", NULL, NULL },
 };
 
 static const struct meson_pwm_data pwm_axg_ee_data = {
-	.parent_names = pwm_axg_ee_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_axg_ee_parent_names),
-};
-
-static const char * const pwm_axg_ao_parent_names[] = {
-	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
+	.parent_names = { "xtal", "fclk_div5", "fclk_div4", "fclk_div3" },
 };
 
 static const struct meson_pwm_data pwm_axg_ao_data = {
-	.parent_names = pwm_axg_ao_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
-};
-
-static const char * const pwm_g12a_ao_ab_parent_names[] = {
-	"xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5"
+	.parent_names = { "xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5" },
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
-	.parent_names = pwm_g12a_ao_ab_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_g12a_ao_ab_parent_names),
-};
-
-static const char * const pwm_g12a_ao_cd_parent_names[] = {
-	"xtal", "g12a_ao_clk81",
+	.parent_names = { "xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5" },
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
-	.parent_names = pwm_g12a_ao_cd_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
+	.parent_names = { "xtal", "g12a_ao_clk81", NULL, NULL },
 };
 
 static const struct of_device_id meson_pwm_matches[] = {
@@ -437,13 +406,13 @@ MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 static int meson_pwm_init_channels(struct pwm_chip *chip)
 {
 	struct meson_pwm *meson = to_meson_pwm(chip);
-	struct clk_parent_data mux_parent_data[MESON_MAX_MUX_PARENTS] = {};
+	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
 	struct device *dev = pwmchip_parent(chip);
 	unsigned int i;
 	char name[255];
 	int err;
 
-	for (i = 0; i < meson->data->num_parents; i++) {
+	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++) {
 		mux_parent_data[i].index = -1;
 		mux_parent_data[i].name = meson->data->parent_names[i];
 	}
@@ -459,7 +428,7 @@ static int meson_pwm_init_channels(struct pwm_chip *chip)
 		init.ops = &clk_mux_ops;
 		init.flags = 0;
 		init.parent_data = mux_parent_data;
-		init.num_parents = meson->data->num_parents;
+		init.num_parents = MESON_NUM_MUX_PARENTS;
 
 		channel->mux.reg = meson->base + REG_MISC_AB;
 		channel->mux.shift =
-- 
2.43.0


