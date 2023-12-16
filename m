Return-Path: <linux-kernel+bounces-2251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7AD815A35
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19AEB237CE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAFC31A72;
	Sat, 16 Dec 2023 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuKt+QWw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE530F82;
	Sat, 16 Dec 2023 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e2d00f99cso316916e87.0;
        Sat, 16 Dec 2023 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744028; x=1703348828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujhT/xhztHbY8JzCzlkbXu+iQMCJG+MMsIZQaYuJZKs=;
        b=SuKt+QWwllwfQNJxmUaW56zDvhx/5cTx8u8lrzdrXaZo6u9+kOAMBmldhTWOkNkHeP
         xgBzALzo8XDjfLyjLesZwa4uQ4eNgdTrgCNMoxhQOB2/NMrznq9kI1D2fcC+ilMnH78t
         ujp9VolQ2ECcYITWu4lpqsvt9YLCAMlYUA4fflqDU7n1sBoCSF9pX4tKT9P3+TbIozJ+
         HtcH81iUsKfFk9SMcabaPqky3MsCrgqaLOCNzjPqzJU3k12PO40y9b8ynIY15mAIGNdq
         dSgmJE9KMhcJY86dwajhZsctIXPUT9k7VjInFinXCs/2TQVlTx4P6sSIonnVAynIK2yF
         4XFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744028; x=1703348828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujhT/xhztHbY8JzCzlkbXu+iQMCJG+MMsIZQaYuJZKs=;
        b=vXQj2B//5gcKGTYPUzQi5/jGzrZSsFMWgkqDX+CMvB6rjViLQlRfQgA1NGJkOz84aO
         HOo6sk3pIPV6j2fZRrnIIXjQ/CS1wGSa0r7cEIgoTZLpJqNCXiDk5VC/tqIlC2/IyjMU
         SzQlafJLIBN8MXrJ0rERDTl5DcaQaQMS8LYn0mGGE6zys8uKylVcdBsDn+U82cUdCm5C
         HUY6tyj6rtyWZvkzCW0htzOCB8ijWLQRyXn6hIUkBNowwqfsQezKJPlZxmG4mXcz4O9w
         VIO7zrwpjQPq+FcDIvAOM2K6Z7X6dOzYKadfQLpxam+WplGqzguA3eng4oRGqV28NEa4
         mK4g==
X-Gm-Message-State: AOJu0Yw4RgkGmnYSw0azIYx44j4PiYPreqjjJf2QmBXhEMynRAlL3bxP
	j325iFlybXSGkpQ/3jgEKQ==
X-Google-Smtp-Source: AGHT+IEoZS1JzzGc12YB/MN689Vsdo/GX0yIsCmhRzmI2mChIP6YnFGPdCsy2rPk5UV5T25TnOSVWw==
X-Received: by 2002:a19:8c0d:0:b0:50b:f55b:abb9 with SMTP id o13-20020a198c0d000000b0050bf55babb9mr6923253lfd.94.1702744028520;
        Sat, 16 Dec 2023 08:27:08 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:08 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 04/27] drm/rockchip: inno_hdmi: Remove useless mode_fixup
Date: Sat, 16 Dec 2023 17:26:15 +0100
Message-ID: <20231216162639.125215-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216162639.125215-1-knaerzche@gmail.com>
References: <20231216162639.125215-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxime Ripard <mripard@kernel.org>

The mode_fixup implementation doesn't do anything, so we can simply
remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 345253e033c5..0b1740b38c7b 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -517,13 +517,6 @@ static void inno_hdmi_encoder_disable(struct drm_encoder *encoder)
 	inno_hdmi_set_pwr_mode(hdmi, LOWER_PWR);
 }
 
-static bool inno_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
-					 const struct drm_display_mode *mode,
-					 struct drm_display_mode *adj_mode)
-{
-	return true;
-}
-
 static int
 inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 			       struct drm_crtc_state *crtc_state,
@@ -540,7 +533,6 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
 	.enable     = inno_hdmi_encoder_enable,
 	.disable    = inno_hdmi_encoder_disable,
-	.mode_fixup = inno_hdmi_encoder_mode_fixup,
 	.mode_set   = inno_hdmi_encoder_mode_set,
 	.atomic_check = inno_hdmi_encoder_atomic_check,
 };
-- 
2.43.0


