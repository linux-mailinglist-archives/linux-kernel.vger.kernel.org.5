Return-Path: <linux-kernel+bounces-9952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6AF81CDD4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE87F1C22138
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCE72E643;
	Fri, 22 Dec 2023 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFlrU6rx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D928E0F;
	Fri, 22 Dec 2023 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-336990fb8fbso479621f8f.1;
        Fri, 22 Dec 2023 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266944; x=1703871744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2HtmTELSCmQNqADg2Zx1cwuvSj7RPiUvZpCNIv/8+8=;
        b=aFlrU6rxyla4IxXOsIeCl7F/7d6bITx3266c0l5z7qislwEgZ0TIoaR/H1EIWvwQlK
         rRQKfGl37/nd+j/rN7A3AMufdCl8YKMLmCtK0bH8Mtq/lyITyvXOuVbr9p0ylFRXoL87
         posnWcjs9KtlkfSNlqsnu++MACaF5X2xTU/F/UuWsHN0Ubp2/hXaw/SEh8LQWoiwK3Jr
         BdjaKlaCZIsUGdQdYOMjzWT9z5v5/3NiuUxrNFURAEOAZXr2qAi177tOpn6sl4qCF26L
         1knk/ZEpLhoTWagxZm7t2KG4I4iWQGSQPZZh6a0m8XNLmMbW6TZPPAx8qLVs8D55FyjP
         Zq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266944; x=1703871744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2HtmTELSCmQNqADg2Zx1cwuvSj7RPiUvZpCNIv/8+8=;
        b=vlfzoCC1PL3aSW3yHT2qXhADsKckxXtdhpA+WXr+Nu2bbt22rnH8K2cROwwDdTMEed
         VJjEgigVR4qMjk2err4jMc7t9hOAARJYlmicDI1fWnYN2xIPVlZp90HkWGsHQ8TbpzBj
         qjAcAi7ZQL+3YkrKmwgPggqsZ6/iPSOAKQ4CS+TdM/KdvM6BX/yUV43qfkgxE/qAoTOz
         RYmOnygHNFfJpvo3abucf81edi4Uxc2HHuWnZx0k50NwoCr1RcojPC6M0LdqbeXegeDN
         oKBFKpbttM8r5Ox98xAxPlqxVndU6JH9m7IpyPG2h5s/6r9pIG4Xbxlk8vePBMf5Tw0b
         If9g==
X-Gm-Message-State: AOJu0YyHelIJ8nrwlIpU8nxlpHlNm7OGsF9XX6qMsfaKUy5M6CddsC3R
	4/gNPH+dNFjOuKEr8hW5sA==
X-Google-Smtp-Source: AGHT+IFV/fIOXodbE6RmpDPeWLOnH4XmVWoyKpBmq+L8MCu5fyIARaUJmQScH13sxNwDp3moadiGgQ==
X-Received: by 2002:adf:dd8c:0:b0:336:77a3:2fbf with SMTP id x12-20020adfdd8c000000b0033677a32fbfmr947364wrl.31.1703266944629;
        Fri, 22 Dec 2023 09:42:24 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:24 -0800 (PST)
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
	Alex Bee <knaerzche@gmail.com>,
	Zheng Yang <zhengyang@rock-chips.com>
Subject: [PATCH v4 03/29] drm/rockchip: inno_hdmi: Fix video timing
Date: Fri, 22 Dec 2023 18:41:54 +0100
Message-ID: <20231222174220.55249-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222174220.55249-1-knaerzche@gmail.com>
References: <20231222174220.55249-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The controller wants the difference between *total and *sync_start in the
HDMI_VIDEO_EXT_*DELAY registers. Otherwise the signal is very unstable for
certain non-VIC modes. See downstream commit [0].

[0] https://github.com/rockchip-linux/kernel/commit/8eb559f2502c

Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
Co-developed-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - none

changes in v3:
 - none

changes in v4:
 - none

 drivers/gpu/drm/rockchip/inno_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 6e5b922a121e..345253e033c5 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -412,7 +412,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_H, (value >> 8) & 0xFF);
 
-	value = mode->hsync_start - mode->hdisplay;
+	value = mode->htotal - mode->hsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_H, (value >> 8) & 0xFF);
 
@@ -427,7 +427,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	value = mode->vtotal - mode->vdisplay;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VBLANK, value & 0xFF);
 
-	value = mode->vsync_start - mode->vdisplay;
+	value = mode->vtotal - mode->vsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VDELAY, value & 0xFF);
 
 	value = mode->vsync_end - mode->vsync_start;
-- 
2.43.0


