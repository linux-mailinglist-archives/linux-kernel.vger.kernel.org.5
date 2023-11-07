Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191397E4D56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbjKGX2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344563AbjKGX2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:28:00 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A6C386F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:25:02 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso5202777b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 15:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699399502; x=1700004302; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XDWMiq/2ClUpNf7l50C4dkGfwlleMPhjaG5SVTFskio=;
        b=ikS1yjgWdwyu16z8b3SL4BXDWJHMxMxujSCWZB5WchgIP5POuH7ZmrLFTEFbjhBaDo
         EJaNijQNZaTz+vzirY1YTThjktCYvHfci3w1zf+UcndDYPVYVrPPAd9Nm+xYTMebfGJn
         UFn+hPbPeuLckcIi9nbTtrxdXkVmVoFh0OjJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699399502; x=1700004302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDWMiq/2ClUpNf7l50C4dkGfwlleMPhjaG5SVTFskio=;
        b=qx2uFwPtMNB4hJ8QlpKy8KZD1tjM6PXniUDafzgX/n8WpXkMpzUuUh7t5jVpJ84bvk
         JH6bX2wij7xfcsGUaCz9kpj1jJ38c831XZ/1weHzBA2yoLgWW/xhFYF22P+C9TLkOWv+
         VcAinCH7ba/nkMWGeXtgrCIZjYXf8bhpSf/SGKm1buDqhEp/hBvwVrzsRl480+BF0KaO
         9bglst1vPNGqf2jx1HTRWHu6Bszn62yBg6/mM7KpTkvsJQynIOzEgt71CoIp9va8yRXI
         KdcM4KJyIFTt9x5iyAzW0dwYLL2eF9SStu1oUi7NlDchslgMs1KWWjNRRQxTMabUDwAp
         GKpA==
X-Gm-Message-State: AOJu0YwUc46gRyw0s0adxSSCaAoJnFuN5pAZ9zqA8mwjaBQTrtAvlIu4
        hySAr94D7AiJ0nUcLjSqxkcfaA==
X-Google-Smtp-Source: AGHT+IHKmeWdNqg8xV4LjBf3dq6jLliKT0Z15hAj2ecHLNWH3B16uFe/4vaumqd744U979GPCfPSTQ==
X-Received: by 2002:a05:6a00:b92:b0:68b:bf33:2957 with SMTP id g18-20020a056a000b9200b0068bbf332957mr126998pfj.22.1699399502232;
        Tue, 07 Nov 2023 15:25:02 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e6-20020a62ee06000000b0068ff267f094sm7692689pfi.158.2023.11.07.15.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 15:25:01 -0800 (PST)
Date:   Tue, 7 Nov 2023 15:25:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
Message-ID: <202311071521.099CAEA58@keescook>
References: <202310170708.fJzLlgDM-lkp@intel.com>
 <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
 <ZUkvOCxyiin_77qd@smile.fi.intel.com>
 <0a29df6b-bc27-43e9-a97d-57ecabb29a9e@intel.com>
 <CAG_fn=VtA6e3oGm4WVnxmy9yMBab780-U_4VoHSqm4tcd2UTzQ@mail.gmail.com>
 <ca0ad357-727b-4f41-a3d6-2c48a9dd5836@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca0ad357-727b-4f41-a3d6-2c48a9dd5836@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 05:44:00PM +0100, Alexander Lobakin wrote:
> From: Alexander Potapenko <glider@google.com>
> Date: Tue, 7 Nov 2023 17:33:56 +0100
> 
> > On Tue, Nov 7, 2023 at 2:23 PM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Date: Mon, 6 Nov 2023 20:23:52 +0200
> >>
> >>> On Mon, Nov 06, 2023 at 05:31:34PM +0100, Alexander Lobakin wrote:
> >>>
> >>>>> | Reported-by: kernel test robot <lkp@intel.com>
> >>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202310170708.fJzLlgDM-lkp@intel.com/
> >>>
> >>>> Not sure how to approach this :z It was also captured on the version you
> >>>> sent 2 weeks ago, so this could've been resolved already.
> >>>
> >>> Is it in the repository already? if so, we should revert it.
> >>> Otherwise you have time to think and fix.
> >>
> >> Nah, neither Alex' series nor mine. And I'd say this should rather be
> >> resolved in the functions Alex introduce.
> >>
> >> Thanks,
> >> Olek
> > 
> > Sorry, I couldn't reproduce the problem using the instructions at
> > https://download.01.org/0day-ci/archive/20231017/202310170708.fJzLlgDM-lkp@intel.com/reproduce
> > locally, maybe that's because I only have gcc-11 and higher.
> > 
> > But if I'm understanding correctly what's going on, then GCC will be
> > reporting the same issue in the following code:
> > 
> > =======================================================
> > #include <stddef.h>
> > #include <stdbool.h>
> > 
> > #define BITS_PER_LONG 64
> > #define unlikely(x) x
> > #define UL(x) (x##UL)
> > #define GENMASK(h, l) \
> >         (((~UL(0)) - (UL(1) << (l)) + 1) & \
> >          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> > 
> > #define BIT_WORD(nr)            ((nr) / BITS_PER_LONG)
> > #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
> > #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> > 
> > inline void bitmap_write(unsigned long *map,
> >                                 unsigned long value,
> >                                 unsigned long start, unsigned long nbits)
> > {
> >         size_t index;
> >         unsigned long offset;
> >         unsigned long space;
> >         unsigned long mask;
> >         bool fit;
> > 
> >         if (unlikely(!nbits))
> >                 return;
> > 
> >         mask = BITMAP_LAST_WORD_MASK(nbits);
> >         value &= mask;
> >         offset = start % BITS_PER_LONG;
> >         space = BITS_PER_LONG - offset;
> >         fit = space >= nbits;
> >         index = BIT_WORD(start);
> > 
> >         map[index] &= (fit ? (~(mask << offset)) :
> > ~BITMAP_FIRST_WORD_MASK(start));
> >         map[index] |= value << offset;
> >         if (fit)
> >                 return;
> > 
> >         map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
> >         map[index + 1] |= (value >> space);
> > }
> > 
> > unsigned long foo(unsigned int n) {
> >     unsigned long bm[1] = {0};
> >     bitmap_write(bm, 1, n, 2);
> >     return bm[0];
> > }
> > =======================================================
> > (see also https://godbolt.org/z/GfGfYje53)
> > 
> > If so, the problem is not specific to GCC 9, trunk GCC also barks on this code:
> > 
> > =======================================================
> > In function 'bitmap_write',
> >     inlined from 'bitmap_write' at <source>:15:13,
> >     inlined from 'foo' at <source>:47:7:
> > <source>:40:12: warning: array subscript 1 is outside array bounds of
> > 'long unsigned int[1]' [-Warray-bounds=]
> >    40 |         map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
> >       |         ~~~^~~~~~~~~~~
> > =======================================================
> > 
> > If this is true for the code in drivers/gpio/gpio-pca953x.c,
> > suppressing the report for GCC 9 won't help for other versions.
> > Given that this report is isolated in a single file, we probably need
> 
> I tested it on GCC 9 using modified make.cross from lkp and it triggers
> on one more file:
> 
> drivers/thermal/intel/intel_soc_dts_iosf.c: In function 'sys_get_curr_temp':
> ./include/linux/bitmap.h:601:18: error: array subscript [1,
> 288230376151711744] is outside array bounds of 'long unsigned int[1]'
> [-Werror=array-bounds]
> 
> > to give the compiler some hints about the range of values passed to
> > bitmap_write() rather than suppressing the optimizations.
> 
> OPTIMIZER_HIDE_VAR() doesn't disable optimizations if I get it
> correctly, rather shuts up the compiler in cases like this one.
> 
> I've been thinking of using __member_size() from fortify-string.h, we
> could probably optimize the object code even a bit more while silencing
> this warning.
> Adding Kees, maybe he'd like to participate in sorting this out as well.

I'm trying to find all the pieces for this code, so I might be working
from the wrong version or something, but I think this is the change:
https://github.com/alobakin/linux/commit/66808fb20fed014a522b868322d54daef14a6bd8

and the induced warning is correctly analyzed in this thread (i.e. GCC
can't convince itself that it'll never reach the out of bounds access).
Does this work?

-	if (fit)
+	if (fit || index + 1 >= __member_size(map))
 		return;


-- 
Kees Cook
