Return-Path: <linux-kernel+bounces-87594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 325B486D64E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB9C281D93
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECD6D52E;
	Thu, 29 Feb 2024 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OYviilRO"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B616FF2B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243149; cv=none; b=cHGb78383iGtPL2bzkXQCriAvk0xYJnz4rUrHH9qS2XKRf6ez8v/UGuu3R0oKiwapr0N5SK+KghqC8TZLCkklpjzsq4TneGemybIGTCi1spxmDS1r9KRRBc/Y0gIJLsnfxwzRSx5fqg6VwTz9u1N64AqVuYON3L7JON1/BJjhaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243149; c=relaxed/simple;
	bh=S9qmQJQHpV9xIh/ueBb59oZ2Q3ShwYdLcu4/9qIjFrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daWt9HahgWSNoHVxmkKWj4lu+2sWXuIVpOWQDddefdx48zly407m+d/xENmB8U6Je7qzN6UWNFhgmeEYAjEKF1PzmT++dCIZdpiWnWmsNHsjgtQRXYaRsRd2g28UosqoNhOQ57W8NN58DrhT1WzrD+L5vMf1lWAXEMQEXkkAHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OYviilRO; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 16:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709243144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zZDxmk1B+ofxrDQ7dG4j+k5Pazi1ITkGCjFdRirB4k4=;
	b=OYviilRODIKEHnO2GBwq7PwFGIKF+VgLGRKmPbARgomthjlz0JDA48BxJB5Me4FE8jszNj
	HZdXjsD+4nLEiQIza5b7GwVg7nh9tN+KFjjQgt3BafihBaca5l6Mu5Md+ZIWjvlILQZL7Y
	V3mPZYy6i71Pbt14yTzF0sflmPNwSl4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v1 1/1] lib/string_helpers: Add flags param to
 string_get_size()
Message-ID: <gpuskwq7kwwf52abwrh6my462cnlhorpohpk6a5wzya4qdyvdb@gqibcr57zkv3>
References: <20240229205345.93902-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229205345.93902-1-andriy.shevchenko@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 29, 2024 at 10:52:30PM +0200, Andy Shevchenko wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> The new flags parameter allows controlling
>  - Whether or not the units suffix is separated by a space, for
>    compatibility with sort -h
>  - Whether or not to append a B suffix - we're not always printing
>    bytes.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

You shouldn't have included my SOB after making your own changes - this
all looks fine, though.

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

Also, does this mean you're picking this patch up? We're actually
dropping it from our patchset, but I'd still like to get it in, it's
just a patch routing question now. I'd use it for other stuff, so I can
add it to another pull request if you prefer.

> ---
> 
> My vesrion of https://lore.kernel.org/r/20240212213922.783301-2-surenb@google.com
> Enjoy!
> 
>  include/linux/string_helpers.h | 10 ++++--
>  lib/string_helpers.c           | 29 ++++++++-------
>  lib/test-string_helpers.c      | 65 ++++++++++++++++++++++++++++------
>  3 files changed, 78 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
> index 58fb1f90eda5..e93fbb5b0c01 100644
> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -17,14 +17,18 @@ static inline bool string_is_terminated(const char *s, int len)
>  	return memchr(s, '\0', len) ? true : false;
>  }
>  
> -/* Descriptions of the types of units to
> - * print in */
> +/* Descriptions of the types of units to print in */
>  enum string_size_units {
>  	STRING_UNITS_10,	/* use powers of 10^3 (standard SI) */
>  	STRING_UNITS_2,		/* use binary powers of 2^10 */
> +	STRING_UNITS_MASK	= BIT(0),
> +
> +	/* Modifiers */
> +	STRING_UNITS_NO_SPACE	= BIT(30),
> +	STRING_UNITS_NO_BYTES	= BIT(31),
>  };
>  
> -int string_get_size(u64 size, u64 blk_size, enum string_size_units units,
> +int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
>  		    char *buf, int len);
>  
>  int parse_int_array_user(const char __user *from, size_t count, int **array);
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 6bbafd6a10d9..69ba49b853c7 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -25,7 +25,7 @@
>   * string_get_size - get the size in the specified units
>   * @size:	The size to be converted in blocks
>   * @blk_size:	Size of the block (use 1 for size in bytes)
> - * @units:	units to use (powers of 1000 or 1024)
> + * @units:	Units to use (powers of 1000 or 1024), whether to include space separator
>   * @buf:	buffer to format to
>   * @len:	length of buffer
>   *
> @@ -39,11 +39,12 @@
>  int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
>  		    char *buf, int len)
>  {
> +	enum string_size_units units_base = units & STRING_UNITS_MASK;
>  	static const char *const units_10[] = {
> -		"B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
> +		"", "k", "M", "G", "T", "P", "E", "Z", "Y",
>  	};
>  	static const char *const units_2[] = {
> -		"B", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"
> +		"", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi", "Yi",
>  	};
>  	static const char *const *const units_str[] = {
>  		[STRING_UNITS_10] = units_10,
> @@ -68,7 +69,7 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
>  
>  	/* This is Napier's algorithm.  Reduce the original block size to
>  	 *
> -	 * coefficient * divisor[units]^i
> +	 * coefficient * divisor[units_base]^i
>  	 *
>  	 * we do the reduction so both coefficients are just under 32 bits so
>  	 * that multiplying them together won't overflow 64 bits and we keep
> @@ -78,12 +79,12 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
>  	 * precision is in the coefficients.
>  	 */
>  	while (blk_size >> 32) {
> -		do_div(blk_size, divisor[units]);
> +		do_div(blk_size, divisor[units_base]);
>  		i++;
>  	}
>  
>  	while (size >> 32) {
> -		do_div(size, divisor[units]);
> +		do_div(size, divisor[units_base]);
>  		i++;
>  	}
>  
> @@ -92,8 +93,8 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
>  	size *= blk_size;
>  
>  	/* and logarithmically reduce it until it's just under the divisor */
> -	while (size >= divisor[units]) {
> -		remainder = do_div(size, divisor[units]);
> +	while (size >= divisor[units_base]) {
> +		remainder = do_div(size, divisor[units_base]);
>  		i++;
>  	}
>  
> @@ -103,10 +104,10 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
>  	for (j = 0; sf_cap*10 < 1000; j++)
>  		sf_cap *= 10;
>  
> -	if (units == STRING_UNITS_2) {
> +	if (units_base == STRING_UNITS_2) {
>  		/* express the remainder as a decimal.  It's currently the
>  		 * numerator of a fraction whose denominator is
> -		 * divisor[units], which is 1 << 10 for STRING_UNITS_2 */
> +		 * divisor[units_base], which is 1 << 10 for STRING_UNITS_2 */
>  		remainder *= 1000;
>  		remainder >>= 10;
>  	}
> @@ -128,10 +129,12 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
>  	if (i >= ARRAY_SIZE(units_2))
>  		unit = "UNK";
>  	else
> -		unit = units_str[units][i];
> +		unit = units_str[units_base][i];
>  
> -	return snprintf(buf, len, "%u%s %s", (u32)size,
> -			tmp, unit);
> +	return snprintf(buf, len, "%u%s%s%s%s", (u32)size, tmp,
> +			(units & STRING_UNITS_NO_SPACE) ? "" : " ",
> +			unit,
> +			(units & STRING_UNITS_NO_BYTES) ? "" : "B");
>  }
>  EXPORT_SYMBOL(string_get_size);
>  
> diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
> index 9a68849a5d55..dce67698297b 100644
> --- a/lib/test-string_helpers.c
> +++ b/lib/test-string_helpers.c
> @@ -3,6 +3,7 @@
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/array_size.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -500,21 +501,65 @@ static __init void test_string_get_size_check(const char *units,
>  	pr_warn("expected: '%s', got '%s'\n", exp, res);
>  }
>  
> +static __init void __strchrcut(char *dst, const char *src, const char *cut)
> +{
> +	const char *from = src;
> +	size_t len;
> +
> +	do {
> +		len = strcspn(from, cut);
> +		memcpy(dst, from, len);
> +		dst += len;
> +		from += len;
> +	} while (*from++);
> +	*dst = '\0';
> +}
> +
> +static __init void __test_string_get_size_one(const u64 size, const u64 blk_size,
> +					      const char *exp_result10,
> +					      const char *exp_result2,
> +					      enum string_size_units units,
> +					      const char *cut)
> +{
> +	char buf10[string_get_size_maxbuf];
> +	char buf2[string_get_size_maxbuf];
> +	char exp10[string_get_size_maxbuf];
> +	char exp2[string_get_size_maxbuf];
> +	char prefix10[64];
> +	char prefix2[64];
> +
> +	sprintf(prefix10, "STRING_UNITS_10 [%s]", cut);
> +	sprintf(prefix2, "STRING_UNITS_2 [%s]", cut);
> +
> +	__strchrcut(exp10, exp_result10, cut);
> +	__strchrcut(exp2, exp_result2, cut);
> +
> +	string_get_size(size, blk_size, STRING_UNITS_10 | units, buf10, sizeof(buf10));
> +	string_get_size(size, blk_size, STRING_UNITS_2 | units, buf2, sizeof(buf2));
> +
> +	test_string_get_size_check(prefix10, exp10, buf10, size, blk_size);
> +	test_string_get_size_check(prefix2, exp2, buf2, size, blk_size);
> +}
> +
>  static __init void __test_string_get_size(const u64 size, const u64 blk_size,
>  					  const char *exp_result10,
>  					  const char *exp_result2)
>  {
> -	char buf10[string_get_size_maxbuf];
> -	char buf2[string_get_size_maxbuf];
> +	struct {
> +		enum string_size_units units;
> +		const char *cut;
> +	} get_size_test_cases[] = {
> +		{ 0, "" },
> +		{ STRING_UNITS_NO_SPACE, " " },
> +		{ STRING_UNITS_NO_SPACE | STRING_UNITS_NO_BYTES, " B" },
> +		{ STRING_UNITS_NO_BYTES, "B" },
> +	};
> +	int i;
>  
> -	string_get_size(size, blk_size, STRING_UNITS_10, buf10, sizeof(buf10));
> -	string_get_size(size, blk_size, STRING_UNITS_2, buf2, sizeof(buf2));
> -
> -	test_string_get_size_check("STRING_UNITS_10", exp_result10, buf10,
> -				   size, blk_size);
> -
> -	test_string_get_size_check("STRING_UNITS_2", exp_result2, buf2,
> -				   size, blk_size);
> +	for (i = 0; i < ARRAY_SIZE(get_size_test_cases); i++)
> +		__test_string_get_size_one(size, blk_size, exp_result10, exp_result2,
> +					   get_size_test_cases[i].units,
> +					   get_size_test_cases[i].cut);
>  }
>  
>  static __init void test_string_get_size(void)
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 

