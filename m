Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639547D57C1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbjJXQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjJXQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:16:50 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD202E8;
        Tue, 24 Oct 2023 09:16:47 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6c7c2c428c1so2744901a34.0;
        Tue, 24 Oct 2023 09:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698164206; x=1698769006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXPrvqhlemMI7g9xIhmWAAMr6+6qbQ1ZU0REA78QcHI=;
        b=CZZzCXRTp+5Kkrc6PLfrFzeQ5/QACxIJoJD9vR3KY3i2ZUBlUz2+eNVKl3a2k5b8+z
         kfpn6UM+pQ1ofREpxO6CK+HqJ6IlbS/MxOweL4kuwtbhy7pLhFPgFL9QS4G/73Jdqg02
         ksYoOy/DLA1PfeZSpLLn7Vgo9LbfDozxvtTiUoGtAlbvLnUeNl23puJNRwKC/NdV1taW
         eoOo4AgR9Waj96pv0M8fE2VV8mI+g2jLhnjFwLy1SiTUqPZ9xVcDBjduVGv15WxAFlcR
         nLoPmPKS3wqWoYCSJX45ak64DI87aV5nMNrNwOaqRsBTJjWu6K1OcOUmy1AADez1/J59
         ZbIg==
X-Gm-Message-State: AOJu0Yw4Gk/WYQ1kpTOAmrH9a7NybjuYTlLmkUTJWsMk5QeXo4aWvwKk
        fMC76YAxZlzYRqAMxNYp7g==
X-Google-Smtp-Source: AGHT+IHcKt9w7bZiBt4/3rwDVdR83Ok9yFwzHM6Yw+yCPtpOKiwL2Yodvx6SUVggzi+iygsVFKZgpg==
X-Received: by 2002:a05:6808:1306:b0:3b2:e379:c11d with SMTP id y6-20020a056808130600b003b2e379c11dmr10337541oiv.22.1698164206547;
        Tue, 24 Oct 2023 09:16:46 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k2-20020a544702000000b003b2f2724c48sm1975040oik.11.2023.10.24.09.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 09:16:45 -0700 (PDT)
Received: (nullmailer pid 4031785 invoked by uid 1000);
        Tue, 24 Oct 2023 16:16:44 -0000
Date:   Tue, 24 Oct 2023 11:16:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <mwalle@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
Message-ID: <20231024161644.GB3707756-robh@kernel.org>
References: <20231009220436.2164245-1-sjg@chromium.org>
 <20231009220436.2164245-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009220436.2164245-2-sjg@chromium.org>
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

On Mon, Oct 09, 2023 at 04:04:14PM -0600, Simon Glass wrote:
> Add two compatible for binman entries, as a starting point for the
> schema.
> 
> Note that, after discussion on v2, we decided to keep the existing
> meaning of label so as not to require changes to existing userspace
> software when moving to use binman nodes to specify the firmware
> layout.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v4:
> - Correct selection of multiple compatible strings
> 
> Changes in v3:
> - Drop fixed-partitions from the example
> - Use compatible instead of label
> 
> Changes in v2:
> - Use plain partition@xxx for the node name
> 
>  .../mtd/partitions/binman-partition.yaml      | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> new file mode 100644
> index 000000000000..35a320359ec1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Google LLC
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/binman-partition.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binman partition
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +select: false

So this schema is never used. 'select: false' is only useful if 
something else if referencing the schema.

> +
> +description: |
> +  This corresponds to a binman 'entry'. It is a single partition which holds
> +  data of a defined type.
> +
> +allOf:
> +  - $ref: /schemas/mtd/partitions/partition.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: binman,entry     # generic binman entry

'binman' is not a vendor. You could add it if you think that's useful. 
Probably not with only 1 case...

> +      - items:
> +          - const: u-boot       # u-boot.bin from U-Boot project
> +          - const: atf-bl31     # bl31.bin or bl31.elf from TF-A project

Probably should use the new 'tfa' rather than old 'atf'. Is this the 
only binary for TFA? The naming seems inconsistent in that every image 
goes in (or can go in) a bl?? section. Why does TFA have it but u-boot 
doesn't? Perhaps BL?? is orthogonal to defining what is in each 
partition. Perhaps someone more familar with all this than I am can 
comment.

Once you actually test this, you'll find you are specifying:

compatible = "u-boot", "atf-bl31";


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
> +            compatible = "u-boot";
> +            reg = <0x100000 0xf00000>;
> +        };
> +
> +        partition@200000 {
> +            compatible = "atf-bl31";
> +            reg = <0x200000 0x100000>;
> +        };
> +    };
> -- 
> 2.42.0.609.gbb76f46606-goog
> 
