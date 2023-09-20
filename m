Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB1C7A7481
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjITHoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjITHn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:43:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4BFD8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:43:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685AAC433D9;
        Wed, 20 Sep 2023 07:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695195832;
        bh=wHmXgn83h8NuefG1j3vWq4VR1WzTwO3eqaG3oocDVB0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gRgSZU6x3azX5ElS1nYcLxlZWZ7QSDkZsepTwRi+qF3TCSaQ+o1LcYUjQ5+k7gTJH
         Gk/qpf7/LHUv6AdRbxH3YCVm8tnLYp/iKZultE8y0z5Gi30vHrpwZATUUJQ/bPvjLY
         1ceHeMFLlmdCIw7lRAihr0RiTuQ64OFmYdMYOTlCBcifFlJuhzfVh0jvKghBzJWf7y
         gJUBdmtQictjoL615hAx5KNZQqQ35BZNIp/fR38JcM7LtqI+DxQG4OSk0I4tkXNOPr
         Kxo/7vmrd/IVfUQv/1cUFJHT5YHvEkOmHZT55ecFB1cM95LfycWRg7G7h9NaH4QIU/
         Kpy+G2fH57lVA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2c038a1e2e6so10675521fa.2;
        Wed, 20 Sep 2023 00:43:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YxBM7NWgbdmDjuBGf6PfnZp6aAzZQUs83psVKYMn4aDm6WYFmWI
        qwNiJGG7EHK8RbHNnR1EOou88azsPuF6x6w4vwM=
X-Google-Smtp-Source: AGHT+IFeyS4faWN5sjvWZz1M6kYCPecf5m3kGaQeSQ8YguuVePOuPu3fhfpHheT/C7M40FSL02w8GohuN7y0mMIsWuk=
X-Received: by 2002:a2e:9f4f:0:b0:2b9:f27f:e491 with SMTP id
 v15-20020a2e9f4f000000b002b9f27fe491mr1599633ljk.42.1695195830591; Wed, 20
 Sep 2023 00:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <c6aea83bb1df563b1f2a66c5f230c3861aed1e15.1695189879.git.wangchen20@iscas.ac.cn>
In-Reply-To: <c6aea83bb1df563b1f2a66c5f230c3861aed1e15.1695189879.git.wangchen20@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Sep 2023 15:43:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQntuknORHf2QC5YHX1ZMSRz3b3e+fsE1uZ4AuchB94SA@mail.gmail.com>
Message-ID: <CAJF2gTQntuknORHf2QC5YHX1ZMSRz3b3e+fsE1uZ4AuchB94SA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] dt-bindings: riscv: add sophgo sg2042 bindings
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 2:38=E2=80=AFPM Chen Wang <unicornxw@gmail.com> wro=
te:
>
> Add DT binding documentation for the Sophgo SG2042 Soc [1] and the
> Milk-V Pioneer board [2].
>
> [1]: https://en.sophgo.com/product/introduce/sg2042.html
> [2]: https://milkv.io/pioneer
>
> Acked-by: Chao Wei <chao.wei@sophgo.com>
> Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>  .../devicetree/bindings/riscv/sophgo.yaml     | 28 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml
>
> diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Docume=
ntation/devicetree/bindings/riscv/sophgo.yaml
> new file mode 100644
> index 000000000000..82468ae915db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/sophgo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SoC-based boards
> +
> +maintainers:
> +  - Chao Wei <chao.wei@sophgo.com>
> +  - Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> +
> +description:
> +  Sophgo SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - milkv,pioneer
> +          - const: sophgo,sg2042
> +
> +additionalProperties: true
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..b74d505003e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20063,6 +20063,13 @@ F:     drivers/char/sonypi.c
>  F:     drivers/platform/x86/sony-laptop.c
>  F:     include/linux/sony-laptop.h
>
> +SOPHGO DEVICETREES
> +M:     Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> +M:     Chao Wei <chao.wei@sophgo.com>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/riscv/sophgo.yaml
> +F:     arch/riscv/boot/dts/sophgo/
> +
>  SOUND
>  M:     Jaroslav Kysela <perex@perex.cz>
>  M:     Takashi Iwai <tiwai@suse.com>
> --
> 2.25.1
>
LGTM

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
