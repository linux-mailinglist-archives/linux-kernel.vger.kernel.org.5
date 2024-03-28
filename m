Return-Path: <linux-kernel+bounces-123339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEEF8906D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DFB1C315CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5A134CC0;
	Thu, 28 Mar 2024 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CW+WKWsA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B93BBEB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645584; cv=none; b=DcyidbZItDdjYY9+rXMiyC3dNYyhG8USK7zCcGdwBnscxLE6E19E50zngf+XTdD+FG9Bub6EuAjehjsStuJtUjnq3Ou1Or8wvEBzC04OImsDx4XlA3gHxqmLQ4YWLcV6PAqGXKkNZB5vruWD/gLBiCaY/gsO2c3ZQgGfxModfT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645584; c=relaxed/simple;
	bh=X5iFI5zB+kvv16/vMGAF4HiLkTbwEk4Xzh+ReI5bKug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI1XgvsTcUdROtVFePGE8E/qPf0BUq1Kfq3FmIrLAS107aybE3CByM0tNu4bzlcb3S2YpWYB8WipKnOGzPP8UTqrIteJ4dZB298d4AIfL4SsZDlSGdXrwgqhEfbaqWFvzsKTb/ARIpy3X2HugYQ0wUPn14J7nmEl/C+zMva6tOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CW+WKWsA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9967540E02A5;
	Thu, 28 Mar 2024 17:06:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YDDV0bws0VxB; Thu, 28 Mar 2024 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711645576; bh=YcObURuT31YF6fcXgSPsh64P2My3TAEfcyXL35rY8xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CW+WKWsAj6roVN10xIx190S8lWNDznYd2AR/Ro/WBuN/WoJzIbfPEdhWRQJ0btvLE
	 9S58LFYPzpqT1d2WvEiM5AoDnSRfspZ9pqAa7kZYwHveW4aQNeC2yxQgqnHLuHyVcu
	 CGTqoF2nYGWHqT/yvJtGD1cHg601ymt/evARq2H4JdXuB34BmrVdgXCBjUfpq/lEkx
	 hImma9s8fsjTl8wHup97eG1P2fwgjRMJ2SCUQhbXkwhepFYnLr+PJfsu0Hy82dka/M
	 G5e+rJFF4u39+ONDA3zekt9c8ILpM/kJMh1TSK0/11GybU4XxBN3NrQGTIevkA8u3X
	 xdimA3sFZlB9hEVWZRs+J9Y6lfGa/6GHG3E8BoTehLLdSvz6zz7lEkut8wGx/UWstJ
	 bFBAz4nfQpmSpPfxmiwgVLZsiPS+0/Bsx64UA4JNynNfLs5DUqm/krlESeBU3NTL7F
	 Uiyei4TGXPsPyIcQpATJuv0PXaO5696cWGu3KIZPZF8Mwf3Wj7/lBgngzqMnKiLm7y
	 00ziU00ID8bUy9uiKLkjnnwXz/rSOkXQ2ia9Q3sLFqvBdVg/+zmPOXqdCGKPsP9qut
	 JwhrkS0QNede0mwDZ4QIWQJFL6xtl1yX8L7qPKzxJQBuk017AoBD72O2wkfTUjeU1r
	 0qbsVGoS5av1xddJgeiFlNRs=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2832E40E024C;
	Thu, 28 Mar 2024 17:06:13 +0000 (UTC)
Date: Thu, 28 Mar 2024 18:06:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <20240328170608.GFZgWjgGSqFL7kGQkE@fat_crate.local>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <SJ1PR11MB60836FBDB2ADF1B3B8A02EFFFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60836FBDB2ADF1B3B8A02EFFFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Thu, Mar 28, 2024 at 04:56:37PM +0000, Luck, Tony wrote:
> I could make the raw format of the #define values be CPUID(1).EAX
> with the stepping masked out. But then I'd need to add a new field to
> the structure instead of overlaying with the vendor/family/model
> fields.

Yes, that would be better. And if you're going to replace our f/m/s
checking with something better, then it better handle the stepping just
like the rest. How it is used now doesn't mean a whole lot for the
future.

And if it is not too important for most checks, you can mask it out with
macros.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

