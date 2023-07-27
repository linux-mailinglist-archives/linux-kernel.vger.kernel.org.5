Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D027653E6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjG0M3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjG0M3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:29:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641D419B;
        Thu, 27 Jul 2023 05:28:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so1490131e87.2;
        Thu, 27 Jul 2023 05:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690460931; x=1691065731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QicXffWXscfgWhv0wb3ebSf1Uk8ERzfc9bWF4vPDeBQ=;
        b=nWVAjPy6GwLcObHrSsBfmcry2p/jRNEVhwYZal07Zn4taKsmuisO2dCX9avM9t/t5L
         ibWyBSBMgnuAzJHyOD/o4pBbPC59pljroAhqBs8EAAkn+Mdie8UuVlSLbm1lZrPGwZwq
         tW0G32h8Ejst7cEVm7TYvucMteewOEOADSVlfFKMrdllOai2rGUo6xoNKZmF1TBgPdG3
         /VYFXn0No1ofpf/MbRu5WNh3uAD7sihI+u5taIqtmQv33BJq8p572HjYUuEVAO8LqPgR
         yxDFXNw7vFHGoLZ7zI4Wsv9X06E+zoc6RcyUxdWzOXgFymzLlfsAIsDepeWCM0RARIsX
         Xo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460931; x=1691065731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QicXffWXscfgWhv0wb3ebSf1Uk8ERzfc9bWF4vPDeBQ=;
        b=WBa91XNOtzv9TnGerfq0pJgONfqoepYjCjdcus8ISLNErlJU8EiKZR973D9yqfq3YP
         yi2qg8EZsOM9S/IvxjxAbGn8SDpZDJJf63gYJk18XybF4/DSVulFSDBPLfLDOp66BaqX
         l86lG2HtPzR+4QTZOIaTN/mrWq0mYNNvnPjcLLmGZZVpe6gdm3pal38kVNiARat9DNQr
         LMJ8Sqrutg8acGS1bCB5GhcjjXFHidlYYH4DSblKl9L3LafcEX8amzePt/WXOrG+GNg+
         uf3GIoWb3JCf+B6tyAy0Ll7D7M86gp2ih4urvJExltSdHCBvrKm2V6Vt2SFK3FjugqEy
         7weA==
X-Gm-Message-State: ABy/qLZWm4by6EfJs23AyRmmlyL5zpq2AIKEYxuAU4BPUaMgzZ36Zd9L
        S03vv18GZmxhTaaYsuBYIFWapAY7U6k=
X-Google-Smtp-Source: APBJJlEwAfMbK7LByxz28+r5fm2o2zVJfTBsjNMM0GRF6lbIsUAGmNqBHQbtJClRf0GxW53OjPTs5g==
X-Received: by 2002:a05:6512:2fa:b0:4f8:554f:36aa with SMTP id m26-20020a05651202fa00b004f8554f36aamr1365190lfq.29.1690460930353;
        Thu, 27 Jul 2023 05:28:50 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id d28-20020ac2545c000000b004fb86662871sm283013lfn.233.2023.07.27.05.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:28:49 -0700 (PDT)
Date:   Thu, 27 Jul 2023 15:28:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     wuyonggang001@208suo.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: baikal-t1: Using div64_ Ul replaces do_ Div()
 function
Message-ID: <vnps4c6o6nsvazyggdqhhqedwsf7vrucc2kpiwpuozi7e2e7tc@celmt367ov73>
References: <20230612033904.34921-1-zhanglibing@cdjrlc.com>
 <0dc9409b662180ed29cbc281f0f076b7@208suo.com>
 <fcd37e67fba625da304fdaf07e0ab0db@208suo.com>
 <CAMuHMdX0xP5Gugo7uF5Wqk9_ny6-4fOWYRm41KicOo26kC6m+g@mail.gmail.com>
 <nt6kbounehvfqo4hpfj3wbr7baukuhr22dafvoykgyehs4imsp@pc6bajyo6ugn>
 <CAMuHMdUHDK9CCJPoMgLQBrXjk9VWszYF17dUU=9JtQ8XX=QAPA@mail.gmail.com>
 <2xp54apmm6o5np34obv5muus5d2lpoo7fn6ozuzzj6p4f2whot@c3pji7twevci>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2xp54apmm6o5np34obv5muus5d2lpoo7fn6ozuzzj6p4f2whot@c3pji7twevci>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert, Stephen

On Mon, Jul 24, 2023 at 05:11:23PM +0300, Serge Semin wrote:
> On Mon, Jul 24, 2023 at 03:38:49PM +0200, Geert Uytterhoeven wrote:
> > Hi Serge,
> > 
> > On Mon, Jul 24, 2023 at 3:13 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > On Mon, Jul 24, 2023 at 12:04:19PM +0200, Geert Uytterhoeven wrote:
> > > > On Wed, Jun 14, 2023 at 8:07 AM <wuyonggang001@208suo.com> wrote:
> > > > > Fix the following coccicheck warning:
> > > > >
> > > > > drivers/clk/baikal-t1/ccu-pll.c:81:1-7: WARNING: do_div() does a
> > > > > 64-by-32 division, please consider using div64_ul instead.
> > > > >
> > > > > Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> > > >
> > > > Thanks for your patch, which is now commit b93d1331ea266dea
> > > > ("clk: baikal-t1: Using div64_ Ul replaces do_ Div() function")
> > > > in clk/clk-next.
> > > >
> > > > > b/drivers/clk/baikal-t1/ccu-pll.c
> > > > > index 13ef28001439..d41735c6956a 100644
> > > > > --- a/drivers/clk/baikal-t1/ccu-pll.c
> > > > > +++ b/drivers/clk/baikal-t1/ccu-pll.c
> > 
> > > > > @@ -78,9 +78,9 @@ static inline unsigned long ccu_pll_calc_freq(unsigned
> > > > > long ref_clk,
> > > > >   {
> > > > >       u64 tmp = ref_clk;
> > > > >
> > >
> > > > > -    do_div(tmp, nr);
> > > > > +    div64_ul(tmp, nr);
> > > > >       tmp *= nf;
> > > > > -    do_div(tmp, od);
> > > > > +    div64_ul(tmp, od);
> > > > >
> > > > >       return tmp;
> > > >
> > > > Likewise.
> > >
> > > Right. This will also break the driver.

No news from Yonggang meanwhile the patch will certainly break the
driver. Is it still possible to drop it from the clk-cleanup and
clk-next branches then before it gets to the mainline kernel?

-Serge(y)

> > >
> > > > But as ref_clk is unsigned long, there is no need to use div64_ul()
> > > > for the first division, and this can be simplified to:
> > > >
> > > >     u64 tmp = (u64)(ref_clk / nr) * nf;
> > > >     return div64_ul(tmp, od);
> > >
> > > Absolutely right. My intention of using the do_div() anyway was for
> > > the sake of the code unification.
> > >
> > > >
> > > > To avoid loss of precision, it might be better to reverse the order
> > > > of the division and multiplication:
> > > >
> > >
> > > >     u64 tmp = (u64)ref_clk * nf / nr;
> > >
> > > Alas exactly this code will cause the compilation error on the 32-bit
> > > platform:
> > > ccu-pll.c:(.text+0x458): undefined reference to `__udivdi3'
> > >
> > > That's why I am using the do_div() here. I would have rather used the
> > > div64_ul() instead as this patch suggests, but I haven't known about its
> > > existence up to this moment.
> > 
> > Bummer, that was a silly mistake on my side...
> > (Initially, I didn't write the cast to u64 there, as all of ref_clk, nf, and nr
> >  are unsigned long.  Then I realized "ref_clk * nf" might overflow on
> >  32-bit, thus requiring a 64-bit result. And I added the cast...)
> > 
> > > Anyway my intention of dividing before multiplying had twofold
> > > justification. Firstly I didn't want to use the "/" operator and
> > > do_div() macro in the statements used to implement the same formulae.
> > > Since I couldn't use the operator I decided to use the macro only for
> > > the code unification. Secondly the PLL is designed in a way so the
> > > signal is first divided by NR, then multiplied by NF and then divided
> > > by OD. That's why I decided to preserve the same order in the
> > > calculations here. I assumed back then that the NR-divider performs
> > > the integer division in the analog circuitry. I have doubts now that
> > > my assumption was correct since it's analog device and most likely
> > > divides the source signal with no integer rounding-up. So using the
> > > order suggested by you would have likely given a more exact result.
> > >
> > > >
> > > > But doing that requires intimate knowledge about the range of nf to
> > > > avoid overflow, so I leave that to Serge.
> > >
> > > nr: 1 - 2^6
> > > nf: 1 - 2^13
> > > ref_clk: normally 25'000'000 Hz.
> > > Using "unsigned long"/u32 multiplication will give the integer
> > > overflow. Meanwhile the u64 arithmetics will be more than enough here.
> > >
> > > So to speak the next alteration seems more correct here:
> > > +return div64_ul(div64_ul((u64)ref_clk * nf, nr), od);
> > >
> > > What do you think?
> > 
> 
> > Given the ranges above, nr and nf can be u32 instead of unsigned long.
> > So perhaps it makes sense to use the mul_u64_u32_div() helper?
> > 
> >     return div64_ul(mul_u64_u32_div(ref_clk, nf, nr), of);
> 
> Just a day of discoveries today.) Didn't know about the
> mul_u64_u32_div() existence either. Thanks for suggestion. Anyway
> seeing "unsigned long" is 32-bits wide on my platform, nr/nf/od will
> always be within the specified ranges, why not. Although using two
> div64_ul()'s seems a bit more readable. But it might be just because
> of me not being used to the mul_u64_u32_div() prototype notation.
> 
> -Serge(y)
> 
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> > -- 
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
