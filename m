Return-Path: <linux-kernel+bounces-73072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0181E85BD25
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3422D1C21E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F0B6A32C;
	Tue, 20 Feb 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="I/EfGhmS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC886A00F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435731; cv=none; b=YPS0+6e4kgmtT0CEGbIcLDYU2y2liMdWHLr7snFJVL0bTXdMJxB+kr4GqmKpzoAxK9Saerx5ApzJGpPdWg5qUT5GXCdXkPEQEX1jZ6atEPi7WitEGijOZh+S1OAmuLvYcs+T1uk4XhZ4wupTvzhZzZbGxD1+I8R8x4xETu4c5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435731; c=relaxed/simple;
	bh=nx1q7ni4Wx8/MmoUZh01FvnRELznLFvKZFbu9MQRSHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0/gxyOtlw/cmgjM5CewlVVEEGxQNa8uXk5oXV0lRbyqdJPSsNShLNL27Rn2RYZWf+HekHJURshkNRPJZ1UXPTHqxdKOkFeFGlXSHoQSL78My0rA7VDS+wPyPgmDD6pJr44yDOK047q2pAT8dbyhYxqi1pQsCDW5un4qOmm3b90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=I/EfGhmS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A690740E01B5;
	Tue, 20 Feb 2024 13:28:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RqEjqnGOUurb; Tue, 20 Feb 2024 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708435722; bh=TVRDVX8t2uJ2XGve10S0sRCBTM90vLaS8eWtyxmSECo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/EfGhmSJpw9/gKjY7ej+HssXRhJE8uBbpB6K+cjXf7ck+xN0hRefz/0eH0K94W8u
	 y+XaF6d5cTu8Ggm9H25g4r/9BEE/mv3QQ9G91m/5xNJiHIec3lgrU9EfdpB3EMaLc0
	 i2CsTwvwvkRXZWieWnjTJnsqKbeG9l3MbxoRtVmt7FiOeXxx3VfC7AIuPtBLn+zvaM
	 A9aJwQIYh+fIDwir2T4KxrVaOpU93H+gJiuYD+Jaq4llnIFevEtBdGfTwUaT6IyaFG
	 iwsTZSztRDV7WDM4/VM8Sxb0jHyWpua0EAqYuGeiIkrl4G+AZXBaDCiJ2rlPrsHM70
	 x7SBrS8j3uTG3SRKRxacwZIGK/x2zSRW67vH58NZDlsmTB3k4aRU7/Cq/wfAXUf3ns
	 +9IBnZdfh6tC21hi8i+Tk/HJlqXIB1BOzFw3gQV3Rhd4bZVjkbK5qQyuRCBY4pcDMC
	 HyTnXRI436ZBpzAV3vkRmkKld/yTTtSzEj4mee2/Gho10opQuTk1U/qPmFjZe2LAKL
	 4epHmqMzX7XO4H0ASDpKdvIjFOsL51MxMlceOrhmKRsFTLyOKwi6QJtTItMtY2Bbq3
	 SzFMLxnFx0b69hZkhz5Yuw4/a5hl5DvRe5WqQJZk9yIQHF+W+rYljlNzB9rKUh1a4t
	 +5jzSiuta/Q0FfR/64MgbI94=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9227640E01A9;
	Tue, 20 Feb 2024 13:28:34 +0000 (UTC)
Date: Tue, 20 Feb 2024 14:28:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH, RESEND] x86/pat: Simplifying the PAT programming protocol
Message-ID: <20240220132827.GAZdSo-1E6NOwxmMhs@fat_crate.local>
References: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>
 <20240131175738.GIZbqKEhlDKhaKfh_w@fat_crate.local>
 <67hqgqargmt6nln5mds672g263lka7glyzbvcdgt4owdg7xc2e@v6wvuizw5ond>
 <20240131202340.GLZbqsTJkeFQycXT0B@fat_crate.local>
 <fvzki5mtpbsoyljy354qnva5rllgukba7iuxufxjttceio5osd@tdvgddwttfqo>
 <20240213161514.GCZcuVku13t8p5wHnj@fat_crate.local>
 <vquojgkflafiro5w27qijetm6uat6dfzijq3vszplirselombz@4xeofmdczpif>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vquojgkflafiro5w27qijetm6uat6dfzijq3vszplirselombz@4xeofmdczpif>

On Tue, Feb 13, 2024 at 06:57:19PM +0200, Kirill A. Shutemov wrote:
> The new text follows with example of sequence that flushes TLB and
> caches. And it doesn't touch CR0.CD.

Ok, sounds like AMD is fine here. I'm going to take this one and see
what explodes. If something does, we can always remove it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

