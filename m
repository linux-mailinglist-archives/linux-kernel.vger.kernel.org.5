Return-Path: <linux-kernel+bounces-78721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E278617C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FA31F23BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B8A84FB2;
	Fri, 23 Feb 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJM2oyYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD383A0D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705447; cv=none; b=Vl5B1lV3Bvy/rmwPDU44sU1+UsT5odweRrMEVKGIz3NJy4zyc9t1ZSyZGUs7GmOReYRJ08sbpQePWy/wafqUU3Wr7BGqKzZiULN+wJh6kPlLxvJQmD2tqKyggiHuroR1xCh3O129bgsBnd8ATi/alCaxcGp6IsLvCwGdWlaIIIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705447; c=relaxed/simple;
	bh=jpd2uydbbK2quIVAUF2f9Jm7NYNaMdUuijZBqca6Nd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYPaqdpdHm39eShJBpAJMTYuHCTul0Af0QYtJahaHCAvzpymxcbYMgDxpi5zwCdOtNi6E+MNLbo04w60Aecj3ZEs0HzfvqKp/e3MNJZC5hsK7O4peRQ1E4NAjTGTB5x4ZLGi1p+EayPH5OXOSkQ0kZHzBkZn0IsZRafiLPlqSp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJM2oyYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD6FC433C7;
	Fri, 23 Feb 2024 16:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705446;
	bh=jpd2uydbbK2quIVAUF2f9Jm7NYNaMdUuijZBqca6Nd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJM2oyYa2uhQh7ht7Wgz9mA/FZAQ9kTpaAsRV9rzZbMGfzV9EwADGL8rI53rlbyP4
	 1eF7QTqIIoYx6Bc0AqEOV0PZnK4Xt6N4KEIFPqB0tMmW31U40Y8SGcrbh73RumILzY
	 nTgXnOnRyaje6+d286YI0gk0r6TrEKHlC4sTmIexd87gwF/uHad27DvP4xC2FJaCSa
	 +lZoNldBO4kLbufRa+5uV0A3teSZhZMaHh+oam0IATwTKbWofU82Gs70OXPW5rrKN6
	 N5WccSNcI+8r5FnlddIbsDiiWLmpQQc0EFRPU8ZKYMuOCztz2whPoPtHKD+Havy+Tp
	 LkXlOb8aRvBnQ==
Date: Fri, 23 Feb 2024 17:24:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	stgraber@stgraber.org, cyphar@cyphar.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] tests/pid_namespace: add pid_max tests
Message-ID: <20240223-kantholz-knallen-558beba46c62@brauner>
References: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
 <20240222160915.315255-3-aleksandr.mikhalitsyn@canonical.com>
 <Zdd8MAJJD3M11yeR@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zdd8MAJJD3M11yeR@tycho.pizza>

On Thu, Feb 22, 2024 at 09:54:08AM -0700, Tycho Andersen wrote:
> On Thu, Feb 22, 2024 at 05:09:15PM +0100, Alexander Mikhalitsyn wrote:
> > +static int pid_max_nested_limit_inner(void *data)
> > +{
> > +	int fret = -1, nr_procs = 400;
> > +	int fd, ret;
> > +	pid_t pid;
> > +	pid_t pids[1000];
> > +
> > +	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
> > +	if (ret) {
> > +		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
> > +		return fret;
> > +	}
> > +
> > +	umount2("/proc", MNT_DETACH);
> > +
> > +	ret = mount("proc", "/proc", "proc", 0, NULL);
> > +	if (ret) {
> > +		fprintf(stderr, "%m - Failed to mount proc\n");
> > +		return fret;
> > +	}
> > +
> > +	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
> > +	if (fd < 0) {
> > +		fprintf(stderr, "%m - Failed to open pid_max\n");
> > +		return fret;
> > +	}
> > +
> > +	ret = write(fd, "500", sizeof("500") - 1);
> > +	close(fd);
> > +	if (ret < 0) {
> > +		fprintf(stderr, "%m - Failed to write pid_max\n");
> > +		return fret;
> > +	}
> > +
> > +	for (nr_procs = 0; nr_procs < 500; nr_procs++) {
> > +		pid = fork();
> > +		if (pid < 0)
> > +			break;
> > +
> > +		if (pid == 0)
> > +			exit(EXIT_SUCCESS);
> > +
> > +		pids[nr_procs] = pid;
> > +	}
> > +
> > +	if (nr_procs >= 400) {
> > +		fprintf(stderr, "Managed to create processes beyond the configured outer limit\n");
> > +		goto reap;
> > +	}
> 
> A small quibble, but I wonder about the semantics here. "You can write
> whatever you want to this file, but we'll ignore it sometimes" seems
> weird to me. What if someone (CRIU) wants to spawn a pid numbered 450
> in this case? I suppose they read pid_max first, they'll be able to
> tell it's impossible and can exit(1), but returning E2BIG from write()
> might be more useful.

That's a good idea. But it's a bit tricky. The straightforward thing is
to walk upwards through all ancestor pid namespaces and use the lowest
pid_max value as the upper bound for the current pid namespace. This
will guarantee that you get an error when you try to write a value that
you would't be able to create. The same logic should probably apply to
ns_last_pid as well.

However, that still leaves cases where the current pid namespace writes
a pid_max limit that is allowed (IOW, all ancestor pid namespaces are
above that limit.). But then immediately afterwards an ancestor pid
namespace lowers the pid_max limit. So you can always end up in a
scenario like this. 

