Return-Path: <linux-kernel+bounces-17521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CEC824ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFBF1C226CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69A1DFE8;
	Fri,  5 Jan 2024 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrkYppV7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB5524C;
	Fri,  5 Jan 2024 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-556aa7fe765so1392683a12.2;
        Thu, 04 Jan 2024 22:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704437596; x=1705042396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gs6Zdo5lqPMyDcy2Y9AErHFR4G8ZNcqDUY2nx2C99rw=;
        b=RrkYppV7GS5pAgoWjULWHTkXfxsqthD+EjVrcHBbkIOZI1UDZp3qqafR2sVTbjLZOF
         WC2EflvjsHg2aB8jTTESeFTzmNLVTeX2nOzFbVZdsrwvL1j+LNEab3O/6TgoJ09Xl1zH
         52fo1OovpxyofJaj9IfAWCTx5K+cjSuLL9rYwQeObMcy2DtJn0NTzFQjRe8TlWzsdCp6
         aYbEBY8o2mglDlEWzFz/KzXh0E2wqNZc+Rv/AAT+OVngo60H13y0FHY4+ge9KiB25zW4
         Bi/Y/iXNuPIpynZOcsaw2mX522e66TS/LUhdI7+tXp85FKPxqhDvginwbQDVPdy9bYgd
         WA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704437596; x=1705042396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gs6Zdo5lqPMyDcy2Y9AErHFR4G8ZNcqDUY2nx2C99rw=;
        b=BA6USypRFJsV8uORtrr5ygRMw0zq0+rGGOtrnRWbmwVKOGoawaBFB8x3ksAbxVbddO
         Tu4OMLRTVrLV0cKznZ84/DFiDeYFbRoolNoyA2F5BCY21xHlPzz38ewgsvzVqkz2LRyh
         cQF8PmBzsMpwO9KCYxzvEZfCZHQL/P30+ZQYWX66tVUUmUIlNWbIrz1n32CSd5yZ+6Ee
         yRaBerZ6SSkHKtB5oEkDMGTH96uPqn6aeVMIaGs3WaRoncEwBDts3APNwP21fBlyaV7M
         c3MoAn/OGgp3dUMHpO8nof1bwkE7IJFXRa2y8+E5LR/iu+zkh13nYdZXRG5Pn+nSmEBN
         8E1Q==
X-Gm-Message-State: AOJu0YxmfRQKu6M28hx4lZDYTCL+WXFUc/WFuELNn4y9UhA2nH6BukLy
	muyK7tJ9bFgbC83irV8SOn0=
X-Google-Smtp-Source: AGHT+IGK9xkg0CCNYNDKzTYncS8IxaFYD6jd3LQSs6N1y6nKezYqqpIO5ypVgZmxqvaMktFrE99/jA==
X-Received: by 2002:a17:906:c55:b0:a28:77b:bb36 with SMTP id t21-20020a1709060c5500b00a28077bbb36mr797610ejf.134.1704437595580;
        Thu, 04 Jan 2024 22:53:15 -0800 (PST)
Received: from hex.my.domain (83.11.207.119.ipv4.supernova.orange.pl. [83.11.207.119])
        by smtp.gmail.com with ESMTPSA id g23-20020a17090669d700b00a28e2b72db2sm518809ejs.56.2024.01.04.22.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 22:53:15 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 05 Jan 2024 07:53:01 +0100
Subject: [PATCH v2 1/2] ARM: dts: exynos4212-tab3: add samsung,invert-vclk
 flag to fimd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-tab3-display-fixes-v2-1-904d1207bf6f@gmail.com>
References: <20240105-tab3-display-fixes-v2-0-904d1207bf6f@gmail.com>
In-Reply-To: <20240105-tab3-display-fixes-v2-0-904d1207bf6f@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704437592; l=860;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=Hj/KIXM8+wrf3C6zb6NPg6hk9u+G2N6Miq9I309cmwA=;
 b=y9TBDXAW40WhQZ9RyljbqE9HKhzBXZ64rvQTNoPAID3ula15xCJhQhW/2iksx6g5BkUiOZ9Zd
 PdpWEQ9LjCzDZWJLsH+POGdfXFFhAi1McL/WcJTJJjyZwgTczWGXKVr
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

After more investigation, I've found that it's not the panel driver
config that needs to be modified to invert the data polarity, but
the FIMD config.

Add the missing invert-vclk option that is required to get the display
to work correctly.

Fixes: ee37a457af1d ("ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0 boards")
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index d7954ff466b4..e5254e32aa8f 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -434,6 +434,7 @@ &exynos_usbphy {
 };
 
 &fimd {
+	samsung,invert-vclk;
 	status = "okay";
 };
 

-- 
2.43.0


