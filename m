Return-Path: <linux-kernel+bounces-163115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4144F8B65EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A082827D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8407B38DF2;
	Mon, 29 Apr 2024 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3WD8QOG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99382E3E5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431254; cv=none; b=uEiqWPMWYvehoZZHpd4WKDtI6i+D9qk+V2uyORUVPBd6+O3tSzAqFDTXjuQTZcl0JelxVL1Tzv/CdkQgu6Y0UTD4AmDNYQZcwD5CgDN9UCsf5OJW0guOkwrq2m3J6Ar+CPHNtPFwTW7DVqqB4JSPSGXfM0xFRuERZS6WhZ/C4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431254; c=relaxed/simple;
	bh=UINAM3jfrtDSz6xncnBT2xl1julRSpzBGzj/C06DS5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp7krXn3F+pWT4ROkCMxw+CFKfFuzsNmIy7xqvlO9vzgZXl/S1+V8I/C2XItxe5ZX+MMwRBHAhEG7xrZHc7U31vz0FVVPWCZRrOimO+V71qQDheX+TKYD7Qfs8P966d/x4RqvGx3BJL8n8KYJ50k9ZvQSK6OECoCT3f6R5c+AiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3WD8QOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DACC113CD;
	Mon, 29 Apr 2024 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714431254;
	bh=UINAM3jfrtDSz6xncnBT2xl1julRSpzBGzj/C06DS5M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=s3WD8QOGW7N3J0WsE3hFkq8hIiSlAnZB/ZgrIhyAlC2wDSgaBktIaKrqHpWURdf7a
	 tCEIpBR8Ii/isvjeYm9gQdUmqDNVfgyTECyTvUpu6E8zgzCLVacausMH719VLhaX3q
	 Kg6kWJhdKmuE6/LM2dekBNwpXaSMjsS70uIKYIWmy5PjQOP2kHOgFEI4iIB/8c+sGz
	 cIXI2HQ9PtxyZHf9MGargYh12tpz2yu0auATqSvxB10yWJBC9LC2n659wOrNrOv1un
	 DVufirrHZyCQms1/e5zAL1Er71pXdh4f3dsFFnmdRCBgvnNGsspu4s3pR7eZ3zKviL
	 5TpKLg8j1H7/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F177ECE0B6B; Mon, 29 Apr 2024 15:54:13 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:54:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] clocksource: Make the int help prompt unit readable in
 ncurses
Message-ID: <8ff9a27c-e060-48c5-aad8-96026d77d765@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240428102143.26764-1-bp@kernel.org>
 <ecde0c52-3a91-4762-b0c3-6455d3cedecd@paulmck-laptop>
 <20240429222902.GLZjAfLjanzLuH3iOl@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429222902.GLZjAfLjanzLuH3iOl@fat_crate.local>

On Tue, Apr 30, 2024 at 12:29:02AM +0200, Borislav Petkov wrote:
> On Mon, Apr 29, 2024 at 09:04:30AM -0700, Paul E. McKenney wrote:
> > So all the world is not yet a UTF-8?  ;-)
> 
> ... and it's not like I'm not trying. I have a fairly new debian
> testing, xterm v390 and libncurses5 v6.3 but nope, no joy.
> 
> I betcha it is some stupid conversion thing.

Worse things could happen!  ;-)

							Thanx, Paul

