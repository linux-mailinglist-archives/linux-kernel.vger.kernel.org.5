Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADEB7857FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjHWMnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjHWMns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D180D1;
        Wed, 23 Aug 2023 05:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFEC264B97;
        Wed, 23 Aug 2023 12:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D845C433C7;
        Wed, 23 Aug 2023 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692794625;
        bh=/oxOH5QslwcioinYcdYU1DcnBL2tOvJ8u1CWKWHgJaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSeP+i6QwvdJ60NcsS4pDWGN3sTdjSpfQB4jiaVLLv1XY0W/IqfUWMEqx0W8H2OKw
         0iMGdjO22CntMdk808/Cm7rXEm3+pkLbbp/LEMMLEkL67Vyo9m+EQLhJAUsGhbc61c
         nCMfN6Eq5yRT6rldBiEvx8j9dlLp37xXPu3LkNw6OhcEMjOZhLrw0FWJdXFootqJzh
         BqorUZveKobJGg7FcF/8U3Zs8NRvTO/4FDpZXzubrGvEvgBx9wRcBs6k/++jgPo6mN
         GoWoLs+i1B5sm3idUIlP5Y0Q2uJ918PNWwAe3PsmPWzqsSQpqOahwDeZYnILD/x2KV
         oQgIIMQ1EwdFA==
Received: (nullmailer pid 2031776 invoked by uid 1000);
        Wed, 23 Aug 2023 12:43:40 -0000
Date:   Wed, 23 Aug 2023 07:43:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Subject: Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw binding doc
Message-ID: <20230823124340.GA2022486-robh@kernel.org>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-2-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823073330.1712721-2-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 01:03:20PM +0530, Pankaj Gupta wrote:
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

v5? Where's the changelog for *this* patch?

>  .../bindings/firmware/fsl,imx-se-fw.yaml      | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
> new file mode 100644
> index 000000000000..f7230f93e56d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
> @@ -0,0 +1,121 @@
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
> +  The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
> +  secure enclave within the SoC boundary to enable features like
> +  - HSM
> +  - SHE
> +  - V2X
> +
> +  It uses message unit to communicate and coordinate to pass messages
> +  (e.g., data,  status and control) through its interfaces.
> +
> +  This driver configures multiple misc-devices on the MU, to exchange
> +  messages from User-space application and NXP's Edgelocke Enclave firmware.
> +  The driver ensures that the messages must follow the following protocol
> +  defined.
> +
> +                                     Non-Secure           +   Secure
> +                                                          |
> +                                                          |
> +                   +---------+      +-------------+       |
> +                   | ele_mu.c+<---->+imx-mailbox.c|       |
> +                   |         |      |  mailbox.c  +<-->+------+    +------+
> +                   +---+-----+      +-------------+    | MU X +<-->+ ELE |
> +                       |                               +------+    +------+
> +                       +----------------+                 |
> +                       |                |                 |
> +                       v                v                 |
> +                   logical           logical              |
> +                   receiver          waiter               |
> +                      +                 +                 |
> +                      |                 |                 |
> +                      |                 |                 |
> +                      |            +----+------+          |
> +                      |            |           |          |
> +                      |            |           |          |
> +               device_ctx     device_ctx     device_ctx   |
> +                                                          |
> +                 User 0        User 1       User Y        |
> +                 +------+      +------+     +------+      |
> +                 |misc.c|      |misc.c|     |misc.c|      |
> +  kernel space   +------+      +------+     +------+      |
> +                                                          |
> +  +------------------------------------------------------ |
> +                     |             |           |          |
> +  userspace     /dev/ele_muXch0    |           |          |
> +                           /dev/ele_muXch1     |          |
> +                                         /dev/ele_muXchY  |
> +                                                          |
> +
> +  When a user sends a command to the firmware, it registers its device_ctx
> +  as waiter of a response from firmware.
> +
> +  A user can be registered as receiver of command from the ELE.
> +  Create char devices in /dev as channels of the form /dev/ele_muXchY with X
> +  the id of the driver and Y for each users. It allows to send and receive
> +  messages to the NXP EdgeLock Enclave IP firmware on NXP SoC, where current
> +  possible value, i.e., supported SoC(s) are imx8ulp, imx93.

Looks like a bunch of Linux details which don't belong in the binding.

Why do you need your own custom interface to userspace? No one else has 
a similar feature in their platforms? Something like virtio or rpmsg 
doesn't work?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8ulp-se-fw
> +      - fsl,imx93-se-fw
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
> +  fsl,mu-did:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      By design, Domain is a clean separated processing island with separate power,
> +      clocking and peripheral; but with a tightly integrated bus fabric for efficient
> +      communication. The Domain to which this message-unit is associated, is identified
> +      via Domain ID or did.
> +
> +  sram-pool:

I believe 'sram' is the somewhat standard property to refer to an SRAM 
region.

> +    items:
> +      - description: SRAM memory instance.

Used for what?

> +
> +  memory-region:
> +    items:
> +      - description: Reserved memory region that can be accessed by firmware. Used for
> +          exchanging the buffers between driver and firmware.
> +
> +required:
> +  - compatible
> +  - mboxes
> +  - mbox-names
> +  - mu-id
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ele_fw: se-fw {
> +      compatible = "fsl,imx8ulp-se-fw";
> +      mbox-names = "tx", "rx";
> +      mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
> +      fsl,mu-id = <2>;
> +    };
> -- 
> 2.34.1
> 
