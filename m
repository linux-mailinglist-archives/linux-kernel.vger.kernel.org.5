Return-Path: <linux-kernel+bounces-5636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48904818D75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEC2B25065
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AA439AE8;
	Tue, 19 Dec 2023 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="my7jBsKQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3C39AE3;
	Tue, 19 Dec 2023 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso45414625e9.1;
        Tue, 19 Dec 2023 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005283; x=1703610083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WseMEHOavtmxykYRA2JtvMxiK/FtoaZXXQqi1uMlW0=;
        b=my7jBsKQdDFXLbbckrB98UxQDRddpPZR3N1nusiIUa+okYJQmi9W8kGrhNH7l3mSxL
         2PrjRkzwC+sgfDrnqOtiKLe14Uz4vo+gnr+hm/y5+lB+Px0GvBrAwSvoVjbvTKzCbp86
         aM4aRDJ/XxqjoAYQFkk6NKFjyvViFoyEYa97OU1kY/OIyhPYFK7AsTEOZAmJzuAbepQW
         jHd+LiV+sN10uFIW8dt42BFGOdQGyyrYnQ3O22i2PPkIIB3I8caljibcc/EXUPPVbpfs
         iwSjCvCw/W+lgmDWOzQa6mAOeILzG7AqdgGw/04A9mrbzNL/ssomAVNjSVDKibyqPAwS
         RZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005283; x=1703610083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WseMEHOavtmxykYRA2JtvMxiK/FtoaZXXQqi1uMlW0=;
        b=rh2biJZHoDAJ6EeeZaK6OQ7TlQU0bDTjilsawC+HDDcKGCMbQrsSqw4xt1at2xvr/s
         vYdgsVNumJBynAgFvNyDzTRZ8Yt5eR3WUqvU2GFxFPxU7EmSr9ySaTbt4r9Hqsg7ARC6
         Yjqq2ZbzdE3jnadf1FLxz+3yc6i42cD/2gozCgHBPtcYcLl0H+bESW52HGMpBK0PMXvr
         N3UrmvxoRmj8q9GK8q1+mP69Uk+TTfCg8Kn35quSGnm7cSkw/4Tz8kYrDQgM+BILmXXG
         /GMIVZH5Oa5QOOXHqBVYxeMj2G7GsRwx1Nf7Y0HWlOCnM5ZWD98lS2a+Ju2JukLyc8wW
         KKGg==
X-Gm-Message-State: AOJu0YwfKbk69VQf/D1yqeUThWVVkkh1E29neEzyyDlgDdLXzKqpee1z
	0Ilu9FVi5nY1umyue0j8ig==
X-Google-Smtp-Source: AGHT+IGOZJZnOnuHfdIdouJRryXsfventVWMJzlbA9qGEmVPHmZahIRRyc0+LTqlmnQmmG0gfJFPiw==
X-Received: by 2002:a05:600c:1d10:b0:40c:50c:9f3f with SMTP id l16-20020a05600c1d1000b0040c050c9f3fmr10565023wms.95.1703005282571;
        Tue, 19 Dec 2023 09:01:22 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:22 -0800 (PST)
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
Subject: [PATCH v3 17/29] drm/rockchip: inno_hdmi: Drop irq struct member
Date: Tue, 19 Dec 2023 18:00:47 +0100
Message-ID: <20231219170100.188800-18-knaerzche@gmail.com>
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

The struct member irq isn't used anywhere. Drop it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
---
changes in v2:
 - new patch

changes in v3:
 - collect RB

 drivers/gpu/drm/rockchip/inno_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 51c1a69dfcc0..138cd4287dea 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -45,7 +45,6 @@ struct inno_hdmi_i2c {
 struct inno_hdmi {
 	struct device *dev;
 
-	int irq;
 	struct clk *pclk;
 	void __iomem *regs;
 
-- 
2.43.0


