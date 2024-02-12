Return-Path: <linux-kernel+bounces-62206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D4A851D00
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3E81F222D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A29405FE;
	Mon, 12 Feb 2024 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfCBN/+d"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0568845979;
	Mon, 12 Feb 2024 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763306; cv=none; b=OXjJ4p4u9QF7yobNHwDK3dhuW0Axu31fxtkIlkRH58BXkdYb2Z+BMicCsIz7DGClEMLupCb9PBxUR2Xh0lx3fRnaejFG2XfRWeyUBKoM7QUQP7J4xpKxNo4ZV2UPsU0a8+KlsgsxvdiOF9oLRkrDUq0KXWS9vTOhBjCSK/OtEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763306; c=relaxed/simple;
	bh=IUZxD5O+i0w+2p0VZy6m7tm97ghxTlBg1TFydIYZFuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK2y4S9wDab6iw9GFJCbLDe8qajopqI2cmrq8o/V39n6zVK3N0H7uD0tsWlci2mbBWVbtOrh2cghvmXoCWzoF71mdNB4DqeSuTvYPwk+ztAD14sPUh8h5FHdK6vumSSL7RPVX/aDv6xVt6t/j5+Z1RrCuX2KhaoArVv9ZlqsClo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfCBN/+d; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6047a616bfeso31048917b3.3;
        Mon, 12 Feb 2024 10:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707763304; x=1708368104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/xVSDZYaBQvoJYVHKQOA1UWqFuvlWGZY8Hn0s/4Hjc=;
        b=UfCBN/+de6pGEVVX4UAw3pE6TvbXN8GflMIdAicfXcpLK1AjSY8fhgVTO/b/d5h/Ma
         w1VvKspoh0u5BYOM2BrV4F2EZOzA1cU4DP0/J8KjFBE/xI9Coc6N+FUkDvIWlJfWnE2X
         H3X0TfOPr7V3NS0EJNR2X9VHyhbFMf4eke3KydI+ntzle4TjHUzKCyx9gk3Cq3kTXmjr
         mV8tUmO7AYPWi8boBoaz73wVkYzh3V/5KUeEgk5a2ZKDXCbblLFonfYRfOerBoVYQ8sp
         OFNFiWzxmbGCk2Czhb3htOx5S0SmHArlUl2xBmiOch+QKzV/ghUlUTMZtp6ChPCmDFlN
         VaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763304; x=1708368104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/xVSDZYaBQvoJYVHKQOA1UWqFuvlWGZY8Hn0s/4Hjc=;
        b=oTg4FGR5hwYO00zlG1EEb1vkpoiKzRvLWD1eCLrrNuKGI086OAiG6HEBjSs5u+o1I7
         /GK2wwYQbn/wgIShsqnpGcM2/AozvG4tTZcDDECDGl7ezB7AtCBV0lTAzr4S2fkPhg4m
         jRpHyxGMnNHXFfFOko4CC/A8lQ5hyrSmmC6/X/C2BSr4A3+AqKhgIA/Pz4XyPlt2G5bl
         ppOeTZQal5jYjLK6Vc9Fhs9Ul25fg2eB4JyhBuoa18hnIi7CDLq1QNz0tPN+PfUao/CY
         5OQmdHUZeO06plML6uuQ/oTXmA/D3T4v0u0XDo5bK4F46rlIbqldxxw54N4YY4vkna0X
         vjhw==
X-Gm-Message-State: AOJu0YzxjWqSatvFviL2Ek7rlfnQ7/OcmppWQQK8IwCGH6Mb9Ae18baP
	p7xLyLamee03nq+uXuZM5oA33VrdLC3x1GRYDsFwP0XMqmyZCOkk
X-Google-Smtp-Source: AGHT+IE4kEey/v26XmyZnftxIjL7x0I737WxMrnoVxzH/S5xEtgVM/RkCDoIclSFu6yTe+ozzw+42A==
X-Received: by 2002:a05:690c:2884:b0:607:776e:57ca with SMTP id ee4-20020a05690c288400b00607776e57camr1204447ywb.21.1707763303849;
        Mon, 12 Feb 2024 10:41:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUuuzxM51dvMxII/HjtZa/eTstnf+CqE9iMkwt0BDmoRYajZd5C8HSJs3J5N0LP5QFm/7vdiQDiqyHkXGN9k4vYDo69uiLSJ/cmK2+VlE3q1cTCLpG0Pz8fzZn2SxVpeNQ0r2au55xgFSQZH4hklwKs/L2yfpCPchxpsOP9GHzEAmoRaODFZSg825b9/JxA5ZdYKmBY5TlXZUVGq0DutlCcq+sAlfdqpawazDnL/ol/s0DSTeWNdugCAUI8bMCrNrWQa5rA14VcLQwm7gJEoZksNW7YuMPssrEsui2yljM9Xli4eyaInRLWcx+ff4HbcNCANRrxh8cTn9uwHW66lIcrKwaNpmMt7U1uRN9fi0So6QB4kDTC8E/WaNr0s9DMK9xnQNCMf7dRROGL739EOCXo5sk13dFZloOvefb01OTTuKWSvzG3t9gLzeeashNatnd18I1avbfL9hpUCOD6MsIhMVLsJHP2iIJF6yitA==
Received: from localhost ([2601:344:8301:57f0:85b5:dd54:cd99:b])
        by smtp.gmail.com with ESMTPSA id eo3-20020a05690c2c0300b0060764876b24sm411700ywb.123.2024.02.12.10.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:41:43 -0800 (PST)
Date: Mon, 12 Feb 2024 10:41:42 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 RESEND 4/6] bitmap: Introduce bitmap_off()
Message-ID: <ZcpmZh8td8DNFzin@yury-ThinkPad>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
 <20240212075646.19114-5-herve.codina@bootlin.com>
 <ZcplW2mXObOZUtR7@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcplW2mXObOZUtR7@yury-ThinkPad>

On Mon, Feb 12, 2024 at 10:37:18AM -0800, Yury Norov wrote:
> On Mon, Feb 12, 2024 at 08:56:32AM +0100, Herve Codina wrote:
> > The bitmap_onto() function translates one bitmap relative to another but
> > no function are present to perform the reverse translation.
> > 
> > Introduce bitmap_off() to fill this hole.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  include/linux/bitmap.h |  3 +++
> >  lib/bitmap.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index 99451431e4d6..5ecfcbbc91f4 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -65,6 +65,7 @@ struct device;
> >   *  bitmap_remap(dst, src, old, new, nbits)     *dst = map(old, new)(src)
> >   *  bitmap_bitremap(oldbit, old, new, nbits)    newbit = map(old, new)(oldbit)
> >   *  bitmap_onto(dst, orig, relmap, nbits)       *dst = orig relative to relmap
> > + *  bitmap_off(dst, orig, relmap, nbits)        *dst = bitmap_onto() reverse operation
> >   *  bitmap_fold(dst, orig, sz, nbits)           dst bits = orig bits mod sz
> >   *  bitmap_parse(buf, buflen, dst, nbits)       Parse bitmap dst from kernel buf
> >   *  bitmap_parse_user(ubuf, ulen, dst, nbits)   Parse bitmap dst from user buf
> > @@ -208,6 +209,8 @@ int bitmap_bitremap(int oldbit,
> >  		const unsigned long *old, const unsigned long *new, int bits);
> >  void bitmap_onto(unsigned long *dst, const unsigned long *orig,
> >  		const unsigned long *relmap, unsigned int bits);
> > +void bitmap_off(unsigned long *dst, const unsigned long *orig,
> > +		const unsigned long *relmap, unsigned int bits);
> >  void bitmap_fold(unsigned long *dst, const unsigned long *orig,
> >  		unsigned int sz, unsigned int nbits);
> >  
> > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > index 2feccb5047dc..71343967335e 100644
> > --- a/lib/bitmap.c
> > +++ b/lib/bitmap.c
> > @@ -682,6 +682,48 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
> >  }
> >  EXPORT_SYMBOL(bitmap_onto);
> >  
> > +/**
> > + * bitmap_off - revert operation done by bitmap_onto()
> 
> This is definitely a bad name. I've no a better idea, but even
> bitmap_onto_revert() would be better.
> 
> > + *     @dst: resulting translated bitmap
> > + *     @orig: original untranslated bitmap
> > + *     @relmap: bitmap relative to which translated
> > + *     @bits: number of bits in each of these bitmaps
> > + *
> > + * Suppose onto computed using bitmap_onto(onto, src, relmap, n)
> > + * The operation bitmap_off(result, onto, relmap, n) leads to a
> > + * result equal or equivalent to src.
> 
> Agree with Rasmus. This should be well tested.
> 
> > + * The result can be 'equivalent' because bitmap_onto() and
> > + * bitmap_off() are not bijective.
> > + * The result and src values are equivalent in that sense that a
> > + * call to bitmap_onto(onto, src, relmap, n) and a call to
> > + * bitmap_onto(onto, result, relmap, n) will lead to the same onto
> > + * value.
> 
> Did you mean "a call to bitmap_onto(onto, src, relmap, n) and a
> call to bitmap_off(onto, result, relmap, n)"? 
> 
> I think the whole paragraph adds more confusion than explanations.
> If a new function is supposed to revert the result of some other
> function, I'd better focus on testing that it actually reverts as
> advertised, and keep description as brief as possible.
> 
> > + * If either of @orig or @relmap is empty (no set bits), then @dst
> > + * will be returned empty.
> 
> Is this an exception from the 'revert' policy? Doesn't look like that.
> So, what for mentioning this specific case?
> 
> > + * All bits in @dst not set by the above rule are cleared.
> 
> The above rule is about empty @orig and @relmap, not about setting
> bits. What did you mean here?
> 
> > + */
> > +void bitmap_off(unsigned long *dst, const unsigned long *orig,
> > +		const unsigned long *relmap, unsigned int bits)
> > +{
> > +	unsigned int n, m;      /* same meaning as in above comment */
> 
> In the above comment, n means the size of bitmaps, and m is not
> mentioned at all.
> 
> > +	if (dst == orig)        /* following doesn't handle inplace mappings */
> > +		return;
> > +	bitmap_zero(dst, bits);
> 
> Can you add an empty line after 'return'.
> 
> > +	m = 0;
> > +	for_each_set_bit(n, relmap, bits) {
> > +		/* m == bitmap_pos_to_ord(relmap, n, bits) */
> 
> Don't think we need this comment here. If you want to underline that
> m tracks bit order, can you just give it a more explanatory name. For
> example, 'bit_order'.
> 
> > +		if (test_bit(n, orig))
> > +			set_bit(m, dst);
> > +		m++;

Forgot to mention - we need a __set_bit() and __test_bit(), because the
whole function is not atomic. This applies to the bitmap_onto() as
well. Can you please send a patch fixing it for bitmap_onto() in the
next iteration?

> > +	}
> > +}
> > +EXPORT_SYMBOL(bitmap_off);
> > +
> >  #ifdef CONFIG_NUMA
> >  /**
> >   * bitmap_fold - fold larger bitmap into smaller, modulo specified size
> > -- 
> > 2.43.0

