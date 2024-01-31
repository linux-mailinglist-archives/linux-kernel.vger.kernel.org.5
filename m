Return-Path: <linux-kernel+bounces-46902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1420684460B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E57294163
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8008912CDBF;
	Wed, 31 Jan 2024 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="FdgYdwWY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vwNnU0A9"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4412C52E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721841; cv=none; b=IgBJEV+tnU+uMZC7Pe+0EqEIDYGHK9wtERHwvdR2WD55XFSOnBtwhQY2UjKmmL+4t/aWEUjKc7qwWSCGbS0XyjeVbc4Dw0iG6CdaFCOGp+o5Bm5zeu3CC6kumw2B2YPHT6rKr0vSCCWDSK0C9niBz0amqf47LpP+Yw0rihJUvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721841; c=relaxed/simple;
	bh=j+Bbez0gzj6+f+YJhhb/ozw9CFQoNu8iD9ScjEsL1JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMXJCKJL5L+OIdUMjdYdJvzg52pZ5z8gc+RR0kzGSzR0UMw4trL5P1vPUqGPyST+qKkocR6NQwd3FcptlXQT3GosnaB3InisoW8I+WjochzsFkLdOTXdCC7wyxfSLurVtXuUdRg5+QC2ijNUUoMJn2l3omS1UySewh6TTBYBC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=FdgYdwWY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vwNnU0A9; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id D88AF3200564;
	Wed, 31 Jan 2024 12:23:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 31 Jan 2024 12:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706721837; x=1706808237; bh=zMKGJxHDLh
	y9XiJ/65aFtBKWBCwquZ0HqRnigxHPmzQ=; b=FdgYdwWYm8m9HkTbaWdKBsylST
	z0y5qnTQ+EfzjRWQEca94JPF5VLWGMyb1y4BbSd7kdL+XQ4wHWATPRJiLH+RMnb5
	16BlZ2r9RH9A8+opNvMb4U4/Leiwjyq/fj7iA//cpRVEyh9ZmsMTVIwyfpvGwlqK
	Gf0wJjMO5fLVJunY+6tCx6gIsQqZ2BI/EK7fblJEpKi3MDKL0zx8Vk9irlYfVpxE
	zrmj1Rj6HCIf3ky9aL3IdWf7Ow1tmEdAmx7y6pBhsNrFSQHvHiS2oM8z8n+M6X1p
	l1oNPberumR5Fi7pCtoji5DJ0BFv3Zl/9OlViemJg9BHgN3q9IXHJdSqUslQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706721837; x=1706808237; bh=zMKGJxHDLhy9XiJ/65aFtBKWBCwq
	uZ0HqRnigxHPmzQ=; b=vwNnU0A9C9Yai7toKg6f1Q0bMNdpPKCQ3uYzbup8sB/0
	pvFltR2plitNjjOOQwDX7iNsgtpT8BYJaCc8WrQ1byVvB6y0/+Aa+4vy9OpqDrhy
	pmtcDg8dzzDpgBik7htIkJ/xygD2T8J3mjaXQhQj3mYZNk6FH7xmIR5Qp3wPHxL6
	HlhsOCgJH7kTFASSWkEbkgs+aVSxQhiY56qmcUT74a5zZTtj2b2H4AL+JjlkHWRy
	6E6fKu9nUDeXSiItbWuEoDIyWV0vM4coix058jVTaYxCeLlMbXlNwdeiXp/7vmBO
	dJfBvjg5EbwnqZ0BCeEDKm/GimryNFsPkstjxFX2Ng==
X-ME-Sender: <xms:LYK6ZaBBMkmwlwPNxdsG6xdlaRJdltfxShKPIvhepwVmHH4DpEJixg>
    <xme:LYK6ZUjN0djRJ_xEzOpKSKzH_j88DZJAmV7EMMcPHo0GJkcVEFnEnVsSWM9guu-mF
    Og446a5WflITA8TYPQ>
X-ME-Received: <xmr:LYK6Zdlvg3XKdLq07cHBcOu6AiJ1Uk0z9LCjKNY4GOv9ig5EnAUXi18ztNE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:LYK6ZYwBY64OcbLVDUjObWlBBqXVzekfd1Snc1OZPQBac_Ey3RXjRA>
    <xmx:LYK6ZfQ030T4RhIJ2Ki1rDnEPSxJh7USfIM0zagZsZVBvdQtxc29bw>
    <xmx:LYK6ZTZgc8YXJRoRuZp6v2sjZ8pRPssG6CsdIUQvtunzgpDHB8edBg>
    <xmx:LYK6ZZdWF5Uz_YnojNVodBaD1Cv0EZkAKLCGUmJLPcuvqmaenhxKxQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 12:23:56 -0500 (EST)
Date: Wed, 31 Jan 2024 10:23:54 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <ZbqCKgTuP/IaEbMM@tycho.pizza>
References: <20240131132541.GA23632@redhat.com>
 <20240131132602.GA23641@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131132602.GA23641@redhat.com>

Hi Oleg,

On Wed, Jan 31, 2024 at 02:26:02PM +0100, Oleg Nesterov wrote:
> With this flag:
> 
> 	- pidfd_open() doesn't require that the target task must be
> 	  a thread-group leader
> 
> 	- pidfd_poll() succeeds when the task exits and becomes a
> 	  zombie (iow, passes exit_notify()), even if it is a leader
> 	  and thread-group is not empty.
> 
> 	  This means that the behaviour of pidfd_poll(PIDFD_THREAD,
> 	  pid-of-group-leader) is not well defined if it races with
> 	  exec() from its sub-thread; pidfd_poll() can succeed or not
> 	  depending on whether pidfd_task_exited() is called before
> 	  or after exchange_tids().
> 
> 	  Perhaps we can improve this behaviour later, pidfd_poll()
> 	  can probably take sig->group_exec_task into account. But
> 	  this doesn't really differ from the case when the leader
> 	  exits before other threads (so pidfd_poll() succeeds) and
> 	  then another thread execs and pidfd_poll() will block again.

I don't have a strong opinion here; leaving it "undefined" for now is
fine with me.

> @@ -2173,7 +2195,9 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
>   */
>  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
>  {
> -	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> +	bool thread = flags & PIDFD_THREAD;
> +
> +	if (!pid || !pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID));

Small typo here, trailing ;. When I fix that, tests pass for me.

Assuming that's fixed up:

Reviewed-by: Tycho Andersen <tandersen@netflix.com>
Tested-by: Tycho Andersen <tandersen@netflix.com>

Thanks for your help!

Tycho

