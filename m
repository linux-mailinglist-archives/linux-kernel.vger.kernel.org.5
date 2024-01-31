Return-Path: <linux-kernel+bounces-46960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410458446EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9237290317
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FE212FF8D;
	Wed, 31 Jan 2024 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU9tleDu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5BD12FF77
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724915; cv=none; b=qZh9miVHlypD8K0zR8Ppi/LRaaQc8UAIdbcLF4zLXzyd1fczkmKuH5YXt+lM0eM/ceg6EWOeYUtYcfkpj1ERxnoYIsUfazdmOL+4zRmye5LESfq2SI5sYhbSCQa3JH9SbHVpHpVSwxMFF7KHsKTnkcsMiCC/tD3FAUoOpEzBdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724915; c=relaxed/simple;
	bh=QJm8orclJe/ubAtpVMyo6AepkOchd3CEPwVIS+4jnLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzw6PLjkchpxxjfjz268oyCS1Rdz+yvmN+FrcnxeFanA4JT03wIjOCCb+tZOen5SkuOs8AMrsx1YqODiI2iD4Ar/AE36CQtjtJ7/R1euBSv3M/KPLJjseqOQPGIGXEdoP/dMPNGaqZDef3KotStEMq1VHWAX1Z+kFeaqgOK7OXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU9tleDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E14C433F1;
	Wed, 31 Jan 2024 18:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706724915;
	bh=QJm8orclJe/ubAtpVMyo6AepkOchd3CEPwVIS+4jnLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DU9tleDuhbfiqaH5mvdiclk1wppXbyWP5LythUQXLCoKmeULFIfl6UuHz/kxoiIDJ
	 M2xPIOfI/JFOMhtxyeuvfB3pc7Yd6tOsItt77RuWnub1ayPHYlXQatLNu3uEMSveaW
	 ZsEBT0FudlBw/C77Cf9vlP8fG70NtyXxEVweBH/2WVX0a9TkL9jIz6VxXZMmAPVnIL
	 pNt6B0aBVJcANUX6r9Pn0L9uCQJxlm7JMKaHZiWBR8hsHEPb3UPOrjZRXXG6Zcl3W8
	 yi+2NRYGR4DfKosSHv2vKf/oihWkKBypOss159pruaTpU3VK0qLwHJWnS6jdPqC3oC
	 MgPWkYpwEI+ZQ==
Date: Wed, 31 Jan 2024 19:15:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240131-hinzu-passen-7fb33796244f@brauner>
References: <20240131132541.GA23632@redhat.com>
 <20240131132602.GA23641@redhat.com>
 <ZbqCKgTuP/IaEbMM@tycho.pizza>
 <20240131180146.GD2609@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131180146.GD2609@redhat.com>

On Wed, Jan 31, 2024 at 07:01:47PM +0100, Oleg Nesterov wrote:
> On 01/31, Tycho Andersen wrote:
> >
> > >  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> > >  {
> > > -	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> > > +	bool thread = flags & PIDFD_THREAD;
> > > +
> > > +	if (!pid || !pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID));
> >
> > Small typo here, trailing ;. When I fix that, tests pass for me.
> 
> OOPS.
> 
> Christian, should I spam lkml with v4, or will you add this fix yourself?

I fixed that up. No need to resend!

