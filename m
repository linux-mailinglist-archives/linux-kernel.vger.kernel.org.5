Return-Path: <linux-kernel+bounces-61647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2A68514E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB02628A9DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F0F4D9E6;
	Mon, 12 Feb 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrROLVyI"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E313B787
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743678; cv=none; b=nIu/AWskZKsH71RpeZEkyCJWntnaiK6jeNk8GIUPmIYFnIiPTxpz95C6oCOo/3RdxUrxWrU6d8Q+mVx8XAW9Adcwl2Q1dNhru8WRINuv9A9txqQ6Ybh61KUYVvIFGQyyXuF9AD0oamR4Hpzw3PvXmD3PlJEq21gbKL6x5kmGdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743678; c=relaxed/simple;
	bh=IrOdF2IkBl2jU+cs6JkBmakSjiXX4Bcd9lmtDOI7FSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jZyJv8tHnf7akCkDsIdDPKSMmbDMd6wZ2RGQ//60rXR7jmKvrGO3k9EY0RJ112SiLsnVz1iZA7bWC3PWkpEZiUA8hwdTjIXrVcq6erFtJv3S8Cdl+Nkofa3nRWiU9RemXnDZ1ermmBBai3iYsQ00prgPcF7Tvi0LXA8SdrNdxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrROLVyI; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33b6e444c76so1038828f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707743675; x=1708348475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weAbudB3k3wPqp+4oDt/WoN+euSYJ/f5cRIeaqwfqjk=;
        b=vrROLVyIUc69oKVb/Bvw5eOwovBUGYXKKzKUT/25HPfN0B6IteVu+BQ++koOzHbXfx
         TBwJpYFJrqeWTuTNQy+rcgBRzxYPBt/klLvADjNcRcVN8rB0vU543aYI//jr2K3D3W1Q
         8GKCpCVJkDpwVaWjFFX019frbnJZbX3VhSCg8SIjBvR9EU74Hsy1svR7MZn20paPnaby
         SkUR+tDYJswUdeMQyIW/YkXd+V20xCCpNy5Ciq02xKEa6GwSJQgOjr2POGVrr+EpBZyU
         +9eVm1+6fl75VqgMYTJ3Q00YRjE6qeCZxLqT941GAYEvyyfXRzZeO8SbuCskZLpXZvMp
         ESnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743675; x=1708348475;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=weAbudB3k3wPqp+4oDt/WoN+euSYJ/f5cRIeaqwfqjk=;
        b=NwWIRbP6WkGPY0R4PDYh0cufWqpEWPwkH74b43U+14BK2reDzyXroLke9ulmI9sUw5
         uKU+RYjr7nstomjgH0HlTpaGclvL04+2MoMmDySDkOFHcjnO4+hJBWKbrtk6QIMt8aZM
         UluHqM7Zdsqk/3GrzQKj8n+E0O93Ne8X6b9J9Mk7UP0may2xyiVnHunkl8rdi1fLCxCO
         1VcfQtgsg/YXCLOIJNbP7blqHQEGxXxbIxgsfby9UAZVLweTL4ylyDvKJmLaBHHxtwPs
         DK///GmIyTSpgXiVu2DhKywpBE2UEgzFa1/P4Ftv8ExV9xan46BCpPY2Dl64ly3vgh91
         gERQ==
X-Gm-Message-State: AOJu0YzNOlCUdHY5gqhvO5t1mWfiZbBacLxB89xdVHEfOcNFS4+Zkp+5
	E3DLs9OZ9zxVIJHx4jN7EZXclA6DoGwka7oF3Gwc+UnHxiCG8K1JhJhIrTzczVpECDmXaaQ0Tcu
	vysfQeD/nRQ==
X-Google-Smtp-Source: AGHT+IFZySJWx+sJiH1D/tqRLGTEXs/l+QZVWepQz6m1RRZuOBSja+jh8SjmiG4dW0L1Nwzda60ddfO2GObytg==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:6000:a16:b0:33b:6489:a97d with SMTP
 id co22-20020a0560000a1600b0033b6489a97dmr13629wrb.14.1707743675651; Mon, 12
 Feb 2024 05:14:35 -0800 (PST)
Date: Mon, 12 Feb 2024 13:13:22 +0000
In-Reply-To: <20240212131323.2162161-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212131323.2162161-1-panikiel@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212131323.2162161-9-panikiel@google.com>
Subject: [PATCH 8/9] media: dt-bindings: Add Intel Displayport RX IP
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The Intel Displayport RX IP is a part of the DisplayPort Intel FPGA IP
Core. It implements a DisplayPort 1.4 receiver capable of HBR3 video
capture and Multi-Stream Transport. The user guide can be found here:

https://www.intel.com/programmable/technical-pdfs/683273.pdf

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 .../devicetree/bindings/media/intel,dprx.yaml | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/intel,dprx.yaml

diff --git a/Documentation/devicetree/bindings/media/intel,dprx.yaml b/Docu=
mentation/devicetree/bindings/media/intel,dprx.yaml
new file mode 100644
index 000000000000..3ed37e0a4a94
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/intel,dprx.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/intel,dprx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel DisplayPort RX IP
+
+maintainers:
+  - Pawe=C5=82 Anikiel <panikiel@google.com>
+
+properties:
+  compatible:
+    const: intel,dprx
+
+  reg:
+    items:
+      - description: core registers
+      - description: irq registers
+
+  interrupts:
+    maxItems: 1
+
+  intel,has-mst:
+    type: boolean
+    description: The device supports Multi-Stream Transport
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: SST main link
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: MST virtual channel 0 or SST main link
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: MST virtual channel 1
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: MST virtual channel 2
+
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: MST virtual channel 3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - if:
+      required:
+        - intel,has-mst
+    then:
+      required:
+        - ports
+    else:
+      required:
+        - port
+
+additionalProperties: false
+
+examples:
+  - |
+    dprx@c0062000 {
+        compatible =3D "intel,dprx";
+        reg =3D <0xc0062000 0x800>,
+              <0xc0060f80 0x10>;
+        interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+        intel,has-mst;
+
+        ports {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            port@0 {
+                reg =3D <0>;
+                dprx_mst_0: endpoint {
+                    remote-endpoint =3D <&fb_mst0_0>;
+                };
+            };
+
+            port@1 {
+                reg =3D <1>;
+                dprx_mst_1: endpoint {
+                    remote-endpoint =3D <&fb_mst1_0>;
+                };
+            };
+
+            port@2 {
+                reg =3D <2>;
+                dprx_mst_2: endpoint {
+                    remote-endpoint =3D <&fb_mst2_0>;
+                };
+            };
+
+            port@3 {
+                reg =3D <3>;
+                dprx_mst_3: endpoint {
+                    remote-endpoint =3D <&fb_mst3_0>;
+                };
+            };
+        };
+    };
+
+  - |
+    dprx@c0064000 {
+        compatible =3D "intel,dprx";
+        reg =3D <0xc0064000 0x800>,
+              <0xc0060fe0 0x10>;
+        interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+
+        port {
+            dprx_sst_0: endpoint {
+                remote-endpoint =3D <&fb_sst_0>;
+            };
+        };
+    };
--=20
2.43.0.687.g38aa6559b0-goog


