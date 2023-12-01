Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D903800DC2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379260AbjLAOyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379210AbjLAOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:54:10 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CFCBD;
        Fri,  1 Dec 2023 06:54:16 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bce78f145so2496228e87.0;
        Fri, 01 Dec 2023 06:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701442454; x=1702047254; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vjkrMKDNwyW10cBYkdXjLMVIs+vWBEVR6cPhW1G4HuM=;
        b=CVLxkO+r+zA6a5BWcMWXRpSchsOO02wvM/h1jwmM/m2VlGuN9A5X5XUi+XQgVC5OoC
         M3ofBq5BBkzJf+G6SmP0n2KjErUv2fDmTAMXupIweLrtOgoq4WY3Jf0cah+h3NTKl4vT
         btqNJUweQvhm1j131oam/LQLJDF+1veFbyuzY90yn97PRfxyRnnEUNl3uORwPwQdUtjX
         HG8JCPntkWiUhpM/imHC2bR/BSjqUPOx2KLEQzZXDJDfRjVt2EgB4hQQ4RO/Ip1yOsk6
         s14TeNY6eWkYaUMqf3T2F6DjbFbGHT/RiVZwzuZGwycWBDuUpzR9iMpBbZAuGrw6hfeO
         rCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442454; x=1702047254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjkrMKDNwyW10cBYkdXjLMVIs+vWBEVR6cPhW1G4HuM=;
        b=eJvhQunbOR2yk+nCyymBcsiMQYcfvlvXGUU/Bgai6yM1IwbobuzANKlkYSy2R0PKxZ
         qyy+xmBAEGR2XAwFqlq2HSy2bfbp2aaJbDhYrqLXmEeBn8KgnhRtWDQY2ZhGMHk+iBJJ
         Aq0udlQCIG6swonWUad9XeSyT5OOYLMpmK8X7Rxtp76HqvuaIBgnYCiQJUtWOYjVQQf3
         LdFIhUp4OvgCaNRJOohW52GlHfmxJB6HPHpkQzXkFHb2Wuo5+ze/2GMNqhriSsQQXwWx
         F48KLZPDV4ST/GDFQkV0FLzINIXr1jABh8WjJNroHEuLYpPDfN7h6r+DfSvuwQm4N/rV
         nIDQ==
X-Gm-Message-State: AOJu0YwaHetjV1J+1nS0xAaDshqZWW3ylK7sJFP11c0g6FybBz0ZoMc0
        UGQPNWnhY/+ZJt5UEBB75vDQbrtW0xX5ww==
X-Google-Smtp-Source: AGHT+IHrH7Kf9EKULsQ06Dcv9sljAIuimxYV6nixZA7lde0fvt11XxB2RBDEtivjkMIFVpwHGjzy3A==
X-Received: by 2002:ac2:4559:0:b0:50b:dfc9:db2b with SMTP id j25-20020ac24559000000b0050bdfc9db2bmr82673lfm.205.1701442453887;
        Fri, 01 Dec 2023 06:54:13 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id h9-20020a197009000000b0050bdf4055a4sm39084lfc.233.2023.12.01.06.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:54:13 -0800 (PST)
Date:   Fri, 1 Dec 2023 17:54:10 +0300
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
Message-ID: <fqwkkyt253uvdaj6qlsu67b25qj35ongh4rbxzgzuwnykl36hi@xinsnpcltpgx>
References: <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
 <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
 <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
 <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
 <c73d9dbf-b637-47ff-ae2d-6f8987345410@app.fastmail.com>
 <3pgnihbrp5orh4tmj45fipbfoxdwzjh6uefitdpcea2vgkarcm@d56gv3areswl>
 <2148a67f-bd4f-432e-aa0d-c914a4bd5e0d@app.fastmail.com>
 <xbkplqgv4ipnofk7hp6ws2rkqk4fsjl3y72blcdephoiocolh7@7l5p5efe7yda>
 <bb13c070-bdfe-47ae-afed-a05e1e55bb94@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb13c070-bdfe-47ae-afed-a05e1e55bb94@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 12:13:22AM +0000, Jiaxun Yang wrote:
> 
> 
> 在2023年11月30日十一月 下午7:16，Serge Semin写道：
> > On Tue, Nov 28, 2023 at 03:46:37PM +0000, Jiaxun Yang wrote:
> [...]
> >
> >> I'd say the safest option is to use CKSEG0 or TO_CAC here, 
> >
> > I would have agreed with you if MIPS didn't have that special
> > _page_cachable_default variable which is undefined for some platforms
> > and which might be re-defined during the boot-up process, and if
> > MIPS64 didn't have ioremap_prot() always mapping to the uncached
> > region.  But IMO updating ioremap_prot() currently seems more risky
> > than just converting dmi_early_remap() to the uncached version
> > especially seeing it won't change anything. MIPS64 always have IO
> > remapped to the uncached region. MIPS32 won't be able to have cached
> > mapping until VM is available, and paging and slabs are initialized.
> > So on the early MIPS32 bootup stages ioremap_cache() wouldn't have
> > worked anyway.
> 

> I really didn't get that, using CKSEG0 on 32bit system and TO_CAC
> on 64bit system won't hurt.
> 
> Something like:
> #ifdef CONFIG_64BIT
> #define dmi_remap(x, l)		(void *)TO_CAC(x)
> #else
> #define dmi_remap(x, l)		(void *)CKSEG0(x)
> #endif
> 
> Can help us avoid all the hassle. Since it always ensures we are
> using same CCA to access DMI tables. We can always trust Config.K0
> left by firmware in this case.

Please note my only concern is about dmi_early_remap(), not
dmi_remap(). The later one can be safely left backended by the
ioremap_cache() method because at the stage it's utilized MIPS32
version of ioremap_prot() will be able to create any mapping it's
requested to. The dmi_early_remap() function is called very early with
no paging or VM or even cache stuff initialized. So currently AFAICS
it just doesn't work on _all_ _MIPS32_ platform, because
ioremap_prot() relies on VM and slab being available to have any
cacheable mapping, which aren't at the moment of the dmi_setup()
function invocation. Seeing the ioremap_cache() is just a stub on
MIPS64 which always performs the uncached mapping, it will be
completely safe to just convert dmi_early_remap() to ioremap() with
no risk to beak anything. dmi_early_remap() semantics won't be
actually changed, it will work as before on MIPS64 and will be fixed
on MIPS32. This (AFAICS) is a completely safe fix of the problem with
just a few affected platforms around.

Getting back to what you suggest. You want to change the
ioremap_prot() semantics so one would return a pointer to the cached
unmapped region for the ioremap_cache() method. First of all
ioremap_cache() doesn't define what type of the cached mapping it
needs but merely relies on the _page_cachable_default variable value.
That variable is uninitialized on the early stages and then only
initialized for the r4k platforms (this makes me also thinking that
ioremap_cache() doesn't properly work for r3k and Octeon platforms),
thus we would need to have it initialized with some value until the
cpu_cache_init() is called and have the r3k and Octen cache init
functions fixed to get it back to the uninitialized zero value .
Moreover all the _CACHE_* field values are already occupied. What
default value should be use then for _page_cachable_default? You say
to read Config.K0 earlier, but Config.K0 may be changed later in the
framework of the cps_smp_setup() method and actually in
cpu_cache_init() for r4k if 'cca' kernel parameter is specified. So do
we need _page_cachable_default being re-initialized then?.. There
might be some other underwater rocks in the fix you suggest. But all
of that already makes your solution much more risky than the one
described before.

Howbeit if you still think that none of the concerns listed above is
worth being that much worried about, then please note your solution is
mainly targeted to fix ioremap_cache(). Meanwhile this patch is about
the DMI region mapping. So if ioremap_cache() needs to be fixed in a
way you suggest it's better to be done in a framework of another
patch. But considering the possible problems it may cause I wouldn't
risk to have it backported to the stable kernels.

-Serge(y)

> 
> You may add some sanity check on 32 bit to avoid generating invalid
> pointer. (And perhaps implement it as ioremap_early.....) 
> 
> Thanks
> -- 
> - Jiaxun
