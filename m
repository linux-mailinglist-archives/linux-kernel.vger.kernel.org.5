Return-Path: <linux-kernel+bounces-5637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FC7818D77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFEC1C246BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924CF3D0A5;
	Tue, 19 Dec 2023 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncJyVCFo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E138FA7;
	Tue, 19 Dec 2023 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d12b56a38so39143905e9.2;
        Tue, 19 Dec 2023 09:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005283; x=1703610083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bc0b+TzRBYlgBswaLzZiZATkVZXs4jtzYrqChWAdmP8=;
        b=ncJyVCFoE8H7MvGtgY7JPYHWMireS/rvF/6t5t3jSvY1iPutm6SVei3Kr3DX9QAVkZ
         TaY2ENGvl9BnCwhajT095wykkIvRM74sF0UzYQDOz9bHuHB6feqqjf1fQzvr4ZmUuTV3
         dGswVnozfhRqTQOn1aMJMTMYU9RznhTNtd+jFpOzlGVmvldsscwJGKll2h0klIcDoMLO
         oL9Lle3mt5xdAS+rxu4O6wp/mxDXyYLR1TQo8odsvzO8xP6BUGjD8ze3+J0QA387tfPN
         WsDXeVvsm/RTWEKOaM5cbDG8XC+AfZH0ipKVNvURhc40TfvUtYMJHf9DsY1aJFhZvT31
         AsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005283; x=1703610083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bc0b+TzRBYlgBswaLzZiZATkVZXs4jtzYrqChWAdmP8=;
        b=P1uVuZioUXxbK7Bza2vgbYslZOvH8Lci3VzIy4y+Td1xCpaeWG/yPEkt7R7CEimyww
         kCw2B3DJZ9xD6jcIueuRbM3liMNcUnUWmTv3ngQaVm/CpltobngjF8aFhTq0IQIFpVwj
         V3Cdd+FgIBYi4Ob5Xhjix2XJ85lliHfBKDw8vjcLCoQbHbAbjlzvUhPv6OV8lvnEU0S9
         eEHlzEqGmYa5f440uVHJVIl1RRnAA0vzij8xPw8C/X5nwiuwojA5O8g9OdsQE4nBW7XC
         KOObpQaQIMH9lGx8WddHiTLGbssCfa+5ISduod/gepjVgGm/yv+MHjvu19pVaoN00eXq
         kc7A==
X-Gm-Message-State: AOJu0YwuRZ6DkONMdxzsqu7Lipiec9ROFc966Vxq0HC1aJXHhrzU6/uB
	tSdx0sfwMuyp5794ImTgsYpNoNYpUQ==
X-Google-Smtp-Source: AGHT+IGsXiyRLPSKTLiCmb5HKcIoTm/Gx4nMKjVc/FhMnHN1ip8FwDTTR8xwruHseC++DoM215yynw==
X-Received: by 2002:a05:600c:4588:b0:40c:6b55:2a0f with SMTP id r8-20020a05600c458800b0040c6b552a0fmr2064612wmo.224.1703005283542;
        Tue, 19 Dec 2023 09:01:23 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:23 -0800 (PST)
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
Subject: [PATCH v3 18/29] drm/rockchip: inno_hdmi: Remove useless include
Date: Tue, 19 Dec 2023 18:00:48 +0100
Message-ID: <20231219170100.188800-19-knaerzche@gmail.com>
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

The inclusion syscon.h isn't used anywhere. Remove it.

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
index 138cd4287dea..c306db90832a 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -10,7 +10,6 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/hdmi.h>
-#include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-- 
2.43.0


