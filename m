Return-Path: <linux-kernel+bounces-14690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE4E8220B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A641C22716
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AE0156D8;
	Tue,  2 Jan 2024 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="aKm3suUK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC17156C0;
	Tue,  2 Jan 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=w/zX07yk+Jq1OGq/27+WNumLIhMXOzoQ92krOFylHrA=; b=aKm3suUKzIF2AsCeFtldwpeEfQ
	EygPfJCAM4XGFqWklmD+GlN6XjOQb1hpZR1kBF632i44RxvJU0a5jWsLxFlYpro0xiErosY4/UFf0
	ZOnghmwEyTlUn4FNBJrFApTz9Y3oXOqcaEBDTY8JQySlX4Qpp3UK7VnwWvUdukxlKATsKJ7WVQuoe
	T0lvWNOjQWHNQpURsePWlgw2KLoZ81EynCJH4Gj8tlGXd41AKf7zvFawmddYBlGoPvNckSd7XvMv0
	xx3vQ26VoXq23hcaHt2Nkko5G9GhVpWfzNmKgD/WpvrDh8r9+8CWhgoy1oI0W7j7zy6V5CGpaMPir
	Q6+aqABA==;
Received: from lfbn-idf3-1-20-89.w81-249.abo.wanadoo.fr ([81.249.147.89]:38406 helo=merlin.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rKj6w-0004Kj-PJ by authid <merlins.org> with srv_auth_plain; Tue, 02 Jan 2024 10:03:30 -0800
Received: from merlin by merlin.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1rKj6v-0004Q9-2A;
	Tue, 02 Jan 2024 10:03:29 -0800
Date: Tue, 2 Jan 2024 10:03:29 -0800
From: Marc MERLIN <marc@merlins.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: sof-audio-pci-intel-tgl/soundwire 6.6.8 kernel outputs no sound
 on speakers but works on headphones => missing alsa-ucm-conf
Message-ID: <ZZRP8RqT83cE-S5m@merlins.org>
References: <20231223234430.GA11359@merlins.org>
 <alpine.DEB.2.22.394.2401021117370.14041@eliteleevi.tm.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2401021117370.14041@eliteleevi.tm.intel.com>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 81.249.147.89
X-SA-Exim-Mail-From: marc@merlins.org

On Tue, Jan 02, 2024 at 02:23:49AM -0800, Marc MERLIN wrote:
> > Please file a bug at 
> > https://github.com/thesofproject/linux/issues
>  
> THanks, done: https://github.com/thesofproject/linux/issues/4758

First, a big thanks for the quick reply and help.
For the benefit of archives and the next potential person looking for
this, my debian system was lacking 
alsa-ucm-conf
which for this soundcare is not optional at all. 

Long gone are the days of simple soundcards that just worked (never mind
self made DAC with resistors in the parrallel port :) ), nowadays sound
cards need a lot of things for anything to work. I had read about some
puzzling defaults of having an amp for speakers, controlled in software,
and off by default :-/  but didn't know that mine was so new/complex
that it would not show up in alsamixer where you would normally unmute
an output and be in your way. Now I've read about alsaucm and maybe
there was a magic combination that would have worked with alsamixer
but too many variables to try, hence aslaucm. 

I spent probably over 10 hours on this building kernels, and comparing
debian to ubuntu, and doing a ridiculous amount of diffs between the
setups, I was unable to see anything about the output being muted, but I
Guess it wasn't being muted, the amp needing to be turned on is yet
another thing and it didn't how up where I looked.

So, a few thoughts:
1) for sure, debian package alsa-ucm-conf should be required, not
recommended. It's not big, people who can't keep track of everything
that changes all the time, have no idea that they need it, and really
need it installed by default if their hardware requires it.
I've filed a couple of bugs with them, including on the package
description that gives little clue that the package can be so essential

Description-en: ALSA Use Case Manager configuration files
 This package contains ALSA Use Case Manager configuration of audio
 input/output names and routing for specific audio hardware. They can be
 used with the alsaucm tool.

2) I spent many hours reading the internet on all issues with sound and
muting and why sound could work on headphones and not speakers, and
nothing gave me a hint that worked, or even mentioned alsaucm.
When I have some time, I'll write a page that I'll try to get
indexed so that the next person dealing with this has a better chance
to find the answer

3) I failed to find the linux-sound list, that's on me, and my mail to
alsa-devel was bouncing for unknown reasons.

A huge huge thanks to you, Kai, for finding this Email and your help.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

