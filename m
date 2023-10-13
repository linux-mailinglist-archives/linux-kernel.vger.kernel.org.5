Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0699E7C8E75
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJMUpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMUpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:45:03 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13C083;
        Fri, 13 Oct 2023 13:45:00 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57bbb38d5d4so1275022eaf.2;
        Fri, 13 Oct 2023 13:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697229900; x=1697834700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWvifqWkzzIi7KppOHWAQtPVkgMwHo2U39bHS0Oz/kQ=;
        b=r/iNoUxcMXvF02uOJO6RbVjADu9BHd58Vpz6M2W8z4jI6jyS3UJa14P5TWngrj0JNo
         RY6H2J6fpfMgULM3nRx3c+hvWqzsA2kb1UgUE40zEdloLTFfuYK5E1n78nhZ3wT5pxT0
         7dWMx2orCPxYCXz6H/qQu7uPTsMrmzopoE1fQEbJY/aA2qnRyKOlHY9X2nVgf/eOAu50
         Pehl7HTSSLCjlaS3g1aCfirxfp9oEmoaAtNgy3Ko56FUGHnN1feU7S73k0fy0i/O5ZJR
         HH+rnmDX7GXjlo5DFtzmVQvroM93tY4nR+Ys1uDL5MJ5FrBz/hfCelDr0MjAFULZWl6U
         6i1g==
X-Gm-Message-State: AOJu0YzgXEzF5h51EnFZIC/pYYa4mcqCqSohlMhMHsyWBoeAOjCZ7IVk
        yA7V5eFyNiA9r5mGfCZIjw==
X-Google-Smtp-Source: AGHT+IHoN94MR4gpIe2dWY+Xyk+VFhdOpMYWuz2jSr4iGaty8EGdGRDIcjcKdPUw2Q7yW6h7qg8ffg==
X-Received: by 2002:a4a:3016:0:b0:57d:e76d:c206 with SMTP id q22-20020a4a3016000000b0057de76dc206mr28837731oof.1.1697229899850;
        Fri, 13 Oct 2023 13:44:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m22-20020a4ae3d6000000b0057bcabf2eeasm23181oov.4.2023.10.13.13.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 13:44:59 -0700 (PDT)
Received: (nullmailer pid 385027 invoked by uid 1000);
        Fri, 13 Oct 2023 20:44:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Julien Massot <julien.massot@iot.bzh>,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: Drop kernel copy of common reserved-memory bindings
Date:   Fri, 13 Oct 2023 15:08:49 -0500
Message-ID: <20231013200851.347042-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common reserved-memory bindings have recently been copied from the
kernel tree into dtschema. The preference is to host common, stable
bindings in dtschema. As reserved-memory is documented in the DT Spec,
it meets the criteria.

The v2023.09 version of dtschema is what contains the reserved-memory
schemas we depend on, so bump the minimum version to that. Otherwise,
references to these schemas will generate errors.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile    |   2 +-
 .../remoteproc/renesas,rcar-rproc.yaml        |   2 +-
 .../bindings/reserved-memory/framebuffer.yaml |  52 -----
 .../reserved-memory/memory-region.yaml        |  40 ----
 .../reserved-memory/reserved-memory.txt       |   2 +-
 .../reserved-memory/reserved-memory.yaml      | 181 ------------------
 .../reserved-memory/shared-dma-pool.yaml      |  97 ----------
 .../bindings/sound/mediatek,mt8188-afe.yaml   |   2 +-
 8 files changed, 4 insertions(+), 374 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/memory-region.yaml
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 8b395893bd85..3e886194b043 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -6,7 +6,7 @@ DT_MK_SCHEMA ?= dt-mk-schema
 DT_SCHEMA_LINT = $(shell which yamllint || \
   echo "warning: python package 'yamllint' not installed, skipping" >&2)
 
-DT_SCHEMA_MIN_VERSION = 2022.3
+DT_SCHEMA_MIN_VERSION = 2023.9
 
 PHONY += check_dtschema_version
 check_dtschema_version:
diff --git a/Documentation/devicetree/bindings/remoteproc/renesas,rcar-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/renesas,rcar-rproc.yaml
index 4bea679a0f61..5c280117dc93 100644
--- a/Documentation/devicetree/bindings/remoteproc/renesas,rcar-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/renesas,rcar-rproc.yaml
@@ -31,7 +31,7 @@ properties:
       remoteproc device. This is variable and describes the memories shared with
       the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
       vrings, ...).
-      (see ../reserved-memory/reserved-memory.yaml)
+      (see reserved-memory/reserved-memory.yaml in dtschema project)
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml b/Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml
deleted file mode 100644
index 851ec24d6142..000000000000
--- a/Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml
+++ /dev/null
@@ -1,52 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/reserved-memory/framebuffer.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: /reserved-memory framebuffer node
-
-maintainers:
-  - devicetree-spec@vger.kernel.org
-
-allOf:
-  - $ref: reserved-memory.yaml
-
-properties:
-  compatible:
-    const: framebuffer
-    description: >
-      This indicates a region of memory meant to be used as a framebuffer for
-      a set of display devices. It can be used by an operating system to keep
-      the framebuffer from being overwritten and use it as the backing memory
-      for a display device (such as simple-framebuffer).
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    / {
-        compatible = "foo";
-        model = "foo";
-        #address-cells = <1>;
-        #size-cells = <1>;
-
-        chosen {
-            framebuffer {
-                compatible = "simple-framebuffer";
-                memory-region = <&fb>;
-            };
-        };
-
-        reserved-memory {
-            #address-cells = <1>;
-            #size-cells = <1>;
-            ranges;
-
-            fb: framebuffer@80000000 {
-                compatible = "framebuffer";
-                reg = <0x80000000 0x007e9000>;
-            };
-        };
-    };
-...
diff --git a/Documentation/devicetree/bindings/reserved-memory/memory-region.yaml b/Documentation/devicetree/bindings/reserved-memory/memory-region.yaml
deleted file mode 100644
index 592f180e6b0d..000000000000
--- a/Documentation/devicetree/bindings/reserved-memory/memory-region.yaml
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/reserved-memory/memory-region.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Reserved Memory Region
-
-maintainers:
-  - devicetree-spec@vger.kernel.org
-
-description: |
-  Regions in the /reserved-memory node may be referenced by other device
-  nodes by adding a memory-region property to the device node.
-
-select: true
-
-properties:
-  memory-region:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    description: >
-      Phandle to a /reserved-memory child node assigned to the device.
-
-  memory-region-names:
-    $ref: /schemas/types.yaml#/definitions/string-array
-    description: >
-      A list of names, one for each corresponding entry in the
-      memory-region property
-
-additionalProperties: true
-
-examples:
-  - |
-    fb0: video@12300000 {
-        /* ... */
-        reg = <0x12300000 0x1000>;
-        memory-region = <&display_reserved>;
-    };
-
-...
diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index 1810701a8509..8ce72996d500 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -1 +1 @@
-This file has been moved to reserved-memory.yaml.
+This file has been moved to reserved-memory.yaml in the dtschema repository.
diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
deleted file mode 100644
index c680e397cfd2..000000000000
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
+++ /dev/null
@@ -1,181 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/reserved-memory/reserved-memory.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: /reserved-memory Child Node Common
-
-maintainers:
-  - devicetree-spec@vger.kernel.org
-
-description: >
-  Reserved memory is specified as a node under the /reserved-memory node. The
-  operating system shall exclude reserved memory from normal usage one can
-  create child nodes describing particular reserved (excluded from normal use)
-  memory regions. Such memory regions are usually designed for the special
-  usage by various device drivers.
-
-  Each child of the reserved-memory node specifies one or more regions
-  of reserved memory. Each child node may either use a 'reg' property to
-  specify a specific range of reserved memory, or a 'size' property with
-  optional constraints to request a dynamically allocated block of
-  memory.
-
-  Following the generic-names recommended practice, node names should
-  reflect the purpose of the node (ie. "framebuffer" or "dma-pool").
-  Unit address (@<address>) should be appended to the name if the node
-  is a static allocation.
-
-properties:
-  reg: true
-
-  size:
-    oneOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - $ref: /schemas/types.yaml#/definitions/uint64
-    description: >
-      Length based on parent's \#size-cells. Size in bytes of memory to
-      reserve.
-
-  alignment:
-    oneOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - $ref: /schemas/types.yaml#/definitions/uint64
-    description: >
-      Length based on parent's \#size-cells. Address boundary for
-      alignment of allocation.
-
-  alloc-ranges:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-    description: >
-      Address and Length pairs. Specifies regions of memory that are
-      acceptable to allocate from.
-
-  iommu-addresses:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    description: >
-      A list of phandle and specifier pairs that describe static IO virtual
-      address space mappings and carveouts associated with a given reserved
-      memory region. The phandle in the first cell refers to the device for
-      which the mapping or carveout is to be created.
-
-      The specifier consists of an address/size pair and denotes the IO
-      virtual address range of the region for the given device. The exact
-      format depends on the values of the "#address-cells" and "#size-cells"
-      properties of the device referenced via the phandle.
-
-      When used in combination with a "reg" property, an IOVA mapping is to
-      be established for this memory region. One example where this can be
-      useful is to create an identity mapping for physical memory that the
-      firmware has configured some hardware to access (such as a bootsplash
-      framebuffer).
-
-      If no "reg" property is specified, the "iommu-addresses" property
-      defines carveout regions in the IOVA space for the given device. This
-      can be useful if a certain memory region should not be mapped through
-      the IOMMU.
-
-  no-map:
-    type: boolean
-    description: >
-      Indicates the operating system must not create a virtual mapping
-      of the region as part of its standard mapping of system memory,
-      nor permit speculative access to it under any circumstances other
-      than under the control of the device driver using the region.
-
-  reusable:
-    type: boolean
-    description: >
-      The operating system can use the memory in this region with the
-      limitation that the device driver(s) owning the region need to be
-      able to reclaim it back. Typically that means that the operating
-      system can use that region to store volatile or cached data that
-      can be otherwise regenerated or migrated elsewhere.
-
-allOf:
-  - if:
-      required:
-        - no-map
-
-    then:
-      not:
-        required:
-          - reusable
-
-  - if:
-      required:
-        - reusable
-
-    then:
-      not:
-        required:
-          - no-map
-
-oneOf:
-  - oneOf:
-      - required:
-          - reg
-
-      - required:
-          - size
-
-  - oneOf:
-      # IOMMU reservations
-      - required:
-          - iommu-addresses
-
-      # IOMMU mappings
-      - required:
-          - reg
-          - iommu-addresses
-
-additionalProperties: true
-
-examples:
-  - |
-    / {
-      compatible = "foo";
-      model = "foo";
-
-      #address-cells = <2>;
-      #size-cells = <2>;
-
-      reserved-memory {
-        #address-cells = <2>;
-        #size-cells = <2>;
-        ranges;
-
-        adsp_resv: reservation-adsp {
-          /*
-           * Restrict IOVA mappings for ADSP buffers to the 512 MiB region
-           * from 0x40000000 - 0x5fffffff. Anything outside is reserved by
-           * the ADSP for I/O memory and private memory allocations.
-           */
-          iommu-addresses = <&adsp 0x0 0x00000000 0x00 0x40000000>,
-                            <&adsp 0x0 0x60000000 0xff 0xa0000000>;
-        };
-
-        fb: framebuffer@90000000 {
-          reg = <0x0 0x90000000 0x0 0x00800000>;
-          iommu-addresses = <&dc0 0x0 0x90000000 0x0 0x00800000>;
-        };
-      };
-
-      bus@0 {
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges = <0x0 0x0 0x0 0x40000000>;
-
-        adsp: adsp@2990000 {
-          reg = <0x2990000 0x2000>;
-          memory-region = <&adsp_resv>;
-        };
-
-        dc0: display@15200000 {
-          reg = <0x15200000 0x10000>;
-          memory-region = <&fb>;
-        };
-      };
-    };
-...
diff --git a/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml b/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
deleted file mode 100644
index 457de0920cd1..000000000000
--- a/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
+++ /dev/null
@@ -1,97 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: /reserved-memory DMA pool
-
-maintainers:
-  - devicetree-spec@vger.kernel.org
-
-allOf:
-  - $ref: reserved-memory.yaml
-
-properties:
-  compatible:
-    oneOf:
-      - const: shared-dma-pool
-        description: >
-          This indicates a region of memory meant to be used as a shared
-          pool of DMA buffers for a set of devices. It can be used by an
-          operating system to instantiate the necessary pool management
-          subsystem if necessary.
-
-      - const: restricted-dma-pool
-        description: >
-          This indicates a region of memory meant to be used as a pool
-          of restricted DMA buffers for a set of devices. The memory
-          region would be the only region accessible to those devices.
-          When using this, the no-map and reusable properties must not
-          be set, so the operating system can create a virtual mapping
-          that will be used for synchronization. The main purpose for
-          restricted DMA is to mitigate the lack of DMA access control
-          on systems without an IOMMU, which could result in the DMA
-          accessing the system memory at unexpected times and/or
-          unexpected addresses, possibly leading to data leakage or
-          corruption. The feature on its own provides a basic level of
-          protection against the DMA overwriting buffer contents at
-          unexpected times. However, to protect against general data
-          leakage and system memory corruption, the system needs to
-          provide way to lock down the memory access, e.g., MPU. Note
-          that since coherent allocation needs remapping, one must set
-          up another device coherent pool by shared-dma-pool and use
-          dma_alloc_from_dev_coherent instead for atomic coherent
-          allocation.
-
-  linux,cma-default:
-    type: boolean
-    description: >
-      If this property is present, then Linux will use the region for
-      the default pool of the contiguous memory allocator.
-
-  linux,dma-default:
-    type: boolean
-    description: >
-      If this property is present, then Linux will use the region for
-      the default pool of the consistent DMA allocator.
-
-if:
-  properties:
-    compatible:
-      contains:
-        const: restricted-dma-pool
-then:
-  properties:
-    no-map: false
-    reusable: false
-
-unevaluatedProperties: false
-
-examples:
-  - |
-      reserved-memory {
-          #address-cells = <1>;
-          #size-cells = <1>;
-          ranges;
-
-          /* global autoconfigured region for contiguous allocations */
-          linux,cma {
-              compatible = "shared-dma-pool";
-              reusable;
-              size = <0x4000000>;
-              alignment = <0x2000>;
-              linux,cma-default;
-          };
-
-          display_reserved: framebuffer@78000000 {
-              reg = <0x78000000 0x800000>;
-          };
-
-          restricted_dma_reserved: restricted-dma-pool@50000000 {
-              compatible = "restricted-dma-pool";
-              reg = <0x50000000 0x4000000>;
-          };
-      };
-
-...
diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
index 90520f89208b..77af276ed2a2 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
@@ -29,7 +29,7 @@ properties:
     maxItems: 1
     description: |
       Shared memory region for AFE memif.  A "shared-dma-pool".
-      See ../reserved-memory/reserved-memory.yaml for details.
+      See dtschema reserved-memory/shared-dma-pool.yaml for details.
 
   mediatek,topckgen:
     $ref: /schemas/types.yaml#/definitions/phandle
-- 
2.42.0

