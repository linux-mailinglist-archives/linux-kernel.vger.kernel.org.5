Return-Path: <linux-kernel+bounces-167850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4B88BB039
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC58E1C22579
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA296154BF9;
	Fri,  3 May 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvoPqICl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C14D9FD;
	Fri,  3 May 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751048; cv=none; b=N0R8jM/4SN4v5nt2syXyu2dy0fsjOG/fW0mOLCGPT5yLjNHunA1DS/2OPUOTREBwKRooM6OyKU9dcA61Q0LMRwjX5Gy13FgW+Ra2gMwPnyUOCJgg6wlNqHpx01V+jZosHVGR2Xtsngc6g0O2HsjDFRuGVNANv+0Q3tBvYMALKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751048; c=relaxed/simple;
	bh=hsXOfi4iNd1CKAF+jsU187xcPJDgAO6eNnEnqzte8lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQfi+zDqiKdujBljWVA/DRm1/f/xPSFVIJ5th0uejmHcAPCcPyNQ2q+mueu2uFvftm+o4FsZTVqHtKXqpxBQlt1Z2RxJhxiLNbAdN76msiP03RMBmjupDYpkDlLVVqByTWTeOd/u+Ei0suwvQW1SGuFdoF9UVqsn4nVnzOMtHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvoPqICl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B589C32789;
	Fri,  3 May 2024 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714751047;
	bh=hsXOfi4iNd1CKAF+jsU187xcPJDgAO6eNnEnqzte8lg=;
	h=From:To:Cc:Subject:Date:From;
	b=UvoPqIClABoxUJ4TpD01WrXqC9ETMFAJEIhu4HU1/4OV5Aw2K3SF38Jtz/SAo/P5r
	 IZnh0Mlx9mLGqvtABoGmKu43SeUBeOXKPhRw9lemKLj9Y7Di0Fw+bUjOyHSdGPxz6c
	 ai+mbLZODt8QpB3vTV/UIkdum1RIlhGX/U8/UM7eNW51yJfP6smQUeYxZDs8AWoEL/
	 eEK1gz1V/bj81lkOZ/jOQiKKN8AxjjYPX2vtHBOI6ecpJH30x6zRYLePGr85vW5DLC
	 su7Na8S7+ZTOu/BkD/ofIQEDg9gcmeuhArg3dfnf+f5ZhBs5ouaLMZzSxC/jC/DSos
	 EEU0rlJUWigyw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: sunxi: Fix incorrect '-' usage
Date: Fri,  3 May 2024 10:44:02 -0500
Message-ID: <20240503154402.967632-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6bc6bf8a940a ("dt-bindings: arm: sunxi: document Anbernic RG35XX
handheld gaming device variants") mistakenly added '-' on each line
which created empty (i.e. description only) schemas matching anything.
This causes validation to fail on all the root node compatibles as
there are multiple oneOf clauses passing.

Fixes: 6bc6bf8a940a ("dt-bindings: arm: sunxi: document Anbernic RG35XX handheld gaming device variants")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index c6d0d8d81ed4..c2a158b75e49 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -57,17 +57,17 @@ properties:
           - const: allwinner,sun8i-v3s
 
       - description: Anbernic RG35XX (2024)
-      - items:
+        items:
           - const: anbernic,rg35xx-2024
           - const: allwinner,sun50i-h700
 
       - description: Anbernic RG35XX Plus
-      - items:
+        items:
           - const: anbernic,rg35xx-plus
           - const: allwinner,sun50i-h700
 
       - description: Anbernic RG35XX H
-      - items:
+        items:
           - const: anbernic,rg35xx-h
           - const: allwinner,sun50i-h700
 
-- 
2.43.0


