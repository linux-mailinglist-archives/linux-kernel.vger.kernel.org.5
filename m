Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452967A22AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjIOPmH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 11:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbjIOPlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:41:35 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE38F3;
        Fri, 15 Sep 2023 08:41:26 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59bd2e19c95so25278907b3.0;
        Fri, 15 Sep 2023 08:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694792485; x=1695397285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLPlFT1v+rGGzpoTjRtF/iJwCpqgzzZDzr6GcDuhBuE=;
        b=iFG1L0eUhNlmX414AnRdkvGOUv13esixwsZSwFL13Oyt/UoOOcgpCwR5VaicYCCbhd
         mbWSS+3GVHeUxPqfmuZDdAyQ9eNVMJIcpkj5oVgt43/OpsAYVmk4Wzg0jWnyfBisB3Oa
         7PjaamyEgSBjGefydpWzVG0WkahxFeMHCRDLrIuTUB9EB59EP/kDxQRPW5vb6PgqiXP6
         VCDebnDxMvuy4dXLKVNzR3hq6B4AY18f3tkrW5p7qHwbbuYC0VpVa6wOmktLqLwUeqaZ
         TlKexJQaCpriiTWQM4WEn+typ5tiQdob3KHqULdXsowTZhvSSQhVavqL7t13js2zVn91
         NMHg==
X-Gm-Message-State: AOJu0Yz6tvuPUvBxOhTKYEnXx9y0YcSyfG1OgG7XFrLBLboQilqL3/py
        vv0w8jKLzOSW7woqc+hNk4Y+Jn2JIwVDyg==
X-Google-Smtp-Source: AGHT+IFT1W/0g1MunW99dAmGIQBpdJJKBYwOsNqeKIbVo/kEs1haWEGCRvfie29NaslqXv9R0nYlNg==
X-Received: by 2002:a81:4f81:0:b0:59b:eedc:43ce with SMTP id d123-20020a814f81000000b0059beedc43cemr2250575ywb.4.1694792485227;
        Fri, 15 Sep 2023 08:41:25 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id w135-20020a81498d000000b00577139f85dfsm910106ywa.22.2023.09.15.08.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:41:25 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ccc462deca6so2134901276.0;
        Fri, 15 Sep 2023 08:41:22 -0700 (PDT)
X-Received: by 2002:a25:ab4f:0:b0:d81:aae4:f774 with SMTP id
 u73-20020a25ab4f000000b00d81aae4f774mr1911127ybi.25.1694792482630; Fri, 15
 Sep 2023 08:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230802184849.1019466-1-arnd@kernel.org> <20230802184849.1019466-4-arnd@kernel.org>
 <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com>
 <5dad2d86-78ea-4a39-8ee1-98e3eb134d36@app.fastmail.com> <CAMuHMdVYcvPL+JpPw9sA48=615cdfwa8d0LP-bVp0NWqbQ+JOw@mail.gmail.com>
 <190041c8-2d99-4bc3-adc3-6fbe902c1265@app.fastmail.com>
In-Reply-To: <190041c8-2d99-4bc3-adc3-6fbe902c1265@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 17:41:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXyLHitBWOMp74cqtJbSs6q_4sPOEee+x72tE-E2G-KWg@mail.gmail.com>
Message-ID: <CAMuHMdXyLHitBWOMp74cqtJbSs6q_4sPOEee+x72tE-E2G-KWg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Sep 13, 2023 at 4:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Sep 13, 2023, at 16:13, Geert Uytterhoeven wrote:
> > On Wed, Sep 13, 2023 at 4:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Wed, Sep 13, 2023, at 14:32, Geert Uytterhoeven wrote:
> >> > On Wed, Aug 2, 2023 at 8:49 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >> Do you have a link to that series? I don't understand why you'd
> >> want to enable GENERIC_IOMAP on sh, given that its PIO accesses
> >> are always memory mapped in the end.
> >
> > "[RESEND RFC PATCH 00/12] DeviceTree support for SH7751 based boards."
> > https://lore.kernel.org/linux-sh/cover.1693444193.git.ysato@users.sourceforge.jp/
>
> Ok, thanks.
>
> > In the meantime, there is a v2, which I wasn't aware of when I wrote
> > my previous email, so perhaps my comment is no longer valid.
> > "[RFC PATCH v2 00/30] Device Tree support for SH7751 based board"
> > https://lore.kernel.org/linux-sh/cover.1694596125.git.ysato@users.sourceforge.jp
>
> Right, it looks like the GENERIC_IOMAP part if gone from that
> series, and I also see that the PCI host bridge does not actually

No, 02/30 still enables it.

> map the port I/O window. That's usually fine because very few
> drivers actually need it, and it also means that there should be
> no need for GENERIC_IOMAP or the simpler alternative.
>
> The first version probably only did it accidentally, which is a
> common mistake, and I think the ones for hexagon, m68k, and
> mips can probably be removed as well with some simplifiations.

When not selecting GENERIC_IOMAP in v2, the build fails with:

sh4-linux-gnu-ld: lib/devres.o: in function `pcim_iomap_release':
devres.c:(.text+0x234): undefined reference to `pci_iounmap'
sh4-linux-gnu-ld: lib/devres.o: in function `pcim_iounmap':
devres.c:(.text+0x278): undefined reference to `pci_iounmap'
sh4-linux-gnu-ld: drivers/pci/quirks.o: in function `disable_igfx_irq':
quirks.c:(.text+0x1738): undefined reference to `pci_iounmap'
sh4-linux-gnu-ld: drivers/pci/quirks.o: in function
`quirk_switchtec_ntb_dma_alias':
quirks.c:(.text+0x1a04): undefined reference to `pci_iounmap'
sh4-linux-gnu-ld: drivers/pci/quirks.o: in function `reset_hinic_vf_dev':
quirks.c:(.text+0x2260): undefined reference to `pci_iounmap'

So I'm back to building the part of arch/sh/kernel/ioport.c
that provides sh_io_port_base...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
