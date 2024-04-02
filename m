Return-Path: <linux-kernel+bounces-128648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AC2895D70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDB31F25ADB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C9515D5B9;
	Tue,  2 Apr 2024 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da9ZUqdI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65C515D5A3;
	Tue,  2 Apr 2024 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089070; cv=none; b=PpgKP9aPf/TrDMjQw9z0+9zGso2csu6InDKOuthGSDHN4ykxfUbkIy5KpwV7uOO4pZmvCTEewa5F1LnET7sOmvSFp/LGotkdfCMpu7Lm378kIVTmSWDIvbiFd8kkmCtBLS9xFhsxT1bHtDFdZQICVyXztiFMfLee0S22YBiiDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089070; c=relaxed/simple;
	bh=96iocZd5ustauxh3FiwURa8D+ou4eiLJnlw9KYvy/rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdxpICgN5ipxa0oMpxkQTwn9XzMTdLVe4Shjc3FGiH5i7wUYPj6DKkyoQOXmnGbS8ZxiLAozkKjl0uLfv2JLnkJWvToULuwHZRR4zVCWWYROWnYrUsCLdQs82LZUiS+O+npeMG4Yf7Z6Xv6rcPwNXU/jiY1u/ZxxFp3qxaUXHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da9ZUqdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1C8C433F1;
	Tue,  2 Apr 2024 20:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712089070;
	bh=96iocZd5ustauxh3FiwURa8D+ou4eiLJnlw9KYvy/rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Da9ZUqdIVrpsoX7s2d85LH6plOALCLB4vYOjJvbBryaOw2549LUGYopRn/wUey+Tm
	 lcTnP17Jp4oMxrA4Y6gytDnwseWGNWLtSvd6nJ5lZ1A3V08SoDd/Or0SExsz5emQES
	 lrJiH+4ZBlvltLDMDx6rglHev9HAPu53KdRW8/trP1QQ6CaZnyeNxh1zt140ue6cvl
	 pNGoxlto2xzk+o2XdMjDhWsRssYxwjfzUPkPj6RY6mJaAD5ZROCmvkO2WtWGgC+ssK
	 dEzyNjvPyLskdVyLPtnGvlGb2o/3yBafzu4eRUpoiojC+bjOahUelPxdvYfFicWhcJ
	 8fafesRLGYKAg==
Date: Tue, 2 Apr 2024 17:17:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <Zgxn68ECer9n8xbh@x1>
References: <20240402094116.79751030@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402094116.79751030@canb.auug.org.au>

On Tue, Apr 02, 2024 at 09:41:16AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the perf tree, today's linux-next build (native i.e. ppc64le
> perf) failed like this:
> 
> make[3]: *** No rule to make target '/home/sfr/next/next/tools/include/uapi/linux/stat.h', needed by '/home/sfr/next/perf/libbpf/staticobjs/libbpf.o'.  Stop.
> 
> Maybe caused by commit
> 
>   f122b3d6d179 ("perf beauty: Introduce scrape script for the 'statx' syscall 'mask' argument")
> 
> or
> 
>   a672af9139a8 ("tools headers: Remove almost unused copy of uapi/stat.h, add few conditional defines")
> 
> or a combination of them?

Right, these are headers that were used to extract string tables but
were added to a directory that was also used to build tools, sometimes
because headers contained new defines that wouldn't be available in
older distros.

We're trying to move things that are needed just for creating string
tables to a separate directory, as done in the second cset you mentioned
above, how to do it in a way that is noticed by the dependency files
cached by the tools build processes is what is needed here.

I planned to investigate and fix this, but this was preventing
development work to proceed as 6.9-rc was released, so I ended up moving
these to perf-tools-next, I'll try again to investigate the deps issue
to make this (and further work in this area) to avoid requiring these
'make clean' steps.

> This is an incremental build but doing 'make -C tools/perf clean' and then
> rebuilding works, so maybe there is a dependency missing?

Thanks for reporting.

- Arnaldo

