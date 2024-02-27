Return-Path: <linux-kernel+bounces-84076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D3886A200
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F4B284B16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E6C14F998;
	Tue, 27 Feb 2024 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7Pd0toZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571614E2C6;
	Tue, 27 Feb 2024 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070967; cv=none; b=Qar73Nv1YtdkR9gEEo0EBH9zKNpzg2JLmRRNxCP0eTVF+F6t7p1hAn1vwMG440641tXrrMwjWLB2GTc8OOx8NJnkVn/yqisijbunCsMxDyphBzYrJrX4Ivg8WBijm4PJzELNM91D5+Ht1vbz/fbuiyS3oUi6JRmINTY4AC77YA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070967; c=relaxed/simple;
	bh=WE8CL4QtAOdJd0hGsGhSMWCPnxYXa54ehLf4NTnJc5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM8Sr8pi/ffTBmIa0n+cFGrMGaQo+/41KuGr/nyk1ou7G3WhRRhhJVOLqKtgRdIVNF2/DJpH3BpgDtfHjw8Eqaz/5SKCdsBxG6Gz22Je2+iu+bbaQz7gxFPnRvEeMtpOfOQDu9UyU6xJ0iDh4v4IIkfg/ZY/EBj8jCh7c70kfZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7Pd0toZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09B3C433C7;
	Tue, 27 Feb 2024 21:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709070967;
	bh=WE8CL4QtAOdJd0hGsGhSMWCPnxYXa54ehLf4NTnJc5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7Pd0toZ3ju4XBbb+MgUxvEA0eXI1IUfH7FKlF0ZZVfvsaM8lbqRfrVtO8ufRb/rV
	 j8mHTc19vlRUN1gUIk3Q2yA1VqHS0m1HKpLeTFAksHmUPrLeIyNSaZh6iUaOeecNX2
	 gNKosWkjWEOBewoTsr5GC7JCZxICWK6/Y6MD2vMDcpXc0xAiAFqEWW4Xe6ppfbfdzK
	 HCQ4cGO8doVYbIITv1TXyFymaYeVnG+T9yh5KKQxp/fow7DeulnFxiFv2sSUM3a1T7
	 qBNcD7hKULgHBhQVP/wnVgztQo08mIvygPeg8cmXfN5NU8Mbr8fAR77ADfKHRIaudk
	 JowNeBHuWBFSA==
Date: Tue, 27 Feb 2024 14:56:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Conor Dooley <Conor.Dooley@microchip.com>
Subject: Re: Prebuilt LLVM 18.1.0-rc2 uploaded
Message-ID: <20240227215605.GA1422986@dev-arch.thelio-3990X>
References: <20240208002841.GA2601476@dev-arch.thelio-3990X>
 <CANiq72=G--5LW-9sg2PscTL863mFVNdnX7LUQX2Xj02qZs4crA@mail.gmail.com>
 <20240212234850.GB3221859@dev-arch.thelio-3990X>
 <20240213025303.GA4006766@dev-arch.thelio-3990X>
 <CANiq72npYCD-zKqcXPNOAxnKiUCCXGbFQaGo-8=0-171ni+ncQ@mail.gmail.com>
 <CANiq72kcQUuxcno00+QWrstrcfwC+2_Bvh+8dr5kgVkEtrWOEA@mail.gmail.com>
 <20240227153728.GA819789@dev-arch.thelio-3990X>
 <CANiq72mmDquTeoEVErwXH7bVhP0+UifCrK0n=-HD97noWLqryA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mmDquTeoEVErwXH7bVhP0+UifCrK0n=-HD97noWLqryA@mail.gmail.com>

On Tue, Feb 27, 2024 at 05:51:04PM +0100, Miguel Ojeda wrote:
> On Tue, Feb 27, 2024 at 4:37 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > How far back would you like it added? I don't necessarily mind
> > rebuilding older releases but certain entities may notice the checksums
> > change.
> >
> > https://gitlab.com/Linaro/tuxmake/-/merge_requests/364
> >
> > Not the end of the world though.
> 
> I think a reasonable set would be those versions matching the LLVM
> that Rust bundles (for `rustc` versions we have since 6.1 LTS). That
> is: 15, 16 and 17.
> 
> Conveniently, LLVM 15 also matches the minimum external LLVM supported
> by `rustc` in 6.6 LTS.
> 
> If those are too much, LLVM 17 would already cover what 6.6 LTS' Rust bundles.

15 through 17 is a reasonable rebuild request, I've added it to the
queue along with 18.1.0-rc4, which was just released. I'll message you
when I have them uploaded.

Cheers,
Nathan

