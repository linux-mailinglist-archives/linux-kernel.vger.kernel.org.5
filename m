Return-Path: <linux-kernel+bounces-48757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E818460D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BDE1C23835
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9378563E;
	Thu,  1 Feb 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzOTlHxm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E385631;
	Thu,  1 Feb 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815255; cv=none; b=l0cR3j85vHqnmwSsZObmIBR5ThTNiuDmA3de38nvhXX25mu+BcowdtvsrXncy667izPxQlC/e3zD+z/TLahEH3nptOHeTdohlfgpaad5ZXgeTlFbm1f0cxkHuiZ2gIqR8jW074A2oAyeDZqN0Mq76WdurAoCH94oCeHt3rj0fN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815255; c=relaxed/simple;
	bh=8ByGpw4Ub5BR+JBxRpGU9i868XZCdYzjzStzYSpZcaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsUPpHUtbFsu/Ed5QV2N2czMWI5dFaJNmKrdSztkUNWjPmrxC9sl9F7OTL3YxUSSUDdHaPXEKFwZKFH9f/RZjSvdGxwFc8GAOfP0z+CAvQ3ZreSeoy1disB4PPPTo1f4n/EKPE5VKPC8p/RF3Aui95zMH7NIgGVwgrU8Q/1Oiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzOTlHxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633ADC43390;
	Thu,  1 Feb 2024 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706815254;
	bh=8ByGpw4Ub5BR+JBxRpGU9i868XZCdYzjzStzYSpZcaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzOTlHxm42AJzkNvcYod5FnctsxVUpkGYpyxL9dB/i5vickaagyGDQy88hFm6bvWd
	 ym2Or4Z3hANT+/xKff/LMtVY7gByIg1NEQV6iwKx+p2if0vrq3QYo3cTcDTFFcShEv
	 lP6eBu7rbxfcWW9OhOo8goiC+3ojDDate/8Xs8mv0JROO0tSumWzZzVpnPcn8q14sl
	 xr3llIpr0hWmFH+2nI/I+gGbBFaNpYeXgJNSNBmWJcqo+bgBOATo01kTtH5naD1sXr
	 KjLYcXCO7Di2+O/qd0iSDZRNo2khimWLVX7voXP+nM9u48FJ+BwemSnndvvUUa5lTd
	 T92SMb2YjNJzQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 14D5C40441; Thu,  1 Feb 2024 16:20:52 -0300 (-03)
Date: Thu, 1 Feb 2024 16:20:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	james.clark@arm.com, Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>
Subject: Re: Perf not able to cross compile
Message-ID: <ZbvvFLN32si2fhGD@kernel.org>
References: <CADYN=9+DUzu6xEThaWQKp0udCsPs7h3XijyE5zmn-UYG8oM+AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADYN=9+DUzu6xEThaWQKp0udCsPs7h3XijyE5zmn-UYG8oM+AA@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Thu, Feb 01, 2024 at 12:32:09PM +0100, Anders Roxell escreveu:
> Hey,
> 
> I'm trying to cross compile perf ARCH=arm64 on my x86_64 host from
> linus tree [1], branch master.
> 
> 
> This is the failue I see, full log [2]:
> 
> ...
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/staticobjs/elf.o
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/staticobjs/features.o
> cc1: error: ‘-fcf-protection=full’ is not supported for this target
> error: command '/usr/local/bin/sccache' failed with exit code 1

We have some checks to deal with unknown options that came from python,
perl config, but it seems in your case there is something that is not
being covered, worth of further investigation.

Can you simply first try disabling python support? Look at
tools/perf/Makefile.perf, first trying with NO_LIBPYTHON=1 to your
make command line?

- Arnaldo

> cp: cannot stat
> '/home/tuxbuild/.cache/tuxmake/builds/1/build/python_ext_build/lib/perf*.so':
> No such file or directory
> make[2]: *** [Makefile.perf:678:
> /home/tuxbuild/.cache/tuxmake/builds/1/build/python/perf.cpython-311-x86_64-linux-gnu.so]
> Error 1
> make[2]: *** Waiting for unfinished jobs....
>   LD      /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/staticobjs/libbpf-in.o
>   LINK    /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/libbpf.a
> make[1]: *** [Makefile.perf:261: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> 
> Running 'x86_64-linux-gnu-python3-config --cflags' I see
> '-fcf-protection' in the output and this happens when I'm building
> cross compile arm64 on my x86_64 host machine. Building on an arm64
> host works. cross compile x86_64 on my x86_64 host works too.
> 
> I have 'aarch64-linux-gnu-python3-config' installed but that isn't used.
> 
> $ x86_64-linux-gnu-python3-config --cflags
> -I/usr/include/python3.11 -I/usr/include/python3.11  -Wsign-compare -g
>   -fstack-protector-strong -fstack-clash-protection -Wformat
> -Werror=format-security -fcf-protection  -DNDEBUG -g -fwrapv -O2 -Wall
> $ aarch64-linux-gnu-python3-config --cflags
> -I/usr/include/python3.11 -I/usr/include/python3.11  -Wsign-compare -g
>   -fstack-protector-strong -fstack-clash-protection -Wformat
> -Werror=format-security -mbranch-protection=standard  -DNDEBUG -g
> -fwrapv -O2 -Wall
> 
> I tried to set PYTHON and PYTHON_CONFIG too, but didn't work.
> 
> It doesn't try to use $(CROSS_COMPILE)python3-config, any idea how to
> use the correct config?
> 
> Cheers,
> Anders
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> [2]  https://storage.tuxsuite.com/public/linaro/lkft/builds/2bc6x6cISHzG9Jgo0oAVv2OgLOG/build.log

-- 

- Arnaldo

