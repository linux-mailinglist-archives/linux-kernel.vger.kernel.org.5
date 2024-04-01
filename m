Return-Path: <linux-kernel+bounces-126510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999C18938D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE00F28175C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C6C127;
	Mon,  1 Apr 2024 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbPiyms8"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DBE8BF0;
	Mon,  1 Apr 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711959229; cv=none; b=nRA/n/p2RG/xdeiAozY8gWn4EZTPrZY1WmB5tLC9nTq9j4AsqG95urDltp65aCtNIvyGkK3Yg939d0Z3r/6BpthQ/vxAAJj4D5ppFGyRE9e9AAldZEBKllIqK2kUIHjPafjNNPVxdULEe1154Qjh4Pw0PCyyVMqK7i95pIR+Jh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711959229; c=relaxed/simple;
	bh=EmOBM/0uJprbcekt/hql8SXwoNf6xXb8BYAWyWp7SoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kyOGAyxsPRCY1BIbOVnQ2kn8CKAemi9t70yo3ny3y4HyrSCQ4bZoa5MnhA8msvl6IRm6gvTZiheHDi6NgnwGX836yziLcAeIv1qfXe/JMzofH3Wiq0IjOtHOmOCN7My6QRgfgIuuy2LONNAAuHbXquBY3xCuxApUi1cIl20+nF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbPiyms8; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a7a4119d02so950063eaf.1;
        Mon, 01 Apr 2024 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711959226; x=1712564026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cej9zpiWpk2htv89hye5Ck+sNEHdHBz2DKWSX4aWhq4=;
        b=WbPiyms8mQ8KonqQPEttbw43kZX733zDIY+GdqGKY9UJOUD+u8xFcg2aeIZz7CxcZ0
         XMuHPck95ucRTzkdDKv5/xfrCZptvrp+AO+R5M/PeVbvir7VCB+OwzdoDsPs0vTaiKGm
         K74d3vhatmLQNbh2AH7IMbVDb8byQF6Im4qKcqmgTnUB1JgkLGBHNSsbnIwWvOb5jWn+
         s3YCgC3tcxdkiG1cb3uhqKjU5BeycZ65nPddCNIH8jvGVYDcOZNh/3SNi48xTBI/QhcZ
         Sp/D0qj2j/S02hDp9cuIkd7fnKiOTgT6wFfpX14mS36uyI+wsWT7VHCaUx/a4gKkokIu
         oSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711959226; x=1712564026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cej9zpiWpk2htv89hye5Ck+sNEHdHBz2DKWSX4aWhq4=;
        b=VYOMzkRFcG43RERzMIY6eC7C6yN4A5FT/g2lIdmfgWxRQpiW0GYMFwx3LHvH0yEcW4
         DWf3ie1CMDbwmOABbtV32JzmAZLE/9usH1d+DImzAKFOs9NzqzP/snnYM7xTtOM28GdH
         1N3DEtzsfV21W/fEFK9EyIPmWo7NPD9EQPueLexyqHhdbPWSywuO8xb0Wbxf+6vqlqrZ
         N5uwjcemG6LT57Ugfz2ms7knwdkyAsiPy3MxNQVn4y+yKbwjF25EpJD6tSEQrvtdebcz
         8bs4CTxmS9CAQ6mWRqdXaiC9iubD1DxbgKIMhFc6TFhJWGt7kxkIeG/Xmb5gqn5axA7x
         OQpg==
X-Forwarded-Encrypted: i=1; AJvYcCU/AI8YUwV68uy0QR6wzBW2mkOmQPvit04p0k7sWHhQfDk+uiNfF3CHBBBY7obuyP32e5eDuTehi78KM0PpLEf7aXCmvvXGl5UGQEwg
X-Gm-Message-State: AOJu0YwVJrGmJHn3RNh6OQjC8hOK9+T9SDou+3IvHViZPO7Zz3AmJRVn
	Kwau5R99UWCN+JLEh/yCZtWbiub6msXs+iYBQ8dhphww8Hk4tVIuIEhOeWkuEwppXA==
X-Google-Smtp-Source: AGHT+IHT7Kfi3nG9Qctt4Fkkm+M8SUzv6s58mZxn7nhIPocD64H3r6VAmceDyGR2xHIKzH3DHuqwAw==
X-Received: by 2002:a05:6870:6e17:b0:229:f7fc:54aa with SMTP id qt23-20020a0568706e1700b00229f7fc54aamr10183931oab.5.1711959226268;
        Mon, 01 Apr 2024 01:13:46 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id r1-20020aa78441000000b006e69a142458sm7262817pfn.213.2024.04.01.01.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 01:13:45 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sfr@canb.auug.org.au,
	liujianfeng1994@gmail.com
Subject: [PATCH] arm64: dts: rockchip: remove startup-delay-us from vcc3v3_pcie2x1l0 on rock-5b
Date: Mon,  1 Apr 2024 16:13:02 +0800
Message-Id: <20240401081302.942742-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Property startup-delay-us is copied from vendor dts and it will
make kernel not detect pcie wifi device. If I run command:
"echo 1 > /sys/bus/pci/rescan", pcie wifi device is detected, but
my wifi device RTL8822CE failed to load driver. Another device
RTL8723BE can load driver but no wifi signal is detected.

Removing this property will fix issues above.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index d6bf2ee07..a9af654a0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -76,7 +76,6 @@ vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <50000>;
 		vin-supply = <&vcc5v0_sys>;
 	};

--
2.34.1


