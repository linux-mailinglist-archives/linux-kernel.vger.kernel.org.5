Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74A178BC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjH2BVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjH2BUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:20:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9CD13D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:20:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc0d39b52cso22435285ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693272049; x=1693876849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJCu4uYFgQErzALy8QM9McVHvVIbD6NirUXXndNGgMg=;
        b=YDnQYB1rmEPCEmcisq/3IyPYSrnWQVNbJu7bE0sEfawHNcIPJRGNb4M5TaCjsZa4nF
         FiTuAePz90iL8oe96taj1iunxl8c4zRxTiM9PYoX5dBKreAd5maqAUN1Hoc04Msod6Wd
         StWGRUJDhEOzBXJOpAcVmbPIVaH2CzQE5MVgvuBOmIB6Uy0RnRQrkeiJHBhhNhe/79Uw
         HgAnC+9LeAT8HM45sSRMBg1isq27PdvHY0cbIyb44ARiDreE/MitIonJvTK+qcmVV6kM
         cQcCVoiAvHSqYknbewSRYjnrRDw4Ar7j0zELYuccMeutpJQkEoKzzHnA3Zu3R2N3I+jy
         c1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693272049; x=1693876849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJCu4uYFgQErzALy8QM9McVHvVIbD6NirUXXndNGgMg=;
        b=IeVY4shk+SfXxB+lp0Tv1biGaTfWfjs8n56UTUeJbhRuI3mLERNf70uoQO93nSb9yk
         OXpZEUwBb0YS8+8eu9FCk2/cMnhvN6AtSVnRE/8OESJIgb13Fw/K8H1zXeoQs56C/FnC
         qCLBrPOdwzW7F6tAJht/iA0JX7EtFRqn6sjYsbmNxG0t/buLUW+sXGnSWj9HYQ1KbEcZ
         CbsC1VCCCkH0ThCtmF1zPEhaz+AqqPFYWpExXKsXjCRNED07tUDRYoS+olGTIgfItqW5
         WJZl1rY/XIlssNxsP2SLs0hDGaiuCeHh6uD1n5qe7uvYHjgFNxmONqx1+YE44mH+Jj1c
         HeGg==
X-Gm-Message-State: AOJu0Yyv98rZDzHES0777aPFO8JHEoVWgLqyE6HifMTN4t/8hK3+f8ve
        yutPL3zfy09/RZ06IlGu6GuJxbf1JCs=
X-Google-Smtp-Source: AGHT+IH6BUZDgEUxxgCxGU0lSz9+HDpByHzVVGbQ6MIjWJcPElwMlP9zHxnOD2yjucLy/e7Z/zRYaA==
X-Received: by 2002:a17:902:cec5:b0:1c1:d934:26b4 with SMTP id d5-20020a170902cec500b001c1d93426b4mr5347564plg.66.1693272048624;
        Mon, 28 Aug 2023 18:20:48 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id jd22-20020a170903261600b001bdd51748f8sm8008368plb.271.2023.08.28.18.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 18:20:47 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:18:35 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] bitmap: Remove dead code, i.e. bitmap_copy_le()
Message-ID: <ZO0gh2aj9Nrr/jIC@yury-ThinkPad>
References: <20230817162054.567617-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817162054.567617-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 07:20:54PM +0300, Andy Shevchenko wrote:
> Besides the fact it's not used anywhere it should be implemented
> differently, i.e. via helpers from linux/byteorder/generic.h.
> Yet the helpers themselves need to be introduced first.
> 
> Also note, the function lacks of the test cases, they must be provided.
> 
> Hence, drop the current dead code for good.
 
It was added in 2008 for UWB subsystem, removed in 2019 by Greg with a note
that UWB an obsolete; and bitmap_copy_le() looks like a leftover. So I think
you're right, it's worth to drop it.

I'll add the patch in the next pull request.

Thanks,
Yury

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/bitmap.h |  5 -----
>  lib/bitmap.c           | 23 -----------------------
>  2 files changed, 28 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 03644237e1ef..1516ff979315 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -220,11 +220,6 @@ int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
>  void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order);
>  int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order);
>  
> -#ifdef __BIG_ENDIAN
> -void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int nbits);
> -#else
> -#define bitmap_copy_le bitmap_copy
> -#endif
>  int bitmap_print_to_pagebuf(bool list, char *buf,
>  				   const unsigned long *maskp, int nmaskbits);
>  
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 24284caadbcc..935e0f96e785 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -1360,29 +1360,6 @@ int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
>  }
>  EXPORT_SYMBOL(bitmap_allocate_region);
>  
> -/**
> - * bitmap_copy_le - copy a bitmap, putting the bits into little-endian order.
> - * @dst:   destination buffer
> - * @src:   bitmap to copy
> - * @nbits: number of bits in the bitmap
> - *
> - * Require nbits % BITS_PER_LONG == 0.
> - */
> -#ifdef __BIG_ENDIAN
> -void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int nbits)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < nbits/BITS_PER_LONG; i++) {
> -		if (BITS_PER_LONG == 64)
> -			dst[i] = cpu_to_le64(src[i]);
> -		else
> -			dst[i] = cpu_to_le32(src[i]);
> -	}
> -}
> -EXPORT_SYMBOL(bitmap_copy_le);
> -#endif
> -
>  unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
>  {
>  	return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long),
> -- 
> 2.40.0.1.gaa8946217a0b
