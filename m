Return-Path: <linux-kernel+bounces-168325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33798BB679
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10551C23F83
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926F537E9;
	Fri,  3 May 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI83HER3"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7B1EB21
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773363; cv=none; b=lyY9p1D0qCuyyJBJyqqyKieX3Uwxlh9Ccoa7+0gvYVpACPcWzMTW3enl8+4coCoWxxR+9yaTyuip42h4srgFaBA3t2kj2sq8lEgg6ZvhJdYgRmEetAvmvpdmhBdbdoJjPYzSmH8AApcpv85nuVeAJtA2CnJVjpR8hN608IduU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773363; c=relaxed/simple;
	bh=7PmDSLqNTmADxMxVOZenNXI5wqituSMPcFCl0oR7ZrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJCvxsIHNigZtK6A3ADrg2Uu8R54Vpzf4ZHFUStO5aV3ckG/SIyUlpNSAuCrEWPsTQthunkYRr9BpQuBYooA50gf33deVQOAKmGmQXssrjoK2bSg1WnoQoINlMsC08CjL+HAWMsbTuejIboSjI0RfYRdqgsCjCo1yBmFNQFSCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI83HER3; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62027fcf9b1so1417867b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714773361; x=1715378161; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JNv+Ds7CjHFQHYfPpJwMB8NKq/3+fB1NA+taSkrcqck=;
        b=mI83HER3R1NoEvlUNSYKGeHVBohIy3Ch3mkHtCfrDxIi6pl/cM33SbTQKGGGgQQRU7
         cEY1GS0qdvFwHIwTzAg9HFhzTmF79o88XV00xy3b8Eh3DU+t85slZ/A5BWsqdMHjyWX+
         05P1dRUMVTWQ9MppP8ZMMurBoIZPRjh+T8MRooLLZhnRXZlbbBVD6J55+8jYKswXYLXd
         zkuuqTuvc3SMjLRPlLvudNRroh5S5m9gObblkGabxE0dJvsETTq9gMv82LsCANvp2D2z
         kuDYLAlygIq3Y3qqtqnNDEUhFDsVPBbawbMj66av/WjXtuTPzF4hU+WeiN3PnffHsrZz
         dJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714773361; x=1715378161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNv+Ds7CjHFQHYfPpJwMB8NKq/3+fB1NA+taSkrcqck=;
        b=Q/qF3HRbILYgryBsuDK9YkRzl0zVyTekcH2r9E4f81DSNN30jxXc5fYikZaWpHFXSn
         KngAp2NG3hU+dRrD2oLdLtwYK7pUfgJ0Yv4g2DGFLeHfUPx4ofk+v/mGLHiBcsL2hPvI
         fS0cY0qNRxf9abxrJXiyD1XgFCE2M97+I+H/fWI6cGlgGsGDskWuNrW+tvgUM40ntj04
         0dh3S3wdzKMqEwKYfMarC8xSggaE7ySgSNs44tvrAu8DqQlOmBetXFcFyDzQ0XBWziRr
         TqTwOqJKa9D52YDeHM/DNTHalJ0ovgvzqRQvsDNbIk5q/gOPHtUBU2nAorLWNfSv3Wd7
         L5+w==
X-Forwarded-Encrypted: i=1; AJvYcCW/l08K9vQUk5SQ6a9XE5YP8py4DQGsr4QlvEkjdhwwHtBHrXYQ2Gm9yX4nPWlq4bWwhFULtKUyl5+j6r5i/RKPYc+TsaPCjoLCYMqO
X-Gm-Message-State: AOJu0YwT04wH8js7sot6WBF3GHS3xmuXyWnkk0pdIHvMxCmhvGsHiv2P
	kEvRIFLZEhGDA1VprSkZTZdNpiHG9a2v/4Z84RavoExa4Cn99aSx
X-Google-Smtp-Source: AGHT+IFj/cJXpOBouPvi3qUuqUMd2VVlAeMkkwx/KGMwWtQvUA3Lorb1JkiFvDWOw3PBH7ik8rbFTQ==
X-Received: by 2002:a0d:d710:0:b0:61b:e2e7:a501 with SMTP id z16-20020a0dd710000000b0061be2e7a501mr4502864ywd.14.1714773361018;
        Fri, 03 May 2024 14:56:01 -0700 (PDT)
Received: from localhost ([2607:fb91:18c0:1dd9:5656:2a64:c011:fb02])
        by smtp.gmail.com with ESMTPSA id jx15-20020a05690c380f00b0061be527b869sm846480ywb.19.2024.05.03.14.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:56:00 -0700 (PDT)
Date: Fri, 3 May 2024 14:55:57 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, kernel test robot <lkp@intel.com>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] lib/test_bitops: Add benchmark test for fns()
Message-ID: <ZjVdbavKgDo8a0CZ@yury-ThinkPad>
References: <20240502092443.6845-2-visitorckw@gmail.com>
 <202405030808.UsoMKFNP-lkp@intel.com>
 <ZjQ/JOpcdgWZXo0y@visitorckw-System-Product-Name>
 <20240503041701.GA3660305@thelio-3990X>
 <ZjSSylciH+qJeEEG@visitorckw-System-Product-Name>
 <ZjSUk4vgsQ63wfcn@visitorckw-System-Product-Name>
 <20240503155401.GA3960118@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503155401.GA3960118@thelio-3990X>

On Fri, May 03, 2024 at 08:54:01AM -0700, Nathan Chancellor wrote:
> On Fri, May 03, 2024 at 03:38:59PM +0800, Kuan-Wei Chiu wrote:
> > On Fri, May 03, 2024 at 03:31:26PM +0800, Kuan-Wei Chiu wrote:
> > > On Thu, May 02, 2024 at 09:17:01PM -0700, Nathan Chancellor wrote:
> > > > Hi Kuan-Wei,
> > > > 
> > > > On Fri, May 03, 2024 at 09:34:28AM +0800, Kuan-Wei Chiu wrote:
> > > > > On Fri, May 03, 2024 at 08:49:00AM +0800, kernel test robot wrote:
> > > > > > Hi Kuan-Wei,
> > > > > > 
> > > > > > kernel test robot noticed the following build errors:
> > > > > > 
> > > > > > [auto build test ERROR on linus/master]
> > > > > > [also build test ERROR on v6.9-rc6 next-20240502]
> > > > > > [cannot apply to akpm-mm/mm-everything akpm-mm/mm-nonmm-unstable]
> > > > > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > > > > And when submitting patch, we suggest to use '--base' as documented in
> > > > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > > > > 
> > > > > > url:    https://github.com/intel-lab-lkp/linux/commits/Kuan-Wei-Chiu/lib-test_bitops-Add-benchmark-test-for-fns/20240502-172638
> > > > > > base:   linus/master
> > > > > > patch link:    https://lore.kernel.org/r/20240502092443.6845-2-visitorckw%40gmail.com
> > > > > > patch subject: [PATCH v5 1/2] lib/test_bitops: Add benchmark test for fns()
> > > > > > config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240503/202405030808.UsoMKFNP-lkp@intel.com/config)
> > > > > > compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
> > > > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405030808.UsoMKFNP-lkp@intel.com/reproduce)
> > > > > > 
> > > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > > the same patch/commit), kindly add following tags
> > > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202405030808.UsoMKFNP-lkp@intel.com/
> > > > > > 
> > > > > > All errors (new ones prefixed by >>):
> > > > > > 
> > > > > > >> lib/test_bitops.c:56:39: error: variable 'tmp' set but not used [-Werror,-Wunused-but-set-variable]
> > > > > >       56 |         static volatile __used unsigned long tmp __initdata;
> > > > > >          |                                              ^
> > > > > >    1 error generated.
> > > > > > 
> > > > > > 
> > > > > > vim +/tmp +56 lib/test_bitops.c
> > > > > > 
> > > > > >     52	
> > > > > >     53	static int __init test_fns(void)
> > > > > >     54	{
> > > > > >     55		static unsigned long buf[10000] __initdata;
> > > > > >   > 56		static volatile __used unsigned long tmp __initdata;
> > > > > 
> > > > > I apologize for causing the compilation failure with clang. I'm not
> > > > > very familiar with clang and I'm not sure why something marked as
> > > > > __used would result in the warning mentioned above. Perhaps clang does
> > > > > not support attribute((used))? Is there a way to work around this
> > > > > issue?
> > > > 
> > > > It looks like __attribute__((__used__)) is not enough to stop clang from
> > > > warning, unlike GCC. I can likely fix that in clang if it is acceptable
> > > > to the clang maintainers (although more below on why this might be
> > > > intentional) but the warning will still need to be resolved for older
> > > > versions. Looking at the current clang source code and tests, it looks
> > > > like __attribute__((__unused__)) should silence the warning, which the
> > > > kernel has available as __always_unused or __maybe_unused, depending on
> > > > the context.
> > > > 
> > > > $ cat test.c
> > > > void foo(void)
> > > > {
> > > >         int a;
> > > >         a = 1;
> > > > }
> > > > 
> > > > void bar(void)
> > > > {
> > > >         static int b;
> > > >         b = 2;
> > > > }
> > > > 
> > > > void baz(void)
> > > > {
> > > >         static int c __attribute__((__used__));
> > > >         c = 3;
> > > > }
> > > > 
> > > > void quux(void)
> > > > {
> > > >         static int d __attribute__((__unused__));
> > > >         d = 4;
> > > > }
> > > > 
> > > > void foobar(void)
> > > > {
> > > >         static int e __attribute__((__used__)) __attribute__((__unused__));
> > > >         e = 1;
> > > > }
> > > > 
> > > > $ gcc -Wunused-but-set-variable -c -o /dev/null test.c
> > > > test.c: In function ‘foo’:
> > > > test.c:3:13: warning: variable ‘a’ set but not used [-Wunused-but-set-variable]
> > > >     3 |         int a;
> > > >       |             ^
> > > > test.c: In function ‘bar’:
> > > > test.c:9:20: warning: variable ‘b’ set but not used [-Wunused-but-set-variable]
> > > >     9 |         static int b;
> > > >       |                    ^
> > > > 
> > > > $ clang -fsyntax-only -Wunused-but-set-variable test.c
> > > > test.c:3:6: warning: variable 'a' set but not used [-Wunused-but-set-variable]
> > > >     3 |         int a;
> > > >       |             ^
> > > > test.c:9:13: warning: variable 'b' set but not used [-Wunused-but-set-variable]
> > > >     9 |         static int b;
> > > >       |                    ^
> > > > test.c:15:13: warning: variable 'c' set but not used [-Wunused-but-set-variable]
> > > >    15 |         static int c __attribute__((__used__));
> > > >       |                    ^
> > > > 3 warnings generated.
> > > > 
> > > > I've attached a diff below that resolves the warning for me and it has
> > > > no code generation differences based on objdump. While having used and
> > > > unused attributes together might look unusual, reading the GCC attribute
> > > > manual makes it seem like these attributes fulfill similar yet different
> > > > roles, __unused__ prevents any unused warnings while __used__ forces the
> > > > variable to be emitted:
> > > > 
> > > > https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Common-Variable-Attributes.html#index-unused-variable-attribute
> > > > 
> > > > A strict reading of that does not make it seem like __used__ implies
> > > > disabling unused warnings, so I can understand why clang's behavior is
> > > > the way that it is.
> > > > 
> > > Thank you for your explanation and providing the solution. I tested the
> > > diff stat you provided, and it works well for me.
> > > 
> > Should I submit an updated version of the patch to the bitmap
> > maintainer, or should this be a separate patch since the patch causing
> > build failure has already been accepted? My instinct is the latter, but
> > I'm concerned it might make git bisection more challenging.
> 
> Yury would be the best person to answer these questions since each
> maintainer is different, some never rebase their trees while others will
> squash simple fixes in to avoid bisection issues and such. I've added
> him to the thread now to chime in (somehow he got dropped? the thread
> starts at https://lore.kernel.org/202405030808.UsoMKFNP-lkp@intel.com/).
> 
> I think the diff in my email should be directly applicable on top of
> your change with no conflicts so he could just squash that in if you are
> both happy with that.
> 
> Cheers,
> Nathan
> 
> > > > diff --git a/lib/test_bitops.c b/lib/test_bitops.c
> > > > index 5c627b525a48..28c91072cf85 100644
> > > > --- a/lib/test_bitops.c
> > > > +++ b/lib/test_bitops.c
> > > > @@ -53,7 +53,7 @@ static unsigned long order_comb_long[][2] = {
> > > >  static int __init test_fns(void)
> > > >  {
> > > >  	static unsigned long buf[10000] __initdata;
> > > > -	static volatile __used unsigned long tmp __initdata;
> > > > +	static volatile __always_unused __used unsigned long tmp __initdata;
> > > >  	unsigned int i, n;
> > > >  	ktime_t time;

Hi Nathan,

Thank you for sharing this.

I think this __used __unused thing may confuse readers when spotted in
a random test code. What do you think if we make it a new macro and
comment properly to avoid confusion?

I did that in the patch below. If you like it, I can prepend the 
Kuan-Wei's series and fix the test inplace.

Thanks,
Yury

From 987a021cc76495b32f680507e0c55a105e8edff3 Mon Sep 17 00:00:00 2001
From: Yury Norov <yury.norov@gmail.com>
Date: Fri, 3 May 2024 12:12:00 -0700
Subject: [PATCH] Compiler Attributes: Add __always_used macro

In some cases like performance benchmarking, we need to call a
function, but don't need to read the returned value. If compiler
recognizes the function as pure or const, it can remove the function
invocation, which is not what we want.

To prevent that, the common practice is assigning the return value to
a temporary static volatile __used variable. This works with GCC, but
clang still emits Wunused-but-set-variable. To suppress that warning,
we need to teach clang to do that with the 'unused' attribute.

Nathan Chancellor explained that in details:

  While having used and unused attributes together might look unusual,
  reading the GCC attribute manual makes it seem like these attributes
  fulfill similar yet different roles, __unused__ prevents any unused
  warnings while __used__ forces the variable to be emitted. A strict
  reading of that does not make it seem like __used__ implies disabling
  unused warnings

The compiler documentation makes it clear what happens behind the used
and unused attributes, but the chosen names may confuse readers if such
combination catches an eye in a random code.

This patch adds __always_used macro, which combines both attributes
and comments on what happens for those interested in details.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405030808.UsoMKFNP-lkp@intel.com/
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/compiler_attributes.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 8bdf6e0918c1..957b2d914119 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -361,6 +361,18 @@
  */
 #define __used                          __attribute__((__used__))
 
+/*
+ * The __used attribute guarantees that the attributed variable will be
+ * always emitted by a compiler. It doesn't prevent the compiler from
+ * throwing the 'unused' warnings when it can't detect how the variable
+ * is actually used. It's a compiler implementation details either emit
+ * the warning in that case or not.
+ *
+ * The combination of both 'used' and 'unused' attributes ensures that
+ * the variable would be emitted, and will not trigger 'unused' warnings.
+ */
+#define __always_used			__used __maybe_unused
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-warn_005funused_005fresult-function-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#nodiscard-warn-unused-result
-- 
2.40.1


