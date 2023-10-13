Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F447C9173
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjJMXo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:44:25 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AC9C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:44:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9e06f058bso16900255ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697240662; x=1697845462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m16elKmpWpc68P/gnYgqcKwJ5UOKKxemZVtL5n1HtMw=;
        b=iRSRlkDy6nibm5lx3s68pXIncuNti2mjv5zVZmFihUCK1HazgsrH1PEeLBWzv8Knfq
         Bd+tCiSjODE6D02iuaKj5DT5EFXpgUYAgdW79efuIwOJz/povXmfHzhsVlLVJOyqGM47
         HmM5AM7nBtoy69aOWMRdZnQ964UEL5A5iNt/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697240662; x=1697845462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m16elKmpWpc68P/gnYgqcKwJ5UOKKxemZVtL5n1HtMw=;
        b=hdxe8FpuX3Qrlx8XHpwINZ3JzBT0PgKmWsfX+FVOjOt14WD/4sWqcWqy53jvwJssdd
         ox9Hr0vNchtCmyHujEZWqZlH4Jjzv3SphglTyOQxiKmsxio7tqmqzghIlowk9OLCSNc8
         5JYcwfUMPTA1y1cEnM5ISV2QjrP9gwS6XSBwv1vJbgpQAUVQ2xYOgagfkEiIiEfzPeyU
         vGHK7PSasgNNmTLA1LULgJGRlujyKj0hZR40sCbQm+vz/eihHOEoGEHi3TfcA5rSi7Qa
         hdpW01b14lBgdDuFgJUAY9MEi+xro1X/k3Tj4rj/CyjBVDgwEGwaplQtvGXv267iDSch
         hU0Q==
X-Gm-Message-State: AOJu0Yy6x2iZFGXoFp9BnhQD29k5EA9epgTn66Wj3z+e/DJr0NLFOpnM
        DM5t+RHviMaiyfMmWvBfgWGs+w==
X-Google-Smtp-Source: AGHT+IHHZCEh0KyaNG5lBNkcjPzUIl4Qu8VPp5RCrEU4Bxp2BkM5PBeuyURnfWsF9t+Xa0r6B2rC5A==
X-Received: by 2002:a17:902:c945:b0:1ca:71:ea41 with SMTP id i5-20020a170902c94500b001ca0071ea41mr2422991pla.22.1697240662526;
        Fri, 13 Oct 2023 16:44:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902f7d500b001b53c8659fesm4423805plw.30.2023.10.13.16.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:44:22 -0700 (PDT)
Date:   Fri, 13 Oct 2023 16:44:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Refactor bkey_i to use a flexible array
Message-ID: <202310131637.D0C66BFBA@keescook>
References: <20231010235609.work.594-kees@kernel.org>
 <ZSkpU0vdrCTfTxuZ@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkpU0vdrCTfTxuZ@bfoster>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 07:26:11AM -0400, Brian Foster wrote:
> On Tue, Oct 10, 2023 at 04:56:12PM -0700, Kees Cook wrote:
> > The memcpy() in bch2_bkey_append_ptr() is operating on an embedded
> > fake flexible array. Instead, make it explicit, and convert the memcpy
> > to target the flexible array instead. Fixes the W=1 warning seen for
> > -Wstringop-overflow:
> > 
> >    In file included from include/linux/string.h:254,
> >                     from include/linux/bitmap.h:11,
> >                     from include/linux/cpumask.h:12,
> >                     from include/linux/smp.h:13,
> >                     from include/linux/lockdep.h:14,
> >                     from include/linux/radix-tree.h:14,
> >                     from include/linux/backing-dev-defs.h:6,
> >                     from fs/bcachefs/bcachefs.h:182:
> >    fs/bcachefs/extents.c: In function 'bch2_bkey_append_ptr':
> >    include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
> >       57 | #define __underlying_memcpy     __builtin_memcpy
> >          |                                 ^
> >    include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
> >      648 |         __underlying_##op(p, q, __fortify_size);                        \
> >          |         ^~~~~~~~~~~~~
> >    include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
> >      693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
> >          |                          ^~~~~~~~~~~~~~~~~~~~
> >    fs/bcachefs/extents.c:235:17: note: in expansion of macro 'memcpy'
> >      235 |                 memcpy((void *) &k->v + bkey_val_bytes(&k->k),
> >          |                 ^~~~~~
> >    fs/bcachefs/bcachefs_format.h:287:33: note: destination object 'v' of size 0
> >      287 |                 struct bch_val  v;
> >          |                                 ^
> > 
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Brian Foster <bfoster@redhat.com>
> > Cc: linux-bcachefs@vger.kernel.org
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202309192314.VBsjiIm5-lkp@intel.com/
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  fs/bcachefs/bcachefs_format.h | 5 ++++-
> >  fs/bcachefs/extents.h         | 2 +-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
> > index f0d130440baa..f5e8cb43697b 100644
> > --- a/fs/bcachefs/bcachefs_format.h
> > +++ b/fs/bcachefs/bcachefs_format.h
> > @@ -300,7 +300,10 @@ struct bkey_i {
> >  	__u64			_data[0];
> >  
> >  	struct bkey	k;
> > -	struct bch_val	v;
> > +	union {
> > +		struct bch_val	v;
> > +		DECLARE_FLEX_ARRAY(__u8, bytes);
> > +	};
> >  };
> 
> Hi Kees,
> 
> I'm curious if this is something that could be buried in bch_val given
> it's already kind of a fake structure..? If not, my only nitty comment

I was thinking it would be best to keep the flexible array has "high" in
the struct as possible, as in the future more refactoring will be needed
to avoid having flex arrays overlap with other members in composite
structures. So instead of pushing into bch_val, I left it at the highest
level possible, bch_i, as that's the struct being used by the memcpy().

Eventually proper unions will be needed instead of overlapping bch_i
with other types, as in:

struct btree_root {
        struct btree            *b;

        /* On disk root - see async splits: */
        __BKEY_PADDED(key, BKEY_BTREE_PTR_VAL_U64s_MAX);
        u8                      level;
        u8                      alive;
        s8                      error;
};

But that's all for the future. Right now I wanted to deal with the more
pressing matter of a 0-sized array not being zero sized. :)

> is that memcpy(k->bytes[], ...) makes it kind of read like we're copying
> in opaque key data rather than value data, so perhaps a slightly more
> descriptive field name would be helpful. But regardless I'd wait until
> Kent has a chance to comment before changing anything..

How about "v_bytes" instead of "bytes"? Or if it really is preferred,
I can move the flex array into bch_val -- it just seems like the wrong
layer...

-Kees

> 
> Brian
> 
> >  
> >  #define KEY(_inode, _offset, _size)					\
> > diff --git a/fs/bcachefs/extents.h b/fs/bcachefs/extents.h
> > index 7ee8d031bb6c..6248e17bbac5 100644
> > --- a/fs/bcachefs/extents.h
> > +++ b/fs/bcachefs/extents.h
> > @@ -642,7 +642,7 @@ static inline void bch2_bkey_append_ptr(struct bkey_i *k, struct bch_extent_ptr
> >  
> >  		ptr.type = 1 << BCH_EXTENT_ENTRY_ptr;
> >  
> > -		memcpy((void *) &k->v + bkey_val_bytes(&k->k),
> > +		memcpy(&k->bytes[bkey_val_bytes(&k->k)],
> >  		       &ptr,
> >  		       sizeof(ptr));
> >  		k->k.u64s++;
> > -- 
> > 2.34.1
> > 
> 

-- 
Kees Cook
