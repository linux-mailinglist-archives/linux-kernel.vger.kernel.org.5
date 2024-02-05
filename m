Return-Path: <linux-kernel+bounces-52767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C0849C76
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106F4B27847
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2C2C691;
	Mon,  5 Feb 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ao7fJbAS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3222C694;
	Mon,  5 Feb 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141560; cv=none; b=BOvElu1HHLSlGJy+5F7WYBVmkIldh828CLWwIMmea20v/lhfFhCpW5fuhlyUQOof2GBLW8yHyhdUKL7NNINbilIXcqDLZAXySd05nimq4l1PfSLmJZBXJpa8t/LpPT80Ipr5gYL7M85nfP4+qM91AqRfQ/ATj/pSS6WY5Ye1KTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141560; c=relaxed/simple;
	bh=e5Ol44cNhbsUA6CtDEObMa0YcRvE9WJtvaMsnXPBe0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ILImiFviRBfWeu5/WOCww9OdbrzLtZ06zp147Vsdx1YT4JhCVkBRcn5+DxHGDn/og9isB2nykXZ2Nm3It2WcK8gDyLVEEbEZ6Cc5zar3Tpu23kGxpQ0MnLj14XJLZffHm4xUDPSjGf9i6bH3nMKwXfwhEWFeWlLZ10615VG0oUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ao7fJbAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52925C433C7;
	Mon,  5 Feb 2024 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707141559;
	bh=e5Ol44cNhbsUA6CtDEObMa0YcRvE9WJtvaMsnXPBe0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ao7fJbASJoBH9GKzma11WC4oZ4jnlg+TWrWxAdIMkI168FpDcqw4p9ZiE0EmfBF/y
	 HQsq2YBX8LSMjho2HTtnSuxMzFf5rTLBRPGo+b3KVdfSuv2LmL2xUG+uHRnLioc2dp
	 dT99AFV1qST8MehPP2v/TLjB6TqjVi418S/Ia2+7d6Sdrh8tvcwcfsj3d4AZrfcGLM
	 QFxrpFEWVycxtHtEnPZJIirHKvEAJdABRIYJ8aJKEle9YC8v3wvMUK1TxMf4OCCNhb
	 h0+XuGxogW5WFkTcDhTFNQueOVQJullbt5T9TVxj86UEm+s3yHQXqVHwjgIqI2WpQt
	 +UJWlLPeUGwpw==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com
Cc: afd@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl compatible
Date: Mon,  5 Feb 2024 15:59:06 +0200
Message-Id: <20240205135908.54656-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205135908.54656-1-rogerq@kernel.org>
References: <20240205135908.54656-1-rogerq@kernel.org>
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
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changelog:
    
    v4 - no change. Added Rob's Acked-by
    
    v3 - add compatibles in alphabetical order
    https://lore.kernel.org/all/20240201120332.4811-2-rogerq@kernel.org/
    
    v2 - New patch

 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 084b5c2a2a3c..9437705af92f 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -72,6 +72,7 @@ properties:
               - rockchip,rk3588-qos
               - rockchip,rv1126-qos
               - starfive,jh7100-sysmain
+              - ti,am62-usb-phy-ctrl
               - ti,am654-dss-oldi-io-ctrl
 
           - const: syscon
-- 
2.34.1


