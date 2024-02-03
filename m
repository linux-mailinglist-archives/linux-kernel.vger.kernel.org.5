Return-Path: <linux-kernel+bounces-51271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C8C848891
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2216228508F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F505F561;
	Sat,  3 Feb 2024 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUBxW4nx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF05DF31;
	Sat,  3 Feb 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706988955; cv=none; b=WpoIctXc1uQshPYs3Lzjrl9Ywurj9Mg8N/qL+uYUPq9da1cr/KktSH1vuMapoMVSWOX4xRR+66ZHwsca3C6aFsOFQaC2bDl/PcrMHr7VLPBcW130KDpOxX3/TM8NaczfOUn3aWuCGf6Kf6C9G7fxyHY4VSD4UFlZuzv8cansIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706988955; c=relaxed/simple;
	bh=zqqko3SVZxwsUe94mUv1PkcA19T881WPCeH+WU4mV90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeXbJkVHriY+Iw/vWkqEC6/twQA/njZQNLh5A3v6Ss/7uRIg4grN+gTNfwRqQonB7o1VZElHvBp6dIdBgfFOgsan0K31mbsbKuUSak8W1uRCErRg90qaOJVJu4RPtAeyTwPPmTJfn4pI8cWiMTfy4jQmPRvOUFtFPAP5CZ0sWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUBxW4nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DFAC433C7;
	Sat,  3 Feb 2024 19:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706988954;
	bh=zqqko3SVZxwsUe94mUv1PkcA19T881WPCeH+WU4mV90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUBxW4nxljLwzo6ljThtzvFLBCowFHQXvdcIybR5Fh/pm+Y78xH4k8Va14n+0d6ZC
	 ZaIA65iRnESA3P5i1LjbGU93MNk7qUzJtQCurZ7EaOvb7CDxrQZXcos3ppUufFPi9B
	 XV43IXc3YJwcVR8G9lxa+4+hWVWm0U4DnsvKxrn1By+0aB4azMJvcahACZMif/K4Cj
	 uQoQuR3arMlDSzDaFpA2bhhvZRZZIWtgiJR/UUUEEYgsHqaymEbbsaNo8n79oM7nlM
	 42oo3tt6hEv3ONid6yt+4qnllXg+/EhtOVC2sdtq/nEiDQWRRa/hMXBn9M9hpzvyoR
	 y7I4YGdmwGnJA==
Date: Sat, 3 Feb 2024 12:35:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org,
	kirill.shutemov@linux.intel.com, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH] x86/coco: Define cc_vendor without
 CONFIG_ARCH_HAS_CC_PLATFORM
Message-ID: <20240203193552.GA655765@dev-fedora.aadp>
References: <20240202-provide-cc_vendor-without-arch_has_cc_platform-v1-1-09ad5f2a3099@kernel.org>
 <20240203102925.GFZb4VhT1IwX-XRxTV@fat_crate.local>
 <20240203160806.GA520926@dev-fedora.aadp>
 <20240203190729.GHZb6O8UborcetShlw@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203190729.GHZb6O8UborcetShlw@fat_crate.local>

On Sat, Feb 03, 2024 at 08:07:29PM +0100, Borislav Petkov wrote:
> On Sat, Feb 03, 2024 at 09:08:06AM -0700, Nathan Chancellor wrote:
> > I have no issues with blaming a9ef277488cf but I think da86eb961184 is
> > equally blamable for removing the option to use cc_vendor in generic x86
> > code where CONFIG_ARCH_HAS_CC_PLATFORM may not be set. Hopefully that at
> > least carifies the "which is it?" question, I'll do whatever you think
> > is best.
> 
> I guess I wasn't clear enough, sorry about that. Of the two, that one

Guess that makes both of us :)

> should be in Fixes which is the first one which causes the build issue
> so that the fix can be backported to the respective kernels.
> 
> IOW, if you can't trigger with da86eb961184, then a9ef277488cf should be
> in Fixes and your fix should go through the KVM tree, along with
> a9ef277488cf.
> 
> How does that sound?

Yeah, that seems like a fair plan to me. I was a little concerned about
a future change that would require backporting to kernels that have
da86eb961184 (i.e., 6.6) that do not have a9ef277488cf and miss this fix
but that is a bridge that can be crossed if it ever appears, no point in
thinking too hard about it at this point.

I can send a v2 on Monday, unless Paolo wants to just add

Fixes: a9ef277488cf ("x86/kvm: Fix SEV check in sev_map_percpu_data()")

directly during application. I think the rest of the patch is fine but
if there are any other changes that should be made, I am more than happy
do to so.

Cheers,
Nathan

