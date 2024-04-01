Return-Path: <linux-kernel+bounces-127055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96819894642
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52225281F8B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8049553E12;
	Mon,  1 Apr 2024 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN34Hj7Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83774E1D5;
	Mon,  1 Apr 2024 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004607; cv=none; b=hWIgGIs0dyNqXVmRbbTUWFBTS2VhSak1W3xdCNaa0Z3bDF5IMrOQ20IFCLdKm6oX5GhyAFErciGBxH7cdCRoXAccJ8D9BJALxbeNJFfbtlfgGLak9kUG6yPaFEp9AKphgwRyggis+oIL0Jnecx/1Go0VmxxZ8jTRGHgi6QE+tWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004607; c=relaxed/simple;
	bh=yIx+UD6lf8yLqkorOuqWQO92jCJ0l41vcQ1dggv5Vbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bb9tMTgPJ+0t9AcIghzooCrq21sMgjZkbIKiCElRZYTesBqGkq9CcMp0GSJQxd2nEZbZgBuwJFqYz610+csq4hj77yFnyPepd3A2N/Sl7HwM2uM2zXC5F8qazFVu3kYTJQJFTbBGu/ZOTR9o7JbgbMhzLq27TTvjhAMo0LNxtdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN34Hj7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F32CC433C7;
	Mon,  1 Apr 2024 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712004607;
	bh=yIx+UD6lf8yLqkorOuqWQO92jCJ0l41vcQ1dggv5Vbo=;
	h=From:To:Cc:Subject:Date:From;
	b=qN34Hj7QQ56j7lJaBBh0SaEaHBKLsMXdc4Nl9FSLl2Xf8KkmhIHUCNs3J3k0q5v3K
	 CMB0Ieixm0jU9EfagM3eZIkRLe1EdqqnTSJI0ElKG5HXC2r6ucMFvfrxCmzM9/xlbC
	 wqbX9LGVdO++0uS/bt5+fBnyhkI2jMfmWrLWNa2oH2lF/PRBKrMaO5P1MfW/d+mp3s
	 vhk31rOSkAri2OXwBg74r38tpSjV56jFsbTX51X541sC++pS+WD2jy8Og+rADBQ433
	 oylCSEqF9S3Xy528AkTiJstErWh6jo/IxU/CNZFHOLVbSMS+CJ+YjHTZZ8oSJ+vw1T
	 7SoFRZTK5rMrg==
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node
Date: Mon,  1 Apr 2024 15:49:58 -0500
Message-ID: <20240401204959.1698106-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'pcie-phy' is missing any type. Add 'type: object' to indicate it's a
node.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 0b87c266760c..79798c747476 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -171,6 +171,7 @@ allOf:
           unevaluatedProperties: false
 
         pcie-phy:
+          type: object
           description:
             Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt
 
-- 
2.43.0


