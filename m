Return-Path: <linux-kernel+bounces-54162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8548084ABB8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217671F2565D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31D15A4;
	Tue,  6 Feb 2024 01:40:45 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CDC1362
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183644; cv=none; b=h1GT1Z6klS2Xt2jiP/i3YKYja0uzMHj515Fe6yEjmA2miR+Lvav3MmozKbe1MpyrOZNP2UE0Euwp9/cZnKtG2w1sF4maLIwkFtHtm5KpQYEGhQvOzbsnxNoLAdj8+BDv8Ipkv19pXE+T+10At3FSNPmmSKjgklSZyyZ6BkWJ+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183644; c=relaxed/simple;
	bh=JrPtZvkgBSvWGyUTBYm/grVlwhb04efI8CTULbYVyHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6Ssf81bTUkTEmE/KKCy0xi6bg8q1/HWX8zc87U1UKdwzcRLAk1DaJNFfmf3T0NEmPt/PXtSHj1lrUuWbuPJ45L0B+oosuyJerDbxW5xl1PVvzOJxnY6HVdlwmx6/UehmzHn3JScUIt2CfdbngDQTlbJyugMfqwHYueIbWLJOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp76t1707183572tof3oqsx
X-QQ-Originating-IP: 1y9BJL98O0FWwxi//dUeg6+B3OJEgGSmd4Nc+3lPLWY=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 06 Feb 2024 09:39:30 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: LE7C6P2vL8TvFsrGsG3IftlI7o2dwNJmdQOd2+XsdEjwaiwUVfgYswhwZqgYu
	WTlLhcJkF5rJRGjMJJkeqv4xQM9x3aJlFiscX3jQG418veVYqs6/zncfC1Oiz0EeikHZRR5
	tKzFcRU46LA6fCQtvUr7ai+wkFTUdeFyt4UX3OM6KPLgPbvL93V7H9GqhHgg03dCdIiBfnh
	UfcFxfDa7dw4GGj94cWp6nJftWj6TbbVdN7QJpTx41f6UowxonChfhfgptO6wheMuYl7y0z
	CK+j0bpTSlXZHFjTz1+XNqCndYCHjlIDbBzl+eO9WF3MQ6+M3fzxW+vcoGRKDMf72oATEwC
	zYpEfChNHdgNYmvSDPaTlROixForXp7PypGMajo2yAdrpjQmmk+2r4iakwKYA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7562001425463095076
Date: Tue, 6 Feb 2024 09:39:30 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mcgrof@kernel.org,
	jpoimboe@kernel.org, j.granados@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com
Subject: Re: [PATCH] arm64: remove unneeded BUILD_BUG_ON assertion
Message-ID: <DB04BC31DF5E38DB+ZcGN0lyKk+olujm8@centos8>
References: <20240202040211.3118918-1-dawei.li@shingroup.cn>
 <ZcDPOgoQE8IncTHY@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcDPOgoQE8IncTHY@FVFF77S0Q05N>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Mark,

Thanks for reviewing.

On Mon, Feb 05, 2024 at 12:06:18PM +0000, Mark Rutland wrote:
> On Fri, Feb 02, 2024 at 12:02:11PM +0800, Dawei Li wrote:
> > Since commit c02433dd6de3 ("arm64: split thread_info from task stack"),
> > CONFIG_THREAD_INFO_IN_TASK is enabled unconditionally for arm64. So
> > remove this always-true assertion from arch_dup_task_struct.
> > 
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  arch/arm64/kernel/process.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 7387b68c745b..4ae31b7af6c3 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -290,9 +290,6 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
> >  		fpsimd_preserve_current_state();
> >  	*dst = *src;
> >  
> > -	/* We rely on the above assignment to initialize dst's thread_flags: */
> > -	BUILD_BUG_ON(!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK));
> > -
> 
> Does the above cause any problem today, or is this patch just a cleanup?

It's just a cleanup patch.

> 
> For the benefit of other reviewers, the assertion and comment were added in
> commit:
> 
>   4585fc59c0e8 ("arm64/sve: Fix wrong free for task->thread.sve_state")
> 
> .. back in 2019, 3 years after commit:
> 
>   c02433dd6de3 ("arm64: split thread_info from task stack")
> 
> The comment and assertion were a safety-net for backports, since commit
> 4585fc59c0e8 was a fix which dependend upon the thread_info being contained
> within task_struct, and couldn't be backported to kernels without
> CONFIG_THREAD_INFO_IN_TASK.

Thanks for the update! It helps.

> 
> I'm sure that we currently have plenty of other code with a similar (but
> undocumented) dependency. Given we've unconditionally selected

Totally agreed.

> CONFIG_THREAD_INFO_IN_TASK since v4.10, and the oldest longterm stable kernel
> is v4.19 (with v4.14 having EOL'd last month), I think it makes sense to delete
> the assertion and comment.
> 
> So FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
> 

Thanks,

    Dawei

