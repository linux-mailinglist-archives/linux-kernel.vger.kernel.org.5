Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856B77A754B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjITIGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjITIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:06:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C5A9E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:06:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1041C433C8;
        Wed, 20 Sep 2023 08:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695197182;
        bh=hbkRSwtqknfZzbBxtOQPm/Rkx/c9bq3LLK5/SR9tbg4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UFI69/KWJ6BKobIvz9DqGXMj3sdUyuQ8R3Dtg6ijZLv951uB1FesbKe3kK9COvunc
         UEdR5b89j6jXnmPXyyCgOOzerrixaxviivzAmsz7aoEFXDdRKmb4zjooQDfkqbSOmk
         JnusihP36lJK/DxE9tVyvMKDEjbUInEVT0H1FnNOYo4z3mYPPcCSJlO9sf4+JQz4yM
         IHyvfmSr82SJ3nhWkXNshf5rOxwB5ziHZEugNm1qN8EUMgOkzRM/gz3PP0yfzYdxGb
         80FD98LOUgSlUn3jebxmxJfEiok6+hLDLhMcmJpCHxzDkfCKOn1ljI4wV/DToPlAAk
         yBtXPUjsUpCow==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso191773566b.1;
        Wed, 20 Sep 2023 01:06:22 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyj1l3COazA3eTDA4FQqWt4guYp7vqigBQZwQ3I0sY6g+slAiRu
        46oEMPjQclORDQlI88ck1eO62d3pcx6X09FtkkQ=
X-Google-Smtp-Source: AGHT+IGe2iP6JINAEB+mczmvizOEP6stOTmfWVD0FmvCA21rimzKtCLaNP7bv9zznAo/CO7ULxgc7OLk0np/ulX7HU4=
X-Received: by 2002:a17:906:d3:b0:9ae:375f:bf00 with SMTP id
 19-20020a17090600d300b009ae375fbf00mr1490393eji.62.1695197181403; Wed, 20 Sep
 2023 01:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <835006e5c76ba1c53eed1b7806a08ddea3390bc5.1695189879.git.wangchen20@iscas.ac.cn>
In-Reply-To: <835006e5c76ba1c53eed1b7806a08ddea3390bc5.1695189879.git.wangchen20@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Sep 2023 16:06:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRi-R_bDSzsPi+Kkf46iT8DGdX0wEUM5L5AHqA=NU9GJQ@mail.gmail.com>
Message-ID: <CAJF2gTRi-R_bDSzsPi+Kkf46iT8DGdX0wEUM5L5AHqA=NU9GJQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] riscv: defconfig: enable SOPHGO SoC
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

On Wed, Sep 20, 2023 at 2:41=E2=80=AFPM Chen Wang <unicornxw@gmail.com> wro=
te:
>
> Enable SOPHGO SoC config in defconfig to allow the default
> upstream kernel to boot on Milk-V Pioneer board.
>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index ab86ec3b9eab..bf737cfa1d2c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -32,6 +32,7 @@ CONFIG_SOC_SIFIVE=3Dy
>  CONFIG_SOC_STARFIVE=3Dy
>  CONFIG_ARCH_SUNXI=3Dy
>  CONFIG_SOC_VIRT=3Dy
> +CONFIG_ARCH_SOPHGO=3Dy
>  CONFIG_SMP=3Dy
>  CONFIG_HOTPLUG_CPU=3Dy
>  CONFIG_PM=3Dy
> --
> 2.25.1
>
LGTM

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
