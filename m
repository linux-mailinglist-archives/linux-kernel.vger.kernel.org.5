Return-Path: <linux-kernel+bounces-77273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B67D8602EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C82287254
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F886E5F5;
	Thu, 22 Feb 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbtvCt7m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8454903;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630837; cv=none; b=jfGMcrakyD2ctqpgHNkQ6TmirP0vgkmGH04yuMI34NYbZsDb+X1sdSGfQPnlKXZEmOpeM3m68DJtSEmduIEcbFPQe+TqG5utUMz5YWuvZ5UlKsqt4GXdbF7IbiiN1HhvoDD/s1Me68Ufb9Ps9uWgHjzXrcRejpDl8gWWatFDcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630837; c=relaxed/simple;
	bh=iXlnN86FBtHze7pc7TT1EzncHtGJddooON9T6JhruhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=deRLA6o5Qbu5zbdkRZ5CtQv+JQPsQCa09iJyjbmCGAYcW1hNldfOA07fTRXaGHdhtMCX72QXKnP7NAPKW7PId1ipA8A3RxOqu3o/AFvRrhNxQTkI5byRnI9skvglfiba5M4A+vmcuQC1T0RSzdIWkxCWf2vD0hLw+P1PoEZEDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbtvCt7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD043C43399;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708630836;
	bh=iXlnN86FBtHze7pc7TT1EzncHtGJddooON9T6JhruhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NbtvCt7mxbWeKYgLzxg/4Iq87LHwNpDdPwU5U2kfLQkOGNzj9WReowrolZ2M5BXK/
	 u6BTgfNObdXqbK3/74mSUUSxJa6mPXP/MACO7LT2bu5ZAK/3X+mp8IGgQdH31FaO6i
	 sn9GjPzH2kAN3VASw92tKp4QY6/LgUHJl1ZFGyFHLx1vuF1o1yeOWhgCuv+qCLIgm7
	 z84VzXEXHm3k1MTRZIgTMke6WhXK5SMcaMTcQAGTmVV1tlD3R/3CFT2u2mCytGgNty
	 y6B8ICkchbLe6B51IF8Fe5cMghX0BVD//TU0iSgFunL8HLtn69vtbZKJ+0lqnwQgIS
	 z2rOPJrzz6yqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96757C54791;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 03:40:13 +0800
Subject: [PATCH v4 3/7] arm64: dts: hisilicon: fix include path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-clk-mv200-v4-3-3e37e501d407@outlook.com>
References: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
In-Reply-To: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708630834; l=950;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=zO+w8jqaXi8Ww2B8vF6SfS+3nCbKAcDggVh4EP/9jpU=;
 b=GQbYW/EM0P0h70DzyqB6wWmefJ25pcQ7J+yd9DwnP1g3Pp4D5SYE4CMGcqVDgeKwhXGkV0V+B
 XuiDlmGfNmNDHZLdZgBizLY5L/KP5gFLzTweeKIObhjTT19TKFTcIUE
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The generic histb-clock.h header is now deprecated. Fix it by including
individual binding header files directly instead.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index ed1b5a7a6067..1e6a8a8829b1 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -5,7 +5,8 @@
  * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
  */
 
-#include <dt-bindings/clock/histb-clock.h>
+#include <dt-bindings/clock/hisilicon,hi3798cv200-crg.h>
+#include <dt-bindings/clock/hisilicon,hi3798cv200-sysctrl.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy.h>

-- 
2.43.0


