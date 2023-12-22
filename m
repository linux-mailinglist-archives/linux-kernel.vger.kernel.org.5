Return-Path: <linux-kernel+bounces-9970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571C381CDFF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C291E1F21E11
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86CC446B3;
	Fri, 22 Dec 2023 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LevdbF8H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85533A8CB;
	Fri, 22 Dec 2023 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so1845487f8f.0;
        Fri, 22 Dec 2023 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266957; x=1703871757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qEiW87NdWMqG1i3IC5TsTsEJY+4saJvfxd4Py7tBWk=;
        b=LevdbF8H8aKPQSKZzVdn4GfVcUq1oo9ngdsz9kCh1qajfv1ufrBjDn92UH9enaTQ9c
         hnH46PkparVDBMVLMMD3EEz77bYaCbkbjMytpo4KeArCE4E3ps7NTPQF1PEwqXdpVopY
         tMI7bbCI/xXCQ5Ygp2zAMxMK/LDR12sw6P7KT2Unf7fU32otdPW5rGHZLa36XvcqrK56
         GXCnkJwptGHNpLy4kn4yt6gAhUEbILwkk6z4jAuhOQ1DTD0TNXvjDe3meoO9TpTz5uz8
         3ElQMpEtVWxV4ljGjv26lj5Ksat3LBtz6aC5S3hfCIYhFzdjt5IMARUc/VBExHlHmR95
         Au0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266957; x=1703871757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qEiW87NdWMqG1i3IC5TsTsEJY+4saJvfxd4Py7tBWk=;
        b=aewNuYm5pEcIFPrR4CqPs+SVPwcxrLnNmGXGdtpEMq//sqJQc9ppdVoz0xlfeM04Ic
         vUzk5XWdalV9yEuML7bjAOOPgfPAzCwPoI33qDiNA0/pX1hw0OAoAm4xitzu08Mow4GU
         zqdQnt7BTTrRYS3ZFmfxUrMhNAK022dBWgPQ5NZRtH7w5I8C8ZEI0yXZBFLOxo7+pt5F
         DWJqMXaa83yCD7PDKCvHD5cWIxJ78Mdp1Sh1Omr97FNQ6QOi4FzZbR6cqLmL19/OOfxa
         QXSqwBfOIODrFJyP09ERhjDkSigfD8lTyl4YnEByGiFfcNA4GoA6q/JTpHEA6nzHMU9R
         AnVw==
X-Gm-Message-State: AOJu0YwwOlf11n/kUb00Mm/P8bHpmtlGuQmTpUzc9E0B6X1unJ6lZV7H
	i+CMqBdXC1Wx/j/C8d3iYQ==
X-Google-Smtp-Source: AGHT+IF/ILntBURjV10Ff56yN/onR9KNU6i4awRUbCKr+V/5OKfVGrXyAKwoOVxh00kqNwRL7i24VQ==
X-Received: by 2002:adf:dd8b:0:b0:336:8940:c4dd with SMTP id x11-20020adfdd8b000000b003368940c4ddmr968833wrl.8.1703266957184;
        Fri, 22 Dec 2023 09:42:37 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:36 -0800 (PST)
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
Subject: [PATCH v4 21/29] drm/rockchip: inno_hdmi: Don't power up the phy after resetting
Date: Fri, 22 Dec 2023 18:42:12 +0100
Message-ID: <20231222174220.55249-22-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222174220.55249-1-knaerzche@gmail.com>
References: <20231222174220.55249-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

inno_hdmi_reset is only ever called when initializing the controller. At
this point it’s completely uneccessary to power up the PHY, since all
what has to work at this point is the DDC bus. The phy will be powered up
correctly when a mode is set in inno_hdmi_encoder_enable and disabled in
inno_hdmi_encoder_disable.
Set it to LOWER_PWR after resetting the controller.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v3:
 - new patch

changes in v4:
 - none

 drivers/gpu/drm/rockchip/inno_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index f3b90b479ab9..52b49f44a4f4 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -202,7 +202,7 @@ static void inno_hdmi_reset(struct inno_hdmi *hdmi)
 	val = v_REG_CLK_INV | v_REG_CLK_SOURCE_SYS | v_PWR_ON | v_INT_POL_HIGH;
 	hdmi_modb(hdmi, HDMI_SYS_CTRL, msk, val);
 
-	inno_hdmi_set_pwr_mode(hdmi, NORMAL);
+	inno_hdmi_set_pwr_mode(hdmi, LOWER_PWR);
 }
 
 static void inno_hdmi_disable_frame(struct inno_hdmi *hdmi,
-- 
2.43.0


