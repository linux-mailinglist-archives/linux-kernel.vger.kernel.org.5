Return-Path: <linux-kernel+bounces-64848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94248543A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545062850A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D8A11738;
	Wed, 14 Feb 2024 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Dh2sPnMr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14EC11C80;
	Wed, 14 Feb 2024 07:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897186; cv=none; b=t/IDvXTsr/HMkiaNflrycQUODahX/cRkphHekccQ+/TRjNrYAkqlD3ZlEV73DpEhFfnRE+61RFy2SYYKCqveScyXCrXfHUs3sPuADnI8kqXC+quz10in1pKVAKi8YeWpuMndZSA5+Cm9/qnWH6a1YL3+tuhKA9fNAOKTsJQX//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897186; c=relaxed/simple;
	bh=nwJ6BmrvNXG+hweFMVXWIckxNuV3ICGXzOY/FpflPus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfYXkw8QmuXeibiJ0Cfx7jM1qjlprzKhrhrvG2+KL0h/ewd1+cXIrtYUBMZcQ9eWBG8z8TdOZKRV0sQwxKFpCvqmOCYfiXmepmnWsTfux+aYX9DHqsSWHyh9NoMFRs+F+SR4iytTJfOg1C1cTYM/lZqvGHNkqTC+sFiSxMFhncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Dh2sPnMr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3A3AB40E016C;
	Wed, 14 Feb 2024 07:53:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AtoXIdDPOwXA; Wed, 14 Feb 2024 07:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707897177; bh=92xNvKeTH2GkkS9ze9entiR/JfiiO841QHEnNATcD0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dh2sPnMr+9Fdg7qIibTGcTUaNK3YbfZeCEDPus9NZMos8gnsHZcXc7gtpjIf4TM8T
	 KcCslolsbE6vxqdz2Mm36+K7CLpAWlQ9xlp+iqyUwbMnmSPX6dwAQaVPxgXYOKp9p6
	 YVGSgQ61YjzMQf/7KKOSr9zpzLAg/sf9OIzty8JdLOGpd68xtOvtWmu8NtoK4T5i3c
	 4F3eQf9KfFYmdlDFTLPsAtoZIZjWN3In6Kg6bj/s52Ud8tVBu5pVSQkFB2VyLLhlwD
	 8FeQ9t27ycJrvvfuRah1s3rKyOW3tF08TnCFyDqcUNnjmOI3AqBTyS8mEg6nB5fgTQ
	 TRHv3XyUEZQFCnclcdBd5oQmU21C838NC55I12C7+YnZ5qWap6SLfouiEWlNKmL4hR
	 FhAdjDMlQda+R+565sjRpGHZPu+Dhoyc30tNSiupUX/OXjPszNOlRgi+KTd1i1KWoU
	 6hQVxDPAsrrgLw/lCms7oyni7Ug+kFFKJRZUUK974d+g16QICxnyBJxWv3IHwOd8h1
	 RGux7bAipcvp7Iik+VZAqHPrTJb09RJx7yrQ3QZtci3d4H8RUOhbm0p1S9sIVyyFob
	 nAvl3eOnN3nNzlYU8H2iYMALGlD2WU7qHWznl28y0+PBfy2qVp5/T06N08Ey36fjhu
	 Mhys/jKSbPfMVIvj282N9fvE=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 900B640E0192;
	Wed, 14 Feb 2024 07:52:48 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:52:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 0/2] FRU Memory Poison Manager
Message-ID: <20240214075242.GAZcxxSiMsDoacvC1M@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214033516.1344948-1-yazen.ghannam@amd.com>

On Tue, Feb 13, 2024 at 09:35:14PM -0600, Yazen Ghannam wrote:
> I included questions in code comments where I think more attention is
> needed.

Lemme look.

> Also, I kept Naveen as a maintainer in case he's still interested.

I don't mind that as long as he responds to bug reports from users and
addresses them in timely manner.

> I did some basic testing on a 2P server system without ERST support.
> Mostly I tried to check out the memory layout of the structures. And I
> did some memory error injections to check out the record updating flow.
> I did some fixups after testing, so I apologize if I missed anything.

Right, I'd like for Murali and/or Naveen to test the final version but
lemme go through them first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

