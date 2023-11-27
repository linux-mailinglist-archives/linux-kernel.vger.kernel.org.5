Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3877FA647
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjK0QX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjK0QX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:23:27 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA3119B;
        Mon, 27 Nov 2023 08:23:33 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507be298d2aso6017103e87.1;
        Mon, 27 Nov 2023 08:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701102212; x=1701707012; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U2WmaNst220bl2JYvYWQafBEL6DaauacmewQ2Ui+7EQ=;
        b=WH0UtOhgVX3Ubz9xVh5llJAaahZzuHQJhWkDiywz5UxyGTSSsj02qm8ydI83OETRxF
         adSYU5yuo3Z3LsmkL75UE/Zu3kGBrpnXzl1Oj3mdHP45u9iL0fXI+3LqdNZIS5fD0AhH
         KYZ2LgyiAsVb4Kpgp2DI2j3uuPV+ThKJ59kzf6RVK1C+RFZFN/AEYnN55DnJnfgybhlP
         x2fgHP2vwOA0IsNfBDWLdESAnVZ7mTu/RKv6y6zvdOYvmCzRIIt97zsOKJmzcg341/+r
         jRkzQlMp2rGjjMgu8uJsdclDzA9npvk/zXTUhaMUJJwuEbThpxmSoScOGUcDceeweQ1G
         u3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102212; x=1701707012;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2WmaNst220bl2JYvYWQafBEL6DaauacmewQ2Ui+7EQ=;
        b=Ar3f6/cnJav+ocbUYT4MmZz/G5BxQxPzaPZZHXe7H9flrmdM3WwaB0+NuDR4wM1zc0
         0jLwJTK8XiZOE0bOaY16/gdFh9WXC14zBh+ZAT6+9xkxfbszmWF1GiKq9A8xqgiOULfb
         uhSDJZCJPpFPKsGzq4x6k/X5IymnSyiEY/GEwIbeyrISRCq9VtyYXkdDyqEtHFuMT00I
         vml/s4e1+633ZtP8aiO7mn/rvfTE4qPdT+4lgvlZE1KUYoRW2wgSQ8QfTf1BcznOY3Uk
         R60I4bdRu2Uf1eFs5rqmiVSOznVMUk8J5XRnX6PUqAWBVMYUfbpUhvZzGUqQ/IEos4yf
         77pA==
X-Gm-Message-State: AOJu0Yy77S+wbON093y51PKyZ+aFVg6r4fXWaLYUlJYD6Ui77KMqNYFf
        mu2u+TyFdmPEAMkCad7xfzk=
X-Google-Smtp-Source: AGHT+IG7xu7bSIz5oLxdKNj7/aZosFlhEMUeLxrFPbwCQdns90kewsQKelW62cF7HIq6A7e/TTD+rw==
X-Received: by 2002:a05:6512:3c86:b0:507:a40e:d8bf with SMTP id h6-20020a0565123c8600b00507a40ed8bfmr10570132lfv.7.1701102211320;
        Mon, 27 Nov 2023 08:23:31 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d36-20020a0565123d2400b0050aa8d38c40sm1533916lfv.168.2023.11.27.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:23:30 -0800 (PST)
Date:   Mon, 27 Nov 2023 19:23:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>, Marc Zyngier <maz@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mips: dmi: Fix early remap on MIPS32
Message-ID: <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
References: <20231122182419.30633-2-fancer.lancer@gmail.com>
 <b996b542-4cd3-4f9d-b221-00b2d5ef224e@app.fastmail.com>
 <c7cuvhuu6py5vxhhvkhekv6ned5sro4a3wzzn7v45oahfw42ud@gyqmucagt5e2>
 <8ca730b9-fa8c-46ea-bdc5-158da0f29c3a@app.fastmail.com>
 <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
 <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
 <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
 <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
 <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxun

On Fri, Nov 24, 2023 at 10:03:49PM +0000, Jiaxun Yang wrote:
> 在2023年11月24日十一月 下午6:52，Serge Semin写道：
> > On Thu, Nov 23, 2023 at 05:33:31PM +0000, Jiaxun Yang wrote:
> >> 
> [...]
> >> Actually dmi_setup() is called before cpu_cache_init().
> >
> > To preliminary sum the discussion, indeed there can be issues on the
> > platforms which have DMI initialized on the cached region. Here are
> > several solutions and additional difficulties I think may be caused by
> > implementing them:
> 
> Thanks for such detailed conclusion!
> I'd prefer go solution 1, with comments below.
> >
> > 1. Use unmapped cached region utilization in the MIPS32 ioremap_prot()
> > method.
> > This solution a bit clumsy than it looks on the first glance.
> > ioremap_prot() can be used for various types of the cachability
> > mapping. Currently it's a default-cacheable CA preserved in the
> > _page_cachable_default variable and Write-combined CA saved in
> > boot_cpu_data.writecombine. Based on that we would have needed to use
> > the unmapped cached region utilized for the IO-remaps called with the
> > "_page_cachable_default" mapping flags passed only. The rest of the IO
> > range mappings, including the write-combined ones, would have been
> > handled by VM means. This would have made the ioremap_prot() a bit
> > less maintainable, but still won't be that hard to implement (unless I
> > miss something):
> > --- a/arch/mips/mm/ioremap.c
> > +++ b/arch/mips/mm/ioremap.c
> >         /*
> > -        * Map uncached objects in the low 512mb of address space using KSEG1,
> > -        * otherwise map using page tables.
> > +        * Map uncached/default-cached objects in the low 512mb of address
> > +        * space using KSEG1/KSEG0, otherwise map using page tables.
> >          */
> > -       if (IS_LOW512(phys_addr) && IS_LOW512(last_addr) &&
> > -           flags == _CACHE_UNCACHED)
> > -               return (void __iomem *) CKSEG1ADDR(phys_addr);
> > +       if (IS_LOW512(phys_addr) && IS_LOW512(last_addr)) {
> > +               if (flags == _CACHE_UNCACHED)
> > +                       return (void __iomem *) CKSEG1ADDR(phys_addr);
> > +               else if (flags == _page_cachable_default)
> > +                       return (void __iomem *) CKSEG0ADDR(phys_addr);
> > +       }
> >
> > Currently I can't figure out what obvious problems it may cause. But
> > It seems suspicious that the cacheable IO-mapping hasn't been
> > implemented by the unmapped cacheable region in the first place. In
> > anyway this solution looks more dangerous than solution 2. because it
> > affects all the MIPS32 platforms at once.
> 
> I just made a quick grep in tree, and it seems like we don't have much
> user of ioremap_cache (as well as ioremap_uc/wc) here so I think it is
> a safe assumption.

I wouldn't say there aren't much users. ioremap_wc() and it's
devm-version is widely utilized in the GPU and network and some other
subsystems. ioremap_cache() isn't widespread indeed. In anyway even a
single user must be supported in safely calling the method if it's
provided by the arch-code, otherwise the method could be considered as
just a bogus stub to have the kernel successfully built. I bet you'll
agree with that. But that's not the point in this case.

A bit later you also noted:

On Fri, Nov 24, 2023 at 10:34:49PM +0000, Jiaxun Yang wrote:
> A nip, _page_cachable_default is set in cpu_cache_init() as well. We'd
> better move it to cpu-probe.c, or give it a reasonable default value.

Right. Thanks. To be honest I haven't noticed that before your
message. _page_cachable_default is indeed initialized in the
cpu_cache_init() method, several steps after it would be used in the
framework of dmi_remap_early(). On the other hand ioremap_cache() is
defined as ioremap_prot() with the _page_cachable_default variable
passed. So my code will still correctly work unless
_page_cachable_default is pre-initialized with something other than
zero. On the other hand we can't easily change its default value
because it will affect and likely break the r3k (CPU_R3000) and Octeon
based platforms, because it's utilized to initialize the
protection-map table. Of course we can fix the r3k_cache_init() and
octeon_cache_init() methods too so they would get the
_page_cachable_default variable back to zero, but it will also make
things around it more complicated.

Also note, moving the _page_cachable_default initialization to the
earlier stages like cpu_probe() won't work better because the field
value may get change for instance in the framework of the smp_setup()
function (see cps_smp_setup()).

So after all the considerations above this solution now looks even
clumsier than before.( Any idea how to make it better?

> 
> >
> > 2. Convert dmi_remap_early() to ioremap_uc() (actually just ioremap()
> > as noted by Arnd).
> > As Jiaxun correctly noted this may cause problems on the platforms
> > which don't flush caches before jumping out to the kernel. Thomas said
> > that kernel flushes the caches early on boot, but Jiaxun noted that
> > it's still done after early DMI setup. So the issue with solution 2 is
> > that the setup_arch() method calls dmi_setup() before it flushes the
> > caches by means of the cpu_cache_init() method. I guess it can be
> > fixed just by moving the dmi_setup() method invocation to be after the
> > cpu_cache_init() is called. This solution looks much less invasive
> > than solution 1.
> 
> I recall Tiezhu made dmi_setup() here for reasons. The first reason is that
> DMI is placed at memory space that is not reserved, so it may get clobbered
> after mm is up.

Note the memory might be clobbered even before dmi_setup() for
instance by means of the early_memtest() method. In anyway it would be
better if the system booloader would have already reserved the DMI
memory (in DTB) or it would have been done by the platform-specific
plat_mem_setup() method.

> The second is we may have some early quirks depends on DMI
> information.

Which quirks do you mean to be dependent in between the current
dmi_setup() call place and the cpu_cache_init() method invocation?

-Serge(y)

> 
> Thanks.
> >
> > So what do you think? What solution do you prefer? Perhaps
> > alternative?
> >
> > -Serge(y)
> >
> >> 
> >> Thanks
> >> >
> >> > Thomas.
> >> >
> >> > -- 
> >> > Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> >> > good idea.                                                [ RFC1925, 2.3 ]
> >> 
> >> -- 
> >> - Jiaxun
> 
> -- 
> - Jiaxun
