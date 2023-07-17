Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F478756F98
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGQWG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGQWG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:06:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1594DE60
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:06:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8b4749013so39623725ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689631585; x=1692223585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0aSkMLbqhEFS8h89Y97m3Wg87iVlmg9IMH1ozE7q+w=;
        b=PAt4mCjlwI68plM4shnc5qOIASfztjz6zfEE36PQkBKuIZW2uX2iywbAqZLHTH1azK
         dj7rfPvMEser3qUfNycp5Eyat04eS0VZ5BTKi3zRzdE1wSk0+40PxJbFmUxzW7dWMN52
         mdyjm9JseYGh+wsrM+hGHlg5YBHhuzaU+EckGR3LmaFmbG3mpKjfMOZ0NU7K3bm1BF6W
         E1T+uNWJJ4wFlr82lhkg3bl1UCjTg0k4aQzdn9yInHhPmujbKL/MaTik+CxeI0I9EP0k
         7XTGNLKp12c9JeGpUUKA4LyL6YyUdexNvokFQzT3D5WEb87P4ETrmJs6I/0W/+0am2It
         7GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689631585; x=1692223585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0aSkMLbqhEFS8h89Y97m3Wg87iVlmg9IMH1ozE7q+w=;
        b=aI4Q6dgYK96z9Y6WPTN2zFAcl7ob4mgc46oCGfjJD2Txm3Q332gF3B21E9UsqOihdE
         6cNsvrdXbEO0CN7GXg636Ql4HGiCsgLtrUM3+yrBdx7uvESy0JdkXTT8NBlL/5fLaclz
         ERv+ot5dIhIXmdBA6s/IwoJc2VNl103mFct4HDzHiQfi47jrYeoI2I/2plkB10MRH3Pm
         UbDstVbROrvfSK+7ELVaGPyGwSNhBzivUjH+Cv7ZNKRQ5yHBeDQ9j1n0mE6hSAZZpIKi
         w7/3AcBjmU6etM7FMiuVOvyDEpiY0zMNUPiMZNDBKgCfCO8D3UvgMKpVKsjHaTUuf6TJ
         QKsw==
X-Gm-Message-State: ABy/qLYD1ANQwEWNdG3KDLm+N6Zdg22mB/wv3RNGSqHyI04Wm6/LCMTM
        CRM/3IHdcSTjdt0dhh+QZmDciZV9uimUCA==
X-Google-Smtp-Source: APBJJlFjyMH8cvaHEb3t6vprfhkqU1UNjIvb6QQUX1oy3Jg/sp5qpqI2R8Ho8Lqhq9Mo3qEvH4vaRQ==
X-Received: by 2002:a17:902:e550:b0:1b8:7e53:704 with SMTP id n16-20020a170902e55000b001b87e530704mr15565931plf.27.1689631585524;
        Mon, 17 Jul 2023 15:06:25 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001b7feed285csm360027pll.36.2023.07.17.15.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 15:06:25 -0700 (PDT)
Date:   Mon, 17 Jul 2023 15:06:23 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tom Rix <trix@redhat.com>, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] lib/bitmap: waive const_eval test as it breaks the build
Message-ID: <ZLW7X04wQ1b9jdHZ@yury-ThinkPad>
References: <20230717195813.29059-1-yury.norov@gmail.com>
 <20230717203105.GA2212488@dev-arch.thelio-3990X>
 <CAKwvOdmUb=JgigcHxOR2trAx+fSxsKu9nNbpAhN1hC8_RBNXeQ@mail.gmail.com>
 <ZLWzLHsGmRxpylxN@yury-ThinkPad>
 <20230717215328.GA18505@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717215328.GA18505@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Yury, Nathan,
> > > Thanks for the patches and discussion.  Yes, I think a combo of:
> > > 
> > > 1. Nathan's lib/Makefile change plus
> > > 2. Yury's removal of the current preprocessor guards in lib/test_bitmap.c
> > > 
> > > make most sense.
> > 
> > OK, then I'll send a v2 shortly. Nathan, don't you mind if I add your
> > co-developed-by for this?
> 
> Sure, no worries!
> 
> Co-developed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Done. Just removed external link from Makefile. We've got it in commit
message anyways, so better to not pollute sources.
