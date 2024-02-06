Return-Path: <linux-kernel+bounces-55535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0E84BDC7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A661B231AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3C1B805;
	Tue,  6 Feb 2024 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="E8H30nIC"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD71B803;
	Tue,  6 Feb 2024 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246209; cv=none; b=MFm86Tu8mpi+uULjsMCYg2oKhewYjTKVzUEfQPmBdechZBWgDD1PLunyKY2VGS4HkXjqWanse1B+XUmQo+yGsZuK/vP/2Bc72EJp7QqzVgN97NhQv5xtC0aLbYnCNka9xKF10KsR9NqK7RuVlqUTJ6RPhD2ZUd74j7d2SgM9IUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246209; c=relaxed/simple;
	bh=7R8s3dS4oPzpvS/xucheAR6yleyBZvEtG5Mu/F0LqNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCaXPeV0zVxmKL99j1kjj0xwV1Nmce7IIFBYkkm7rvh7eacBPLiA8AljmuPUIgyLXWTpoLOpkLfnC7ZUCAJgtjdCiU8ef9kp8S1CTt7XQvTbyqCL7fyB+pGx6Y+260m6RoMMq+xixYNFuEDnJ58Th7wrNcKg9ANC7TdbXidNpnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=E8H30nIC; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id B14B8465FF;
	Tue,  6 Feb 2024 19:03:25 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Ondrej Jirman <megi@xff.cz>,
	linux-sunxi@lists.linux.dev,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-arm-kernel@lists.infradead.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-leds@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Miles Alan <m@milesalan.com>,
	Samuel Holland <samuel@sholland.org>,
	Aren Moynihan <aren@peacevolution.org>
Subject: [PATCH v2 4/4] arm64: dts: sun50i-a64-pinephone: change led type to status
Date: Tue,  6 Feb 2024 13:13:20 -0500
Message-ID: <20240206185400.596979-4-aren@peacevolution.org>
In-Reply-To: <20240206185400.596979-1-aren@peacevolution.org>
References: <20240206185400.596979-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ****
X-Spamd-Bar: ++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1707246206;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=7Z+f/WZ4DkXoVZnfMaT27NbYFoy33khw5gBrGUb/KKw=;
	b=E8H30nICUV7C40BRiCbC6jW+dZaE//BwLh94pzcLV7Kc5gR2epg5O/RMLYX7l/sMytqls7
	ix5lHv7U5TFFagxV1lB6MT2wn0s2z6rmXHNYaZuSILswCDEp+85E1mo7R8MZeZOrMftTBH
	AB0U6/So6MjmyopbyRqd/HJHIDjPvNY=

The status function is described in the documentation as being a rgb led
used for system notifications on phones[1][2]. This is exactly what this
led is used for on the PinePhone, so using status is probably more
accurate than indicator.

1: Documentation/leds/well-known-leds.txt
2: include/dt-bindings/leds/common.h

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---
I can't find any documentation describing the indicator function, so
it's definitely less specific than status, but besides that I'm not sure
how it compares. Please ignore this patch if it's not useful.

(no changes since v1)

 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index e53e0d4579a7..6d327266e6cc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -61,7 +61,7 @@ led2: led-2 {
 	multi-led {
 		compatible = "leds-group-multicolor";
 		color = <LED_COLOR_ID_RGB>;
-		function = LED_FUNCTION_INDICATOR;
+		function = LED_FUNCTION_STATUS;
 		leds = <&led0>, <&led1>, <&led2>;
 	};
 
-- 
2.43.0


