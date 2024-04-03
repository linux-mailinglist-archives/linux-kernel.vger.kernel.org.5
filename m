Return-Path: <linux-kernel+bounces-129212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E1589670F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBA81F24FC4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05D55C614;
	Wed,  3 Apr 2024 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXr8/9Qv"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA467A15
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130409; cv=none; b=qOqRUgDH/s3g9dIUI+R0e0GMlic/gXbSAzylTkHejLwkRWq1tpEo5wy0SVEFQcKgbCj9g7mttRDC1ElLx22CWcA+FplZCvE8fzsN76Mewz5MUDGUhiZNGq4Je9oyo9YILEmGu1LxbqVh74VQPUiAPqGJfGr4CXrP+x2f2Dx1ybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130409; c=relaxed/simple;
	bh=IE7LBQJSwmFpro9NRvngqeq31VcV/n9f72AsydUqbws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=soWNEjNhQgeXpjXXpDBR6Pnuyj+p0C+mMfYRq85qIHw7gM0tdqWnGyBgQHai/8BMIz+EYgGF4Rn/wtDjOo6V0lh8qZChzCrzl5Z9rH4abqeEunbia1/DMjVrM3ntBZIdi8BXse/TpgW2LnkTSXlAM0BVLhnlDXFKVnwuALuDTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yXr8/9Qv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33edbc5932bso4345706f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712130406; x=1712735206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kTGO29vezq1Gc7J5O9OI72ko2OnA3sM69gX9LY6c8Y=;
        b=yXr8/9QvlFyhyrTHR78eqXBDJTXPJi4xbRcJZU4uzOQt7aPkw7sybXcd8wpXSPsFJt
         gs5W7psp7+VoyzLgRdRlZJxnGE1QNRSWWcnEscnR6IQeq3SXykgRnNIgqbn6wCu7mUrF
         XBsqdCmX/snj9p2p13V5aWW7f7opGxRwY0C63ujbzqrEZN9liS2yEpHOUQCtMxBgLakt
         IIOzYXxMvjA8/k/PZqqen+LKJKFFcm3NCD1zgZgwPM1Ep2YyiKivMJ1qWYrtEA4HApMQ
         0U5XRJn2s1WutAumtM71cLWIAu9Iu5iy18k1uk2lgGOsjLtsnp/yKcdlSFnWbXaz1a05
         ERXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130406; x=1712735206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kTGO29vezq1Gc7J5O9OI72ko2OnA3sM69gX9LY6c8Y=;
        b=ayy1UNGZdvOn1WsfDLkwTDpD0L0vlXc4XwIxpcfVkZnM1iBOUhW51qgiQIo+40fFVr
         yIxC0SL8nnn6e6/7WOrQzHUtLZY5bqTxJ0DxuJcYi0DXMvWYGgZi3ia6+GDb4ZXHgbGf
         odnCqawnImbk1497bwhP95cFYJeEQQz369SdpPx1qbqLihjETpFcOAO5uuVbxm4JQiwD
         pAKXhLquJPRsrsRvgTm66Kwf0r3Jdw1C3I5Jv3dxy8GVmeI6y1MFzcfTpSWDTc/cU3n6
         dA5qRg6UHgG7hJlKN3Vgu7eClju5P/ETR+eE2CWIa1rR9xxf920GWukNvZZHvXgPsPLf
         s9AA==
X-Forwarded-Encrypted: i=1; AJvYcCWILKtpJYn4sfjjX6URhHGvsn5BW0r5RXmhThxcLukL9Vb49NsQIauLIZ6pvn6OL0SmxsKS3hxWlLKC6ex+chZsZ7jbt4PeDXnWsNav
X-Gm-Message-State: AOJu0YxRW6q0HWINFPBZhA0SLsgLuBqN16e+Y/W/F31kTpWtWQrJRIHK
	aP9aCBm+2x3VIGDJ6lg1Hi5WTnITh05ozZSKUS4xv9t9Jdz9HH7uaINFUsJByAc=
X-Google-Smtp-Source: AGHT+IGGBq46h/V4vx/Me2v91oAoyllp45G9fkusl1z2wLTpALiMyIumG2Nx4o8WN9H7lVUQlHmBwA==
X-Received: by 2002:a5d:4a87:0:b0:343:3dba:79ad with SMTP id o7-20020a5d4a87000000b003433dba79admr1387682wrq.26.1712130406071;
        Wed, 03 Apr 2024 00:46:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id cc13-20020a5d5c0d000000b00341b8edbe8csm14021282wrb.87.2024.04.03.00.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:46:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 03 Apr 2024 09:46:35 +0200
Subject: [PATCH v12 4/7] drm/meson: gate px_clk when setting rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-4-99ecdfdc87fc@linaro.org>
References: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-0-99ecdfdc87fc@linaro.org>
In-Reply-To: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-0-99ecdfdc87fc@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Nicolas Belin <nbelin@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IE7LBQJSwmFpro9NRvngqeq31VcV/n9f72AsydUqbws=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmDQlejcQpqrYrAdfaoIKddWFOfQjzYTGqO7gkkwmM
 X08eYFCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg0JXgAKCRB33NvayMhJ0Q7FD/
 4pXY/d5+OF74duX+1KwCp8i59NBBA/JfD4gBGLG/y8peYkyi6uFoymroebTIXBTdk5OktdRxI2MY6k
 Yjcg/mDVItK4u5zTwrCSiL9dojIKHN5PueEDWQS6IV8/RsmrtJZOG/womzzmlOkl6B3/hR/49K9k6c
 oT1r6jV1q6/dCwoLjJZUs0qxsf2dbBS4lm7Kg9n8/j3+b1wq25ppIbXnbkACOXs4BOU+PKclGRwKJF
 StBh28gamk0zR5pezCjDBe3sdyYaVKkWXFHc2q5ph6bfpmZyz1+b/EMk9rmhxixkT8LeMNCf8IUAug
 Wz/jxtAyVjXCwwJHdFoiqdfg047aMW+ev4DjGD3gYEgivIruNyU7a7PqKlHimMxjx18m/3Z7gENtez
 Bu9iz3iMAbGc7tpsJpTimlVpLnY9m3sXgmkyV53z0w0/wFTGEPJJ1ovAVsfNJkq3pufN6AhdeJ6CWb
 O0htkhM8Xu3woGTfwn8NwVex41/0839yVaVOseg2JCEWrffVta4km1puojyKb/kSPer1cpbRugbmL1
 ff6acKY/vNIQ8OGAI8V6gW83mtpbrFI5ZJX9eK4CUBq6cMjlfo2zdDYfmCffnOw+CExXEtcT3LBPCV
 0XaCwjwkkEsUfB4ElfVGrV+pgK89u2lGxo6GINqE01Rrwy66Rj4gX+hgcRPg==
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


