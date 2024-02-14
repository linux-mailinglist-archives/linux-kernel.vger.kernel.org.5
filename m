Return-Path: <linux-kernel+bounces-65786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB698551D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7596028686C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4544212C552;
	Wed, 14 Feb 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="TBNyiB7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YFwk5T69"
Received: from wflow2-smtp.messagingengine.com (wflow2-smtp.messagingengine.com [64.147.123.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FCD84A3E;
	Wed, 14 Feb 2024 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934326; cv=none; b=QprWrXk8zyyGmE1E48lMijQiEbqys/qk++IQeXimUHiyWyLU7+JnanGps7T2GbYEAFaX7W70veZr3ifzIhVy9m2k2qRERUuM3u4dIg6eJuWbmtRXzbisLSOTG8mIEPM57IhciK3/ouMymvb8FWOrdXdj0ZKndQGl3plwMomwd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934326; c=relaxed/simple;
	bh=xaNjbfsXALYJf7A9rUTlboAITdFj7hL2rnQGSgbm4FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzs9d1Djf9n7jDvqOgpgpCHFq368FfpcHIr9tc6mQrcmSV9eWHgQz6OGL3oNYg5g8pr1PzHwSS0pP1NWAT4F6YVZgci5j+kr0rdsgfb5yQY9LtjUpn7xygf26aMmLmaj9EnKF/8MR9Nvc877mzAVt4/g8dKEZz2CI7GAnqhJpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=TBNyiB7A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YFwk5T69; arc=none smtp.client-ip=64.147.123.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id C50602CC02C2;
	Wed, 14 Feb 2024 13:12:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 14 Feb 2024 13:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707934321; x=1707941521; bh=YyjszkVulV
	wS9ApAAhU5F14N1kZwgfnmL4dXYcuxs4Y=; b=TBNyiB7AxVjfWKAklylOYdaEtS
	LDX7hv+vsIFNJkciDeKmC4ZxZ66lQiy0d6ubGBo3UclIjS/EXbgGet9cdmvj2/ZK
	JlDe+CaYXY0NfFbl0114ZR79HFmyyjRAn3MbzxI85GV8qUTyGc9A1qroNcrKib1Z
	NEPZO54lFU7FELTmNiKngFYEOnrUnULjeCK/15B7j3VkCKtlE56PVFIbLIWL5CYR
	U4kSpwnL8Ss+4PBd4qAztJf+J15+TzHRV2UMyxI2sU7EagE86i3kgalIM261OVRh
	9ywIH0BP/3YvTJU/ESdl3ArhZ4GoDdX+UbAlQDfF7aWxT7dh+RMa7+zPEDnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707934321; x=1707941521; bh=YyjszkVulVwS9ApAAhU5F14N1kZw
	gfnmL4dXYcuxs4Y=; b=YFwk5T69aHohbXMadg1f6TH9B2bxoFucQ+2mufrZF/7Q
	amCR8gzOfkHLj4AZMwYSBzIXbsdwq1yyZLB+KRrK/gReB0fau04w7VXbF+oP47MD
	jAnKJdHhs4Rx/cU5TyOcteljI3iSgm/EeLifVh8m9so+DBXalTaRqI7Spad19Qkt
	qJO6LYEaZOfv9Tg9ax7JkoxnENBHBP79v/1t7iexWq20u370ZcF2dF9D0+wZDF5x
	bkBy+m4dNveY7VGQ1yQxomv9AU06DhumYAGiHK6Fbmyk0WQlY39uNWt16BoFdCQe
	VCCfIjrQZV5iToSQ3e7TTf5rSntTmT5XcdBk441H4w==
X-ME-Sender: <xms:cALNZUfx16W7IjtETrHdLMm9SenOXZulc3V3WwJz6BV78HY-CCRC0A>
    <xme:cALNZWOhIecGHB4B5NQ2ZBHrq5TksBlmKtibRNs972oxvGZrtQaRaZ6zS9-ivbL7X
    WKbvivKFCaU1KMN80g>
X-ME-Received: <xmr:cALNZVgB9ThiugBlx2eizIoR2kzEEinE3NsiOw5AzIk5t4WtDDgbqoAHdOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:cALNZZ8OijF3iXe7rHiP4uRqCEpNNecqhYVuEmwWeim6H68gYhYGLA>
    <xmx:cALNZQvYwrmTLFlYHX4VFE_WjiYJ7GDzgnUZZOmjd0LnA394iFViMA>
    <xmx:cALNZQF7GlsSfLnKkGChc8jcIMeuwKCN2a-BFEh5dxqt6cYWSPbMRg>
    <xmx:cQLNZRPey3rcDYDaj_wTvqESmQhTvj2CXdVt-_pn9pZACw8_0NcNFQSS2a8bKQ73>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 13:11:57 -0500 (EST)
Date: Wed, 14 Feb 2024 11:11:55 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: coverity-bot <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: __do_sys_pidfd_send_signal(): UNINIT
Message-ID: <Zc0Ca5te+QFBZ1U6@tycho.pizza>
References: <202402131559.B76A34B@keescook>
 <ZcwGua3a9Z8nJXVq@tycho.pizza>
 <20240214090332.GA14017@redhat.com>
 <20240214090640.GB14017@redhat.com>
 <ZczLyDCN+zG6imTd@tycho.pizza>
 <20240214175555.GC16265@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214175555.GC16265@redhat.com>

On Wed, Feb 14, 2024 at 06:55:55PM +0100, Oleg Nesterov wrote:
> Hi Tycho,
> 
> let me repeat just in case, I am fine either way, whatever you and
> Christian prefer. In particular, I agree in advance if you decide
> to not change the current code, it is correct even if it can fool
> the tools.
> 
> That said,
> 
> On 02/14, Tycho Andersen wrote:
> >
> > On Wed, Feb 14, 2024 at 10:06:41AM +0100, Oleg Nesterov wrote:
> > >
> > > -	/* Ensure that only a single signal scope determining flag is set. */
> > > -	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
> > > +	switch (flags) {
> > > +	case 0:
> > > +		/* but see the PIDFD_THREAD check below */
> >
> > Why not put that bit inline?
> 
> Not sure I understand what does "inline" mean... but let me reply
> anyway.
> 
> We want to check the "flags" argument at the start, we do not want to
> delay the "case 0:" check until we have f.file (so that we can check
> f.file->f_flags).

Fair point. I was thinking delaying it would make it simpler, but then
you have to free the file and it's less fast in the EINVAL case. I
also don't have a strong opinion here.

Tycho

