Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0BF770D86
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjHEDbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHEDb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:31:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385024ED8;
        Fri,  4 Aug 2023 20:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C683B61783;
        Sat,  5 Aug 2023 03:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFE8C433C8;
        Sat,  5 Aug 2023 03:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691206287;
        bh=Ygnq8tBAlMTkwF79cozfvveIrcpUJbIfQh8kZtFnv+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QeDOaekO4YVYv0JUdfTsvVADmqgv6gEjz49e3xvq9MHlPGQlOwXtJJ+XFL5nBlFFf
         mqPtwAspdvuZTEmDuEFIvuPUHtglf5RjESepXJjCMsJLhfUDIomNDV/ZmR3BwMSmhg
         IU4AaxJM/1OtKqoqp820EZ0ygZhc4+Y/CJQJ7eSNggwJr2s+uDhiZl73ZnOwIkA3Kx
         /rxuu/JlTMs2CSWZ7OK8rntBMDik3zuMJBi+yKH8hvaYeCjp2SV6gqc7CP4GujJH+H
         WKKR7Whq7vFPEz657qecUMmxQUTfL+6OZ6FG7rpLJLt1AqlnXXBFDLF3y1ePGfuPbd
         8P0sSYNcaF6PA==
Date:   Fri, 4 Aug 2023 20:34:25 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v14 02/25] dt-bindings: Add binding for gunyah hypervisor
Message-ID: <lbxu5uzoithbv6ghl3ksmsz6hz57g7b57uqcado7ekupyxkprn@3idnpedjnftf>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-3-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-3-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:30AM -0700, Elliot Berman wrote:
> When Linux is booted as a guest under the Gunyah hypervisor, the Gunyah

Is this unique to the case of booting Linux?

> Resource Manager applies a devicetree overlay describing the virtual
> platform configuration of the guest VM, such as the message queue
> capability IDs for communicating with the Resource Manager. This
> information is not otherwise discoverable by a VM: the Gunyah hypervisor
> core does not provide a direct interface to discover capability IDs nor
> a way to communicate with RM without having already known the
> corresponding message queue capability ID. Add the DT bindings that
> Gunyah adheres for the hypervisor node and message queues.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../bindings/firmware/gunyah-hypervisor.yaml  | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> new file mode 100644
> index 0000000000000..3fc0b043ac3cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/gunyah-hypervisor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Gunyah Hypervisor
> +
> +maintainers:
> +  - Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> +  - Elliot Berman <quic_eberman@quicinc.com>
> +
> +description: |+
> +  Gunyah virtual machines use this information to determine the capability IDs
> +  of the message queues used to communicate with the Gunyah Resource Manager.
> +  See also: https://github.com/quic/gunyah-resource-manager/blob/develop/src/vm_creation/dto_construct.c
> +
> +properties:
> +  compatible:
> +    const: gunyah-hypervisor
> +
> +  "#address-cells":
> +    description: Number of cells needed to represent 64-bit capability IDs.
> +    const: 2
> +
> +  "#size-cells":
> +    description: must be 0, because capability IDs are not memory address
> +                  ranges and do not have a size.
> +    const: 0
> +
> +patternProperties:
> +  "^gunyah-resource-mgr(@.*)?":
> +    type: object
> +    description:
> +      Resource Manager node which is required to communicate to Resource
> +      Manager VM using Gunyah Message Queues.
> +
> +    properties:
> +      compatible:
> +        const: gunyah-resource-manager
> +
> +      reg:
> +        items:
> +          - description: Gunyah capability ID of the TX message queue
> +          - description: Gunyah capability ID of the RX message queue
> +
> +      interrupts:
> +        items:
> +          - description: Interrupt for the TX message queue
> +          - description: Interrupt for the RX message queue
> +
> +    additionalProperties: false
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupts
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    hypervisor {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        compatible = "gunyah-hypervisor";

It's typical to carry the compatible first among the properties.

Unrelated to the binding itself, I don't see any code that matches this
compatible, and as such will probe the resource manager. What am I
missing?

> +
> +        gunyah-resource-mgr@0 {
> +            compatible = "gunyah-resource-manager";
> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX full IRQ */

This is the "Tx no longer full IRQ", so the comment is misleading.

> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX empty IRQ */

And this irq seems to fire when there's data in the RX queue, not when
it's empty...

> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
> +                  /* TX, RX cap ids */

Wrapping this differently will make the comments more useful.

Regards,
Bjorn

> +        };
> +    };
> -- 
> 2.40.0
> 
