Return-Path: <linux-kernel+bounces-81333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302486745E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFA61F2BB28
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304DA5FF00;
	Mon, 26 Feb 2024 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tooi7QKJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB955FEE7;
	Mon, 26 Feb 2024 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949262; cv=none; b=Vd5g96Zloi3O1wUl5zl4rwzvqT6uhMENUg7kfttEERsgg7P9IOgnHcAoEyFnqXLKT7haalYLFzKgPDxav9fXYigbRcQVLYC3mjU8F6dWzTI5k2d8ehpfKZj/giezXzJT/X73TatcLbpd6Y9hjVg+ccBd9H9RBQD1984ag+8VYSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949262; c=relaxed/simple;
	bh=2ff+U/daLvta7prHxzZSq2xWA5leXpB8TWzwlk61Z/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cQsMU7aLxzeXA6RU+/h2jpLx+bxCg8sae+AbVvK2tkwSsBEzx0e1o+HIyNsQocHwc6e+iHcHBxZyvLH3o5DhIlzIpLLBpRYdgjRM1Dan5tOoOD1FE2ufTtBKEQVOqgQYWrR5EFrDFn/vFxvBYrMsIu++bTTKAAXIpzZVoZDVDLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tooi7QKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB71C433F1;
	Mon, 26 Feb 2024 12:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708949261;
	bh=2ff+U/daLvta7prHxzZSq2xWA5leXpB8TWzwlk61Z/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tooi7QKJzJYXZY5AfQMJ6g4MfNGi7Y1a/p7B2ky2hp9L0sOSp5iDpJJU0B+QsRCHn
	 Zwd1PE1GlzfK7s7gBNyNtEYVEyo6BweVNm9q4o3OJ/mgZxyxMN8wmd8dTxsoQrgNp+
	 7f/oDLTFCguRKl+zIz3fA3ROTT6BEct8cPxleeX0OzJ3HBamjOfu5vXRU1Jg1/z6cj
	 3w7EHTmTRO29FZ7jn4JEOeTiwYRqrxYEKfSO4p+fYWvE/QIpR/abMCr4isrNEM2l4l
	 GgXGubvHcDrUTtuV8IBiLxWc5BPsf/3l9qY4RePotk3lV0g2d1vcDlqhyu9TYrZHGo
	 SGsfPXGLCz/wg==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 26 Feb 2024 14:03:07 +0200
Subject: [PATCH v6 1/4] dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-1-acf77fff4344@kernel.org>
References: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-0-acf77fff4344@kernel.org>
In-Reply-To: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-0-acf77fff4344@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Roger Quadros <rogerq@kernel.org>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=2ff+U/daLvta7prHxzZSq2xWA5leXpB8TWzwlk61Z/Q=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl3H8FF4jq4BFw1U/vhzVYQm7gp+wptBEhiVRof
 9A+HIJE2p+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdx/BQAKCRDSWmvTvnYw
 k9oCEADHMqqmiB3qQpLssXsSrxaWrNjuFRCXNya9s8A1BMfScm9Qk59t1yaZSKI7FAr4dFAtsA9
 ODrFANTs+NPvmhzdR8wWWuS+yVtVP4cpFVfP+jVDZKFxjWw4PlVhGUxPzIjYm5YGyeiNUjyPxDw
 mfbdUOOCfh/cD38tZBInzrNcT3AiJF0YI4UDDQUtx4cfJSVDrL2hB+cNAfl8SaQYYXd+7fds1bH
 liXvQK1dmuX8TkDdOVDw5WG8wKRsk669MjJcVDJC6bOoCD/MZgtZwXMDMLQBm4UkpYnl5RM8BI/
 Qz0rYvfkoMVFt++5E08gJtjakOvPJ8OnSyZ2mqJzQy0SsIcBe327euMZUCRAy2o+2eexwtquBOb
 88hB9j4nXmDqFm+VOVnngMu62hCHVHEh7MhhWiTTxlXss4blYna/NRCuF7oPWjuM17XOp24Knch
 jr7BAhoWMYmDJT9LFc+cGn3OFezQShF++nZsZgqa/dJsNa586J18RTRw+ORH46iWa7cwgbgl1b4
 2/dcIGRl1MuQgzqmscp0PtUE0V89genWGdvYCAYAd8D2dK5zkrU6CbMU05VLS8S9K1/0XBzlpoN
 5JAf58fthmdINscVUjCe2i11nohrLQ5zUsn/BlojXoD7katormzb8p1hWLqmx5MY13wRyNb2VHf
 Ad4phQXuBgGlH4A==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Add the compatible for TI AM62 USB PHY Control register. This
register is found in the TI AM62 WKUP_CTRL_MMR0 space [1]. It
is used to indicate the USB PHY PLL reference clock rate and
core voltage level to the USB controller.

[1] - https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changelog:
v6 - Rebased on next-20240226
v5 - no change. Added Lee Jones in To list
v4 - no change. Added Rob's Acked-by
v3 - add compatibles in alphabetical order
v2 - New patch
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 820c364c01f2..9d55bee155ce 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -72,6 +72,7 @@ properties:
               - rockchip,rk3588-qos
               - rockchip,rv1126-qos
               - starfive,jh7100-sysmain
+              - ti,am62-usb-phy-ctrl
               - ti,am654-dss-oldi-io-ctrl
               - ti,am654-serdes-ctrl
               - ti,j784s4-pcie-ctrl

-- 
2.34.1


