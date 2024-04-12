Return-Path: <linux-kernel+bounces-142114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F38A27B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53389B27C4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170EB4C624;
	Fri, 12 Apr 2024 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuBoEaBE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E14AEE0;
	Fri, 12 Apr 2024 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905800; cv=none; b=IyKiIF0NSkCiOGuRSqvf7ImS6UDUHm5DiCP6SabsCkAeklqUpAS4cCgW4/RyTUKtVqzuCFLktjPc89UzMlu6w/n0SpGhAbJFHLROXrgtpPoGnDnoT8V7AyNCmGB/rMtpez8dxNsrB1bst2A11cMu2goEcVE2ERXwbB6wGG5S5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905800; c=relaxed/simple;
	bh=tCLqJRABRY6ap/jqeS8uIjvqA260Xzo22ky+g6GjZPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEbpIGacUrkch3aACMaRXcpwOrwOMyMLazLMKm9v1+r4H4Z6KV1Yaz6ywoIcLhDrlZJ21ln+JgWdjRPwRcKEEwjeQU8DDoMb7Oonv6/5nz/Ko9j6cWj/ClQnZeHWYMy+I/6FbxdbzEYLCgVNzcExLj4jxmLzKCX6TQi9BQCPT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuBoEaBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BC1C113CC;
	Fri, 12 Apr 2024 07:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712905800;
	bh=tCLqJRABRY6ap/jqeS8uIjvqA260Xzo22ky+g6GjZPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tuBoEaBEvU6S2J/Jyldd7k4jVIyEKQkl9xGepxwQ3AW49QIn83xv4mckRGSEqB7Go
	 85YhBanhfdGrS+wTa36RMf55wI7pQOGKeobYKGZoDIkZzvj4Jdm2FmYPqVc7trhFYg
	 hsSoYen8zuVHg51tj0mFCli7yy2Q+CNb7/OpxEdB+6FBXom9safo7DVxkS1bjNMrBI
	 eOviwHgEZamj+4AgnKvEdI+kOAU02nMaJncgMkjeInW+QIuxq5qu6Ma47SX7oNFRxS
	 naRtMjMXM6L+w2Bj5iy0QQKGgcgWeAmHn3KxwlVj0md2LWF80DG5nFbPnmwJZhRAgp
	 vRg1Tquj5G/Fw==
Date: Fri, 12 Apr 2024 08:09:56 +0100
From: Lee Jones <lee@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the leds-lj tree
Message-ID: <20240412070956.GL2399047@google.com>
References: <20240412140101.45d125c3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412140101.45d125c3@canb.auug.org.au>

On Fri, 12 Apr 2024, Stephen Rothwell wrote:

> Hi all,
> 
> The following commit is also in the backlight tree as a different commit
> (but the same patch):
> 
>   da8310b24223 ("video: backlight: Make backlight_class constant")
> 
> This is commit
> 
>   47e184e212c7 ("video: backlight: make backlight_class constant")
> 
> in the backlight ltree.

Thank you Stephen, that's now resolved.

-- 
Lee Jones [李琼斯]

