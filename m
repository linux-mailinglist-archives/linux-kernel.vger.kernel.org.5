Return-Path: <linux-kernel+bounces-75470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8474285E923
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8381C2108F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C803C46C;
	Wed, 21 Feb 2024 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rs3Cua4L"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0934A1D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547864; cv=none; b=CT4RTtioVlBiTU9izRPk3MDvOeJHTZzuQgP3KrKtUYSWyFCA2mlExzQTez2pPgnrhempkbtQYxv3ddDPDhqhdnK56MoDV2PdcO7jhICLUr3a11BKvrEKP9vp1X7/tIth/pAcGC3k2vkFMZkCByNpfgyG5sHDBdEdPd3m4RnZQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547864; c=relaxed/simple;
	bh=pD1anHYz7Qvyjwrl3Ul7SA/vuVDFvvq0ON2C3+jQcVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPFs8raW2Srx4odNB+6SuKhWuCJZpAH1XNjLLWHOxZBmI0sJ+rFbetX7lu/4HHP+gi4gpQkZ8RRO2KeEtLFFEIeiHCCK+Xiygd+XLx/rFOyuzC9Cxto8TbsKfYrJKLOIEeK83u/DqURrtx/eXeSivmLwuNxAXEwB8GxDXqARWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rs3Cua4L; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso4773063276.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708547861; x=1709152661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LemITai8o2S9gTBYLEbvTlpnnxm99PXeiUxZksmifiI=;
        b=rs3Cua4LskIupLa1meID+vLP7z0mv9s/WRsVO8KAE+jdYS05qAJn6HzHg/Jm0yaVHK
         NRMrfdjemU5qBvBoKCHTuX0aOCTmuD2FiKHWd3DoALbddOU4X/7SnwiN0TAp6M+oSbIl
         wAJNeKTOaZ0LwqOl7DcC2Imfgm6v5Ie4yhhPoZ6ZZ21RmSuC+ctACT/By85HOma27Cyh
         J9eNMTUdojNuT+g8LXAlCkUr9kPgcxNTg/SvAeX5oTaJTIgwDn03euc/UwVjka1ra74f
         Xe9fxC+/+rDprqbNblDVdrlxmNZf5yZV2SuRii3OVJ1WpibMkes8eY5qm+HaWC2uuShv
         Amng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547861; x=1709152661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LemITai8o2S9gTBYLEbvTlpnnxm99PXeiUxZksmifiI=;
        b=SHzDCjZR8KkjzJDyV/kaLxipInSJ/oNPCvVNX6jBXpVCPGyMs4be4ghu/S7apKtg3E
         09MMyxMSGL7PHcwzCz+gd9JyY60YAdlAvQIMM1gIdjkJx9+Xx4DOQHEWtNMpUDC2T7Zw
         +5IqiueTkYixSg9ctRt9bwd8s3qgdmNs1Qx7YrW2NKE99CwoCrh0zhSboNipEUfil+MT
         oSeHY0xrmBLq1H0xLXP03+1Z5hup7++SC6Jq5FLS8CykLeynsPTAnSovd//fiR5J9S3s
         SaywmJp6ScuhZ5p4gjp9Y6hwR+sE9qMNlSon/2LYp2xKDseEdwG9puAO8xEBCnk03txd
         48ag==
X-Forwarded-Encrypted: i=1; AJvYcCW5QKWDA03E33dHAPUlZDLmgSU9OCp2xpJe+SHp5D7QndJSGE08cv7wvxhldS6bKtdmzRmF1ACm+blKNVBFKU5NdZHDuU4N0yaF68hY
X-Gm-Message-State: AOJu0Yw+nWLsT6i3nm5b70R10zEnLDMurtIbovyU2LFEXCrragaGKLno
	PQ3AY1/oqHsSFPpS560D8j0a9xa6D66b7nmhHh4ECwgw7n46y/LKcshYbZ+aXL44MvPK8cevFX2
	p++0PohpC/tPUsoFSbOc/B0+665ew6+9fTPpzoroQBGNHJkNe8qY=
X-Google-Smtp-Source: AGHT+IFZW2SlpqZKS+bsh9fUf4n7GPXvOVLb2xZm8a4atZsgzNMR1d1NSXbs7oSUZw1hV+0Ouk8g+4nF8tRyZ9kGFUY=
X-Received: by 2002:a5b:d09:0:b0:dc7:4367:2527 with SMTP id
 y9-20020a5b0d09000000b00dc743672527mr420992ybp.49.1708547861221; Wed, 21 Feb
 2024 12:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-2-lucas.demarchi@intel.com> <CAA8EJpprfrtOjNzT6TFhV1n6MXzLdTahanfxcRW4uVjeHaBduA@mail.gmail.com>
In-Reply-To: <CAA8EJpprfrtOjNzT6TFhV1n6MXzLdTahanfxcRW4uVjeHaBduA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 21 Feb 2024 22:37:30 +0200
Message-ID: <CAA8EJpo3X5Ljdf5w8pj+WPQZaqab4mD53VXdAxfLFqsU4mNoPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] bits: introduce fixed-type genmasks
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, intel-xe@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 22:30, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 8 Feb 2024 at 09:45, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> >
> > From: Yury Norov <yury.norov@gmail.com>
> >
> > Generalize __GENMASK() to support different types, and implement
> > fixed-types versions of GENMASK() based on it. The fixed-type version
> > allows more strict checks to the min/max values accepted, which is
> > useful for defining registers like implemented by i915 and xe drivers
> > with their REG_GENMASK*() macros.
> >
> > The strict checks rely on shift-count-overflow compiler check to
> > fail the build if a number outside of the range allowed is passed.
> > Example:
> >
> >         #define FOO_MASK GENMASK_U32(33, 4)
> >
> > will generate a warning like:
> >
> >         ../include/linux/bits.h:41:31: error: left shift count >= width of type [-Werror=shift-count-overflow]
> >            41 |          (((t)~0ULL - ((t)(1) << (l)) + 1) & \
> >               |                               ^~
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > ---
> >  include/linux/bitops.h |  1 -
> >  include/linux/bits.h   | 32 ++++++++++++++++++++++----------
> >  2 files changed, 22 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index 2ba557e067fe..1db50c69cfdb 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -15,7 +15,6 @@
> >  #  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
> >  #endif
> >
> > -#define BITS_PER_TYPE(type)    (sizeof(type) * BITS_PER_BYTE)
> >  #define BITS_TO_LONGS(nr)      __KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
> >  #define BITS_TO_U64(nr)                __KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
> >  #define BITS_TO_U32(nr)                __KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index 7c0cf5031abe..bd56f32de44e 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -6,6 +6,8 @@
> >  #include <vdso/bits.h>
> >  #include <asm/bitsperlong.h>
> >
> > +#define BITS_PER_TYPE(type)    (sizeof(type) * BITS_PER_BYTE)
> > +
> >  #define BIT_MASK(nr)           (UL(1) << ((nr) % BITS_PER_LONG))
> >  #define BIT_WORD(nr)           ((nr) / BITS_PER_LONG)
> >  #define BIT_ULL_MASK(nr)       (ULL(1) << ((nr) % BITS_PER_LONG_LONG))
> > @@ -30,16 +32,26 @@
> >  #define GENMASK_INPUT_CHECK(h, l) 0
> >  #endif
> >
> > -#define __GENMASK(h, l) \
> > -       (((~UL(0)) - (UL(1) << (l)) + 1) & \
> > -        (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> > -#define GENMASK(h, l) \
> > -       (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > +/*
> > + * Generate a mask for the specified type @t. Additional checks are made to
> > + * guarantee the value returned fits in that type, relying on
> > + * shift-count-overflow compiler check to detect incompatible arguments.
> > + * For example, all these create build errors or warnings:
> > + *
> > + * - GENMASK(15, 20): wrong argument order
> > + * - GENMASK(72, 15): doesn't fit unsigned long
> > + * - GENMASK_U32(33, 15): doesn't fit in a u32
> > + */
> > +#define __GENMASK(t, h, l) \
> > +       (GENMASK_INPUT_CHECK(h, l) + \
> > +        (((t)~0ULL - ((t)(1) << (l)) + 1) & \
> > +        ((t)~0ULL >> (BITS_PER_TYPE(t) - 1 - (h)))))
> >
> > -#define __GENMASK_ULL(h, l) \
> > -       (((~ULL(0)) - (ULL(1) << (l)) + 1) & \
> > -        (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> > -#define GENMASK_ULL(h, l) \
> > -       (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> > +#define GENMASK(h, l)          __GENMASK(unsigned long,  h, l)
> > +#define GENMASK_ULL(h, l)      __GENMASK(unsigned long long, h, l)
> > +#define GENMASK_U8(h, l)       __GENMASK(u8,  h, l)
> > +#define GENMASK_U16(h, l)      __GENMASK(u16, h, l)
> > +#define GENMASK_U32(h, l)      __GENMASK(u32, h, l)
> > +#define GENMASK_U64(h, l)      __GENMASK(u64, h, l)
>
> This breaks drm-tip on arm64 architecture:
>

Excuse me, it seems a c&p from gitlab didn't work as expected.

arch/arm64/kernel/entry-fpsimd.S: Assembler messages:
arch/arm64/kernel/entry-fpsimd.S:271: Error: found 'l', expected: ')'
arch/arm64/kernel/entry-fpsimd.S:66:  Info: macro invoked from here
arch/arm64/kernel/entry-fpsimd.S:271: Error: found 'l', expected: ')'
arch/arm64/kernel/entry-fpsimd.S:66:  Info: macro invoked from here
arch/arm64/kernel/entry-fpsimd.S:271: Error: found 'l', expected: ')'
arch/arm64/kernel/entry-fpsimd.S:66:  Info: macro invoked from here
arch/arm64/kernel/entry-fpsimd.S:271: Error: found 'l', expected: ')'
arch/arm64/kernel/entry-fpsimd.S:66:  Info: macro invoked from here
arch/arm64/kernel/entry-fpsimd.S:271: Error: unexpected characters
following instruction at operand 3 -- `bic x2,x1,(0+(((unsigned
long)~0ULL-((unsigned long)(1)<<(0))+1)&((unsigned
long)~0ULL>>((sizeof(unsigned long)*8)-1-(3)))))'
arch/arm64/kernel/entry-fpsimd.S:66:  Info: macro invoked from here
arch/arm64/kernel/entry-fpsimd.S:282: Error: found 'l', expected: ')'
arch/arm64/kernel/entry-fpsimd.S:98:  Info: macro invoked from here
arch/arm64/kernel/entry-fpsimd.S:282: Error: found 'l', expected: ')'
arch/arm64/kernel/entry-fpsimd.S:98:  Info: macro invoked from here
arch/arm64/kernel/entry-fpsimd.S:282: Error: found 'l', expected: ')'
arch/arm64/kernel/entry-fpsimd.S:98:  Info: macro invoked from here
arch/arm64/kernel/entry-fpsimd.S:282: Error: found 'l', expected: ')'
arch/arm64/kernel/entry-fpsimd.S:98:  Info: macro invoked from here
arch/arm64/kernel/entry-fpsimd.S:282: Error: unexpected characters
following instruction at operand 3 -- `bic x2,x1,(0+(((unsigned
long)~0ULL-((unsigned long)(1)<<(0))+1)&((unsigned
long)~0ULL>>((sizeof(unsigned long)*8)-1-(3)))))'
arch/arm64/kernel/entry-fpsimd.S:98:  Info: macro invoked from here
make[4]: *** [scripts/Makefile.build:361:
arch/arm64/kernel/entry-fpsimd.o] Error 1
make[3]: *** [scripts/Makefile.build:481: arch/arm64/kernel] Error 2
make[2]: *** [scripts/Makefile.build:481: arch/arm64] Error 2
make[2]: *** Waiting for unfinished jobs...


-- 
With best wishes
Dmitry

