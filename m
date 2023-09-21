Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934137AA4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjIUW0a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 18:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjIUWZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:25:36 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B10A4AA2;
        Thu, 21 Sep 2023 10:58:19 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57b45b7e4a5so651745eaf.1;
        Thu, 21 Sep 2023 10:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319099; x=1695923899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McBssJIFman3vDfY3Lya/lUW6BvCQvI1WsK86xV7B60=;
        b=cLojXCDhgF0GQ6gXXu4UiNJBAXOTmNgVYlO+XwmzjiQatzm1So79YVuEYZs3rbk6sS
         OvNJspuJOdoa7jBV8mA0nUU4ByDA6GIj6uSvV0Lj40U/jzRI5qCfsRDYUGaX3RraXSLe
         WeMEf3OVTp5IitpkL3x6fks+DBXvWzl6LysPYFmEk/IGI1zW63pJlg2urGTydajTdZSH
         todIUjsQivGLZDD1tOQ8a2z6RqnNQYYPYmAojDKAq/KzXxz6Jj0wlmJdIZtLxz9GtORA
         tpiCMgGURjFJxONI0Ccx2c6YPEtbYFLHGymkZ+OuOBkc5fMYJooK7n4NBEOoPxyZefFj
         9dsQ==
X-Gm-Message-State: AOJu0Yz8zyY6+wzYtoXjkXCF4070snmD1s3MDYJJaD2PnTVvniX2rtIj
        7TPeFmm4WqJ/3hcRKKyGCEAYVgqZzkMOAKTY
X-Google-Smtp-Source: AGHT+IF8rNCnD/Yl0uSen1jk3GJDDkgY/UU4H3ZmOfpWlJNr4jl9B78ZMoZHarWcou2uRFKIORt2bA==
X-Received: by 2002:a25:824e:0:b0:d80:1bbf:fabf with SMTP id d14-20020a25824e000000b00d801bbffabfmr4723954ybn.2.1695286361528;
        Thu, 21 Sep 2023 01:52:41 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id a125-20020a254d83000000b00d7bb3c4893fsm249790ybb.8.2023.09.21.01.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 01:52:41 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d81dd7d76e0so858065276.1;
        Thu, 21 Sep 2023 01:52:41 -0700 (PDT)
X-Received: by 2002:a25:c54c:0:b0:d06:f0ab:e17b with SMTP id
 v73-20020a25c54c000000b00d06f0abe17bmr5004172ybe.55.1695286361107; Thu, 21
 Sep 2023 01:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230802184849.1019466-1-arnd@kernel.org> <20230802184849.1019466-4-arnd@kernel.org>
 <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com>
 <5dad2d86-78ea-4a39-8ee1-98e3eb134d36@app.fastmail.com> <CAMuHMdVYcvPL+JpPw9sA48=615cdfwa8d0LP-bVp0NWqbQ+JOw@mail.gmail.com>
 <190041c8-2d99-4bc3-adc3-6fbe902c1265@app.fastmail.com> <CAMuHMdXyLHitBWOMp74cqtJbSs6q_4sPOEee+x72tE-E2G-KWg@mail.gmail.com>
 <d2f5cdc1-4bff-4f1d-a7b2-38eee6a6a86d@app.fastmail.com> <f61e1f218ee4d5a87121c0e5ee0d8694364ea2dd.camel@physik.fu-berlin.de>
In-Reply-To: <f61e1f218ee4d5a87121c0e5ee0d8694364ea2dd.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Sep 2023 10:52:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXFSvyTGvYrc2af_Bba9hHNQ-taufOMXRPrKJGNiCP8mw@mail.gmail.com>
Message-ID: <CAMuHMdXFSvyTGvYrc2af_Bba9hHNQ-taufOMXRPrKJGNiCP8mw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, Sep 21, 2023 at 9:45 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Fri, 2023-09-15 at 17:49 +0200, Arnd Bergmann wrote:
> > On Fri, Sep 15, 2023, at 17:41, Geert Uytterhoeven wrote:
> > > On Wed, Sep 13, 2023 at 4:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Wed, Sep 13, 2023, at 16:13, Geert Uytterhoeven wrote:
> > > >
> > > > Right, it looks like the GENERIC_IOMAP part if gone from that
> > > > series, and I also see that the PCI host bridge does not actually
> > >
> > > No, 02/30 still enables it.
> >
> > Ok.
> >
> > > > map the port I/O window. That's usually fine because very few
> > > > drivers actually need it, and it also means that there should be
> > > > no need for GENERIC_IOMAP or the simpler alternative.
> > > >
> > > > The first version probably only did it accidentally, which is a
> > > > common mistake, and I think the ones for hexagon, m68k, and
> > > > mips can probably be removed as well with some simplifiations.
> > >
> > > When not selecting GENERIC_IOMAP in v2, the build fails with:
> > >
> > > sh4-linux-gnu-ld: lib/devres.o: in function `pcim_iomap_release':
> > > devres.c:(.text+0x234): undefined reference to `pci_iounmap'
> >
> > Odd, that one is provided based on CONFIG_GENERIC_PCI_IOMAP
> > and should be provided by common code, despite the similar
> > naming this is unrelated to CONFIG_GENERIC_IOMAP.
>
> So, what would be the suggestion now to move forward? Shall I include this
> series for 6.7 or better wait until after Yoshinori's series to convert
> to device tree has been merged?

I think including Arnd's cleanups (that is, his v2) in v6.7 is fine.
Sato-san's series needs more work, and is easy to fix for Arnd's cleanup
(just provide sh_io_port_base unconditionally).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
