Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C387FFAFF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376324AbjK3TQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376269AbjK3TQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:16:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A8210DF;
        Thu, 30 Nov 2023 11:16:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bc4fe8158so1879608e87.0;
        Thu, 30 Nov 2023 11:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701371809; x=1701976609; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=beTU95GN50GYTXIaXw8asjQyUJ5kn1rsDTKmhhbRSLc=;
        b=NHOUtUQsIXFhNr31aeuq9abXTOYWWMyrKoQppF6zi9wR5FugZ9WwOw63v8gBx/NSrt
         1p3wsarcTpXJ8UA2KIYMLjnoznHusXVrcSXbbhjXv9btn02QWplp/d+OKjfL3W53xmmX
         wBk/SsPBUjO4Jn7E/478jr1IcQgtCy0A8McJ6TGbSslKmR77EnAylHmMO+ZQidzTF76c
         yo29kuFJadjifDxP8qQa58pwoNrjVQLjMy2T+Lx4YMoYiInXoGXadO2GGatMpngMqkD4
         a8N9+Oo6dqaIrUJP47j/72NV7HDcFnMM33Y0AMJon/5mbws02FTYQJo7xJ2tTC8MN8qF
         Cpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371809; x=1701976609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beTU95GN50GYTXIaXw8asjQyUJ5kn1rsDTKmhhbRSLc=;
        b=mONZymjPAcWH9auLmLvvBL06BB3f4VQPpiY6NdKbjsyNtOTbifWOhRgm07LPNBwXXG
         UXTxCeS2xawqvRwQLUkrnQwS7pbXk/0CJWV1wYggEXJzp3vfC1OiJeEKt6/32sP58JKH
         CpWYgVT1nYa7KV0ZpmX51MPwxGLxFUGF9jL8RaENm0GSkqLIpxa4fbx4I+QNsTsECO4U
         Au8nOuXbTbpTFLJn4RpjcPYpz97NLiEknUMyJzXq5J0Ooo+e4iG+uoV0GmCeXuO385VO
         JglbeoPkiCmxYaDWNEXiAd6WEDQI5/Qh0gBsIvfECfWfCSpFYrGL+GPh7tnMgt+ZhE/2
         AueQ==
X-Gm-Message-State: AOJu0YycETzd5StejUBFiGmBwGYUEb5sBovnk5nsfeCOaw6+W3qtTYEv
        mfX3XrAAOPI7wvh/YOxnM8Q=
X-Google-Smtp-Source: AGHT+IEjI7GCoxUOOVd+G0oM4OekkSNj6mkZDuZl+LhOwppbLSARI3DeRgkKK7Ms62A8NDUSE8hsMg==
X-Received: by 2002:a05:6512:36cb:b0:507:9ef2:fb1c with SMTP id e11-20020a05651236cb00b005079ef2fb1cmr10846lfs.2.1701371808553;
        Thu, 30 Nov 2023 11:16:48 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id dx14-20020a0565122c0e00b00507a089caf6sm230827lfb.219.2023.11.30.11.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:16:47 -0800 (PST)
Date:   Thu, 30 Nov 2023 22:16:45 +0300
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
Message-ID: <xbkplqgv4ipnofk7hp6ws2rkqk4fsjl3y72blcdephoiocolh7@7l5p5efe7yda>
References: <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
 <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
 <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
 <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
 <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
 <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
 <c73d9dbf-b637-47ff-ae2d-6f8987345410@app.fastmail.com>
 <3pgnihbrp5orh4tmj45fipbfoxdwzjh6uefitdpcea2vgkarcm@d56gv3areswl>
 <2148a67f-bd4f-432e-aa0d-c914a4bd5e0d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2148a67f-bd4f-432e-aa0d-c914a4bd5e0d@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 03:46:37PM +0000, Jiaxun Yang wrote:
> 
> 
> 在2023年11月28日十一月 上午11:34，Serge Semin写道：
> > On Mon, Nov 27, 2023 at 09:08:11PM +0000, Jiaxun Yang wrote:
> [...]
> >
> > Indeed. Thanks for pointing that out. In the last days several times I
> > was looking at that line and for some reason UNCAC_BASE seemed as
> > CAC_BASE to me.) Based on what both IO_BASE and UNCAC_BASE are defined
> > as of the uncached region anyway, then it should be safe for any
> > currently supported MIPS64 (including the Loongson's) to use ioremap()
> > in place of dmi_early_remap(). So basically my current patch in the
> > subject won't change the method semantics. Let's not to try to fix a
> > problem which doesn't exist then, and keep the patch as is especially
> > seeing that the alternatives might still cause some troubles. Will you
> > be ok with that?
> 

> I'd say the safest option is to use CKSEG0 or TO_CAC here, 

I would have agreed with you if MIPS didn't have that special
_page_cachable_default variable which is undefined for some platforms
and which might be re-defined during the boot-up process, and if
MIPS64 didn't have ioremap_prot() always mapping to the uncached
region.  But IMO updating ioremap_prot() currently seems more risky
than just converting dmi_early_remap() to the uncached version
especially seeing it won't change anything. MIPS64 always have IO
remapped to the uncached region. MIPS32 won't be able to have cached
mapping until VM is available, and paging and slabs are initialized.
So on the early MIPS32 bootup stages ioremap_cache() wouldn't have
worked anyway.

> but I'm fine
> with ioremap as long as the semantic remains uncached on Loongson.

Ok. Thanks.

-Serge(y)

> 
> Thanks.
> >
> > -Serge(y)
> >
> >> 
> [...]
> -- 
> - Jiaxun
