Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451387805DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357170AbjHRG2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358062AbjHRG20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:28:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0725C10C0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:28:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ff9abf18f9so717213e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1692340103; x=1692944903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0YFcn5NgIiAMz1+cp7pg/nNSy+7Fusx4SPkjE7L2z70=;
        b=atag02lcLBGejuN/J52tITP0cad0+IJrmkpQ574vQmlScX5Y0bNMfISD4FSu835R6O
         gVSxFz/qvXR+hnfBYvcFIDLd0D2qwOUK6mcQny3TuLlikStcqa1yuGauyTwYTVZcU727
         VvR6Ls1+lyqaYROHvi3Kxo4+hb5GtrGkKqt+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692340103; x=1692944903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YFcn5NgIiAMz1+cp7pg/nNSy+7Fusx4SPkjE7L2z70=;
        b=KG6y2TAAiZv5Repku26E2wUpoymCskX3feLZshAHVbNUIJnZmTYPq2b7n9FQnCP0gs
         r4gV+oClS/EGFmXMWlR1Qah6ZsSWTTL8l3MWHZU3idIsQ7x4aPPCSs2Lv1Y2g3o6N1Y1
         cK6C+zdHAc2igmnvuc0shXzuQErpby1ssvoIoquxxAJlrE/2nv59VZ4LMYeoNJ2wfpH4
         Q8XzYl3wsMztxp824oi/QwUZsUBQUSB0lo7Hjy5PjgVgHw6HP83qBPsacsAtzqc1fPBT
         /A1cefEa11G7bt4hw5nc3llOetikSWf/oj1ZvIB15j4GvCt7c7fWAiN5HzGxN/k6O32N
         almw==
X-Gm-Message-State: AOJu0YxvgPPcQSzztNkglTYdZmI68ZBfiqQNZIK+sbYo/NJh6UGI4viU
        814WzUMPzpw+6c4iuyW521G7GxBDln5QCEv59dFDkw==
X-Google-Smtp-Source: AGHT+IFlg6snHAv0mgq0MX8xYqANu7Err9yyTx8iOMhmTw7i/hjqyTxfrG76Jx4fTvqGptUGVjHhjg==
X-Received: by 2002:a05:6512:3e02:b0:4ff:745b:4f1f with SMTP id i2-20020a0565123e0200b004ff745b4f1fmr1243862lfv.30.1692340102762;
        Thu, 17 Aug 2023 23:28:22 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v10-20020ac2592a000000b004fe47b88defsm200882lfi.138.2023.08.17.23.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 23:28:22 -0700 (PDT)
Message-ID: <26fc3fb7-eb68-e5ff-ec86-67982734491e@rasmusvillemoes.dk>
Date:   Fri, 18 Aug 2023 08:28:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/2] bitmap: Use constants and macros from bits.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
References: <20230817165453.713353-1-andriy.shevchenko@linux.intel.com>
 <20230817165453.713353-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, da
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230817165453.713353-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 18.54, Andy Shevchenko wrote:
> Use BITS_PER_LONG and BITS_PER_BYTE for BITMAP_MEM_ALIGNMENT.
> Calculate bytes from bits for memcmp() and memset() with BITS_TO_BYTES().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/bitmap.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 1516ff979315..2d5042d1b501 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -354,9 +354,9 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
>  }
>  
>  #ifdef __LITTLE_ENDIAN
> -#define BITMAP_MEM_ALIGNMENT 8
> +#define BITMAP_MEM_ALIGNMENT	BITS_PER_BYTE
>  #else
> -#define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
> +#define BITMAP_MEM_ALIGNMENT	BITS_PER_LONG
>  #endif
>  #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
>  
> @@ -367,7 +367,7 @@ static inline bool bitmap_equal(const unsigned long *src1,
>  		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
>  	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
>  	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
> -		return !memcmp(src1, src2, nbits / 8);
> +		return !memcmp(src1, src2, BITS_TO_BYTES(nbits));

Please no. Currently, I can verify the arithmetic directly. Using such a
"helper" I'd have to know whether it just does /8 or if it's more like
the bitmap_words() thing which rounds up to a whole number of words. And
BITS_PER_BYTE (and similarly CHAR_BITS) really is, IMO, much less
readable than 8.

Rasmus

