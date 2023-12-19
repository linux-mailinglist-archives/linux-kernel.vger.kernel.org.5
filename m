Return-Path: <linux-kernel+bounces-5629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD81818D64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81441F28126
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523EF39851;
	Tue, 19 Dec 2023 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqk8Zjok"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D530837D27;
	Tue, 19 Dec 2023 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3367601a301so577366f8f.2;
        Tue, 19 Dec 2023 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005277; x=1703610077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vfw1A5kPCqeEpvkS0qSDCc84V56+/woGo5pclCQd9uw=;
        b=mqk8ZjokHBOmxIt8RKtFh7E76Fwny4r3nE8piPw2oCUKFxphSWbN/a0IQQC9n8t5Ie
         Sve05zS3Iq6tgQmp0q4rcjHGCjoAUribwz3IeF20VcryMs3CN9XL65Cbp5omgQC7gUVN
         iOV5MrF6CMwfCODHZHalExoJaUojYYMCQKq6crkeKcNL61HloFdDZaFDEOwZd52XbbIt
         oR3ve0QzjiLT5KMNagdgP8B6MBkiIPqCauR8HGHY2PLaPeyKQKvWXGnjm2t6tG2PxrJV
         hfeuxRsu3GRwHRmlralsbsUwT0wEKRnBIdP1qzmQZk7iXQiRZOpHR3Fg9pWzgM2eWA2T
         jiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005277; x=1703610077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vfw1A5kPCqeEpvkS0qSDCc84V56+/woGo5pclCQd9uw=;
        b=krif/+lkD5hw9rPqvJDWaD+j+VQeLHJfD5Mp/pFfwrjQjBee4+65cJjVMxQ3VCBl4I
         +APRJpUkYebiq4LQtKq8PE363GwWBF4h31Hk/WuxxlIvs0Cuwe1gIDTr9Xpvh0Uz46QP
         ByhyN6Odzw4hk3ezTd/7Mvc83ywfXL5vRB2xg5CsLnajo2BWmkrcYbL58rr9z8PsPbbw
         RWX2EPQDUdgYVABxbsSRsCnYuJeKpduZ9Zq2yzZNyhFJF6cS2oPcEvZhsc2FCTC5sQuI
         rTDtft7lNyf2ycwcHMbx2fyGGAC7a88DxwMKI0dFZpYl5mEK0R1w/VCkIsOxTa+Y7riK
         Uayg==
X-Gm-Message-State: AOJu0Yxyv4WW7bUWDaMgjku4uuJADaqy8BLFtlutOFOZPqH198Ue5ldM
	etj4A3vdK0vW8TMC2dSRKA==
X-Google-Smtp-Source: AGHT+IEoAr6dXqLAHpqmd1Dg8MViO9ibFuLzxT2b+W8ygqu4NI2IAAxTliP/CtM0Lm8338Mg9O8/2g==
X-Received: by 2002:a05:600c:5115:b0:40c:6924:5172 with SMTP id o21-20020a05600c511500b0040c69245172mr3185004wms.92.1703005277195;
        Tue, 19 Dec 2023 09:01:17 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:16 -0800 (PST)
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
Subject: [PATCH v3 11/29] drm/rockchip: inno_hdmi: Remove YUV-based csc coefficents
Date: Tue, 19 Dec 2023 18:00:41 +0100
Message-ID: <20231219170100.188800-12-knaerzche@gmail.com>
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

Now that the unneeded support for YUV based input formats is gone, the csc
coefficients for those formats can be dropped as well.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - new patch

changes in v3:
 - none
	
 drivers/gpu/drm/rockchip/inno_hdmi.c | 37 ----------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 7c75feedacad..04344ee1265d 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -74,49 +74,12 @@ static struct inno_hdmi *connector_to_inno_hdmi(struct drm_connector *connector)
 }
 
 enum {
-	CSC_ITU601_16_235_TO_RGB_0_255_8BIT,
-	CSC_ITU601_0_255_TO_RGB_0_255_8BIT,
-	CSC_ITU709_16_235_TO_RGB_0_255_8BIT,
 	CSC_RGB_0_255_TO_ITU601_16_235_8BIT,
 	CSC_RGB_0_255_TO_ITU709_16_235_8BIT,
 	CSC_RGB_0_255_TO_RGB_16_235_8BIT,
 };
 
 static const char coeff_csc[][24] = {
-	/*
-	 * YUV2RGB:601 SD mode(Y[16:235], UV[16:240], RGB[0:255]):
-	 *   R = 1.164*Y + 1.596*V - 204
-	 *   G = 1.164*Y - 0.391*U - 0.813*V + 154
-	 *   B = 1.164*Y + 2.018*U - 258
-	 */
-	{
-		0x04, 0xa7, 0x00, 0x00, 0x06, 0x62, 0x02, 0xcc,
-		0x04, 0xa7, 0x11, 0x90, 0x13, 0x40, 0x00, 0x9a,
-		0x04, 0xa7, 0x08, 0x12, 0x00, 0x00, 0x03, 0x02
-	},
-	/*
-	 * YUV2RGB:601 SD mode(YUV[0:255],RGB[0:255]):
-	 *   R = Y + 1.402*V - 248
-	 *   G = Y - 0.344*U - 0.714*V + 135
-	 *   B = Y + 1.772*U - 227
-	 */
-	{
-		0x04, 0x00, 0x00, 0x00, 0x05, 0x9b, 0x02, 0xf8,
-		0x04, 0x00, 0x11, 0x60, 0x12, 0xdb, 0x00, 0x87,
-		0x04, 0x00, 0x07, 0x16, 0x00, 0x00, 0x02, 0xe3
-	},
-	/*
-	 * YUV2RGB:709 HD mode(Y[16:235],UV[16:240],RGB[0:255]):
-	 *   R = 1.164*Y + 1.793*V - 248
-	 *   G = 1.164*Y - 0.213*U - 0.534*V + 77
-	 *   B = 1.164*Y + 2.115*U - 289
-	 */
-	{
-		0x04, 0xa7, 0x00, 0x00, 0x07, 0x2c, 0x02, 0xf8,
-		0x04, 0xa7, 0x10, 0xda, 0x12, 0x22, 0x00, 0x4d,
-		0x04, 0xa7, 0x08, 0x74, 0x00, 0x00, 0x03, 0x21
-	},
-
 	/*
 	 * RGB2YUV:601 SD mode:
 	 *   Cb = -0.291G - 0.148R + 0.439B + 128
-- 
2.43.0


