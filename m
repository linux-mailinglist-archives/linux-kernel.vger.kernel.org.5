Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51428801298
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjLAS0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjLAS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:26:30 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ECB115;
        Fri,  1 Dec 2023 10:26:36 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bdec453c8so685861e87.3;
        Fri, 01 Dec 2023 10:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701455195; x=1702059995; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ep11bMRk1v3QCOoLwm0Yn6OjGUPrQYX7GTrJRrOZYQ=;
        b=OuL9UiztS2p9EBAvCldsoY8qGsk5PwEs/IyqvdTCTtIyBYc6zxIKqWWDh5dVzqWBGQ
         8NPiW+pR9BEiuOOSyx4NO+3ivKmVznY1GU/xiGVrejR854C/ZBuxmGybvkhqf/D/VFQ7
         0JJ9Bo+B/BMYZ9Ru/JbOBsk1pb6HNANhDMwkETtx5v96V1Cdmg7IqsJIRFwIW+O/37If
         UUJZGncr+fwfL8CYBx/UAKKRWKQMwHfKkTU/L0Zlx1tBS8Q+dSGix29VYX5aRXxFI7IN
         RE/TgEPTId/PhJs4hFd/4qN+3CflCl6NbWoeeNbrdfb9MHTYp0azTkFVdcsVZfztIb1j
         lYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455195; x=1702059995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ep11bMRk1v3QCOoLwm0Yn6OjGUPrQYX7GTrJRrOZYQ=;
        b=MacU4NswbNBHu/cZqZRACUwwQd4ZAgnSrDhSGTVbZ7nKE9fIxsy5oQqgNNzXMPIOB7
         onfd8+yJOE5f9N/jhAYJEkD9osdEzj8hMv6TzV0BYYTx/gvw79gdY97nb/yzuHPQbfmD
         qz8N9MpJrIYFWyLe1IF/QAqyQ+ZtUMu0RB8gW7tHd+kX15eUQ248Zz/3RzY3i/7v3tut
         5+/4jS/rRofMwWKwz9LsF2Ly8pjZ5cxjlHotnc2auLxVHpN8j1whuFrtutC0gan1rySQ
         EwNdmKpvrrNsenx5KS+eNjFguSxlcdXGkIcJ7DQdn8m31PmAlW14hnkQISe5ksnlOAMr
         bnZA==
X-Gm-Message-State: AOJu0YyUf5KLRLO8Ed9w2W+chqOQslv4I6puq8GUA3+iNCKo8ZTpN/eQ
        jWLVdz5HdrUHtwHXTd8N5K5oYpVMtGYF8g==
X-Google-Smtp-Source: AGHT+IEd8uxBR2dNyumkQ7246sFbygQLGPDJa56MB2qhN12tmB7F/mg3R6x+3/DOyzDRt6p5svmQMw==
X-Received: by 2002:a05:6512:32b3:b0:50b:d764:6ea9 with SMTP id q19-20020a05651232b300b0050bd7646ea9mr964105lfe.89.1701455194684;
        Fri, 01 Dec 2023 10:26:34 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id l15-20020ac2554f000000b0050bc6317952sm484042lfk.274.2023.12.01.10.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:26:34 -0800 (PST)
Date:   Fri, 1 Dec 2023 21:26:31 +0300
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
Message-ID: <7lla5haj4r4thqqhqvkzvcu2g5oaquubgp6zyemn4up3acoeev@saxalnh6vudt>
References: <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
 <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
 <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
 <c73d9dbf-b637-47ff-ae2d-6f8987345410@app.fastmail.com>
 <3pgnihbrp5orh4tmj45fipbfoxdwzjh6uefitdpcea2vgkarcm@d56gv3areswl>
 <2148a67f-bd4f-432e-aa0d-c914a4bd5e0d@app.fastmail.com>
 <xbkplqgv4ipnofk7hp6ws2rkqk4fsjl3y72blcdephoiocolh7@7l5p5efe7yda>
 <bb13c070-bdfe-47ae-afed-a05e1e55bb94@app.fastmail.com>
 <fqwkkyt253uvdaj6qlsu67b25qj35ongh4rbxzgzuwnykl36hi@xinsnpcltpgx>
 <f883ed8d-7140-40af-9ebb-cefbd4c40f9d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f883ed8d-7140-40af-9ebb-cefbd4c40f9d@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:10:13PM +0000, Jiaxun Yang wrote:
> 
> 
> 在2023年12月1日十二月 下午2:54，Serge Semin写道：
> > On Fri, Dec 01, 2023 at 12:13:22AM +0000, Jiaxun Yang wrote:
> >> 
> >> 
> >> 在2023年11月30日十一月 下午7:16，Serge Semin写道：
> >> > On Tue, Nov 28, 2023 at 03:46:37PM +0000, Jiaxun Yang wrote:
> >> [...]
> >> >
> >> >> I'd say the safest option is to use CKSEG0 or TO_CAC here, 
> >> >
> >> > I would have agreed with you if MIPS didn't have that special
> >> > _page_cachable_default variable which is undefined for some platforms
> >> > and which might be re-defined during the boot-up process, and if
> >> > MIPS64 didn't have ioremap_prot() always mapping to the uncached
> >> > region.  But IMO updating ioremap_prot() currently seems more risky
> >> > than just converting dmi_early_remap() to the uncached version
> >> > especially seeing it won't change anything. MIPS64 always have IO
> >> > remapped to the uncached region. MIPS32 won't be able to have cached
> >> > mapping until VM is available, and paging and slabs are initialized.
> >> > So on the early MIPS32 bootup stages ioremap_cache() wouldn't have
> >> > worked anyway.
> >> 
> >
> >> I really didn't get that, using CKSEG0 on 32bit system and TO_CAC
> >> on 64bit system won't hurt.
> >> 
> >> Something like:
> >> #ifdef CONFIG_64BIT
> >> #define dmi_remap(x, l)		(void *)TO_CAC(x)
> >> #else
> >> #define dmi_remap(x, l)		(void *)CKSEG0(x)
> >> #endif
> >> 
> >> Can help us avoid all the hassle. Since it always ensures we are
> >> using same CCA to access DMI tables. We can always trust Config.K0
> >> left by firmware in this case.
> >
> > Please note my only concern is about dmi_early_remap(), not
> > dmi_remap(). The later one can be safely left backended by the
> > ioremap_cache() method because at the stage it's utilized MIPS32
> > version of ioremap_prot() will be able to create any mapping it's
> > requested to. The dmi_early_remap() function is called very early with
> > no paging or VM or even cache stuff initialized. So currently AFAICS
> > it just doesn't work on _all_ _MIPS32_ platform, because
> > ioremap_prot() relies on VM and slab being available to have any
> > cacheable mapping, which aren't at the moment of the dmi_setup()
> > function invocation. Seeing the ioremap_cache() is just a stub on
> > MIPS64 which always performs the uncached mapping, it will be
> > completely safe to just convert dmi_early_remap() to ioremap() with
> > no risk to beak anything. dmi_early_remap() semantics won't be
> > actually changed, it will work as before on MIPS64 and will be fixed
> > on MIPS32. This (AFAICS) is a completely safe fix of the problem with
> > just a few affected platforms around.
> >
> 

> The only platform enabled DMI in upstream kernel is Loongson64, which
> I'm perfectly sure that the mapping for DMI tables *should* be Cached.

Then it looks like it must have been broken in the first place.

> It is an accident that ioremap_cache is misused here, so I'm proposing
> to replace it with CKSEG0/TO_CAC. Also as per MIPS UHI spec, all the
> data passed from bootloader to firmware should lay in KSEG0,

I failed to find the MIPS UHI spec. The only link google freely
provide is
http://prplfoundation.org/wiki/MIPS_documentation
but it's broken. Could you please share the doc somehow?
Anyway AFAICS from the MIPS arch code it only concerns the dtb pointer
passed to the kernel. Does it really mandate all the data being in KSEG0?

> please
> let me know if your platform is an exception here.

No, it's not. U-boot is executed in kseg0 anyway.

> 
> Using ioremap_cache at dmi_early_remap does not sound safe to me as well.
> What if DMI code tried to remap something beyond KSEG range at this place?

Right. I've found out that for the safety sake the generic version of the
ioremap_prot() has been recently updated not to do any mapping if the
slab hasn't been initialized:
Link: https://lore.kernel.org/lkml/20230515090848.833045-7-bhe@redhat.com/
I'll add a similar fix to the MIPS-version of the ioremap_prop()
method to make sure no early cached remapping is attempted.

> 
> The safest option here is just bypassing ioremap framework, which does
> not give you any advantage but only burden.
> 
> I'll propose a patch later.

Ok. I see. I'll resubmit my series today as is then. Should you need
to have the problem fixed differently, please either re-base your
patch on top of it, or add your explicit comment that you'll have a
better fix so Thomas could be able to consider to postpone this patch
mergein until your fix is ready.

-Serge(y)

> -- 
> - Jiaxun
