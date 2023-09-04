Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99F47911D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346308AbjIDHOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjIDHOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:14:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D23099;
        Mon,  4 Sep 2023 00:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDCA461167;
        Mon,  4 Sep 2023 07:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC38C433C7;
        Mon,  4 Sep 2023 07:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693811667;
        bh=pV1JdXN/UN77OWQbJvFR9ti4vvNAc9hx/NUH52oHLt0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AVOcTiHwyZqMP2aTXOddUPAwDbp3O8j1KJZLVJkAnKglOcW0IS/dwQsRrF72znNce
         UkOauOKNAnO9oQsJKQJHnN6ELB7rrg4BaqO0bnvaTknB4E3wEAJTnFWAP5TLE1Cj82
         KNGLPIrc1Zvyd+8fgmrsa0y2NkGnbL0PoCFUYq78r9eyCaZGDQXeB43FEqI/Yfhdpw
         +kA5WaSVAXQMtoOsxyRtMxjyY16rXiU5NnXEOlpCvcJR+YQt3b9ZN1j4BkgI7qv8iC
         Tjlp+zi+HHYa9tuGhU972gCZdAsAkLN0q6sgGRM2//eRJh2MQJme5IVIpSdJfEjhDS
         zfoyX+9BDJrMw==
Message-ID: <937ea540-09e1-65f2-7165-662bbee2542b@kernel.org>
Date:   Mon, 4 Sep 2023 09:14:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 1/3] dt-bindings: Add beaglecc1352
Content-Language: en-US
To:     Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Nishanth Menon <nm@ti.com>
References: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
 <20230902182845.1840620-2-ayushdevel1325@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230902182845.1840620-2-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2023 20:28, Ayush Singh wrote:
> Add DT bindings for BeagleCC1352 co-processor UART.

This does not look like UART controller.

> 
> The BeaglePlay has a CC1352 co-processor. This co-processor is connected
> to the main AM62 (running Linux) over UART. The CC1352 can run Zephyr
> and other embedded OS. This commit adds DT bindings for the BeagleCC1352

Please do not use "This commit/patch", but imperative mood. See longer
explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> UART, which will allow Linux platform drivers to identify and access this
> device.
> 
> This commit adds serial/beaglecc1352 for identifying this UART. It is
> used by an upcoming gb-beagleplay greybus driver.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

> 
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  .../bindings/serial/beaglecc1352.yaml         | 25 +++++++++++++++++++

It's not a serial driver. Don't put it in unrelated directory.

>  MAINTAINERS                                   |  6 +++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/beaglecc1352.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/beaglecc1352.yaml b/Documentation/devicetree/bindings/serial/beaglecc1352.yaml
> new file mode 100644
> index 000000000000..54db630a2a50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/beaglecc1352.yaml

Missing vendor prefix. Filename should match compatible. Compatible is
not "beaglecc1352"


> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/beaglecc1352.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BeaglePlay CC1352 serial UART

How is this serial UART? Of what? The SoC? Do not describe interface but
the device.

> +
> +maintainers:
> +  - Ayush Singh <ayushdevel1325@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: beagle,cc1352

No resources? This does not seem useful... Put it then only in trivial
devices if your hardware - hardware, not driver - does not have any
pins, interrupts or other resources.

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    beaglecc1352 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Best regards,
Krzysztof

