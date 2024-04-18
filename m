Return-Path: <linux-kernel+bounces-150258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AFB8A9C66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4B1282A30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58E16ABE2;
	Thu, 18 Apr 2024 14:15:34 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36DC165FA4;
	Thu, 18 Apr 2024 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449734; cv=none; b=VshZ0FVttt3ufVdxSBkakPb6mgrN8JYi36G+WmNmEGZIy7m/L6qMxrOU8JdZrxSeVeaoitglkdbBpHKBGoKcGhbD85BVaTOW7B1eo2XNMtorkg8mFCj4BQLbv80XyLA/cDawmMwmFeo7wTdKYDDBCAkGq2+ePkXAYNvaUrydBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449734; c=relaxed/simple;
	bh=aaDTVYzvybf28vrHHzELLbzhGLNTrrJtU8e6QvR/zV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJwyFlXIJRdmoX2p0RDg9frZK1dCzTCvm9TBWiAgprz4LTkRjG3r2MYOVfBN0VH+LTxqOwnjs2QnVsWB9+BstB4720uAHPW4A1vJB83p4cjr4k/h4ur6erqfsu10/SdCND6aKlxFacRh+aoqrSy2GCoF6JOGduNYxVtMPVBdiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 5DEBD10D1B05; Thu, 18 Apr 2024 16:15:14 +0200 (CEST)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: linux-kernel@vger.kernel.org
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] =?UTF-8?q?media:=20dt-binding:=20Document=20rk3588?= =?UTF-8?q?=E2=80=99s=20VEPU121?=
Date: Thu, 18 Apr 2024 16:15:05 +0200
Message-ID: <20240418141509.2485053-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418141509.2485053-1-linkmauve@linkmauve.fr>
References: <20240418141509.2485053-1-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This encoder-only device is present four times on this SoC, and should
support everything the rk3568 vepu supports (so JPEG, H.264 and VP8
encoding).

According to the TRM[1], there is also the VEPU580 encoder which
supports H.264 and H.265, and various VDPU* decoders, of which only the
VDPU981 is currently supported.  This patch describes only the VEPU121.

[1] https://github.com/FanX-Tek/rk3588-TRM-and-Datasheet

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/media/rockchip,rk3568-vepu.yaml   | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
index 9d90d8d0565a..4c6cb21da041 100644
--- a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
@@ -15,8 +15,12 @@ description:
 
 properties:
   compatible:
-    enum:
-      - rockchip,rk3568-vepu
+    oneOf:
+      - const: rockchip,rk3568-vepu
+      - items:
+          - enum:
+              - rockchip,rk3588-vepu121
+          - const: rockchip,rk3568-vepu
 
   reg:
     maxItems: 1
-- 
2.44.0


