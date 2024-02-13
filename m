Return-Path: <linux-kernel+bounces-62892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564BA852798
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E973B1F238A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF28C0B;
	Tue, 13 Feb 2024 02:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGk7uUHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BA8BE8;
	Tue, 13 Feb 2024 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707792785; cv=none; b=KgACR2dC4lfybvSMY1/PTcsXYCc8DrFoUKNuOuCH9m+ax4TBnA4qY4JCyoI5eJWJTlgbKZfjgCuOeL+jID4BohDJvn2oN8ePlWwxzMbzyErX5M3MoNuIuuXl1dhGDA2UTGZR2k3OiwlaoMsVTktSUTi5nSDkvp7+nrFCQAbDNQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707792785; c=relaxed/simple;
	bh=CAs0UMp0BUjGybDRGjh0Nyg6O4tl4J6ISVjwah+57MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRKjnzAQ0uDvYmhqbuYNgn3NULNhYiDn+GzHYGmGTKFx5kqBwJX8GPFyALiQDwix5rF46Y1lmV7JY/wiS6I0T4MFKIJFRiGIFmTo8mD5LaqyniC2NvcZ4QPh4F4WtDPHjXKjkZ7nsOeOG51Lu5YjV20NqeUzZwH0iawlJAdfj58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGk7uUHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D93EC433F1;
	Tue, 13 Feb 2024 02:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707792784;
	bh=CAs0UMp0BUjGybDRGjh0Nyg6O4tl4J6ISVjwah+57MI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGk7uUHg0aWZlEP6w6wzMkOo2Y/yS76VDz8euCfjoGqlyjyhcFLmUzNyBNikw6qns
	 dePhwicnPM86j2thaGSc/CcCJR0qb+nSF/LPctPfx9Q1TlPgiTvufrTB7DTq/06Fv1
	 m+weN/Jv2U8HA8SLYcWsLHtzH7qsGrR3HT+7v7R4O0ZfOpeulAviP0l0t58GplIJ8X
	 yZdw96zDmJDJWk/ZfHikVo0Sl6vmwkZhPMRl3EXs+PaUZ2glPhiOLnJgkuZZzA8QRu
	 xYRTOHF30pKLqf+gIQyCrULaxg2S3+mATIRZpnUCtw8Mew+CMj1NNZg8lai0beP7Bl
	 84Y9hfwpyhqUw==
Date: Mon, 12 Feb 2024 19:53:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Prebuilt LLVM 18.1.0-rc2 uploaded
Message-ID: <20240213025303.GA4006766@dev-arch.thelio-3990X>
References: <20240208002841.GA2601476@dev-arch.thelio-3990X>
 <CANiq72=G--5LW-9sg2PscTL863mFVNdnX7LUQX2Xj02qZs4crA@mail.gmail.com>
 <20240212234850.GB3221859@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212234850.GB3221859@dev-arch.thelio-3990X>

On Mon, Feb 12, 2024 at 04:48:52PM -0700, Nathan Chancellor wrote:
> Hi Miguel,
> 
> On Sat, Feb 10, 2024 at 05:36:01PM +0100, Miguel Ojeda wrote:
> > On Thu, Feb 8, 2024 at 1:28 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > I have built and uploaded a prebuilt version of LLVM 18.1.0-rc2 to
> > > https://mirrors.edge.kernel.org/pub/tools/llvm/.
> > >
> > > As with Linux -rc releases, this is not the final version that will
> > > ship. If you run across any issues, especially ones that were not
> > > present in earlier LLVM releases, please consider reporting them to us
> > > so that we have a chance to investigate and fix them before the final
> > > release.
> > 
> > I took a look at the LLVM 18 prerelease to see if these would work
> > with Rust for e.g. CI and other users (instead of using the
> > LLVM-provided apt ones, for instance), and noticed it does not bundle
> > `libclang.so`.
> > 
> > Would it be possible to include it so that we can use `bindgen` and
> > thus enable Rust with them?
> > 
> > I understand they are intended to be minimal toolchains, but if you
> > think it would not be an unreasonable overhead, then it would be great
> > to have it.
> 
> Absolutely, I am more than happy to include libclang.so and anything
> else that would be useful for the kernel. Everything gets built but I
> only install what has felt needed for the kernel, so there is no real
> overhead aside from package size, which obviously should not increase
> much with this change. I've added the targets to my build scripts and
> kicked off a set of builds. If they finish successfully, I will upload
> them so that you can test them out and make sure they will work.

Alright, I reuploaded 18.1.0-rc2 with libclang.so included, please let
me know if this will work for you going forward.

Cheers,
Nathan

