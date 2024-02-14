Return-Path: <linux-kernel+bounces-64723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF1D8541F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87691F23E80
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64F0BE66;
	Wed, 14 Feb 2024 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="Y8BsDNGw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nTIrNl4M"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B410A17;
	Wed, 14 Feb 2024 04:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707883683; cv=none; b=RHkLarJEtCScLPkaDI4yCLJKasJHwl870vjgUxIhEQYnkMSotvCvIYtodbmm4D1evEozBj3bu90qtXP1MlKQVmCzGONtSY50vZs+HdpBHqw5DJAhLLAFW++3MCYu+yLXNcWBSWU5L88mzux4byOJANlWOA5B0WOGV9BboWtJWgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707883683; c=relaxed/simple;
	bh=d7Buzoa32D06mtcqBHxLgRwBefQ5o2riEZA1zbWWF84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IzFlOqWb6y42pet9AwSLt1MAruJO7n9LL6ggWcFrKpDvXVVGpwU/dLENU/Pm007SGCkreoGige0J+pMVLDzdQhPTxybtaHJHhwDYO0ShiT5S5AZcCfqTXc/KFfcfFVyS75XycxRxpRtM5kjgFDvTeP9een6DgRgVQewUHxvfCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=Y8BsDNGw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nTIrNl4M; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4B07711400A9;
	Tue, 13 Feb 2024 23:08:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 13 Feb 2024 23:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707883680; x=
	1707970080; bh=9WoQRLE1KfwHraU5Vv9QP4/yV2f55MUrS1IyZ9YV7t8=; b=Y
	8BsDNGwR4eDbnfQKt0Sf6BqKYqAbfClQduewmshOvGqqiEJzqvg87RGmGQFX0m7x
	vTGpEwMARs9aqJvb+21/JT6zxKScK8z+ZiE1A3SKy0pbKBroNI2JCSPkhkMilRES
	P1IOwN9pLOhDfDb0rJ9S4OY8K9IAOmJsNVFgRRmLwaVmoMHBxj+j3+GOWxnhh+MA
	/LX3oAZCMvHI6aS/tN3Ni8srUWi7wHRajHjVY2Y62t8QFXxaCeXEInIgF+xbp6jL
	T6xtp+6rckZJvGFvsh87HIgAhae1iHz0jgmb5lEIQU6iNO9+G7Pk24Pa6gWoIqQT
	N5AqwtOsmDWdYxHgl/gRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707883680; x=
	1707970080; bh=9WoQRLE1KfwHraU5Vv9QP4/yV2f55MUrS1IyZ9YV7t8=; b=n
	TIrNl4MuGm5djX+d7glB2+8g4c4xnLnleF8Nr2BlmraSmtcuF8k0kbsIYp5eoLX3
	LotcRQJP27dDkPu6GmkjKKO1wVe2u6uThSbhVdfvH7y60dLD8f+5EjwOVoCe6OB4
	oTmBkEjKAyVuyZzbzwmN0/vAs7DZzntIRbQo5lTJ2o8TzWqAp7q58w6ZVWf49eqK
	M+SZj8i0Cy9HpQImiZY+7qMN1QqFHmRxvygs8F1SmIIID8qB2Xe0BHXWdRCvpSiO
	IKBHDn8tDKxoXYXPpib3eJ9r7+oMw0aAkJAe1OV4c9a1FMXqIF7mch880U9Om/Bw
	4uSleqyKWI+0KCVRuSEEw==
X-ME-Sender: <xms:oDzMZZrqDLVVmTtxG1T7VdFI1MqJnR5xGJgrgxxeCE1ZOh0nt62zQQ>
    <xme:oDzMZbpbNMuZz6dQojwpiRXxhogPkVZC4pa-k5T7OPlG9wNurFiOQXtm3K0-4uqcJ
    Dzk19yx0g>
X-ME-Received: <xmr:oDzMZWOCjGIdQmYplVjGTK_9mK7fpOXTYUsffLzMvAZ8X9qHkkrmB7TJBhWBjs0IzyJffBIE3fNCwJq5NBj_-Jll9wL0vB46jUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhmucfn
    uhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvghrnh
    epfeffuefhteegieekjeevgfdtfeethefgvdfhteefueffuefhhfefkefgkeegheeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimhesfh
    gvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:oDzMZU7iH4ULHjO8dgYE84VNVdEtgK-JBk29BW0KF7o__rq_K1znNA>
    <xmx:oDzMZY4zEdRHzxaFcbQz56YNu5DDa7hXrU8mHECiksDMwOiMzPR7Jw>
    <xmx:oDzMZcgjc-t9M3kbD7rEea8QJR70Nij0JNOiLFA3TM1VKjYGwSYQPQ>
    <xmx:oDzMZXTi_w9jFk5RyD6URFZYxUSrtH8dzeZUYGhAgnn-gEnpxRaFDQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 23:07:55 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Wed, 14 Feb 2024 15:07:52 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org
Cc: Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jagan Teki <jagan@edgeble.ai>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Ondrej Jirman <megi@xff.cz>,
	Rob Herring <robh+dt@kernel.org>,
	Tianling Shen <cnsztl@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: arm: rockchip: Correct vendor for Banana Pi R2 Pro
Date: Wed, 14 Feb 2024 15:07:29 +1100
Message-Id: <20240214040731.3069111-3-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240214040731.3069111-1-tim@feathertop.org>
References: <20240214040731.3069111-1-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vendor for this board was incorrectly listed as Rockchip. Fix this
now while they are not used anywhere, in the future they may be used by
bootloader to select dts.

Update the vendor to Sinovoip.

Signed-off-by: Tim Lunn <tim@feathertop.org>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 29f922f3ca4e..89261b9601ce 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -940,9 +940,9 @@ properties:
           - const: rockchip,rk3568-evb1-v10
           - const: rockchip,rk3568
 
-      - description: Rockchip RK3568 Banana Pi R2 Pro
+      - description: Sinovoip RK3568 Banana Pi R2 Pro
         items:
-          - const: rockchip,rk3568-bpi-r2pro
+          - const: sinovoip,rk3568-bpi-r2pro
           - const: rockchip,rk3568
 
       - description: Sonoff iHost Smart Home Hub
-- 
2.40.1


