Return-Path: <linux-kernel+bounces-125236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037EE892295
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E837B21B67
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC337E108;
	Fri, 29 Mar 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PYhVXN1K"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E42033E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733059; cv=none; b=InXjpwax40zuReg5ix8kBjo2TfRfrldKHk9RMWabKchr+wg5adMUG+uDVR6C229lepct+yWh1+hien59j6rkaIN67YZ5xO0SLdhlkl9BbjuWTPSXzWKrfqM8JRZ9zcG2ZJ7nVNtQ+POhslMKcEyowKTJKjbFyg2c+7epLfsQ6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733059; c=relaxed/simple;
	bh=lkfPtEw77lSIZ0oGk/kE9oHshz0JUtvSGdjFFZ+c+io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxSsFvA4lCZt6LLEB1fsC3v7eI8qxTak8gIk5GidRT2Cx0MlJHkXLXHtCx0j9wwJC5257JHKOv1Z2pZlTiCaPS6ozJekBxz72N1JUnwR6vJOGPT+X67gxFyoKCR4ifA39Pzoko3DEMhiJDY2FnsXpvWiShezLTEnfrvq+sIqzpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PYhVXN1K; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7282740E0247;
	Fri, 29 Mar 2024 17:24:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WfnC5c0qMxFU; Fri, 29 Mar 2024 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711733047; bh=4nXAnictXeJV5AlqQSznerSrQYtHPHUJWwc4tHERygM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYhVXN1KOqeiylzpqs9e2StLyjBEDP+H6LD6oALxzJd905hduQp9B35wtAUqWMTEe
	 qrT8sVMX/1QOgzNvOpN6ME+4K82VxN63TfudDjJR/2jua6hFaGRqMvWtFykckWw1jD
	 QWr/5c6vBHTJhKs1Z7z3M3Gxijj1CkCZwlN9CQLjaHw02RCwrRkGjZBTpzyANKmzth
	 9pmSLX+NdHPnGv6ef0NlE1MRTFZRPCNsCa+UY+EMreXth6Y9mCyjSSOPK/KJsYgXIM
	 +5hUq9bWo7O4SEcnytm7fz7s0FtkvCKvQ6FFN23Cj3tpIu1DyMzDqXmbnSlend2k8r
	 mwelDysr6QVe7LmVmpTrBrIrQqInvlpmf4QitP/6kd34UiGL7rwRW2nSSRHFUkNf0X
	 0Z5/PoNpDlpi6jJq6oT1/0AryTAmR3+obNyXTCOBi7y3U2a+eEoGSy1N5MhtMVIzzh
	 rWLg7Hyxb0IDJW8eUGAyIJlH08RmoNYwNDC+wz3EBO5I6GZRr5U5/288wEdud6Rb+7
	 jv9uKBhXh1i0klicpMOK+vYm9+BdgHLgXPizl1j6Bk05NzX+DmRslyyiq3qkFmKk0k
	 2H8JH4hdJhl3VNs9c/2LJ9FZNF235VvdwjreU7PLV3jcJkXXdUQUqnfaaFo5hWCS9z
	 uHRLFxqJJXpM06gkQb+RdQtw=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E50140E00B2;
	Fri, 29 Mar 2024 17:24:04 +0000 (UTC)
Date: Fri, 29 Mar 2024 18:23:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <20240329172357.GBZgb5LWSP2mPBFs7s@fat_crate.local>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
 <ZgbwYb3D3tBtXZ8y@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgbwYb3D3tBtXZ8y@agluck-desk3>

On Fri, Mar 29, 2024 at 09:46:25AM -0700, Tony Luck wrote:
> I think you are talking about a range of models that all belong to
> the same family (rather than steppings in the same model).

Either. Depending on what you're tracking. If the majority of your
feature tests want to determine whether you're running on the same set
of hw features which belong to a model determined by a single or
multiple model numbers, then you need to track that.

On Intel you have a single model number determining that set of hw
features.

On AMD you have s range of model numbers and there can be differences
too.

Seldom we pay attention to steppings but it is not unheard of. We have
had an incremented stepping denoting a hw bug fix in the past.

> History of Intel model number allocations apparently looks like
> we just throw a dart in the general area of a block of unused
> model numbers :-)

Don't say that. The guy who's assigning the numbers and keeps track of
what he's given to which team, will be mad at you. :-P

> I'm glad I don't have to keep track of groups of hex numbers like that.

Depends on how you model it. Setting a X86_FEATURE_ZEN<n> for each works
like a charm.

> My patch doesn't help with this, but doesn't prevent you from doing
> a switch (c->x86_model).  If that list of model number ranges shows
> up more than twice you could add a helper that converts that list to
> a #define AMD_ZEN2 to make the code clearer.

Haven't needed such stunts yet and I hope I won't ever.

> So keep the "V" in the common code. Maybe one of the other x86
> vendors will want to have #define names for their CPU models
> some day.

Right.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

