Return-Path: <linux-kernel+bounces-57238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1DF84D576
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B9DB21A8E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340F412F37B;
	Wed,  7 Feb 2024 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMIHIKrh"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343B412D749;
	Wed,  7 Feb 2024 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341955; cv=none; b=nAnsBA6977Gp6Jx9SdRugPzVqDWVok1KueJ9XK5oGBRsWtW3RqDH8EfEEVPY6O5gapUKNQcn1ziMkRaXTagpR1S8YK/rRtWmd+D7J/LIQr71dRqqDejdgTQMQ9VAbQY/uODPvQGA72aIKrEyWIyIFanBj7di0VL4+5HvQShoF2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341955; c=relaxed/simple;
	bh=6ZWqFx3ca1jpgWlsqAfIR5Ati7mNHH87BZaKOn9KJ9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK3vEndJSIGDZcDixzvKiN3DKdAO1M87zWTIYoS2QdkH3O31dH7uiw8QxojYBq1L5XAfVfuCmEql7zCX5BRzcW/RUnqLGOKa9uqLKvOvOoEJB55AgCmigHoVBpCxBIQSNkUYUR83mIOedsI9m42st53qBnAHVzRptYlF4tHrmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMIHIKrh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so1425833a12.1;
        Wed, 07 Feb 2024 13:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707341951; x=1707946751; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHrWrs6xdhZ+695CZ3GqYRaPvXyFlxSiTcqYfb21vc0=;
        b=SMIHIKrhDaA6RSmcrIZJM9ih1OSs6lvsAuTkKQGAnMjlj4iJnYfVdLuAJxa0/LXQMb
         T3K8ornTPDrDyRBQCiEGVRIBECqauIeMVCh9yo77xkoFbIRKXbo1q/cjbWuHWIuX0EtN
         L5BamIR+0PTb2ruVWqnVszVsISEP/ofCSbkmsQIGVLvCBS/RbKJw1+XZA/hy+8UDwXpm
         ce43kEFcni+tIoCq8g11fhcG9/6r4Mkt84N+j74XP4VkHe/cYaMhE+pQzchOnfFhxHBM
         GQx2bglCIzvfU/MAwkBxkWHN4/scNG0vC4XYD+tdxfQxIXSRS5iiKrd1XlBNeMZOEwcj
         7s8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707341951; x=1707946751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHrWrs6xdhZ+695CZ3GqYRaPvXyFlxSiTcqYfb21vc0=;
        b=MNa82kMbIEexC+w6zo8GtAzBzFTK3DrL5OQT8YQQUbx3k1QWknF5O5WQxQN/9Qd6XK
         ZLuchn3eKjNCs2CC7dD2rGcuhV72uSNBR3ddiuEmpVjJOUa+Nxbx6HcW/UjM9fJHoPnz
         z0N4W6JqhuDVDXYrb8qWi3Qf577iuQL+YCE8ubh8PwdKCnp6T8BZoHZltbYvkBLwQLEm
         9bJEFvZYTJzAzYGKmc2y/jAGZhdXWvIjHbeLVN0v/7JKGpte9UEe4dnRjvaRKKg/LAp+
         cQzHaArvUXlSeAnrStti3f2zAWSFPRkN2dztpYGVLSZAHH+Th9DmlwCyMh8YYsNPnzS/
         TSiQ==
X-Gm-Message-State: AOJu0YzhTfxlghwoDy2ZchRVx19JNHyAWic08ELXZvTtRLQ+Ve8O1626
	kKq82Cq6HtdGJ0pk2iX64Xk+Qrk7D0lOUJn8KqVOUa4QWTAyFEKE
X-Google-Smtp-Source: AGHT+IH31AJIGaV5jSnbTxJFqgSEJhPOZR2SHDszJJRSiECJXp6pPaxQhhYbrQ2TFfU4Zn6lsuv1HQ==
X-Received: by 2002:aa7:d391:0:b0:560:c6a8:e7d3 with SMTP id x17-20020aa7d391000000b00560c6a8e7d3mr3034780edq.1.1707341951102;
        Wed, 07 Feb 2024 13:39:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBIIJ98wcDQML8JTumvwwlEMas1YdRlwRZ9VPj2YErTrfZA0ITOze9hMyXD5njhtPGQDcMIbzZO8miUxa7gmUPQ+n2VUnNbB1kVVMF1VJ8+P4EcwyHsJ4+GMEhRSSnZHxk/e1LE1fgLcALZT6cnXGGVSWs4lackno8YBhI38F3byEcaVgvtM/qrA/DfK+KXXBBjwsjib/gZQfPvVgExxtmb8LbLXtVq2CyZ3Ei5H/mZzwtpFlRL9ajxZcpMn7WsjnK625IxW74f9jzuy4/GKJa8yOF3QM0O6E+xTG0VMIMGnXLpXmZf8M6zb9fFOatMPKgmEep
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id df21-20020a05640230b500b00557aa8d72c9sm120400edb.25.2024.02.07.13.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:39:10 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 7EF0EBE2EE8; Wed,  7 Feb 2024 22:39:09 +0100 (CET)
Date: Wed, 7 Feb 2024 22:39:09 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: Jordan Rife <jrife@google.com>, Valentin Kleibel <valentin@vrvis.at>,
	David Teigland <teigland@redhat.com>, 1063338@bugs.debian.org,
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, gregkh@linuxfoundation.org,
	regressions@lists.linux.dev
Subject: Re: [regression 6.1.76] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
Message-ID: <ZcP4fXEllcCDHyE6@eldamar.lan>
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
 <ZcNdzZVPD76uSbps@eldamar.lan>
 <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
 <CAK-6q+hza9yXb5KpBS2VJMNHJa805nXqiYPTovnf9G-JFadBsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+hza9yXb5KpBS2VJMNHJa805nXqiYPTovnf9G-JFadBsg@mail.gmail.com>

Hi Alexander,

On Wed, Feb 07, 2024 at 04:27:48PM -0500, Alexander Aring wrote:
> Hi,
> 
> On Wed, Feb 7, 2024 at 1:33 PM Jordan Rife <jrife@google.com> wrote:
> >
> > On Wed, Feb 7, 2024 at 2:39 AM Salvatore Bonaccorso <carnil@debian.org> wrote:
> > >
> > > Hi Valentin, hi all
> > >
> > > [This is about a regression reported in Debian for 6.1.67]
> > >
> > > On Tue, Feb 06, 2024 at 01:00:11PM +0100, Valentin Kleibel wrote:
> > > > Package: linux-image-amd64
> > > > Version: 6.1.76+1
> > > > Source: linux
> > > > Source-Version: 6.1.76+1
> > > > Severity: important
> > > > Control: notfound -1 6.6.15-2
> > > >
> > > > Dear Maintainers,
> > > >
> > > > We discovered a bug affecting dlm that prevents any tcp communications by
> > > > dlm when booted with debian kernel 6.1.76-1.
> > > >
> > > > Dlm startup works (corosync-cpgtool shows the dlm:controld group with all
> > > > expected nodes) but as soon as we try to add a lockspace dmesg shows:
> > > > ```
> > > > dlm: Using TCP for communications
> > > > dlm: cannot start dlm midcomms -97
> > > > ```
> > > >
> > > > It seems that commit "dlm: use kernel_connect() and kernel_bind()"
> > > > (e9cdebbe) was merged to 6.1.
> > > >
> > > > Checking the code it seems that the changed function dlm_tcp_listen_bind()
> > > > fails with exit code 97 (EAFNOSUPPORT)
> > > > It is called from
> > > >
> > > > dlm/lockspace.c: threads_start() -> dlm_midcomms_start()
> > > > dlm/midcomms.c: dlm_midcomms_start() -> dlm_lowcomms_start()
> > > > dlm/lowcomms.c: dlm_lowcomms_start() -> dlm_listen_for_all() ->
> > > > dlm_proto_ops->listen_bind() = dlm_tcp_listen_bind()
> > > >
> > > > The error code is returned all the way to threads_start() where the error
> > > > message is emmitted.
> > > >
> > > > Booting with the unsigned kernel from testing (6.6.15-2), which also
> > > > contains this commit, works without issues.
> > > >
> > > > I'm not sure what additional changes are required to get this working or if
> > > > rolling back this change is an option.
> > > >
> > > > We'd be happy to test patches that might fix this issue.
> > >
> > > Thanks for your report. So we have a 6.1.76 specific regression for
> > > the backport of e9cdebbe23f1 ("dlm: use kernel_connect() and
> > > kernel_bind()") .
> > >
> > > Let's loop in the upstream regression list for tracking and people
> > > involved for the subsystem to see if the issue can be identified. As
> > > it is working for 6.6.15 which includes the commit backport as well it
> > > might be very well that a prerequisite is missing.
> > >
> > > # annotate regression with 6.1.y specific commit
> > > #regzbot ^introduced e11dea8f503341507018b60906c4a9e7332f3663
> > > #regzbot link: https://bugs.debian.org/1063338
> > >
> > > Any ideas?
> > >
> > > Regards,
> > > Salvatore
> >
> >
> > Just a quick look comparing dlm_tcp_listen_bind between the latest 6.1
> > and 6.6 stable branches,
> > it looks like there is a mismatch here with the dlm_local_addr[0] parameter.
> >
> > 6.1
> > ----
> >
> > static int dlm_tcp_listen_bind(struct socket *sock)
> > {
> > int addr_len;
> >
> > /* Bind to our port */
> > make_sockaddr(dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> > return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
> >    addr_len);
> > }
> >
> > 6.6
> > ----
> > static int dlm_tcp_listen_bind(struct socket *sock)
> > {
> > int addr_len;
> >
> > /* Bind to our port */
> > make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> > return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
> >    addr_len);
> > }
> >
> > 6.6 contains commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs on heap) which
> > changed
> >
> > static struct sockaddr_storage *dlm_local_addr[DLM_MAX_ADDR_COUNT];
> >
> > to
> >
> > static struct sockaddr_storage dlm_local_addr[DLM_MAX_ADDR_COUNT];
> >
> > It looks like kernel_bind() in 6.1 needs to be modified to match.
> >
> 
> makes sense. I tried to cherry-pick e9cdebbe23f1 ("dlm: use
> kernel_connect() and kernel_bind()") on v6.1.67 as I don't see it
> there. It failed and does not apply cleanly.
> 
> Are we talking here about a debian kernel specific backport? If so,
> maybe somebody missed to modify those parts you mentioned.

Thanks all for looking into it.

No it's not a Debian specific backport, e9cdebbe23f1 ("dlm: use
kernel_connect() and kernel_bind()") got in fact backported upstream
in 6.1.76, 6.6.15 and 6.7.3. The respective commits are:

v6.1.76: e11dea8f503341507018b60906c4a9e7332f3663 dlm: use kernel_connect() and kernel_bind()
v6.6.15: c018ab3e31b16ff97b9b95b69904104c9fcca95b dlm: use kernel_connect() and kernel_bind()
v6.7.3: 4ecf1864f2076872b7aea29d463e785ef6fc9909 dlm: use kernel_connect() and kernel_bind()
v6.8-rc1: e9cdebbe23f1aa9a1caea169862f479ab3fa2773 dlm: use kernel_connect() and kernel_bind()

But for the 6.1.76 case there is the above regression (while it works
for 6.6.15 as confirmed by the reporter).

I'm very sorry I see where I have caused you confusion: The regression
is in 6.1.*76* not 6.1.*67* and I misstyped the version in two places.

Regards,
Salvatore

