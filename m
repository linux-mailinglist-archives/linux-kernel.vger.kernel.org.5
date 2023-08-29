Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA6F78C20A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjH2KJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjH2KJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:09:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61084129
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:09:21 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68c0d4cc3a4so2397344b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693303760; x=1693908560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8GC0rrrlusGp8LPXtLXf2qogomPAUP46UX4WK7gGNE=;
        b=HS56xOsTMwIRDdCQyeRICcKGSkDC+c6+qRpbYGtd5Ukj74t622DddQeXreRclow7mp
         j4ksYle9roLDGve0WpxXnU34pNeJjocV63NPdhCRgLP5qUz8qn9U6KxBfI5RdpLkte6P
         rJPMg2/kuiEw952YJj12YnuKswr/lsxOdEWDdGUNpkcdb9CI+Cuq2cuZkHWvGG/S2tuy
         GtjO/yPRmmuYLgAM88MswFsjbUTgMuD3NL4jCBjIEffdSb5vEoK+cIIy7k7WrcL8qKvq
         rKUNpn9z2fYPmPMnhj2+CaXn96R1EkZYN9A7NcP+raSoHBo+hKUFKsCe6tj+MX/H7KSv
         gRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693303760; x=1693908560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8GC0rrrlusGp8LPXtLXf2qogomPAUP46UX4WK7gGNE=;
        b=ZJExfe126bZVVa8RdFYndzvDQc21PngDFDAI2PqyhnXjcCUe1GPJz3G01o4yYRVRC6
         dNOUNH8B5HHxJnh5qasqrSbXjwa7jtLVc1AhvDWIThikdvB8ZHy5Vdg0rO2AbUp+fzcO
         JpVH/XQ+6snOCiOXt2yGG/etAZNDzpsMA4GD944CtHmOa+gxERz5kodQUyWcF8R3otGZ
         /oQFUmu/Ou5hF64hnyFvK9AVVIWx9AdMj3RjoZGQP3MbhUgGALoU+pry5KeFjT1+YwTQ
         Rb7g+RN/FnWmRIx8p0stC9SokskHHzllVBZ31bwLsgpqkOxgAybZUBgsQXdjvK4MPUFm
         SspA==
X-Gm-Message-State: AOJu0Yz7RlU5uWQZ/QaNr1KIDi6516chw26kh7/3cYH213yHLK0nH1Br
        YuKu4MZDawAdXqb5ZHWiRo+fGEvnqNE=
X-Google-Smtp-Source: AGHT+IEUtU2N12930XLF8TKjlScMxVMsqAGtPjJTGYcy/kJF6nmX6uIJKo8lVvo4UmX/bvkf/cG3MQ==
X-Received: by 2002:a05:6a00:2da0:b0:68a:4261:ab7f with SMTP id fb32-20020a056a002da000b0068a4261ab7fmr21279999pfb.31.1693303760256;
        Tue, 29 Aug 2023 03:09:20 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d12-20020a63360c000000b0055b5f206ea2sm8808081pga.39.2023.08.29.03.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 03:09:19 -0700 (PDT)
Date:   Tue, 29 Aug 2023 03:07:07 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 8/8] bitmap: move bitmap_*_region() functions to
 bitmap.h
Message-ID: <ZO3DS4OrKeN78qLU@yury-ThinkPad>
References: <20230829023911.64335-1-yury.norov@gmail.com>
 <20230829023911.64335-9-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829023911.64335-9-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/**
> + * bitmap_release_region - release allocated bitmap region
> + *	@bitmap: array of unsigned longs corresponding to the bitmap
> + *	@pos: beginning of bit region to release
> + *	@order: region size (log base 2 of number of bits) to release
> + *
> + * This is the complement to __bitmap_find_free_region() and releases
> + * the found region (by clearing it in the bitmap).
> + */
> +static inline void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
> +{
> +	bitmap_clear(bitmap, pos, pos + BIT(order));
> +}

This is a leftover after wrong rebase from previous buggy version. It
should be:

        bitmap_clear(bitmap, pos, BIT(order));

Please igonre the patch, I'll resend it shourtly.

Sorry for noise.
