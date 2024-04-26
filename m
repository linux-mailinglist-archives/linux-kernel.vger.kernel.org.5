Return-Path: <linux-kernel+bounces-160008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8248B3797
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054D31F22EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE34B146D41;
	Fri, 26 Apr 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RZuOsYbP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604AA145B0D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136297; cv=none; b=boOZBTHE3mfB9iaDUTJyZmfPUCZDzKDxXDt6zZtG0X7ckmHZKvZqlvQtlAvldd9QcBWrnXGN7eSElJ32/UUAnSn7T9kHg0w2GroEn7VTQb8IkQX+0qZ+AuUeimnkdt3dFfri9DtHyFgDJNtYZ0yMUymomk6PoNuoJhFKxxFP4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136297; c=relaxed/simple;
	bh=QYk4rjYRopBRkpm4YBPXSiacVYDLMEGjeCLCnHfTe7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTR6rRibIrXFlKjixTOlSRqMajeLMJl+jz/6RxVd6HzNjKWnBEhN+FGklqbHgUibwuyIODIEPNx2nZr7vghorOtd2opO0/FM7/lcvJyuFLAmrdHJLtIO48j5NFZ/66bymnmMwXft0FjRpxn7UzPA9gyqDa6Xxv8CDM4VH5KB7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RZuOsYbP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4B93B40E0187;
	Fri, 26 Apr 2024 12:58:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Qw4k9b_DB3ES; Fri, 26 Apr 2024 12:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714136289; bh=SBWDLy/Z8jULbV9JWFfWKICsmpR29qvLNIwHCgU4JC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZuOsYbP5BVSxtGsO69gB8NQlp3mB/pn3smaTkfin78c8Oko7na0jJZ4k0zZA7fol
	 JzbSpswcTQuX5Xo5a9HJlQTPjTVxXpINQ2vW5TwYr/bf1x114D8kKryDN3B44VmJdx
	 eY8GClZny3oL75jlhKzACb+vAW73ra0xG75u5GjVLgFeSzMBzQUm0ME8Cu2GHT74hJ
	 W5aondW9SLCKoX4yrQbpgwQYYOtwAn/rC0p2XTs36VUUQKNcIPjE3nf7nvhRHD75ah
	 6UlGpdYDKPwMZ3K/IuY4z2VjQo+JUrk7/xK51XP1mmaAg2yyMD/4JIBjc4XURBr1UI
	 Njx5AT5PgD9PMcLaTTa6uDE6UydhFXLWBtIbIoeNAwaqpkILuFBjjVBkINtSBg9r+W
	 DvsRilx0jmC5S5kXepHZyhByr7dU2eJMajky/dUo8PTUAly1bsDykx+C8Am6bgfmP5
	 vmqX8E/0mYfAPhQLWYwyBfXx2Pp49zGs+zmcivXf1JG02HCtILXeLycxHDPd3TLxsc
	 CSO7nDs4hPAzc9sGeff3tIDOmIfHhd5hvvq1qJneLQp4dCiNof3R+H/YpkTXV4aZGG
	 IVFFyIbJjLND3Gz9hh5tpmU0pzxmqChgVvFqpasuBYAcl00DOzfac2R2TuHV6kYvpW
	 jMZV6wHkvfSpPL8svOJezFUQ=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90F2A40E0177;
	Fri, 26 Apr 2024 12:58:04 +0000 (UTC)
Date: Fri, 26 Apr 2024 14:58:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: thomas.lendacky@amd.com, michael.roth@amd.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/sev: Add callback to apply RMP table fixups
 for kexec.
Message-ID: <20240426125803.GDZiuk2-YonyodvSbi@fat_crate.local>
References: <cover.1713212104.git.ashish.kalra@amd.com>
 <96b2949cf225501d686b47070c7bbad341e160a3.1713212104.git.ashish.kalra@amd.com>
 <20240420130533.GNZiO9nShSxjxB-FQn@fat_crate.local>
 <ed4cb373-e626-4b79-b692-df5ea2ca8899@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed4cb373-e626-4b79-b692-df5ea2ca8899@amd.com>

On Wed, Apr 24, 2024 at 06:48:08PM -0500, Kalra, Ashish wrote:
> This callback needs to be invoked as part of setup_arch() as it needs e820
> table to be setup in e820__memory_setup() before the callback is invoked and
> snp_init() is called from sme_enable() in kernel/head_64.S (startup_64),
> which is much before start_kernel() -> setup_arch() is invoked.

So?

snp_init() still runs before e820__memory_setup(). So what's stopping
you?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

