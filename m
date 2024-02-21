Return-Path: <linux-kernel+bounces-75058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE4A85E249
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12F51C214D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E168E81748;
	Wed, 21 Feb 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2+Irjth"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4643AAB;
	Wed, 21 Feb 2024 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531160; cv=none; b=XRem9xznB+S9wCpClMRUCNjrcIFCVw++DmriA08IjtlavXEKUrOYCXjYt5GLHmfyjRMDH48FVnCJWHsc17WvG/kYgepWH5g3bH4LPtCwwtPrOryNeCnLE2FSVWVaGHBi1VkvF4IH7tUiH+e9dQn9NMk/CpG2wgmeUy2H3HC9n34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531160; c=relaxed/simple;
	bh=wzMn7N6GEbr+AfMO+gRxUUuRVYZP5iP83MZxHmQMiEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N0/pCp5iGTAMaxV/4+lJJQCsu8cQUyaMJeq4yaFyFR6UxFZ8qH5+FiacdSRXkzKSDNvy7zQ+BYaDlmNAXtsHcc4R2ftEixuMxUASqF7T2d7HKhL8k6o8/5XPTzd5lfQtjRwU0cHXAuN/eU5HNoCGasM5rbqhGdlA+XmLcE8Ss2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2+Irjth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9230FC433C7;
	Wed, 21 Feb 2024 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708531159;
	bh=wzMn7N6GEbr+AfMO+gRxUUuRVYZP5iP83MZxHmQMiEA=;
	h=From:To:Cc:Subject:Date:From;
	b=p2+IrjthXJUqyxlAB8oa2fPoOALqBc/eMw1FjuvbQqAlhQWy/R7rECLc6dP35JxPL
	 o3W8x1pK+HyIdN3m+/6D76x2ZeUYN9fH3OLLs9E2OQXf0oMhiS1b3Hnw94bmlE5RlN
	 TuMRNEkxRQC+301wy4ArUm8dGTt3FHLRH0wJN3tlGne7TxOthraBoZLnZPAo9EhXfY
	 54TPXv50b5vbrJF82tSj1i5E8NS8MjH2DBZAz+9382IigZvTJzbS0ZKHDaXUKS1by3
	 GEu0XbTxkf6S9O8TvJk5cGUkFWCbITe37O32vwjyoDQPK6Ci/fQSPlLCQDHVf03DZY
	 akoaB7bHJ4cBA==
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
Subject: [PATCH v3 1/2] dt-bindings: arm64: mediatek: add Kontron 3.5"-SBC-i1200
Date: Wed, 21 Feb 2024 16:59:04 +0100
Message-Id: <20240221155905.1217340-1-mwalle@kernel.org>
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
v3:
 - drop description and add to mt8395 existing entry

v2:
 - convert enum to const as there is only one specific board
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 09f9ffd3ff7b..29ebe1f9c1d2 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -353,6 +353,7 @@ properties:
           - const: mediatek,mt8365
       - items:
           - enum:
+              - kontron,3-5-sbc-i1200
               - mediatek,mt8395-evk
               - radxa,nio-12l
           - const: mediatek,mt8395
-- 
2.39.2


