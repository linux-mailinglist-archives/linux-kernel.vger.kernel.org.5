Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF6079F60C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjINBBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjINBBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:01:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838B01BCE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:01:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso3009075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694653304; x=1695258104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOhY4/HHjO8nyiv4RMgJQs8tmpa6Ek7TsfJHQTupOvg=;
        b=jdFpariyWnhnu7oxSvA4Px+PFqgBiXE8sb08ZnJBmWI+W3q1tlTcIivzipR3ef64ms
         aj1b9S1oynR4ApuDESPrQAeSrOr5Sw7heOAKVKNoL17a7esqWBfVzWIFXOxXpzlekaRH
         5pj3NQSHrLBs5lumLWoXy7sqXewPoQ1kzlM80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694653304; x=1695258104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOhY4/HHjO8nyiv4RMgJQs8tmpa6Ek7TsfJHQTupOvg=;
        b=fHDTNongzljirZ8GsqYYNosKvGo+IhI5VzrZGnw/73IAaNCgQiXaX8KfKBBmX1rS7S
         0IINwegKbPDahPAiqpDQ8zsfu+vfXhrVxcn7jSywf8KF9WRRpCu5CXBzyYybyQSSS5yi
         JUaVxkg4QT7Absg8+XpTsd16eyk5KzWH4TPulLhsENJowz0gt8na4OOG8RLWdlbqCcBy
         P2Oo/YEvK/72wGkF8hfMgZv+j2ghqWNShWMdk8DGZLo44jh1Qw+huvL3qMaAeoRmZplf
         TdOLCdgQpJWMqYPzc4U83Q6YN6NfPq+u7vNvbGHWn/GWWK6DOCtCS461qp/avyX6g+o6
         D3Cw==
X-Gm-Message-State: AOJu0YwTcXanzWBsdWm+RWcigvn1vY6F2uHDJ5jiwEfSvY0zwHruSk5K
        rUz8SUcq8IIJzGZDOXGaO3vE6Q==
X-Google-Smtp-Source: AGHT+IF7zVjuNnFpYU9zV2rHDCL/g2S69AM5aUXRAQqmkUEYRKGfJ7qqHWdbw8s+xLj7D18uGuv6Yw==
X-Received: by 2002:a17:902:ea01:b0:1c3:a1a8:969a with SMTP id s1-20020a170902ea0100b001c3a1a8969amr5151790plg.8.1694653303973;
        Wed, 13 Sep 2023 18:01:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902b94700b001bc21222e34sm216668pls.285.2023.09.13.18.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 18:01:43 -0700 (PDT)
Date:   Wed, 13 Sep 2023 18:01:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Sep 12 (bcachefs, objtool)
Message-ID: <202309131758.208804F4@keescook>
References: <20230912152645.0868a96a@canb.auug.org.au>
 <d60dac60-1e38-4a8c-98ad-a769ab1dfccd@infradead.org>
 <20230913210829.zkxv6qqlamymhatr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913210829.zkxv6qqlamymhatr@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 11:08:29PM +0200, Josh Poimboeuf wrote:
> On Tue, Sep 12, 2023 at 04:36:55PM -0700, Randy Dunlap wrote:
> > 
> > 
> > On 9/11/23 22:26, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20230911:
> > > 
> > > New tree: bcachefs
> > > 
> > > The bcachefs tree gained a semantic conflict against Linus' tree for
> > > which I applied a patch.
> > > 
> > > The wireless-next tree gaind a conflict against the wireless tree.
> > > 
> > > Non-merge commits (relative to Linus' tree): 4095
> > >  1552 files changed, 346893 insertions(+), 22945 deletions(-)
> > > 
> > > ----------------------------------------------------------------------------
> > 
> > on x86_64:
> > 
> > vmlinux.o: warning: objtool: bch2_dev_buckets_reserved.part.0() is missing an ELF size annotation
> 
> Here ya go:
> 
> ---8<---
> 
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> Subject: [PATCH] bcachefs: Remove undefined behavior in bch2_dev_buckets_reserved()
> 
> In general it's a good idea to avoid using bare unreachable() because it
> introduces undefined behavior in compiled code.  In this case it even
> confuses GCC into emitting an empty unused
> bch2_dev_buckets_reserved.part.0() function.
> 
> Use BUG() instead, which is nice and defined.  While in theory it should
> never trigger, if something were to go awry and the BCH_WATERMARK_NR
> case were to actually hit, the failure mode is much more robust.
> 
> Fixes the following warnings:
> 
>   vmlinux.o: warning: objtool: bch2_bucket_alloc_trans() falls through to next function bch2_reset_alloc_cursors()
>   vmlinux.o: warning: objtool: bch2_dev_buckets_reserved.part.0() is missing an ELF size annotation
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  fs/bcachefs/buckets.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
> index f192809f50cf..0eff05c79c65 100644
> --- a/fs/bcachefs/buckets.h
> +++ b/fs/bcachefs/buckets.h
> @@ -180,7 +180,7 @@ static inline u64 bch2_dev_buckets_reserved(struct bch_dev *ca, enum bch_waterma
>  
>  	switch (watermark) {
>  	case BCH_WATERMARK_NR:
> -		unreachable();
> +		BUG();

Linus gets really upset about new BUG() usage (takes out the entire
system):
https://docs.kernel.org/process/deprecated.html#bug-and-bug-on

It'd be nicer to actually handle the impossible case. (WARN and return
0?)

-Kees

>  	case BCH_WATERMARK_stripe:
>  		reserved += ca->mi.nbuckets >> 6;
>  		fallthrough;
> -- 
> 2.41.0
> 

-- 
Kees Cook
