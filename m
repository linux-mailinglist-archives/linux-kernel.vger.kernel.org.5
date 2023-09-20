Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0D17A74DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjITHvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjITHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:51:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40954A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:51:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD124C433CB;
        Wed, 20 Sep 2023 07:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695196300;
        bh=YhB+A7iHmnmzoZBCFb7X2I4fWEuWQ8+59ZBtsGegYaE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jpJLjy/5IqVHJKhetfC3m64SELPEhe+uDcmU+8ae7pKKhrI8ttOvhXg8STgC4BECW
         hkjfuqWG5qWX4MVHlTXVPg/lcumtcZqub6g7US/SyHxWJ9icvZDrnh8PlJ1hx2yuoH
         FGmt5RlNRH4MbjPg/RkozOf1ArduSt4F8xFBJZmpDCyJHvnognnaeCXghzgOyPiFNH
         15y1qX41SHRgx7oxVaXIp4mahZxppiSU6VGJb0UikrxDRYeBuLRlcj3r9g49arbstv
         CEr5z1JsBdD+E7/YgN6hsyAXASBwQARxkHFPbaI+gtboRXKDQhSE55SiJJEIy4wlCh
         qBGPGdEDIIAMQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9a645e54806so824476766b.0;
        Wed, 20 Sep 2023 00:51:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YyVsxRTYlOjx0IEVB8GUAZj54BOqT02sQJ4Dz0AElpc3hAh/6cw
        Zd7gIpaWMqi3VhnvrQYG0QrNQF5U9+O5TbE+/sc=
X-Google-Smtp-Source: AGHT+IHJGMtQRq4hJtwB0IoLnShAiYYmpLruCzt+pRdlxwjYpm4dlJQHOZBhuUpQIRfn83gR6MeyI28oZ/mw/6JVkUs=
X-Received: by 2002:a17:906:18c:b0:9ae:5120:514c with SMTP id
 12-20020a170906018c00b009ae5120514cmr237222ejb.0.1695196299190; Wed, 20 Sep
 2023 00:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <05fcf91d60468323a6c7cdb8ac57c356ab4a3050.1695189879.git.wangchen20@iscas.ac.cn>
In-Reply-To: <05fcf91d60468323a6c7cdb8ac57c356ab4a3050.1695189879.git.wangchen20@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Sep 2023 15:51:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR0Q=sdVtSHOgmvnhBk8SJbEi+NjWGR62OB0JJ1i0ekZA@mail.gmail.com>
Message-ID: <CAJF2gTR0Q=sdVtSHOgmvnhBk8SJbEi+NjWGR62OB0JJ1i0ekZA@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] dt-bindings: serial: snps-dw-apb-uart: Add
 Sophgo SG2042 uarts
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

On Wed, Sep 20, 2023 at 2:40=E2=80=AFPM Chen Wang <unicornxw@gmail.com> wro=
te:
>
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>
> Add compatible for the uarts on the Sophgo SG2042 RISC-V SoC.
>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 17c553123f96..011d89e6df0f 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -45,6 +45,7 @@ properties:
>            - const: snps,dw-apb-uart
>        - items:
>            - enum:
> +              - sophgo,sg2042-uart
>                - starfive,jh7100-hsuart
>                - starfive,jh7100-uart
>            - const: snps,dw-apb-uart
> --
> 2.25.1
>
LGTM

Reviewed-by: Guo Ren <guoren@kernel.og>

--=20
Best Regards
 Guo Ren
