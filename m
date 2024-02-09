Return-Path: <linux-kernel+bounces-59861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2689084FCA5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8412830E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228298287F;
	Fri,  9 Feb 2024 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="w+ucZjAL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V6VQs3pY"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1702E3F7;
	Fri,  9 Feb 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505741; cv=none; b=HxX8c0RSK+riKQclbt8qYASElnYAR+GRL1yeI1d/QCl0SgHDaUqDtotG7bOszJGD10DgLV4K9mErNZb3fRmV3RfwowYDuu5Q+hPgHsysK6z50bBZabNBh68G2bbPRiBQEUHcHHw7YtNFITzLk+4LPqRiPbB5ZrT/29HJ16K4KIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505741; c=relaxed/simple;
	bh=+Az18EmozWnGENlBFvdl2uyGh3hA8/mru7NNCHcuS7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiiuFsFh42zLhUm8aewgobpv8Qs3aCwvzW0tjApo1c40fbcxTQ/nUVSV58WBBMU/uERGhG7scGhtIpk8na2+o2lVpOllguO+shiyq5CbWt+Hf7ru8K2TvbLv/r1JYa71tZAhULjCGGvG3TkjLcHooOIZq4UbAA9fq5XcfV1o6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=w+ucZjAL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V6VQs3pY; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B3B9D1140085;
	Fri,  9 Feb 2024 14:08:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Feb 2024 14:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707505737; x=1707592137; bh=SAe6fmg2iu
	kgmMmSnSkobKVPLF6RTasrBQRLnrKYkHY=; b=w+ucZjAL8FE7GIe1p0B8EkVpU1
	4SdP99jEVmNljXi4FCxlWrmD1p5kbEIiLMQ4/vKN3hYg5t49CmC/EerE4T4Vw4gm
	iishwdjp9Vg6JMm4NgCnkh5EFV7hQcQTvWPecri3Xp25jIDe2gD4/2bk3D/IM0hw
	ysDWKiHgi6ybo5WqvPCBUypBCJx1LtRFuEt+C+pvBtBd7S/tfkZ4rRQCFSyIWWTS
	GuvCJx+NW25EDfDBTRK1fYEnEuuJ86FDZYToBWeq3HKQoFZnCzxn2M2Lc1wGVfdk
	ozD0mIQNzG8HXkrIy5qKuS6sg+3FORHwsRg/ZwGtLqx0BB9pIvukjlY6NPeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707505737; x=1707592137; bh=SAe6fmg2iukgmMmSnSkobKVPLF6R
	TasrBQRLnrKYkHY=; b=V6VQs3pYr5cojBStLX+VeoMBgTE/9rLlTrQc9WQLSZnc
	37UKHkca/lIdAst33VWfPlVkVpxJJugkEHJ+LM5l/PyajfzFHaQN79j36QAk44BI
	p7TIKLNk+y/YjlCxCZhA/fjHSPWfacQMr2sygo3+5FWnl70K7Oe9WnFnY7G6E9c5
	q7Q6QetzdjKsbjPNc4SU2W8DoZj1jCgeuSAym2mVUxl/7YHVs+weBaTDBDTmaN6e
	NKaX+HhKIy8S3CT9qXqL1ekuszyFjhqDzSE/xjVAQ1zAJX3R6c4AwC4q9RdF/yje
	bzMZPYjf4ViM9G+Jyn8sRocn1uf/b1lAw70h1MVESA==
X-ME-Sender: <xms:SXjGZaZCdBOwZzuUkjF3XqpnoFqqK0GHeQ7RuBpOKb1692JGLsjM5Q>
    <xme:SXjGZdagX2mitSwCDJ3hEBMFlrM5xdKXMgnBljjIt5-fOe8Y6YZUdOI__zMcjRdmV
    YT-vpHsqMlPmMYEVi0>
X-ME-Received: <xmr:SXjGZU8X4JjyVvRd1DpwxtJvmHL-f-Nn5RrMF_OKAHIMkcOSYCVdM6gh4hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:SXjGZcpSErAKQZW5jmNLTmZPB6PaV4AwvnMhLdflfcfnFaDj4CPQMA>
    <xmx:SXjGZVqAqiiVH41rgQDlqJWKUwdAonEFWPWEu_fWSTYkPTIu_224oA>
    <xmx:SXjGZaQeyF9JVBFAV5DZ47crlYiOoX5zcXrIfweH2ZLXSf3QK0g-Zw>
    <xmx:SXjGZWedr_cUI5nKQBGgR3AmgkdwWWKxX5hJ8W39eRZd_BbqFqay7A>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 14:08:56 -0500 (EST)
Date: Fri, 9 Feb 2024 12:08:54 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <ZcZ4RuaiAINGH/rD@tycho.pizza>
References: <20240209130620.GA8039@redhat.com>
 <20240209130650.GA8048@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209130650.GA8048@redhat.com>

On Fri, Feb 09, 2024 at 02:06:50PM +0100, Oleg Nesterov wrote:
> Turn kill_pid_info() into kill_pid_info_type(), this allows to pass any
> pid_type to group_send_sig_info(), despite its name it should work fine
> even if type = PIDTYPE_PID.
> 
> Change pidfd_send_signal() to use PIDTYPE_PID or PIDTYPE_TGID depending
> on PIDFD_THREAD.
> 
> While at it kill another TODO comment in pidfd_show_fdinfo(). As Christian
> expains fdinfo reports f_flags, userspace can already detect PIDFD_THREAD.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Tycho Andersen <tandersen@netflix.com>

