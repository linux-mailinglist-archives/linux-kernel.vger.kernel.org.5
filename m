Return-Path: <linux-kernel+bounces-81834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B99F867B42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54AABB29CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD7512B153;
	Mon, 26 Feb 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9SY++mh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A812BE87
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962338; cv=none; b=C3So+Ko/7XPQP7KfZL1W3EDjrr7V3Fy8l4KL3+2nwdfsLGj9TTHqyTHz8XITs+Mz8X767tzcEmLdViKJH2i23GrbS1D5mLVxgClBjqBLqtHfhX2TrGYzwe3N4FzTuWjCUK2uvj1mSGo4Kn00Mu6gfO7kUsQEBzEq03TmWkETcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962338; c=relaxed/simple;
	bh=VsH0ymrYLcRyJRnocuhbJuZDkMN1aFvJrkS1qBHwOqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuXGm7Jh/peg09VTNJSZEDLc7hQ+ryVD2Zygs36bJcfpTuEbLpb+G4PeJpnPqA8BjGnjPPleTq5UbIKwg0YO0xfJg/wfUfg/HjLDVfxRPztdPdB6uKlrDvUKThPl0Pz3gQanEXiHErKfu1TKOynin+3lSDw/Te/yr+GP9678FEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9SY++mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22787C433C7;
	Mon, 26 Feb 2024 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708962337;
	bh=VsH0ymrYLcRyJRnocuhbJuZDkMN1aFvJrkS1qBHwOqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9SY++mhNAKw369O/4ET4NztG3dF+U4U2Fo2gCThAJHS4inmUjFIgWYn/UdttAMMf
	 lVfeJGREmZ4uUbb0LcItayvC/EPlyKo0Z/n2lTJ6e/Ym1uDG+AFZipoqoKhR9iJzJH
	 reBe+HZNyeza0I7xTpHvKx+zzPrhig6dO1/1NBcTXxHOi5ILswryo2YX2L+advZbET
	 +jeaLLyhz4252rs456/kX7oJYss55jEz0OgKThg5yk97/bz5N1/lWH5h/zL0gTjq/5
	 Sn61paoidyZIpP+v8eeIYhhOGkgd7dlDqkgp15DbPoEE2ZiO5NmumKBVDvqgF6w83f
	 uaJ9/JtryeWTw==
Date: Mon, 26 Feb 2024 16:45:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	stgraber@stgraber.org, cyphar@cyphar.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] tests/pid_namespace: add pid_max tests
Message-ID: <20240226-bewaffnen-kinokarten-94eb5abf727c@brauner>
References: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
 <20240222160915.315255-3-aleksandr.mikhalitsyn@canonical.com>
 <Zdd8MAJJD3M11yeR@tycho.pizza>
 <20240223-kantholz-knallen-558beba46c62@brauner>
 <ZdoEavHorDs3IlF5@tycho.pizza>
 <20240226-gestrafft-pastinaken-94ff0e993a51@brauner>
 <Zdyumw6OfWBqQMTj@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zdyumw6OfWBqQMTj@tycho.pizza>

On Mon, Feb 26, 2024 at 08:30:35AM -0700, Tycho Andersen wrote:
> On Mon, Feb 26, 2024 at 09:57:47AM +0100, Christian Brauner wrote:
> > > > > A small quibble, but I wonder about the semantics here. "You can write
> > > > > whatever you want to this file, but we'll ignore it sometimes" seems
> > > > > weird to me. What if someone (CRIU) wants to spawn a pid numbered 450
> > > > > in this case? I suppose they read pid_max first, they'll be able to
> > > > > tell it's impossible and can exit(1), but returning E2BIG from write()
> > > > > might be more useful.
> > > > 
> > > > That's a good idea. But it's a bit tricky. The straightforward thing is
> > > > to walk upwards through all ancestor pid namespaces and use the lowest
> > > > pid_max value as the upper bound for the current pid namespace. This
> > > > will guarantee that you get an error when you try to write a value that
> > > > you would't be able to create. The same logic should probably apply to
> > > > ns_last_pid as well.
> > > > 
> > > > However, that still leaves cases where the current pid namespace writes
> > > > a pid_max limit that is allowed (IOW, all ancestor pid namespaces are
> > > > above that limit.). But then immediately afterwards an ancestor pid
> > > > namespace lowers the pid_max limit. So you can always end up in a
> > > > scenario like this.
> > > 
> > > I wonder if we can push edits down too? Or an render .effective file, like
> > 
> > I don't think that works in the current design? The pid_max value is per
> > struct pid_namespace. And while there is a 1:1 relationship between a
> > child pid namespace to all of its ancestor pid namespaces there's a 1 to
> > many relationship between a pid namespace and it's child pid namespaces.
> > IOW, if you change pid_max in pidns_level_1 then you'd have to go
> > through each of the child pid namespaces on pidns_level_2 which could be
> > thousands. So you could only do this lazily. IOW, compare and possibly
> > update the pid_max value of the child pid namespace everytime it's read
> > or written. Maybe that .effective is the way to go; not sure right now.
> 
> I wonder then, does it make sense to implement this as a cgroup thing
> instead, which is used to doing this kind of traversal?
> 
> Or I suppose not, since the idea is to get legacy software that's
> writing to pid_max to work?

My personal perspective is that this is not so important. The original
motivation for this had been legacy workloads that expect to only get
pid numbers up to a certain size which would otherwise break. And for
them it doesn't matter whether that setting is applied through pid_max
or via some cgroup setting. All that matters is that they don't get pids
beyond what they expect.

So yes, from my POV we could try and make this a cgroup property. But
we should check with Tejun first whether he'd consider this a useful
addition or not.

