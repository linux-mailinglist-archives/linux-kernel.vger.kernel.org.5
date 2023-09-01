Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604DA79020D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350585AbjIAScm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjIAScl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:32:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D69519E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:32:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf092a16c9so18365095ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693593158; x=1694197958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6OX4ESsTLl6ApuI6FDV4HSspv8mn63QqTxuR45w8VU=;
        b=a1x6rLZiEtfY7GHGHyvIf7gy5o8qCOIrG74yR4AzOwXO6WRqhvXcoyIffezx7N5OY2
         c3uU4uBtN+LO3Y95avNaBERWzB9vxxot0pPvclLbpzrpz3ejY2LUlJcP5Q/PP8rxdirr
         5FKsyFiUNUbnYV97cly2zgqfOtubMaOPCoak0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693593158; x=1694197958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6OX4ESsTLl6ApuI6FDV4HSspv8mn63QqTxuR45w8VU=;
        b=KpDqzSXsl0NW/gbLFvkNDFyjwKGtNlQG+a8gy4Jnw1TbK8rPrCTYM50I6JEupBapzu
         a9kq8z2MfEf0+u+IKSIBjAD6Z2ksWxRya4TJsUmON3khYvbircwwEf3DGrEMRs91eijl
         vWQZxQaZzG1qvfeiNpyojBmnXq5SXTsnei4oRgeEj8Iz0jnjYtEMi2DeOTdMzOed5xkf
         wEa3ByaEmuhayRsLJyg1iICnrjsSiiVjBYK4tIH5x1oU4B/Z76czN9chYP6Ueo1K0uDA
         vvbHn3oLS1wgbQUzBN93acCw2mQINBjvi+drMICpQBzd9NDd57ptUjGqas/MiYGxjwuy
         CizA==
X-Gm-Message-State: AOJu0Yxd5IY95h2XEvpbl1b/O8nBulfibFPNYV2eUrfVFU4aAu2tikvH
        b8qM+7ocEbMqwNALbMD2Pla81w==
X-Google-Smtp-Source: AGHT+IEXedxDyhssdkjDhR0kl/szUvNh9UK8tCVEFt6vr38Ypb8iBBJ2vnd51/Nd8wNZ6wSMkn1OQg==
X-Received: by 2002:a17:903:11cc:b0:1be:f53c:7d1d with SMTP id q12-20020a17090311cc00b001bef53c7d1dmr4496217plh.23.1693593158093;
        Fri, 01 Sep 2023 11:32:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902788e00b001bc930d4517sm3284865pll.42.2023.09.01.11.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 11:32:37 -0700 (PDT)
Date:   Fri, 1 Sep 2023 11:32:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm: make __GFP_SKIP_ZERO visible to skip zero operation
Message-ID: <202309011130.7543E1DC9D@keescook>
References: <20230831105252.1385911-1-zhaoyang.huang@unisoc.com>
 <ZPCEim0AZG5hTSYH@casper.infradead.org>
 <CAGWkznGAJVZtn49zNHsMAjRSfTRR707QXYY0m8Q+yABTsiig2Q@mail.gmail.com>
 <CAG_fn=VJrO3e9q0M6KA9nopqyDuRO4g7SBak6YptiEvzdE+nkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VJrO3e9q0M6KA9nopqyDuRO4g7SBak6YptiEvzdE+nkA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 02:55:17PM +0200, Alexander Potapenko wrote:
> A draft implementation at
> https://github.com/ramosian-glider/linux/commit/00791be14eb1113eae615c74b652f94b5cc3c336
> (which probably does not apply anymore) may give some insight into how
> this is supposed to work.
> There's plenty of room for bikeshedding here (does the command-line
> flag opt-in or opt-out? should we use function names instead of some
> "keys"? can we allow overriding every allocation site without the need
> for alloc_pages_uninit()?), but if the overall scheme is viable I can
> probably proceed with an RFC.

This is my preferred direction to go with this idea (though I agree some
internals could be partially whitelisted: the "dup" functions need to
wipe the trailing rounded-up bucket size bytes still).

-- 
Kees Cook
