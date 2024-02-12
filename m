Return-Path: <linux-kernel+bounces-62521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A24D7852250
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B091C21F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CEF4F20D;
	Mon, 12 Feb 2024 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cSSROMVO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FEE4EB28;
	Mon, 12 Feb 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779431; cv=none; b=jqqA6L2WdR4FGZLWpm5Ht5OnoLQQOvFhLcVEROmWrIsZoIY5HtVpq7ONXxEJm6FNb71Q78wjFQdIbB8EHhe6mGpefgfFBJ5bUf9JINzKLgVno8sUEecA94YjIBxjiZMLJ9oT2eXUYnaEHIt02W4+4+Y7dYlQGbGxBLnhSKGulaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779431; c=relaxed/simple;
	bh=kLS8+liRFc8Av1JsFpqI5qboWvNUiRYE+DF0OAk9EV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C22OFOBMfjE2FvsNbOCNxs/yQgLKhVuebamseVwTS3nHpjL4DNoiNj0C1QmWzA3UXMX/udzqvCj1lNrkjFKRSCJxppD2gCa71ydBc21Q/jAHmstCBvB/1xE/TFEK4UfJNMuhSlZg2zaGK0Vt4G1Ewgx2l+oJaQgCmadc96L0Zeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cSSROMVO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 65D3940E01BB;
	Mon, 12 Feb 2024 23:10:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id huSHbf6mq5Ex; Mon, 12 Feb 2024 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707779424; bh=39mF2a31e7R6BCJbA5oz2VBjGFXWjXh1FN58lK1do2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSSROMVOHM37bF6Uuy6/leFNyPTSzpVCAlkmcxBxuWjXZqcAiVLgb0ZxPTc3CIiuU
	 QXZBTH5zC6EvL6QJ2EIxw2rVeUwU6pEqU0KzWmVp87bdfg4ShQ9b3IPM1N/gKUjJd3
	 Y+nFX5wd+YTy8nAWG2JZFmIL114Xq/P1CJFNjR2ga3R2o5bRuC7TRuqpxdTnasPDtA
	 yQMjTw+/c+cRIVScm/Hl+Fos4dI4w4pIveT9kZJusq4Nf2s5Z+mj6vDwHWM+cHss8N
	 4ukye/4uvWCA2MFaPdtYWNYHFCvmFO4CHBqXklUru2WmsZGTfguHPBWcTYjknYplNi
	 vcK9Pq5oxnqBlYLZHmU5IRIoh0ioTzwGxgpcnHkiro77aCWie32m/Or6ZPV1nKSTyy
	 WcPsKYU9BA89d96CGdAzpOTydG4pv9vFuLouk34DPXlzIcJA9T6V7Aj6YkNz1YyYoE
	 07julTZAnK8GLHvseQgs0G9SnoNYRyjkPyqRmekXMhbusfvds1ot67bWcnXydBjqdj
	 Afimybr/u8U2KlYeieDhcnI1mRSdQAycHSShcUEkCHBYKUYh5vRWzjmv/OU6nOV9eF
	 CYPJRqDtP8waGbnBzmgxMJRIUzaOsPNCZnVVvHNo+tvaVK19MdaFdNgAUgs4uxMOy8
	 o5nzqIn2ffMuMYl9Pd1Wlq/U=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1167640E01A9;
	Mon, 12 Feb 2024 23:10:15 +0000 (UTC)
Date: Tue, 13 Feb 2024 00:10:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240212231009.GAZcqlUVY8U2hzOaF4@fat_crate.local>
References: <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34b19db5-bd72-457c-9b6a-c2089f6be83c@amd.com>
 <SJ1PR11MB6083E7E11F6C7BCC8C6C7F21FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212201038.GNZcp7PuIqIJndpDM9@fat_crate.local>
 <47901422-ac07-47db-bf44-3f4353e92b1d@paulmck-laptop>
 <20240212212741.GPZcqNTXfU2OX7uRtx@fat_crate.local>
 <2d8b17f2-c22f-478f-b407-9d2dfd2064f7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d8b17f2-c22f-478f-b407-9d2dfd2064f7@paulmck-laptop>

On Mon, Feb 12, 2024 at 02:46:57PM -0800, Paul E. McKenney wrote:
> The usual reason is to exclude other CPUs also doing list_add_rcu()
> on the same list. 

Doh, it even says so in the comment above list_add_rcu().

And the traversal which is happening in NMI-like context is fine.

So phew, I think we should be fine here. Thanks!

And as it turns out, we're not going to need any of that after all as
it looks like we can allocate the proper size from the very beginning...

Lovely.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

