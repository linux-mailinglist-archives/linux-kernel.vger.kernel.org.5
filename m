Return-Path: <linux-kernel+bounces-125840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94033892CF3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8BD1C214B2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153AE42A93;
	Sat, 30 Mar 2024 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fwAVkrzk"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7F1D526
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830469; cv=none; b=uooGCoqCkY6it+jX4akZGvbvG7FYh652phutL+Iqc3F7hyuN+fxKuJKteX/cs8DnjDMcMXrimYHY8ntgtnj9SY99xU3E9gu0ZMpc+dw1xTZJjDOpwty7hi9QWKl54G1QaNkPYxUFV1VfpeKh+0HSgjX/9SSC+mPK10+dIMZz/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830469; c=relaxed/simple;
	bh=5cQkb2VYon5nwSzv7bXk4MaMv6rme79Px3p6AE+Shu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hsl1RN2GLoMXHP8IedLk5tCKXpEJYX4cjHwooHjm5HxU+BBt0VuhdQ+OCORYDTjmJ5yw1Xg1GITlbC4MXdC9UWtKfxlKQwX5Zxi5pf70Gh/LNZc1ARIL1L8laZ7THi0lpUtrWxC7zU4ritBbTsS45QHVbX1cdlI8T85upJtSaSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fwAVkrzk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ff53528ceso2092404f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711830466; x=1712435266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gBZRypw7eFJBqOZhPqW7krS5T53iZPLz//P5NJv5yo=;
        b=fwAVkrzkr75VGJcXnuG3Fz9dxZjekQOOioplqRFtRUntKMofrsp+/+k33w3uK0A8Kg
         WmLOFNQc4dZTAXkI8VL3WWsptCYIsaPceJoostofko1FIu8hgwF85L04adFIDYFIoIB+
         dXDMcKF2mELMYFyrU+5H/T3vK5Xw8+NoDFTqFbz29CEjxYqg7l0mSR2vUAGy5bOHQTgO
         x2yFCCIlwd4WcMfyNROmEm1Ek23cIJLFrMEPxQv+owp7Zt4jNff7mS5ScJIlRA3t2Ln7
         6vmrCL99uIjl6xSweqbvcr0MJQFun4MDO4ew4WnGxlz9jFp4MYiDMpHfdmVrd5nM9KiX
         n+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830466; x=1712435266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gBZRypw7eFJBqOZhPqW7krS5T53iZPLz//P5NJv5yo=;
        b=eZFDDXzF/kMzhDq5Tt+NRQkbhsiMSm/yyMcONYm3q8jhmpLJZBavEvqfhZA0VwMA44
         mUcTTmIURu1UW0FzmUnflZMC7cpWsH/aYG9ASi3quxquND5MhaW+OIdBWZc/0A58tfiB
         t0kuRIvJvO5LSXZgoNyo+HG/dsfkXuMRO6+jctdADEfefB5OKFse3Ac4gq1kbzhkAjui
         t1NyKkeiH7zC+fcJF2PwI8c0S80+CzPmv5MZhdj5uVZuEBtqzn76rsG6G+c1lKlwBUwp
         zd/D4CvKMX6jMAkzL1aDa24WXR3IatvujwauoqMVWdSZ7Vs2wGXkQV6ohal5njG8X697
         IkLw==
X-Forwarded-Encrypted: i=1; AJvYcCW+Jr5XD4WAi2CwqTLjEVUQJ89g4OscsQx88M5814OXaK3w4jIxGXqEl1piBMoOa7m4FiRQjJAhjuhCX+1QRjqcUuM4hpp4S6Ss/J5u
X-Gm-Message-State: AOJu0YyJmG5/GWM4UahKznezVNHVZiDoimNiiWGFrWxAmKfcn6SkVZjn
	Q/DQ3wy+Qi08k795n5K0Nghs8X0SHOYP3itBIK2jfcx8BXi/oOVVcvLAFueFtsE=
X-Google-Smtp-Source: AGHT+IGiediON0ELikHy/elKnPO4WPe3ex+JoynxDpd5PfqunqrjvyVunhrRIHlUdtSG+VqRmnZhmg==
X-Received: by 2002:a05:600c:1c05:b0:415:456c:a17f with SMTP id j5-20020a05600c1c0500b00415456ca17fmr3563275wms.25.1711830465715;
        Sat, 30 Mar 2024 13:27:45 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600c46d100b0041409db0349sm9505616wmo.48.2024.03.30.13.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:27:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] drm/bridge: chipone-icn6211: drop driver owner assignment
Date: Sat, 30 Mar 2024 21:27:40 +0100
Message-Id: <20240330202741.83867-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in mipi_dsi_driver_register() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/bridge/chipone-icn6211.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 82d23e4df09e..43c1202701ee 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -783,7 +783,6 @@ static struct mipi_dsi_driver chipone_dsi_driver = {
 	.remove = chipone_dsi_remove,
 	.driver = {
 		.name = "chipone-icn6211",
-		.owner = THIS_MODULE,
 		.of_match_table = chipone_of_match,
 	},
 };
-- 
2.34.1


