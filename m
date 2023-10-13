Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032DE7C7EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjJMHhp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJMHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:37:43 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C03A83;
        Fri, 13 Oct 2023 00:37:42 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a7ad24b3aaso22323647b3.2;
        Fri, 13 Oct 2023 00:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697182661; x=1697787461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2Mlsv7IV/ok3/Xb+dHDjiLm3yxeKrefXSzK5AqwRkw=;
        b=NTK/pwV2kP8GuoJq+98+DuHpKNpSF3hTlQKWET48GKuuNBfXcbbXDLxIJ9W0M6wrCy
         Nr++RJ1WG1SJxTaeIuyqmhWbEukemDMJqJMI7fo3N1mHaV4HgBt6iDkBN7YD/cM3tBHc
         bDCKiVCwouO7YHA2dMPgTn5ba2lYI+g2XVJK+1ZN1EDwJaozcs/JRDThRUtoRhgt/A4E
         JavP23YIN87+NIoRX1p+Di3Y9UaJsvJgwG67H+/0Z1Nl015d+FYS7d+PUARrrBOOqack
         aJichpboZgJi+JJPHaQsd5orSppgnVbZVo/2k72mxpxhaXm5i65VvTI+JQzNUoMeZKRV
         DKsw==
X-Gm-Message-State: AOJu0YzR35zATPSKTz09LxUGtC3F/MVfvpBE8QVP4bnfjqvojKVKYULg
        PBD5EE19m/8gIzm0bh3rI12X43t7aCqaUA==
X-Google-Smtp-Source: AGHT+IH2nlrZVg7aQ+/L1FFKFxS6UqdEbrErqllJ4zSZB3wZ1KX+js9opUecpwwS9+n5s8obgcxJ6w==
X-Received: by 2002:a0d:c546:0:b0:595:80e4:907d with SMTP id h67-20020a0dc546000000b0059580e4907dmr27733622ywd.32.1697182661646;
        Fri, 13 Oct 2023 00:37:41 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id g2-20020a0df602000000b005a7daa09f43sm517878ywf.125.2023.10.13.00.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 00:37:41 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59b5484fbe6so22526577b3.1;
        Fri, 13 Oct 2023 00:37:41 -0700 (PDT)
X-Received: by 2002:a81:4885:0:b0:59f:61b6:f584 with SMTP id
 v127-20020a814885000000b0059f61b6f584mr27680401ywa.9.1697182660859; Fri, 13
 Oct 2023 00:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231013091831.60a032c2@canb.auug.org.au> <CACRpkdaEVUfFg-O53NBiyWPsjx0VZVMKK7o2ikUMSCy0_AJUGQ@mail.gmail.com>
 <CAMuHMdX3LXZiRRAHSb1FU6nrgtPnyewbUwp7R9Rw2zbxziYz7w@mail.gmail.com> <CACRpkdYNRyL-hywayP97PsLvhEk_Dm4HdnYHHo9N50GXMuxWCg@mail.gmail.com>
In-Reply-To: <CACRpkdYNRyL-hywayP97PsLvhEk_Dm4HdnYHHo9N50GXMuxWCg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Oct 2023 09:37:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSirm9mxjRMEh3uBeo71smOwKfuvmSrq6TauCs664mmQ@mail.gmail.com>
Message-ID: <CAMuHMdUSirm9mxjRMEh3uBeo71smOwKfuvmSrq6TauCs664mmQ@mail.gmail.com>
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

On Fri, Oct 13, 2023 at 9:14 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Oct 13, 2023 at 9:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Oct 13, 2023 at 12:44 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Fri, Oct 13, 2023 at 12:18 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > The following commit is also in Linus Torvalds' tree as a different commit
> > > > (but the same patch):
> > > >
> > > >   73394a1b2194 ("pinctrl: renesas: rzn1: Enable missing PINMUX")
> > > >
> > > > This is commit
> > > >
> > > >   f055ff23c331 ("pinctrl: renesas: rzn1: Enable missing PINMUX")
> > > >
> > > > in Linus' tree.
> > >
> > > I had to fix up the commit message, sorry,
> >
> > The only difference is your added SoB?
>
> No, I'm not that vain...

I don't see any other difference, though:

$ git help diff-commits
'diff-commits' is aliased to '!bash -c "colordiff -up <(git show $1)
<(git show $2) | less -R" #'
$ git diff-commits 73394a1b2194 f055ff23c331
--- /dev/fd/63  2023-10-13 09:30:50.809415961 +0200
+++ /dev/fd/62  2023-10-13 09:30:50.809415961 +0200
@@ -1,4 +1,4 @@
-commit 73394a1b2194694b66f7a0839a219ce0d16b64a3
+commit f055ff23c331f28aa4ace4b72dc56f63b9a726c8
 Author: Ralph Siemsen <ralph.siemsen@linaro.org>
 Date:   Wed Oct 4 16:00:08 2023 -0400

@@ -17,6 +17,7 @@ Date:   Wed Oct 4 16:00:08 2023 -0400
     Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
     Link: https://lore.kernel.org/r/20231004200008.1306798-1-ralph.siemsen@linaro.org
     Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
+    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

 diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
 index 77730dc548ed3c70..c8d519ca53eb7f31 100644

> > > I'll rebuild my branch for -next.
> >
> > I'm afraid that won't help, as the original one (from
> > renesas-pinctrl-fixes-for-v6.6) is also part of
> > renesas-pinctrl-for-v6.7, which I'm gonna send you a PR for later today.
> >
> > I guess we'll just have to live with it?
>
> It's fine if you drop it and rebase from my side, I understand the
> hashes will be different but the content is the same so it is the
> same tested.
>
> But I guess there could be reasons for not to, so then we can
> live with it I guess.

OK, I'll drop it from renesas-pinctrl-for-v6.7. I don't have any other
changes touching the same file.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
