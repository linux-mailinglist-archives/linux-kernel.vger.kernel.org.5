Return-Path: <linux-kernel+bounces-27415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A250482EFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412FF1F211D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC611BDDD;
	Tue, 16 Jan 2024 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="pa+BHsnO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dpe6lJJ6"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7E1BDDB;
	Tue, 16 Jan 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id C3C905C01A9;
	Tue, 16 Jan 2024 08:21:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 16 Jan 2024 08:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1705411303; x=
	1705497703; bh=RMgaWg9hRvrDkXQrNiaOtNKt79w/zahXRyvkBwhz6CI=; b=p
	a+BHsnOVFNEhy4yroFQTqyqGKxJHdfzMVtGcrghhCnmGnu7l/2WTldCeAcpg/ynE
	lQzVY2QPl4//PZi1ABJaavnLl8Ik5hacXgJyoAnZf2OCDeRwjt5H1sCwK1roxMbe
	pUATKmdRibIr0wQSq6Ov3IV69qg05lJ7gLpf3M8bKeb/6ZNl6xxzFvXsyw0oNonv
	80jg+DhcosuFaZSA9qcITIVPd3QwaB0twwW0L+myBfJe5JPJTO3tZwk1VHAcpCwJ
	clwXVZOa+8TdHhK6ZB+81QabL7Qpcpuk6AZ5YToGHdZpd9FS9plpFb2xNHgyo47A
	pat4pK7DuAXHvQQ2w+Ckw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705411303; x=
	1705497703; bh=RMgaWg9hRvrDkXQrNiaOtNKt79w/zahXRyvkBwhz6CI=; b=d
	pe6lJJ61pl+D1ECDjyP2pmZChQXohrzTJBB6IkRQXSkq6mCLVTbrQCR8uGvWbjLY
	+NzOAuiPjst8ILYJz3CHI29aSJ2gY+b7bP27+mUDUpBwljUjO+Ju4KwYhEIUlYz7
	4V09T+9b+BMYFV2t9AlKHBBCZfZhgQXtCGpMyaVJyxeAn3oag5g8CRJhQcxb0q6q
	y+d8nmvdBCBL++1b7pNKNbmvZ821Qhm8v/qEkV/C6lImMdMLhXIYMzd0/Ptjm6LV
	oLJQOfj+NEdcAVS3guxGKqjtuNjl+5eROqiNBsz0lqGIc4TOOKZk/SmSoBRj1rkF
	NZblvcas2100to8KBhPCg==
X-ME-Sender: <xms:54KmZUr9kZ1cGJhj410QnsRm6YpUPe3Jx4TDsDFUzBCK7cAPpqM6kw>
    <xme:54KmZapw5zQRAdR1h0jaaHtuFQ2VnjghXRRd1eC0dyI2tHGyNKUYso4poRLqvxddt
    RGoZupDNg>
X-ME-Received: <xmr:54KmZZMM3LUs1niyrX_OrA5Je_dFvC7Up6lmaAOY4TKjyhofWM6fIl80B-8DX-3O1AOK6GeWy1FPYs8ASFMVZDTpWMRPXRDDFnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejfedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
    nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
    hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
    hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:54KmZb7YZHi97_2x_pHB7-fu5iUJOpL4Ufcn64K4y3zxQV20H0RNyg>
    <xmx:54KmZT7BFq3uypono5aJHD8l0riu8eWsKRUcEbfBL0JeCkqZ0w3CiA>
    <xmx:54KmZbiXXI7s5oBKpcwZUXqMRpKXCvnhu-o7KCIVFnLrl7t01joCNw>
    <xmx:54KmZQwfyIAB6_vbfvj5tfUDhLZKtK7VxMrPoHON18TgZPQpCGINTQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jan 2024 08:21:38 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Wed, 17 Jan 2024 00:21:35 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Tim Lunn <tim@feathertop.org>,
	linux-arm-kernel@lists.infradead.org,
	Chris Zhong <zyw@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Zhang Qing <zhangqing@rock-chips.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: rockchip: Update rk809 example with audio codec properties
Date: Wed, 17 Jan 2024 00:21:02 +1100
Message-Id: <20240116132102.3272682-4-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240116132102.3272682-1-tim@feathertop.org>
References: <20240116132102.3272682-1-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the example provided to include the properties for using
rk817 audio codec.

Signed-off-by: Tim Lunn <tim@feathertop.org>

---

Changes in v2:
- Fix missing include and pinctrl for codec example

 .../devicetree/bindings/mfd/rockchip,rk809.yaml          | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index 9b9d670708ce..fee8338b230b 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
@@ -147,6 +147,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/px30-cru.h>
     #include <dt-bindings/pinctrl/rockchip.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/gpio/gpio.h>
@@ -161,10 +162,13 @@ examples:
             clock-output-names = "xin32k", "rk808-clkout2";
             interrupt-parent = <&gpio3>;
             interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+            clock-names = "mclk";
+            clocks = <&cru SCLK_I2S1_OUT>;
             pinctrl-names = "default";
-            pinctrl-0 = <&pmic_int_l_pin>;
+            pinctrl-0 = <&pmic_int_l_pin>, <&i2s1_2ch_mclk>;
             rockchip,system-power-controller;
             wakeup-source;
+            #sound-dai-cells = <0>;
 
             vcc1-supply = <&vcc_sysin>;
             vcc2-supply = <&vcc_sysin>;
@@ -309,5 +313,8 @@ examples:
                     };
                 };
             };
+            rk817_codec: codec {
+                rockchip,mic-in-differential;
+            };
         };
     };
-- 
2.40.1


