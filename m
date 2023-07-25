Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB8B7608FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGYFEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGYFEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:04:39 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519F210F6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:04:38 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-348c62db335so11514615ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690261477; x=1690866277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVslJkVhhPHT+yMOLAi97A/B19Ed0JkmeSyU1/87Zew=;
        b=LeF8ZOkPZfKXU1YDm6y069PfmiOw25aDOBl9wEi0O6JOXGnpd5OWmKr8jW5HzGqOgs
         zlCouop+w5iBba2yFhZN6ogEMTwK2iBZr64Y715W+azBrkDRdvtqkYPIxafaYRvfclGu
         Ob+OiV7cpHuOJNsAK/7pRev532JfVumw0xdV4JEklzZWYgEUa8nOuub8fke5N1dCGIC/
         13rsXlnJYgdP7cAEhnDb4NYzC/MxBHTKd5Fl7MrYkHPICAVm084wjkkUM7LatlNrIhC/
         KJib8YH2tbY4Jmjt0cRskcgkHxReLGUuovfeR6Xpp68PsmjMnImUDxXoexs3/sD36cSv
         78Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690261477; x=1690866277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVslJkVhhPHT+yMOLAi97A/B19Ed0JkmeSyU1/87Zew=;
        b=ibk/MNsjW2k0l2nUiWo5H8S+t67E2LhdsON56bHQ+QtqRgbyxIthZameFPF/bKAZiX
         M2poF5OYD5f6aWJz2oJGgpjfgkdU9hSLmSKov6zFC2yektPOmC6cblkGMNzi4pPOovw1
         q+K1g4Q+9NxR8BKTzCdZleWdNtS66oUL9tOVMwUhO0zstvcSQ8L9qDWHf4lq/XvYW31G
         AmjVsvTv8DOvSV9TrQnEfapjQQByTrR1cAlP/6MlVYU0uwo7unG3DIzTikp5AOf7t+oy
         fRDhWK3OleRUHaPskjQF+9m2jSxyRm3xqmNaAKjiX1i9s70UUa0LpV1KdxtO6Q/7uCsB
         KelA==
X-Gm-Message-State: ABy/qLbxTojisiPoaEVEr+OyWLsVFpRLeEZhjnIHszVAaGF7FHALfQqX
        qs6rPe2Y7DwGWS7Yw+ozdcEHRTo0RE87IQ==
X-Google-Smtp-Source: APBJJlEUSg373VkiGklwZ+hrHTv7QkNTUpHuCZyK8/AvCy04rEmGLTRTpulphGvVlwKlMZ17uzxG6A==
X-Received: by 2002:a05:6e02:2190:b0:348:8b42:47c with SMTP id j16-20020a056e02219000b003488b42047cmr2089788ila.17.1690261477523;
        Mon, 24 Jul 2023 22:04:37 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id b26-20020a63a11a000000b00563962dbc70sm5932675pgf.58.2023.07.24.22.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 22:04:36 -0700 (PDT)
Date:   Mon, 24 Jul 2023 22:04:34 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZL9X0TZb/QhCbEiC@yury-ThinkPad>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-2-glider@google.com>
 <ZLyI+0EL1VztnHLe@yury-ThinkPad>
 <ZL44FFAkG8pKS1lv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL44FFAkG8pKS1lv@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:36:36AM +0300, Andy Shevchenko wrote:
> On Sat, Jul 22, 2023 at 06:57:23PM -0700, Yury Norov wrote:
> > On Thu, Jul 20, 2023 at 07:39:52PM +0200, Alexander Potapenko wrote:
> 
> > > +		map[index] &= ~(GENMASK(nbits - 1, 0) << offset);
> > 
> > 'GENMASK(nbits - 1, 0) << offset' looks really silly.
> 
> But you followed the thread to get a clue why it's written in this form, right?

Yes, I did. But I don't expect everyone looking at kernel code would spend
time recovering discussions that explain why that happened. So, at least it
would be fine to drop a comment.
 
> ...
> 
> > With all that I think the implementation should look something like
> > this:
> 
> I would go this way if and only if the code generation on main architectures
> with both GCC and clang is better.
> 
> And maybe even some performance tests need to be provided.

For the following implementation:

  void my_bitmap_write(unsigned long *map, unsigned long value,
                                 unsigned long start, unsigned long nbits)
  {
          unsigned long w, end;
  
          if (unlikely(nbits == 0))
                  return;
  
          value &= GENMASK(nbits - 1, 0);
  
          map += BIT_WORD(start);
          start %= BITS_PER_LONG;
          end = start + nbits - 1;
  
          w = *map & (end < BITS_PER_LONG ? ~GENMASK(end, start) : BITMAP_LAST_WORD_MASK(start));
          *map = w | (value << start);
  
          if (end < BITS_PER_LONG)
                  return;
  
          w = *++map & BITMAP_LAST_WORD_MASK(end + 1 - BITS_PER_LONG);
          *map = w | (value >> (BITS_PER_LONG - start));
  }

This is the bloat-o-meter output:

$ scripts/bloat-o-meter lib/test_bitmap.o.orig lib/test_bitmap.o
add/remove: 8/0 grow/shrink: 1/0 up/down: 2851/0 (2851)
Function                                     old     new   delta
test_bitmap_init                            3846    5484   +1638
test_bitmap_write_perf                         -     401    +401
bitmap_write                                   -     271    +271
my_bitmap_write                                -     248    +248
bitmap_read                                    -     229    +229
__pfx_test_bitmap_write_perf                   -      16     +16
__pfx_my_bitmap_write                          -      16     +16
__pfx_bitmap_write                             -      16     +16
__pfx_bitmap_read                              -      16     +16
Total: Before=36964, After=39815, chg +7.71%

And this is the performance test:

        for (cnt = 0; cnt < 5; cnt++) {
                time = ktime_get();
                for (nbits = 1; nbits <= BITS_PER_LONG; nbits++) {
                        for (i = 0; i < 1000; i++) {
                                if (i + nbits > 1000)
                                        break;
                                bitmap_write(bmap, val, i, nbits);
                        }
                }
                time = ktime_get() - time;
                pr_err("bitmap_write:\t%llu\t", time);

                time = ktime_get();
                for (nbits = 1; nbits <= BITS_PER_LONG; nbits++) {
                        for (i = 0; i < 1000; i++) {
                                if (i + nbits > 1000)
                                        break;
                                my_bitmap_write(bmap, val, i, nbits);
                        }
                }
                time = ktime_get() - time;
                pr_cont("%llu\n", time);
        }

Which on x86_64/kvm with GCC gives:
                                                Orig    My
[    1.630731] test_bitmap: bitmap_write:	299092	252764
[    1.631584] test_bitmap: bitmap_write:	299522	252554
[    1.632429] test_bitmap: bitmap_write:	299171	258665
[    1.633280] test_bitmap: bitmap_write:	299241	252794
[    1.634133] test_bitmap: bitmap_write:	306716	252934

So, it's ~15% difference in performance and 8% in size.

I don't insist on my implementation, but I think, we'd experiment for more
with code generation.

Thanks,
Yury
