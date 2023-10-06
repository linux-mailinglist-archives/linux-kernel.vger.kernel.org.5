Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151F57BBD48
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjJFQyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjJFQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:53:55 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1D4AD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:53:54 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d8164e661abso2526222276.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696611233; x=1697216033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RRHPsvPdMlUlp1HTcO5ss/dErjauxHiRYZDTLP9NQY=;
        b=feUXWsWA7aYZtHc20ZeDmisUNikZhwn7B/sYQG0gtrTB9zu4KQdCFe57nkgr1AUxtj
         C9EHgUrI2YQV7RCLU0PF74sacazpAYF9xDLB4SIKpMCvrsTYBDIMzqpjcZlKfKMlQnrL
         +7k4eAkBdWtYq47JRKXQXAPg4nNKj9MmDrNfrDj3TsOs9nKLJ0WEoG/S31gktbulyhHp
         G5vLwrvphhYvgtn+CiHBMpyZSMRI/aO0nlkaIB7ExRdjAP0kbGNNwEfT1GM6IRQV7tFP
         kCaKhIOXPyzkOYdsAA2ZD6MwL47qnjPGFYkAfyLvSUmVfl07bpeYRxoMyXq0jmLxv7zd
         LUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696611233; x=1697216033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RRHPsvPdMlUlp1HTcO5ss/dErjauxHiRYZDTLP9NQY=;
        b=WpVMqjrKKG1QtfW7WlxPtfdTr6gOSCyz5NLDpN6EqSPcwrC1o3uq8PRSsRG1Ul2uBG
         PC8k2FGauF97c1VFgslEoCyBPfpcTU0bMiGD9qJ3dF91WmIBQRQ7m379uWZ/Uj/a9jKq
         TNxTnpazaLBjIHgvYrSuBiR6kGnoFVz+08pUa1mxzHziN1KksSmaCuyF8yfLjYuqT2LO
         6+AqfpI7nle6Gd9YHHSjSXArbclS1OskytsHO0Y0a3dyMdQlkJWBCxpybggOCqB3jToi
         rn87VOWEvZ/zpJfEa7PkqHP4dq8tUIACet5E6BK1H0QE6AjViF8gN0G6snWnkbHG8WCC
         aH4w==
X-Gm-Message-State: AOJu0YxsXbMqxtY+BQRsC3AVUjd9rCBI5DHO5dvKSKDWI1PoqkQv9ckS
        31guhwKLK6sYHRrgDkMYrn0=
X-Google-Smtp-Source: AGHT+IEENVGdTDMRdiCUd7WaIpDQn16TvgmGMQgvE/IoUwFSER5IRtuhNaX/A0e3QB7cxqjkMN+ghA==
X-Received: by 2002:a25:da8a:0:b0:d81:97c:c01e with SMTP id n132-20020a25da8a000000b00d81097cc01emr8596149ybf.5.1696611232872;
        Fri, 06 Oct 2023 09:53:52 -0700 (PDT)
Received: from localhost (76-202-118-196.lightspeed.jcvlfl.sbcglobal.net. [76.202.118.196])
        by smtp.gmail.com with ESMTPSA id d82-20020a254f55000000b00d728a2738f1sm1159048ybb.61.2023.10.06.09.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 09:53:52 -0700 (PDT)
Date:   Fri, 6 Oct 2023 09:53:51 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 1/5] lib/bitmap: add bitmap_{read,write}()
Message-ID: <ZSA7n44oqBMumlty@yury-ThinkPad>
References: <20231006134529.2816540-1-glider@google.com>
 <20231006134529.2816540-2-glider@google.com>
 <ZSAeFfNOUZIrK3Yk@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSAeFfNOUZIrK3Yk@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 05:47:49PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 06, 2023 at 03:45:25PM +0200, Alexander Potapenko wrote:
> > From: Syed Nayyar Waris <syednwaris@gmail.com>
> > 
> > The two new functions allow reading/writing values of length up to
> > BITS_PER_LONG bits at arbitrary position in the bitmap.
> > 
> > The code was taken from "bitops: Introduce the for_each_set_clump macro"
> > by Syed Nayyar Waris with a number of changes and simplifications:
> >  - instead of using roundup(), which adds an unnecessary dependency
> >    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
> >  - indentation is reduced by not using else-clauses (suggested by
> >    checkpatch for bitmap_get_value());
> >  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
> >    and bitmap_write();
> >  - some redundant computations are omitted.
> 
> ...
> 
> > v6:
> >  - As suggested by Yury Norov, do not require bitmap_read(..., 0) to
> >    return 0.
> 
> Hmm... See below.

 [...]
 
> > +static inline unsigned long bitmap_read(const unsigned long *map,
> > +					unsigned long start,
> > +					unsigned long nbits)
> > +{
> > +	size_t index = BIT_WORD(start);
> > +	unsigned long offset = start % BITS_PER_LONG;
> > +	unsigned long space = BITS_PER_LONG - offset;
> > +	unsigned long value_low, value_high;
> 
> > +	if (unlikely(!nbits))
> > +		return 0;
> 
> Hmm... I didn't get was the comment to add or to remove these checks?

The sentence relates to the test, and the comment that confused you
should to to the 2nd patch.

I.e., bitmap_read(..., 0) is not required to return 0, and it's purely
an implementation details.

> 
> > +	if (space >= nbits)
> > +		return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> 
> And don't you want to replace this GENMASK() as well?

+1

> > +	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> > +	value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> > +	return (value_low >> offset) | (value_high << space);
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
