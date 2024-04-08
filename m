Return-Path: <linux-kernel+bounces-135328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2202C89BF13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1565281696
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6F6F06B;
	Mon,  8 Apr 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh3RBVdr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2CA6D1CC;
	Mon,  8 Apr 2024 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579857; cv=none; b=CzU9YRrJUtI7GTpM5quDbCNj4X9gPXi89JHnx7s+iRCEAovIuDqlIhLCarvbqsrDUYrrWFs5QU8ba9MN41ZyoDD+FrQTyxigZ34Lzh9scLbnqf6nobFmiU29vOg+eMLFkP99mDoOirI/a3kmAUWq73KmWQjNOY2mAiJjgYzicg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579857; c=relaxed/simple;
	bh=eKyMOCTmzVpas0Ku4p4aIG2DFODmyGN4nePJuS4aVi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez138fxixe8afbqi2LcXnsIia5O/nwN9Kpu9g+iuA3HQXlV5TjceHh1y0PL83x+gi1FIsliJb47SGbM4c3rxTSo5SsE2Ry013gy/lcZIdhJmnPWPT3nwQCitZEmzPIq5IOtu5BKUmAKh0F4XtHMOP3N8M16EpzHLz35L7rSZckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh3RBVdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF87C43330;
	Mon,  8 Apr 2024 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712579856;
	bh=eKyMOCTmzVpas0Ku4p4aIG2DFODmyGN4nePJuS4aVi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oh3RBVdrQUr0HMr7a6y+Rg3f9nttVQFy1Q16vLI3P/3flHrCAI5uw9qF8pmkzecAa
	 brNKRKJBx7iFo+WzQ8EsitaTQaQZauWSZiEYzsbxIRo8E6E6nDFa0OtQ7Ft45XJM2p
	 5ld8UnVNfTcs6T61SlF/AxllTzz6Ya4vlBVm/5jk5Pcf26wpusITKcIej73GuZbi89
	 CSIxAtA8dqfz2wPo6z1mVtGb6Q6dhQA0PiuQts4LvYFcVQZodZBIbRSnLyLvYHSVQ6
	 Vk/5TcYcsOO3g1a1ilIy4fndG7dx8W1AKKgdMJv0vrMJua/SeKrvFTqAf0l6F5Qc9w
	 oeYc1WlYHNyYg==
Date: Mon, 8 Apr 2024 08:37:34 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Stefan Kanthak <stefan.kanthak@nexgo.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	tim.c.chen@linux.intel.com, sean.m.gulley@intel.com
Subject: Re: [PATCH 1/2] crypto: s(h)aving 40+ bytes off
 arch/x86/crypto/sha256_ni_asm.S
Message-ID: <20240408123734.GB732@quark.localdomain>
References: <5EEE09A9021540A5AAD8BFEEE915512D@H270>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EEE09A9021540A5AAD8BFEEE915512D@H270>

On Mon, Apr 08, 2024 at 11:26:52AM +0200, Stefan Kanthak wrote:
> Use shorter SSE2 instructions instead of some SSE4.1
> use short displacements into K256
> 
> --- -/arch/x86/crypto/sha256_ni_asm.S
> +++ +/arch/x86/crypto/sha256_ni_asm.S

Thanks!  I'd like to benchmark this to see how it affects performance, but
unfortunately this patch doesn't apply.  It looks your email client corrupted
your patch by replacing tabs with spaces.  Can you please use 'git send-email'
to send patches?

- Eric

