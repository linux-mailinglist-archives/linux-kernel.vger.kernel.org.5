Return-Path: <linux-kernel+bounces-71706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE2585A94C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D384B24C23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3602F41C8D;
	Mon, 19 Feb 2024 16:49:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF741C7D;
	Mon, 19 Feb 2024 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361361; cv=none; b=fi2oFL1BGqDo6ZIFD/1Rn1Gi9AOFTs4vBD+yq67qnh+9ZRL8zz944KbuD91vAKpGandeq9jL/v+HcuZGNaD/2mVa1ugTybSCFDZ7FcdJhsSUbV/62I4zodQYgdmfqM596PB95UEGzGxt7sXcWQaJKVeoVcjTAeMym/6l5Jq3QLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361361; c=relaxed/simple;
	bh=1Dg7pxDMbg8XS4tLmwzr2u4mMw8LyERdAhO8F+8W8eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaD+qqMuA+2ft8YFfdIdgySktw97ly7pSnsqcXVfF6NaeJLCQm9AkTYPZMB9WBpUltJkl5Uk7j5C4IYUNzWcP5jpxy8hFUnouK/qxC93rqD8f+SmAXf9pToLJNPdlTlG3ls1p+O1eoDumXBSobVM4rekhNqYKybIEB3rd027E9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302C4C433F1;
	Mon, 19 Feb 2024 16:49:18 +0000 (UTC)
Date: Mon, 19 Feb 2024 16:49:16 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Christoffer Dall <cdall@cs.columbia.edu>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <ZdOGjPfnJMoF1LH0@arm.com>
References: <20240219135805.1c4138a3@canb.auug.org.au>
 <ZdNGGrUDWfvqCudV@arm.com>
 <86bk8c4gyh.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bk8c4gyh.wl-maz@kernel.org>

On Mon, Feb 19, 2024 at 03:22:14PM +0000, Marc Zyngier wrote:
> From f24638a5f41424faf47f3d9035e6dcbd3800fcb6 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Mon, 19 Feb 2024 15:13:22 +0000
> Subject: [PATCH] arm64: Use Signed/Unsigned enums for TGRAN{4,16,64} and
>  VARange
> 
> Open-coding the feature matching parameters for LVA/LVA2 leads to
> issues with upcoming changes to the cpufeature code.
> 
> By making TGRAN{4,16,64} and VARange signed/unsigned as per the
> architecture, we can use the existing macros, making the feature
> match robust against those changes.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Thanks Marc. I applied it on top of the arm64 for-next/stage1-lpa2
branch.

-- 
Catalin

