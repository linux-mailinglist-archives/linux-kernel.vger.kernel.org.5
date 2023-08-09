Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C1776752
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjHISbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjHISbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:31:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A281BCF;
        Wed,  9 Aug 2023 11:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFB0D61485;
        Wed,  9 Aug 2023 18:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B3BC433C7;
        Wed,  9 Aug 2023 18:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691605881;
        bh=mNZ+YunKlSq1QXLl6rJgFDv+juRcDVmioVraKPgpXSg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LK+YekbEFlkG5rN+a30HzQ0o58dL2PvyMebXLvYWij67I1ISo6yXPJwD2WWvv5NPu
         pzn4aFXn4uv42gpp6auB/SVu1z7VPkQPCeePlRSssoNI00IFynjPNaft1ydnuSzVI/
         +DxgNv56ALMxqHV09Xhox1L6J8taBOYc2a1B8T/TeM6oi20PS/QrnMd1rKS5zgsBBd
         P24AeV5/30JDv4Cmsa+beoCpifw17GYvRUH1WFRpwv1ZD22VruKYeCly/VhMPUHcq9
         itMdTRP/C+HNCmm3Pr+iO+kZP/+ezxIEa/SU1h9bzOjGkjNBXitMwAUjpxh9mkRgrF
         BYUQ4SXTBo6Cg==
Message-ID: <3f17d903-20c4-59ac-f52b-ed108fe9475f@kernel.org>
Date:   Wed, 9 Aug 2023 20:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] devicetree: bindings: Add keypad driver ducumentation
Content-Language: en-US
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230808072252.3229-1-Wenhua.Lin@unisoc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230808072252.3229-1-Wenhua.Lin@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 09:22, Wenhua Lin wrote:
> Add keypad driver ducumentation.

1. Please use scripts/get_maintainers.pl to get a list of necessary
people and lists to CC. It might happen, that command when run on an
older kernel, gives you outdated entries. Therefore please be sure you
base your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.


2. Please use subject prefixes matching the subsystem. You can get them
for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
directory your patch is touching.


Limited review follows:

> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  .../bindings/input/sprd-keypad.yaml           | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/sprd-keypad.yaml

Filename matching compatible, so sprd,block-name-etc.yaml

> 
> diff --git a/Documentation/devicetree/bindings/input/sprd-keypad.yaml b/Documentation/devicetree/bindings/input/sprd-keypad.yaml
> new file mode 100644
> index 000000000000..51710e1eb389
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/sprd-keypad.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2023 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/sprd-keypad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Device-Tree bindings for GPIO attached keys

This should not work and you should see warnings... which means:

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

so drop "Device-tree bindings".

Title also says nothing about the hardware - it is entirely unrelated.
Describe the hardware.


> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +description: |
> +    Keypad controller is used to interface a SoC with a matrix-keypad device.

Mention which SoC.

> +    The keypad controller supports multiple row and column lines.
> +    A key can be placed at each intersection of a unique row and a unique column.
> +    The keypad controller can sense a key-press and key-release and report the
> +    event using a interrupt to the cpu.
> +
> +properties:
> +    compatible:
> +    const: sprd,sc9860-keypad
> +
> +    reg:
> +        maxItems: 1

OK, so this was for 100% not tested and won't work. No need to waste our
time on this. Test before sending:

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Best regards,
Krzysztof

