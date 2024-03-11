Return-Path: <linux-kernel+bounces-98894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F368780C4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D581F21BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3039222064;
	Mon, 11 Mar 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDK09Sbx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D43FB21
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164527; cv=none; b=faflU63AbSV4xbaSHhWVML4lKYwCChr/JhyCwM6LI2FBKvlZkVAPXqVNDEsnN6Zyz7dStfvTe8i6ZeFN9rZVK+9tejO36lqrinS88mcqQhQ6vCqmDILyM4nSZL2YqT6ohe7KDZGRK3aPYSdiBq6E7YIzI8dWy2O1EIx89BnIEWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164527; c=relaxed/simple;
	bh=GBZJtwDWuIO+GSAmxpBqcvQHRzPIx+s/dcBLIqAv15w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/ebTdhmEhhKxVDJZohiTmTlmDpyxiOidY28sxF0PyuIl1iVVehJGnvGOnirJ3zWPDDP4Bi6FM+FYAttSikoXQWfuh8aF2X4EDQkw2Ky0LL0rcvdiH7Q1v+pdKdCaw1sRBW74T5kvDdhb8kDLhPG4UzYlug0dW8Kgn2HAfn4qlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDK09Sbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2530C433C7;
	Mon, 11 Mar 2024 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710164527;
	bh=GBZJtwDWuIO+GSAmxpBqcvQHRzPIx+s/dcBLIqAv15w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDK09SbxurXhUorcOf6awSEAQvnvNLlxJLmf9KRq/b2egdLPROcJkjVRaDN4kyvsT
	 oXn23UW1E2sJK0JEkx4NL/2CXElPinlkkjpd7eoCpiJPamEEYyLEUv9ggR/0f3KaXI
	 QPAFx1hqABrcy7dUMY4ax6zJxaBGkvBH9QP9nbUPGJDsgN7KSQi7r6PFom4o8zfNzL
	 NpD2zYXAg8sF3N7nBrk4jXcv0zJam+Sywn/HMjytc+95TTva/Z3mOm6c5ZZQeBnjoi
	 K7FWsMaC/PiUP9k0LNtINsI+zqTIty2LNI5oLUiUAvMtEWZcRxt19jTI6GVTjZQjVF
	 Dm60qwKkpuHbw==
Date: Mon, 11 Mar 2024 13:42:02 +0000
From: Lee Jones <lee@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: CVE-2023-52514: x86/reboot: VMCLEAR active VMCSes before
 emergency reboot
Message-ID: <20240311134202.GQ86322@google.com>
References: <2024030251-CVE-2023-52514-c93d@gregkh>
 <Ze7d0YCDKdu_LJWc@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze7d0YCDKdu_LJWc@tiehlicka>

On Mon, 11 Mar 2024, Michal Hocko wrote:

> On Sat 02-03-24 22:52:59, Greg KH wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > x86/reboot: VMCLEAR active VMCSes before emergency reboot
> > 
> > VMCLEAR active VMCSes before any emergency reboot, not just if the kernel
> > may kexec into a new kernel after a crash.  Per Intel's SDM, the VMX
> > architecture doesn't require the CPU to flush the VMCS cache on INIT.  If
> > an emergency reboot doesn't RESET CPUs, cached VMCSes could theoretically
> > be kept and only be written back to memory after the new kernel is booted,
> > i.e. could effectively corrupt memory after reboot.
> > 
> > Opportunistically remove the setting of the global pointer to NULL to make
> > checkpatch happy.
> > 
> > The Linux kernel CVE team has assigned CVE-2023-52514 to this issue.
> 
> I do not really see the security aspect of this fix. Guests systems
> shouldn't be able to trigger host reboot nor any untrusted entity should
> on the host either or this would be a serious security hole.
> 
> Or am I missing something?

Thanks for reporting.

If Sean and/or Paolo agree, we can revoke the CVE for you.

-- 
Lee Jones [李琼斯]

