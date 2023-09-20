Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAAD7A749A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjITHpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbjITHo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:44:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFEEF2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:44:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B06C43395;
        Wed, 20 Sep 2023 07:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695195893;
        bh=CUy5nbKHvNNWzc7wvrdjNqIowVr8juKuzhQtXQtY0E8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VjVwMSo2BFQ4ZN94kcvqgFKI2LLphwE9j/2TCMlsGmkNvlE3NnRIx1RkWehvHIYMW
         eKyxHvjiqjBBx6r4pk2N/maUiUyz9ETQs32ahwv6sDIG1holAZ9kQGnEXM6T6r/xIH
         UPaJc9yJTP/2XNq/Y7MibBwp1oUEIzWa+/kIAAbtdAGJKrfdVU/dR9UqbK9VBDsLAX
         R1AG8VTwr0woMnc8S8SdQjpoxPFOzt52xzObAn7usRq8bGZnafNQm822jcxEm9Ig1f
         zUncMMPOE5VA0PCQvv4Dih/istjfmBiyQlsr3pnbjtC7lTtEKgYp0epV9DEhRs6tDS
         ITF2nWd/UULbA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9ada609bb62so838618366b.2;
        Wed, 20 Sep 2023 00:44:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YyJISESA9nx24DKAe+hM2WouQMOAADeZhjdUvKsSd7ITeWp2gD2
        NB2RBsViEISHss1lHKSqDH+OwEK50+XN33PTUBs=
X-Google-Smtp-Source: AGHT+IF2n/KDXrUAYLrBICpVZHiK7Hkrk5C0+YyZ+GUHHWrlPX11eVtSbZh+/iRJVkdhpD139PNbaZUBqWCbIdzdLL4=
X-Received: by 2002:a17:906:300e:b0:9a1:bebc:8282 with SMTP id
 14-20020a170906300e00b009a1bebc8282mr1435848ejz.32.1695195891933; Wed, 20 Sep
 2023 00:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <c5061fbe8ef9c4971cd45de7b5d8408dc1b848b4.1695189879.git.wangchen20@iscas.ac.cn>
In-Reply-To: <c5061fbe8ef9c4971cd45de7b5d8408dc1b848b4.1695189879.git.wangchen20@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Sep 2023 15:44:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTfpG=Hy9bhPjLVVvSt-t=Hgu2GFm_V8-VRLuaCmSpv0g@mail.gmail.com>
Message-ID: <CAJF2gTTfpG=Hy9bhPjLVVvSt-t=Hgu2GFm_V8-VRLuaCmSpv0g@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] dt-bindings: riscv: Add T-HEAD C920 compatibles
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
> The C920 is RISC-V CPU cores from T-HEAD Semiconductor.
> Notably, the C920 core is used in the SOPHGO SG2042 SoC.
>
> Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 38c0b5213736..185a0191bad6 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -47,6 +47,7 @@ properties:
>                - sifive,u74-mc
>                - thead,c906
>                - thead,c910
> +              - thead,c920
Reviewed-by: Guo Ren <guoren@kernel.org>

>            - const: riscv
>        - items:
>            - enum:
> --
> 2.25.1
>


--=20
Best Regards
 Guo Ren
