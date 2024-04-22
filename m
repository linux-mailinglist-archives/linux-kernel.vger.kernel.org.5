Return-Path: <linux-kernel+bounces-153266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E44A8ACBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9911C229A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC0C146D68;
	Mon, 22 Apr 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2MD1ZN7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771D145FEE;
	Mon, 22 Apr 2024 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784333; cv=none; b=OhB8V8frt5maNEceX0tOrB14pAWea7Of9ieEf0Yu9nHjf1dYGorhCbOLtRJmslPSzbhByxzxHzuArp8V9/xa+aVa32RQdfC7FPUGjmNbwI6ijzNEOVn/II8/ncwK17lqJ5cLpi/nsLrPqeNwz+/1kwnlDPpfjAqDXcCfpiNa3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784333; c=relaxed/simple;
	bh=2hP9Wr46k20/hqo2zftH4vkjOu/C8jNY4dsEV4q3rdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDu18cvv9kRcHACDpeY2U8ZtRQ6MAobVukNLiYO4iOoWebIp8RxVUQiZ9Tzz8OklUbhRXCRwH4DHl399gyE9P0s/xl5ttljH9pVeYcjIWGiv1dSp0UB6WPwmsbFHBe+18yTMw7SWVq4Y0ZXNutRK83kRno2quNM7ORuKd3wA7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2MD1ZN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42AB0C3277B;
	Mon, 22 Apr 2024 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713784333;
	bh=2hP9Wr46k20/hqo2zftH4vkjOu/C8jNY4dsEV4q3rdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=B2MD1ZN7k0Oz211U8eFTKiRwf57BNBBI37UTzWlHjISgw9fEV59mTxyXK59bRlZ8A
	 CZsRA4yDQy/Hi3tcGLPQaIUGEV4woXTlH5nLPGLPLjYCcNIBi9ujNc2yMU1+tRlXWj
	 J9cS6qlebiOMweLIX8cvV7OoFUn5nLEH4JXB1CVX1dFeoDeR0F1FwrZFjbXVA38ZXk
	 UdarBgM8A7+F0oVYhpiJkAEm5NjIHpvyL2l8XowRQdiCiKToP8mjnsQs5ah/EJIKXa
	 LWmG+Bx4E1lOaCieVKYLJ7Ig0D/Qhhgstpk7p9IsTTYviOfL6sBObZOHcgW9ONZpSS
	 8ZMmZqPROHmoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F05C07C79;
	Mon, 22 Apr 2024 11:12:13 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Mon, 22 Apr 2024 19:11:43 +0800
Subject: [PATCH v2 1/3] dt-bindings: reset: Add Amlogic T7 reset controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-t7-reset-v2-1-cb82271d3296@amlogic.com>
References: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
In-Reply-To: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Zelong Dong <zelong.dong@amlogic.com>, 
 Kelvin Zhang <kelvin.zhang@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713784331; l=942;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=CyHJlDrpjIAL79VP7HKiQbjHBUBNChERmthFTOisS7k=;
 b=No+L3Aq5VEv4hqOixwhyza7FgSRJ0OGNj0kF4mf0d14MAeHGUGA8GyfSxN0wnQE4etPev/vEx
 DugVtyb6BUtBHREtlEd+d4JICkCSHNL7yqFZ3tdyyzszIH+hd0f7qXG
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Zelong Dong <zelong.dong@amlogic.com>

Add a new compatible for Amlogic T7 reset controller.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
index f0c6c0df0ce3..695ef38a7bb3 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
@@ -19,6 +19,7 @@ properties:
       - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
       - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
       - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
+      - amlogic,t7-reset
 
   reg:
     maxItems: 1

-- 
2.37.1



