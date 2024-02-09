Return-Path: <linux-kernel+bounces-59914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAAB84FD4A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5308B2880B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93775126F0C;
	Fri,  9 Feb 2024 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="DAbw1HfX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yf1Pu1dw"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B47FBBC;
	Fri,  9 Feb 2024 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508902; cv=none; b=Z4ldSfn2RcyEcZzb0XbVRSQFmTn63j1NWO9Y+VwYJ4WA6CzGml5UHiW7zRfv4GYga5QY0UEfBKKZu/l+SY+7PHG3q7c1cqRv+ukOwhzlzVH8a1egZ759YVME/vn9QNoU+9hPh9XrYuHh/uY1/uMsd2PHmviKH3AahH+2WDxX/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508902; c=relaxed/simple;
	bh=WL/rzBB2GfU053FLLg28Xuod+XynvPbNisV0axNODVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBcI/pVnZJPVD9pOIFfh/7iLhc7snywxai7jof2Kwbf8NBGLgjJa0bJH1L0uMzPmx7Hq//MkVkjBKfk6ucnFmVzfZ9MR8WwpZO0k1+Vs3dJIFOjL6SeAwYNUEilF5utZBYm/M75jjUmU/obyvS6MO3U9nTBsbO8BNYk2CfezBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=DAbw1HfX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yf1Pu1dw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id B16FC13800A0;
	Fri,  9 Feb 2024 15:01:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 09 Feb 2024 15:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707508899; x=1707595299; bh=7HHSZSBrGn
	vXlR9ji0eRnBBMyU/kYyPlTorpNyRe0mk=; b=DAbw1HfXp/TaIjcGplAzidZYB6
	EiPtcvqgmuMJQrWJ7TOja4UNfLfrTPKV+zVNNVsaxEjcYxdWajt/NXlpHOUZ4TnQ
	p+u3CSb2urhqHRSi56ak2k4EQrPHkYrZoJIepyS5zRE1G/7YjhGXqpTdBuBZ3V2X
	FkqUeJQbc8tM1s2zyNDHPW0q4MoatML6zl40bOhGiFJAaMOV9sJH5lofuJKzm+sD
	D4XcyLBPzPf3GlsjWsRIV4HqSI1gbfqrHrQ3FWS56oeyPNdw4M7XAQysUP0dUmju
	L+3eQ55sdBArJKRwUGzgwkVaxgkYlfyDhFsQqy5lS/A0xCPtmszMe82wCsdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707508899; x=1707595299; bh=7HHSZSBrGnvXlR9ji0eRnBBMyU/k
	YyPlTorpNyRe0mk=; b=yf1Pu1dwEuy0SvpGiWStbqu7cGKH7y4QXdN8juMeDivS
	tSI0aKfAYEEdNEWDWT9sJl7pRxZnd5IfekY19SVg39IwEYhAm6oo9hG41W07p5qx
	cI5J0/qvJJTlHDmQQvk9pKFebKwNphxORxVbj11R/FVWpiXbhltzelp/GwLbAHAT
	6EaIRqfxYWiZBMEKrWz4eC6GZTTpsyH5z8lBD0SbhvFf5UlqydWfoqufLeFyXFMg
	5KSsoL+9zTBmPXqBNZeKaOEGatr6HRUe7/1WgUidCzoGHpDofcQwI71zQ/lQAPoj
	3WOK8NHA8SyuZXZflQZCnaQIolfWAOqY15PoF3zcqg==
X-ME-Sender: <xms:o4TGZW7_VdgqDcE3EVXb09Hd06YJmnvt80b9paehOhoN1D367VL-xg>
    <xme:o4TGZf6xeIVtBcfrrY4P5rBcsYGhU4kJUG6EHDwhQnrxoOArZudQCt8NthyRJ9b92
    YSo9bAmEv_IUCQOYJs>
X-ME-Received: <xmr:o4TGZVdV1pV_BM9RiPb0TWsQTR_eW9MwclhnOAD4Ksq395rqMUnyl3f8RbY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepleevudetgefhheekueekhfduffethfehteeftdfhvefgteelvedvudev
    teeufeehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:o4TGZTLsBcDlKAzqPMg_EdAaJ1m3LADMbb6_9ziQixEojnRkaWEzCQ>
    <xmx:o4TGZaJBFmu-XKDjpadqSJqUevwauBs9qW-hf8FI7CIT4VJLhfDq3Q>
    <xmx:o4TGZUwasBW7t0r3zHVRQ9ngv0o8JbQxOjimaLkTQnhcA511y1xcUA>
    <xmx:o4TGZS8cGkNEFpmbIXCJV79nPv8-2iygFyXWNuTM4xYge8DnU-ROdg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 15:01:38 -0500 (EST)
Date: Fri, 9 Feb 2024 13:01:36 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andy Lutomirski <luto@amacapital.net>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] signal: add the "int si_code" arg to
 prepare_kill_siginfo()
Message-ID: <ZcaEoKAQGgKOYyi+@tycho.pizza>
References: <20240209130620.GA8039@redhat.com>
 <87sf21zjy8.fsf@email.froward.int.ebiederm.org>
 <20240209163914.GE3282@redhat.com>
 <20240209-traben-geothermie-8c6aa7e1984f@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-traben-geothermie-8c6aa7e1984f@brauner>

On Fri, Feb 09, 2024 at 08:36:24PM +0100, Christian Brauner wrote:
> On Fri, Feb 09, 2024 at 05:39:14PM +0100, Oleg Nesterov wrote:
> > On 02/09, Eric W. Biederman wrote:
> > >
> > > Could you can pass in the destination type instead of the si_code?
> > > Something like I have shown below?
> > 
> > ...
> > 
> > > 	info->si_code = (type == PIDTYPE_PID) ? SI_TKILL : SI_USER;
> > 
> > Yes, I considered this option too.
> > 
> > OK, will send V3 tomorrow.
> 
> Hm, I don't think that's necessary if you're happy to have me just fix
> that up in tree. Here's the two patches updated. It was straightforward
> but I have a baby on my lap so double check, please:
> 
> From 05ffda39f6f5c887cae319274366cbf856c88fe5 Mon Sep 17 00:00:00 2001
> From: Oleg Nesterov <oleg@redhat.com>
> Date: Fri, 9 Feb 2024 14:06:20 +0100
> Subject: [PATCH 1/2] signal: fill in si_code in prepare_kill_siginfo()
> 
> So that do_tkill() can use this helper too. This also simplifies
> the next patch.
> 
> TODO: perhaps we can kill prepare_kill_siginfo() and change the
> callers to use SEND_SIG_NOINFO,  but this needs some changes in
> __send_signal_locked() and TP_STORE_SIGINFO().
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Link: https://lore.kernel.org/r/20240209130620.GA8039@redhat.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good to me as well,

Reviewed-by: Tycho Andersen <tandersen@netflix.com>

