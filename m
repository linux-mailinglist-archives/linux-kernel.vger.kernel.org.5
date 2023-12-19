Return-Path: <linux-kernel+bounces-5623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9C1818D55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B21F1F271A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A860358AF;
	Tue, 19 Dec 2023 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZMaMjCZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57031A74;
	Tue, 19 Dec 2023 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c236624edso52670395e9.1;
        Tue, 19 Dec 2023 09:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005272; x=1703610072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qH39RMJfndGmJ2yo6EAj0TEb5im2nG8g4/g1kbQG1h8=;
        b=mZMaMjCZvrsGp5stWFYqLD6tBEGoQjtF5o0m8xa7fWwjseseKxvWUlZCHvl2jXPXEZ
         ZKLhC0yw2+4FwBgH+MfcLGmcBjxpcslkLQ5V2+AfQ1hUQAIeAn3wtxSArKQcIBQ1ZkMt
         ARwUAaMiE1vYgbCGMlNmvRYcgL8AB4vLctwbcA/EC5FVbj4BuqByRIvcQPL+iDYN2Lry
         6F1s6VmbgPMMMbyFnfsPF5RLxtzQu0Ihu/lN6v5AaMlvN++DU0UixTrRDs8o0AyygCbo
         iya/vFCFRqRdPZSeE3V+MKrmFaMrQxEO2dBBlhym+/Fj4rkI5HiUtbLbpNXRz6iLmBNz
         OPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005272; x=1703610072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qH39RMJfndGmJ2yo6EAj0TEb5im2nG8g4/g1kbQG1h8=;
        b=idxCJ6Ouos622kj35jcGZQaGYRz9w4x17VMJQJGw7Qz/5Vm9dnBsw6exQnn7XoCecC
         rT8OKAw1jdOdl1/BUEzi/J2i1qbE7OY0lZ0jStLObDrqso9Uhb8nBXQNEyJgsgryb6Xt
         +MYQvZ6nhqrfSEoeHo7c6C5GnnVwj0n7Pt+Wd/e7BgFm5zQnNetYKFzYX8arw4A0ip9Y
         9OdtIrO70d9ssdtFFZETRszEykm8zSVD6+Be7aQk+D/qKwlYqKWsDt7drd+Mz2wnAIBI
         B/D5nPV4IMTyJnGecwhIyBSUZqdfTCpQkW8LorCWBlEiLWdniZog7Zhq25RRB08ol43f
         rimA==
X-Gm-Message-State: AOJu0Yw+/1CSPE2GKnFxCj4VFr168M9KbGLK0KrNYJ7BTWraYESGiX5V
	JVBx5rwUlTwR8guXD7dGlg==
X-Google-Smtp-Source: AGHT+IGtFrexi9uVeaZK/6ydPyM1BX9m1o9MELmkYq+IF/YlCMbmQvGLdQPCk5LCS9UJ76GWt9oJsw==
X-Received: by 2002:a05:600c:b99:b0:40d:27fb:2f27 with SMTP id fl25-20020a05600c0b9900b0040d27fb2f27mr601599wmb.111.1703005271769;
        Tue, 19 Dec 2023 09:01:11 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:11 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 05/29] drm/rockchip: inno_hdmi: Remove useless copy of drm_display_mode
Date: Tue, 19 Dec 2023 18:00:35 +0100
Message-ID: <20231219170100.188800-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219170100.188800-1-knaerzche@gmail.com>
References: <20231219170100.188800-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxime Ripard <mripard@kernel.org>

The driver maintains a copy of the adjusted mode but doesn't use it
anywhere. Remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

changes in v3:
 - added my SoB

 drivers/gpu/drm/rockchip/inno_hdmi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 0b1740b38c7b..14d2ba92a606 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -62,7 +62,6 @@ struct inno_hdmi {
 	unsigned int tmds_rate;
 
 	struct hdmi_data_info	hdmi_data;
-	struct drm_display_mode previous_mode;
 };
 
 static struct inno_hdmi *encoder_to_inno_hdmi(struct drm_encoder *encoder)
@@ -498,9 +497,6 @@ static void inno_hdmi_encoder_mode_set(struct drm_encoder *encoder,
 	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
 
 	inno_hdmi_setup(hdmi, adj_mode);
-
-	/* Store the display mode for plugin/DPMS poweron events */
-	drm_mode_copy(&hdmi->previous_mode, adj_mode);
 }
 
 static void inno_hdmi_encoder_enable(struct drm_encoder *encoder)
-- 
2.43.0


