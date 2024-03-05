Return-Path: <linux-kernel+bounces-92749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5B2872580
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561041C23390
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D6214006;
	Tue,  5 Mar 2024 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2X4Rd5e"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02F5256;
	Tue,  5 Mar 2024 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659005; cv=none; b=Ay1YtC1vKM/LRSJL4Mo6WIfSPmlLjC/6sq7TkaFBA5ik9iyz3H4NvR52DxT8StfiyjiLJSk7oBc2mpEWPSlWz/vUzhATjz1NSEAlMLSpQmw//leVFNXxdgtFgvmFVyaw3NWT36QjrDGkGKGNf0OBSv4t1HkUgIcA+SfCcRxwT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659005; c=relaxed/simple;
	bh=CxNH8DsP5Yqy2n7slCYu0v+Vqw+IlqWMS0GJ4rMV2nc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oJjA6NbhgjkPiDZJyDdHzkQss+fIMceEHQLc6wa+xXUOYSwVtnJLsgCP+m189dWO/Cy5pkyrYMwefAEdd7QMPUzjEVpqO4c633qAI1q6Y3z+8uMiZ0msNiQRGVzBPdbgngwE87U6HY1ty5nEFB+aSkpRioMrLw6YycT5YOkhHcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2X4Rd5e; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d2b354c72so4467195f8f.1;
        Tue, 05 Mar 2024 09:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709659002; x=1710263802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PKbxpo3p1gqabtKHicX9j5Bzb5Ge571GvOAKw++fIX8=;
        b=Q2X4Rd5eDpMFLUSQYNIc6ds26PauSkFXTVlggxPcmcGpoFdHUgnEDoJVaRyV8+BeHi
         v1jiiwPU5zc5rrkMh7HOQJFOqX6gBnvPNYN+Pi4KmIqwzEf1OZ7v6ErEeY6kw54OZ4x4
         KRwmEQs7orfnZKbDjMMqVLbK76bOM/axnEDi+89B38Fpulg5LyZxVgKY5nSEFANQ5IB9
         Cy7ZP+CznK+qpSi8ZNdXxLpzl16uFpfZo1jpyvSQ6c+wgh+g0q7XxUKFs+RUezTcg3a3
         exIF/S49Z9OF4J2hiQ5dbfDkTaZaRWTtr1rik8RKcbJdQ/iv/kAjAmVxm2ltecMJvE57
         rfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709659002; x=1710263802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKbxpo3p1gqabtKHicX9j5Bzb5Ge571GvOAKw++fIX8=;
        b=jDfnM0y41B6aefpjTfy5GmY8fe1oSlQOt8brXwrw/kRToFca29ZDKlXU6Bqm9vfXuX
         K3Rj02AvOI9aKzXhg3KKvT0+kB05tB2kVJuvEeute+8GusnGCmluX1usDZouVX6k7GIR
         vsQ8K4nUeS7zKVKVfQUkIQPtqn6M/3QGvUy9lPg/lWfWjivlSGcBCWYSotWPnwISItFl
         OBKFJUc0lcuBq+n51yrPeDsNfe8mJ4lHKPUTz1FW1L2AcmHvQtJOum2wTz3++k+fZvFA
         Ck/K8fAkG/CEaVQYNXAdxTSPx6inlAXslD/qdy7shLTLIbtaJy00EAdvlWYpejuEOzv+
         ayfg==
X-Forwarded-Encrypted: i=1; AJvYcCU8EJSol6XdLwLxG6mXOy0DZPbTF3Wtu0e7pIFgSOqZZK4tdKIx8Nt4WpjomTTR3MSSqe69WM3O5jrZ+rGCObzK0B+5a5DJNhte4yXgKnMLNM0soA9Zs1wBe89QuyqfzZxEzf2QjcqSFPxrRRyh1Cv1U54EV4l57Or+0XQAOcH+rYipccGciJgBFIMI
X-Gm-Message-State: AOJu0YyoSSy6JCtuLyH8Abwj2Trx6zL6fx/x3EkoJLMLWhpypOsF3yo6
	7rBHlK2V16yC1clAOnZZT0oj+HHhOwdCjOJjUTH44pYRy4oynERX
X-Google-Smtp-Source: AGHT+IHIBCVUp/teBNt+MD+eC5T5ObcOSa11pOm8x4zOw8GdB041i2c+71Mg3Wqb6mYmgalSHgDcyQ==
X-Received: by 2002:a5d:4ec5:0:b0:33e:1b2a:bd6e with SMTP id s5-20020a5d4ec5000000b0033e1b2abd6emr8516158wrv.33.1709659002332;
        Tue, 05 Mar 2024 09:16:42 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:6479:f309:81e3:3373])
        by smtp.gmail.com with ESMTPSA id bw1-20020a0560001f8100b0033d6bc17d0esm15831640wrb.74.2024.03.05.09.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:16:41 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: serial: renesas,scif: Document R9A09G057 support
Date: Tue,  5 Mar 2024 17:16:00 +0000
Message-Id: <20240305171600.328699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document support for the Serial Communication Interface with FIFO (SCIF)
available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface in
the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
(R9A07G044) SoC, with the only difference being that the RZ/V2H(P) SoC has
three additional interrupts: one for Tx end/Rx ready and the other two for
Rx and Tx buffer full, which are edge-triggered.

No driver changes are required as generic compatible string
"renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 .../bindings/serial/renesas,scif.yaml         | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 4610a5bd580c..b2c2305e352c 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -80,6 +80,7 @@ properties:
               - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
               - renesas,scif-r9a07g054      # RZ/V2L
               - renesas,scif-r9a08g045      # RZ/G3S
+              - renesas,scif-r9a09g057      # RZ/V2H(P)
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
   reg:
@@ -101,6 +102,16 @@ properties:
           - description: Break interrupt
           - description: Data Ready interrupt
           - description: Transmit End interrupt
+      - items:
+          - description: Error interrupt
+          - description: Receive buffer full interrupt
+          - description: Transmit buffer empty interrupt
+          - description: Break interrupt
+          - description: Data Ready interrupt
+          - description: Transmit End interrupt
+          - description: Transmit End/Data Ready interrupt
+          - description: Receive buffer full interrupt (EDGE trigger)
+          - description: Transmit buffer empty interrupt (EDGE trigger)
 
   interrupt-names:
     oneOf:
@@ -116,6 +127,16 @@ properties:
           - const: bri
           - const: dri
           - const: tei
+      - items:
+          - const: eri
+          - const: rxi
+          - const: txi
+          - const: bri
+          - const: dri
+          - const: tei
+          - const: teidri
+          - const: rxi-edge
+          - const: txi-edge
 
   clocks:
     minItems: 1
-- 
2.34.1


