Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E284789CF4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjH0KT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjH0KS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06848C7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 03:18:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9005C62B7C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 10:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03043C433CD
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693131534;
        bh=PFIO5vLBBD+8A0zyM0b7mUY3zex5RZW+Gl+CUcxvcG0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NU+ZOvWVDtseXndW8WpjhAvTGlIHOz0fX6PK9NfX1OxndDj7gDAz8/1gWljOgBGAF
         CQlSWJdWjno4h4oxVKqTAJ4frUPcJu7ojbJlhZkiS0J7bLElqg5CQLfg1t0NrgkMLd
         a+Wkm9xcKFPfAMW+5ztwc5ozK0C+0xtdbngO1LI4zD9ltvfbzFscgdlhWsRNwPFzpH
         cwsoIi2zYeV5GoalNhtGVwNy3Oq7W5BXcEjVsLRPra869LWn+iWbPd//VnpeBE5ZRp
         /CRVArYGaNEUx9mNP9AMG4v/mzfiAh+wtQjdnnZDqtiWdIc8L2b1KRBENBqaIAA3Oq
         htiRurm8BnLYQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5008faf4456so3530783e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 03:18:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YxhA5Y9mQuKapC/ZTNHLHUEECL/nzxbB20J/F53b47EX5J9uEsT
        PqQQjeYOoan0AopwurJ/pNqthzW/1cTmD5yzOg8=
X-Google-Smtp-Source: AGHT+IFv97vcQvxow4dQrpUTObNLTldjJHYJlxW3bULXJEHlJN/vR2IHG3vY43IgqTE36N1ohJXoUXiJFaD1GrgcxUE=
X-Received: by 2002:ac2:5f41:0:b0:4f8:72fd:ed95 with SMTP id
 1-20020ac25f41000000b004f872fded95mr13011795lfz.22.1693131531948; Sun, 27 Aug
 2023 03:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230827090813.1353-1-jszhang@kernel.org> <20230827090813.1353-3-jszhang@kernel.org>
In-Reply-To: <20230827090813.1353-3-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 27 Aug 2023 06:18:40 -0400
X-Gmail-Original-Message-ID: <CAJF2gTS1P-1PhWM6qLowbAPm8N0iPyq+88+2=SunCdAY07fe1g@mail.gmail.com>
Message-ID: <CAJF2gTS1P-1PhWM6qLowbAPm8N0iPyq+88+2=SunCdAY07fe1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: errata: prefix T-Head mnemonics with th.
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
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

On Sun, Aug 27, 2023 at 5:20=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> From: Icenowy Zheng <uwu@icenowy.me>
>
> T-Head now maintains some specification for their extended instructions
> at [1], in which all instructions are prefixed "th.".
>
> Follow this practice in the kernel comments.
>
> Link: https://github.com/T-head-Semi/thead-extension-spec [1]
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  arch/riscv/include/asm/errata_list.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index feab334dd832..98ecab053dd2 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -90,25 +90,25 @@ asm volatile(ALTERNATIVE(                            =
               \
>  #endif
>
>  /*
> - * dcache.ipa rs1 (invalidate, physical address)
> + * th.dcache.ipa rs1 (invalidate, physical address)
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>   *   0000001    01010      rs1       000      00000  0001011
> - * dache.iva rs1 (invalida, virtual address)
> + * th.dache.iva rs1 (invalida, virtual address)
>   *   0000001    00110      rs1       000      00000  0001011
>   *
> - * dcache.cpa rs1 (clean, physical address)
> + * th.dcache.cpa rs1 (clean, physical address)
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>   *   0000001    01001      rs1       000      00000  0001011
> - * dcache.cva rs1 (clean, virtual address)
> + * th.dcache.cva rs1 (clean, virtual address)
>   *   0000001    00101      rs1       000      00000  0001011
>   *
> - * dcache.cipa rs1 (clean then invalidate, physical address)
> + * th.dcache.cipa rs1 (clean then invalidate, physical address)
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>   *   0000001    01011      rs1       000      00000  0001011
> - * dcache.civa rs1 (... virtual address)
> + * th.dcache.civa rs1 (... virtual address)
>   *   0000001    00111      rs1       000      00000  0001011
>   *
> - * sync.s (make sure all cache operations finished)
> + * th.sync.s (make sure all cache operations finished)
Reviewed-by: Guo Ren <guoren@kernel.org>

>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>   *   0000000    11001     00000      000      00000  0001011
>   */
> --
> 2.40.1
>


--
Best Regards
 Guo Ren
