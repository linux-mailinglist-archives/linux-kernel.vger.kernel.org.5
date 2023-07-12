Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F417513A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGLWix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGLWir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:38:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7611FCD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:38:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6686ef86110so71113b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689201526; x=1691793526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8YUW/Zd4/FzjfHiWuAqocnMNvPoUjuHs9kCi3pQTEg=;
        b=JcItZFYLGNLQpMetpc4AZXWDqjK75pr9B84E73Vg6Z6upHHtSs5EuoCIm08b1fOrw3
         W062q+m+kTVhfF5qDwmOmt5DE0H3S1o9iwgug7J+Af+YeKR6TrJjQyZrS64uyX3g/Vhl
         d9qmNjelUFRc6zilOeKM0muTSuN1qIHW/e5Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201526; x=1691793526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8YUW/Zd4/FzjfHiWuAqocnMNvPoUjuHs9kCi3pQTEg=;
        b=jlsnRTIq5kdC7nRhcu2cgoVUnZ8ZTpkmjRqWvCF9l5CQT2ar5vreEyZuY+iOsHj3QH
         yvDU4tc9b4jUKECrtSzhQc1rut8o8JuOt59+GURI1d+q1E3JIOjGWjr8aDpuAs+TnvMm
         quN1CJPtDYri5V2BVzk5Bl9jT7y7l5Rz/aHFXCShW70Rm0bZEZTNbliWOQGfy7W+5D54
         2pjYcIywQzQf7FmT+9tdKCalUweUtnCF0glQqjb8KE/r4GTCZIFlo/8fqLeISc7kVd1o
         f5qfBSQ9u/SJC8hM+v3RPOeEID9GiGD6dxOmN8aOxGGJrhfnRp79PaXCr2tKfilXTxsI
         BmAA==
X-Gm-Message-State: ABy/qLbb0Y4qpQki0G6NLLLxEX+PJaTMjaXOzgEUJkbEg+QCd9sanSwm
        rOJsv1pKQAtV8FrgfLGThqrhWg==
X-Google-Smtp-Source: APBJJlEdhwXsXcGHCDh9IIXqffyekudE0U73cwGt4G+vJfJhXQWa0KQDZhRcqpkbW+8Hic7He3qlLQ==
X-Received: by 2002:a05:6a21:900c:b0:130:74c8:b501 with SMTP id tq12-20020a056a21900c00b0013074c8b501mr11827939pzb.30.1689201525956;
        Wed, 12 Jul 2023 15:38:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bc1-20020a170902930100b001b3fb2f0296sm4462298plb.120.2023.07.12.15.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:38:45 -0700 (PDT)
Date:   Wed, 12 Jul 2023 15:38:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 29/32] lib/string_helpers: string_get_size() now returns
 characters wrote
Message-ID: <202307121525.B3B6153D8@keescook>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-30-kent.overstreet@linux.dev>
 <202307121248.36919B223@keescook>
 <20230712201931.kuksw5zmuwah7tqs@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712201931.kuksw5zmuwah7tqs@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:19:31PM -0400, Kent Overstreet wrote:
> On Wed, Jul 12, 2023 at 12:58:54PM -0700, Kees Cook wrote:
> > On Tue, May 09, 2023 at 12:56:54PM -0400, Kent Overstreet wrote:
> > > From: Kent Overstreet <kent.overstreet@gmail.com>
> > > 
> > > printbuf now needs to know the number of characters that would have been
> > > written if the buffer was too small, like snprintf(); this changes
> > > string_get_size() to return the the return value of snprintf().
> > 
> > Unfortunately, snprintf doesn't return characters written, it return
> > what it TRIED to write, and can cause a lot of problems[1]. This patch
> > would be fine with me if the snprintf was also replaced by scnprintf,
> > which will return the actual string length copied (or 0) *not* including
> > the trailing %NUL.
> 
> ...All of which would be solved if we were converting code away from raw
> char * buffers to a proper string building type.
> 
> Which I tried to address when I tried to push printbufs upstream, but
> that turned into a giant exercise in frustration in dealing with
> maintainers.

Heh, yeah, I've been trying to aim people at using seq_buf instead of
a long series of snprintf/strlcat/etc calls. Where can I look at how
you wired this up to seq_buf/printbuf? I had trouble finding it when I
looked before. I'd really like to find a way to do it without leaving
around foot-guns for future callers of string_get_size(). :)

I found the printbuf series:
https://lore.kernel.org/lkml/20220808024128.3219082-1-willy@infradead.org/
It seems there are some nice improvements in there. It'd be really nice
if seq_buf could just grow those changes. Adding a static version of
seq_buf_init to be used like you have PRINTBUF_EXTERN would be nice
(or even a statically sized initializer). And much of the conversions
is just changing types and functions. If we can leave all that alone,
things become MUCH easier to review, etc, etc. I'd *love* to see an
incremental improvement for seq_buf, especially the heap-allocation
part.

-- 
Kees Cook
