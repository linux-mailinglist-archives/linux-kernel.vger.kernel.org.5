Return-Path: <linux-kernel+bounces-2373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5A6815BD7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA3D1C21954
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01353527D;
	Sat, 16 Dec 2023 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2WDYNMf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE24D3527E;
	Sat, 16 Dec 2023 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40b5155e154so22232625e9.3;
        Sat, 16 Dec 2023 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702761716; x=1703366516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep6QV7S0LD+l2v1oGCSbwLCeiUsCxqLVqe3qakJ/WRg=;
        b=c2WDYNMfxaRxXEeIk4OGBqyhuLof+iZLr/lrwY1HeZLYH3kSJyovR3/EaCqYTyhHMW
         lkQIubnoiySz6i18v77huwAp/4xedbi7RLO30TNGLApszatPVMTlceE6BO9sdVB4KfoT
         yGUNPieO/kcGXKCfSTakwldqiJBBe5lq67PjBKvs2rl0wOVo8BklrEB3QJNR/+kU38Qc
         65Yz1tfYw+OvHo1c3mHrPJ8udxDWm+5Aqxg6xA6QyuCXEGll0oyKzMh/0/n5Er+tJCix
         7WYlrLR314GdbUwASQJLptgIEAtFoBeTo1htfErYP4aOuS1juyNCGJ7Fzyi6/8dqK5oZ
         uqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702761716; x=1703366516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ep6QV7S0LD+l2v1oGCSbwLCeiUsCxqLVqe3qakJ/WRg=;
        b=WKFXMAkKQpQLFQjKk50PyfPTqy2IBzlmWrzWB1cmz66Uf+CB626So5biI9mZVsipaq
         ucwZUUe35KQ7zzIbuzehD0pXPbaMohWWUKLB/Z1vz26Sk8CGuLnR7/SpuKrtho+ZFE6R
         OoWJAxmLnY71qN/nBWMKaifdU0a7Qx+grz/u0gsv25qqQpW3uR9Js2BsxVbgG+aK2xAj
         lYI90NsL3qgBWmcG52GHPjjbXEkF4FbvFqDvVx3aG+7D0SNtgYKn3mW80pG6B6BVdCx9
         fFi6eRfTgSJJf9HQ/IbC91rxHSjOTQOlOZN6gfXXB5Zruku1y2BYf3viDqGOB+qbkmda
         /QlQ==
X-Gm-Message-State: AOJu0YyWU4NAQc2OHQmxyrbhHM5+C+TKjIjixyx1azVAwjjqL3YUHQGK
	2kBwGImyS4w2YJwEN9OSeGRI7gJwjgR8PQ==
X-Google-Smtp-Source: AGHT+IG7B+FTcFzeYXt/n4qfZysDGamT9Gb/+0TSs44EIYdfPhgymDIRV2BJdHte+Snez1QdL4VB3A==
X-Received: by 2002:a05:600c:444a:b0:40c:6e2a:70b with SMTP id v10-20020a05600c444a00b0040c6e2a070bmr1307239wmn.12.1702761716244;
        Sat, 16 Dec 2023 13:21:56 -0800 (PST)
Received: from apple.sigmaris.info ([2a02:8010:6606:0:c984:6cfa:50ea:c4cb])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b0040c6b667dccsm8166767wmq.25.2023.12.16.13.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 13:21:56 -0800 (PST)
From: Hugh Cole-Baker <sigmaris@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Hugh Cole-Baker <sigmaris@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Support poweroff on NanoPC-T6
Date: Sat, 16 Dec 2023 21:21:34 +0000
Message-Id: <20231216212134.23314-1-sigmaris@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK806 on the NanoPC-T6 can be used to power on/off the whole board.
Mark it as the system power controller.

Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index 612107615e66..0fc48fb0d34d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -569,6 +569,8 @@ pmic@0 {
 		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 
+		system-power-controller;
+
 		vcc1-supply = <&vcc4v0_sys>;
 		vcc2-supply = <&vcc4v0_sys>;
 		vcc3-supply = <&vcc4v0_sys>;
-- 
2.39.3 (Apple Git-145)


