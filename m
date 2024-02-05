Return-Path: <linux-kernel+bounces-53163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11584A187
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6BE1C22B79
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8608482F4;
	Mon,  5 Feb 2024 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqRnAlfZ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFDE47F77
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155745; cv=none; b=YlelJfTSDuojTlNCTu3SPZX7M4ZFwg0s7Kb9q8v1xf+YuSjUg15geplnhxwvb+mc72asFBqKbEp+NYoMdAUOeCmzPrpywTLsYwBcDbDUi9wNJFZZflmenLIvQHdz1EHkQemhrgEqXu1yNkM8tbLj61YT0Z6/v8nDAhUs4SECabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155745; c=relaxed/simple;
	bh=IE7LBQJSwmFpro9NRvngqeq31VcV/n9f72AsydUqbws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpHDt4/4E/i5n6+ehtgN2adTjEcLXM8hA5lJFxyeq2vLsB43ivBenqb3vc1D3xMUWJA3t9R7gD8nJmHNWeKz8lQLvxISKROTnNKTfy26B4oLvVG2Ie93Uh0WcdbrK+EKFVrDZ6EXiCuN5/hrM96wVZMbMEZiqctZxFyOq1MWr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aqRnAlfZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fc549ab9bso30253615e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707155741; x=1707760541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kTGO29vezq1Gc7J5O9OI72ko2OnA3sM69gX9LY6c8Y=;
        b=aqRnAlfZgeFva46/NVYcwhw8ttGC2IhyGzc0aSPSAOHvVpEKHJy92cl9l3LaDgHzhd
         rGEQ5IV8t6/KOezzZIvg/f+6lRALUy2i0udd4PKFvfwXlXl3W//GOHsSXBaySv/+srsS
         0RhouTja7BBRVN8BW7GyicG6SEXLgjGf0REEE/QXGHIa9RA20Wmq+HuF8Wv+N9q4Gwrg
         KoXsdCFR2ZANDXXVWzcO+QyaOx/fo0TJ6NIyWhw3vbzdagNoeGk3yyzKJ+xUEtnkYNvX
         AN/xGtu8iDraPkDbQ4ZM0rdIqMnGZv6gvrp3ef7yCgPoCU7+MH+7crGYAIv4XS4p2dA0
         S3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155741; x=1707760541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kTGO29vezq1Gc7J5O9OI72ko2OnA3sM69gX9LY6c8Y=;
        b=Td7fKms/UAO/mZs977sEh4Tjv96WYsyRKuDB0AYIl69SsAtFeB5iEvn05lGLqPOl16
         PHzQexW+KfZhahv7NWr5bfjsYczax3EVWHalQHqTdAPWA5rpe6Ib8T0qgKWZzTppwfmO
         aUgJseWAHXlNkbndQSy4WcHSrOXd8W5Lxx3bpM0dfbrylQdYarHNq8GBV+NQEuuaF0f4
         A6pzdHK+zddZA7V0she4Ug1BmyRttGDZMmoAaBDJG3I+Nks4zVlyd70/tLOXI83jQ+aX
         7Tl16Q5N/4750KIhgRnkMxW+42ddmW8nrjjDKeNYzMKF/f4v2W4mI8Jv7pSrLtO4RxC7
         9QWg==
X-Gm-Message-State: AOJu0YwsMCXZI+4n6lcuRzirzC64EyXg3PJ6zrInmcLlFiTk9FAJqWa/
	jsh0ikDPX3fj2Fp/m4WqOtgMu2e4cxYCI8uJgxC0tH3kmZE6HkCF3RD3HBFDYIU=
X-Google-Smtp-Source: AGHT+IFaTHgGhy9XHjQX3HZeB2JEULMM1CNBGC9GZqY1QPaVhgAIUfcH9PYMzLk1SOsavnXKC+2l+g==
X-Received: by 2002:a05:600c:1c02:b0:40e:f67d:d5f9 with SMTP id j2-20020a05600c1c0200b0040ef67dd5f9mr355270wms.4.1707155741431;
        Mon, 05 Feb 2024 09:55:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXv164Rb/MjNSq/GnHSz2slhbj77T70wXKz076hC/kAWvtWZyXcRewm4yYlOnItzMT+KxRBmLo7ILUP9U+uktRLSu+wywU9KC6I9zzfHukz82cZFIZUZ0crw8ZUQLUdif/0PUH1v/Qb7xyx9raAFJeQBvdGhsSAEQuLppe1OQlipq4cLsmGvgNgxdq6O4syZeQgHAk1oYfrgxgPSOv6U0IMrHoDO4z4FaP6pRhJJwc0+IuwTRG2tdTRBLFYGTqaAZHbvkXCcJV9iJM2BIqqDzVRr3JXV8SUx5pB3dSfC+BTyDbgb3OrFmBWNQ2S1qeRE46NRzyxELs3GKOBh4K4Kde2f/5uT53Fuvjl5E//8GSyjS17ZDGGOZ0xCZlmTEKiC70W+m1V0G0COaHLbxFN07SqoF3vVYXJVr7pCdMz0Bg1GcBWfYQ3OG6sYg9JME0mty+HDfaOmYI6jvMcOK5KC1wrfbRbbz8bp2W2zHr7gqnvm1H/yv0qMk5Q3/z0lD/rHaEug6HpQ0sQ4UfsRmI2Hsr53CRRGmqLlGd/ghhuXwq1wv/vG3totXQhuT6LjnIyvgo3hIzUgg5GuGo51DYrxCRsGItu036VgUcP+XNt/ECkupMwDKZEeC9NJto+neqOvG2rT9/p2XZEFTw9vxU+Qi9tLlhuqjrx6zMth+HAkv3Afxt8WV7yoz8SwLoz/VPd2WWBCjfAirKw+LxsrjxKUKjATCLvIljk7Q5Izh949D6C1Hmv9/UZC4stlAZvYiWw9Tg=
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ee8765901sm517556wmb.43.2024.02.05.09.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:55:40 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 05 Feb 2024 18:55:31 +0100
Subject: [PATCH v10 4/7] drm/meson: gate px_clk when setting rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-amlogic-v6-4-upstream-dsi-ccf-vim3-v10-4-dc06073d5330@linaro.org>
References: <20240205-amlogic-v6-4-upstream-dsi-ccf-vim3-v10-0-dc06073d5330@linaro.org>
In-Reply-To: <20240205-amlogic-v6-4-upstream-dsi-ccf-vim3-v10-0-dc06073d5330@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IE7LBQJSwmFpro9NRvngqeq31VcV/n9f72AsydUqbws=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlwSEVQAxTmc2Mi1THlqhQKITJhQ6jRe1YxMSAnbv+
 TbbdaV2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZcEhFQAKCRB33NvayMhJ0cLPD/
 4sXVqcu6M0soSWNW7qB/VG2yRyCqRZlP+HfhrykDyTg+9WG9KEwllxNUC87INl9I0/eYkJbB8tjfl7
 cGB4wluRZIubLWb7oiOlwQOaAM4R0iWsXe16E+SHd0OEEaHrAcfqMdyYyKTD0jgfduGlGfCkoHCB+m
 Hhk1itzbJkMbTvD2TumjnjJ/g70e7CeEt0ez9UN4eDF0rAzQgDxJ9NfUj4oHJhBNgPrWvIKl0++dtq
 Q3pD3gCFhQwuD2DrW4gTZQObKmAHrRFGBqBFhIYOk83pALZmm39fXAuu1KVP+yt46ISyJ84GizN/00
 BKgKW/bJDNL+z8HdbFv6YeWKSP8Ey90aTF6YGPvcGIOj9E1a/ot5iTS5rLdNchvObxeGgCR8jdmbGZ
 ZzEkHtPwEn9rsrCLxUfxXu8HvIi5QBXrKPZAIp3ASTYIcIIKQcBMY5XzqpXreRGGv7rdgLqhuAAbYk
 wktdeESe7TNgfMqSMR1s0in5cmnjEf+BmouAgSpZQ0VJ+Ltr5vBgeaPISg5Ekxp1DJt8W+loq0b+Nl
 W7M2QYAbyZgXjq2biY1pfNtGUOTNkZc42VmAKHwupT5XlPdbarqKluglNXmlZ0NLB6OLw1RTX0EvDv
 qHjPNMXksmy+zHdIIwm3XpX6OUN3/xAjYHtHASedXPRN++zX/U7UTDUuu+oA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Disable the px_clk when setting the rate to recover a fully
configured and correctly reset VCLK clock tree after the rate
is set.

Fixes: 77d9e1e6b846 ("drm/meson: add support for MIPI-DSI transceiver")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
index a6bc1bdb3d0d..a10cff3ca1fe 100644
--- a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
+++ b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
@@ -95,6 +95,7 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 		return ret;
 	}
 
+	clk_disable_unprepare(mipi_dsi->px_clk);
 	ret = clk_set_rate(mipi_dsi->px_clk, mipi_dsi->mode->clock * 1000);
 
 	if (ret) {
@@ -103,6 +104,12 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(mipi_dsi->px_clk);
+	if (ret) {
+		dev_err(mipi_dsi->dev, "Failed to enable DSI Pixel clock (ret %d)\n", ret);
+		return ret;
+	}
+
 	switch (mipi_dsi->dsi_device->format) {
 	case MIPI_DSI_FMT_RGB888:
 		dpi_data_format = DPI_COLOR_24BIT;

-- 
2.34.1


