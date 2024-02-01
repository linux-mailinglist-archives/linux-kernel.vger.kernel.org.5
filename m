Return-Path: <linux-kernel+bounces-48758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 740E08460D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C0CB2155C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C448527C;
	Thu,  1 Feb 2024 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwgaHeTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599312FB11;
	Thu,  1 Feb 2024 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815321; cv=none; b=Wy86/Mjv30JAs7IXWKg8XuKU4EsABB2lIueHlWAmYK1KbRQYFnJXrEsJCZGTVjm4qQLOWmjanePK2mxlvJ+RBKZMQK/2euf5kxm3SFANUdLZv81KjEuR0x18fNGHgsWzsiDlUb93yxnRpAl77LNwQrKfZDe70Itv9E3kXvl5mnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815321; c=relaxed/simple;
	bh=/GVp+KkWn8FbjPzBszbZ74s0vJwipfrVV+J3uWTKmO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwwpsPnr+nb3e7dxpbYOJFWUlcLqQi94X4IuzSE5WqJ4K+ye3gWjxxx3SEGQjrbW1Gkyan5tPdvMGRNj8bxuBv3o/sw3I3zThMsQaME+g+S4rYj9K4u6QmgKFho3SCVAywDnnEXGg5cpPlzIB4iCGR0BsTbABlyApjorP3S+Nus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwgaHeTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A0DC433C7;
	Thu,  1 Feb 2024 19:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706815321;
	bh=/GVp+KkWn8FbjPzBszbZ74s0vJwipfrVV+J3uWTKmO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwgaHeTyLUp69ZlVFY3x7ngz1RK5hWTi7OZQ6FYlfXtaHqU9TCc58hNAv5Ch2StAa
	 SuYlanJMLgGmBvBsCYdQlgWJeeK4HPQBPS/TtQ5/NVUI60Em5ozQJadYRYKo2AJYzo
	 kDq8ASD/6BJm8m+rwPU6B43lPV7VA1ulkPu+sHxVvvYi7b7KTbyoUMmLG5SoUrfU+K
	 cIAihcKLxKasiI7p6PyowNUSnoGNQa8Tp/SF2m67saGfMei/nubiyilawnz5RBMdbC
	 b7cq/Mqm43Z7YIaDLuU3/VLRju4mjnNO7Vbe0w9WphkkAqGEByer3wTLS5yfIMXTCF
	 4egtnuTz1pGTA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id ECED740441; Thu,  1 Feb 2024 16:21:58 -0300 (-03)
Date: Thu, 1 Feb 2024 16:21:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Anders Roxell <anders.roxell@linaro.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Subject: Re: Perf not able to cross compile
Message-ID: <ZbvvVjqWByL1385l@kernel.org>
References: <CADYN=9+DUzu6xEThaWQKp0udCsPs7h3XijyE5zmn-UYG8oM+AA@mail.gmail.com>
 <511f5874-3c97-5928-fd59-b49516ca6b2a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <511f5874-3c97-5928-fd59-b49516ca6b2a@arm.com>
X-Url: http://acmel.wordpress.com

Em Thu, Feb 01, 2024 at 11:52:07AM +0000, James Clark escreveu:
> 
> 
> On 01/02/2024 11:32, Anders Roxell wrote:
> > Hey,
> > 
> > I'm trying to cross compile perf ARCH=arm64 on my x86_64 host from
> > linus tree [1], branch master.
> > 
> > 
> > This is the failue I see, full log [2]:
> > 
> > ...
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/staticobjs/elf.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/staticobjs/features.o
> > cc1: error: ‘-fcf-protection=full’ is not supported for this target
> > error: command '/usr/local/bin/sccache' failed with exit code 1
> > cp: cannot stat
> > '/home/tuxbuild/.cache/tuxmake/builds/1/build/python_ext_build/lib/perf*.so':
> > No such file or directory
> > make[2]: *** [Makefile.perf:678:
> > /home/tuxbuild/.cache/tuxmake/builds/1/build/python/perf.cpython-311-x86_64-linux-gnu.so]
> > Error 1
> > make[2]: *** Waiting for unfinished jobs....
> >   LD      /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/staticobjs/libbpf-in.o
> >   LINK    /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/libbpf.a
> > make[1]: *** [Makefile.perf:261: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> > 
> > Running 'x86_64-linux-gnu-python3-config --cflags' I see
> > '-fcf-protection' in the output and this happens when I'm building
> > cross compile arm64 on my x86_64 host machine. Building on an arm64
> > host works. cross compile x86_64 on my x86_64 host works too.
> > 
> > I have 'aarch64-linux-gnu-python3-config' installed but that isn't used.
> > 
> > $ x86_64-linux-gnu-python3-config --cflags
> > -I/usr/include/python3.11 -I/usr/include/python3.11  -Wsign-compare -g
> >   -fstack-protector-strong -fstack-clash-protection -Wformat
> > -Werror=format-security -fcf-protection  -DNDEBUG -g -fwrapv -O2 -Wall
> > $ aarch64-linux-gnu-python3-config --cflags
> > -I/usr/include/python3.11 -I/usr/include/python3.11  -Wsign-compare -g
> >   -fstack-protector-strong -fstack-clash-protection -Wformat
> > -Werror=format-security -mbranch-protection=standard  -DNDEBUG -g
> > -fwrapv -O2 -Wall
> > 
> > I tried to set PYTHON and PYTHON_CONFIG too, but didn't work.
> > 
> > It doesn't try to use $(CROSS_COMPILE)python3-config, any idea how to
> > use the correct config?
> > 
> > Cheers,
> > Anders
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > [2]  https://storage.tuxsuite.com/public/linaro/lkft/builds/2bc6x6cISHzG9Jgo0oAVv2OgLOG/build.log
> 
> 
> Hi Anders,
> 
> I see something similar but in the end it works. Despite the name, I
> also get perf.cpython-311-x86_64-linux-gnu.so generated in my build, but
> it's actually an arm binary.
> 
> For me I'm using python3.10, and the x86 config options don't include
> -fcf-protection which is probably why it can compile successfully with
> the arm compiler.
> 
> It looks like your assumption is correct and it's not using
> $(CROSS_COMPILE)python3-config but just python3-config. The answer to
> how to fix it is probably to start hacking at the makefiles, if PYTHON
> and PYTHON_CONFIG don't work either.

Right, that seems like a good direction in trying to fix this.

- Arnaldo

