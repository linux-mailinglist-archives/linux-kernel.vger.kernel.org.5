Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059CE7A743A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjITHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjITHfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:35:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB5BC9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:35:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED5BC433C7;
        Wed, 20 Sep 2023 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695195313;
        bh=MwnjbUi7Sx9APmmmeYu8ljwitw4TVsfCiEHzcg97XsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KIrPPOoTRRCKLsXBrrHXlGCl1dlS+AzrvF5nNUDpCtW6vK6bSZ2oMcH/HVFNiFQe9
         rZF1jgAVQmeMP8csfh8PqU8uH53WJ/X6H8g0IP/s5mDoD0/hEX+3vB0IrMX7s89Q0a
         uMsLAaLPSLF288lvxprrDLtzxBBmd3lkeMyyE6B2TTIVF4N0SzSABwKbVUKpGtIW2Z
         qDYetfxJLy/7EcEzHy7LXBHo4pcC4MQNl6OuGPhFmjpMlMSNQSMvHCquZep6VeUyK9
         NtvKE0WAFXUmv6XxUmq4yOEYBZ2turpfGXAL/IjrQ4Ump9qk6ZQS9RJHmmGlc8jHWb
         nqqdHX+dLnggQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso65313111fa.1;
        Wed, 20 Sep 2023 00:35:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy6sWul2TgVnao865s8lKnS8rCvnBn8xAV7BNaR/j5X2V1XIi/U
        g1sdiRcwk4Vq0IMXvDRUF5is/jck/LSqmHFRtT8=
X-Google-Smtp-Source: AGHT+IHch1AXwlNkfWZcAKqcoQehbFmp5SKV23GQUuzMcerp45Vu3rzzpiA/6uMhIfrtq2Gks/bl+L8cD0WzeapAy7o=
X-Received: by 2002:a2e:88d1:0:b0:2bd:10b7:4610 with SMTP id
 a17-20020a2e88d1000000b002bd10b74610mr1389072ljk.25.1695195311475; Wed, 20
 Sep 2023 00:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <2c6db3d2db0d27d4b2b8364e0c03be3da292101e.1695189879.git.wangchen20@iscas.ac.cn>
In-Reply-To: <2c6db3d2db0d27d4b2b8364e0c03be3da292101e.1695189879.git.wangchen20@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Sep 2023 15:34:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQym7Ad8y+m368hr7RgcjNpc2TfWRT8qu0cJyhJHm9vuQ@mail.gmail.com>
Message-ID: <CAJF2gTQym7Ad8y+m368hr7RgcjNpc2TfWRT8qu0cJyhJHm9vuQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] riscv: Add SOPHGO SOC family Kconfig support
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

On Wed, Sep 20, 2023 at 2:35=E2=80=AFPM Chen Wang <unicornxw@gmail.com> wro=
te:
>
> The first SoC in the SOPHGO series is SG2042, which contains 64 RISC-V
> cores.
>
> Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>  arch/riscv/Kconfig.socs | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 6833d01e2e70..d4df7b5d0f16 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -22,6 +22,11 @@ config SOC_SIFIVE
>         help
>           This enables support for SiFive SoC platform hardware.
>
> +config ARCH_SOPHGO
> +       bool "Sophgo SoCs"
> +       help
> +         This enables support for Sophgo SoC platform hardware.
> +
Reviewed-by: Guo Ren <guoren@kernel.org>

>  config ARCH_STARFIVE
>         def_bool SOC_STARFIVE
>
> --
> 2.25.1
>


--=20
Best Regards
 Guo Ren
