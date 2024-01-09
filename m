Return-Path: <linux-kernel+bounces-21265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96545828CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7651C24BE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DA23D0D5;
	Tue,  9 Jan 2024 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EuKKB38E"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F976D6FC;
	Tue,  9 Jan 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7104240E01B0;
	Tue,  9 Jan 2024 18:37:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id b7yVKaHzlFZI; Tue,  9 Jan 2024 18:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704825422; bh=3GnnfT61nG0MgA4KLPPPfjplcJ6wV6Zbmw1e3o0+qUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuKKB38EOmDmgXRgfjQIhkWZOOy7vA6jvLaAqqtKkdkPYY14htlpjS7BHK6U8O/P5
	 xvvVdyAyV8GiTog2P5YYJSO24CErBZO6VgnWIA8jjqx2cPp7/AOP4Lv9S8tEwnOfPv
	 +lgzudzbCe+wkvl9Bd+uuzcY3+iW6xwao4w80LfOz4yzJFlJl5ueLu4UpwGXNM9kRO
	 AETEnyZrDIAQcO/b3GCPkB0yMxZWrq6theK2u8LBwXTjgDyU53ikOT4qtJ3+ZBSxKC
	 sfuJy5o4TXiMbqqVzEZ10VeauMwlghqE4dBAzlLPBh9zK8wkBW27xm4liAUo/jMMnq
	 zvM9bFRvaxz/WTfNjMGroFY9lPtYzJVeWDysw5LoLXggzunm67M8wbILK5wxa3Wo1J
	 Q4ApQ0o/ms48movkl3mhKzkuCEKvhNeKsSi2S1N0CpBfutXS2viqCP6LlDfFJcAQNi
	 tBOk6dHuYQc8dHFcLna4F6HRMCKfmiGmNsbYBrh+rl5jmdGvMB0zwaD5ifx3xD1yGz
	 pXU14X6LS2/cP1MYqtH30t/Fxacae2HNMZl+IWWHCc9H0PDKSKMza1AktIjK74sAWU
	 U9A9dJbCXj0aE9vfWQlJSo8HTU2svyHpGKywH4eZeznp2NxTAVIVMATV2adQLkIk6a
	 nnQpUJlFQ5Gs9RhnzPp9DRjo=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30B0640E0196;
	Tue,  9 Jan 2024 18:36:54 +0000 (UTC)
Date: Tue, 9 Jan 2024 19:36:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muralidhara M K <muralidhara.mk@amd.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Begin a RAS section
Message-ID: <20240109183646.GAZZ2SPiMZv83J3f0a@fat_crate.local>
References: <20231102114225.2006878-1-muralimk@amd.com>
 <20231102114225.2006878-2-muralimk@amd.com>
 <20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local>
 <87a5pes8jy.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5pes8jy.fsf@meer.lwn.net>

On Tue, Jan 09, 2024 at 10:47:29AM -0700, Jonathan Corbet wrote:
> I wish I'd been copied on this ... 

linux-doc was CCed:

https://lore.kernel.org/all/20231128142049.GTZWX3QQTSaQk%2F+u53@fat_crate.local/

Or did you prefer you directly?

I've been working to get a handle on
> the top-level Documentation/ directories for a while, and would rather
> not see a new one added for this.  Offhand, based on this first
> document, it looks like material that belongs under
> Documentation/admin-guide; can we move it there, please?

Not really an admin guide thing - yes, based on the current content but
actually, the aim for this is to document all things RAS, so it is more
likely a subsystem thing. And all the subsystems are directories under
Documentation/.

So where do you want me to put it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

