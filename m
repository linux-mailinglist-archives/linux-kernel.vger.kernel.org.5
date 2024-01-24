Return-Path: <linux-kernel+bounces-37574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1D583B1D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EB0283E65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF874131E4A;
	Wed, 24 Jan 2024 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzusQ3YD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337C6A004;
	Wed, 24 Jan 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123240; cv=none; b=ntdUmtlj1N7c8xBeRXTFzA2p0+5qTGdFlq6mo5fIBSIvOKvnxx/69rthizmSxUUwObS457DNGBYygcySmwoxmTD5Iz3a4DNMoBRnPf6L2TA79lWvLJi/FQ6WsodcW/kHYBTWUAJgh0eM/Cw9KzWi4CM9M6UCGnyuzoCz31Lr9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123240; c=relaxed/simple;
	bh=ZOMG0BPoG356t+LC9zBOmep2nMZDeJ/aYYf9HLTtk2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLGCyYosA/bBiozb15j5M431I9Ieip9/hRwEMifLfuIVlBqrkQLsARfZVNDgyoRfxRCbaecf17cBDU5KQKo3uPqh70cHmJczVfql0BamjR11GZwEWFvIFI3zOkoTljdPdC3LaiA4avw+zZQtC2XS8QZKQXHQ1zfDXYhoYidSXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzusQ3YD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA9DC433F1;
	Wed, 24 Jan 2024 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706123239;
	bh=ZOMG0BPoG356t+LC9zBOmep2nMZDeJ/aYYf9HLTtk2M=;
	h=From:To:Cc:Subject:Date:From;
	b=EzusQ3YDgLM8XXrewy+6C2dXHp5on2QwntBfbmkws4MVDUlAFfQbEpPvhsDPlBATb
	 T35aRFL3zp3BtMRM3ehDdTwSklEjR3o8yMePaX1k55TCHewrTosU//Az5xV6EvrDmA
	 r+hruCv/H4Z/n1mD4VOjpGRdni17dBQ28sVRNwaWGA+cvPZKwfGw2ERpaoDYlmi5Ld
	 CcM7abjk38jnSw1gPrKGjqShtYVs0Xkw4MjFUEp9yJVVxHXbDT+zuiusN+ZwLhF7uQ
	 9Jb3bYCClzV4XDRuDJB4nTCbxjvqAzwDgzr/xNU8rweOrgJtb1wYrcG8kpHOsMRvbH
	 1W4O/dVjjwHpw==
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: tpm: Drop type from "resets"
Date: Wed, 24 Jan 2024 13:07:14 -0600
Message-ID: <20240124190714.1553772-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"resets" is a standard property which already has a type. Users only need
to define how many clocks and what each clock is if more than 1 clock.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/tpm/tpm-common.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/tpm/tpm-common.yaml b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
index 90390624a8be..3c1241b2a43f 100644
--- a/Documentation/devicetree/bindings/tpm/tpm-common.yaml
+++ b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
@@ -42,7 +42,7 @@ properties:
 
   resets:
     description: Reset controller to reset the TPM
-    $ref: /schemas/types.yaml#/definitions/phandle
+    maxItems: 1
 
   reset-gpios:
     description: Output GPIO pin to reset the TPM
-- 
2.43.0


