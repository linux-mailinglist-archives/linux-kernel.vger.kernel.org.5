Return-Path: <linux-kernel+bounces-37565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A683B1B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA471F28A21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED110132C12;
	Wed, 24 Jan 2024 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtrOHq/s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32644131E5E;
	Wed, 24 Jan 2024 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122883; cv=none; b=drNACeZbipnwm6z+iUWPYsUymrrwFPxuIbRf2UFZn+lMkBSsJ8dZIDGrqQ3UJy0eL8LuPVY2dLAXlw97zF0yqfzBq5NrWNjeEEyDx0tiLsQ4882VTP6XZWco0gwpaRlGIAZ9bWwgSNO7cjMMVbtfigbZigs6KrRQFEUPLPUTDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122883; c=relaxed/simple;
	bh=dMObXyq0MBRE/uycOHgjqOdNUcF7nQX2Ho+KMxlPsXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcbTI9y65j7VI+SmXBuxV72xgqOKNpnahLH0Vb8WEzGGQZwHGZ+EZ7V698Rl/D22NjE8Cvj2u4oiST0HXv5VZdBCarYZO5qA991wfWTecLD2PY0R0OYs9mVxOOB0WyThh+dQiZK0pGSvEMi5cDhzPorObIt5aJZR7EtaQnOiBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtrOHq/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86972C43390;
	Wed, 24 Jan 2024 19:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706122882;
	bh=dMObXyq0MBRE/uycOHgjqOdNUcF7nQX2Ho+KMxlPsXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtrOHq/se1guXLT7U4yisWLOI4M8hEOOfNKHh6jYGnWmGY8x/Fk+BwXOKJOtEwBwe
	 6jtsYOsQsCycofWpVO/AfO40OVu60FhKCU++W0/qT06ZKIDiGytIGa8+6p3/gWLiSO
	 FSFd2ZRL4yfowDYlU91IF/s6U1kBpGhaQFKNtIYYHK4UavbDaYgw+mw+wWgbwdNqAs
	 p1Kn3v2PnWPdd4ZwpJYoAPRClwSkgyYuo7XtIeCCVHqP2AI5og2fa7oJph4dVhZ9Sq
	 PzC9zOeQ5tCx90r78j32XpujfuHx6LoXxY2UFccrEC+mdWZOqAgyFzYfm4IzYCCBJW
	 j73dEwZG43dhQ==
From: Rob Herring <robh@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	patches@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH 2/2] dt-bindings: pinctrl: nuvoton,npcm845: Drop redundant type for "slew-rate"
Date: Wed, 24 Jan 2024 13:01:05 -0600
Message-ID: <20240124190106.1540585-2-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124190106.1540585-1-robh@kernel.org>
References: <20240124190106.1540585-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pincfg-node.yaml already defines the type for "slew-rate", so drop the
type from the nuvoton,npcm845-pinctrl binding.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml     | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
index 20cf0102aa63..b55d9c316659 100644
--- a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
@@ -159,7 +159,6 @@ patternProperties:
         description: |
           0: Low rate
           1: High rate
-        $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 1]
 
       drive-strength:
-- 
2.43.0


