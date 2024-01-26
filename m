Return-Path: <linux-kernel+bounces-40526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D308083E1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA60284D02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF4F21A0C;
	Fri, 26 Jan 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YYItJv40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E820321;
	Fri, 26 Jan 2024 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294905; cv=none; b=ZB2hd/TjMu0he9C56uM+VtDms9qi/qfs+BZV6wTnw1e7//4sYYww6xGm3/g5gN3IRkDlXu3TfSRNx4RrJ0FqbVZDC4TUjqAKfOhMVQCQkGZtEDTznH0ivgYrUrHCpA9mXpThm2QWBcKkd7dBO7iI6oUpa4I2F6SqN9B8krffJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294905; c=relaxed/simple;
	bh=BnryrUApwZ0nI32BdUhHkFXOuwB01+MG4M5KXNOSAgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns7kWpHe9gkiuJa5oczYm42iLAyc1q/3+3HHl22+e793iHZAjPMIkwM9p2u39AmYGTHd2fp2Srqt9KNMB617Eq1ybNraoV7uSgGODG3hox/5L8vRoznVAKlX0qm8zjv7rXq6yz3lap9HXSIiNkwrMvn99lPF10vqPgKrn8p4IT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YYItJv40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2071C43390;
	Fri, 26 Jan 2024 18:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706294905;
	bh=BnryrUApwZ0nI32BdUhHkFXOuwB01+MG4M5KXNOSAgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYItJv40S++SCggpNYzSwWtrsVjncULPKgKTanfkHkHX3jl4t5RgFldXfzHqyc8Q6
	 UghPect/Av0dDoAIyggJPC7I5q4wnqAWH4bEiS8IPmeF7N6DiA8fomhzJW6Iq5U7km
	 UG3xBjdpUjh9YzBJggB9LP6fZFSoXg9lp9Z8leGA=
Date: Fri, 26 Jan 2024 10:48:24 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
Message-ID: <2024012646-glove-cabana-6e64@gregkh>
References: <20240122235732.009174833@linuxfoundation.org>
 <6b563537-b62f-428e-96d1-2a228da99077@roeck-us.net>
 <2024012636-clubbed-radial-1997@gregkh>
 <2f342268-8517-4c06-8785-96a588d20c63@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f342268-8517-4c06-8785-96a588d20c63@roeck-us.net>

On Fri, Jan 26, 2024 at 10:17:23AM -0800, Guenter Roeck wrote:
> On 1/26/24 09:51, Greg Kroah-Hartman wrote:
> > On Fri, Jan 26, 2024 at 08:46:42AM -0800, Guenter Roeck wrote:
> > > On 1/22/24 15:55, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.10.209 release.
> > > > There are 286 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > [ ... ]
> > > 
> > > > zhenwei pi <pizhenwei@bytedance.com>
> > > >       virtio-crypto: implement RSA algorithm
> > > > 
> > > 
> > > Curious: Why was this (and its subsequent fixes) backported to v5.10.y ?
> > > It is quite beyond a bug fix. Also, unless I am really missing something,
> > > the series (or at least this patch) was not applied to v5.15.y, so we now
> > > have functionality in v5.10.y which is not in v5.15.y.
> > 
> > See the commit text, it was a dependency of a later fix and documented
> > as such.
> > 
> > Having it in 5.10 and not 5.15 is a bit odd, I agree, so patches are
> > gladly accepted :)
> > 
> 
> We reverted the entire series from the merge because it results in a build
> failure for us.
> 
> In file included from /home/groeck/src/linux-chromeos/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:10:
> In file included from /home/groeck/src/linux-chromeos/include/linux/mpi.h:21:
> In file included from /home/groeck/src/linux-chromeos/include/linux/scatterlist.h:5:
> In file included from /home/groeck/src/linux-chromeos/include/linux/string.h:293:
> /home/groeck/src/linux-chromeos/include/linux/fortify-string.h:512:4: error: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                         __read_overflow2_field(q_size_field, size);
> 
> I also see that upstream (starting with 6.1) when trying to build it with clang,
> so I guess it is one of those bug-for-bug compatibility things. I really have
> no idea what causes it, or why we don't see the problem when building
> chromeos-6.1 or chromeos-6.6, but (so far) only with chromeos-5.10 after
> merging 5.10.209 into it. Making things worse, the problem isn't _always_
> seen. Sometimes I can compile the file in 6.1.y without error, sometimes not.
> I have no idea what triggers the problem. Of course, on top of all that,
> the error message is completely useless.
> 
> Either case, we don't use that code in chromeos-5.10, so reverting the
> entire series from the merge was the easiest way to proceed. But we really
> don't have an incentive to apply the series to v5.15.y because we don't
> need/use it there, and we might end up having to revert it from there
> as well if it is applied.

If this is causing build issues, I'll drop this, I was worried about it
during review but no one had any reports then, but now it looks like it
should be reworked.  I'll go revert them, thanks.

greg k-h

