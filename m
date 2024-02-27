Return-Path: <linux-kernel+bounces-84098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B9386A238
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB08B2ECA4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEDC150988;
	Tue, 27 Feb 2024 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqvI80ve"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285C14F98E;
	Tue, 27 Feb 2024 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071808; cv=none; b=StyKLY6BZVtAFmOLAIxnoTK2b81Ei+zHTTGGNTdMp/ahAuDs2+I3OjnOpS65ba5xYvW+N7LokOlem9wnZhFylTGs38gC41+hUKxP5CVAOTzppgWJ6g99UAR54GLA69mQdXYqfkvKLxZ9iu1WAdc8bFt9JaIdeNy/CUzXpMsgxVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071808; c=relaxed/simple;
	bh=RGo3+txwNsrQ6IT60hsPwAvFDG+YtsMzMqrgzgdFu9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rgonTAFRgQhvc50OwO8xcy9L/O9l9y7dnxIFuaSH4rgVQse+wSRbX08n0hSEXpo6nnNhp86nMzRgFxTjLhCtx9Xigu23keHhfT5NXACipl6GcTBrx+7Lcu9TV030VLuxcOojjrKy4ukyJkqXKFyx/5lZHFSf2goswqCT9WAe/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqvI80ve; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d28468666so4163207f8f.0;
        Tue, 27 Feb 2024 14:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071805; x=1709676605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma8ASoLaikXcGfj9j8rCCZj2yH+c7Ub2I8hdjXF8mhA=;
        b=OqvI80veLiOMJHcxgm1DT4/a9STvqNjgjp83scL7aF7QWN1bI6jwEeX1uIWdEjT9ks
         nXYoXRChXLdXu3wwsyMATtvxMrKZOXuNAVqeKgMtoWTMnaaTQWxtyr6/rakA7w/Kph9R
         zQ3YoST3akkDMonC4A9riylPGlCGqCEAGzS285QEktP9NJbRbZrUVH8x609lN5g6QB9m
         RMjSwwhhllFw9SAlKKXe2cnwsK4jfP40luJh5sj4WfruE6hAWS7b+R3eRDQPHeu7JR3o
         F+Fk7YVAK9Rp8zylVxBicwFNS2cVyqwFDx8vI2NQvikCdzaMiDU6I5Uj7zJbY5IMkFNK
         yozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071805; x=1709676605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ma8ASoLaikXcGfj9j8rCCZj2yH+c7Ub2I8hdjXF8mhA=;
        b=GPqGJDxcnvLfz8ACqe7KYF2GhOBA12Ghufm0hse71coGcy87vYOwfAZzdQC/zxzs+U
         kKuAfAEYT51izMji8K3++DDidSqzX23JJ68anaZxEKjNFuNNHchWmJBdNKKHHzgyG1k7
         By3Eul3Lq0ON8HxiTLjPv+aSpXL09sr/GQUnYKxmIo1YZ+KbVN/5i9ftbfTVVyuEbCme
         BAubF7Fy2h8f1KnFSgsT494RMA9exL+HWXxGWihW2sklanNWmzHLF2TLRfGOYHThOvmB
         BkWAJb09hUb6Wl7POTVvJSNjlOf0R7eFmfujy6yNMJvH7Kc3CSikYD2cvEgmlfeAfTY8
         +Pkw==
X-Forwarded-Encrypted: i=1; AJvYcCUPy3oB1JpwSUWmhis9WSYDgLpAIHOPGYBnPRVYVRZvchv7w98v9MOYrZl2RPITcBjjSCpt2mDoiEb21rIbfgQ6+WHvf/THKepkcUu3TR/gBw40cFT8hS2BNJv30o5YUw62IEy7P31fVg==
X-Gm-Message-State: AOJu0YzPetyusVWWRSvYuMzGK1IxHpjxzJzIh0BsJJQLXP1P32vyebib
	0JWnHZ0wrVlSjScIc/xx8pO/EnO6rSXNqCwsv/wXzG5qFqABEYUP
X-Google-Smtp-Source: AGHT+IFNgh0VbEih7fXYUL3kk3qEsVKpWoXXdEC+dl+GDwrzEYTzSWdQKuUPy7DAB7nCM8SHNz4k8g==
X-Received: by 2002:a5d:4e85:0:b0:33d:87f0:1475 with SMTP id e5-20020a5d4e85000000b0033d87f01475mr7283981wru.62.1709071804614;
        Tue, 27 Feb 2024 14:10:04 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e6a2:98b:e06b:631a])
        by smtp.gmail.com with ESMTPSA id bu25-20020a056000079900b0033d8a17a710sm12891664wrb.88.2024.02.27.14.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:10:03 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: soc: renesas: renesas-soc: Add pattern for gray-hawk
Date: Tue, 27 Feb 2024 22:09:30 +0000
Message-Id: <20240227220930.213703-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add pattern for Renesas Gray Hawk Single board (based on R-Car V4M SoC)
to fix the below dtbs_check issue:

arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dtb: /: compatible:0: 'anyOf' conditional failed, one must be fixed:
4695 'renesas,gray-hawk-single' does not match '^renesas,(emev2|r(7s|8a|9a)[a-z0-9]+|rcar|rmobile|rz[a-z0-9]*|sh(7[a-z0-9]+)?|mobile)-[a-z0-9-]+$'
4696 'renesas,gray-hawk-single' does not match '^renesas,(condor|falcon|gr-peach|salvator|sk-rz|smar(c(2)?)?|spider|white-hawk)(.*)?$'
4697 'renesas,gray-hawk-single' does not match '^renesas,(can|cpg|dmac|du|(g)?ether(avb)?|gpio|hscif|(r)?i[i2]c|imr|intc|ipmmu|irqc|jpu|mmcif|msiof|mtu2|pci(e)?|pfc|pwm|[rq]spi|rcar_sound|sata|scif[ab]*|sdhi|thermal|tmu|tpu|usb(2|hs)?|vin|xhci)-[a-z0-9-]+$'
4698 'renesas,gray-hawk-single' does not match '^renesas,(d|s)?bsc(3)?-(r8a73a4|r8a7740|sh73a0)$'
4699 'renesas,gray-hawk-single' does not match '^renesas,em-(gio|sti|uart)$'
4700 'renesas,gray-hawk-single' does not match '^renesas,fsi2-(r8a7740|sh73a0)$'
4701 'renesas,gray-hawk-single' does not match '^renesas,hspi-r8a777[89]$'
4702 'renesas,gray-hawk-single' does not match '^renesas,sysc-(r8a73a4|r8a7740|rmobile|sh73a0)$'
4703 'renesas,gray-hawk-single' is not one of ['renesas,imr-lx4', 'renesas,mtu2-r7s72100']
4704 'renesas,gray-hawk-single' is not one of ['renesas,smp-sram']
4705 'renesas,gray-hawk-single' does not match '^(?!renesas,.+-.+).+$'
4706 from schema $id: http://devicetree.org/schemas/soc/renesas/renesas-soc.yaml#

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml
index a5fcd471983d..5ddd31f30f26 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml
@@ -37,7 +37,7 @@ properties:
       anyOf:
         # Preferred naming style for compatibles of SoC components
         - pattern: "^renesas,(emev2|r(7s|8a|9a)[a-z0-9]+|rcar|rmobile|rz[a-z0-9]*|sh(7[a-z0-9]+)?|mobile)-[a-z0-9-]+$"
-        - pattern: "^renesas,(condor|falcon|gr-peach|salvator|sk-rz|smar(c(2)?)?|spider|white-hawk)(.*)?$"
+        - pattern: "^renesas,(condor|falcon|gr-peach|gray-hawk|salvator|sk-rz|smar(c(2)?)?|spider|white-hawk)(.*)?$"
 
         # Legacy compatibles
         #
-- 
2.34.1


