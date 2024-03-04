Return-Path: <linux-kernel+bounces-90977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1FE8707F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E59A1C212A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC55FDB0;
	Mon,  4 Mar 2024 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NXRPmS72"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9D94E1DB;
	Mon,  4 Mar 2024 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571866; cv=none; b=HeQ6qL/JBuzyx+6gWhwI99maZOs6wLD6y9ntoW/ECzKdWqHSmSllhNHw9bLrCR3g3UgA177rmn0n+ZMBZFQtxMKWVUmR3HPh+XEZ/qjlF38Ax/4cvlfI8WABeRVqrXppyVC+qjJphYJaqHPpqByIw8qkfkInW/Q37xU3mCTNg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571866; c=relaxed/simple;
	bh=yJgY3Cxc7MpDJihQYRZQAp2N7ydObfo8yiyscDNAPrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8K9hhNzTPqdWPAQ6eVfObiM5HrRkvtKHS7SAt89Q6jIzUkLzpXiB2ZII0oDGHFAptthvF193qcvyfRXlyFxkLXQBGMRGp7qX+xztrEUzmpl0LExUM7dQfVmihkEjGnsMzpnR0YyD1SFhIvBVi1nyBmwXcsEftE0GHqkfbtJi3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NXRPmS72; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 824B440E01A2;
	Mon,  4 Mar 2024 17:04:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6LBhdAGguSsq; Mon,  4 Mar 2024 17:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709571855; bh=ONdikGD1yGAPbm7O2SHjebFrROQeyHHdH3ZyyYX0F7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXRPmS72i7Lm5nThrgFUY34DyXsEhgk/5EIcpLpXf1WfpAg/uV6UYTZbv/IHfNiBL
	 75I0jfWrb+4iJpNWdKdRB7bD0UbJb7urw6mkLGPPs8q0VaTCE9gJu+31mZOjeLRk/t
	 P4z1Mcwbd8t57MGlql2SJ72jK6FUR0T5snyxEXJwUXt5gNjjIUttCSThlbijjjdLYf
	 rxl5ssVxEzZ6kggGbATuAZ2OqqbGBPAsmZQ8JAPFOMh+HHugZRVtT96SR7Y9mc7NDe
	 JyfeKPtJprru9Y3X0nvaERGpx1AtU5sMjrgx8lLhdCnqbZy16dexk6A6wsLcffVKMP
	 L74i+U+LjmWpUgdLIE0w18eSURnOrXO6ri6puQ6IWTJzO61J7eHYI+tMqP8HiHSdSy
	 Xg3uGb81ocMGSwOJ/E8c48DxaVoaPNbhmMnOjRZlXm8CE4/SPEp2zMsjGt3GJRVb52
	 Mnz1bcOhFtmcxWpC6Hc+wJKNafUFPc3DAbocXGRuPaiNpJozGdZj8wXIN/1Ptr28rS
	 +MKkBxUgDG5qMXbyON6mpLWwoBgHbO4kYlWCU9352E8cb2qo05E74dFMUdztxJP06S
	 wF+ZEBKZ2ZJP7SHoU1z2NFzros828NC7DO4iL6oigAzJ5joYDlfLoL9O6rtYSwCzuE
	 D1AEKrfNAL6cYoreXIb8HvOY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28B6040E0185;
	Mon,  4 Mar 2024 17:04:04 +0000 (UTC)
Date: Mon, 4 Mar 2024 18:03:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	"xrivendell7@gmail.com" <xrivendell7@gmail.com>,
	syzkaller@googlegroups.com, linux-edac@vger.kernel.org,
	hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com,
	mingo@redhat.com, tglx@linutronix.de, tony.luck@intel.com
Subject: Re: [Bug] WARNING: ODEBUG bug in __mcheck_cpu_init_timer
Message-ID: <20240304170356.GBZeX-_IdRl9-eGKYb@fat_crate.local>
References: <CAEkJfYNiENwQY8yV1LYJ9LjJs+x_-PqMv98gKig55=2vbzffRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEkJfYNiENwQY8yV1LYJ9LjJs+x_-PqMv98gKig55=2vbzffRw@mail.gmail.com>

On Mon, Mar 04, 2024 at 10:26:28PM +0800, Sam Sun wrote:
> Dear developers and maintainers,
> 
> We encountered a kernel warning with our modified Syzkaller. It is
> tested on kernel 6.8.0-rc7. C repro and kernel config are attached to
> this email. Bug report is listed below.

Thanks for the report - I started looking but am seeing more fail so
it'll take a while before I get to fixing it properly.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

