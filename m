Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA187D570C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbjJXP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjJXP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:57:32 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8732310A;
        Tue, 24 Oct 2023 08:57:30 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so3053821a34.0;
        Tue, 24 Oct 2023 08:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698163050; x=1698767850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHcRvpJFapb0Q3P+9BlCR7HD1XqDuZe4P3/x1wWBCyM=;
        b=e/aYb36J9bJmw7VKSOMzbPOlEo9IyRl6tUx+LJNhRMFWgJVtnuBi6XkOb6Fsd9K8a/
         NbU1PnEo2IfER2htsqEQxHHvwEqduOog8PwY4/0IK2FH+eLF8wzzvteCfq6/LjzF1176
         quxJMGllPmIbIKEUfKt+h6I2V6Nn6twxRVEF/kMRW0mcUA4nOXfyBoksbUw5vUgEjrfk
         EvEg5p7FNLxzUvZFzx8bfU2tQuu5Ws1TjiKrChHZ1wq7aJdfmf/BMrc8mJrW6ASl6Xzj
         VWygi5cKcqo2AE0HKnZOP3SZjbcggUYDpAI3y0r8P3nkmUwRX7dzEKJmbSTJqHr3QpCm
         SFmA==
X-Gm-Message-State: AOJu0YxmDLo5bGCtlYua/Hvv399yDu6HY8JdeiFP50g53oVdyaZMGVd9
        gEFAD5BG8O3CLbX8V7d+Jg==
X-Google-Smtp-Source: AGHT+IGHYmHNXEiTTfwOzmFz01R3ZgSU10kI3zUH744k0D8HWbiWLtUy7kIW318y+4z87Hn4RJxUqA==
X-Received: by 2002:a9d:618d:0:b0:6b9:26ce:5e5c with SMTP id g13-20020a9d618d000000b006b926ce5e5cmr13881917otk.31.1698163049764;
        Tue, 24 Oct 2023 08:57:29 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f3-20020a4ae603000000b0057b74352e3asm1986286oot.25.2023.10.24.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 08:57:29 -0700 (PDT)
Received: (nullmailer pid 3929057 invoked by uid 1000);
        Tue, 24 Oct 2023 15:57:28 -0000
Date:   Tue, 24 Oct 2023 10:57:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <mwalle@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: mtd: partitions: Add binman
 compatible
Message-ID: <20231024155728.GA3707756-robh@kernel.org>
References: <20231009220436.2164245-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009220436.2164245-1-sjg@chromium.org>
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

On Mon, Oct 09, 2023 at 04:04:13PM -0600, Simon Glass wrote:
> Add a compatible string for binman, so we can extend fixed-partitions
> in various ways.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v4:
> - Change subject line
> 
> Changes in v3:
> - Drop fixed-partition additional compatible string
> - Drop fixed-partitions from the example
> - Mention use of compatible instead of label
> 
> Changes in v2:
> - Drop mention of 'enhanced features' in fixed-partitions.yaml
> - Mention Binman input and output properties
> - Use plain partition@xxx for the node name
> 
>  .../bindings/mtd/partitions/binman.yaml       | 63 +++++++++++++++++++
>  .../bindings/mtd/partitions/partitions.yaml   |  1 +
>  MAINTAINERS                                   |  5 ++
>  3 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> new file mode 100644
> index 000000000000..7d6c8bd738f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Google LLC
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binman firmware layout
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +select: false
> +
> +description: |
> +  The binman node provides a layout for firmware, used when packaging firmware
> +  from multiple projects. It is based on fixed-partitions, with some
> +  extensions, but uses 'compatible' to indicate the contents of the node, to
> +  avoid perturbing or confusing existing installations which use 'label' for a
> +  particular purpose.
> +
> +  Binman supports properties used as inputs to the firmware-packaging process,
> +  such as those which control alignment of partitions. This binding addresses
> +  these 'input' properties. For example, it is common for the 'reg' property
> +  (an 'output' property) to be set by Binman, based on the alignment requested
> +  in the input.
> +
> +  Once processing is complete, input properties have mostly served their
> +  purpose, at least until the firmware is repacked later, e.g. due to a
> +  firmware update. The 'fixed-partitions' binding should provide enough
> +  information to read the firmware at runtime, including decompression if
> +  needed.
> +
> +  Documentation for Binman is available at:
> +
> +  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html
> +
> +  with the current image-description format at:
> +
> +  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#image-description-format
> +
> +allOf:
> +  - $ref: /schemas/mtd/partitions/fixed-partitions.yaml#
> +
> +properties:
> +  compatible:
> +    const: binman

This couldn't possibly pass validation. Including fixed-partitions.yaml 
says the compatible must be one thing and this says something else.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "binman";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@100000 {
> +            label = "u-boot";
> +            reg = <0x100000 0xf00000>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> index 1dda2c80747b..849fd15d085c 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> @@ -15,6 +15,7 @@ maintainers:
>  
>  oneOf:
>    - $ref: arm,arm-firmware-suite.yaml
> +  - $ref: binman.yaml
>    - $ref: brcm,bcm4908-partitions.yaml
>    - $ref: brcm,bcm947xx-cfe-partitions.yaml
>    - $ref: fixed-partitions.yaml
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c934244acc31..ebc8158fe67d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3536,6 +3536,11 @@ F:	Documentation/filesystems/bfs.rst
>  F:	fs/bfs/
>  F:	include/uapi/linux/bfs_fs.h
>  
> +BINMAN
> +M:	Simon Glass <sjg@chromium.org>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/mtd/partitions/binman*
> +
>  BITMAP API
>  M:	Yury Norov <yury.norov@gmail.com>
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> -- 
> 2.42.0.609.gbb76f46606-goog
> 
