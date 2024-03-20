Return-Path: <linux-kernel+bounces-109012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F611881359
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FF1B23EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC7E47F4D;
	Wed, 20 Mar 2024 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTVmsdtW"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13815848E;
	Wed, 20 Mar 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945044; cv=none; b=KLXulYnKAAOYZb7rQDRe4dktTBPaVrgdCRT2LRQ79xRXedYdZDyV3vLFQ+LQpz+VVA8nXkkk0HLn76/Fe4djo1QbNd8XnwhZ0x9dRsHE1qtmRFDIxT5LT1nBkBF0cB1IMbaEVz5pqCjTjAznOVzgk7X1Q65KnSA+RfyK9h1+Alo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945044; c=relaxed/simple;
	bh=zrfVyRY5tL0TunSwp7D8tq7oxVUsmAzsyiCykPlmTnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nrp/hN4DglxRxT/6YqKME53cMPNqhJzCMfq9Sn1FfoH77Bd9PPz8g6P3O8EVed/TWWqa0X3b7KWbkQ/GP+QwY81LLofNuFKi6RUuWHJgm19mtf2KGT+grMauBKoNsEA+bW/kB7zXnNVAwxgeAjAIGq9lSdfc+M5IuDz6Tu7Zlu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTVmsdtW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46a7208eedso595720666b.0;
        Wed, 20 Mar 2024 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710945041; x=1711549841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aI/xdfnQChwGM+0xeXeUgfzkjQ2ZUFhMzealK0WWSK8=;
        b=DTVmsdtWUmeiuQXmPwx3O8pTDtQNQ0ng5I2dITrHJQoEvcFwDuICMuz39oUBTlP03K
         Gd8PLl0bGH7q8bxC8063DBtOI8Yun7/f3D5X4nng1E+92vontkSQsMkEQRT5QQAY7eyS
         KBoOGlVdReaIQdi/fYrjMF4FRO47JwiFf4dHs2bbs2APlhgRGT2mcm3zFtztOqzHdOhU
         0K7MjdbrpXjozjRcwiI3Fu5f5P/HHJwhKwOXR0kT+VMrgjGANAEbtvrKYQgZ6FpnDybZ
         9yL+zl7xmi7VVEC3Twi+Zs9D8hj5ic640XWoF6+UyqDkkNAY8Btxf22SmpZsTMQNILD+
         gZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710945041; x=1711549841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aI/xdfnQChwGM+0xeXeUgfzkjQ2ZUFhMzealK0WWSK8=;
        b=C1/NBjCqwZmWHz4g21sq4l6fTwhVeDd9iwCqncBB+N05QeuGoQqjcT1ZDE8bjE7bhI
         Yl8KX04CyyA6il4VI7mAtNG9i2cRGbhyyFB1PimRWbJySSad4R6WwuUTjcrzJFxjDskB
         V0ttS8Gy90jvZBWAfkUo5Ys5DaokzufZMTk2nfpxjfcTzPskGAdNRESvQM/hv4HQYqHx
         WBbSbzI3iDDVsGgx929cT4Q9QraJmbySOrFHTLWBqPq4XSZM3qzlbWre5UbGpH5yASMi
         wzbxZd56aeUV/DCzpRqsG+jA3LBBxL7bpSBE9jGHppE7yRBKRCDvcOEOjk+/hioNfec8
         DkJw==
X-Forwarded-Encrypted: i=1; AJvYcCWyf/oKBoFoSq/ZNkAeRTuzIGBNH5f4kXM2FT9MznJud4pUegYICEpMAaz72sO2mroVhGPVIlGwyEbPxpKGlnG6P50K2uxv3+WReBIhDiq6UF7ZRsPUM8YwaYev3l5FmWvqQP70irXtnHXoTloXRuiBPXsKeMmlGbGIy0QbeOf9Ww==
X-Gm-Message-State: AOJu0Ywg5m2gO9iKWlMS/n60xqw4pGmBArG2Hw+8hM9RIWfwePYHWNuv
	jGklDMG13UkCKTTd9VJUCJ88nRfp1H8YX7by9k+BhQInQNEdoUz7
X-Google-Smtp-Source: AGHT+IHZkG6EvpcQLZ/q8cZUoQjNhtFlYTceRTfWxbzEKFSIBzBThSG3aJZYDEow2oePlcW/pxhgvg==
X-Received: by 2002:a17:906:ef0c:b0:a46:c01b:7e2c with SMTP id f12-20020a170906ef0c00b00a46c01b7e2cmr7612185ejs.75.1710945041157;
        Wed, 20 Mar 2024 07:30:41 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906469200b00a46f69a43a8sm745514ejr.184.2024.03.20.07.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:30:40 -0700 (PDT)
From: max.oss.09@gmail.com
To: max.krummenacher@toradex.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	francesco.dolcini@toradex.com,
	kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nm@ti.com,
	robh+dt@kernel.org,
	vigneshr@ti.com,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: ti: verdin-am62: Set memory size to 2gb
Date: Wed, 20 Mar 2024 15:29:37 +0100
Message-ID: <20240320142937.2028707-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

The maximum DDR RAM size stuffed on the Verdin AM62 is 2GB,
correct the memory node accordingly.

Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
Cc: stable@vger.kernel.org
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index e8d8857ad51f..8c837467069b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -76,7 +76,7 @@ verdin_key_wakeup: key-wakeup {
 
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0x00000000 0x80000000 0x00000000 0x40000000>; /* 1G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>; /* 2G RAM */
 	};
 
 	opp-table {
-- 
2.42.0


