Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF078705B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbjHXNhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241370AbjHXNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:37:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73412170F;
        Thu, 24 Aug 2023 06:37:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10E1C6501F;
        Thu, 24 Aug 2023 13:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AB5C433C7;
        Thu, 24 Aug 2023 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692884224;
        bh=3U3iza2rKnDGP9eBsmXIz+qXIBFFKyRg0jO73d+n7rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nw+6TPLwp6z3cmw3zNMGSL3HNi4K0Y/JuGnXUj+rMTVq2A8qMVRmuPyQ6jwH7YhCI
         QYAjYIlVETOgHokB6uuRWNaITKKNamsvSphCIaMshd34ZvyQNJWQlb4RY88+9LaxUP
         6cGrRHFvc1oat9vxnNXUFfX5DXWf2QxaOQnNfFyo1ovrcccIzRfH3vOaspppeSmyZD
         aYrc+8kfwYsJGtqhz8nnY/g8DLlsKMPcPSo2/oB3Xxx78wJTchwf26AFWopP+PGvQO
         sDeyfRem2HKTwRbS1OdU3FuDbUdK2zuKap9iaUYBnP1zciGJILD3IeWHx0D2VQW0SX
         6KQgwFTJG1pQQ==
Received: (nullmailer pid 671019 invoked by uid 1000);
        Thu, 24 Aug 2023 13:37:01 -0000
Date:   Thu, 24 Aug 2023 08:37:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, quic_jhugo@quicinc.com,
        nipun.gupta@amd.com, tzimmermann@suse.de, ogabbay@kernel.org,
        mathieu.poirier@linaro.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, linux@zary.sk, arnd@arndb.de,
        yangyicong@hisilicon.com, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCHv5 1/4] dt-bindings: wiegand: add Wiegand controller
 common properties
Message-ID: <20230824133701.GA649032-robh@kernel.org>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
 <20230824111015.57765-2-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824111015.57765-2-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:10:12PM +0200, Martin Zaťovič wrote:
> Wiegand bus is defined by a Wiegand controller node. This node
> can contain one or more device nodes for devices attached to
> the controller(it is advised to only connect one device as Wiegand
> is a point-to-point bus).

How would multiple devices work? Seems like you'd need some sort of mux 
which would be another node. If there's not really any need, then I'd 
just say it's only a single device. Either way the binding needs to 
define this.

> 
> Wiegand controller needs to specify several attributes such as
> the pulse length in order to function properly. These attributes
> are documented here.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  .../bindings/wiegand/wiegand-controller.yaml  | 39 +++++++++++++++++++
>  MAINTAINERS                                   |  5 +++
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> new file mode 100644
> index 000000000000..8f36287e4fed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/wiegand/wiegand-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wiegand Generic Controller Common Properties
> +
> +maintainers:
> +  - Martin Zaťovič <m.zatovic1@gmail.com>
> +
> +description:
> +  Wiegand busses can be described with a node for the Wiegand controller device
> +  and a set of child nodes for each SPI slave on the bus.

Some more detail on what Wiegand is would be useful. Link to spec? What 
it is used for?

> +
> +properties:
> +  $nodename:
> +    pattern: "^wiegand(@.*|-[0-9a-f])?$"

The '-[0-9a-f]' suffix should be decimal rather than hex.

> +
> +  pulse-len-us:
> +    description:
> +      Length of the low pulse in microseconds.
> +
> +  interval-len-us:
> +    description:
> +      Length of a whole bit (both the pulse and the high phase) in microseconds.
> +
> +  frame-gap-us:
> +    description:
> +      Length of the last bit of a frame (both the pulse and the high phase) in
> +      microseconds.

If you have multiple devices, you need to define the child node format. 
Specifically, you need addresses for multiple devices. So you need to 
define the unit-address format, #address-cells and #size-cells values, 
and any constraints on 'reg' such as max address and/or number of entries.

Rob
