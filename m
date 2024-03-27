Return-Path: <linux-kernel+bounces-121890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7865588EF01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187631F35973
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B82153560;
	Wed, 27 Mar 2024 19:11:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2D1534EB;
	Wed, 27 Mar 2024 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566713; cv=none; b=JWj4clGgDn+cSIInWpqomaQ6WprQXs5NG/oh53tDSApGJzIq3g+klF9abNe/myYC/2k2l+5/iRJnXdV3GzG+PPglh8sHfFgiRLWLGgY0U8RAOu8KRzk7PtGBBMuepu5fu9bNF/Yd2lfRgvSnkyPXqhmX9+CDqcSj2i18EYwtU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566713; c=relaxed/simple;
	bh=vhyhvBPp9VjqgpumB14+p5QhF1SFFcfFwmHxRzf2ApI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oojDagmc5s9JqGRsUmWTiJ+RKh+jKzjOLffo2/sVP0X0Rwf1pwOx8ogM55KPuOcAniWvNk3Jmg3GMC+7gcv9m4vVkcTp23rWgU46b+FmwgIbHc29g6GB7aFnTE8vBhP/TEnUv6s3gYBRJhHmjg7+ko4lUX0kC1DTxTtFPwYY++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0CCC433C7;
	Wed, 27 Mar 2024 19:11:52 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id B0E491060DE1; Wed, 27 Mar 2024 20:11:47 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 27 Mar 2024 20:11:36 +0100
Subject: [PATCH v2 5/7] ARM: dts: omap3: fix ssi-port node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-hsi-dt-binding-v2-5-110fab4c32ae@collabora.com>
References: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
In-Reply-To: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=vhyhvBPp9VjqgpumB14+p5QhF1SFFcfFwmHxRzf2ApI=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBmBG9y8K4vIQF/wdXEEHfddRWe28FaLBHpZOUrn
 u25r7nYIHmJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZgRvcgAKCRDY7tfzyDv6
 mineD/97Pm/faG7e1iuivIEzLVAOscMDlYodnyPcGl93F8jMPjQfg+ihlLG4si902uBfDWEmKMD
 lpQjSIKztFgWpxFoJ5ia/6yN5mCZkvt2LFDk8ya/fg9X4kRyq7HpF8NOShe9XuINzb1cwLdQlEm
 wJVoePLxJcO+5vsY8T5uMSpBXCgdQiDPYv00nUxgzwFIWSPQqmsf3qqhswkV2PMHTkUh/FCM77w
 HolNIWGJkBDewhoHAZzjAiRRRQam2Ypnk7wcDYO8+FZzPzSeu7vamGYRFXHrO9dVm211efPzO6x
 5ObUeWsIpXuFTGBxN2WveXivitCqMmNSxil8XINRR9pkk4y/LcCNEPsl7QEdq14atX1+BZg9SY7
 CBUVRRxbrRnwaV+P4WEUVB3pFei+37L0u0g/OSaGbky64yG/R8JwN7cEtlQn1fkrDJFyMVIVVZa
 Zm8mg0o6xUFoKOE4CcJEV+1zeLzlAhNn026I/IBlyGt5XPATi3nNNtA79BaskknaXifFZt5K5P7
 j6bcv81Mm6cDkTyr2hjFdcbDhDDSwKC+YcykfzVYxvzdimJs9aKOk9uQzzbIY4jR2VvMQCG8kXf
 ITz5uPC6o0bC+6olMGvzadGeyzqxZ4XQF1E/IFrHbPcwJF9nq/qf2n1hDNQZ2+HM5iUu1nBlVdk
 spugbylEVvF66yA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The DT binding specifies, that the node names for the SSI ports should
be just 'port@<address>' instead of 'ssi-port@<address>'.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/ti/omap/omap3.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3.dtsi b/arch/arm/boot/dts/ti/omap/omap3.dtsi
index 92cd4c99dae7..ae2bfcd7e18e 100644
--- a/arch/arm/boot/dts/ti/omap/omap3.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3.dtsi
@@ -999,7 +999,7 @@ ssi: ssi-controller@48058000 {
 			#size-cells = <1>;
 			ranges;
 
-			ssi_port1: ssi-port@4805a000 {
+			ssi_port1: port@4805a000 {
 				compatible = "ti,omap3-ssi-port";
 
 				reg = <0x4805a000 0x800>,
@@ -1011,7 +1011,7 @@ ssi_port1: ssi-port@4805a000 {
 					     <68>;
 			};
 
-			ssi_port2: ssi-port@4805b000 {
+			ssi_port2: port@4805b000 {
 				compatible = "ti,omap3-ssi-port";
 
 				reg = <0x4805b000 0x800>,

-- 
2.43.0


