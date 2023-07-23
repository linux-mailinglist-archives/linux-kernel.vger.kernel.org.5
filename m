Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABE175E2E2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjGWPiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 11:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGWPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:38:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E0C1AD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 08:38:22 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6682909acadso1930810b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690126701; x=1690731501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cmykefcdNhgVGfJdHuYylH/HeDsJaOrk0SIp3sP/JU=;
        b=ov+BpRiYgea8xlcwARUtusVDTtfXt0zC6EKRxm30xUvDkrhLHUSDhTWZZ05ThCkDae
         ueVPCpms5Hz1wArm+Xv97aKJKegOtTzyJbI/bpYtmxV43ZNJit1sBbtq/sOkIIxmXfU4
         VE2pXWsTDWyYyI03oGoNMVaYnN0yhgwRkxFMxq3laR09aOD2oY8A0SAR51lITXOSoc6J
         G5vX21/kavKXM9w0kyEi/Lpw4RODOTLJM8FSL+DAphZWsJQSIWmO1Nc1vpkYliaQLWRF
         DGFO1ksWTWyx2hKOQjOLddkIgZmu/yOzSRzBuPg29DKsBRJ+es4gqP4a1nQbglI6B9/G
         mbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690126701; x=1690731501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cmykefcdNhgVGfJdHuYylH/HeDsJaOrk0SIp3sP/JU=;
        b=UG4T4aEGC9kyzKGRn9rw4ScduM+ht8bc2e05FVIjMgQ8oTeU0I0ZuzEe8Iuesgk11N
         xMiqx/yjW89Q7Ah6+qopz8KymY/2X467hQS8sfSq65gjvoymV2D95RaW6mmPgisdTWFa
         ezeOyvVHLAP6EKjRgy6qP2EItr5zWA7OJD8ffiDOGHZaKhjjh18kYvAgcLbDFPfEWzOZ
         WNSIWMbR8d1mU7Oxr9h+0t8WpYRNjT/6kRxCUTK5hzM7+Ymf1rsxSWNbwVGRPN/G6G9R
         m0SfL3bmCuj7mNdou+r3fyheoEvW5CIourAluHWD7auFhTaXRDPdY5gFHbnuIO2iE432
         wFqQ==
X-Gm-Message-State: ABy/qLaVyr8yaGec/rPgRfXdJATCPrvrDKyaV3ysRn/TKpya9Nnpmewf
        9T0SNXFSeGW1TN9Tehh7ti8=
X-Google-Smtp-Source: APBJJlHmaNVJSFpJcCEb+1BeIjzHHI/5SyteTiblySRF84cv2yj7i9+ib0lbS6DYyJT8mgXgxJdUAw==
X-Received: by 2002:a17:902:bd96:b0:1b1:99c9:8ce1 with SMTP id q22-20020a170902bd9600b001b199c98ce1mr4921708pls.51.1690126701353;
        Sun, 23 Jul 2023 08:38:21 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902989500b001b03842ab78sm7055043plp.89.2023.07.23.08.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 08:38:20 -0700 (PDT)
Date:   Sun, 23 Jul 2023 08:38:18 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZL1JarpwxpsB3fhY@yury-ThinkPad>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-2-glider@google.com>
 <ZLyI+0EL1VztnHLe@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLyI+0EL1VztnHLe@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 06:57:26PM -0700, Yury Norov wrote:
> On Thu, Jul 20, 2023 at 07:39:52PM +0200, Alexander Potapenko wrote:
> > +/**
> > + * bitmap_write - write n-bit value within a memory region
> > + * @map: address to the bitmap memory region
> > + * @value: value of nbits
> > + * @start: bit offset of the n-bit value
> > + * @nbits: size of value in bits, up to BITS_PER_LONG
> > + */
> > +static inline void bitmap_write(unsigned long *map,
> > +				unsigned long value,
> > +				unsigned long start, unsigned long nbits)
> > +{
> > +	size_t index = BIT_WORD(start);
> > +	unsigned long offset = start % BITS_PER_LONG;
> > +	unsigned long space = BITS_PER_LONG - offset;
> > +
> > +	if (unlikely(!nbits))
> > +		return;
> > +	value &= GENMASK(nbits - 1, 0);
> 
> Strictly speaking, a 'value' shouldn't contain set bits beyond nbits
> because otherwise it's an out-of-bonds type of error.
> 
> This is kind of gray zone to me, because it's a caller's responsibility
> to provide correct input. But on the other hand, it would be a great
> headache debugging corrupted bitmaps.
> 
> Now that we've got a single user of the bitmap_write, and even more,
> it's wrapped with a helper, I think it would be reasonable to trim a
> 'value' in the helper, if needed.
> 
> Anyways, the comment must warn about that loudly...

OK. I spent a night with that, and I'm still not sure. Pseudo code
that implements it looks like this:

        for (bit = 0; bit < nbits; bit++)
                assign_bit(start + bit, bitmap, val & BIT(bit));

And it ignores trailing bits. So if we're optimizing this pattern,
we'd ignore these bits just as well...

Either way, whatever we decide, let's stay clear with our intentions
and mention explicitly that tail bits are either must be zero, or
ignored.

Alexander, can you add the snippet above to the comments for the
bitmap_write() and bitmap_read(), as well as in the test? Also, if we
decide to clear tail of the input value, would BITMAP_LAST_WORD_MASK()
generate better code than GENMASK(nbits - 1, 0) does?

Commets are very appreciated.

Thanks,
Yury
