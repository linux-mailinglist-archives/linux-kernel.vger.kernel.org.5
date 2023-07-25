Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0AB761DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjGYP7C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 11:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGYP7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:59:01 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273AC1BD5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:59:00 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5841be7d15eso14109997b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690300739; x=1690905539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFR09uXcv/Vcvx11NF1Gsv9VJ3Ak8y5Uv+mDsENcftc=;
        b=ZcNPb8IX55PQAQiOtfy+DKfXG2aPFhDpbYfoV2bUQ2KUsH6nF0NxVMsloK9XfdGMV7
         5DzB9n8i1kAIjHpouE2s8BDlG3IASj887mW9b2vnHhxXbZr42YmP49oyBXxkVg8z30nN
         nhMf/S01h36BvOmuUYNwl5D/sB5XhL1+vaKjZwk0Bs2PmZ55ZrLhu4Jlg1mqlcYcnPI2
         YY5Iz34jZf4NWW0paQz1TJmx4El5rV6fbDAIm8lU1DtdkPHN3Bb3k/6VFl8renoR8EV6
         +0wV6w9lBdmbff/4Hksa4qtv13ZdtPl9AlUWTWs9BR+ION25RKYj7bOlkoQs+tTMPGDB
         Q08Q==
X-Gm-Message-State: ABy/qLYtYeakC0tMXnwPr/5qhw+FQwR7VOt8aL0BFJNATxTFHOzCt6N4
        SAIZNR09frZHQ0VlTPJVcDSiCNJjMTcztw==
X-Google-Smtp-Source: APBJJlFxOzCI7tmmovlBzgf/XiXX5CFifCBMLyY9Q6dOQZi2hz6Szasz2CsxHrU+ruA1ll6ZXH6tVg==
X-Received: by 2002:a25:c742:0:b0:d0d:d99d:1b8b with SMTP id w63-20020a25c742000000b00d0dd99d1b8bmr7343025ybe.39.1690300738997;
        Tue, 25 Jul 2023 08:58:58 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id y2-20020a259282000000b00bcd91bb300esm2918733ybl.54.2023.07.25.08.58.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 08:58:58 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d16889b3e93so1271513276.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:58:58 -0700 (PDT)
X-Received: by 2002:a5b:891:0:b0:d1b:da26:6364 with SMTP id
 e17-20020a5b0891000000b00d1bda266364mr275703ybq.21.1690300738263; Tue, 25 Jul
 2023 08:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230722180925.1408885-1-hugo@hugovil.com> <CAMuHMdVTDrTowx2-MgYaaNASKLZw=ra5z7pL5WtemDgZ3HS5sQ@mail.gmail.com>
 <20230725111354.160f32cfba0b53923ac2aae6@hugovil.com> <CAMuHMdXe7MWpOjeUXjSsdOx0LXmzYCbvDCtt5yEup+1iGe4O=w@mail.gmail.com>
 <ZL/sDSDYXWFDGbcX@1wt.eu>
In-Reply-To: <ZL/sDSDYXWFDGbcX@1wt.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 17:58:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW0-FcDo-S_DGq+AkWkhB66n_VTow5v2riw8fwmknjddQ@mail.gmail.com>
Message-ID: <CAMuHMdW0-FcDo-S_DGq+AkWkhB66n_VTow5v2riw8fwmknjddQ@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: hd44780: move cursor home after clear
 display command
To:     Willy Tarreau <w@1wt.eu>
Cc:     Hugo Villeneuve <hugo@hugovil.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Tue, Jul 25, 2023 at 5:36 PM Willy Tarreau <w@1wt.eu> wrote:
> On Tue, Jul 25, 2023 at 05:21:36PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Jul 25, 2023 at 5:13 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > On Mon, 24 Jul 2023 18:08:00 +0200
> > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Sat, Jul 22, 2023 at 8:18 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > >
> > > > > The DISPLAY_CLEAR command on the NewHaven NHD-0220DZW-AG5 display
> > > > > does NOT change the DDRAM address to 00h (home position) like the
> > > > > standard Hitachi HD44780 controller. As a consequence, the starting
> > > > > position of the initial string LCD_INIT_TEXT is not guaranteed to be
> > > > > at 0,0 depending on where the cursor was before the DISPLAY_CLEAR
> > > > > command.
> > > > >
> > > > > Extract of DISPLAY_CLEAR command from datasheets of:
> > > > >
> > > > >     Hitachi HD44780:
> > > > >         ... It then sets DDRAM address 0 into the address counter...
> > > > >
> > > > >     NewHaven NHD-0220DZW-AG5 datasheet:
> > > > >         ... This instruction does not change the DDRAM Address
> > > > >
> > > > > Move the cursor home after sending DISPLAY_CLEAR command to support
> > > > > non-standard LCDs.
> > > > >
> > > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- a/drivers/auxdisplay/hd44780_common.c
> > > > > +++ b/drivers/auxdisplay/hd44780_common.c
> > > > > @@ -82,7 +82,15 @@ int hd44780_common_clear_display(struct charlcd *lcd)
> > > > >         hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
> > > > >         /* datasheet says to wait 1,64 milliseconds */
> > > > >         long_sleep(2);
> > > > > -       return 0;
> > > > > +
> > > > > +       /*
> > > > > +        * The Hitachi HD44780 controller (and compatible ones) reset the DDRAM
> > > > > +        * address when executing the DISPLAY_CLEAR command, thus the
> > > > > +        * following call is not required. However, other controllers do not
> > > > > +        * (e.g. NewHaven NHD-0220DZW-AG5), thus move the cursor to home
> > > > > +        * unconditionally to support both.
> > > > > +        */
> > > > > +       return hd44780_common_home(lcd);
> > > >
> > > > Sorry, I haven't tested your patch yet, as my HD44780 display is
> > > > currently not connected to any system.
> > > >
> > > > Your patch LGTM, so
> > > > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > >
> > > > Note that hd44780_common_home() calls hd44780_common_gotoxy().
> > > > According to the documentation, both HD44780U and NHD-0220DZW-AG5
> > > > support the Return Home command (0x02), so that could be a good
> > > > alternative.
> > >
> > > Hi Geert,
> > > If this is desired, I think maybe it would be best to do it in a
> > > separate patch. Maybe there is a good reason why hd44780_common_home()
> >
> > Sure, a separate patch would be fine.
> >
> > > calls hd44780_common_gotoxy() instead of using Return Home command?
> >
> > Looks like the Linux driver has always used goto 0/0 instead of Return Home.
> > Perhaps not all displays support that command? I know mine does.
> >
> > Willy: do you remember?
>
> Indeed, this vaguely reminds me something. I've been using an old 2x40
> salvaged from a fax in the late 80s, originally all reverse-engineered
> under DOS. When I implemented Linux support for it 10 years later, I
> ported my working code there and we started to adapt to other said
> compatible models and fixed certain things that were specific to my
> model or that were incorrect in my initial analysis. But I remember that
> we broke several times the support for mine while trying to match the
> available specs more closely.
>
> Several times we had something related to the initialization, where it
> wouldn't always initialize well. But maybe that's because we were calling
> what became hd44780_common_home() while during the init code it's possible
> that we need at least one call to gotoxy(), I don't really know.
>
> One thing I'm having in mind is that this LCD supported horizontal
> scrolling to show the off-screen columns. I'm wondering if the gotoxy()
> and home() did the same thing regarding this. Maybe gotoxy() scrolled
> back to 0,0 while home() just moved the cursor to the visible home
> without scrolling back, in which case it could make a difference.

Indeed, at least according to the real HD44780 documentation,
Return Home also resets the scrolling.

> I would suggest that we just stick to the specs and see if anyone reports
> any trouble. There are so many compatible devices nowadays that possibly
> implement only a subset of the original controller that we should really
> stick to what is clearly understood by everyone and not rely on some old
> conclusions about vague observations made by me 25 years ago!

OK. Given this patch is also a workaround for an incomplete
implementation, let's keep hd44780_common_home() as-is.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
