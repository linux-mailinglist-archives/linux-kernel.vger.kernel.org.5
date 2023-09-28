Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8D67B258F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjI1SwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjI1SwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:52:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5810119C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:52:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFFDC433C8;
        Thu, 28 Sep 2023 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695927122;
        bh=n3aZdNHw4MpEqxnCX4fjYDB+dJUPetWTFBhMgHS1KU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Flz0tRnVGo4/Y0PD9nmkCdwWh/N9m61Q8xa2FbhfSXDcp9moHABUQSJFXB+c8ynIN
         Y+zcjCkLKHVqVx1IatT+ZLBDXX8ylvQSqyrcn9nfUfDVh6aMsTWOVQMqUu2syXsnkU
         aGhlU7a2VXrA9HW6bebOLy8QCRV0pDLJNl8ns8G02VgFMtSv/KFZ1aNY8IG1js3cEG
         RrT/+bU02sp7OHJlGaKTnhpJG36yFmUgjssgDEHYwHJVydSaF30Ll22knqO64SQFls
         xa0hMWoptxs6SHtPCDsJzwC1jMM/IeA80EGhJ8baIu+gOSD+M2VBo0+MAgNmF4iFLQ
         iVLw/CXpBeL5A==
Received: (nullmailer pid 1052656 invoked by uid 1000);
        Thu, 28 Sep 2023 18:51:59 -0000
Date:   Thu, 28 Sep 2023 13:51:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Subject: Re: [PATCH v6 02/11] dt-bindings: arm: fsl: add imx-se-fw binding doc
Message-ID: <20230928185159.GA1035361-robh@kernel.org>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
 <20230927175401.1962733-3-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927175401.1962733-3-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:23:52PM +0530, Pankaj Gupta wrote:
> The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
> secure enclave within the SoC boundary to enable features like
> - HSM
> - SHE
> - V2X
> 
> Communicates via message unit with linux kernel. This driver
> is enables communication ensuring well defined message sequence
> protocol between Application Core and enclave's firmware.
> 
> Driver configures multiple misc-device on the MU, for multiple
> user-space applications can communicate on single MU.
> 
> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../bindings/firmware/fsl,imx-se-fw.yaml      | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
> new file mode 100644
> index 000000000000..d250794432b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/fsl,imx-se-fw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX EdgeLock Enclave Firmware (ELEFW)
> +
> +maintainers:
> +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> +
> +description:

Need '|' to preserve formatting.

> +  The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
> +  secure enclave within the SoC boundary to enable features like
> +  - HSM
> +  - SHE
> +  - V2X
> +
> +  It uses message unit to communicate and coordinate to pass messages
> +  (e.g., data,  status and control) through its interfaces.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8ulp-se-fw
> +      - fsl,imx93-se-fw

The firmware is not compatible across chips?

> +
> +  mboxes:
> +    description:
> +      All MU channels must be within the same MU instance. Cross instances are
> +      not allowed. Users need to ensure that used MU instance does not conflict
> +      with other execution environments.
> +    items:
> +      - description: TX0 MU channel
> +      - description: RX0 MU channel
> +
> +  mbox-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  fsl,mu-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Identifier to the message-unit among the multiple message-unit that exists on SoC.
> +      Per message-unit, multiple misc-devices are created, that are  used by userspace

Extra space in there.

Wrap lines at 80 unless there's a benefit to going to 100.

> +      application as logical-waiter and logical-receiver.
> +
> +  memory-region:
> +    items:
> +      - description: Reserved memory region that can be accessed by firmware. Used for
> +          exchanging the buffers between driver and firmware.
> +
> +  fsl,sram:

Just the common 'sram' property.

> +    description: Phandle to the device SRAM

Used for what?

> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +required:
> +  - compatible
> +  - mboxes
> +  - mbox-names
> +  - fsl,mu-id

How is memory-region optional?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ele_fw: se-fw {

Drop unused labels.

> +      compatible = "fsl,imx8ulp-se-fw";
> +      mbox-names = "tx", "rx";
> +      mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
> +      fsl,mu-id = <2>;
> +    };
> -- 
> 2.34.1
> 
