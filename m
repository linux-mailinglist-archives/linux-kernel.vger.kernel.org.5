Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAD8789AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 03:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjH0BXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 21:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjH0BXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 21:23:38 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E0C1B3;
        Sat, 26 Aug 2023 18:23:35 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1c504386374so1553240fac.3;
        Sat, 26 Aug 2023 18:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693099415; x=1693704215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UJWYdABUudEik4UApcn9d5OCq8NnpJS1prRVjkwYng=;
        b=YILrZSpuc6tXjA/KHYsuhflzF+WKOnz8QU8X4oG3sPB1G6jmpg4T+P9citxRoQQLrS
         q3JrSlkaAKpFMBuWPBKj2rf2c51iDXM1leXYfcnREUoQjUTi6i0wE/OY/PBQmzmecfuR
         1tbbQkbyEuNgn4A6k9aaA86ThgcTGTKCwcWUKt0O+6l0j43c/VpV86NhMhRy2HyioA/d
         w6BgFrEZEaL5K6lm5hbFkbnsKw44XgYA9ql462ORAQgPXD+M0yrLWAmUAHRNXYMGOCar
         yUB9qmxQmbj/a/k/bbQTWgyoHJi/yGbUZj92f4KWb/5VtrcW6cDx1cpolY5eGqGQdBPb
         CtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693099415; x=1693704215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UJWYdABUudEik4UApcn9d5OCq8NnpJS1prRVjkwYng=;
        b=WG9J9u/o4bWWoupwBipFRbATxwg9jeFfm6m16543FX+jqzgXbqKK5CF7FamKeGxfrN
         xRgefE/gw+3C84Wfts6IyPjlhgYAQV2WNgO2yJ7WbuYFI13YssrAttuM1erMu1fAMFJD
         EYcYAFWm+kiD/mFXtzbSnxHEdQfj3Hbgo0YF6r3u2C9P39tCOXHbclHvyiFSbJg3yiQd
         fQ3SRyadQRtNDMNsJqymDG77mXo5BRDzoLbvxWhPDT+OAajZBRSwi6PxZKAVe8QMgq2K
         ydDucH43g9X0tdOlqUmUnrRpPFLeCBKPgBoQ7e6Mit62FyiMI2SrIGuAdIdzWyeK7YYM
         qKDQ==
X-Gm-Message-State: AOJu0YyKrl8CtLxc2A35kD1aiOqRU9RXu3/SUgCptRLItE7AdcHp6FGk
        5y1EPkkootrLBED9wl6tbtxn8rJyMDVS+vWWiwg=
X-Google-Smtp-Source: AGHT+IHp6Gw67GwbCZWDbOFLnMaGjVW+v2aVpG+5nmMeu0ci2bsbjgYHz/3wd3D5c7iC/6kpTuOR/Kdd5zr4t6SfodQ=
X-Received: by 2002:a05:6870:4709:b0:1b0:43b6:e13b with SMTP id
 b9-20020a056870470900b001b043b6e13bmr8363532oaq.54.1693099415128; Sat, 26 Aug
 2023 18:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230802092647.3000666-1-sergio.paracuellos@gmail.com>
 <CAKwvOd=SvHUPd8+sWtqgxghPEciD5sqPiggZx+OOEqxtJrML6Q@mail.gmail.com>
 <9a22ecee-ebb0-437e-bd2b-99b5c6944855@app.fastmail.com> <CAMhs-H-2g2QF8NjZOknEop_3UFc_R3YYhpEveU2fc-Ks-iM1bA@mail.gmail.com>
 <b0e203e7-3b3c-40ad-8d99-e43415c0d3c5@app.fastmail.com>
In-Reply-To: <b0e203e7-3b3c-40ad-8d99-e43415c0d3c5@app.fastmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 27 Aug 2023 03:23:23 +0200
Message-ID: <CAMhs-H9uWCLEN3z8sfO0hzCbbJy7eNLc7dsD5=RmZmdvcFs9Rw@mail.gmail.com>
Subject: Re: [PATCH] clk: ralink: mtmips: quiet unused variable warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        clang-built-linux <llvm@lists.linux.dev>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Sorry for the late response. I was on a family vacation trip.

On Thu, Aug 3, 2023 at 9:58=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> On Thu, Aug 3, 2023, at 00:35, Sergio Paracuellos wrote:
> > Hi Arnd.
> >
> > El El jue, 3 ago 2023 a las 0:02, Arnd Bergmann <arnd@kernel.org> escri=
bi=C3=B3:
> >> On Wed, Aug 2, 2023, at 23:26, Nick Desaulniers wrote:
> >> > On Wed, Aug 2, 2023 at 2:26=E2=80=AFAM Sergio Paracuellos <sergio.pa=
racuellos@gmail.com> wrote:
> >> >>
> >> >> When CONFIG_OF is disabled then the matching table is not reference=
d and
> >> >> the following warning appears:
> >> >>
> >> >> drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'm=
tmips_of_match' [-Wunused-const-variable]
> >> >> 821 |   static const struct of_device_id mtmips_of_match[] =3D {
> >> >>     |                          ^
> >> >>
> >> >> Silence it declaring 'mtmips_of_match' with '__maybe_unused'.
> >> >>
> >> >> Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for M=
TMIPS SoCs")
> >> >> Reported-by: kernel test robot <lkp@intel.com>
> >> >> Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py=
-lkp@intel.com/
> >> >> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >> >
> >> > I think this is fine; Arnd or Nathan do you have a preference? or th=
oughts here?
> >> >
> >> > If not, thanks for the patch.
> >> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >> >
> >> > (I have a slight preference for wrapping the use in `#ifdef CONFIG_O=
F`
> >> > since with the approach used by this patch, if all users are removed
> >> > we will never get a warning for this var. But it's a weak preference=
;
> >> > it's more important to me that we don't have -Werror promote this
> >> > warning to a build breakage)
> >>
> >> I don't understand why there are two match tables in the same
> >> driver, with almost the same contents. I have not looked very
> >> closely here, but why can't we just drop the mtmips_clk_of_match[]
> >> table (the one without the .data fields) and use the same
> >> table for both? Is this because of the ralink,rt2880-reset entry
> >> that is missing in mtmips_of_match, or is that another bug?
> >
> > ralink,rt2880-reset is for old dts compatibility and only applies to
> > reset driver. The one with data fields apply for clocks and is needed.
>
> Ok, I see. It still looks like the two tables can simply be
> merged by adding the ralink,rt2880-reset entry to mtmips_of_match[],
> which will allow it to be used for mtmips_clk_driver (which doesn't
> use the data) as well as for mtmips_clk_init() (which doesn't
> need get called for ralink,rt2880-reset).

I think I see your point, thank you. I'll do some test with this
approach and will send a new patch properly addressing this.

Thanks,
    Sergio Paracuellos

>
> >> I also see that there is both a platform_driver instance for
> >> late probing and a list of CLK_OF_DECLARE_DRIVER() entries.
> >> Do we need both here?
> >
> > This system controller driver provide clock and reset controllers.
> > Clock cannot be a platform driver since we need to set
> > mips_hpr_frequency at a very early sargento. Reset stuff can be a
> > platform driver so both of them are needed.
>
>      Arnd
