Return-Path: <linux-kernel+bounces-65328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50740854B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9FAEB22481
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381345730B;
	Wed, 14 Feb 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="jeMUyY42";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="In9lxJI2"
Received: from wflow8-smtp.messagingengine.com (wflow8-smtp.messagingengine.com [64.147.123.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE7B29437;
	Wed, 14 Feb 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920338; cv=none; b=EJGlMsb/fSP6Txs8NAMb5rkSHUdCFplrU46vaFKjAQgzR8FJ36TpvXSl46FRaEk3Fmgr91yKkPVrUzTJOILSUfEmT85YaH+tiYOf8bMjafjIMxy0TxU6KnRMqesFXx1wNJMCcz86hvfF+rhvjbqcBYaxvNYcM1fpKsPehjr8sbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920338; c=relaxed/simple;
	bh=nTl1e8UEmACUyenLLW2iCRqE5C4RtIPrVYx7Rhm8IDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEtCKKf6DcQvut6YNr6RnKbKnIJbc/WZP/hZ7f4kMdF+uLyUuIsnbsbq6vQq+a514QEZu9RF6uOPtdUFihatddk62+I17mkQ2TSbiEjn2d+ie325TpaHojexm5cVsckBI08Qo6dlZqfH2Vco27oAnBYtn8QOT8l+D7aRcUhZOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=jeMUyY42; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=In9lxJI2; arc=none smtp.client-ip=64.147.123.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.west.internal (Postfix) with ESMTP id 03A492CC02D0;
	Wed, 14 Feb 2024 09:18:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 09:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707920332; x=1707927532; bh=6RsiVidSCw
	BrjsulM6iUvKUYTy+Y7E6NKV1i3zA5qpU=; b=jeMUyY42CXSJw46CT9NQVglyCM
	E7RLRhEzcLYi1I8QeUo183E55xwmzqBHWAv4NLTpkqHNnt65+FgnK83oq4qcxz6k
	q9tCfccKFZgtS5/NeIVLN6QvdeUUo5/r0ZdTWn7KZDtKJpHlq/vo+N/ObHUeLd8P
	8WgWL3cwf64GiEdFu7CF/ZCKAf6vELZb8F2CbItzzqIRsO1/IylxcMnb3aI7xy/U
	2aoWiUu++SvPfgrwlWr23pu8ZFEhUkmYBtS93SGtb066xY9VYgr1HqvZEPXnT7vZ
	N0+s2Ykx0GdRHBfceSPdQ+2LIVyEwcbe/qOjhjOJy85ic4Sh2gvFo6yyO2Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707920332; x=1707927532; bh=6RsiVidSCwBrjsulM6iUvKUYTy+Y
	7E6NKV1i3zA5qpU=; b=In9lxJI2/qikc/OHPx4USykX8W8PIUIKmbagu2mBdOhB
	4bwb/STZdV1WcVFEaHvE8eXeK1uebqXZPyMGrvJeNAtpT592uy6MXOtqk4gEWBVL
	VdIdDBt0epBzO/tVVljh81LxSYUx8w8VWBFx1eqPyaarXJhGRZt9YL+qMP16VIu5
	YjN/q8aPybrdpW8ZJ3KERsmf1jjH3Pq+Z7vKaorOr9uDI5r94YqamyEQBpOTCMAP
	VntQkstFmpps4gOR/5CnvUV3bss09HnuNFilvIEgId4CTeDN65gowCVrNm+65KUI
	Iu5nwSVHeudYda0tjSht/962gXyfcTdrufrsfurCww==
X-ME-Sender: <xms:y8vMZYrEu3ZKpzC-ur-lUClxdnSXcACjD27_Oi1Qv8UuggyMOM2uNQ>
    <xme:y8vMZerGtGPjK4YqJTlMNUA0OmYNsTDOl-dIcQ5bBVHKhm4nkFOU77JXHcPAy6KTr
    PSaW4YYeRJRbKVmuXY>
X-ME-Received: <xmr:y8vMZdNFxyFZUJVEXRyDcP5mMXZBuqQ17FNSXetFbVa94R9P8PTbbfTkLDnkP5F7QiYZABHo13otPbRvwo2RfeSwOtrO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:y8vMZf64-wd7mz4pF2zxJRbMXrrp25fV54ch5xt5FEsg63gNDa-uxg>
    <xmx:y8vMZX68zZhXPUHy5CeWIXe5a2jsJHZH7e5eaZPC_yDQqlbERPQuRg>
    <xmx:y8vMZfgRAXCu25PXsPQr41w9J6C7WjwHBQgBFUdnYrbfNwoxvVkZUA>
    <xmx:zMvMZV7ibGkEuF3toxvX4kD4YGPjYOBvZ4dLdyJ-EK3yZvJICdZlywQBlax07Xqq>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 09:18:50 -0500 (EST)
Date: Wed, 14 Feb 2024 07:18:48 -0700
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
Message-ID: <ZczLyDCN+zG6imTd@tycho.pizza>
References: <202402131559.B76A34B@keescook>
 <ZcwGua3a9Z8nJXVq@tycho.pizza>
 <20240214090332.GA14017@redhat.com>
 <20240214090640.GB14017@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214090640.GB14017@redhat.com>

On Wed, Feb 14, 2024 at 10:06:41AM +0100, Oleg Nesterov wrote:
> On 02/14, Oleg Nesterov wrote:
> >
> > On 02/13, Tycho Andersen wrote:
> > >
> > > I think this is a false positive, we have:
> >
> > Agreed,
> >
> > > That said, a default case wouldn't hurt, and we should fix the first
> > > comment anyways, since now we have extensions.
> > >
> > > I'm happy to send a patch or maybe it's better for Christian to fix it
> > > in-tree.
> >
> > I leave this to you and Christian, whatever you prefer. But perhaps we
> > can simplify these checks? Something like below.
> 
> forgot about -EINVAL ...
> 
> Oleg.
> 
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3876,10 +3876,6 @@ static struct pid *pidfd_to_pid(const struct file *file)
>  	return tgid_pidfd_to_pid(file);
>  }
>  
> -#define PIDFD_SEND_SIGNAL_FLAGS                            \
> -	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
> -	 PIDFD_SIGNAL_PROCESS_GROUP)
> -
>  /**
>   * sys_pidfd_send_signal - Signal a process through a pidfd
>   * @pidfd:  file descriptor of the process
> @@ -3903,13 +3899,23 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  	kernel_siginfo_t kinfo;
>  	enum pid_type type;
>  
> -	/* Enforce flags be set to 0 until we add an extension. */
> -	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
> -		return -EINVAL;
> -
> -	/* Ensure that only a single signal scope determining flag is set. */
> -	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
> +	switch (flags) {
> +	case 0:
> +		/* but see the PIDFD_THREAD check below */

Why not put that bit inline? But I guess the hweight and flags mask
are intended to be future proofness for flags that don't fit into this
switch. That said, your patch reads better than the way it is in the
tree and is what I was thinking.

Tycho

