Return-Path: <linux-kernel+bounces-9967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F30FA81CDF9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9365F1F21608
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB043A287;
	Fri, 22 Dec 2023 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqPUl6h+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA635F1C;
	Fri, 22 Dec 2023 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33666fb9318so1833376f8f.2;
        Fri, 22 Dec 2023 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266955; x=1703871755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoHup+tJ34Km8AW+9n07V9L+jLAh9fwpCrHBqqRCe/E=;
        b=DqPUl6h+jeKUhEhX7g3uF44PAkkTMAUGKkL1G4MuZGHH/QiQWJr0L1TZCpHo/RCP1h
         0wocgZocYFrVYY5KPYizuXdGZdRbbYHdOY4zroZ/NPxJFxXpKXk+i4sRKlqRqVSFl56A
         qHQHYN7psI/Kv8VjbiH7xY1QsostTvRT41QZeeT3vAqTVS9RPcaQf4FEkCWNYhw025qE
         RfV+XzBBN4Bce27+ZiOsLljtKvWFnivvIYiSrcmUtHcbnMl8jgfzLLq/kOvjUPp23kMY
         DXwwkHfpyLxUpILDGZTFurMMqCey+q5d2J0xf30vA77njMSD21W7iQY168oU1dXZZ6Ta
         kJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266955; x=1703871755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoHup+tJ34Km8AW+9n07V9L+jLAh9fwpCrHBqqRCe/E=;
        b=c/MJok5O1A9nwdzJUOwe+MJMs8Ooq1MUqowm0mCNzevSZFiTBvyAQptCA9Owc8khKi
         Lkrr+D17Xrqzl5D4VX1zzbu7L3D956ONlXBz0wg+Ik34uA9hGY3Bfgkv1lLoL4+q+COd
         KDNHAYNZimfVuZLf6bGkDAbHqjpp9wWb+h8iUQ5Zdpb9juhH14dthIddBOfLIHiclLwz
         XBehu+ZtHqq5YY9TlnRecYpKd3OihWvSjcN30PuDvV7yjQyRor1Fb+vbkRsJDuyiX6Tm
         Vq9KGTvGVHiq84K3TK4aBBXT3hsXnIcaYa9w5KJlSSxGgGe4wXLMqv0hdUKFqTvCKfSR
         APtQ==
X-Gm-Message-State: AOJu0Yz7kmzS33qPiANxFoJ3A2ShW7xGNTwLt4h47cIleucALvvKQJJz
	Dd7NVpJjVsmZrMi2r3L+Zg==
X-Google-Smtp-Source: AGHT+IEnGIoJqNWWyiWZwjEzr0L5g9377mlPC0xqKPYwtqdze7Um6irPMyQs814kV87bqN1XpP/smQ==
X-Received: by 2002:a5d:400f:0:b0:336:8063:e066 with SMTP id n15-20020a5d400f000000b003368063e066mr798319wrp.52.1703266954984;
        Fri, 22 Dec 2023 09:42:34 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:34 -0800 (PST)
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
Subject: [PATCH v4 18/29] drm/rockchip: inno_hdmi: Remove useless include
Date: Fri, 22 Dec 2023 18:42:09 +0100
Message-ID: <20231222174220.55249-19-knaerzche@gmail.com>
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

The inclusion syscon.h isn't used anywhere. Remove it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
---
changes in v2:
 - new patch

changes in v3:
 - collect RB

changes in v4:
 - none

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


