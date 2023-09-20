Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135547A7587
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjITINT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjITINP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:13:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E8CB4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:13:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6356EC433CB;
        Wed, 20 Sep 2023 08:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695197589;
        bh=BHg2WeM95rpBPjSMtBK54EXDu7Fym4u87Mw9H+3v6no=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FgbS2oaQQz5/ROzre/v3t66FIfY12n+sbyeiA0ewV0IslizhDBg3fMC/84+vZ/ep5
         VgjuhkUvz258KvDgzSAvbnNYfvvY6H7DvjomLj2uL145N+oHZNZHKcPMuHIVR93ea7
         HN5vAZ00KgCFHNZP8ARg/RKKSGvhH8/hwNhiSnEh8m8ayYHEFlBI3OZHjZkfFasl8R
         Gdh7sXZ60vi6bZuyC5Yf/5Nv1KiG4buobDe3lU81Y4ndCUoZN6AwvChFm2E02cKxSm
         NrLDDzSJm8NKzBoWHnyEk/YWFrK90BYv6oloSNEzcIWv0r5+kpPSjqyunJ9qrkuRfB
         qmKD5BsNUJ3zw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b962c226ceso107127651fa.3;
        Wed, 20 Sep 2023 01:13:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YyuuW6n378j0yl8cTCufv5ZaSMJ92X68grrwz8aD7W8TNnM/yLh
        xIPG6KJi8lm9PlubL+ULoVCegk69Rwo+4nfzNVg=
X-Google-Smtp-Source: AGHT+IGwjome/AlKiUn8xGguHpMmW+YpKm8Pe6RU+TH5Vb8xW7yjkVi5Uq+QUgh8oIAyllj23ml6rFP95Ng60vN9ga0=
X-Received: by 2002:a2e:9959:0:b0:2bd:180d:67b7 with SMTP id
 r25-20020a2e9959000000b002bd180d67b7mr1497733ljj.40.1695197587601; Wed, 20
 Sep 2023 01:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <55865e1ce40d2017f047d3a9e1a9ee30043b271f.1695189879.git.wangchen20@iscas.ac.cn>
In-Reply-To: <55865e1ce40d2017f047d3a9e1a9ee30043b271f.1695189879.git.wangchen20@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Sep 2023 16:12:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTTUYuMi4F8wPsEPMwCv7Fqi9OSBTGoaYmzo6cPwdZjjQ@mail.gmail.com>
Message-ID: <CAJF2gTTTUYuMi4F8wPsEPMwCv7Fqi9OSBTGoaYmzo6cPwdZjjQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
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

On Wed, Sep 20, 2023 at 2:39=E2=80=AFPM Chen Wang <unicornxw@gmail.com> wro=
te:
>
> From: Inochi Amaoto <inochiama@outlook.com>
>
> Add two new compatible string formatted like `C9xx-clint-xxx` to identify
> the timer and ipi device separately, and do not allow c900-clint as the
> fallback to avoid conflict.
Please explain more about the c900-clint mtimer & mswi, why do we need
to separate the c900-clint into two pieces? When could we use
c900-clint which eases dts design?

>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/=
Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index a0185e15a42f..ae69696c5c75 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -39,6 +39,14 @@ properties:
>                - allwinner,sun20i-d1-clint
>                - thead,th1520-clint
>            - const: thead,c900-clint
> +      - items:
> +          - enum:
> +              - sophgo,sg2042-clint-mtimer
> +          - const: thead,c900-clint-mtimer
> +      - items:
> +          - enum:
> +              - sophgo,sg2042-clint-mswi
> +          - const: thead,c900-clint-mswi
>        - items:
>            - const: sifive,clint0
>            - const: riscv,clint0
> --
> 2.25.1
>


--=20
Best Regards
 Guo Ren
