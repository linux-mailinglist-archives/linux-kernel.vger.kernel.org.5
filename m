Return-Path: <linux-kernel+bounces-61248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E779850FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510211C21B73
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF78A179BC;
	Mon, 12 Feb 2024 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A6QPEmZ9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3917752;
	Mon, 12 Feb 2024 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730387; cv=none; b=n/z6k2m3g+QKxE8fkLjrk0GRtPS040Ax/R3wdpCwji0FiBHR8gYbhEgAltj50hNqJ2V0zADEn6lmjX8HtbLEy1ArMJUZDUsuoQ5WfUe1jnHVQu2sxTk0sdz7Op9M1ZU1iHwvneVW5uwjFD8fFTLhvCBTmvspRRZ+CM0VdWbRQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730387; c=relaxed/simple;
	bh=Tnw1t7Ni5n9jDvo0mIkYT1qQSHmAgNLrdrv4fxUa8+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IytbVnMn73sjeoD/3l7b7fBdQhL32rZsdHMrEQEZt8ru4XVq9NxHBT9RoOLDx1daRNZL9jzOfFyAtqSjNAzebfD9xrO8oKfBPId5mIHmXKzNzsGKU8HgQCVlv1xbVf/Qm62YrQwZ3homVbs1+qjY3HbE/sTVy/xFSA3p85xDDZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A6QPEmZ9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F20C540E01BB;
	Mon, 12 Feb 2024 09:33:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PrjaPpRiwzme; Mon, 12 Feb 2024 09:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707730380; bh=LHtWUL0JMVKXqsiPBvZWVeU03w98dPH2QqSqpRk+NAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6QPEmZ9yU9DElkPzwNiElcIzdDJ5YKAKoJc2S+y0g41sHOG7DmPAsAbOrTIqHXQK
	 IZEegQnIwCWBCf9ivaonzu/v3Uc04aFUYK2r//GkNAS46mZo40sjVTDsbAwziKC4a1
	 O93pnjx0+oW6OS9O3huOMq040/JNdATOQkTQdwmER0Xnz5Mna74qvSXajn5ZinNfPk
	 EvaXPC7RFWzlP8c2CreCMCkyMJ3UP+6IRkO7zKLLUvUDc2rS3ZOaRL4AB+gz9TBYah
	 PlwgT2QFaLOYIM6hY4e6Lzfjhh835vzs69iGK1gdSsVQnEj3fn76keAhWHh3LemLuX
	 092Rd+9cPw1dad58IX2w4m26VbiC46qGj5CgkSPx5MY78u/MuCql2MxkRjQ1cIR5X1
	 wlJ+EEUGPk3VJWzIkezZwdO23VlIABUSeoESQPAPzAPqM9LhclHr8Hr69Jp1axY5bh
	 VOlp5c/tj43pt4ONLJaIwYuUZDeGcIlvn6p9RZJOKUy2qo5lrqtNe82Z/K0UpW8rQC
	 YBEVIDO+yrPSMCBrtk+1/84rG4UPiV5sFXP6FuQL7hVDTrnXgbkQ73xT7FBAYU+h6n
	 zcF9OV/oTKOPSEtxFw/G6GUJeTNJZsYB9DcX7q1i6e0XIYd7k1yPwwLhuDPC0Irvep
	 WyGtfuQ3n8X3dD73s38M6yOY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A06D340E0192;
	Mon, 12 Feb 2024 09:32:52 +0000 (UTC)
Date: Mon, 12 Feb 2024 10:32:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
References: <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
 <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>

On Mon, Feb 12, 2024 at 09:58:01AM +0100, Borislav Petkov wrote:
> * Can you think of a slick deduplication scheme instead of blindly
> raising the buffer size?

And here's the simplest scheme: you don't extend the buffer. On
overflow, you say "Buffer full, here's the MCE" and you dump the error
long into dmesg. Problem solved.

A slicker deduplication scheme would be even better, tho. Maybe struct
mce.count which gets incremented instead of adding the error record to
the buffer again. And so on...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

