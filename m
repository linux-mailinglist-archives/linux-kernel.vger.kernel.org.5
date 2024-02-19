Return-Path: <linux-kernel+bounces-71724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBEF85A986
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA3C1C226FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D204439F;
	Mon, 19 Feb 2024 17:03:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836483A1CF;
	Mon, 19 Feb 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362182; cv=none; b=ds9m2qBiQwK3QfyHhSFHQc3dWu2MtfkudnmmxIQUBAXq3z6aiLD5cJgO8cxBWHC2DkpezcuMgHbukHe6FGTmuzrU9Zj6ZUdZ4vZbdtD4r0U7snYWCJWu75f6P2RBPx6oia9Fqx4lef4pyChF3sVEuXz8jr5aSXM4qeQLkMHyhaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362182; c=relaxed/simple;
	bh=FDHavmdGhoIJckd4BTDH4LTUQrUq5xigNG4PkIe8dTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW4qgtkk6W2S2U8lM2N2P2m+36FBk/uwskRiR9WKD7FTFiq3wMQsfVyq7VeKyd8TzmJYYAhnbqWpvmwaWN9idhFGkJd2E7+t7ILAvKYfBEkw11o4KB/TyQmxqrbomxw6Ni3clGbVLuoDoojCW37eu1eiMnero+SONT649kXY8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C281DA7;
	Mon, 19 Feb 2024 09:03:39 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 370C13F762;
	Mon, 19 Feb 2024 09:02:58 -0800 (PST)
Date: Mon, 19 Feb 2024 17:02:55 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] overflow: Adjust check_*_overflow() kern-doc to
 reflect results
Message-ID: <ZdOJv3Dz2JVs6hhG@FVFF77S0Q05N>
References: <20240214194432.makes.837-kees@kernel.org>
 <20240214194605.602505-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214194605.602505-1-keescook@chromium.org>

On Wed, Feb 14, 2024 at 11:46:01AM -0800, Kees Cook wrote:
> The check_*_overflow() helpers will return results with potentially
> wrapped-around values. These values have always been checked by the
> selftests, so avoid the confusing language in the kern-doc. The idea of
> "safe for use" was relative to the expectation of whether or not the
> caller wants a wrapped value -- the calculation itself will always follow
> arithmetic wrapping rules.
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-hardening@vger.kernel.org

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  include/linux/overflow.h | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 7b5cf4a5cd19..ad64d810c8aa 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -57,11 +57,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   * @b: second addend
>   * @d: pointer to store sum
>   *
> - * Returns 0 on success.
> + * Returns true on wrap-around, false otherwise.
>   *
> - * *@d holds the results of the attempted addition, but is not considered
> - * "safe for use" on a non-zero return value, which indicates that the
> - * sum has overflowed or been truncated.
> + * *@d holds the results of the attempted addition, regardless of whether
> + * wrap-around occurred.
>   */
>  #define check_add_overflow(a, b, d)	\
>  	__must_check_overflow(__builtin_add_overflow(a, b, d))
> @@ -72,11 +71,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   * @b: subtrahend; value to subtract from @a
>   * @d: pointer to store difference
>   *
> - * Returns 0 on success.
> + * Returns true on wrap-around, false otherwise.
>   *
> - * *@d holds the results of the attempted subtraction, but is not considered
> - * "safe for use" on a non-zero return value, which indicates that the
> - * difference has underflowed or been truncated.
> + * *@d holds the results of the attempted subtraction, regardless of whether
> + * wrap-around occurred.
>   */
>  #define check_sub_overflow(a, b, d)	\
>  	__must_check_overflow(__builtin_sub_overflow(a, b, d))
> @@ -87,11 +85,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   * @b: second factor
>   * @d: pointer to store product
>   *
> - * Returns 0 on success.
> + * Returns true on wrap-around, false otherwise.
>   *
> - * *@d holds the results of the attempted multiplication, but is not
> - * considered "safe for use" on a non-zero return value, which indicates
> - * that the product has overflowed or been truncated.
> + * *@d holds the results of the attempted multiplication, regardless of whether
> + * wrap-around occurred.
>   */
>  #define check_mul_overflow(a, b, d)	\
>  	__must_check_overflow(__builtin_mul_overflow(a, b, d))
> -- 
> 2.34.1
> 

