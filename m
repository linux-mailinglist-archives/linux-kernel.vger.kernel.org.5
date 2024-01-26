Return-Path: <linux-kernel+bounces-40799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E62283E5D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F24C1F24712
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6EF2563D;
	Fri, 26 Jan 2024 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+FgHu//"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4002556D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309586; cv=none; b=D01UBPD5d8utmwVRsilP9Uw+aZsLly2BowzqrrKNJprBctMS4/uFpzm2CEMuBY2AtvavOfMpgL0agj36Cy+DkXgEW68Yg2T37HZ600bCdcdY+4Ad8gfkINCbGNv516Y1ocxvaQlRjjnHvwQySPrOwgDpwFY/vrIdvdFmESgdIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309586; c=relaxed/simple;
	bh=44H58IoQpiv+yLvW7vreVRuB+tW5WFPbunVdWDk0Gk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAip4a+Z3oqs486MwaG1VnxhQU8dWQI88n02rE6faCLIvOyqHQds5apxwpqc6G5jsldZOWhR8xwLGb2OZR3SedNzM3+roaAOi3g9LTk1q6KG65ZxVZjJ3OegY991dQh1Urfn4im432QjGSx2wrCuFPoY/fRSOAVbOt+5RoPthLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+FgHu//; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3606ad581a5so1876145ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706309583; x=1706914383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hQRFSvbhKcNzR7WD2Hs/Sj9NUJI0s3BltoLyeof5Fi0=;
        b=l+FgHu//oMnvP6sAs6iwiYvgocxppLPZsZePxL6my3nIqXrUPFWBF+IS8uCCV1WbGO
         MNbclVWd11QGkJuCoSmSRgZDhegtzC4HGGss38owUIcynsVTufVdaTJxV+ciw6dRyclf
         u324//1+TNhfHcLUCIbSXq1WXIYGciat9P2BZw3U6kClcRrYqoRkxy6ciF5Odz8cB7yx
         /E29IRyRB740EI9NeULe4oWeNW5DHxpuw7erbF4Moz16aqmiEYgUARxrw/e45FepO1aD
         V+DV81nDMtnPDVny6FqN5qBAq3byG2+EZP7KD1UB1QPKs5KZYIJjWg8tIbT7Ydfy2K3Z
         wBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706309583; x=1706914383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQRFSvbhKcNzR7WD2Hs/Sj9NUJI0s3BltoLyeof5Fi0=;
        b=nZTlFt+tcn/KcyH7CVNUSxWgVnjPtS8U3gjWI0kvQp0/tMv/l93vJLbLNzsEUCpoxm
         +yk0O7auXeUz50zd7Q9NzTsZSv+UD2G2LhG7ev5pSMKCA+YFjUvyHMkLRHsqHRMMZA+r
         OUOKCXhO8jXNKtlWa5JKtB/PWe1cC+nxxbZbBCMs6YqEjmIKjob/AHsrhR1P1wpyWSsO
         99+kE20KgJ5NmQopBT1xnCbqCJiOt7kXmCtigplzMDtXcxquvaVQ4z0a4ohtO1i56YxB
         SH/Dxp49qzHqj1IiBntpfsXRqLDMuNAGdP9sTqMsyZos5O+lbvpeiBY+giTTlbYsogUp
         kQvA==
X-Gm-Message-State: AOJu0Yy8jH+PPPhKKDwkgMLbdnHeqnZQOE51ScmtUFTm9Et0svHzw2yw
	4YbvYcl3rJKJDCZD9qfRAqv/dqVTQKpcbQK8cJIVBJCCDHwi7ZhYi0VwuT1Z0DaL0BoLD6XKLwM
	iTQ==
X-Google-Smtp-Source: AGHT+IHid4fkQI8CL7RCGjgoERAK7pu57eCVx5/+xS2a+6+b54sf/tw9SBbw8NGVYDSEra6l71ZY9w==
X-Received: by 2002:a05:6e02:5b0:b0:361:ac4c:8c39 with SMTP id k16-20020a056e0205b000b00361ac4c8c39mr616384ils.23.1706309582956;
        Fri, 26 Jan 2024 14:53:02 -0800 (PST)
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id bs18-20020a056e02241200b003627dd3822bsm584899ilb.77.2024.01.26.14.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:53:02 -0800 (PST)
Date: Fri, 26 Jan 2024 22:52:57 +0000
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/82] overflow: Expand check_add_overflow() for pointer
 addition
Message-ID: <20240126225257.lfgeom4rhjzx2wrf@google.com>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240123002814.1396804-1-keescook@chromium.org>

Hi,

On Mon, Jan 22, 2024 at 04:26:36PM -0800, Kees Cook wrote:
> The check_add_overflow() helper is mostly a wrapper around
> __builtin_add_overflow(), but GCC and Clang refuse to operate on pointer
> arguments that would normally be allowed if the addition were open-coded.
>
> For example, we have many places where pointer overflow is tested:
>
> 	struct foo *ptr;
> 	...
> 	/* Check for overflow */
> 	if (ptr + count < ptr) ...
>
> And in order to avoid running into the overflow sanitizers in the
> future, we need to rewrite these "intended" overflow checks:
>
> 	if (check_add_overflow(ptr, count, &result)) ...
>
> Frustratingly the argument type validation for __builtin_add_overflow()
> is done before evaluating __builtin_choose_expr(), so for arguments to
> be valid simultaneously for sizeof(*p) (when p may not be a pointer),
> and __builtin_add_overflow(a, ...) (when a may be a pointer), we must
> introduce wrappers that always produce a specific type (but they are
> only used in the places where the bogus arguments will be ignored).
>
> To test whether a variable is a pointer or not, introduce the __is_ptr()
> helper, which uses __builtin_classify_type() to find arrays and pointers
> (via the new __is_ptr_or_array() helper), and then decays arrays into
> pointers (via the new __decay() helper), to distinguish pointers from
> arrays.
>
> Additionally update the unit tests to cover pointer addition.
>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: llvm@lists.linux.dev
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/compiler_types.h | 10 +++++
>  include/linux/overflow.h       | 44 ++++++++++++++++++-
>  lib/overflow_kunit.c           | 77 ++++++++++++++++++++++++++++++----
>  3 files changed, 121 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 6f1ca49306d2..d27b58fddfaa 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -375,6 +375,16 @@ struct ftrace_likely_data {
>  /* Are two types/vars the same type (ignoring qualifiers)? */
>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>
> +/* Is variable addressable? */
> +#define __is_ptr_or_array(p)	(__builtin_classify_type(p) == 5)
> +
> +/* Return an array decayed to a pointer. */
> +#define __decay(p)		\
> +	(&*__builtin_choose_expr(__is_ptr_or_array(p), p, NULL))

Initially, I thought this __decay could dereference a NULL which would
be UB.

According to the C std 6.5.3.2 (4):
| The unary * operator denotes indirection. If the operand points to a
| function, the result is a function designator; if it points to an
| object, the result is an lvalue designating the object. If the operand
| has type ‘‘pointer to type’’, the result has type ‘‘type’’. If an
| invalid value has been assigned to the pointer, the behavior of the
| unary * operator is undefined^(84)

With footnote 84 mentioning NULL:
| Among the invalid values for dereferencing a pointer by the unary *
| operator are a null pointer, an address inappropriately aligned for the
| type of object pointed to, and the address of an object after the end of
| its lifetime.

However, in this very same footnote it mentions:
| &*E is equivalent to E (even if E is a null pointer)

So, yeah this is OK ( and new to me :>] )

> +
> +/* Report if variable is a pointer type. */
> +#define __is_ptr(p)		__same_type(p, __decay(p))
> +
>  /*
>   * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
>   *			       non-scalar types unchanged.
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 7b5cf4a5cd19..099f2e559aa8 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -51,6 +51,45 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  	return unlikely(overflow);
>  }
>
> +/* Always produce an integral variable expression. */
> +#define __filter_integral(x)		\
> +	__builtin_choose_expr(!__is_ptr(x), (x), 0)
> +
> +/* Always produce a pointer value. */
> +#define __filter_ptr(x)			\
> +	__builtin_choose_expr(__is_ptr(x), (x), NULL)
> +
> +/* Always produce a pointer to an integral value. */
> +#define __filter_ptrint(x)		\
> +	__builtin_choose_expr(!__is_ptr(*(x)), x, &(int){ 0 })
> +
> +/**
> + * __check_ptr_add_overflow() - Calculate pointer addition with overflow checking
> + * @a: pointer addend
> + * @b: numeric addend
> + * @d: pointer to store sum
> + *
> + * Returns 0 on success.
> + *
> + * Do not use this function directly, use check_add_overflow() instead.
> + *
> + * *@d holds the results of the attempted addition, but is not considered
> + * "safe for use" on a non-zero return value, which indicates that the
> + * sum has overflowed or been truncated.
> + */
> +#define __check_ptr_add_overflow(a, b, d)		\
> +	({						\
> +		typeof(a) __a = (a);			\
> +		typeof(b) __b = (b);			\
> +		size_t __bytes;				\
> +		bool __overflow;			\
> +							\
> +		/* we want to perform the wrap-around, but retain the result */ \
> +		__overflow = __builtin_mul_overflow(sizeof(*(__a)), __b, &__bytes); \
> +		__builtin_add_overflow((unsigned long)(__a), __bytes, (unsigned long *)(d)) || \
> +		__overflow;				\
> +	})
> +
>  /**
>   * check_add_overflow() - Calculate addition with overflow checking
>   * @a: first addend
> @@ -64,7 +103,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   * sum has overflowed or been truncated.
>   */
>  #define check_add_overflow(a, b, d)	\
> -	__must_check_overflow(__builtin_add_overflow(a, b, d))
> +	__must_check_overflow(__builtin_choose_expr(__is_ptr(a),	\
> +		__check_ptr_add_overflow(__filter_ptr(a), b, d),	\
> +		__builtin_add_overflow(__filter_integral(a), b,		\
> +				       __filter_ptrint(d))))
>
>  /**
>   * check_sub_overflow() - Calculate subtraction with overflow checking

Does check_sub_overflow() deserve some more love in the future? I
imagine "under"-flowing pointers is not at all common, though.

Nonetheless, this all looks good to me.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index c527f6b75789..2d106e880956 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -45,13 +45,18 @@
>  # define SKIP_64_ON_32(t)	do { } while (0)
>  #endif
>
> -#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
> -	static const struct test_ ## t1 ## _ ## t2 ## __ ## t {	\
> +#define DEFINE_TEST_ARRAY_NAMED_TYPED(n1, n2, n, t1, t2, t)	\
> +	static const struct test_ ## n1 ## _ ## n2 ## __ ## n {	\
>  		t1 a;						\
>  		t2 b;						\
> -		t sum, diff, prod;				\
> +		t sum;						\
> +		t diff;						\
> +		t prod;						\
>  		bool s_of, d_of, p_of;				\
> -	} t1 ## _ ## t2 ## __ ## t ## _tests[]
> +	} n1 ## _ ## n2 ## __ ## n ## _tests[]
> +
> +#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
> +	DEFINE_TEST_ARRAY_NAMED_TYPED(t1, t2, t, t1, t2, t)
>
>  #define DEFINE_TEST_ARRAY(t)	DEFINE_TEST_ARRAY_TYPED(t, t, t)
>
> @@ -251,8 +256,10 @@ DEFINE_TEST_ARRAY(s64) = {
>  };
>
>  #define check_one_op(t, fmt, op, sym, a, b, r, of) do {			\
> -	int _a_orig = a, _a_bump = a + 1;				\
> -	int _b_orig = b, _b_bump = b + 1;				\
> +	typeof(a + 0) _a_orig = a;					\
> +	typeof(a + 0) _a_bump = a + 1;					\
> +	typeof(b + 0) _b_orig = b;					\
> +	typeof(b + 0) _b_bump = b + 1;					\
>  	bool _of;							\
>  	t _r;								\
>  									\
> @@ -260,13 +267,13 @@ DEFINE_TEST_ARRAY(s64) = {
>  	KUNIT_EXPECT_EQ_MSG(test, _of, of,				\
>  		"expected "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
>  		a, b, of ? "" : " not", #t);				\
> -	KUNIT_EXPECT_EQ_MSG(test, _r, r,				\
> +	KUNIT_EXPECT_TRUE_MSG(test, _r == r,				\
>  		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
>  		a, b, r, _r, #t);					\
>  	/* Check for internal macro side-effects. */			\
>  	_of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);	\
> -	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump, "Unexpected " #op " macro side-effect!\n"); \
> -	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump, "Unexpected " #op " macro side-effect!\n"); \
> +	KUNIT_EXPECT_TRUE_MSG(test, _a_orig == _a_bump, "Unexpected " #op " macro side-effect!\n"); \
> +	KUNIT_EXPECT_TRUE_MSG(test, _b_orig == _b_bump, "Unexpected " #op " macro side-effect!\n"); \
>  } while (0)
>
>  #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
> @@ -333,6 +340,55 @@ DEFINE_TEST_ARRAY_TYPED(int, int, u8) = {
>  };
>  DEFINE_TEST_FUNC_TYPED(int_int__u8, u8, "%d");
>
> +#define DEFINE_TEST_PTR_FUNC_TYPED(n, t, fmt)				\
> +static void do_ptr_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
> +{									\
> +	/* we're only doing single-direction sums, no product or division */ \
> +	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);\
> +}									\
> +									\
> +static void n ## _overflow_test(struct kunit *test) {			\
> +	unsigned i;							\
> +									\
> +	for (i = 0; i < ARRAY_SIZE(n ## _tests); ++i)			\
> +		do_ptr_test_ ## n(test, &n ## _tests[i]);		\
> +	kunit_info(test, "%zu %s arithmetic tests finished\n",		\
> +		ARRAY_SIZE(n ## _tests), #n);				\
> +}
> +
> +DEFINE_TEST_ARRAY_NAMED_TYPED(void, int, void, void *, int, void *) = {
> +	{NULL, 0, NULL, NULL, NULL, false, false, false},
> +	{(void *)0x30, 0x10, (void *)0x40, NULL, NULL, false, false, false},
> +	{(void *)ULONG_MAX, 0, (void *)ULONG_MAX, NULL, NULL, false, false, false},
> +	{(void *)ULONG_MAX, 1, NULL, NULL, NULL, true, false, false},
> +	{(void *)ULONG_MAX, INT_MAX, (void *)(INT_MAX - 1), NULL, NULL, true, false, false},
> +};
> +DEFINE_TEST_PTR_FUNC_TYPED(void_int__void, void *, "%lx");
> +
> +struct _sized {
> +	int a;
> +	char b;
> +};
> +
> +DEFINE_TEST_ARRAY_NAMED_TYPED(sized, int, sized, struct _sized *, int, struct _sized *) = {
> +	{NULL, 0, NULL, NULL, NULL, false, false, false},
> +	{NULL, 1, (struct _sized *)(sizeof(struct _sized)), NULL, NULL, false, false, false},
> +	{NULL, 0x10, (struct _sized *)(sizeof(struct _sized) * 0x10), NULL, NULL, false, false, false},
> +	{(void *)(ULONG_MAX - sizeof(struct _sized)), 1, (struct _sized *)ULONG_MAX, NULL, NULL, false, false, false},
> +	{(void *)(ULONG_MAX - sizeof(struct _sized) + 1), 1, NULL, NULL, NULL, true, false, false},
> +	{(void *)(ULONG_MAX - sizeof(struct _sized) + 1), 2, (struct _sized *)(sizeof(struct _sized)), NULL, NULL, true, false, false},
> +	{(void *)(ULONG_MAX - sizeof(struct _sized) + 1), 3, (struct _sized *)(sizeof(struct _sized) * 2), NULL, NULL, true, false, false},
> +};
> +DEFINE_TEST_PTR_FUNC_TYPED(sized_int__sized, struct _sized *, "%lx");
> +
> +DEFINE_TEST_ARRAY_NAMED_TYPED(sized, size_t, sized, struct _sized *, size_t, struct _sized *) = {
> +	{NULL, 0, NULL, NULL, NULL, false, false, false},
> +	{NULL, 1, (struct _sized *)(sizeof(struct _sized)), NULL, NULL, false, false, false},
> +	{NULL, 0x10, (struct _sized *)(sizeof(struct _sized) * 0x10), NULL, NULL, false, false, false},
> +	{NULL, SIZE_MAX - 10, (struct _sized *)18446744073709551528UL, NULL, NULL, true, false, false},
> +};
> +DEFINE_TEST_PTR_FUNC_TYPED(sized_size_t__sized, struct _sized *, "%zu");
> +
>  /* Args are: value, shift, type, expected result, overflow expected */
>  #define TEST_ONE_SHIFT(a, s, t, expect, of)	do {			\
>  	typeof(a) __a = (a);						\
> @@ -1122,6 +1178,9 @@ static struct kunit_case overflow_test_cases[] = {
>  	KUNIT_CASE(s32_s32__s32_overflow_test),
>  	KUNIT_CASE(u64_u64__u64_overflow_test),
>  	KUNIT_CASE(s64_s64__s64_overflow_test),
> +	KUNIT_CASE(void_int__void_overflow_test),
> +	KUNIT_CASE(sized_int__sized_overflow_test),
> +	KUNIT_CASE(sized_size_t__sized_overflow_test),
>  	KUNIT_CASE(u32_u32__int_overflow_test),
>  	KUNIT_CASE(u32_u32__u8_overflow_test),
>  	KUNIT_CASE(u8_u8__int_overflow_test),
> --
> 2.34.1
>
Thanks
Justin

