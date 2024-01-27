Return-Path: <linux-kernel+bounces-41364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9B683EFB1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DC9B22FD0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11E22E419;
	Sat, 27 Jan 2024 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zy734ztr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0925777
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706383220; cv=none; b=ATLrEVUyebNg6CPuJUsFp6j4pja4XUJ2I0/47NF94BWxxhh2VNo1CWlbLN97N7jLKTI2ujpaHUwGeEL3A0DcQoskZVYiuhISErziNKvjpf9Dao+SKY36/K5wOt+UNiWwHsUW9ZUGW/T8QEIe6z4VMPqBvuNn3WHtx/2kGhf1dhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706383220; c=relaxed/simple;
	bh=mxYGcZamntGv6/lKLPaozaBoydnP9QOs3sHakrVRwao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVBZxfToEA8b8jQUz9vhtcyv1BWzQiElK5jOFi9QqNlMb+Cu03yxRC879U+4JebqejX5FgiRH2aFkQGe+AWgYnNbT6dqu+0WKLD7oS+qw5AsLI8h5IpOFoZtF760cxRHVtosxk9GJHmjZRkrrUX14xGGcekewAjUekPurgWo4B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Zy734ztr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8D73740E016C;
	Sat, 27 Jan 2024 19:20:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id L62bCu3OzT-Y; Sat, 27 Jan 2024 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706383206; bh=qGuBlnaOTt+mQA4p2lainjlyqvlcC6hQjOKRuAXqh+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zy734ztrEfBFYcBBdCOaUT2WMpD+EMRHHGhAHbdgouDhAK9V+XfKQNjxRfrJ5oCbb
	 d2sWtwKmj0FW6pzTTbECjCd6aWtwt2rkF01swvuemYW1HIsVdJTTsBQuXxTvl+EqxO
	 Et4GM0EWpyv2dbpXuj5mGDGAw8lrhInxw6kHUtOkiYfQkAdzzmWCDL6hqScATvPsGo
	 l0LFyRxTAFiZ0XpjewiMJ0cder7E5eK7tyTk0/dmdM3LnmTshJ+sWkQB8qsiZ3hEpB
	 HiHS95pX/d2mcubQ2lRVWLfSg6v3Z7c+XgNy8GjHc43CiQI/tmlZ3aIdjC1xAQEotX
	 7y7o+zn8qxP15oU+amEL/kClBSwLo75oucOZ3RVOlkZGVerWDOPMcUlcacHMGtUBlK
	 auePffVen3wzwSm16ZDnZNQ+lEnVRCidV4cq5r+y35EmskGOXCC3WI13Zt7g3SNfw+
	 8lCvV9UZ4UVmk5vWiIDT71MJTpO6CeQwz21ZjxYkvk3hbB2419toDJ8wMkeSaiRX6O
	 SRDo9rTrBIpES8jYaDNvwvbunPGRn3lHtnl24DsSfFYKN3scGHDGaafwXNHb6cLxnw
	 yzYrDvTLIkM/gE1vFDAX4WdchwiNdw6OOwYhHYGzMbOsTUHISk9Z+z6gevz0FpTqdq
	 ZtomFENlxwpBXmEtlKGVEiSQ=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3079D40E00C5;
	Sat, 27 Jan 2024 19:19:58 +0000 (UTC)
Date: Sat, 27 Jan 2024 20:19:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: a-development@posteo.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
	jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
Message-ID: <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
References: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>

On Sat, Jan 27, 2024 at 06:58:37PM +0000, a-development@posteo.de wrote:
> putting srso=off in the cmdline fixed up my FUSE related issues.
> Basically, I could not suspend anymore.
> kernel 6.7.1.
> 
> This is the behavior with srso enabled...
> https://paste.cachyos.org/p/bae7257

Can you disable, if possible, whatever's doing FUSE and try suspending
then?

Also, can you share full dmesg, .config and /proc/cpuinfo from the
machine?

Thx.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

