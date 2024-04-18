Return-Path: <linux-kernel+bounces-150480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAFE8AA000
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C861C20A56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C0D16F910;
	Thu, 18 Apr 2024 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KzjIZxkn"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199716F90E;
	Thu, 18 Apr 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457593; cv=none; b=XKszd484PzH7Du7M08bbp6hy5/SczrCylCKAJRoQxm41BYrbRIJurY6tLz2OnhxuX4UFxtiLeUdAtgD7SbRFurJ3EhJJ8lH6/O5ng/FuYW51e1OThh9d7jTMZT93NeVhFkkbM0w/AJnKvLAM5Z3s/P8ISe24FmpeSpsIfUdFRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457593; c=relaxed/simple;
	bh=dpqezVntDIQN+re7eIhhC6vPZOh44qB72Rig/xpo/i4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCFVytcGgM7MhDXbRflsDXg4+xzqsjyOvVEVnACTNy+/IwXEWpBbJBAx8n3/egCtVA1QBc+IrX9H8/DXkSIVAfsLqL+lddwfLDDSIzs0dwldwxjp3l39rJafmEfvkt/fg6GHs9qrLI1bY4QY/QTASaLwScPrw6AqRELUV4CCOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KzjIZxkn; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713457589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1u55PLCGxci9bAUfKmtYNqOEwbkf8Uc9rj3DWZzS4F8=;
	b=KzjIZxknxJVEM1S6yX44gD7YfP4LBCul7mlUz+mzLX5Hp3KZuJSA5pk6mtr5eUuhRSJVQk
	XLyp6jcbNPdwRUlUiCdkMG6LJhwKjx7xsJHJF6A2Od2JxWoSayt66y2EE0WiCBzyDo2ImH
	FScHbOVnQ56BPk24k8n090UVhK4BIXgwmwfHYz/T07f0m2F1s02lgiwgAynIAAwReAC3h9
	QTqNa4UCcYsMAlReKSYVamlxVNmiRQDYU4XbXZBsUrjj9zwiJ7iA7LRyfu/4oKTghgH5u7
	DUraFnOgSMYfdm+kyMd7w+BoqHXZvW3A87l7boKivq5gyynGF7tkBKp42NBtMA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	amadeus@jmu.edu.cn,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: Correct the model names for Radxa ROCK 5 boards
Date: Thu, 18 Apr 2024 18:26:20 +0200
Message-Id: <6931289a252dc2d6c7bfd2388835c5e98ba0d8c9.1713457260.git.dsimic@manjaro.org>
In-Reply-To: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
References: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Correct the descriptions of a few Radxa boards, according to the up-to-date
documentation from Radxa and the detailed explanation from Naoki. [1]  To sum
it up, the short naming, as specified by Radxa, is preferred.

[1] https://lore.kernel.org/linux-rockchip/B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com/

Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts  | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 1fe8b2a0ed75..1c26f04cbfcb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -7,7 +7,7 @@
 #include "rk3588.dtsi"
 
 / {
-	model = "Radxa ROCK 5 Model B";
+	model = "Radxa ROCK 5B";
 	compatible = "radxa,rock-5b", "rockchip,rk3588";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 00afb90d4eb1..4c7f2a2fdb11 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -8,7 +8,7 @@
 #include "rk3588s.dtsi"
 
 / {
-	model = "Radxa ROCK 5 Model A";
+	model = "Radxa ROCK 5A";
 	compatible = "radxa,rock-5a", "rockchip,rk3588s";
 
 	aliases {

