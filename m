Return-Path: <linux-kernel+bounces-44858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A9842835
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2B1B26A16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58686138;
	Tue, 30 Jan 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg+UwOth"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109CF5C8B;
	Tue, 30 Jan 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629256; cv=none; b=SELoKtUxDAj9ae+yziKY34KUBx5gfynH28iWUdjBEUkfkWU+QNZ2mWIdDaKAqRvAoC8ICOaF/yBo+s5U36krz82PHjewiw3UW3vjSyb9FYdd/24PAmWfNhrerx7kSHaE462UqYFfeyQiMpvnqm0KSD8h7/rzFvgrc/zw3bwZVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629256; c=relaxed/simple;
	bh=PvogyaMhQ35TmqTU2MVaW0rUBplyqT/XFNewRYyTLVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=amprFNjSkC6Zphu8kEIGGx32QQLydI5RagmIFITnfIHTcgZRFMJ2YA3UnxM6NbmyFLyKkazO1vXt50dN0eyrrhp/wgeNsqG+NaUphXuGawpaHaqe1pV9cBLlQG7PY1IGRqxfFH1x0ZvivHSV0hIzuenj198MkYcfiSG2WruMfyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg+UwOth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87528C433A6;
	Tue, 30 Jan 2024 15:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629255;
	bh=PvogyaMhQ35TmqTU2MVaW0rUBplyqT/XFNewRYyTLVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sg+UwOthfJOfI++Q7e9R3YnXsy38890oOI2b3WIEFWS1rzxE4Acd7HIwxv34m/l3K
	 konIO3DcRzVvzr9gTh9eiG9a7NKHl7a6AOivHA0JD6EP+F1N/1bms2g7db/edvNijW
	 zJLdPTvTPexZ4CKqkycNy3Vx/T2lxIE6Z9rpaIoiaYuHOr/4k+p8Xb7MSxKSs+G+tz
	 wuHcAUZXvC2V9PRQYY1GQ0bK90btftl/+O6Y5yAIbk9pa7Ma1jh73bfZmp979AmJH3
	 0U8TkEcLGfOp9XFe9Io0Sh59VRwwgjiD5SSV+rVMwHIcc0IuWdrEX5QrlbSzwP+6eF
	 MyrmpzLPipOKQ==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com,
	lee@kernel.org
Cc: afd@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl compatible
Date: Tue, 30 Jan 2024 17:40:33 +0200
Message-Id: <20240130154035.6901-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130154035.6901-1-rogerq@kernel.org>
References: <20240130154035.6901-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for TI AM62 USB PHY Control register. This
register is found in the TI AM62 WKUP_CTRL_MMR0 space [1]. It
is used to indicate the USB PHY PLL reference clock rate and
core voltage level to the USB controller.

[1] - https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Notes:
    Changelog:
    
    v2 - New patch

 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 084b5c2a2a3c..b5f27cc2917c 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -73,6 +73,7 @@ properties:
               - rockchip,rv1126-qos
               - starfive,jh7100-sysmain
               - ti,am654-dss-oldi-io-ctrl
+              - ti,am62-usb-phy-ctrl
 
           - const: syscon
 
-- 
2.34.1


