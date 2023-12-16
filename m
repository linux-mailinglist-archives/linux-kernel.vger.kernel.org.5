Return-Path: <linux-kernel+bounces-2035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E0D81572D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598441C2459D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBB10A39;
	Sat, 16 Dec 2023 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkaAgdu0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3B10953;
	Sat, 16 Dec 2023 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d9d307a732so977722a34.1;
        Fri, 15 Dec 2023 20:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702699631; x=1703304431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lh1fPASUA2RVK3PUb6yIztNzpjqxC47uH/J5SJ+A7yY=;
        b=QkaAgdu0TxJztWJF7AQPUjHia/ywruRw7xFzyJR6uBQz9ySX9rtCw/fHNgbTVl88cN
         vL+JAUM92yOaEqEpLRSrvY7+jqRx78D54YTOPs8RJSuJoVjxEdk+EBTe+QxkB76HgWvI
         +hqVTFhrk+hD5xI9pjCNnmbs8tn7Ql/855uJYGEIRIJUIWIV5aVjarMHRZGBkpmDJG24
         RhsPgpVAAAbzgSxyd0Ag6TipdE4secb8KJpn10w6fEOggw89coolxI5UPIuKMoOzjq/v
         fYqCu6E4glunHy8pGRadH6+IB2mN8DXz/8ROOu1sWxzkDsNlv8r6aRVZkZoNP4k7PwM4
         BRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702699631; x=1703304431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lh1fPASUA2RVK3PUb6yIztNzpjqxC47uH/J5SJ+A7yY=;
        b=cgOexhWC5S2Q+cA9yWVE/cQ9qmX/LrJ2/e/QWTIHh2AwC+gzchSUZRoeFNXEvVxmbw
         Ubas3boTWCqq94D8+x0MkqzYcYfPYvh/edHEtvnyDglqLUAt8+klztp71RTaDJOXyn0U
         hYkYfECEIsy2APza3kDf5+C6+CbzKZRIec4TutfTLxq6n6+VBClBMklSml1Ee5HoBRqz
         c+FueEX9tTu8EzEXe4B3qNjHUgxrxPjazYZzLNkYHY+FSlaXdreJW1t8U3uEi7P0TpFG
         78O5JyoIAiz9okHzIUGS82UvkYQwIvYGrZyQUBTB8PxqQ+kSvqGCsA94jvY/DS9tVY/v
         CKGA==
X-Gm-Message-State: AOJu0YxkUpnLOzPgYLJ7yc2hCV8ma9eRLBubqK7H40SVLpoo5teXFE2y
	LPaOuynDYMihS5xvwQ0vdpc=
X-Google-Smtp-Source: AGHT+IFcAdimm0eRg4pVwTxwgiiokcG0S1CDTXH57Tb0zgAxZ+ctCXVTXDZ7OB/TWvwa9DxP8a2jLQ==
X-Received: by 2002:a9d:6297:0:b0:6d9:cf49:f5e2 with SMTP id x23-20020a9d6297000000b006d9cf49f5e2mr12531859otk.19.1702699630980;
        Fri, 15 Dec 2023 20:07:10 -0800 (PST)
Received: from buildbot-shaka.infra.immortalwrt.org ([38.150.14.243])
        by smtp.gmail.com with ESMTPSA id f26-20020aa79d9a000000b006cb94825843sm14216936pfq.180.2023.12.15.20.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 20:07:10 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Tianling Shen <cnsztl@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: configure pad driver strength for orangepi r1 plus lts
Date: Sat, 16 Dec 2023 12:07:23 +0800
Message-ID: <20231216040723.17864-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default strength is not enough to provide stable connection
under 3.3v LDO voltage.

Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi R1 Plus LTS")

Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
index 5d7d567283e5..4237f2ee8fee 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
@@ -26,9 +26,11 @@ yt8531c: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 
+			motorcomm,auto-sleep-disabled;
 			motorcomm,clk-out-frequency-hz = <125000000>;
 			motorcomm,keep-pll-enabled;
-			motorcomm,auto-sleep-disabled;
+			motorcomm,rx-clk-drv-microamp = <5020>;
+			motorcomm,rx-data-drv-microamp = <5020>;
 
 			pinctrl-0 = <&eth_phy_reset_pin>;
 			pinctrl-names = "default";
-- 
2.43.0


