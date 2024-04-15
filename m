Return-Path: <linux-kernel+bounces-144908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D21B8A4C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59503281460
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E47A58139;
	Mon, 15 Apr 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cl4V3bw/"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA15C5812A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176832; cv=none; b=CnOmg0t3HOMw/0Hc5wuDyQct+/Hxp6g6uXkwxB0PXcuOLvwkeInwKuDpERIjYBbexN5ds4YIJ6cQXLuEJgZVKxRz+GaaYSLhlrNwwt/wk4z0S5aTpLCdnowcKvIXirAJ/AWpHRaPsilOVFgM1o8sMLoVOUy+NLrf9sqTSE4GMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176832; c=relaxed/simple;
	bh=4666bQ5C7Q5rqF8FqPbc+Mmrfwwnhga/7n6qezH6Z68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8naLp4dYGAfX2NVVAf5qshX2Ns5L5UDAJm8BLAtXM8pMo7FuBFTzYpL70X4Yxw8QiX+4Gpkx7BPdwUr+pm0OTeOkB/EFC2kzdBtGxPM4UJx3qeaW0kGCVsdN2+3PXePMdaBXCXEayHPMPBv3IH3omEFySzCFZjVzeq17WKxo48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Cl4V3bw/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qrOKfC3vNeV6cJvML6qpei/ma+54N48f+DUN+SqAsWo=; b=Cl4V3bw/qj0KOyCFEI21RVAkyB
	RB24GlF6+j/0k31OguZjdWDLwp0XmghSGP1QNY7qazglnYw5piRk3DbIw5OUe+XP2owpL+wGshdED
	bnYMYgZU4MiM8If2jKdIcr5hxwXOTaCye02R9MiuYW/3mHc0A3X6nUpnMLfxVY2VYIXGlxUr2+Fbx
	kGRkN+5Ye+1bVaK1qwCvQWqoSbw+rBTCN7cQviZ5FvScjslr5MoUeFd+GHuNmktQi5N8wDeeDqwvU
	6d/F8orP71l0jcqAULXJLfW5EtOcBwqzLiuGPc125JMPED6nwAOXIH3+Mso83yG8fKElPsigNmz1n
	rhzUlQKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36548)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwJYE-00060O-2O;
	Mon, 15 Apr 2024 11:27:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwJYE-00027g-BR; Mon, 15 Apr 2024 11:27:02 +0100
Date: Mon, 15 Apr 2024 11:27:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
Message-ID: <Zh0A9p/l8lmIrunk@shell.armlinux.org.uk>
References: <0000000000004cf5c205faf1c7f3@google.com>
 <dcf54740-7cc3-4017-ad1b-8626a22fc15e@I-love.SAKURA.ne.jp>
 <Zg1/1xbmrY4yDfhO@shell.armlinux.org.uk>
 <ZhztQ9CvDm3UPgE9@FVFF77S0Q05N>
 <c5a3598d-16dd-4aeb-904e-2084fafef9fe@I-love.SAKURA.ne.jp>
 <Zhz3EEsnGSOgnYWA@shell.armlinux.org.uk>
 <2ab55fd1-7eb0-488e-93ea-660fa05ee43a@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab55fd1-7eb0-488e-93ea-660fa05ee43a@I-love.SAKURA.ne.jp>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 15, 2024 at 06:58:30PM +0900, Tetsuo Handa wrote:
> On 2024/04/15 18:44, Russell King (Oracle) wrote:
> > On Mon, Apr 15, 2024 at 06:38:33PM +0900, Tetsuo Handa wrote:
> >> On 2024/04/15 18:02, Mark Rutland wrote:
> >>>   08626a6056aad824 ("arm: Implement thread_struct whitelist for hardened usercopy")
> >>>
> >>> That commit says that all accesses are bounce-buffered and bypass the check,
> >>> but AFAICT the fpa_set() code hasn't changed since then, so either that was
> >>> wrong or the user_regset_copyin() code has changed.
> >>
> >> Then, can we go with https://lkml.kernel.org/r/0b49d91b-511f-449e-b7c3-93b2ccce6c49@I-love.SAKURA.ne.jp ?
> > 
> > Have you visited that URL? It doesn't point to an email containing a
> > patch, so sorry, I don't know what patch you're referring to.
> > 
> 
> Containing a link to a diff. ;-)
> 
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index c421a899fc84..347611ae762f 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -583,10 +583,15 @@ static int fpa_set(struct task_struct *target,
>  		   const void *kbuf, const void __user *ubuf)
>  {
>  	struct thread_info *thread = task_thread_info(target);
> +	const unsigned int pos0 = pos;
> +	char buf[sizeof(struct user_fp)];
> +	int ret;
>  
> -	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> -		&thread->fpstate,
> -		0, sizeof(struct user_fp));
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> +				 buf, 0, sizeof(struct user_fp));
> +	if (!ret)
> +		memcpy(&thread->fpstate, buf, pos - pos0);
> +	return ret;
>  }
>  
>  #ifdef CONFIG_VFP

No, not unless there is really no other option. It's hacking around the
issue, creating two copy operations of the data (one onto the stack)
rather than solving it properly - and I will not put up with that kind
of mentality - it's a completely broken approach to open source
software. If there is a problem, always fix it using the correct fix,
never try to sticky-plaster around a problem.

It seems there is a way for architectures to tell the code what is
safe to write to, and it seems that a misunderstanding meant this
wasn't implemented. So let's see whether it's possible to fix that
first.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

