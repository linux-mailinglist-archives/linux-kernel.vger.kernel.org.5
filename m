Return-Path: <linux-kernel+bounces-71511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921C685A66E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAB82835AD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BDC376EB;
	Mon, 19 Feb 2024 14:52:28 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6512B25614
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354347; cv=none; b=neZvzdbjJ3j6/pzb7Ji6hjADX4Pf+s7xtip2MLJUrYm1YeKD+v6bEYLXCyShn5X8LMGhidyzNayDn+U7ANCHB6EV5G/W8CIJtWDalYnvL/aAMQWrDRp2aI5ctVVN6A3PKI+eGhP/lSRCRceQTPxTv9Cvr1UGa3TVw84W4Rdw9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354347; c=relaxed/simple;
	bh=P1uaLo5kuSWBOuLhpiZjbZrkbL+eJv35Qo0JI3uLF30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eVHeBUM9Dba205JDNaYf56zwXLDE30zo7VS1zbh9g711NLB8OBu2xnKLH1DzUjAKzcb18G9/rAFvUmfp7USRK4E4+jkZZiAmRqBJnOIWiBfLHHRJnjzEvVCxaeVEDINoBopj8eTqB1R2H9J2bNrx5HQFFuFkt9KckltuyJUoMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:a66f:1f5b:42c8:e3c5])
	by laurent.telenet-ops.be with bizsmtp
	id p2sN2B0011N8lK5012sN4Q; Mon, 19 Feb 2024 15:52:22 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rc50A-0016f2-1D;
	Mon, 19 Feb 2024 15:52:21 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rc50H-007QOw-QZ;
	Mon, 19 Feb 2024 15:52:21 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: memory: renesas,rpc-if: Document R-Car V4M support
Date: Mon, 19 Feb 2024 15:52:19 +0100
Message-Id: <263d6626fd4fa51b175b5c7a53e6a363e2c91519.1708354280.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for the SPI Multi I/O Bus Controller (RPC-IF) in the
Renesas R-Car V4M (R8A779H0) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/memory-controllers/renesas,rpc-if.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
index 25f3bb9890ae624a..d7745dd53b51ce47 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -45,6 +45,7 @@ properties:
       - items:
           - enum:
               - renesas,r8a779g0-rpc-if       # R-Car V4H
+              - renesas,r8a779h0-rpc-if       # R-Car V4M
           - const: renesas,rcar-gen4-rpc-if   # a generic R-Car gen4 device
 
       - items:
-- 
2.34.1


