Return-Path: <linux-kernel+bounces-134373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E51B89B0C9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7491C20B2D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9659249F7;
	Sun,  7 Apr 2024 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="wA2k3oUc";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="38XsvpOh"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B592125D6;
	Sun,  7 Apr 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493512; cv=none; b=BmFe7ulAVwNXty8Un4ym70SUIjva0P1dNwnu47ZsmDZC+SDVpjjgzELTYbqmNxBQhpWyiRILhh2cNo4+WVh8ubn9rPsaAHfS1bvsWvQuy70AwOYRE10y8e8wJMsPg4Z7n5CoHyPXNg+FHceYFEO9loZNesQXBeM1h3Sd/F3DZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493512; c=relaxed/simple;
	bh=O2Xi5/Vhd4+d70tT31UFzavN7LvCALUssqXNVC27xE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYUjVx3OxPhuMpaHQlvm5s3YxjGJSju/Apnwm4TmLQWrY9wNO/okr31+qQxc8B5f9dZare1fEfnCBrUvQOhwe3kNL2+zc77NHPKiV880Zvy6WS4HEeu+QFSymgrCvVJGyEMPHusTZq2z6SdpJMciGx5Hw/2rGPjLwgXUnLqkN/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=wA2k3oUc; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=38XsvpOh; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 13BB7C01E; Sun,  7 Apr 2024 14:38:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712493509; bh=UvKcs2Qh0OFwEbrqtpta4kIQwfiplMVDC7o0WnH1kGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wA2k3oUcb+OMOj1Qehd/JtpmYEJYhtGSXisx3OXFxbpLmNcgUj17r5o7wYbUnrJqk
	 n1cLuG4s+Dt0+iziPia1AaFm+1Y9uNZoFtlCXlgLsquHUl1Qa+WQxco6LKCORgxRbT
	 dLjROj2zTbpeWhazqi9RYG09cKFYv+c55t19i5F+kkkJjy9B4ch571DY4bmJaVbv/i
	 UiktQJ5VGLhV6GKyq7I1DVMWzbItyo5gcvEOGxG138WAmJi1BjsW3nQl8KHSUHl99Z
	 6zJVfsw/54m5nxVYNGoDhWuu/NOC7zTDjXK5xWhkQMELHbv4aYizFl2Bn2YYeMCS97
	 z40Dj2Kg0NBhw==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 1A60CC009;
	Sun,  7 Apr 2024 14:38:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712493508; bh=UvKcs2Qh0OFwEbrqtpta4kIQwfiplMVDC7o0WnH1kGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=38XsvpOh9FF06DJ8KNyp126Rqhhk7tH8WYsR8UE7MG5RPtGdisR8eFM5ZcDj0nUbV
	 jUt04dp9Vln+JK6PQi68FebTzMmbiHpfVq63zm1uvUHpwleiAQt+jjykkF0jQt11ZN
	 F0QbeQWHKiWFgBl0aRN1VXBGxvQfGP4Vgca9enHJQy3LmLHtju3irG1WJEWnuD4bao
	 pFa3C8rjoPHepe++lZLvhjJp5CDd9ZsJWfUkxURa/7Td48r6dQ0MfaDFCZ6uuQXLR8
	 CXi9gqRMM6kCHEiglAClVzMWxFH/pyegcf4ObgBojzHsrO+MphzgDs3n/fN18pGA0j
	 SE6ryEhvYRWyQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1a0434f2;
	Sun, 7 Apr 2024 12:38:20 +0000 (UTC)
Date: Sun, 7 Apr 2024 21:38:05 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf parse: Allow names to start with digits
Message-ID: <ZhKTrUPbUnBviQYK@codewreck.org>
References: <20240407-perf_digit-v1-0-57ec37c63394@codewreck.org>
 <20240407-perf_digit-v1-3-57ec37c63394@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407-perf_digit-v1-3-57ec37c63394@codewreck.org>

Dominique Martinet wrote on Sun, Apr 07, 2024 at 09:18:21PM +0900:
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index e86c45675e1d..41c30ff29783 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -158,7 +158,7 @@ event		[^,{}/]+
>  num_dec		[0-9]+
>  num_hex		0x[a-fA-F0-9]{1,16}
>  num_raw_hex	[a-fA-F0-9]{1,16}
> -name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
> +name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*

grmbl sorry I guess I didn't actually test this two years ago (?!), or
used it differently (commit message is weird and also needs fixing,
perf probe -e 9p:* does not make sense) or something changed but
that's not enough:

----
$ sudo ./perf trace -e 9p:9p_fid_ref
event syntax error: '9p:9p_fid_ref'
                     \___ parser error
Run 'perf list' for a list of valid events
----

Adding 0-9 to name_tag as well makes perf trace works.

I'm not sure what name_minus is for but I did't need to add that one in
my test.

That also highlights that the test I added isn't sufficient, if someone
familiar with the code could hint at a better place to test please tell!
Otherwise I'll have a look next weekend, I need to get back to my 9p
bugs now I've got a working perf command..

>  name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
>  name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
>  drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
> 

-- 
Dominique Martinet | Asmadeus

