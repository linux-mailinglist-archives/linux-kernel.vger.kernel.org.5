Return-Path: <linux-kernel+bounces-9960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03781CDEA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1E01F234CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA1233069;
	Fri, 22 Dec 2023 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIHED4K/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CEC2FC5B;
	Fri, 22 Dec 2023 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336755f1688so1824551f8f.0;
        Fri, 22 Dec 2023 09:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266950; x=1703871750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvwlyAlnXeNL9AzDIrE6gEzR9A8598VoqwlyqljJPww=;
        b=mIHED4K/XVxWagcSpVCqUAMd/NOEuH+mtHLhJljAtZ07jZI9P/IAlSqg8KbJCC0Mj/
         lVb5IxBfnEWGdsKAM8tg4IY185AxWGeS4OTF4LKpUfRWAQ5rUGD9C0eBpfas0eVR2Rzb
         nIQCM0G/rGUmQgP3BM7KXrnn8OB6EOxNbgp+7f37Q2708GKs0hPmv6G8PUA0KgP+R6w3
         MD5iV5oMsdwp0Bcx5zOxVrxakeohclaWc3/0p38IWwZd8OFp7kZRGURRp6CvW06hQDg/
         ldcJWBy8/m3cRluSFBaOX/qpHck82Ynx2dwzQcTDORe1nQbBuaSKa053WAn2uTvbx5Ve
         atsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266950; x=1703871750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvwlyAlnXeNL9AzDIrE6gEzR9A8598VoqwlyqljJPww=;
        b=BTdqBA2dytuCcjm9VEBLz0lZpW0R1GF50uYXcTZGB9LaphMF5wP/O4RVVqSf88UanV
         yUugCrPwhh2gyLREb3HAnLPtJeB1f9n9OuZU6MUx83QMx15vYZq7G0eQVS8tWQ587U6D
         H8cW/8uew86y7sfbHEirsIvvAG2Hgqrgn53n4j24GzNRPrL5scPnF/Xs2Ibk0EUDriFA
         D3NK/cMAVcRdLsdV9lrAgkOE5lx8CsmRzEh/O/KBfh0L6ZFOYyEbOcK8ewE72s5dHBuw
         rV3hsXaH5meTZbJ3n3+Oc/YcLjNO56aa9ztzS9S3z8Lg1tLSDl2yu3ubOqqXfR1CxWU+
         yHgQ==
X-Gm-Message-State: AOJu0YxOEWQlPilidy3WK7AIi7R7W3mMfNtzky1BU2D3J01XAeIDL4u2
	aPjHf77ERIlliLetEDOESQ==
X-Google-Smtp-Source: AGHT+IFlH1FXt4AEcnW4RXoWxNep1h0V1fV019/19FThEs51/7Aby/yM7fFwgKONy2ZfswfDCXMW+w==
X-Received: by 2002:adf:cd89:0:b0:334:b2bb:6d1e with SMTP id q9-20020adfcd89000000b00334b2bb6d1emr1133231wrj.17.1703266950277;
        Fri, 22 Dec 2023 09:42:30 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:29 -0800 (PST)
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
Subject: [PATCH v4 11/29] drm/rockchip: inno_hdmi: Remove YUV-based csc coefficents
Date: Fri, 22 Dec 2023 18:42:02 +0100
Message-ID: <20231222174220.55249-12-knaerzche@gmail.com>
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

Now that the unneeded support for YUV based input formats is gone, the csc
coefficients for those formats can be dropped as well.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - new patch

changes in v3:
 - none

changes in v4:
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


