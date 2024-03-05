Return-Path: <linux-kernel+bounces-91492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85440871252
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7BEB21A0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4C712E47;
	Tue,  5 Mar 2024 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgcXCV5j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA622FBE9;
	Tue,  5 Mar 2024 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601921; cv=none; b=fl1kQSleVwL0YBNXBtISTwu2Lw1DhQM7YlRWXKySEolmC6NxOHMKE5fGg9+MF3wptj8Q/1bbhw/NVLfXxt7Jur0u2KQSJqgv211a6DT1KMhTHu2alfxqwdi3Ly8ZZAUymSXnn00fzQtKLYWScVLuFDenl0iqfl1a5IVgXqovPMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601921; c=relaxed/simple;
	bh=3eIZaoNoVA0xwK38cSKb+8zYI7Km58J2uaElmQ1tjJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnVpxSZjW20bv4tL0aPl6fu21jqP8UnCeBq3wo3tFYR11p0BKlaCYX0gfoTg7O9sumUJ5MhVp4KHbN7mB3pYbeldKLCgYBSXaoku14HNsfE/fszp6l89lsB2clzdrXsSm8vqVdYvUp6pCSbP0z/KIpmHRtVvOFyhpqvNEzimAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgcXCV5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2457EC433F1;
	Tue,  5 Mar 2024 01:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709601920;
	bh=3eIZaoNoVA0xwK38cSKb+8zYI7Km58J2uaElmQ1tjJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NgcXCV5jkJwfzWMeWFz9khwq/bJSF+w5B7R9RqMjTx0PPH6d02+DevppTIBM8jfHt
	 JjR4LEgHH2LVPUUCIl8sCLFKf0iaQHJmarcw+kYVr9gy1YvcO/gTbC1lKxmZgf2ovG
	 sd6XfpKMZjnYbe0XXZJ5fRRPZjSO4z0Pitv4L3R2uphQOVqfQVConnIwCsPIx/3ABg
	 VSHEgIdMIevezNS8A0CtCUOIoVCVQrQkz1xzh6NENkBXALgt85RsSWBA5PYZLs0Z7C
	 x9t6IAeFZISr9PHXESP+HdA7unjEoQQQXhuROu8wAhSfIlHUKYa0tELcmjovcYO6u0
	 Uy7Yao49LP8sg==
Date: Mon, 4 Mar 2024 17:25:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.8-rc7
Message-ID: <20240304172519.1d7a4e91@kernel.org>
In-Reply-To: <35a869c8-52e8-177-1d4d-e57578b99b6@linux-m68k.org>
References: <CAHk-=wgwt9b3yMxAQRCVJ0Jh6-4Dz1Fgo2au7g_U9VWVxXoS6Q@mail.gmail.com>
	<20240304083122.361773-1-geert@linux-m68k.org>
	<35a869c8-52e8-177-1d4d-e57578b99b6@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 10:00:07 +0100 (CET) Geert Uytterhoeven wrote:
> arm64-gcc5/arm64-allmodconfig
> mips-gcc8/mips-allmodconfig
> powerpc-gcc5/powerpc-all{mod,yes}config
> powerpc-gcc5/{ppc32,ppc64_book3e,ppc64le}_allmodconfig
> sparc64-gcc5/sparc{,64}-allmodconfig
> x86_64-gcc8/x86-allmodconfig

Ugh, we had an earlier report but it didn't cover rcu_assign_pointer()
or at least we missed if it did. Fix on the way, thanks for the report!

