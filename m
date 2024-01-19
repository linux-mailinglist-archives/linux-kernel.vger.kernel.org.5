Return-Path: <linux-kernel+bounces-30699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EE2832337
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44ED1B21CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5860E1367;
	Fri, 19 Jan 2024 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpghMXmo"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42C210E4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629722; cv=none; b=g3lsI7lm8UrEMKwYCaVIXEkE5rnMLeTzO5PU7Yj/1f5C8HFuVUsjA4tK/5zaAK/+y1P+ddXy3Fw0xFcJIEYEUFe9v6wpxPh4yXy+aVl3EuEcbza1+rfeH02a4zR5YNs9Q0tGQ8ngQN6t2etAcqtHT6qRMmbfTDHJW/A8eBcmv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629722; c=relaxed/simple;
	bh=bMPWD4YX9FbZ1LQIuKqwO78aEtj4/0KUNkeG8z6oPqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEDZyTRxSMPUE7OCPo8F8JLsbZMmaFWBTviBUO+Ja5RptRpTmpdpKCsLFQW9VLMt3+liVk3pTRfg3lUKpc2zMSKEWL/RRluDqnjSkAb6aR4UGhlHofw6BaHIeasUBndmIImEFmNIpqBygC9ZNYOu/npUC+W00vqCCc8jHj2QnJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpghMXmo; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc256e97e0aso244504276.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705629720; x=1706234520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UL4ovdZqy7pqFm08qbXwQcz8rBwgeWh/wVxSrYGEaQ=;
        b=QpghMXmolMSY8RgLTYJRE3qaIjmXGCrAObcDdytIMb2dr6NOT2jATqDxndxm9DXre+
         5ggv8K5vxRP1u2x/aolPMqDEGMgKVWKCfPaxXFQkOxS6gqg9o+5OUs4dWmHjmG8T3ny2
         QTLXb5qEnolr1W2cvi9xhrWfl3+8SE6UpppCa2uTwRX15W7A2iH7ikOg8lB3O0UpRmsH
         gDLJ0hZzSpjcJ9r1VwBDPellcn4JhTlwOQy16TcKX+LiAb/mCqvUMSqtZx+z5gqctnt6
         R4KBl9/z6sVIDrG+3Dy677eUVdPMe6mq1sfpYwI+zQhfj0vKuDB5LMX+3041RvkHSqG4
         TIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705629720; x=1706234520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UL4ovdZqy7pqFm08qbXwQcz8rBwgeWh/wVxSrYGEaQ=;
        b=N+rwl0J8+XMwvqYoZFgjTgL2OK+jeyk77IV0gyTVmM8nt5L0k9PDBWE92FawoPpX+r
         7UFHxw/pJOaDyQba/0h6v6vLw4/5naRtq8aaTU8S0AAGJwgo/1b3q6sZZMhcTDwpth21
         Hs4vg6F4/OaK0Ibsn5OrNOzdV45JYPaN86g0GW4yvO24/OxPLu9yV8/UdlKJfiJvxY7d
         lh++1Zbxqtsh6A0ZzeDHFYIuUcfjD2ogBDOVxEvFO/LGYNBEWV2y6szIDBfbC6tQatA9
         3e5qf2mcs5rEYPASYT8fyNFckYFZGXhEqs7O7FnkR08stGpLp/5WBON42cW76Xk03lBI
         c5Yw==
X-Gm-Message-State: AOJu0YzBflNijx28RvK8OAVim7sfsKbMp6I6H05u/Sgi/92DqyIwiAB4
	qrup8jIUMg3iCQiAILXC0yC1YedPH6p7EuNRRKZ9VE30gBBZLnZx
X-Google-Smtp-Source: AGHT+IG7JQ2tL8aWjeUHeYlWG31vdKxDYL0jEF5eQRQ9/uYReJn96n+BQ3e84rd83trDzvtCTtI1+w==
X-Received: by 2002:a25:acc8:0:b0:dc2:1bc4:e06b with SMTP id x8-20020a25acc8000000b00dc21bc4e06bmr1599993ybd.51.1705629719588;
        Thu, 18 Jan 2024 18:01:59 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:b45f:9648:c2e:2e36])
        by smtp.gmail.com with ESMTPSA id n17-20020a259f11000000b00d677aec54ffsm6231517ybq.60.2024.01.18.18.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 18:01:59 -0800 (PST)
Date: Thu, 18 Jan 2024 18:01:58 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	intel-gfx@lists.freedesktop.org,
	Kevin Brodsky <kevin.brodsky@arm.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	intel-xe@lists.freedesktop.org
Subject: Re: Re: Re: [Intel-xe] [PATCH 2/3] linux/bits.h: Add fixed-width
 GENMASK and BIT macros
Message-ID: <ZanYFqS7YrVYQsjB@yury-ThinkPad>
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
 <20230509051403.2748545-3-lucas.demarchi@intel.com>
 <ZJOwC5LIEySpduQJ@yury-ThinkPad>
 <4ezps56sdj7fmr27ivkaqjakv4ex46f5cvmy6oqr3z6gkhiorl@us4qd53jzq34>
 <Zamcu7tts8mqX0b4@yury-ThinkPad>
 <clamvpymzwiehjqd6jhuigymyg5ikxewxyeee2eae4tgzmaz7u@6rposizee3t6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <clamvpymzwiehjqd6jhuigymyg5ikxewxyeee2eae4tgzmaz7u@6rposizee3t6>

On Thu, Jan 18, 2024 at 05:25:00PM -0600, Lucas De Marchi wrote:
> SA2PR11MB4874
> X-OriginatorOrg: intel.com
> Status: RO
> Content-Length: 6257
> Lines: 150
> 
> On Thu, Jan 18, 2024 at 01:48:43PM -0800, Yury Norov wrote:
> > On Thu, Jan 18, 2024 at 02:42:12PM -0600, Lucas De Marchi wrote:
> > > Hi,
> > > 
> > > Reviving this thread as now with xe driver merged we have 2 users for
> > > a fixed-width BIT/GENMASK.
> > 
> > Can you point where and why?
> 
> See users of REG_GENMASK and REG_BIT in drivers/gpu/drm/i915 and
> drivers/gpu/drm/xe. I  think the register definition in the xe shows it
> in a good way:
> 
> 	drivers/gpu/drm/xe/regs/xe_gt_regs.h
> 
> The GPU registers are mostly 32-bit wide. We don't want to accidently do
> something like below (s/30/33/ added for illustration purposes):
> 
> #define LSC_CHICKEN_BIT_0                       XE_REG_MCR(0xe7c8)
> #define   DISABLE_D8_D16_COASLESCE              REG_BIT(33)
> 
> Same thing for GENMASK family of macros and for registers that are 16 or
> 8 bits. See e.g. drivers/gpu/drm/i915/display/intel_cx0_phy_regs.h
> 
> 
> > 
> > > On Wed, Jun 21, 2023 at 07:20:59PM -0700, Yury Norov wrote:
> > > > Hi Lucas, all!
> > > >
> > > > (Thanks, Andy, for pointing to this thread.)
> > > >
> > > > On Mon, May 08, 2023 at 10:14:02PM -0700, Lucas De Marchi wrote:
> > > > > Add GENMASK_U32(), GENMASK_U16() and GENMASK_U8()  macros to create
> > > > > masks for fixed-width types and also the corresponding BIT_U32(),
> > > > > BIT_U16() and BIT_U8().
> > > >
> > > > Can you split BIT() and GENMASK() material to separate patches?
> > > >
> > > > > All of those depend on a new "U" suffix added to the integer constant.
> > > > > Due to naming clashes it's better to call the macro U32. Since C doesn't
> > > > > have a proper suffix for short and char types, the U16 and U18 variants
> > > > > just use U32 with one additional check in the BIT_* macros to make
> > > > > sure the compiler gives an error when the those types overflow.
> > > >
> > > > I feel like I don't understand the sentence...
> > > >
> > > > > The BIT_U16() and BIT_U8() need the help of GENMASK_INPUT_CHECK(),
> > > > > as otherwise they would allow an invalid bit to be passed. Hence
> > > > > implement them in include/linux/bits.h rather than together with
> > > > > the other BIT* variants.
> > > >
> > > > I don't think it's a good way to go because BIT() belongs to a more basic
> > > > level than GENMASK(). Not mentioning possible header dependency issues.
> > > > If you need to test against tighter numeric region, I'd suggest to
> > > > do the same trick as  GENMASK_INPUT_CHECK() does, but in uapi/linux/const.h
> > > > directly. Something like:
> > > >        #define _U8(x)		(CONST_GT(U8_MAX, x) + _AC(x, U))
> > > 
> > > but then make uapi/linux/const.h include linux/build_bug.h?
> > > I was thinking about leaving BIT() define where it is, and add the
> > > fixed-width versions in this header. I was thinking uapi/linux/const.h
> > > was more about allowing the U/ULL suffixes for things shared with asm.
> > 
> > You can't include kernel headers in uapi code. But you can try doing
> > vice-versa: implement or move the pieces you need to share to the
> > uapi/linux/const.h, and use them in the kernel code.
> 
> but in this CONST_GE() should trigger a BUG/static_assert
> on U8_MAX < x. AFAICS that check can't be on the uapi/ side,
> so there's nothing much left to change in uapi/linux/const.h.
> 
> I'd expect drivers to be the primary user of these fixed-width BIT
> variants, hence the proposal to do  in include/linux/bits.h.
> Ssomething like this WIP/untested diff (on top of your previous patch):
> 
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index cb94128171b2..409cd10f7597 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -24,12 +24,16 @@
>  #define GENMASK_INPUT_CHECK(h, l) \
>  	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>  		__is_constexpr((l) > (h)), (l) > (h), 0)))
> +#define BIT_INPUT_CHECK(type, b) \
> +	((BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> +		__is_constexpr(b), (b) >= BITS_PER_TYPE(type), 0))))
>  #else
>  /*
>   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
>   * disable the input check if that is the case.
>   */
>  #define GENMASK_INPUT_CHECK(h, l) 0
> +#define BIT_INPUT_CHECK(type, b) 0
>  #endif
>  #define __GENMASK(t, h, l) \
> @@ -44,4 +48,9 @@
>  #define GENMASK_U32(h, l)	__GENMASK(u32, h, l)
>  #define GENMASK_U64(h, l)	__GENMASK(u64, h, l)
> +#define BIT_U8(b)		(u8)(BIT_INPUT_CHECK(u8, b) + BIT(b))
> +#define BIT_U16(b)		(u16)(BIT_INPUT_CHECK(u16, b) + BIT(b))
> +#define BIT_U32(b)		(u32)(BIT_INPUT_CHECK(u32, b) + BIT(b))
> +#define BIT_U64(b)		(u64)(BIT_INPUT_CHECK(u64, b) + BIT(b))

Can you add some vertical spacing here, like between GENMASK and BIT
blocks?

> +
>  #endif	/* __LINUX_BITS_H */
> 
> > 
> > In the worst case, you can just implement the macro you need in the
> > uapi header, and make it working that way.
> > 
> > Can you confirm that my proposal increases the kernel size? If so, is
> > there any way to fix it? If it doesn't, I'd prefer to use the
> > __GENMASK() approach.
> 
> I agree on continuing with your approach. The bloat-o-meter indeed
> showed almost no difference. `size ....i915.o`  on the other hand
> increased, but then decreased when I replaced our current REG_GENMASK()
> implementation to reuse the new GENMASK_U*()
> 
> 	$ # test-genmask.00: before any change
> 	$ # test-genmask.01: after your patch to GENMASK
> 	$ # test-genmask.01: after converting drivers/gpu/drm/i915/i915_reg_defs.h
> 	    to use the new macros
> 	$ size build64/drivers/gpu/drm/i915/i915.o-test-genmask.*
> 	   text    data     bss     dec     hex filename
> 	4506628  215083    7168 4728879  48282f build64/drivers/gpu/drm/i915/i915.o-test-genmask.00
> 	4511084  215083    7168 4733335  483997 build64/drivers/gpu/drm/i915/i915.o-test-genmask.01
> 	4493292  215083    7168 4715543  47f417 build64/drivers/gpu/drm/i915/i915.o-test-genmask.02
> 
> 	$ ./scripts/bloat-o-meter  build64/drivers/gpu/drm/i915/i915.o-test-genmask.0[01]
> 	add/remove: 0/0 grow/shrink: 2/1 up/down: 4/-5 (-1)
> 	Function                                     old     new   delta
> 	intel_drrs_activate                          399     402      +3
> 	intel_psr_invalidate                         546     547      +1
> 	intel_psr_flush                              880     875      -5
> 	Total: Before=2980530, After=2980529, chg -0.00%
> 
> 	$ ./scripts/bloat-o-meter  build64/drivers/gpu/drm/i915/i915.o-test-genmask.0[12]
> 	add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
> 	Function                                     old     new   delta
> 	Total

OK then. With the above approach, fixed-type BIT() macros look like wrappers
around the plain BIT(), and I think, we can live with that.

Can you  send all the material as a proper series, including my
GENMASK patch, your patch above and a patch that switches your driver
to using the new API? I'll take it then in bitmap-for-next when the
merge window will get closed.

Thanks,
Yury

