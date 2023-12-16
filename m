Return-Path: <linux-kernel+bounces-1952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB5981564A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE46F28721E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2474A31;
	Sat, 16 Dec 2023 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M88rzfJM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F415C6;
	Sat, 16 Dec 2023 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so859684fac.2;
        Fri, 15 Dec 2023 18:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702692624; x=1703297424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=McVfGfyP695CBBV4Dy191zoW62rsgzuHJs0dXDvRxJc=;
        b=M88rzfJMR6aYzW7ZmTG3U4QxTV+el22RnA9m4lzJs1VUj2FhITHAhfsoiLlGRNxOsn
         6oB2879dXfAbBSyvBEWlyg2cHDPzXKvbh5lG1IUFi6jV8PDTD+zoxF8jYUlPAQC4D586
         At0PtSD6ElUZ2eD9hgpvEokCuz7I44ZWI2njdxixYiy0nmV9WTNnSeVgg3GvZBrTrMve
         GUOIgWhpmyxR2J4yspd30FmNqFPwzfSrlOHo1pgq3pHX1WoPWxhy4id39eTydeB/u26f
         oSRHuKVFMWsjFxR/YaewcLxIlgmXY1aCB0xTlAT45CG52TN5Pd/XPB9B9oLY+HRlriB3
         iYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702692624; x=1703297424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=McVfGfyP695CBBV4Dy191zoW62rsgzuHJs0dXDvRxJc=;
        b=Zpf1q2PoPBnqUo3gtIixJyfuSBWJuEHoaok7OeVbltwKWT58RZ/MwJvbY3U+2+HNgG
         YvB4aEQWmHCBePHKkhP+98h/GxfUppxsmD4f2mePFI6irDUJnHegQeaFMqXxo5PHEq6X
         P8sh9Q9e4ebNrXDAc6Jw20pc1ATLNOiAiG0xZKfIS6CDWavTaA5iB7p9vc9kfcpDNdMb
         +dj9tcui/jd42J0A++G3A8vPq8lcu/SX+qWQLywUfEBZsPjBwX3P8a87VkWoyW2E+d7o
         d6ZKM9rwYJaeQ0yKiggwHkhUNKjsbR4YWrMFp014m7hufnftqF066qBVfh1RTeDYyJ/B
         /jNg==
X-Gm-Message-State: AOJu0YySSG17bAlOiGi+HTzhIOi8BRGXn7k/VUGfoghDKTrU/+1iPfTu
	FOM2G8k5KtXIjkMudHcQ3K4CjwF2avIGJ0R/
X-Google-Smtp-Source: AGHT+IHSz8Ro83bs/m+BykpP8bk+dNyWIE4b/mhcfkhvooSvOT/La8XtUE59cbVt1lGKsrxHmfkUSQ==
X-Received: by 2002:a05:6870:a68a:b0:203:294a:50da with SMTP id i10-20020a056870a68a00b00203294a50damr6322456oam.75.1702692624475;
        Fri, 15 Dec 2023 18:10:24 -0800 (PST)
Received: from celestia.nettie.lan ([2001:470:42c4:101:7c7f:3273:a81a:4618])
        by smtp.gmail.com with ESMTPSA id hq15-20020a0568709b0f00b002032d9a4c0dsm1621924oab.43.2023.12.15.18.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 18:10:24 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh+dt@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	Sven Rademakers <sven.rademakers@gmail.com>,
	Joshua Riek <jjriek@verizon.net>,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: rk3588: Fix USB PD clocks
Date: Fri, 15 Dec 2023 19:10:19 -0700
Message-ID: <20231216021019.1543811-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QoS blocks saved/restored when toggling the PD_USB power domain are
clocked by ACLK_USB. Attempting to access these memory regions without
that clock running will result in an indefinite CPU stall.

The PD_USB node wasn't specifying this clock dependency, resulting in
hangs when trying to toggle the power domain (either on or off), unless
we get "lucky" and have ACLK_USB running for another reason at the time.
This "luck" can result from the bootloader leaving USB powered/clocked,
and if no built-in driver wants USB, Linux will disable the unused
PD+CLK on boot when {pd,clk}_ignore_unused aren't given. This can also
be unlucky because the two cleanup tasks run in parallel and race: if
the CLK is disabled first, the PD deactivation stalls the boot. In any
case, the PD cannot then be reenabled (if e.g. the driver loads later)
once the clock has been stopped.

Fix this by specifying a dependency on ACLK_USB, instead of only
ACLK_USB_ROOT. The child-parent relationship means the former implies
the latter anyway. By the same token, remove the redundant HCLK_USB_ROOT
reference, since that's also implied by its HCLK_HOST* grandchildren.

Fixes: c9211fa2602b8 ("arm64: dts: rockchip: Add base DT for rk3588 SoC")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---

Hi list,

Feel free to tell me to knock the HCLK_USB_ROOT change out of there, since it's
not strictly necessary for this fix. It was a "while I'm at it, let's remove
this redundant reference" thing. :)

I also do not know quite enough about debugfs to know how to manually request
clocks and PDs, but if such a mechanism exists, it would be a good way to
confirm the correctness of this fix: ensure ACLK_USB is stopped, then try to
toggle PD_USB a few times.

Cheers,
Sam

---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index fd1b5d02ba16..32d7e49f03d3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1341,8 +1341,7 @@ power-domain@RK3588_PD_RGA31 {
 			power-domain@RK3588_PD_USB {
 				reg = <RK3588_PD_USB>;
 				clocks = <&cru PCLK_PHP_ROOT>,
-					 <&cru ACLK_USB_ROOT>,
-					 <&cru HCLK_USB_ROOT>,
+					 <&cru ACLK_USB>,
 					 <&cru HCLK_HOST0>,
 					 <&cru HCLK_HOST_ARB0>,
 					 <&cru HCLK_HOST1>,
-- 
2.41.0


