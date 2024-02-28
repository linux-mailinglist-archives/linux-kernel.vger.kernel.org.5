Return-Path: <linux-kernel+bounces-85543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C102786B769
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA21B2169A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F89F71EB9;
	Wed, 28 Feb 2024 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rsqrd5CO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FD071EA4;
	Wed, 28 Feb 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145841; cv=none; b=AnJCYEDdhQTPNlhJIuFQrb0iyVurkUz1z1i83+0UL1ap1sxWCty0AjrXllVCnjgyKeBARN1M7MSJ+eldyqJMjecgUdqIFIIf28/iucokD4ovzbjIQ1TwuwGW+mVb31VENO416+Qy1nPUeDIIGir3cXV0hW+bR+kfLZ019tp6ThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145841; c=relaxed/simple;
	bh=d4REXzErWg5y+ljz5I+jMe6oFelwBUUA3uuPSjYv2uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTTHb/aLIbfKCYbcgWdw8rcXvJctfC9h9skYZiFSrX87nxoL9UyHlFCuJq124TuC1l091/EnPbzmprO8B1XCXf2NNmKF8G7MnwEqL2Np5A5C4y2F9e0Cl/8Mh2NFQcE8HALQsr6fYzf/FFZa7i6lBexpe3g9OCetp23kU3bG4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rsqrd5CO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82957C433F1;
	Wed, 28 Feb 2024 18:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709145840;
	bh=d4REXzErWg5y+ljz5I+jMe6oFelwBUUA3uuPSjYv2uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rsqrd5COCyM+KeeIBz5kmiyU2i4jfSG++56qd+0PfVItG7dZnKaR5eJUuQeVSQItJ
	 1aYqL9ev35IHqtqXWj6FY73ZkOF3e1WxlFvICHnnawEH8tlbG+xgECi7dZhzzgEz6P
	 JIpdsz57dvlhIAFnLl7TGsVWtEv8YvLn7T/OnXQqSGpxbs2wvRkQMLDD4Q44X83NFx
	 055r33Cwu5SLJUDHJ7ZfCDLjoQiB7l5AUGBkRsmhfwaYTvIMGsnkYoGaOXG+TKwImm
	 0ckInimfUQNeO66DHeB3Rv+ioLPnXJ6Pe/l0b4noBw/7O+iPZ7BOloOjiEOB5rOwC+
	 yAqbrI/5EUFpA==
Date: Wed, 28 Feb 2024 11:43:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Conor Dooley <Conor.Dooley@microchip.com>
Subject: Re: Prebuilt LLVM 18.1.0-rc2 uploaded
Message-ID: <20240228184358.GA139944@dev-arch.thelio-3990X>
References: <20240208002841.GA2601476@dev-arch.thelio-3990X>
 <CANiq72=G--5LW-9sg2PscTL863mFVNdnX7LUQX2Xj02qZs4crA@mail.gmail.com>
 <20240212234850.GB3221859@dev-arch.thelio-3990X>
 <20240213025303.GA4006766@dev-arch.thelio-3990X>
 <CANiq72npYCD-zKqcXPNOAxnKiUCCXGbFQaGo-8=0-171ni+ncQ@mail.gmail.com>
 <CANiq72kcQUuxcno00+QWrstrcfwC+2_Bvh+8dr5kgVkEtrWOEA@mail.gmail.com>
 <20240227153728.GA819789@dev-arch.thelio-3990X>
 <CANiq72mmDquTeoEVErwXH7bVhP0+UifCrK0n=-HD97noWLqryA@mail.gmail.com>
 <20240227215605.GA1422986@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227215605.GA1422986@dev-arch.thelio-3990X>

O Tue, Feb 27, 2024 at 02:56:05PM -0700, Nathan Chancellor wrote:
> On Tue, Feb 27, 2024 at 05:51:04PM +0100, Miguel Ojeda wrote:
> > On Tue, Feb 27, 2024 at 4:37 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > How far back would you like it added? I don't necessarily mind
> > > rebuilding older releases but certain entities may notice the checksums
> > > change.
> > >
> > > https://gitlab.com/Linaro/tuxmake/-/merge_requests/364
> > >
> > > Not the end of the world though.
> > 
> > I think a reasonable set would be those versions matching the LLVM
> > that Rust bundles (for `rustc` versions we have since 6.1 LTS). That
> > is: 15, 16 and 17.
> > 
> > Conveniently, LLVM 15 also matches the minimum external LLVM supported
> > by `rustc` in 6.6 LTS.
> > 
> > If those are too much, LLVM 17 would already cover what 6.6 LTS' Rust bundles.
> 
> 15 through 17 is a reasonable rebuild request, I've added it to the
> queue along with 18.1.0-rc4, which was just released. I'll message you
> when I have them uploaded.

This is now done, please let me know if there are any issues!

Cheers,
Nathan

