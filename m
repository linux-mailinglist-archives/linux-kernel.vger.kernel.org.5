Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C527BBD29
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjJFQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjJFQqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:46:07 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3850919AE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:44:37 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a24b03e22eso28455507b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696610644; x=1697215444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9qXiQD02jSxmMRUgSkyvEpmCFOZ3iTInzi5BF14OmQ=;
        b=MlNQa+phUCR8A+i4TKwuJyj5q+Al9rlKc0OaEBaTQ1+vKG/rujyCUBN613ahj60O1T
         0jg/wtuw6e2lk0lJ4vTvshpnr9SKI0K/Iypoe883tDs3Jw9RG5MGTQPRo84ifFkuJ4OF
         vHaRV7QtSWEoD1g4BVvqpvn9h2irIXkhPoQ5wRT75vPYsl1Iox6mFIgNWUVEP+vbdqWV
         RYjPofmrXe0dnmSs5JHQMQD0V21kHp20HvdP4PYlzj9YouIPZ12wdrQfLShBJpL3Wrca
         rHe4KwdI9OStRXgGfLyANoibHzriUzQsx/+tLbM2V8oWJM5qqj7h1vhNyUCDH/1h5AWM
         /49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696610644; x=1697215444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9qXiQD02jSxmMRUgSkyvEpmCFOZ3iTInzi5BF14OmQ=;
        b=KeH2Q2NRIfCcAqa6EY2MXxXDoJ2YArHkcp/N7IiNshMQ2ZRumb43yAfu6L/tFe07x7
         ElISWUwB+9RPblhWeCc3Hy98snepm8Whz9q/UkZ7b+SRjaQOzo3/p/L2HwvFJhfxSK0/
         8RqQ0pDBAHv8CJ9eDrLybwwLDzJDiJgcE1S5b7BYshgBD8UXAV2OFTd+IwvGHnNpcmrp
         FVi4KW9pMPfH895nUJl0sgqCDa+V+jShBr1V6aGPqcO+Cg3iv6LvGf4B6Xh/IysLb27t
         Orwmq76RKqLXDaqoudN17YMb5UcuhETV5ap07lh+hBH5LbpMK1df2UU1dXajPA7CJnFR
         uzdg==
X-Gm-Message-State: AOJu0YzmjIXnCVPPbGlGP4OpYJexTu/nngQkLEGxFjbY2F8kOUbS/iSa
        hOzhumzmL4cvatq4SXOsjlvrW7/JcJlWWQ==
X-Google-Smtp-Source: AGHT+IEVlH/Sosq/Sgf9/c1bnatg/z09RORbFjd46bBQ1D1NUgCfWCe6BLGyA8YwDGqrFVihmnSCXA==
X-Received: by 2002:a81:62d7:0:b0:576:fc3a:3ef5 with SMTP id w206-20020a8162d7000000b00576fc3a3ef5mr9105615ywb.47.1696610644125;
        Fri, 06 Oct 2023 09:44:04 -0700 (PDT)
Received: from localhost (76-202-118-196.lightspeed.jcvlfl.sbcglobal.net. [76.202.118.196])
        by smtp.gmail.com with ESMTPSA id r135-20020a0de88d000000b005a1cc37aff1sm1378858ywe.20.2023.10.06.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 09:44:03 -0700 (PDT)
Date:   Fri, 6 Oct 2023 09:44:02 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v5 0/8] bitmap: cleanup bitmap_*_region() implementation
Message-ID: <ZSA5UlF8e7DRxuqp@yury-ThinkPad>
References: <20230925023817.782509-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023817.782509-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Sun, Sep 24, 2023 at 07:38:09PM -0700, Yury Norov wrote:
> bitmap_{allocate,find_free,release}_region() functions are implemented
> on top of _reg_op() machinery. It duplicates existing generic functionality
> with no benefits. In fact, generic alternatives may work even better
> because they optimized for small_const_nbits() case and overall very well
> optimized for performance and code generation.
> 
> This series drops _reg_op() entirely.
> 
> v2: https://lore.kernel.org/lkml/20230811005732.107718-2-yury.norov@gmail.com/T/
> v3: https://lore.kernel.org/lkml/20230815233628.45016-2-yury.norov@gmail.com/T/
> v4: https://lore.kernel.org/lkml/20230829023911.64335-1-yury.norov@gmail.com/T/
> v5: - fix bitmap_release_region() implementation;
>     - address nits for commits comments.
> 
> Yury Norov (8):
>   bitmap: align __reg_op() wrappers with modern coding style
>   bitmap: add test for bitmap_*_region() functions
>   bitmap: fix opencoded bitmap_allocate_region()
>   bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
>   bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
>   bitmap: replace _reg_op(REG_OP_ISFREE) with find_next_bit()
>   bitmap: drop _reg_op() function
>   bitmap: move bitmap_*_region() functions to bitmap.h
> 
>  include/linux/bitmap.h |  63 ++++++++++++++++++-
>  lib/bitmap.c           | 140 -----------------------------------------
>  lib/test_bitmap.c      |  24 +++++++
>  3 files changed, 84 insertions(+), 143 deletions(-)
> 
> -- 
> 2.39.2
