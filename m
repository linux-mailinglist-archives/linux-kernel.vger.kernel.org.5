Return-Path: <linux-kernel+bounces-105072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359F187D8C3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6376282731
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611226AB6;
	Sat, 16 Mar 2024 04:39:09 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE09610D;
	Sat, 16 Mar 2024 04:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710563949; cv=none; b=Qf/YnKsiZVFLyop1N45F0Fhl74Gd04scm2s++IEsQwKRvNB1Wkc8eUlrNO+Wc2+yw2HLs0nvhp9kKgSqpd+PIjdc/1K9xPBGHIaCdOlvyw6kxRb5zUAKOgXzJTP9PLg7Ysjis0Vax+brA02bpGAOLHDpBhn84KBio96yhjE75pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710563949; c=relaxed/simple;
	bh=ZlZFZDfAROAGSzJmzECla/BWQwennPw5YADMwd0x53Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdSgOtvQgnJw6V568UH/33w2qsoyvA2swp4k3F7qsybnbj9Jw1sgvgl5eG3vUW2knyZaoIUhuPMZ7lgZYtsblUg5195GRmovhQ5m5ClmRZ0sP9hsBj9JGEwUyl+4DD5VzGm8Rawrjonkv3y0q1ynFlSJBAYLVZ6jd3osJW74ALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rlLol-007X2L-Hb; Sat, 16 Mar 2024 12:38:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 16 Mar 2024 12:39:03 +0800
Date: Sat, 16 Mar 2024 12:39:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [GIT PULL] Crypto Update for 6.9
Message-ID: <ZfUiZ/cETFPW4h0O@gondor.apana.org.au>
References: <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
 <ZfO6zKtvp2jSO4vF@gondor.apana.org.au>
 <CAHk-=wirkYjV=-R0bdtSTLXSAf=SkcsXKCsQeKd0eSbue1AoDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wirkYjV=-R0bdtSTLXSAf=SkcsXKCsQeKd0eSbue1AoDA@mail.gmail.com>

On Fri, Mar 15, 2024 at 02:51:47PM -0700, Linus Torvalds wrote:
> On Thu, 14 Mar 2024 at 20:04, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > Drivers:
> >
> > - Add queue stop/query debugfs support in hisilicon/qm.
> 
> There's a lot more than that in there. Fairl ybig Intel qat updates
> from what I can see, for example.

Sorry, one line got chopped off while I was creating the signed
tag:

- Improve error recovery in qat.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

