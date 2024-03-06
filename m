Return-Path: <linux-kernel+bounces-93732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3200B873420
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91802B2CB2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AF45F862;
	Wed,  6 Mar 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="xz9DwYt0"
Received: from bee.tesarici.cz (unknown [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4E85FB9C;
	Wed,  6 Mar 2024 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720292; cv=none; b=nm56Z1YVPGWr15cbAbX5f+cfAVSuOh+zXXw1tC5l/np7/Ppk+hX2n2aFyWSlou4YXwflctW66NMyeD4SJhXLOagJ9U8RlVqOEqDvihvUKVTp7vOpEwxtCPurvQa/gfsTLoFjrPZXOnL8P+bFLkGhseSJmGY23z4fDT7Ex+gLqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720292; c=relaxed/simple;
	bh=pNAiBPk3+b7TPFffKjUIflh60HluCNFIEoK2TZcYEHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1bMKp0CgTlE80orCRAMAbrT6Brv1dBxn+tlEnhTeGmg7e4/4iOQYqoTlh08WyAY3U74M3hT2MEF69jQt0KzIeLgjLDphjsBdRkqOhjgEaIRYLPIQGNdkFD12wnZdUfQdd641NRuz04NtJAkZr0LNX8fI3LpmOc3tZfc5xTtzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=xz9DwYt0; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id F1E351C8E6D;
	Wed,  6 Mar 2024 11:18:06 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709720287; bh=tZVIOy/Hp11PencpyFqREitSnYQ8zBVbq1ZDzko0Mso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xz9DwYt0kbyxrHiLd35ZroeRrU56YfxcIS95juX6a3sJNRGlr6hxomuN94ADEIfFX
	 WfJqz/qBeBIQfsk1ZyHs44s+3QyXTorCgBk1ySC8IF6dwu2tSk5ndnsg9SYCvUmjZ/
	 lmNmEoBgLnVOVz2oKUpdnsAEuNSIsI3ZUUtU0tn23DxVzgg+8PaJxgsABoq4RCQrZk
	 fO7xfZJefPs+oAEkAkX4lmyTVtgw7CeUjwo0VgHL8LY0blH7U0kNTl5xpoFN1BnLcf
	 hfunt4wOXlNUMV/VaJzF0GbvNeTB7fUsIyw0wAnaCgrT275zbfPhrDE7wtZPIrLNT6
	 9K1sFTuFWF/IA==
Date: Wed, 6 Mar 2024 11:18:05 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, regressions@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Bagas Sanjaya
 <bagasdotme@gmail.com>
Subject: Re: [PATCH v1] docs: verify/bisect: fixes, finetuning, and support
 for Arch
Message-ID: <20240306111805.382fd341@meshulam.tesarici.cz>
In-Reply-To: <6592c9ef4244faa484b4113f088dbc1beca61015.1709716794.git.linux@leemhuis.info>
References: <6592c9ef4244faa484b4113f088dbc1beca61015.1709716794.git.linux@leemhuis.info>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 10:21:12 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> Assorted changes for the recently added document.
> 
> Improvements:
> 
> * Add instructions for installing required software on Arch Linux.
> 
> Fixes:
> 
> * Move a 'git remote add -t master stable [...]' from a totally wrong
>   to the right place.
> 
> * Fix two anchors.
> 
> * Add two required packages to the openSUSE install instructions.
> 
> Fine tuning:
> 
> * Improve the reference section about downloading Linux mainline sources
>   to make it more obvious that those are alternatives.
> 
> * Include the full instructions for git bundles to ensure the remote
>   gets the right name; that way the text also works stand alone.
> 
> * Install ncurses and qt headers for use of menuconfig and xconfig by
>   default, but tell users that they are free to omit them.
> 
> * Mention ahead of time which version number are meant as example in
>   commands used during the step-by-step guide.
> 
> * Mention that 'kernel-install remove' might do a incomplete job.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> 
> Lo! A quick note reg "mention ahead of time which version numbers are
> meant as example in commands used during the step-by-step guide". I did
> that, as I've seen someone following the guide without replacing the
> version numbers, so pointing this out with a few words seemed wise. But
> I'm not sure if the way I did it was the best; if someone has a better
> idea how to do that, please let me know. Ciao, Thorsten


If you want to make 100% sure that nobody can follow the guide blindly
without replacing the version numbers, use e.g. 2.8...

Then again, this could also confuse some other folks...

The idea is probably not better.

Petr T

