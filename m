Return-Path: <linux-kernel+bounces-51027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2A84852F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D6A1C213BF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17375D737;
	Sat,  3 Feb 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PYeSrXLu"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1575D734
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706956185; cv=none; b=IyzExVm+ME+ydN4shHBQp9bKsIIO1wk970v2OInBBxRO/bhDdxWDuwJEOkyHcCjZa3EghCd5EKWqpGXa6wMgIszgR5ZQV00fS72ZXazO8EPhI/c5Fkv/hC3an5upc42MTZ68FI2WKJoF4DNTJG+pEO6Ga/ILKHyvC/OVw8uK9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706956185; c=relaxed/simple;
	bh=mdUxL8RJ5LBysSTmS48XBZdP0i52a9+liv4tYojfPoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7s0sUOsZiyNqikChQauheNk5E0GoMthF+5zPjxBV1IgnA8Y4Xtg5Hdj3svBcoRPinVhRD+r3++OdGXyVoMn086jkEVGOPVHz1tC/4I16PtHLkP5lWyx4BFP/i82AKuX8UKRG9dedbOEfLegNzDHhiWA88whM9riZZlwnjCyJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PYeSrXLu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 94ABA40E01A9;
	Sat,  3 Feb 2024 10:29:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3VPB0sa50QDg; Sat,  3 Feb 2024 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706956179; bh=PpFVx0KRK8Fi5jzyistetVbiB87/96T4pWjZRktWrp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYeSrXLuRz378w5jeT+l+liLevtEt1E5gWQUp4/ve5+xPo8mdJhZrjwJObX17oIX8
	 zh89zyX2wXg+Qp09lohNyTrfZ38jMk97sGPKFYJg+V+1lgbPCiU4azz/csYmtXdskt
	 CTEI7SodLggSdYkNTg++nu5Ff7jh5Zzey+lWMgfqIFVtJ82W6ZLECXwi5QbV6QQIvg
	 ESXZHVaCMUlE7mSIMkeTqAWDCdAju1ey8gSEBsCy8k+Cx0ENGR2gF7Y7LiTBspWzZG
	 c0DNNffwmzgnF0DNUJYr8Uk+DgKdA2jPtfiUQUzN7Mlxr4gm80res80b2efJFuImg3
	 h00oejHvlk+3ptaTn4rYGBZB6fT4FfPMcEaJjX0GA+C9wNCslFMOkB4T0LeVQeNFqK
	 3Av9fDkX1CVqJU1il0nmijYD3yGthOb9w/p3b8YtC1l2cxBNX0PfKBdFKETCQsPNjf
	 i12URjMFpNX9iyBTZDCFJjwj/bDfvmaSS1e0vZ/bQhvVNU1voI0pk7MEdA/K7KGbBg
	 QZHJLo0QDkLGJW/k3VsCknnOk77SAIp+IslKh5dlom20P4WoYE5e8hwjF1ai/ksURG
	 UpvfgNxiZGVsgYDgvFJ57n4LBdw9mustLqwtoZenfnWCFR3kehzfJv8/xys5IGfQhQ
	 8gpnN6ztJd7FWA2Ib13u5b0w=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 373E040E00C5;
	Sat,  3 Feb 2024 10:29:26 +0000 (UTC)
Date: Sat, 3 Feb 2024 11:29:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org,
	kirill.shutemov@linux.intel.com, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH] x86/coco: Define cc_vendor without
 CONFIG_ARCH_HAS_CC_PLATFORM
Message-ID: <20240203102925.GFZb4VhT1IwX-XRxTV@fat_crate.local>
References: <20240202-provide-cc_vendor-without-arch_has_cc_platform-v1-1-09ad5f2a3099@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202-provide-cc_vendor-without-arch_has_cc_platform-v1-1-09ad5f2a3099@kernel.org>

On Fri, Feb 02, 2024 at 04:53:21PM -0700, Nathan Chancellor wrote:
> Commit a9ef277488cf ("x86/kvm: Fix SEV check in sev_map_percpu_data()")
> exposes this build error but I think it is really a problem with commit
> da86eb961184 ("x86/coco: Get rid of accessor functions"), although I am
> not positive so I left out the fixes tag.

Well, which is it?

If you're running those GCOV LLVM tests regularly and you haven't seen
it after da86eb961184, then it cannot be that one, can it?

In any case, you can simply revert a9ef277488cf and see if it fires.

> It would be nice if this could go along with KVM tree that has that
> change but it is obviously well within -tip's territory so I will just
> aim it at both parties and let them figure it out :)

The answer to the above question would determine the proper Fixes tag
and who picks it up.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

