Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F337C7E65
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjJMHKf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 03:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjJMHKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:10:31 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C081D91;
        Fri, 13 Oct 2023 00:10:25 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d9ac45092e7so1695938276.2;
        Fri, 13 Oct 2023 00:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697181025; x=1697785825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IECtGtWqm2geyWEIJWEaKKW27eGFZt3c1gYt5Pcu7+g=;
        b=hj4wqEW9UyKIY/eZuEzzCtZFp2CO9bGM8SHg2bFSCUOXAn8WjrbWizXySANe0PXMEs
         wtasg15GSAAGEwNSj3ShCBsdqHqdOUZDhAMOE2a+cn3LPNiAQePsMme6rkhBoNQFnwHF
         Fqm0XbYjbFC2wmaZaOuagUOTWOvNBKGRLS4nHhZnn2v6GzJDiJdbYcjMxuzY5ynGIkp1
         4xVyWJecPt5+qgCpi7UelTromrMD3O8HyfjK4jAYZFAcvDUbH0VGQhPoVLPfPFnMeyFv
         CG1hIxDh+93I7t26khOMmMEV8R/Zh/XdNvHS5ethtAxduBeICWMTW0hawCAY2TxL+zng
         JBfw==
X-Gm-Message-State: AOJu0YzC2rxxuWwFPX/SsG4Da7ESX1jOOO88yQ66SkwlBtZIanjtg1as
        5owELifFFHPrr5E3OiYsb9CkcVEMVMDh0Q==
X-Google-Smtp-Source: AGHT+IGgvOA+dW4mOb57bwV0iOmPb7ViZlSQF4dIcl/lGRK8VWWVqEjDHMpYPObc4Rq79QEOkwAaCw==
X-Received: by 2002:a5b:143:0:b0:d81:65a9:ac6d with SMTP id c3-20020a5b0143000000b00d8165a9ac6dmr26081406ybp.37.1697181024769;
        Fri, 13 Oct 2023 00:10:24 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id x22-20020a25ac96000000b00d7e96c6eaf5sm342599ybi.46.2023.10.13.00.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 00:10:24 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a7c93507d5so20897447b3.2;
        Fri, 13 Oct 2023 00:10:24 -0700 (PDT)
X-Received: by 2002:a81:72c5:0:b0:59f:4bc3:3e9 with SMTP id
 n188-20020a8172c5000000b0059f4bc303e9mr26137098ywc.46.1697181024276; Fri, 13
 Oct 2023 00:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231013091831.60a032c2@canb.auug.org.au> <CACRpkdaEVUfFg-O53NBiyWPsjx0VZVMKK7o2ikUMSCy0_AJUGQ@mail.gmail.com>
In-Reply-To: <CACRpkdaEVUfFg-O53NBiyWPsjx0VZVMKK7o2ikUMSCy0_AJUGQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Oct 2023 09:10:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX3LXZiRRAHSb1FU6nrgtPnyewbUwp7R9Rw2zbxziYz7w@mail.gmail.com>
Message-ID: <CAMuHMdX3LXZiRRAHSb1FU6nrgtPnyewbUwp7R9Rw2zbxziYz7w@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the pinctrl tree
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

Hi Linus,

On Fri, Oct 13, 2023 at 12:44 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Oct 13, 2023 at 12:18 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > The following commit is also in Linus Torvalds' tree as a different commit
> > (but the same patch):
> >
> >   73394a1b2194 ("pinctrl: renesas: rzn1: Enable missing PINMUX")
> >
> > This is commit
> >
> >   f055ff23c331 ("pinctrl: renesas: rzn1: Enable missing PINMUX")
> >
> > in Linus' tree.
>
> I had to fix up the commit message, sorry,

The only difference is your added SoB?

> I'll rebuild my branch for -next.

I'm afraid that won't help, as the original one (from
renesas-pinctrl-fixes-for-v6.6) is also part of
renesas-pinctrl-for-v6.7, which I'm gonna send you a PR for later today.

I guess we'll just have to live with it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
