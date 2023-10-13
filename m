Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFACF7C8B19
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjJMQXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjJMQXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:23:22 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F18E116;
        Fri, 13 Oct 2023 09:23:07 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5812eaed1eeso1217370eaf.0;
        Fri, 13 Oct 2023 09:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697214186; x=1697818986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTeWtczTCim3bUIkTH8/1bxuqk9pVOgqh9GbNsNWAg4=;
        b=b+pHnikdxY+shFSVcCUlNqtPbTEClBtTKId9E5lplf85J1+ccIYg13MDgJ5QFTO2xW
         1M9WBfgkuR5iNd50gaVLEdg/MAUhKyDnqpAErrGxGiWp/EJiH0lO4BwEOo12hFBtihDc
         Qgwb/SDIeK3INnrEjMqsLPY/0aKBdNawCxDBzZMP844XqMTnT7E85uwCRAZwf9BujP0H
         Zw7lolkiP46JjY2tvR353Q+RQ6iIz8C6i85DBi/F4fWE6l/trGWIvo5IB2oNUkj3mpGP
         9y03MQX3Dqvp4gS27Gk47lXi4yfoTMBFIcNiFNIjHoN/Mx9e93TYIuNIEpf6cp+TSJF8
         102g==
X-Gm-Message-State: AOJu0YxHAD7+yq0TbUr5WGnC6S+vxTkwLKbg3ySJOotrvJk4aJzq/KcA
        T1qcAAyStDt4+H2Wf041yQ==
X-Google-Smtp-Source: AGHT+IE9D0QOvXopUn2q1b4CNs+O8E6MeuJ6J3Rueqw1UVR0S1wokx9EVO1bmxvkK3J7jzfvrnszSg==
X-Received: by 2002:a4a:3543:0:b0:57d:e3e4:49bc with SMTP id w3-20020a4a3543000000b0057de3e449bcmr25443137oog.8.1697214186330;
        Fri, 13 Oct 2023 09:23:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y45-20020a4a9830000000b0056dbeb283cesm3190019ooi.43.2023.10.13.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 09:23:04 -0700 (PDT)
Received: (nullmailer pid 4063494 invoked by uid 1000);
        Fri, 13 Oct 2023 16:23:03 -0000
Date:   Fri, 13 Oct 2023 11:23:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
Cc:     srinivas.kandagatla@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to
 yaml
Message-ID: <20231013162303.GA3803760-robh@kernel.org>
References: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
 <20231013101450.573-3-praveen.teja.kundanala@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013101450.573-3-praveen.teja.kundanala@amd.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 03:44:47PM +0530, Praveen Teja Kundanala wrote:
> Convert the xlnx,zynqmp-nvmem.txt to yaml.
> 
> Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
> ---
>  .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 46 ---------------
>  .../bindings/nvmem/xlnx,zynqmp-nvmem.yaml     | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
>  create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
> deleted file mode 100644
> index 4881561b3a02..000000000000
> --- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
> +++ /dev/null
> @@ -1,46 +0,0 @@
> ---------------------------------------------------------------------------
> -=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
> ---------------------------------------------------------------------------
> -The nvmem_firmware node provides access to the hardware related data
> -like soc revision, IDCODE... etc, By using the firmware interface.
> -
> -Required properties:
> -- compatible: should be "xlnx,zynqmp-nvmem-fw"
> -
> -= Data cells =
> -Are child nodes of silicon id, bindings of which as described in
> -bindings/nvmem/nvmem.txt
> -
> --------
> - Example
> --------
> -firmware {
> -	zynqmp_firmware: zynqmp-firmware {
> -		compatible = "xlnx,zynqmp-firmware";
> -		method = "smc";
> -
> -		nvmem_firmware {
> -			compatible = "xlnx,zynqmp-nvmem-fw";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			/* Data cells */
> -			soc_revision: soc_revision {
> -				reg = <0x0 0x4>;
> -			};
> -		};
> -	};
> -};
> -
> -= Data consumers =
> -Are device nodes which consume nvmem data cells.
> -
> -For example:
> -	pcap {
> -		...
> -
> -		nvmem-cells = <&soc_revision>;
> -		nvmem-cell-names = "soc_revision";
> -
> -		...
> -	};
> diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> new file mode 100644
> index 000000000000..e03ed8c32537
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/xlnx,zynqmp-nvmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Zynq UltraScale+ MPSoC Non Volatile Memory interface
> +
> +description: |
> +    The ZynqMP MPSoC provides access to the hardware related data
> +    like SOC revision, IDCODE.
> +
> +maintainers:
> +  - Kalyani Akula <kalyani.akula@amd.com>
> +  - Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-nvmem-fw
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +
> +patternProperties:
> +  "^soc_revision@0$":

Fixed string, not a pattern. dtschema will now flag this. Thanks for the 
test case. ;)

> +    type: object

Needs 'additionalProperties' or...


> +    description:
> +      This node is used to read SOC version and IDCODE of ZynqMP. Read-only.
> +

> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - reg

fixed-cell.yaml (via nvmem.yaml) already says this, so this can all be 
dropped. Except that this[1] just landed, so you will need to adapt to 
it.

Though there is an issue that fixed-cell.yaml doesn't restrict the 
allowed properties, so that needs to happen somewhere... Not sure what 
the fix is. Hopefully fixed-cell.yaml can just be changed to 
'additionalProperties: false', but need to see if other properties are 
in use.

Rob

[1] https://lore.kernel.org/all/169667333484.74178.7121029453685069845.b4-ty@linaro.org/
