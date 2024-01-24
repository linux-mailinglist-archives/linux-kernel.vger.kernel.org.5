Return-Path: <linux-kernel+bounces-37576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 256D783B1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CB41C22367
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFC3132C30;
	Wed, 24 Jan 2024 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvj7dcBD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E8131E53;
	Wed, 24 Jan 2024 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123251; cv=none; b=Fby6/X1S7tSqOyK2R+/v1rCqOmgE4CMiPYwCeBcfd7QoGzykYjrc+tJh40358oOknVFMjj+w4UwgApXG6POCGv9ghuWpQ3MVGl621mLAo7cYYTMmixS0CfcYjHYbgzq8xN+dPR6DUUyEaEFMPBr1wzCKRKGH0frDM8SKTqtu//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123251; c=relaxed/simple;
	bh=SKRO+C4Y09BLBmwNyikwqGEZSpIUdd4Hbjgub5WPK3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dS3e2ga9j16kmY/8/o2bP48gsCzCWRM2u7mZCm/Sct+3ikQC//zrh43/+Sg30fL55GfafZ2W/DFFd9otKuz4uP94E7PQqFL32nJ2bVq7Ot7tGE4EeFbU36+LYZRBP5pP7BG8gLmZ9Vc+eCANfCopNY67yeEyZp8ZUd1RjFfj/Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvj7dcBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DCAC433F1;
	Wed, 24 Jan 2024 19:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706123251;
	bh=SKRO+C4Y09BLBmwNyikwqGEZSpIUdd4Hbjgub5WPK3I=;
	h=From:To:Cc:Subject:Date:From;
	b=fvj7dcBDuVqkNSjRoKF34m2NAZ6ufwLS7z8I/HAo+qa1lEuijXSL9+e3Qemr8VOXB
	 ts+ZVPqXrjWxhIXuq9+XkUiKa9mAPASb+mvZZtS8jWXGtqsdQw2pn4J4JBObm1kqXc
	 D/ggPrioyDoTmSUxT2J0giFaaCEljCF9tcflopH08w/HglC3yp1LPqql133zM1L6BU
	 VGjyoVIfNNV5HBLdK9urDvtwlC9qdzUt2DLeWTcdRTHmtCxhCMUqA0yNj3fnf1iQ12
	 +0fXaBWRPsmTJfdYbLTMoG8hLWuJyYYXv/X0fQJyZwwfW8mlgREcxTK2K0smjqHbr5
	 qUV2jNNGpNhKQ==
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: Clean-up "usb-phy" constraints
Date: Wed, 24 Jan 2024 13:07:24 -0600
Message-ID: <20240124190725.1554080-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"usb-phy" has multiple type definitions. Unify the type with the looser
definition, phandle-array, as there are cases with multiple entries
(USB2 and USB3). However, the 'phandle-array' type alone is a bit
ambiguous. It can be either just an array of phandles or an array of
phandles plus args. "usb-phy" is the former and needs to constrain each
entry to a single phandle value.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 2 +-
 Documentation/devicetree/bindings/usb/usb.yaml          | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index b7e664f7395b..3b56e0edb1c6 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -313,7 +313,7 @@ properties:
 
   usb-phy:
     description: phandle for the PHY device. Use "phys" instead.
-    $ref: /schemas/types.yaml#/definitions/phandle
+    maxItems: 1
     deprecated: true
 
   fsl,usbphy:
diff --git a/Documentation/devicetree/bindings/usb/usb.yaml b/Documentation/devicetree/bindings/usb/usb.yaml
index 326b14f05d1c..1761b7aa92f0 100644
--- a/Documentation/devicetree/bindings/usb/usb.yaml
+++ b/Documentation/devicetree/bindings/usb/usb.yaml
@@ -25,6 +25,8 @@ properties:
 
   usb-phy:
     $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      maxItems: 1
     description:
       List of all the USB PHYs on this HCD to be accepted by the legacy USB
       Physical Layer subsystem.
-- 
2.43.0


