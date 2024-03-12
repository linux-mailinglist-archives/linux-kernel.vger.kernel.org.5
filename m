Return-Path: <linux-kernel+bounces-100133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0CB879251
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2E91F2285E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6968469D09;
	Tue, 12 Mar 2024 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEfXXzEw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A315955E73;
	Tue, 12 Mar 2024 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240164; cv=none; b=DyxU+WdrBk87nHuR9auvELbecff6BhVlCC4XbKlHbBx7uS9TtY0jCejZa3yOdG31pfpUSvOq7juGjuAfuSOeZj6gCS7MEdlpWMqp+jkz4+h/nc30gqQj2eRUCOIDmibzlCXaI75dwZK/ETH7CInESajMJpwRg24RRjf1CEgu38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240164; c=relaxed/simple;
	bh=3Hm/MYg22uTG/hGFgFvZ24Uyx08CNOOkluWrBAt/nsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9JF6JXudd5F9vap89u9aYl4LgnVkLRGJv2SHJWvqBVv8snVjNX4yjJtENqXKmkYisyiasTwE2LUDcb8sEqZQzWR59T0p+fVMjQMvtSvb8vjjKe2CAkxG4DVtTcdJWdvYVHgbHqOWG/xIFNM/7odLFunzWaT8fgiabz2ubUvp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEfXXzEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E13FC433C7;
	Tue, 12 Mar 2024 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240164;
	bh=3Hm/MYg22uTG/hGFgFvZ24Uyx08CNOOkluWrBAt/nsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEfXXzEwiPC1ZZEFMmekKYkXFixj7tq6ibOLE2X+dQvgA+K30zIsMFY7fh7DBFCTu
	 u/OHpQmN3tSAN+o1+fZX0mNeDAt12VcnxD+2qAyp/ZiVdKYlTr4azUGy+o6llC/f5b
	 0qwElm9mj67qFjy80VYleTSf+DsDYDAXKBa/VdJRYAlzX1E+WTxFpv6P5APddw1cOW
	 chhxB8DgYkSiD8wWi4+nYmpC8HoiSWNJ4FBGmzQ22akCm88pCBht7hnXZUK3hfVF+v
	 tsxT0BheWdXku6lgcJktc3RUuIwC824/0nDCAzugRTXJmt7u8mRTqAXy4T2XgQ3Hox
	 1YBmWAK/GeBUA==
Date: Tue, 12 Mar 2024 11:42:39 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the i2c-host-fixes tree
Message-ID: <eswu6tcsrk4gusitf7wnfnjajpagusuz4sl7ylubjtejd667ps@ixucxjzc4sdn>
References: <20240312081558.014deb45@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312081558.014deb45@canb.auug.org.au>

Hi Stephen,

On Tue, Mar 12, 2024 at 08:15:58AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   1f78f0901011 ("i2c: aspeed: Fix the dummy irq expected print")
>   7c16cfd69d51 ("i2c: i801: Avoid potential double call to gpiod_remove_lookup_table")
>   ace9dc1d1251 ("i2c: wmt: Fix an error handling path in wmt_i2c_probe()")
>   b60b86b55400 ("i2c: i801: Fix using mux_pdev before it's set")

we've had quite a few in the past release in i2c... will fix it
from the next release.

Thanks,
Andi

