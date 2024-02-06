Return-Path: <linux-kernel+bounces-55426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5596584BC92
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12245289C74
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B5EDDD2;
	Tue,  6 Feb 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="U6dbarqv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F2G1epIv"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42EDDCF;
	Tue,  6 Feb 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242125; cv=none; b=bzc5aw2Tzgym6Gp0edb+XRqyZyeZmD+j2vmna6yp0Ts30OtFW6CBPFuTrA28HMCc3Q8lzGn8zMm7Fq441XhOjWILSlaXstwbCR6ktVJc9fCcs91L7XBZNKgvAx1HX0GzKQyY2rLpRiqDHDbYBbdezGdkoePLuN64xv99a1uDNg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242125; c=relaxed/simple;
	bh=vYpVklxsp9a2xUIs/wY88jNQ5mHAiOcEwhPYeMKMGD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7qcUVLK/UoJPAwKZfuI1kVeEKnhYlL8IGPR3O+v68kwE48fxEr6d0zz3TMKiLYbEdkEgMwxyH2MdGjut26+TNFMrVtrodZkqh1uIGZJGnuGBj4mkdG8vxXynl6Osf+Tni+L8gSW4ta8nlAJAluOXXrYQyQVnDFuwV+AmzA7fDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=U6dbarqv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F2G1epIv; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A40535C005A;
	Tue,  6 Feb 2024 12:55:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 06 Feb 2024 12:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707242121; x=1707328521; bh=e1EAQQRKi1
	25NncAMIEO4HlMNemKHBTjJx/Rtk6PoO4=; b=U6dbarqvMSQGmpM+Cx9ag8ZNYl
	ycUk8RFTbSkcSc/ntfTCf0w+WHOkyrESISZKn3yS7vQeXQutAu6yyMSHDml7muY0
	WAGCveIzfhH0umAK+oyDLb7DJB3fK2wCOUvF6HarlTnFzS3VCgn43+uweGP7tCuG
	nNc4cYLCORWfU1+p4xu3JO6yeS8Kdu0y7IAgRuS/IMuBbkIk6laDN+dSeJdkViTK
	HgBV+LzhOg7x5cPvf0aXirO3/o2tVrWyt5iJxSLxvYEjv9bA4cBG/HJKTRIijAxa
	RVRLcRf84VYl+CYBzXCHaMNJeFCZ5araxjOam1H2zbsKBZQPPvfxwzFhPCdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707242121; x=1707328521; bh=e1EAQQRKi125NncAMIEO4HlMNemK
	HBTjJx/Rtk6PoO4=; b=F2G1epIvD5u5UEZ6DwZO86jU3+FmrXMNGT0gbVEZug4Q
	oRN27UoCf4CZuY7HrdfsBGi+QgeyiJHeRrLgj402LTx6+HHx1/aHpoQdG69P+uql
	bxBtmtviTONfV/NLwtJot/5KMQcJHQ7EiGxLBnvWFhVpEBvvk/VINqzZr3skWlr8
	xQ3qRPOoaP9OsTf6djYbHT+mTfsbRCCVurWgclb1S5WGrdC4fYHnvm/UD1/jp+jO
	JussFIFuAJU9sY7VjExslHqvkpg3viQ4OePSimGU4G8b5Bubx5gN1zDbW6+bMHRj
	W9XiYA2rNsKNd0u4VQGnVpTrj+Op2QPOaDiPp3PauQ==
X-ME-Sender: <xms:iXLCZbQNR6dgLwOjyzV_P4XTtlB0KZVfzdBfz-cYtmrLscHxNo06dA>
    <xme:iXLCZcypdhHs4_gNdCfTzFDuhlKKj6H6NJQJyUgX0CtcD2kJrcTotQMn6XRk3SKSI
    U3nzMLjWC6p7b_Uft0>
X-ME-Received: <xmr:iXLCZQ3sg3Nw3if2w9A17BQpuDpPyXwxU_l1s2luMi5kaBFeBZHxb4mBV6BOfCzYlWj3m4nJdkllye5DHRcDHq8UaamF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:iXLCZbCbHtz-8dywLumOs2k4kuSQB0cY-3fpV2vjjyfFen1rgIBFTw>
    <xmx:iXLCZUgubJtR-g1GVqPo9Wka37OXAdW3pLWTk0xDjNW_WitaZLUH8w>
    <xmx:iXLCZfoA6_kQj9vpgh1D_o7PZRfg0aBUK1zb1aqM3tbIO2BfzO6RKA>
    <xmx:iXLCZeY9cog2nzOZ5j5OzTXc0Djti8ukEDHUtywloQexkxXQLzBGkA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 12:55:20 -0500 (EST)
Date: Tue, 6 Feb 2024 10:55:19 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <ZcJyhwr+uW73iuIX@tycho.pizza>
References: <20240206164308.62620-1-tycho@tycho.pizza>
 <20240206173722.GA3593@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206173722.GA3593@redhat.com>

On Tue, Feb 06, 2024 at 06:37:22PM +0100, Oleg Nesterov wrote:
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -688,7 +688,7 @@ static int pidfd_getfd(struct pid *pid, int fd)
> >  	int ret;
> >  
> >  	task = get_pid_task(pid, PIDTYPE_PID);
> > -	if (!task)
> > +	if (!task || task->flags & PF_EXITING)
> >  		return -ESRCH;
> 
> This looks racy. Suppose that pidfd_getfd() races with the exiting task.
> 
> It is possible that this task sets PF_EXITING and does exit_files()
> after the "task->flags & PF_EXITING" check above and before pidfd_getfd()
> does __pidfd_fget(), in this case pidfd_getfd() still returns the same
> EBADF we want to avoid.
> 
> Perhaps we can change pidfd_getfd() to do
> 
> 	if (IS_ERR(file))
> 		return (task->flags & PF_EXITING) ? -ESRCH : PTR_ERR(file);
> 
> instead?
> 
> This needs a comment to explain the PF_EXITING check. And perhaps another
> comment to explain that we can't miss PF_EXITING if the target task has
> already passed exit_files, both exit_files() and fget_task() take the same
> task_lock(task).
> 
> What do you think?

Yes, you're absolutely right. Let me resend.

Tycho

