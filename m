Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD47B98C6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbjJDXl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbjJDXlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:41:25 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2857C9;
        Wed,  4 Oct 2023 16:41:21 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3af65455e7fso272356b6e.3;
        Wed, 04 Oct 2023 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696462881; x=1697067681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4C1iihc3EDnsL/rTdUR5Op9U6iZWDJfi2p6KDHXbMCg=;
        b=ifi6Y6PlyomqjHtWWBT9F1EAhHeZLFwYQxquDS9F4hwKJje+NHz/nRc8Y3s3INPyR4
         J7JB9+GF1t/43fzoDfAtu1ZUywHmxaJPWUgrDFrvmT++z9gTG9wYhsZoFeHxRObZW8ZB
         voOCUSbyqmPwZfyBk9gbGTPcSVYZYATGMxcLKSeF5cqWoaVozbXP9zPQ18j0DfkBzYER
         cVhNN3WlLieqjNdY2ZOJ/+gUIlVZzh/9/BRonzH0RMYp+it95DVmFNOrMsuOxmEg1JFy
         zKMiOUJ4Bj4bcS2beHzsdFxcdEmt6QHzOWtnVEEqvjqYbDo9fhCCScNZpiCc5PREmMFi
         Auqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696462881; x=1697067681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C1iihc3EDnsL/rTdUR5Op9U6iZWDJfi2p6KDHXbMCg=;
        b=X7SCeyX+fEe6CcktCGH2foTXiRxHWxwAAovDsqwSTomGIAzeZTpg5zpmfxr3//CQot
         UsyjUwuCtvfwvf/W6X0zgtgd6c7y89Gc5tjsuGazSTdDZotJLKoIElZtfByLv2UPVu5P
         1QPgVZTKBvriIjKtOC4zxW5O0G7mnbWPxGXiMYWwvVPDaw+gOMOw7eLjQFrhPhigHVu6
         FF2JFzecVOpDpRxxx/EXi/3ZTVcA8eVRDzgaW5scTMOcFCSFGPQy5yE1P02mjVtq2GLy
         V/sr/4wl9tShiKMeggnWS7fwSYWdRUPIAtGmCS63N04VkIbVAt7mVqoOh+XtUpQmkRY+
         sjww==
X-Gm-Message-State: AOJu0YxGfcHt+o7iwQ6QPp/vDJpp6oV58cVlR2CVWIbeRhnsdp7Z4g6s
        uZhVGIMsKQ4WWNI+KS7R2R81E17AqqiDkgwWbsQ=
X-Google-Smtp-Source: AGHT+IF1G34r6cm8vMu/bXXwaMqnblKv3w1itMr8e1W0/KkBZ7RueirXtjIlAqju5LO/oQRnSsQ9D66zRw06dgwbdk8=
X-Received: by 2002:a05:6358:6f06:b0:13c:eea2:d021 with SMTP id
 r6-20020a0563586f0600b0013ceea2d021mr3677892rwn.9.1696462880856; Wed, 04 Oct
 2023 16:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231004091552.3531659-1-hugues.fruchet@foss.st.com> <20231004091552.3531659-4-hugues.fruchet@foss.st.com>
In-Reply-To: <20231004091552.3531659-4-hugues.fruchet@foss.st.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 4 Oct 2023 18:41:09 -0500
Message-ID: <CAHCN7xKrriTPaRMJ-r86cSgFDUUP1At08imLBr_zEP0g3fga_g@mail.gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: media: Document STM32MP25 VENC video encoder
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 4:16=E2=80=AFAM Hugues Fruchet
<hugues.fruchet@foss.st.com> wrote:
>
> Add STM32MP25 VENC video encoder bindings.
>
> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> ---
>  .../bindings/media/st,stm32mp25-venc.yaml     | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-=
venc.yaml
>
> diff --git a/Documentation/devicetree/bindings/media/st,stm32mp25-venc.ya=
ml b/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
> new file mode 100644
> index 000000000000..c69e0a34f675
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/st,stm32mp25-venc.yaml#

Can this dt-binding be made more generic, like something like
hantro-h1 or VC8000NanoE?

I think there will be more boards that may incorporate the Hantro-H1
or a VC8000 in the future, because I don't think this IP is unique to
the STM32MP25.

adam

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32MP25 VENC video encoder
> +
> +maintainers:
> +  - Hugues Fruchet <hugues.fruchet@foss.st.com>
> +
> +description:
> +  The STMicroelectronics STM32MP25 SOCs embeds a VENC video hardware enc=
oder
> +  peripheral based on Verisilicon VC8000NanoE IP (former Hantro H1).
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp25-venc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    venc: venc@580e0000 {
> +        compatible =3D "st,stm32mp25-venc";
> +        reg =3D <0x580e0000 0x800>;
> +        interrupts =3D <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names =3D "venc";


Is the interrupt-names needed if there is only one?

> +        clocks =3D <&ck_icn_p_venc>;
> +        clock-names =3D "venc-clk";

Same thing for the clock.  if there is only one clock, doe they need names?

adam
> +    };
> --
> 2.25.1
>
