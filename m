Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B64175F7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjGXNNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXNNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:13:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE8DDD;
        Mon, 24 Jul 2023 06:13:17 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso62248631fa.1;
        Mon, 24 Jul 2023 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690204395; x=1690809195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h0XwyMgX4mS7VpluG5Iry9y96d8HKzSPT5Ovi9r5ZEo=;
        b=gerYL6R3egoRyRwQpFz0ssKPtEzv3/KEE2AgHM+pPamlNqoPceJWSB4RaN+KBiEPwm
         zSWXlpzdroM76HgI9/NdPPte0d9HcxOGjC0+eSzbGntSzEO7BoCRteUViE/Q9NokXtkV
         lM9xN7FI3oR82oadkVWgIWwIK7f6S4GByiuuTSpxCHKiwcXDeCU4HmOCKBS/dU4mf7x8
         HSdHCHC3zSTXnTooVs6bUrg5XUElPlzg6woO9zBNO7X9ubKxhvzprQqiuVceyBw2U8Lj
         rH3Kl29sFaKpeBx7wyFshrOcKQpdGLJDWufO8li7YUN2dvEAvsFdShF4DtThVuFyCH9+
         AvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690204395; x=1690809195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0XwyMgX4mS7VpluG5Iry9y96d8HKzSPT5Ovi9r5ZEo=;
        b=VtdFExn+Iv/CEKLdU+9GjD+JJskf1jYRLblIJYYfmWXruk13js1TL17sz0eiwCAPkE
         iz1S+47W3j2yK1dxRDUDhYB65bNoMnGgoZy8ZbsXGZT1bZuX0F/Q8Y0SW6sgfhAFE8PC
         EgbrWr6ragIZ5pDIEzqqkUYiEHEPqYo/iN6w3jRJFAcWRkqrM4t212sWdwXgmLsU3Jam
         X0dQrN2Bwdjadd80rhyh5osOkqIEEQxqiKxxWD2c7PrFtykN33txuxkJtdP8BVTFd3oh
         SxcEFKJxhIfbd+fezCL4VkbcCNJWthrQETWAnLagxGXTOJBxrlo4QhRYlnlYjZDLZF2d
         2RIA==
X-Gm-Message-State: ABy/qLZsOvwyip54zJnYBcwU5OXskvKrtU8pQpzsMOIb20u15c0w0gfX
        RUEcN74leKKIJYTkqPiwgss=
X-Google-Smtp-Source: APBJJlEucSzSmQYiI+ro5xRfR7WnkS0Gvp+fmm1PG5uNirttRhcC3djRkCQ8LMVlf/GKT1dXliR1yw==
X-Received: by 2002:a2e:9f0b:0:b0:2b7:25b2:e37a with SMTP id u11-20020a2e9f0b000000b002b725b2e37amr6031612ljk.44.1690204395118;
        Mon, 24 Jul 2023 06:13:15 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id j26-20020a2e3c1a000000b002b6ee99fff2sm2860293lja.34.2023.07.24.06.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:13:14 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:13:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>, wuyonggang001@208suo.com
Cc:     wuyonggang001@208suo.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: baikal-t1: Using div64_ Ul replaces do_ Div()
 function
Message-ID: <nt6kbounehvfqo4hpfj3wbr7baukuhr22dafvoykgyehs4imsp@pc6bajyo6ugn>
References: <20230612033904.34921-1-zhanglibing@cdjrlc.com>
 <0dc9409b662180ed29cbc281f0f076b7@208suo.com>
 <fcd37e67fba625da304fdaf07e0ab0db@208suo.com>
 <CAMuHMdX0xP5Gugo7uF5Wqk9_ny6-4fOWYRm41KicOo26kC6m+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX0xP5Gugo7uF5Wqk9_ny6-4fOWYRm41KicOo26kC6m+g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert

On Mon, Jul 24, 2023 at 12:04:19PM +0200, Geert Uytterhoeven wrote:
> Hi Yonggang,
> 
> CC Serge

Thanks for Cc-ing me.

> 
> On Wed, Jun 14, 2023 at 8:07 AM <wuyonggang001@208suo.com> wrote:
> > Fix the following coccicheck warning:
> >
> > drivers/clk/baikal-t1/ccu-pll.c:81:1-7: WARNING: do_div() does a
> > 64-by-32 division, please consider using div64_ul instead.
> >
> > Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> 
> Thanks for your patch, which is now commit b93d1331ea266dea
> ("clk: baikal-t1: Using div64_ Ul replaces do_ Div() function")
> in clk/clk-next.
> 
> > b/drivers/clk/baikal-t1/ccu-pll.c
> > index 13ef28001439..d41735c6956a 100644
> > --- a/drivers/clk/baikal-t1/ccu-pll.c
> > +++ b/drivers/clk/baikal-t1/ccu-pll.c
> > @@ -66,7 +66,7 @@ static inline unsigned long
> > ccu_pll_lock_delay_us(unsigned long ref_clk,
> >   {
> >       u64 us = 500ULL * nr * USEC_PER_SEC;
> >

> > -    do_div(us, ref_clk);
> > +    div64_ul(us, ref_clk);
> 
> The above is not equivalent:
>   - do_div() returned the quotient as an output parameter in us,
>   - div64_ul() returns the quotient using the return value.

Indeed, leaving the patch as is will break the driver for sure.
do_div() and div64_ul() aren't equivalent in regard of the return
values. So this update will cause the ccu_pll_lock_delay_us()
returning "500ULL * nr * USEC_PER_SEC" instead of
"(500ULL * nr * USEC_PER_SEC) / ref_clk".

> 
> Have you tested your patch?
> 
> >
> >       return us;
> 
> So this should become:
> 
>     return div64_ul(500ULL * nr * USEC_PER_SEC, ref_clk);

This would be the correct fix. But I would either retain the local
"us" variable here or fixed the
drivers/clk/baikal-t1/ccu-div.c:ccu_div_lock_delay_ns() function too
for the sake of the driver unification. The later is preferable
though.

> 
> >   }
> > @@ -78,9 +78,9 @@ static inline unsigned long ccu_pll_calc_freq(unsigned
> > long ref_clk,
> >   {
> >       u64 tmp = ref_clk;
> >

> > -    do_div(tmp, nr);
> > +    div64_ul(tmp, nr);
> >       tmp *= nf;
> > -    do_div(tmp, od);
> > +    div64_ul(tmp, od);
> >
> >       return tmp;
> 
> Likewise.

Right. This will also break the driver.

> But as ref_clk is unsigned long, there is no need to use div64_ul()
> for the first division, and this can be simplified to:
> 
>     u64 tmp = (u64)(ref_clk / nr) * nf;
>     return div64_ul(tmp, od);

Absolutely right. My intention of using the do_div() anyway was for
the sake of the code unification.

> 
> To avoid loss of precision, it might be better to reverse the order
> of the division and multiplication:
> 

>     u64 tmp = (u64)ref_clk * nf / nr;

Alas exactly this code will cause the compilation error on the 32-bit
platform:
ccu-pll.c:(.text+0x458): undefined reference to `__udivdi3'

That's why I am using the do_div() here. I would have rather used the
div64_ul() instead as this patch suggests, but I haven't known about its
existence up to this moment.

Anyway my intention of dividing before multiplying had twofold
justification. Firstly I didn't want to use the "/" operator and
do_div() macro in the statements used to implement the same formulae.
Since I couldn't use the operator I decided to use the macro only for
the code unification. Secondly the PLL is designed in a way so the
signal is first divided by NR, then multiplied by NF and then divided
by OD. That's why I decided to preserve the same order in the
calculations here. I assumed back then that the NR-divider performs
the integer division in the analog circuitry. I have doubts now that
my assumption was correct since it's analog device and most likely
divides the source signal with no integer rounding-up. So using the
order suggested by you would have likely given a more exact result.

> 
> But doing that requires intimate knowledge about the range of nf to
> avoid overflow, so I leave that to Serge.

nr: 1 - 2^6
nf: 1 - 2^13
ref_clk: normally 25'000'000 Hz.
Using "unsigned long"/u32 multiplication will give the integer
overflow. Meanwhile the u64 arithmetics will be more than enough here.

So to speak the next alteration seems more correct here:
+return div64_ul(div64_ul((u64)ref_clk * nf, nr), od);

What do you think?

Yonggang, several comments:
1. Could you please include the "linux/math64.h" header file to the
driver?
2. Could you please fix the same thing in the ccu-div.c file too?

-Serge(y)

> 
> >   }
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
