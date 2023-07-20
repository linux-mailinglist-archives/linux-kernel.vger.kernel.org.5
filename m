Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9F375A42B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGTB4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGTB4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:56:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106D11FF1;
        Wed, 19 Jul 2023 18:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A29B96188D;
        Thu, 20 Jul 2023 01:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C85CC433CC;
        Thu, 20 Jul 2023 01:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689818166;
        bh=9D9pujAKUz8k842CA8as0OrHJ41UWIIq1tXLMWMGxqw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oigbKhG88zFTqlsGf9VwOaoKSwshXbuldiU+bveGtGBLCxLg8VeR5sRYmUkUNdmcU
         S+l/Wg6zzj2hq6A7BeAtMGqW9x4F72l6QPdcawpaYqUIqXnEFI42WESQc8HjshNbgX
         32ZYkW2RAnFZ+lhW/tFpnwIsAouTaJb4q/RO6mtH8i3hEdwz31PutTumL4I2gUGPKS
         F/uFtgfFvP3+QS1DPoiHAekz4eR74YVVD9JD1QZ7VDkMt6gRPsTEHyHqqRelpVE4ZA
         1ynwW/D/0PYCuj9hGF3DZ/5ZbpO70V7yDJ/nBzfyZRdoBDcYAT8Gjo+QkPjYsGB9qI
         PVSo+2Q+U0K6g==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-314319c0d3eso251680f8f.0;
        Wed, 19 Jul 2023 18:56:05 -0700 (PDT)
X-Gm-Message-State: ABy/qLYXJg56hjsCm0Bb+yVT6VvftNhp5FBs+ePuRWX42CXqBTia7zty
        a4Jh8+jxpGDr97M9GeYt+lUzhRXMMevVozUH5vo=
X-Google-Smtp-Source: APBJJlGP7nNOlXbv8EnnAuXK71LQH8eBvXzJLaPtZ3prvMZlGxg0bHCtwEfb8pji9JkDAfzIcTk/ss2wOspoD0W7cgk=
X-Received: by 2002:adf:f8d0:0:b0:313:f45f:74a1 with SMTP id
 f16-20020adff8d0000000b00313f45f74a1mr1105625wrq.51.1689818164269; Wed, 19
 Jul 2023 18:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2307180025120.62448@angie.orcam.me.uk>
 <CAAhV-H4ewzWuZRe0RX+j2x2R_fROVExHuogWNaWBmFA=Tgb=Og@mail.gmail.com> <alpine.DEB.2.21.2307191621450.58367@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2307191621450.58367@angie.orcam.me.uk>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 20 Jul 2023 09:55:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7K2qM35GuGV+B2p=N_f30i98KazvwVNCuvvG9fYfrghw@mail.gmail.com>
Message-ID: <CAAhV-H7K2qM35GuGV+B2p=N_f30i98KazvwVNCuvvG9fYfrghw@mail.gmail.com>
Subject: Re: [PATCH 0/3] MIPS: Fix build issues from the introduction of `need-compiler'
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jan-Benedict Glaw <jbglaw@lug-owl.de>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Maciej,

On Wed, Jul 19, 2023 at 11:39=E2=80=AFPM Maciej W. Rozycki <macro@orcam.me.=
uk> wrote:
>
> On Tue, 18 Jul 2023, Huacai Chen wrote:
>
> > Even if patch-2 resolves the problem, I don't think patch-3 is
> > necessary because the original patch makes code simpler and more
> > compact.
>
>  Please don't top-post on a public mailing list.
>
>  If you're referring to this part:
>
> +ifdef CONFIG_CPU_LOONGSON64
> +cflags-$(CONFIG_CPU_LOONGSON64)        +=3D -Wa,--trap
> +cflags-$(CONFIG_CC_IS_GCC) +=3D -march=3Dloongson3a
> +cflags-$(CONFIG_CC_IS_CLANG) +=3D -march=3Dmips64r2
> +endif
>
> then it can be done with a separate clean-up.  Otherwise it'll have been
> lost in the noise.
>
>  Firstly:
>
> cflags-$(CONFIG_CPU_LOONGSON64) +=3D -Wa,--trap
>
> doesn't have to be wrapped in `ifdef CONFIG_CPU_LOONGSON64'.
>
>  Secondly:
>
> cflags-$(CONFIG_CC_IS_GCC) +=3D -march=3Dloongson3a
> cflags-$(CONFIG_CC_IS_CLANG) +=3D -march=3Dmips64r2
>
> document compiler peculiarities.  Does Clang support, or intend to,
> `-march=3Dloongson3a'?  If so, what version can we expect this stuff in?
> GCC has had it since 4.6 or Y2010, which is pretty long ago.
GCC support loongson3a/mips64r2, Clang only support mips64r2. If we use
$(call cc-option,-march=3Dloongson3a,-march=3Dmips64r2)
both GCC and Clang can work and we don't need to care about the compiler.

Huacai

>
>  Last but not least there are formatting anomalies there, which may have
> to be dealt with in a separate change.
>
>   Maciej
