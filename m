Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7FF7FFB3D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376405AbjK3T0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376388AbjK3T0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:26:19 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75329D48;
        Thu, 30 Nov 2023 11:26:25 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bca79244fso1867179e87.3;
        Thu, 30 Nov 2023 11:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701372384; x=1701977184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMs74unU7j3F1FusL/0cihts5RibnCIqAyk58UQbGC0=;
        b=mZbfDoZ42+zy1d+b9Y7/jGJBJ1IO7r5I1cOkPloAKuQTouRttLWXcZPhHVnxImQ0uk
         mRyjcG/EEdUex94aV4tuTi8S/8EzbqRVBg7CfZ4O1FccmhqCb55fjsQ+ZVzCuWenqTrh
         vQ/G+sWh2lT8Rq97fo3H7lpq++SWpmjsoKi3eAuWMcZHCfc3AU6dhFRmKuxOyvIPOldS
         3Vk+HmYjDdqwL8K7rZSRMrdAcJ0BwyauOTTUVQS0IvlBxUYH8q488YsxfofZZjNvEiRY
         PNk68ZlHeaO740lZaCiQemYHKuxZeqZtRvSqhT3Zo/ml2Ze4Hx5Nj4n+bEb38/Wx0X9J
         tqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701372384; x=1701977184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMs74unU7j3F1FusL/0cihts5RibnCIqAyk58UQbGC0=;
        b=rJUL7oEzPOwE38PAl50oUsBmmwH9m9VxL1mglOtTXsIIQNrbwvVJ4MIpcZ55ZeFToh
         ZnULP/gg9nBseTrpNzUsYDii01w+8SVT3DpNiBoznGBBqft21rJ3l9LC1AsfSRO7mDUN
         7gVGQi7Z913rBUzgAq2SM+LF1jlIqK32NL3X5aUh+D5hLTdVZDH5O8XeKyf8P5YLMSnt
         dsy9iHRKPvxPJNGB3VveLb15f43jLW6LHTsb4ppvR1Oy29xJymBBOxAEk+XC7tVXvvE1
         9F8AJeLpZs6wH2TvH1kaI1fwEHToaL6chrdWkpsBTQh38b/5J5qlNh2+17h2eyNzoe2m
         BoYg==
X-Gm-Message-State: AOJu0YxQztWKP5ecx0wJQx3BByxCFltEyB7XK3XgrMAJ+yAn1BxXlmCp
        LfVEBEm/4hIs5YFBjdMhzeg=
X-Google-Smtp-Source: AGHT+IHCWGwWvalIBKki4YozNtwRGbiGw1Q30A2/Q59Vc29DchiDIMWyT7SoQeCsB1Kr6b9roa+Ruw==
X-Received: by 2002:ac2:59c1:0:b0:50b:d764:76c1 with SMTP id x1-20020ac259c1000000b0050bd76476c1mr8537lfn.80.1701372383383;
        Thu, 30 Nov 2023 11:26:23 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id g11-20020a19ee0b000000b0050bc96db130sm234767lfb.275.2023.11.30.11.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:26:23 -0800 (PST)
Date:   Thu, 30 Nov 2023 22:26:20 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
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
Message-ID: <2b6pgqupd7uv5la5h52zczdfkpbtnn3xbz2oqjhqpyiqv6ew35@t2vb7vteespn>
References: <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
 <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
 <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
 <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
 <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
 <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
 <c1c0a409-902e-4609-ae84-8939226b4fa0@app.fastmail.com>
 <fvbe4625dgh57c3njx7fhd6vlnfxynzipfz43ieu2txflc2q4r@xzvrrmmktxsb>
 <00c225bf-ed99-4721-9d6a-1e58cdffc79f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c225bf-ed99-4721-9d6a-1e58cdffc79f@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:59:10PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 28, 2023, at 14:52, Serge Semin wrote:
> > On Tue, Nov 28, 2023 at 01:41:51PM +0100, Arnd Bergmann wrote:
> >> On Mon, Nov 27, 2023, at 17:23, Serge Semin wrote:
> >> > On Fri, Nov 24, 2023 at 10:03:49PM +0000, Jiaxun Yang wrote:
> >> but ioremap_cache() is generally underspecified because the
> >> resulting pointer is neither safe to dereference nor to pass into
> >> readl()/writel()/memcpy_fromio() on all architectures.
> >
> > I don't know about ARM64 (which for instance has it utilized to access
> > the DMI region), but at least in case of MIPS32 (a fortiori MIPS64
> > seeing the ioremap_cache() method actually returns a pointer to the
> > uncached region) I don't see a reason why it wouldn't be safe in both
> > cases described by you. All IO and memory regions are accessed by the
> > generic load and store instructions. The only difference is that the
> > MMIO-space accessors normally implies additional barriers, which just
> > slow down the execution, but shouldn't cause any other problem. Could
> > you clarify why do you think otherwise?
> 
> On arch/powerpc, CONFIG_PPC_INDIRECT_MMIO makes all ioremap()
> type functions return a token that can be passed into the readl/writel
> family but that is not a pointer you can dereference.
> 
> On s390, the mechanism is different, but similarly __iomem
> tokens are not pointers at all.

Ah, you meant that it was not generically safe. Then your were correct
for sure. I was talking about the MIPS arch, which doesn't
differentiate normal and IO memory pointers: all of them are accessed
by the same instructions. So ioremap_prot() returns just a normal
pointer there, which can be safely de-referenced.

> 
> >> There was an effort to convert the remaining ioremap_cache() calls
> >> into memremap() a few years ago, not sure if that's still being worked
> >> on but it would be the right thing to do.
> >
> > I see. Thanks for the pointing out to that. I guess it could be done
> > for MIPS too (at least on our MIPS32 platform DMI is just a memory
> > region pre-initialized by the bootloader), but the conversion would
> > require much efforts. Alas currently I can't afford to get it
> > implemented in the framework of this patchset. (I saved your note in
> > my MIPS TODO list though. Let's hope eventually I'll be able to get
> > back to this topic.)
> 

> I just noticed that the only architectures that actually provide
> ioremap_cache() are x86, arm, arm64, mips, loongarch, powerpc, sh
> and xtensa. The ones that have ACPI support still definitely
> need it, most of the other ones can probably be fixed without
> too much trouble.

Ok. Thanks. I'll have a look at that on my free time.

-Serge(y)

> 
>      Arnd
