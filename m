Return-Path: <linux-kernel+bounces-70949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD791859E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A499281884
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B2621379;
	Mon, 19 Feb 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptrLcM5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786ED20315;
	Mon, 19 Feb 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332308; cv=none; b=maBqenA1eqjlebfGMeyAVXh5/kO6A6OIdxMWYsNUp8rknXXskCFAk6ynv+uQ0cYSwfxGijefEAzi+fw0h1J/iAeePXqveRWMUsDoItSC/Yxudnp/JDQ8EU8qi/ZgcAmsm2aQOcsfrpmqI1UKkdWzsEpNiX53gjj8HMogEWNoPU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332308; c=relaxed/simple;
	bh=XCRrHzV6LyBu4+jXcasCLefrxDxH3vBtjp/y8ZvMbrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AJ/3YZ/Qp3oByHTWkoUQNv3xx8ULD3AUvRGOVig7mFxzlmL/w+Qvv7+Bza6wsOuKd5OuY6ECV0c/bntKKQ3HlReJgf85kuSgdBWvX8pKB+m2vj+5yizjoTn/tpVwFvwWLNQG2uZtkpXvlQVhQ9oTnzVYfcndn9Psu54txENrMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptrLcM5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FCBC433F1;
	Mon, 19 Feb 2024 08:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708332308;
	bh=XCRrHzV6LyBu4+jXcasCLefrxDxH3vBtjp/y8ZvMbrc=;
	h=From:To:Cc:Subject:Date:From;
	b=ptrLcM5h+3p3S4UnLs9iw1O/cuanKKZ3WrHwxq4E62NhOE3IdSLslLenjnHjRP8/j
	 Hdu9gh9TQgqN01a91xeTtE4L9A504C3el7W0qfylpYUhI+1fDTXnlOnrWzhLVQn1aX
	 VcuHkejnW45BeWUxl3p4r29LQpmxCa0sB3W0O8MVPA8rISOSZd9TwoovM1uyHyiup6
	 9SKyl9T88sGW8qv2NlN+//9flZcwb6ArYLqbFxJxAo3+kPgxUfGMyWYmcjE4THVi8f
	 Sk6I7X3RkC+wdSLQ82kmA16+e/1kJfbXGPvsN4BgT0xlBWx3hULu95bvN1KLtecCOn
	 U0AUKSbDi97LA==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: arm64: mediatek: add Kontron 3.5"-SBC-i1200
Date: Mon, 19 Feb 2024 09:44:55 +0100
Message-Id: <20240219084456.1075445-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
computer.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v2:
 - convert enum to const as there is only one specific board

 Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 09f9ffd3ff7b..add167d8b8da 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -357,6 +357,11 @@ properties:
               - radxa,nio-12l
           - const: mediatek,mt8395
           - const: mediatek,mt8195
+      - description: Kontron 3.5"-SBC-i1200
+        items:
+          - const: kontron,3-5-sbc-i1200
+          - const: mediatek,mt8395
+          - const: mediatek,mt8195
       - items:
           - enum:
               - mediatek,mt8516-pumpkin
-- 
2.39.2


