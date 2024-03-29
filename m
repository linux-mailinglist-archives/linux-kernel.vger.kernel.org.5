Return-Path: <linux-kernel+bounces-125061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6073D8920E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B504B25501
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0D612A157;
	Fri, 29 Mar 2024 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rFKYRxMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396612A154;
	Fri, 29 Mar 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718639; cv=none; b=RHdQxU9eSo6SPyg/8r15dzUnUPD9S93RfiqdIijXQjEy8pGMzz1tfVeWEVcu09GUv5ECjNtEufOLkkhQ53dxO9jajsI7rXNn6mYmaok+E/DaMxqaXcCTXisZL/lfu1eRbUsLzUeSu7ofUNb4Qp0ojc0AYVwJGXaD47K/+7AOstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718639; c=relaxed/simple;
	bh=bQx/BXOUSe4TNoDtXR2BXWY0aFMLcADXigMMWJW/L3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pck9qzt8qi8viidWtHlFAoWLB82JaYLff0bQSKiCMOyejoWJp+rZWc8RXd4i3mB0HINt0NzyYCmkceq4HUDYNXfVnXUT1aVkkD0UmBi9wXnfiELrLc/rfy84tiV5n8cnGg0X4HIwYISEGl7RhpMTMyzI6ePdwH0ZBLQ7UJND/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rFKYRxMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D88C433F1;
	Fri, 29 Mar 2024 13:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711718639;
	bh=bQx/BXOUSe4TNoDtXR2BXWY0aFMLcADXigMMWJW/L3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFKYRxMFWgbTseJJMATejdwMQAFlQv/Gg01agjZQWEoWMUuHtWmzii0H62Wzpj5KT
	 wuktrBJ0GoAHlP5XS1yvLuqjYvss3CWMTe1AnvlI8Hc9WtLczeN0VHc6JwfzhxEcHJ
	 IW/M9vWYf3kCbr3JTTZZT+rhIEPz01karffLPpVI=
Date: Fri, 29 Mar 2024 14:23:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: FAILED: Patch "powerpc: xor_vmx: Add '-mhard-float' to CFLAGS"
 failed to apply to 5.10-stable tree
Message-ID: <2024032925-tapering-correct-c88c@gregkh>
References: <20240327122007.2835763-1-sashal@kernel.org>
 <20240327151613.GA1153323@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327151613.GA1153323@dev-arch.thelio-3990X>

On Wed, Mar 27, 2024 at 08:16:13AM -0700, Nathan Chancellor wrote:
> On Wed, Mar 27, 2024 at 08:20:07AM -0400, Sasha Levin wrote:
> > The patch below does not apply to the 5.10-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> ...
> > ------------------ original commit in Linus's tree ------------------
> > 
> > From 35f20786c481d5ced9283ff42de5c69b65e5ed13 Mon Sep 17 00:00:00 2001
> > From: Nathan Chancellor <nathan@kernel.org>
> > Date: Sat, 27 Jan 2024 11:07:43 -0700
> > Subject: [PATCH] powerpc: xor_vmx: Add '-mhard-float' to CFLAGS
> 
> I have attached a backport that will work for 5.15 and earlier. I think
> you worked around this conflict in 5.15 by taking 04e85bbf71c9 but I am
> not sure that is a smart idea. I think it might just be better to drop
> that dependency and apply this version in 5.15.

I'll go drop it and take this version, thanks!

greg k-h

