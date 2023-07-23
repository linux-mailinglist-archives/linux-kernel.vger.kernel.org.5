Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E2775DF9B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 03:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGWB53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 21:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWB52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 21:57:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677E91FD7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 18:57:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8b4748fe4so18430345ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 18:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690077447; x=1690682247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6OJA1szbHJT2dTZkEYp229VJOjQYpcsaqtJfcTXaGHw=;
        b=SPvSXlRUArMMM7H0n77+u0MIxjCm0vQfLvSGUieskKSANsRFdURbBL3lB76raHnwu+
         fHmbkGEKmVewVfwXRvSQUtPZ2nzR+esLoi0N50P1mq+gaF/Gk6tgCwrw25HGIYqFY4oB
         9VIu3CMdsQ1WadxBHWCqqt2hyBChrHr4SSpiaD2ooZ698Ia6xwJb4IhEVUwK/vMq4lG9
         kX7FWhibBMldmFN2KHl2sDJaex22YuZhL8oCJ9apwSD0qZ3Ym1a5+ULFbgGBBBduhMSe
         G2GEeQtMts1weJzJmTHApMoKE1Eg5w1RJzwgmPAfD2ZtrB1VZStOK7WM49YG+cDWhn6/
         uYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690077447; x=1690682247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OJA1szbHJT2dTZkEYp229VJOjQYpcsaqtJfcTXaGHw=;
        b=QGuV2S3eJ4fV3d1JMowZ9Mnrf3CKPjeIbKu7FuWUzxYuhlmq/wLzU5TQEpGq8OS0Yq
         /ayCEKxuKRgYpLbX68ccc2vyB9EFPwgHyIhYcu8yEGIbrxnsHyV5Sk63N9d4RT5RTDLg
         jutW+S5KMhX16m9X+aaedwHMeg3DfJLW27vQvGjo//y4mNc3/s6qcNnR3hbKWbHHKWYf
         ViA/8Xc6uhxg+LenVDrp++OAHE175iqSshc6djtMwlN+1L6mb+hFrgcwCX7txsc9qRMf
         /boW8wIpJdZ96kaLuk9AGPiAVbWmwPjU4kuQKkp0rKECz82LDiDPBMUx3YzyIaWF8oHu
         uIvg==
X-Gm-Message-State: ABy/qLbBnnS2DysbWtkP1HYyXYmMFtdwoCoDKwhTV29yPEk9zh9uTDCV
        cK2HbiIZ7FKqYlG+Udu/YsTZumCMZG/Y5Q==
X-Google-Smtp-Source: APBJJlGhAzGcE+2IOC+BjPU/5Vwb4rjWM8XqjTX5uJY2OU0MetPGTmcbrM2iQkJFc8VrJyG5hCZqcQ==
X-Received: by 2002:a17:902:6ac6:b0:1bb:6875:5a73 with SMTP id i6-20020a1709026ac600b001bb68755a73mr4371328plt.2.1690077446732;
        Sat, 22 Jul 2023 18:57:26 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id jk4-20020a170903330400b001b8b6a19bd6sm6048646plb.63.2023.07.22.18.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 18:57:26 -0700 (PDT)
Date:   Sat, 22 Jul 2023 18:57:23 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZLyI+0EL1VztnHLe@yury-ThinkPad>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720173956.3674987-2-glider@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 07:39:52PM +0200, Alexander Potapenko wrote:
> +/**
> + * bitmap_write - write n-bit value within a memory region
> + * @map: address to the bitmap memory region
> + * @value: value of nbits
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits, up to BITS_PER_LONG
> + */
> +static inline void bitmap_write(unsigned long *map,
> +				unsigned long value,
> +				unsigned long start, unsigned long nbits)
> +{
> +	size_t index = BIT_WORD(start);
> +	unsigned long offset = start % BITS_PER_LONG;
> +	unsigned long space = BITS_PER_LONG - offset;
> +
> +	if (unlikely(!nbits))
> +		return;
> +	value &= GENMASK(nbits - 1, 0);

Strictly speaking, a 'value' shouldn't contain set bits beyond nbits
because otherwise it's an out-of-bonds type of error.

This is kind of gray zone to me, because it's a caller's responsibility
to provide correct input. But on the other hand, it would be a great
headache debugging corrupted bitmaps.

Now that we've got a single user of the bitmap_write, and even more,
it's wrapped with a helper, I think it would be reasonable to trim a
'value' in the helper, if needed.

Anyways, the comment must warn about that loudly...

> +	if (space >= nbits) {
> +		map[index] &= ~(GENMASK(nbits - 1, 0) << offset);

'GENMASK(nbits - 1, 0) << offset' looks really silly.

> +		map[index] |= value << offset;

Here you commit 2 reads and 2 writes for a word instead of one.

> +		return;
> +	}
> +	map[index] &= ~BITMAP_FIRST_WORD_MASK(start);

~FIRST_WORD is the same as LAST WORD. I tried to replace, and it saves
~25 bytes of .text on x86_64.

> +	map[index] |= value << offset;
> +	map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> +	map[index + 1] |= (value >> space);
> +}

With all that I think the implementation should look something like
this:

        unsigned long w, mask;

        if (unlikely(nbits == 0))
                return 0;

        map += BIT_WORD(start);
        start %= BITS_PER_LONG;
        end = start + nbits - 1;

        w = *map & (end < BITS_PER_LONG ? ~GENMASK(end, start) : BITMAP_LAST_WORD_MASK(start));
        *map = w | (value << start);

        if (end < BITS_PER_LONG)
                return;

        w = *++map & BITMAP_FIRST_WORD_MASK(end);
        *map = w | (value >> BITS_PER_LONG * 2 - end);

It's not tested, except the /s/~FIRST_WORD/LAST_WORD/ part, but I expect
it should be more efficient.

Alexander, can you please try the above and compare?

In previous iteration, I asked you to share disassembly listings for the
functions. Can you please do that now?

Regarding the rest of the series:
 - I still see Evgenii's name in mtecomp.c, and EA0 references;
 - git-am throws warning about trailing line;
 - checkpatch warns 7 times;

Can you fix all the above before sending the new version?

Have you tested generic part against BE32, BE64 and LE32 architectures;
and arch part against BE64? If not, please do.

You're mentioning that the compression ratio is 2 to 20x. Can you
share the absolute numbers? If it's 1k vs 2k, I think most people
just don't care...

Can you share the code that you used to measure the compression ratio?
Would it make sense to export the numbers via sysfs?

Thanks,
Yury
