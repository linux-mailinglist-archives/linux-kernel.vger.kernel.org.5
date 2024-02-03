Return-Path: <linux-kernel+bounces-51202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22C8487B7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7792825CF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92065FDB1;
	Sat,  3 Feb 2024 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoKXYxnD"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24A5F85B;
	Sat,  3 Feb 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979279; cv=none; b=EZ5mdL+SK2m5lsVfGPb3Lhuoopel66GvM+hwpafqbqpRIBxvd6KEjZjHqLpKObz6uXI/FBr1zNWWak1a/aHdF5Kmqjjvj9R9xbbA8hudQQpMCwEc94Bw0QFvHgtt0WTyjN/plwEWLdV87R19f5z12B5/ZrP42q8aUsMRgD9is28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979279; c=relaxed/simple;
	bh=EfxmtEkbo9lCm+BJRom2AXAVkSHkbXCkdqAhzEcn49Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZrUwcAOKSHOdAUrQ1sWbUFU5E8k301lwBfxNlJr2qJE+NT3OCZa1Sjv8sgfn9aWI//nxfRZ/mnxWsS9FCSZKWhoAuvZrVJMy1wEJ6QtpctBXOGOXDPOJxEpK7cZF/oDukXXywJ3dvSkxcLDtvMn3iAx04exCVZoT6hcuBPxEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoKXYxnD; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-363b8429f03so4019385ab.1;
        Sat, 03 Feb 2024 08:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706979276; x=1707584076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyFysKI+ulqGIrIVYWeP6alGWB5geZ7uKPOowV05Tlo=;
        b=VoKXYxnD+w8H1qOyVPibYRrbrSuas4+F0M7ZGGDv3rUR4XBF85Zi6OAt57tH5odY2g
         o30iDHXht0yqEdigbxaDSU+onXLXCcUF7NsvE+Xv6NdFjV8kkSGGKdJnQ+XFWuTumWMT
         9ykQvCDp9ETmbrfb2g87WI76eUmM8mub33SY0CCYn03sySP1GNwJxFeLOMYO3Spdh5PK
         hV1khHOx28aRykVv+7AJzYKqZf0aqUXPt2f1orojsjE0KFIFCcfABXTJQ8BkDIF+k3rH
         DsL5RKpbkJEWucxtSc+8wMBl4d0LaVaU0em2uO6YxIJENvahQv5XA6tGqAFqXBBLY+Nl
         QTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706979276; x=1707584076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyFysKI+ulqGIrIVYWeP6alGWB5geZ7uKPOowV05Tlo=;
        b=pIEmNKBeGbOqWKH6RHPRlYZibzXkaD67YRN1rq9oXgBtlKj3wQT36Rt8dcGtk+br/i
         4sE7kVC5acsDT2FSlA8StAd1+ivzBoWl8vBy7k6L1k9wqfQimVx1K1QtYZdJBLfcU1pi
         fbkJsZYGdLWqH01OaOhiD5Rl9FRT3hoEJxna2yji9nYn82hGIJxUlyM0sCPl/oHsUauv
         izL4h+mNPlWytnYJKhKW/Kd6F7GWObdR8xAuFt+ZVDxbXVwdqy0fnM0dUvlL9dkg52oM
         1UaeBvmaM3D9/y/EPW61msycSyn5EOJQdid0pzIQy4kA8DjnmZjIJkkY6Iq2OvyBZuXD
         ZbuA==
X-Gm-Message-State: AOJu0Yx07j22DCxHQpyGSCDRglmRH/QqNi/5GjE6/9AHoF8gCYvEgOHF
	rwxKxNlpDPLWrTO5QU2oM8vIJiudAUpZEFSb7HdfMb5iE7wGz5lb
X-Google-Smtp-Source: AGHT+IF1aACYQI7zwb4q5hLiUZpptfXorBFS4iS5gGCHnkIEhvZqaIY+gUX6CxiigB4ll3DqgkpL/w==
X-Received: by 2002:a05:6e02:1d01:b0:363:ac17:f529 with SMTP id i1-20020a056e021d0100b00363ac17f529mr8191065ila.9.1706979276564;
        Sat, 03 Feb 2024 08:54:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVljTFGqHUSDda9IQphGIjLtMyFUmJsD5/fnOAFZYp2KpiC41NPfYVmEJNncZEAjdeLOrMUzdpOV5TbIlRuJLdiUGYnrmJbe41q13QCeCPiB4j+CHYs8WDll/NAuhl3pkt3eXzSWivXd/aXcCDCFBeeLXBvU9kyEhEqZZ/eUrewxxe2CwctMrTQYkJRL0xNw2AK3RX4xAeRXReeeWiCLNTAonyxyEAH4iiwBktEmXvbCu6eh58loDAY78XJsgrBp0gxfxxSB3KpbxvbznhG6ugQy0RHkFGg8ADrXOhxL7TPQBSRu2IqAyPopNRGXlwlzsOwD0Hg4RD8Ln2fjUD7uNk368Z1ZtaOuXnh/Z/g/W1hEnPiFUzLtP57Hl+G68yJ9OmYP5X0GGiMfmxdXJ3aa6YX+YTrhkgbUnjIPe4tBXyaNp2UN+qUZi8bGhE9ah9VRB6zKxAdunomFwGVngvOAwa5B9Dx2PILpUY0bfyN/ir6lzJCrsuyXO1o8F5T9S1cfriObbMiEPNHZa0qZ2okO/1w9JJj2sJ2sim4jLAsTOFDq+e/qxSfM9C6RI0bJImP57JqQg1G7O2wzDofYy+mf0ZuTCNYTHnAOIbqeAqvy896QqFaulKzd9yWq8IR99RiUFkRL0gJHob+80GOrvW5AJiQWS62k5Mtbh3O7ckOQfNveRcTw/E7XU5SouMLkcvsAdO5ePF12rv1Pzj3rLeMcHfyYgaWxiGs0i+IubvfyBABcO6xRt7LEHpYJijivKUpwW7juAGu939vJs0Fr/ebqBENphxakW6KwZYGtPja8EAxdRr9fVlrzgckTLX/szX2NxeyohtcmqIoPvt2vp1ld/eL258lQbGt3DiDGzr5ALeTbchKxeNt8vqIXl2zrSO9E6OcB+md7JB40W5GI9ByeKZI9AiA5d3NXhDNU81E7wOZt8PjCKtoWtF84pbIkA+2cKoD0g
 3XwtNaf3IbP/ifREnAcq+5U3JXWrBWvuZg4Lm5VzSB+3EXvlL8OCnXdfpE5mp2peJ6R+cYt7c7baJLe25xPG0v4H8XAwA/pNVH1YuvC8oPK7Snx4QC/qXMw7M5l1WQN55hX+TVd5z6XkZX6KnyRHUiSMPvb17dSTk7B3F7ldYrcx+JrSkuAmx2OMjXShCBwUA2xbCQGwRrMBEp833JC+DPrJ1ZRzus5Q==
Received: from aford-System-Version.lan ([2601:447:d002:5be:d9b2:bb4f:5531:6aa9])
        by smtp.gmail.com with ESMTPSA id t30-20020a05663836de00b00470b29b82b1sm1086256jau.154.2024.02.03.08.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:54:32 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	alexander.stein@ew.tq-group.com,
	frieder.schrempf@kontron.de,
	Adam Ford <aford173@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Liu Ying <victor.liu@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V8 12/12] arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
Date: Sat,  3 Feb 2024 10:52:52 -0600
Message-ID: <20240203165307.7806-13-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203165307.7806-1-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX8M Plus has support for an HDMI transmitter.  The
video is genereated by lcdif3, routed to the hdmi parallel
video interface, then fed to a DW HDMI bridge to support
up to 4K video output.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..3e33825f0ed7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -880,6 +880,7 @@ CONFIG_DRM_ANALOGIX_ANX7625=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_DRM_CDNS_MHDP8546=m
+CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE=m
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=m
 CONFIG_DRM_IMX_DCSS=m
-- 
2.43.0


