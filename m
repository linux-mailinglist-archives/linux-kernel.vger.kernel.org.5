Return-Path: <linux-kernel+bounces-21522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D568290B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26024B26CD3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8FD3EA87;
	Tue,  9 Jan 2024 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giEdhK26"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F83EA74
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e4d1e0e5eso15182375e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704841630; x=1705446430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SB32//xbcW4q0bnp0pdqAtTjcsxtx9ia49ME4uFhsuI=;
        b=giEdhK26zqyzqw9zYaEOAPE7nzqp1A0cd/Z4R14GIefyFZZ7hrOf8XRjrpskX/ZLMu
         +T8xPsLDtepQM5gtpNupCcQvrFbSqhLTn2OBefcrXNifZc9uKtCScz8b5vHSS39hq1Mh
         rgK/1faOnZdBsTlYR6MT02PQu2Ca5+9kodpcgx7F/kZUWYpdJt972r9I57q1HJJgzns4
         rmJWvZxONtFMdYxvJ2FnfBPqQ05b2QxvCCUtUNLqsFz+oK8VzfeYe9wNCahQvsd8QNZE
         MOunrENzGD1qEYq7dEkTtBnhbwUn/ire0LdlQHxZLUO3OBYRVsUs9fAybZE4smST5Kjo
         J6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841630; x=1705446430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SB32//xbcW4q0bnp0pdqAtTjcsxtx9ia49ME4uFhsuI=;
        b=MM1vz3RRHX9YwEvj3pMEEu6lyZ++ukmCu/8EKddY+L3WIWAumtQ39/iKmCDJngEsnD
         e5VosiDCXgz5o/jDW/antmUgzPGuEPy5hf1mHuqx64TKRg2GzZbMre5W+P/51+WxLpY0
         3SQH1dXzcndPdfccALx1dkmjKnN9XQMDEC/terivsH1Mal08ghvJo3xMrmIywFAmEpkR
         XCfQ5K9n6T24+KNm1kO0eQHn6itSq9rOZSZB+MmXfhmmLsrbbBWJ3QWyy+2mv2pD1uO4
         5yc/hoigiK60WuOn/WZpQcSC5aZDZ4DWMdw/Jx5KTLiqjDiOqkRgyu7DeEWPvRO8vWdG
         Dnzg==
X-Gm-Message-State: AOJu0YzZBLsPWrsgec28V0jk/tqJ7P48K5sGPdwTO0/MtG6+Ih6ag7Eo
	C3YbykE3CipBSRdS7UgAyjE=
X-Google-Smtp-Source: AGHT+IE2PVEJT8mDhWzJ6iSvWvAbhYiuY5i/hdgn30vebpKJwshevCMFqAjmPMAfHgMekvj9Muzm+A==
X-Received: by 2002:a05:600c:3c8b:b0:40e:53f4:f979 with SMTP id bg11-20020a05600c3c8b00b0040e53f4f979mr22910wmb.164.1704841629893;
        Tue, 09 Jan 2024 15:07:09 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b0040e486bc0dfsm54021wmp.27.2024.01.09.15.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 15:07:09 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] drm/meson: vclk: fix calculation of 59.94 fractional rates
Date: Tue,  9 Jan 2024 23:07:04 +0000
Message-Id: <20240109230704.4120561-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Playing 4K media with 59.94 fractional rate (typically VP9) causes the screen to lose
sync with the following error reported in the system log:

[   89.610280] Fatal Error, invalid HDMI vclk freq 593406

Modetest shows the following:

3840x2160 59.94 3840 4016 4104 4400 2160 2168 2178 2250 593407 flags: xxxx, xxxx,
drm calculated value -------------------------------------^

Change the fractional rate calculation to stop DIV_ROUND_CLOSEST rounding down which
results in vclk freq failing to match correctly.

Fixes: e5fab2ec9ca4 ("drm/meson: vclk: add support for YUV420 setup")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
I'm unable to give a better mathematical description of the fix as I can barely read
code. The change was inspired by [0] which I chanced upon while looking at how other
dw-hdmi drivers handle fractional rates.

[0] https://github.com/torvalds/linux/commit/4f510aa10468954b1da4e94689c38ac6ea8d3627

 drivers/gpu/drm/meson/meson_vclk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 2a82119eb58e..2a942dc6a6dc 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -790,13 +790,13 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 				 FREQ_1000_1001(params[i].pixel_freq));
 		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
 				 i, params[i].phy_freq,
-				 FREQ_1000_1001(params[i].phy_freq/10)*10);
+				 FREQ_1000_1001(params[i].phy_freq/1000)*1000);
 		/* Match strict frequency */
 		if (phy_freq == params[i].phy_freq &&
 		    vclk_freq == params[i].vclk_freq)
 			return MODE_OK;
 		/* Match 1000/1001 variant */
-		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
+		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/1000)*1000) &&
 		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
 			return MODE_OK;
 	}
@@ -1070,7 +1070,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
 		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
+		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/1000)*1000) &&
 		    (vclk_freq == params[freq].vclk_freq ||
 		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
 			if (vclk_freq != params[freq].vclk_freq)
-- 
2.34.1


