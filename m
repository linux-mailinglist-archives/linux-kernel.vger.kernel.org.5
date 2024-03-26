Return-Path: <linux-kernel+bounces-119139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058BF88C4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BC21C3E5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0B763E6;
	Tue, 26 Mar 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LgUTD1Cm"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675438002B;
	Tue, 26 Mar 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462100; cv=none; b=SlbXa/NSASdHK8wBemGajHAMA/sEf8w0nzsLkumAaIxcimSD4Kdpq1cB9nBA8nw5jdbiDOlHLcyZO8X7+ivvqtfXam0NYTBORqEmc6Z/37WJ0QoTmcSslEsK2OFHMkRv0EheDzDEJ74grzZh85c0SYYQu+TlE5UCm+OyN22E2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462100; c=relaxed/simple;
	bh=FY3LsSsFRHaFczhaFzvuVUs8HHvnygjoAiHpGuzYl88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDOy0qDCJB1A6Flnqox1gnzwrNlMBjDKcoKo9wuOPuVtbdUHFE/WznLwufRhk0ckqL1kZZuXNBCzXDv7Rj8F2sr5DlYamr5cRh742odS7huicqwizzk/WdZK9Q/K2v5mK7blQzTRDi1h0hsd/q8wLT3mN8oRRlaIqRnZfgG3xrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LgUTD1Cm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 712BA40E00B2;
	Tue, 26 Mar 2024 14:08:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BsJuunepuwqY; Tue, 26 Mar 2024 14:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711462088; bh=si9gxpWQp2pSZo+KQ5IYAfoQf6a9WF4AKx4wLpYoflE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LgUTD1CmFPGWrOf+QdlpPCN5fnMHespeAPQqeFOyJPMm9mERAxY4IU3ipJ31enjc2
	 MflDi44nGa6kKYH1bWq9JvxOfF3o2T8neGAP2peYBzsTNGNzVtU7z5ZkRhl2rlMPHs
	 N/oGhC7/95gq58OeuygQRMAXf+ayP3BXITsHQvE7fILjLCylVrFtkV8G/X+c+wFMqm
	 y4tD4BGaSErniUvqidBwkpcWejVR1VrODOWs2/nrKEw/LyFsvvB/3PbsaCnW6unRUg
	 rlWEYBjhmF54tFeOTyKiBfyQCxDKcAEK/aGaeZJg1+tCYS4+tnUjorq2yrptY3ED0L
	 gRBFj6H20ySWgcSKNY19QneENXzvly0k8Plp88uNQppBAQblRIo0bBnUtCEq7u8BNr
	 xtA7eMyVxhdGd3WTXWUsF0XxjTwsrA7tCl8eWTvIm9huChWwQ6tiqXJ/4CmUQL1imB
	 f2MvLMlBESMtFfyqb8uKgQvynMHDfe3beSugc54pGt5PPvNxYKjarp4C0xzTdLnt85
	 6fj8hlvnNjWNSYs5rDDxm7spddq9cfW1aYUcLdC6s0fFzrQpXD62lElSAu9tzv0Dh7
	 H2JVq5n1ZfieOSag8bdHmAncVcOoyU8rYNZnkFHn1+zja1yQ/6NmFWjDY3fy92fsDz
	 U4iGk3CKMyrUzAvfL8ooGXOk=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4FC840E02A2;
	Tue, 26 Mar 2024 14:08:04 +0000 (UTC)
Date: Tue, 26 Mar 2024 15:07:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"anthony s . k ." <akira.2020@protonmail.com>
Subject: Re: [PATCH] RAS/AMD/FMPM: Fix build when debugfs is not enabled
Message-ID: <20240326140759.GGZgLWv3UZVpHZ5c98@fat_crate.local>
References: <20240325183755.776-1-bp@alien8.de>
 <eede2586-f143-4107-a065-2860ed413d0a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eede2586-f143-4107-a065-2860ed413d0a@amd.com>

On Tue, Mar 26, 2024 at 09:41:41AM -0400, Yazen Ghannam wrote:
> This isn't true which is why the module doesn't fail to load if debugfs
> is not available.

How useful is this thing really without debugfs to dump records?

> This was my first thought too. However, besides not true as stated
> above, this also leaves the issue open for others to hit.

The others to hit? I don't get that part.

> I think the fix below (not tested) would be more appropriate.
> 
> What do you think?

Sure, remove my fix and send me a tested version of yours and I'll swap
them if the driver is useful without debugfs...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

