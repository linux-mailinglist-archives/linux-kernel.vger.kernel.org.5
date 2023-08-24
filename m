Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0AD787086
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbjHXNkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbjHXNkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13C5C7;
        Thu, 24 Aug 2023 06:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5507D66CAF;
        Thu, 24 Aug 2023 13:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3512C433C8;
        Thu, 24 Aug 2023 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692884416;
        bh=A8J2LnxJra5d1H9UVsWjdPJ1mHs82MiMsF4YKN8vTlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DoCQXFEZDQ40KQBPRUAP7rCq5+r0a5PswtY/0sJzcOa4HJtiXKcZM/bKP6x6gwtEB
         Ejos7WLn+2Z0DJ5lnl899JUF5adg3tPYSDRcmWwZeUZ+XypqqyIBoXdcMOgw/Umn3g
         M7ezZ7w9LMP+i1BaeMpYkKKbfL3s1/nC7AZB08kcapQian/izxW1T2ZU4KgVsJNBuf
         JwJ9xBssenm2pwz3VXGGkm++HfPyF7/Ae/9aOpP0XF2QRvGnZlbMHCMUUBBmoQRu4Y
         saZAzeUzzOMvjJrvwo+ntbBdTaN1owZyAd8I1sB5fV1ibDJWN5WFAZE84OgSNPUqiS
         DHwk24Gq27oHQ==
Received: (nullmailer pid 674275 invoked by uid 1000);
        Thu, 24 Aug 2023 13:40:13 -0000
Date:   Thu, 24 Aug 2023 08:40:13 -0500
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
Subject: Re: [PATCHv5 3/4] dt-bindings: wiegand: add GPIO bitbanged Wiegand
 controller
Message-ID: <20230824134013.GB649032-robh@kernel.org>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
 <20230824111015.57765-4-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824111015.57765-4-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:10:14PM +0200, Martin Zaťovič wrote:
> GPIO bitbanged Wiegand controller requires definitions of GPIO lines to be
> used on top of the common Wiegand properties. Wiegand utilizes two such
> lines - DATA0(low data line) and DATA1(high data line).
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  .../bindings/wiegand/wiegand-gpio.yaml        | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
> new file mode 100644
> index 000000000000..cf2cb938de02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/wiegand/wiegand-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO bitbanged Wiegand interface properties
> +
> +maintainers:
> +  - Martin Zaťovič <m.zatovic1@gmail.com>
> +
> +description:
> +  This represents the GPIO lines used for bit-banged Wiegand on dedicated GPIO
> +  lines.
> +
> +allOf:
> +  - $ref: /schemas/wiegand/wiegand-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: wiegand-gpio
> +
> +  data-gpios:
> +    description: GPIOs used as Wiegand data lines, DATA0 and DATA1 respectivelly.
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - data-gpios
> +
> +unevaluatedProperties: false

You'll find this fails if you add an actual child node. Assuming you go 
with only 1 child node allowed, then you need:

unevaluatedProperties:
  type: object

(There's not any way to say only 1 child, but multiple would have 
constraints in the common binding as I explained.)

Rob
