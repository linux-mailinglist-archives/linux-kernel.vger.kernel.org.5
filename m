Return-Path: <linux-kernel+bounces-154775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B368AE0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE5F1C21694
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036855812B;
	Tue, 23 Apr 2024 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="glg2zKB4"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAD2AD11
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863892; cv=none; b=RTGoNSDMlQ6rg7kwBJhceSuEXF4Fngfhq1/wvxMLGMN2UvTScbCsGIHWiObFcXLht2tXIV5RDLtYoGIrmFkofjIZ65XgEXGDPv5451BkjzE4BJJS/wdT7BMKilGK0iRAnR/yso4pSjEbAiHfFjB3Z0snPxT030rbeSPgVkjoAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863892; c=relaxed/simple;
	bh=0g3RC9v/aNxcYppBWNUHo78P3I4XIoFkZB6LPvM4rRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqaqbeJ0xuziUW4J22YufntvKT8zQ0SLSOgfjbf+3ZDe9ekijnCq2Sp02GUkUvBMqTWI6vF1v0lJyKbVWk9kHEAoN7mPGePdG0/uuO3MyEoPNPm2WdlvZK8+orD33PNUjHaqx8LrtYLqBh/NpuSJZV64hncIa1EI9lwpxJQ+70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=glg2zKB4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713863886;
	bh=0g3RC9v/aNxcYppBWNUHo78P3I4XIoFkZB6LPvM4rRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=glg2zKB4PGPUfZvJ0aqL7uuMi0SINVsKXwKXdhd5u1KpxoTKTQ6fC/MaHuevI/JEL
	 QIPa5tMcoPS0FGAA/b6nfzQLKhTS+RIPv49rvUUfw5zLS7QEjRB9Zg5KkQ8tgur6Pz
	 usgMYtjQrAbArCDJWy3wVLwIKeXiHw1+oDkKNAdE=
Date: Tue, 23 Apr 2024 11:18:06 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <skhan@linuxfoundation.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, 
	Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: Re: [PATCH v3 4/4] selftests/nolibc: Add tests for strlcat() and
 strlcpy()
Message-ID: <172d25cf-cfd7-4069-8c26-df2e81ffbad1@t-8ch.de>
References: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
 <20240218195110.1386840-5-rodrigo@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218195110.1386840-5-rodrigo@sdfg.com.ar>

+ Shuah and Paul, please see below.

So I picked this up and it got picked up by Shuah, but...

On 2024-02-18 16:51:06+0000, Rodrigo Campos wrote:
> I've verified that the tests matches libbsd's strlcat()/strlcpy()
> implementation.
> 
> Please note that as strlcat()/strlcpy() are not part of the libc, the
> tests are only compiled when using nolibc.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 40 ++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 6ba4f8275ac4..d373fc14706c 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -600,6 +600,25 @@ int expect_strne(const char *expr, int llen, const char *cmp)
>  	return ret;
>  }
>  
> +#define EXPECT_STRBUFEQ(cond, expr, buf, val, cmp)				\
> +	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_str_buf_eq(expr, buf, val, llen, cmp); } while (0)
> +
> +static __attribute__((unused))
> +int expect_str_buf_eq(size_t expr, const char *buf, size_t val, int llen, const char *cmp)
> +{
> +	llen += printf(" = %lu <%s> ", expr, buf);

This introduces a compiler warning on 32bit:

    i386-linux-gcc -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra -fno-stack-protector -m32 -mstack-protector-guard=global -fstack-protector-all  -o nolibc-test \
      -nostdlib -nostdinc -static -Isysroot/i386/include nolibc-test.c nolibc-test-linkage.c -lgcc
    nolibc-test.c: In function 'expect_str_buf_eq':
    nolibc-test.c:610:30: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
      610 |         llen += printf(" = %lu <%s> ", expr, buf);
          |                            ~~^         ~~~~
          |                              |         |
          |                              |         size_t {aka unsigned int}
          |                              long unsigned int
          |                            %u


It is easy enough to fix through a cast to "unsigned long".

The original patch was already sent to Shuah and included in -next.

Shuah, Paul:

I'd like to rewrite the offending commit instead of having a fixup commit.
As it seems to me the original patch would only go into 6.10 anyways.

Any objections?

Notes to self:

* Add flag to run-tests.sh to use -Werror
* Implement "%zu" in nolibc printf()

> +	if (strcmp(buf, cmp) != 0) {
> +		result(llen, FAIL);
> +		return 1;
> +	}
> +	if (expr != val) {
> +		result(llen, FAIL);
> +		return 1;
> +	}
> +
> +	result(llen, OK);
> +	return 0;
> +}

> [..]

