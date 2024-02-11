Return-Path: <linux-kernel+bounces-60979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1D6850C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7EE3B21A83
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F717557;
	Sun, 11 Feb 2024 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjLp+tEn"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A18B1426A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707692984; cv=none; b=lLBWe9HLAI7obCwT25f3yqLaPtsh6QeqsbCUK0stPKuKtXYQ8Xqa6t/gWmIBeYKXd0B3YHH27lFNORJcmKH2Z6M7tW7hmmxK5zKQhkxUSOIJA4dgCF1YOhV75F3TjgQmNjXeAhd5+hjYs23G0W7mDMTO31B3MGGj5g92HZD9uYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707692984; c=relaxed/simple;
	bh=ZV5g1y0cPA00H5tFqxrqlogbsErWJkzNuROVhuAMx1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9giWSsU7H4JKqilfcOD2aMNXni3EsCR3+00F+HYzu6B7CW0dxLI41mqCpoWWTdyQVKM1VTt94ZxAWlpp+5UwvCEjw7MJmo6EcTd2gRDyaNhVNeE2QIkaWWzcmt1xLXDCYlPcYIRm0ob9/RjHVOMJEOWWtbG/UFolJf4WxKPsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjLp+tEn; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78406c22dc7so162911185a.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707692981; x=1708297781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhCKXGEt9TZ3Ak7K2jgNcJJQ6zAqQoIKdg3XOoh2cBc=;
        b=DjLp+tEn+7T8bbRx4nllb8bPBZ5HKO6HbGMEdi03ZMsWE7jz0/5z9KYzWY2CpL5lzo
         xlPvXjW6bKDiNAqBE4wKUwbm7TxXlT85qpl95visgWWCHLeUapf21a0WDUF/Am7hNzA/
         Yp7NfKiwzY5GYFjZbDwTXdQiZ100qN8I5ukFzi9+CDWUdzcPzh6VBvFB9NdJSTmgu1bV
         60j8WEbw1qJCZWPxRgIBiG00427r24HJErhH8C66dgzmcwDr70XxivGBfqScqDWnQoel
         EzmHsKoC07jD3Rfx8Qn81KeLu2XYSXLBpkH96kpxzwGuZFrOSevrcjWDApyjXO7XCeA1
         JD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707692981; x=1708297781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhCKXGEt9TZ3Ak7K2jgNcJJQ6zAqQoIKdg3XOoh2cBc=;
        b=v5hSoOZtFYYLQBMBaW35ejusla/dEyapSn1a47+G2tVE406l3j6gwKdLxHAT3clDZR
         xsewJHfy0tCAX+5YZ2hSzksqn+n/gpSqLQXdZryuOIx7lK6Nxbmz9r92E+M7yHADZFpf
         WUpIMQH3eB21iqqkGj7U2Eum4bVpaH77XWSeQdgyzaW4Eze/ODobbIsnoKUcWr0nINr9
         0umBQmGhdCOXLu2GglL4LH6FDmq9VLZPvDsQMvlbt3s6KBDI9c5lXGTaOJl3+uF0fR2k
         ETL1maEcPi/oyKXnWfKM+DfJgSS0C2U8uNdGBq0kyJtlddohs/edXsFs5YUfQxNkVQvG
         AusA==
X-Gm-Message-State: AOJu0Yx2PT0QY/FdP4PaLkI8BC9Swh1RNLjjmpzlwIe2ZpEihXNCjM0k
	EEpndhGb5QDVG5eXgQbV6kqimuUKqQEDmcNowkglDJSwSirR0HxD
X-Google-Smtp-Source: AGHT+IEVrTUKOVe7UOOJKP7QkP0pLNPWsCwxp6nzYTXnFQfMy0sRkqzLhG714QWKyRz1NPs5pVPzOA==
X-Received: by 2002:a05:620a:60df:b0:785:b9cf:c757 with SMTP id dy31-20020a05620a60df00b00785b9cfc757mr5621083qkb.36.1707692981261;
        Sun, 11 Feb 2024 15:09:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOPHbzpPEM50aXzk4BjXx2OhfGWzMbZgGMfTA2eUWLV88KXgQHIguJzG+uN7yZN+jCSjQV0Os96HxfC6C55G5AvfPXNejM4GNCJFbZ1nnph8TXwF8tT0xdbouII7qkgUvdNc+1nj6UD9DeiEnMY50FBb3yV+FfaDRdliF8coDO2R7P7Ulont//43wj2mSOAk/Hlo9W1//n6lYPXQMYx81aM1QNn1X2OZR+dOa2RQsufXUxhdawyYlz/s7GbjMR6BnZZbv/CqHNAn1Tvp3uHmlh4gcKHz1hogLPJ2oT6983e8hxxEpOl1k93qhKK4UM4xQixLky8Afmt3C6/lO1SXsfYyFmP44nNdjHFpCtohyzoAvJOKhnaONxezjWmdsZmYv7XowxRYwzdcask/leYbTjT3enstMSMzTWFSPz+KiVp3bM7Eh/TakyyDNfxGIeRy43/2kC6L2HVAY6D05P5prTPhe3NvnkAc/ktlAh0sErOfwlYk8r2zx0noS2aWufyRpDpcjSjWIrQQV9S5DPS30HuM3GKg1AOKY3z5poS5tJZ5lcY/eGXdVFMnYth4oHWT3KTQSh6vNfStZxG+WwC4vAMAJrYdHIn8IarA+yltc+A6g6TPsTtxRIAfT6sJs+Oz4bcYEOMxznphGeW5dpDZYqoX1rbVF8l+n7p796s5NLnHxJxKWScV7dD5cHRI9t8jRe4YP4MSNRQ1DJ
Received: from aford-System-Version.lan ([2601:447:d002:5be:c8c4:8542:9142:2184])
        by smtp.gmail.com with ESMTPSA id a25-20020a05620a103900b007855bec5da8sm1589773qkk.16.2024.02.11.15.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:09:40 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Michael Tretter <m.tretter@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation rounding
Date: Sun, 11 Feb 2024 17:09:30 -0600
Message-ID: <20240211230931.188194-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211230931.188194-1-aford173@gmail.com>
References: <20240211230931.188194-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using video sync pulses, the HFP, HBP, and HSA are divided between
the available lanes if there is more than one lane.  For certain
timings and lane configurations, the HFP may not be evenly divisible.
If the HFP is rounded down, it ends up being too small which can cause
some monitors to not sync properly. In these instances, adjust htotal
and hsync to round the HFP up, and recalculate the htotal.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL i.MX8MM with HDMI monitor
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No changes

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 8476650c477c..52939211fe93 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1606,6 +1606,27 @@ static int samsung_dsim_atomic_check(struct drm_bridge *bridge,
 		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
 	}
 
+	/*
+	 * When using video sync pulses, the HFP, HBP, and HSA are divided between
+	 * the available lanes if there is more than one lane.  For certain
+	 * timings and lane configurations, the HFP may not be evenly divisible.
+	 * If the HFP is rounded down, it ends up being too small which can cause
+	 * some monitors to not sync properly. In these instances, adjust htotal
+	 * and hsync to round the HFP up, and recalculate the htotal. Through trial
+	 * and error, it appears that the HBP and HSA do not appearto need the same
+	 * correction that HFP does.
+	 */
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE && dsi->lanes > 1) {
+		int hfp = adjusted_mode->hsync_start - adjusted_mode->hdisplay;
+		int remainder = hfp % dsi->lanes;
+
+		if (remainder) {
+			adjusted_mode->hsync_start += remainder;
+			adjusted_mode->hsync_end   += remainder;
+			adjusted_mode->htotal      += remainder;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.43.0


