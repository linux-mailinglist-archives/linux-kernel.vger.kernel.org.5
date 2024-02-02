Return-Path: <linux-kernel+bounces-50658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE5847C30
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AEB1C23510
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E7185953;
	Fri,  2 Feb 2024 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdB7+hcr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17A8060E;
	Fri,  2 Feb 2024 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912615; cv=none; b=n0Ur5tXi6aJnKNq8ganc1aWvXjy+30n7OiCqIJCInpPf4LrFPKsAGayDpmfQC8JeFkycgl8elP5NdeEUAUjSG8cwqJY5q1tPFag6pMN4OgZzJnAVIKW6MyyxIYCZoqKX3QMshvB876ezBWPzbqn75ZTWKuB9m9xpbQ7bfa7Mw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912615; c=relaxed/simple;
	bh=r3ftRMCphRRMd6wDXZMGi4+Lx21WilpTGLmbJKYhTeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKycHpkVWdY60v6k4RFytW9NZh00R2xujPZSFSD6h75bMLTSbkNN9VKD1m3oTmdcVKfN6jVkmWl9uCTHRbsSKpRj59IylbkBYuezhhY+RIzC34ZbsyGQ2p9UrIFes+QT0y+lwrLYs9lrag4Z/HQTqbZLEQn5ak1HqilyjsACxWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdB7+hcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66582C433C7;
	Fri,  2 Feb 2024 22:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706912614;
	bh=r3ftRMCphRRMd6wDXZMGi4+Lx21WilpTGLmbJKYhTeU=;
	h=From:To:Cc:Subject:Date:From;
	b=HdB7+hcro/XHqbdPuOzaC3liVbBnIXvo8GJY44eg/WEQp+HBhlFpQ9aLvJCNR9zVg
	 HWhPlE/cVtN1P37bKUcCl/TZCcSGPVS5vq1D4lkPbkz+GjOxfvn9xSYNxJ36GzMt2e
	 BICjvSg9VqrzRuja54fgMdf6IwCMU49l3p6DyT7WJSQJfMSm3Pc/VWvjIabOJGOm/3
	 MiyURzmle8truq12Kxa7sAEBLzYIcseGd0XgxDRm8v/McRYFr6BHD/FPKR5Mgnbtus
	 JQO6h8XpoI8adTcduZj0gWJeoeDjbZsG1FS4bf2YQd0+rhD+MULLvE67PZuBy/JUwM
	 R0zI79i1sES1A==
From: Rob Herring <robh@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: dt-bindings: techwell,tw9900: Fix port schema ref
Date: Fri,  2 Feb 2024 16:23:25 -0600
Message-ID: <20240202222325.1651952-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The port@0 node doesn't define any extra properties in the port or endpoint
nodes, so the $ref should be to "/properties/port" instead as it restricts
extra properties.

Fixes: 0f82ffa9a295 ("media: dt-bindings: media: i2c: Add bindings for TW9900")
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/i2c/techwell,tw9900.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
index e37317f81072..c9673391afdb 100644
--- a/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
@@ -36,7 +36,7 @@ properties:
 
     properties:
       port@0:
-        $ref: /schemas/graph.yaml#/$defs/port-base
+        $ref: /schemas/graph.yaml#/properties/port
         description: Analog input port
 
         properties:
-- 
2.43.0


