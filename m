Return-Path: <linux-kernel+bounces-166245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831788B97FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6551F24B84
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77385647B;
	Thu,  2 May 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="1yPZyLqD"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD3339AC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643009; cv=none; b=mYPmXpGW0hiAkgux6ya3nFE2fj39KIAGJuqnNdk0aNfEGnY0FDPQfKa4lKezUWeNDXx80JzF5D8RN8V5PFIIXlvGXQkpnN8u5exCozch5mF4dhrXhkU9VLa/Ld7f49gJSfASBDkJgozMZlZV+npJWge1k7YIcGudKRp11YthpAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643009; c=relaxed/simple;
	bh=ethnIDgbeKT4bwsEjRaQnPGNO0sDowUNV8Yot0tnI5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3FTWPimSIRHyAeDecrHV/DKbGfE2Y4dWJHh4PgbdQK+VeKf+8N2QO8kDvFut7MxADweVh1zGocIeveX/hKmjlhywIM9DxGfZgPx/EE3gJNTO48lqThGHF+RSvEz5lt7VzbSS2QshRBqzPIDaiCdiHp6GFqxq0VPMlX4xoLBPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edgeble.ai; spf=pass smtp.mailfrom=edgeble.ai; dkim=pass (2048-bit key) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b=1yPZyLqD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edgeble.ai
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b519e438so6063526a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1714643007; x=1715247807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NafZmSgbMWHkPxYUCANWhCGG1sZpE0RVMkcek4g8Q64=;
        b=1yPZyLqDnrklS/D6cGLKAZ7JWh/gYSXg6n4Cs4UDoShmTZ5lfri46qB9tzbSWJQTNp
         OxKc+nwzK1vUZp4bj/Hp3UIKL+05LIm7aBhVf8KU4hA47vxX4k9OGMq6oYJcz5m6pcl1
         LI/En1ni6XtF8kwWJdRvzlh2bdJJZn6RSQv1vHU6FzK2NpX24XtoT9rBYDw8sGbKE4gM
         nbUbQLRn49YOK1objbZD/7xqeAriW75Vm9qUtD32PS5y4cghSw0poee2YiiEX30O+y5w
         /Q8UtsT51YItL4IzvCGjgP3EG9e8x24bbLKP6OUTe6orE7AkznuvCQkodld95znJhjlU
         jY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643007; x=1715247807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NafZmSgbMWHkPxYUCANWhCGG1sZpE0RVMkcek4g8Q64=;
        b=ITCXDYtAp4wAEqEPbjjg/w8p9yT5q+eYabPljSQiSlMFnbLN4Lppj6IkBKjsLoULIZ
         4TNyBP4zsLuqcC6R/d/cvHW/uVsF3r+WFyMp7x/MHLu3Noj0nU3C2jNtj7z9yESYM5t7
         Bg2/lbVi8ZDX+yr7GbPnfWLrCJQaSVVf/sDj6sSBsHhePq+AjPYvc9xpOvQlUUf2HuZp
         ubf9QGKnpOw2ZR3UHkNv2p9O67lgjfLo7fsYlpZfbH0BibRQyu3bFJbf5uE+w+/9BhUv
         7HgsO+mhjkgZ7fJIUgXinqGr3+2XojbNizwKfzAQwCAKJWCSa7+u+XRMkpXRadKsKljT
         6aRA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ygLL11IF/mkS59xFtITFfx49mG6XHyA81+0rLA5x6EBrxGGGaMVt/PbwwpxItjSu4p136u6RHnde3rbu4ItdXd71Cg2Cs5wGkJ2y
X-Gm-Message-State: AOJu0YxyvVaSPtKka3n925FYyy9f134gqAKc+q0OiFfayVkd9laKX/44
	nSg+IsJBYWKR8vUv8mxTnwlFG01BUjpl0NAVlwU0cqAnErScQy2cvmWixXE60MI=
X-Google-Smtp-Source: AGHT+IHvUulvyLLuIR2ixjTdxZDCwMu9zOKpV98sFsG+9Kb5SZEbV1Ur8C3Ke6fQgfW3uB1Cl9G0qg==
X-Received: by 2002:a17:90b:690:b0:29c:582d:bade with SMTP id m16-20020a17090b069000b0029c582dbademr4530071pjz.2.1714643007228;
        Thu, 02 May 2024 02:43:27 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a428b00b002a42d247a93sm782603pjg.36.2024.05.02.02.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:43:26 -0700 (PDT)
From: Anand Moon <anand@edgeble.ai>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <anand@edgeble.ai>,
	Jagan Teki <jagan@edgeble.ai>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: rockchip: Add USB3 on Edgeble NCM6A-IO board
Date: Thu,  2 May 2024 09:42:38 +0000
Message-ID: <20240502094246.4695-2-anand@edgeble.ai>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502094246.4695-1-anand@edgeble.ai>
References: <20240502094246.4695-1-anand@edgeble.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the proper nodes to activate the USB 3.0 ports on the
Edgeble NCM6A-IO board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
 arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi
index 963e880ccc12..7b1317898358 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi
@@ -68,6 +68,10 @@ &combphy1_ps {
 	status = "okay";
 };
 
+&combphy2_psu {
+	status = "okay";
+};
+
 &i2c6 {
 	status = "okay";
 
@@ -230,3 +234,7 @@ &usb_host1_ehci {
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&usb_host2_xhci {
+	status = "okay";
+};
-- 
2.44.0


