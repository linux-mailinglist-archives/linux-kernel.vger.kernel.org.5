Return-Path: <linux-kernel+bounces-142930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7688A3228
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56434282634
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA03150987;
	Fri, 12 Apr 2024 15:15:21 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230C149C4D;
	Fri, 12 Apr 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934920; cv=none; b=b5AwX/3XHmClXtFs0K1CniBitO6TnQU56KLUPCU2jtkgttsk7Z542QT65nCVTyxtDm+fhrPDDx2FC41otthBmfqXU2qtTxc3KalvB2bcY4M5w7IowIbwrQoBT2qxHN3L02BIXWXktvyvTP/FqMzPVLE7F1XG6yLTkY0/01gpUuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934920; c=relaxed/simple;
	bh=J1jG4kj0aYZKcUmMvtYUKNLJlJWsegdKYmIoMD1fTS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2pXpr/SW6mpEG2VEroTsCyc877Vw+cbXi4KMOhkq2M2XrYMaYNAE8U3QM7czNkb09Ky0MkuAecLe/x90nNkdW+S4x05nq91JxcRJ10YRtOlNJjAAn6KY7PhUMobQFjpSb+No1WIPvHz274jmk8Z3+FkahXOz4sLAkF/gGjy6gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 73A2C10A2675; Fri, 12 Apr 2024 17:15:17 +0200 (CEST)
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
	iommu@lists.linux.dev
Subject: [PATCH v3 1/2] =?UTF-8?q?media:=20dt-binding:=20media:=20Document?= =?UTF-8?q?=20rk3588=E2=80=99s=20VEPU121?=
Date: Fri, 12 Apr 2024 17:15:10 +0200
Message-ID: <20240412151515.837824-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412151515.837824-1-linkmauve@linkmauve.fr>
References: <20240412151515.837824-1-linkmauve@linkmauve.fr>
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


