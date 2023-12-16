Return-Path: <linux-kernel+bounces-2253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B19815A39
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E42A28557E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACA9328AF;
	Sat, 16 Dec 2023 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L99+d5s8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF6315A7;
	Sat, 16 Dec 2023 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso2600942a12.0;
        Sat, 16 Dec 2023 08:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744030; x=1703348830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+K0So3uuQGg3yr+y8AKU1btAl7C7H8qZH5jAq4CxfOw=;
        b=L99+d5s8N5i0IuxxU2/QkU436ajp4zsDVmF3cLTGp+R8PVfoxoD/4CVWgEHnML6wQZ
         6pmffHQuSQn1VSy+7eMF6lZQSIvFYbSJwGDfLmYPoojxOdSPT67xaCiuXCpGkHHoD3Gm
         cT16eR5ujV/Zz+5cFgpGFfGYZ1UJ4gq3IxQMO9NqmsAOvXqiskl+VDYrLm09QruHboWJ
         T3qryLawYOzx2LZOmO7z2RuK1d2U5U8JkzMKk0ZoyWmpImXhlVcZZvd6ISBYweZwi9fi
         BwEl/BJZC8c+ylekfWf4NQD6XiPp+Q18DD0VZmnio8zWD51aGf8c6qZMgWmWQG8zB1aD
         mN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744030; x=1703348830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+K0So3uuQGg3yr+y8AKU1btAl7C7H8qZH5jAq4CxfOw=;
        b=E9+3C7AA9IJfAtYsnp6TZ0PZzEKf3OLcr067DH4LKQfIuXI8XUoWYa25DBBYGSlpGM
         f3NaJcu3PEJV7j6Y0qtf7UX8AElQpo9RukUzX7CTpCGDEjH54GvSPmd5a9edSZn47Bnt
         y3HWqdlRoqEEeUCC1358WpbSg9hp2wn4SO7QVX/buTgjQ3EiO5aIp5Vg80zp+8tZuIqH
         hSw7QQnn+mpJ1wCmx0YdEU4TBVqD4K9ZTu9FtmZPyFMWcZT8s/QgZ3+OSjNyFi6GD2cb
         9U6uC12RK/g6qWKn51MNwXejucdnimfA/C3G1oQkkYHgcHLrvhhSTE8wFI/CTSbGsiGR
         XmTg==
X-Gm-Message-State: AOJu0YzxDhV65FC9H0J0Be7f6TcQzeLIhlKEK269lwaFjiqwLA9lITuR
	N3Ap4vH8fLdMvkkgTYEwoA==
X-Google-Smtp-Source: AGHT+IExRugXG74sxCB2Guilb/nSJFlUmZY/5iuQd+cooSuE643BRC/59xoXydHOjqZElMPX6y5FtQ==
X-Received: by 2002:a17:906:101e:b0:a01:ae9a:c1d3 with SMTP id 30-20020a170906101e00b00a01ae9ac1d3mr13645179ejm.11.1702744029174;
        Sat, 16 Dec 2023 08:27:09 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.08
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
Subject: [PATCH v2 05/27] drm/rockchip: inno_hdmi: Remove useless copy of drm_display_mode
Date: Sat, 16 Dec 2023 17:26:16 +0100
Message-ID: <20231216162639.125215-6-knaerzche@gmail.com>
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

The driver maintains a copy of the adjusted mode but doesn't use it
anywhere. Remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

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


