Return-Path: <linux-kernel+bounces-51176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04216848756
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E6D1C22A3D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5455F84F;
	Sat,  3 Feb 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNLCdrJX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5025F54F;
	Sat,  3 Feb 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706976489; cv=none; b=k6da+W6S4lFNKOsHPXTiWyf/UIzADmHIndT0hNiSJ54buqumsuH0cZdLfumn0rwZkZJw4vUE9Xy3Iu5CmGctFDF2d5hlKKc9sgq/IayQa3l19Iv7vIEQYin/JFwqtmXQ7Jsw5znMgLBq9Ifv3g1HGlvxBODt4h7mQh2vnqZ9wkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706976489; c=relaxed/simple;
	bh=SeNku5MGwBucgE6V4WxWAhjMMTksXR8Sl9NiT84m2GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDCV0J/6mkCLf5ZpRTjh3CRHxcjFVCA3pg7iVHAQUNukgmrMwBKWVVgl+aSlLtlAVryTaG4IBCSB7sNwWs3NcahTa8l2L3m62Xv4q8GkZWZgPSmkYXlKuOeV0buO12PLp+fjj9h9mXvx+IHuL46wG+EMbam1S4z+rW8qNTOP3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNLCdrJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C61C433F1;
	Sat,  3 Feb 2024 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706976488;
	bh=SeNku5MGwBucgE6V4WxWAhjMMTksXR8Sl9NiT84m2GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNLCdrJXOcG+9RKrNP47I0U78tgynQzyGmlQet7MdNKgSJiMvVok0SCpC5OF574Q9
	 RQunhn+QQc80CD+I3Aj3CUkS+aGS0PHwV50lA3XYMEhjd+80zKHWblRv4pbulldaOg
	 pONg+FWH2i1r+OjQ5fDTo8z673EAE0jNjKaMHDNQ/IkMpjEVctX8Y1sQqj45KFCDxf
	 Kysx/DW/gfZedakNgOFsbRCDlhZqzMRs2ikM8slB9BojPDYPtIz8iD2vcX7UlbVdv/
	 dwGMcw7EaDZ0cJ59I4WDNt33wkNYnM84dU7eBa9SnAceq3s+UWw8tu+W5aeXznj6xW
	 JlWDZwHwgbGTg==
Date: Sat, 3 Feb 2024 09:08:06 -0700
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
Message-ID: <20240203160806.GA520926@dev-fedora.aadp>
References: <20240202-provide-cc_vendor-without-arch_has_cc_platform-v1-1-09ad5f2a3099@kernel.org>
 <20240203102925.GFZb4VhT1IwX-XRxTV@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203102925.GFZb4VhT1IwX-XRxTV@fat_crate.local>

On Sat, Feb 03, 2024 at 11:29:25AM +0100, Borislav Petkov wrote:
> On Fri, Feb 02, 2024 at 04:53:21PM -0700, Nathan Chancellor wrote:
> > Commit a9ef277488cf ("x86/kvm: Fix SEV check in sev_map_percpu_data()")
> > exposes this build error but I think it is really a problem with commit
> > da86eb961184 ("x86/coco: Get rid of accessor functions"), although I am
> > not positive so I left out the fixes tag.
> 
> Well, which is it?

Perhaps I should have expanded more on this in the commit message or
trailer.

> If you're running those GCOV LLVM tests regularly and you haven't seen
> it after da86eb961184, then it cannot be that one, can it?

Well the issue is that at da86eb961184, all uses of cc_vendor is in code
that is guarded by either CONFIG_AMD_MEM_ENCRYPT or
CONFIG_INTEL_TDX_GUEST, which both select CONFIG_ARCH_HAS_CC_PLATFORM,
so this build error cannot happen at that revision.

$ git grep cc_vendor da86eb961184
da86eb961184:arch/x86/coco/core.c:enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
da86eb961184:arch/x86/coco/core.c:        switch (cc_vendor) {
da86eb961184:arch/x86/coco/core.c:        switch (cc_vendor) {
da86eb961184:arch/x86/coco/core.c:        switch (cc_vendor) {
da86eb961184:arch/x86/coco/tdx/tdx.c:        cc_vendor = CC_VENDOR_INTEL;
da86eb961184:arch/x86/hyperv/ivm.c:        cc_vendor = CC_VENDOR_AMD;
da86eb961184:arch/x86/include/asm/coco.h:enum cc_vendor {
da86eb961184:arch/x86/include/asm/coco.h:extern enum cc_vendor cc_vendor;
da86eb961184:arch/x86/include/asm/sev.h:        if (cc_vendor == CC_VENDOR_AMD &&
da86eb961184:arch/x86/include/asm/sev.h:        if (cc_vendor == CC_VENDOR_AMD &&
da86eb961184:arch/x86/include/asm/sev.h:        if (cc_vendor == CC_VENDOR_AMD &&
da86eb961184:arch/x86/mm/mem_encrypt_identity.c:                cc_vendor = CC_VENDOR_AMD;

However, is it really a9ef277488cf's fault that it happened to use
cc_vendor in generic code where those same conditions may or may not
satisfied? If it had used cc_get_vendor() instead if da86eb961184 had
not existed, this issue would not have happened.

I have no issues with blaming a9ef277488cf but I think da86eb961184 is
equally blamable for removing the option to use cc_vendor in generic x86
code where CONFIG_ARCH_HAS_CC_PLATFORM may not be set. Hopefully that at
least carifies the "which is it?" question, I'll do whatever you think
is best.

Cheers,
Nathan

