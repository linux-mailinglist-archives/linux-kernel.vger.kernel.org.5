Return-Path: <linux-kernel+bounces-9954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A0081CDD9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A041C22494
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69552EAE0;
	Fri, 22 Dec 2023 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUaqBvH5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7762C1AD;
	Fri, 22 Dec 2023 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336979a566aso574527f8f.1;
        Fri, 22 Dec 2023 09:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266946; x=1703871746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDZw6NA00pLIWCPFGMihyx1IVwowkY8XOiwDd7TasQE=;
        b=KUaqBvH5GO1wdJGC+MVz/Mo4nrDj902m5Ln7T5abvoDa/r9pLVpXLCrAY0qrEN+w+F
         giDGPRQ2MB9eagvsp6vBv+w3PbepESL83+7VQrk/V3SEON9nDGFugkfoMmgOq1qMoTes
         NqOqol5rmU9TIFsH/CzSNCDOA1Air/oejKEWiqiMf8YDWYsLcTttSR8j2uOnMp0pe0s8
         0DwFOUnWlZL6IUrYO0SpD+KWlYRf+Z7rDkYvSwSLtCixsZzhdhDQTeu37yjZ/MUp5RL/
         Ledkw1rNmEdDk1q9LDreQ3qdvfmYdt6GWOP6U3qvwlT+qJdv8bvuTeU+qhXGNgDdz5dK
         +t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266946; x=1703871746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDZw6NA00pLIWCPFGMihyx1IVwowkY8XOiwDd7TasQE=;
        b=uDeeT0jJhk8iGnHd/7bVfZbr7CHRqC5XIDadhPAYb7b3ZmSVLmvkahtNCgN1yXqymD
         DHIEPUWaB9OeIApDkdXM/stPVdV3ttgsS1mPCm05DkFt19kGG3kgxRSSvwc8zS4M4Ff6
         AN9Wkrvc9zSWIWOWt3XaMqSAlcX6RnKTEf40hPUS3lLXRi1hwhPI4ojH/6/OvaJbHaO2
         ALzaQM5tQzle5i3IPcyHzy6dOqaXkMq4Z89qcaqsG+zBluUm39BzCIfH8ryMRyhYP0Ov
         tMomYxOd98ctO1WHIxtUzslcP4R/iRxzXuMyWH+PHVGd2Hh7IsCidRC38Yp8+yCPUemt
         uwjg==
X-Gm-Message-State: AOJu0YxCdvs6UgD+eTcpnJGGb7b8bzONSOVuB+wOrWCSh9gfY8QzFfVF
	oYBmFeerRGfG9T0pd9lSaw==
X-Google-Smtp-Source: AGHT+IGOfU9ODiH9NLfSXETtkHv9WTh+X98b43SlP0OW8MLrcFPW+Mc6NKBN1yINEst4gkgEd8TDVw==
X-Received: by 2002:a5d:58c1:0:b0:336:48fd:3458 with SMTP id o1-20020a5d58c1000000b0033648fd3458mr1123123wrf.68.1703266945929;
        Fri, 22 Dec 2023 09:42:25 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:25 -0800 (PST)
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
Subject: [PATCH v4 05/29] drm/rockchip: inno_hdmi: Remove useless copy of drm_display_mode
Date: Fri, 22 Dec 2023 18:41:56 +0100
Message-ID: <20231222174220.55249-6-knaerzche@gmail.com>
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

changes in v4:
 - none

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


