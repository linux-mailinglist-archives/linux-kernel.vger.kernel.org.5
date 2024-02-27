Return-Path: <linux-kernel+bounces-83515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE342869A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8BD1C24524
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B7E1468F1;
	Tue, 27 Feb 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIX84Dk/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55552145337;
	Tue, 27 Feb 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048252; cv=none; b=D6y9baBQQ70mjfAqv8gMBa6yW04QGzcMRTGQTbF0jv0dVec6fiNOW4TATW7db1h3jY/C/0Gxdx+ZKt6FpUv5Gg4qdAKaveHZtcMzHvBxCmCaVTllJ8KBTdgiIfVltF4M7y/jl5/SLujym3dgshOFps+8yQhKVJ6fioctCM4artY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048252; c=relaxed/simple;
	bh=wKhv+uomFSUgNXE9gZvgIBnM26YZ9IHwLIEHSELs1Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ13mcYLRjnpNbpcPlNqOeCpx5VjQYCpzVZSzgDPpgFWkBGRhBje+ObLO1sKgDjjmPRw2oaue99dmRi3MCwFgdFcH/mO4Q0u6ZoRI1ILL7n4s9lkwhh3aIXLtjKeI7gONagcTR5tRCMCP1nftwfKa6+g5NpzY/z864RA3YnRacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIX84Dk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806A1C433F1;
	Tue, 27 Feb 2024 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709048250;
	bh=wKhv+uomFSUgNXE9gZvgIBnM26YZ9IHwLIEHSELs1Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIX84Dk/bpBALOLXu1Amgyu0FM11Mm/oPon76AqIRSH4RHSKwOEfVTeulFOTGpN+T
	 PW6+aNQtLHtHdsxwRPaYm54unRSdBjXExq3ksthfRdpjfPEF9dfAF3YiKqywo3Ugfz
	 77zJukr1JqzfPOCxRyuuQaGsSgk7/EwyeugmJhPHnxRlfLe/UUndsZPOD1Gy25BwMZ
	 du/ryXkR6qE2a6KVQ/RyH7X1+nWajJuOtNnh5c6vxLeTNU/g8//VdbdN9mPSEndt8U
	 F668jMC/Ox13HiRiGeixFw0oNX4n3w1OZypqieXun0hqUAyORyiRliG1BOKwkigoXC
	 t3RRTrbCInLJg==
Date: Tue, 27 Feb 2024 08:37:28 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Conor Dooley <Conor.Dooley@microchip.com>
Subject: Re: Prebuilt LLVM 18.1.0-rc2 uploaded
Message-ID: <20240227153728.GA819789@dev-arch.thelio-3990X>
References: <20240208002841.GA2601476@dev-arch.thelio-3990X>
 <CANiq72=G--5LW-9sg2PscTL863mFVNdnX7LUQX2Xj02qZs4crA@mail.gmail.com>
 <20240212234850.GB3221859@dev-arch.thelio-3990X>
 <20240213025303.GA4006766@dev-arch.thelio-3990X>
 <CANiq72npYCD-zKqcXPNOAxnKiUCCXGbFQaGo-8=0-171ni+ncQ@mail.gmail.com>
 <CANiq72kcQUuxcno00+QWrstrcfwC+2_Bvh+8dr5kgVkEtrWOEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kcQUuxcno00+QWrstrcfwC+2_Bvh+8dr5kgVkEtrWOEA@mail.gmail.com>

On Tue, Feb 27, 2024 at 01:32:36PM +0100, Miguel Ojeda wrote:
> On Tue, Feb 13, 2024 at 9:37 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Thanks Nathan, that was quick!
> 
> Is it possible to add libclang for the older toolchains? Or are they
> supposed to be immutable?

How far back would you like it added? I don't necessarily mind
rebuilding older releases but certain entities may notice the checksums
change.

https://gitlab.com/Linaro/tuxmake/-/merge_requests/364

Not the end of the world though.

> Relatedly, Connor reports KCFI not working with LLVM 18:
> https://lore.kernel.org/rust-for-linux/20240227-uncertain-amaze-6197e627ad95@wendy/

I see now this was PEBKAC :)

Cheers,
Nathan

