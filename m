Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC70783BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjHVIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjHVIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:41:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D3ACD4;
        Tue, 22 Aug 2023 01:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0454D61063;
        Tue, 22 Aug 2023 08:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44519C433CA;
        Tue, 22 Aug 2023 08:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692693694;
        bh=6uqDbLXsR+BxTTZl03sCQ10dOl32Q0UyJCc+W3QkBgo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tcTMNCaiiW5RRkzHUerroX42Ufj4cLz3KnAiOTvaeL7UtEDdu71nqZ+kRbTx32Z8n
         h5d1voe6HqEDTTBkwboPPlYd2RjR68XpuDC9IzjoK6Vu6kW+k3fvMTgOedITCDv9MG
         ZZlgn7vE7t85cnGkaIExqBen58CMjLab8PumPtDmDeH0IxHvSq1gYFrsgvv6Ulqa73
         u4HskZFwXARwUWqKJFDU1VOSv1VpJgJL4nBSv6DKLfcWrJwVRtyCwBFQHSIOf6XjMl
         RT+ghv8i1IvJqlmmFmaF4+BVMkPkd+nZG55k4pRXUpgPd6tc6wgjn7V1IJNlQe+ogL
         mEUsXvbxaljKA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so66813721fa.1;
        Tue, 22 Aug 2023 01:41:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YwdmCxSbRILyshimDqgPkZ+/GSVPstM3r8Vko9gTV1L0Kx34o3W
        Jmc/A2ZYIPIKXkP1KTWgOLkh7kVZhqfJubIbrLc=
X-Google-Smtp-Source: AGHT+IGv7WdXQUeAKBhMYMzrqj4ZYXxeY61kxBveTkYDN/4pKlWx7k41yrOqx1YrsyTL2A2CItD12Q2XFiFFoWh5VKg=
X-Received: by 2002:a05:6512:3105:b0:4ff:745b:4f1f with SMTP id
 n5-20020a056512310500b004ff745b4f1fmr4989198lfb.30.1692693692201; Tue, 22 Aug
 2023 01:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230822164859.26b0b8f6@canb.auug.org.au> <CAMj1kXGKtpGNYx6hqygya+k_gQaMTiwEZnRGk9rZ=hcbcagKXA@mail.gmail.com>
 <20230822180805.483c10ee@canb.auug.org.au>
In-Reply-To: <20230822180805.483c10ee@canb.auug.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Aug 2023 10:41:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF4eQBYiPBv2asbu+yqcCuYSmw-8_x41u=g4s1NJjb1Xg@mail.gmail.com>
Message-ID: <CAMj1kXF4eQBYiPBv2asbu+yqcCuYSmw-8_x41u=g4s1NJjb1Xg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the efi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 at 10:08, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Ard,
>
> On Tue, 22 Aug 2023 09:32:31 +0200 Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Hello Stephen,
> >
> > On Tue, 22 Aug 2023 at 08:49, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > After merging the efi tree, today's linux-next build (x86_64 allmodconfig)
> > > failed like this:
> > >
> > > In file included from drivers/platform/x86/uv_sysfs.c:14:
> > > arch/x86/include/asm/uv/bios.h:118:22: error: expected ')' before '*' token
> > >   118 |         u64 (__efiapi *function)(enum uv_bios_cmd, ...);
> > >       |                      ^~
> > >       |                      )
> > >
> > > Caused by commit
> > >
> > >   73632c8c865f ("efi/runtime-wrappers: Remove duplicated macro for service returning void")
> > >
> >
> > Thanks for the report.
> >
> > I cannot reproduce this with Debian's GCC 12.2.0 when building the
> > efi/next tree either in isolation, or merged into yesterday's next.
> >
> > Could you please share the compiler version and the .config you used? Thanks.
>
> $ x86_64-linux-gnu-gcc --version
> x86_64-linux-gnu-gcc (Debian 12.3.0-4) 12.3.0
> (this is Debian's cross compiler that is ppcle64 hosted)
>
> and (see above) it is a x86_64 allmodconfig build.
>
> Maybe there is some interaction with something else in today's
> linux-next (just released).

Thanks. I fixed it in the efi/next tree so things should build as
expected the next time around.
