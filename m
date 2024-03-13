Return-Path: <linux-kernel+bounces-101516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6DC87A829
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75171F22DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA0B405FB;
	Wed, 13 Mar 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="APpn9+Y+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132D3B798;
	Wed, 13 Mar 2024 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710335932; cv=none; b=GIfDJd06nKYr5d/9zPWF1GW293ztEUP0j1CpYssW+tCrjiYTXYNJKcPwAmPe+883LKlFVFN3bdfMOGmg12VYgBBfIwV3atie7bkZ0Gwasj7vNWrLGl2I/YSNXIQa//7uOFEhLxAKVb+d+Z4CPBuUALp4+z5XfrZI3vNNDNFd3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710335932; c=relaxed/simple;
	bh=3NI9+YRJAhyhrZYpG4leb60LatyeAaPg+2TqvSBblDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF9bDlhLeffEADKHuI9akIpJtQbTJGGQTyhxy30IqjBBvKutx/lEBZPtn5lrtPVKFChEh5jfQQ9pE2snofdiTrxrRKhIPmPFBE5crZ5wBPejrkU4hZoqY9287ydVkIxuDuGtY3x8V1FoId9l0Ol3GELB4J/SYCfKGhXanVkJd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=APpn9+Y+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7B27040E0174;
	Wed, 13 Mar 2024 13:18:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dfbpo-9lhIPa; Wed, 13 Mar 2024 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710335919; bh=Lo4vjZFvfuk+3/mkZPJ4zRgq8Ta+PGCqOM6epR06t8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APpn9+Y+AsljuIY1SyFmeyXdbWK0DcqsOK5MgyQ1qC7snfZ6D0CwLCWX2kxIh69Ii
	 JqJ0xd06Zrl5FOLFCaUyfJ7w9Bopq+M0durNgoWU0bMpyzgsbY983RXGi3K9XE7CxG
	 iFWq2wWeX+5NWs8S3Nrd1nmq0hiqPrm262FyAEbwx+WblQ39x40CKdKxey+RVGoOjO
	 oGh9l3Eo20UCz9i+ZBVORiEN1HvMpuE3GTbJHtIQppwoRTsp/k+C5NfjIc4ieDhahK
	 yF8jgi15sOBnhXWm2sVeiz0DuZayEZV1GefIexGug9MbCrmq07Jfc/Jf8/rq/rYD8R
	 B6fMZMOSfftx4liP538CR2Plv1q8zRhSeM5A1loE3th5ps7/Xo64I47kHvQN8cuMwN
	 JlEHfMr6n0Osep55A0Ox+vNAVa0SL2XrtZ4Ry/oUBCQW1fLBhIcA3s/aoKzNVx3dqd
	 4+j3ZWYR8nREoNOHAKn+OS/bUZhdNJAD+3mPD04sIAxw9aDxRWZ2X4aOwUcNeL7ZJB
	 0cIpvAec37BZOc9xODmI5z7phz6rR/EpmEs1tEQ+7rxw+MpWUmik0Hqa4BU5yILEMy
	 UW9w3ftxVVtqDXTYdu9Hy3UsBYoHrtkobGLjZTHIVAnp+nYzQeDx9oQVhH6L66Ky2W
	 QInqryLEiiXQZFfqFrxxMvLc=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C40E40E0028;
	Wed, 13 Mar 2024 13:18:34 +0000 (UTC)
Date: Wed, 13 Mar 2024 14:18:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/build] x86/vmlinux.lds.S: Remove conditional
 definition of LOAD_OFFSET
Message-ID: <20240313131833.GBZfGnqTwdhcw6twQd@fat_crate.local>
References: <20240313075839.8321-4-richard.weiyang@gmail.com>
 <171032639869.398.16886435468084846590.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171032639869.398.16886435468084846590.tip-bot2@tip-bot2>

On Wed, Mar 13, 2024 at 10:39:58AM -0000, tip-bot2 for Wei Yang wrote:
> -#ifdef CONFIG_X86_32
> -#define LOAD_OFFSET __PAGE_OFFSET
> -#else
>  #define LOAD_OFFSET __START_KERNEL_map
> -#endif

And, as a next step, you can get rid of LOAD_OFFSET completely and use
__START_KERNEL_map everywhere.

Even less ifdeffery.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

