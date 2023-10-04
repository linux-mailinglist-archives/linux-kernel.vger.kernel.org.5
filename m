Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C87F7B85AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbjJDQre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243410AbjJDQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:47:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8CFAB;
        Wed,  4 Oct 2023 09:47:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742A4C433CA;
        Wed,  4 Oct 2023 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696438047;
        bh=u5vibFQwkh8UIxXlWdlTN5pp+bQqeetBERWkOE476cs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XWT1rYlOevfblznVe03wbu+5L4ift3Gq1rm/KKWsQ6EnYQH6QXWYVxED5BwPB+xVU
         84ngMoTdzr6BBgSP6reG4f4+lL97qLZmtQu+st7dG48HJpPjM/f/5Axpr5aX/wMzxD
         VRCtxfEtKi/Js+V0oVD5OLrffNr6lgW7/YVZQuuRtYCQ/3xoMwt80H+PSaPFKWqhdz
         GI6IQEyYNVqsaTI5yHKEr1vfWUos3faBJX/uo3lCn6mxNqt5uBAqyrdUiTG27oobex
         sSG51wxTIr2JnVLaZNlUGIl7Sky1qQbARHBjSokUI2DXkHYKDu3DV/oA9EL6D+7Fff
         d7grcKvMLRBxg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-505748580ceso26286e87.3;
        Wed, 04 Oct 2023 09:47:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YwnDBAIvbnNV9VVvdQgYoHWShWMAXdixoGXmMe3lmMSbxhR0lnf
        3vq4nX2iyeNIjOILc4+dRrau2RJPWKKpejDYPA==
X-Google-Smtp-Source: AGHT+IGH5B9IUykC9MgzqqooZDwGjlF4MLEJyn1zZaxDUCnUe0iFb35HePEAg5ZtDa0llKM7HYYNjaSkT04+eVYeXJU=
X-Received: by 2002:ac2:5f6e:0:b0:503:3281:2ffd with SMTP id
 c14-20020ac25f6e000000b0050332812ffdmr2112624lfc.41.1696438045612; Wed, 04
 Oct 2023 09:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231004161038.2818327-1-gregory.clement@bootlin.com> <20231004161038.2818327-7-gregory.clement@bootlin.com>
In-Reply-To: <20231004161038.2818327-7-gregory.clement@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 4 Oct 2023 11:47:12 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+NkRM07U8enKSVvpOg+9qtDdnkqs2Pc0X8LgjVVo7Vhg@mail.gmail.com>
Message-ID: <CAL_Jsq+NkRM07U8enKSVvpOg+9qtDdnkqs2Pc0X8LgjVVo7Vhg@mail.gmail.com>
Subject: Re: [PATCH 06/11] dt-bindings: mips: Add bindings for Mobileye SoCs
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 11:11=E2=80=AFAM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Add the yaml bindings for Mobileye SoCs. Currently only EyeQ5 is
> supported
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../devicetree/bindings/mips/mobileye.yaml    | 36 +++++++++
>  include/dt-bindings/soc/mobileye,eyeq5.h      | 77 +++++++++++++++++++
>  2 files changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/mobileye.yaml
>  create mode 100644 include/dt-bindings/soc/mobileye,eyeq5.h
>
> diff --git a/Documentation/devicetree/bindings/mips/mobileye.yaml b/Docum=
entation/devicetree/bindings/mips/mobileye.yaml
> new file mode 100644
> index 000000000000..f47767bc2c8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/mobileye.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause

Use what checkpatch tells you.

> +# Copyright 2023 Mobileye Vision Technologies Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mips/mobileye.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mobileye SoC series
> +
> +maintainers:
> +  - Vladimir Kondratiev <vladimir.kondratiev@intel.com>
> +  - Gregory CLEMENT <gregory.clement@bootlin.com>
> +  - Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> +
> +description: |

Don't need '|'.

> +    Boards with a Mobileye SoC shall have the following properties.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +
> +  compatible:
> +    oneOf:
> +      - description: Boards with Mobileye EyeQ5 SoC
> +        items:
> +          - enum:
> +              - mobileye,eyeq5-epm5
> +          - const: mobileye,eyeq5
> +
> +      - description: Boards with Mobileye EyeQ6 SoC
> +        items:
> +          - const: mobileye,eyeq6

Not valid to have only SoC compatible. Add this when you have a user.

> +
> +additionalProperties: true
> +
> +...
> diff --git a/include/dt-bindings/soc/mobileye,eyeq5.h b/include/dt-bindin=
gs/soc/mobileye,eyeq5.h
> new file mode 100644
> index 000000000000..7d8cb97b45bf
> --- /dev/null
> +++ b/include/dt-bindings/soc/mobileye,eyeq5.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2023 Mobileye Vision Technologies Ltd.
> + */
> +#ifndef _DT_BINDINGS_SOC_MOBILEYE_EYEQ5_H
> +#define _DT_BINDINGS_SOC_MOBILEYE_EYEQ5_H
> +
> +/* EQ5 interrupts */
> +#define NUM_INT_I2C_A                  1
> +#define NUM_INT_I2C_B                  2
> +#define NUM_INT_I2C_C                  3
> +#define NUM_INT_I2C_D                  4
> +#define NUM_INT_I2C_E                  5

These are interrupt numbers? Note that we never do headers for
interrupt numbers, so drop this.

Rob
