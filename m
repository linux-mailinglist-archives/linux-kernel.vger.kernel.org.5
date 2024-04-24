Return-Path: <linux-kernel+bounces-157197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F138B0E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59BA289439
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1510A16D4E1;
	Wed, 24 Apr 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYPoWxwf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C9416079C;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972571; cv=none; b=cn6g6fFTwh0sBwqlVRouKWQod4kg1MkbhrSpSqr78tONXf9lSOwv7wP/hhzZ1UxYrFE8GDr99l2dp1pZ2I6IJzEgRc4kZHfda0kygC8eM7hggduwreLg/2AumhVlx35TWQxaUDXvbFuXf+jiKGIEMWYVzKVcllPTy7/KmqNW23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972571; c=relaxed/simple;
	bh=MGDeJja2K+2Fy6iZ3UVl+kKOjkN4yNTXYCSocCHEyOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMsOdIXy6YWYbnZQj/dFFlq7TwIl6k20Jg0Q+eFtUKyk9NL/5ED/1inkGGg7Djruv/4MrIpiu3XfUUzimyUCrbCqYnVGMMvaa5joJHgAtPLUaFO3Kdl1Syg7inaN5brJjMwpEwlrpXDkSSMy2YbWeTPkvJrBLN9hCInPdhJeBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYPoWxwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67AD8C4AF17;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972570;
	bh=MGDeJja2K+2Fy6iZ3UVl+kKOjkN4yNTXYCSocCHEyOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GYPoWxwfjWjBIZqzfXah+R1y39jKPnpmgHVSmpHgQifk+qjwnYgCpBFPlPGt2nvTZ
	 yOP8czmAe6Ekh9WqewODZb1M6L4f+kw5gmp0iyzj2H1AXA51HXvZEGiLGLPN2xtj4p
	 h30KMOmlSSPNj9+OGxCkneF0aVrSbrCax2cuHfMlwbidwwoifu6NZeg9hUAP7eZhnA
	 u8DHvPSf2/ahiIkwK+avKByRKRa+3sQwBiF9EaIrX+eqOfavFVtZ50VnIgHs3L9QM6
	 2lqXRQCjM1YFG822lBgQ/IOoavFcEhLNNCTXp1HtMwPH65235fe1ExwnsCCQX5RqHU
	 al3ziHloshvWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E454C19F4F;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
From: Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Date: Wed, 24 Apr 2024 23:29:10 +0800
Subject: [PATCH 05/10] arm64: dts: qcom: pmk8550: Add PWM controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ayn-odin2-initial-v1-5-e0aa05c991fd@gmail.com>
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
In-Reply-To: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, 
 Molly Sophia <mollysophia379@gmail.com>, Junhao Xie <bigfoot@classfun.cn>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713972563; l=805;
 i=wuxilin123@gmail.com; s=20240424; h=from:subject:message-id;
 bh=UJJkbMFALeVJntjJ0F6Zy3BxeVdQ8NMCNMFJYC7Boyk=;
 b=CxOiSooLXVMHGp39j8/B3jelCeqziYdEj46802PdgC+psrDtPoDZNIW6D7J2ub0wVyd5OYEUV
 APrmVMQwclPD0ASCtCxD40Y4LrcBZeQAkA1iUSRraJ92DVQL/c3QGGk
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20240424 with
 auth_id=157
X-Original-From: Xilin Wu <wuxilin123@gmail.com>
Reply-To: wuxilin123@gmail.com

From: Xilin Wu <wuxilin123@gmail.com>

Add the PWM function to the pmk8550 dtsi, which is usually used
to control PWM backlight on platforms using this PMIC.

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
 arch/arm64/boot/dts/qcom/pmk8550.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmk8550.dtsi b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
index c7ac9b2eaacf..8d43fbb85263 100644
--- a/arch/arm64/boot/dts/qcom/pmk8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
@@ -73,5 +73,15 @@ pmk8550_gpios: gpio@8800 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmk8550_pwm: pwm {
+			compatible = "qcom,pmk8550-pwm";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
 	};
 };

-- 
2.44.0



