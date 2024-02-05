Return-Path: <linux-kernel+bounces-53796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5783784A6AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC0928C50D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEDF1AB81E;
	Mon,  5 Feb 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XROKgdlw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9F1AB7E1;
	Mon,  5 Feb 2024 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159953; cv=none; b=gDY+/Yf8fg4apa4vkCZvCz//HWnWDkxvOylHZTBWICZtS4W/+kuk2tSZ4M4z5rq2o9PxSk+z3nQ5V9qu2iItFjmIhKivYN4pM8ddhlW7LNubR6/9SA4U89RLhSNUI1DIN5pM0w5dDTOhPgRseMKR/CLfspJoIDIq4Qr6Fcf7TRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159953; c=relaxed/simple;
	bh=3ROEJmZTb8Jo+bSEuAFN2xW0wJl3GtXSP1Suz12V08M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrIm4j61B4bd02ABSnd76/+wfQ6+7ZY0xGof8utDyK3NpQW3dzF43EeDDs4Tpj5kseWu0BGObcRkNKjQcn9HL8Se/qwL1wB3/Ay/pBG/Y2CHBZDfm+K+rK3PqtsLpurCydl2TcibMQknupXwzWgQPPhC+5SlLtT9bXnQwywZSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XROKgdlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245A4C433F1;
	Mon,  5 Feb 2024 19:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159952;
	bh=3ROEJmZTb8Jo+bSEuAFN2xW0wJl3GtXSP1Suz12V08M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XROKgdlwninKaSs2ZIIMucMD8+MqsKiHm90Z+YeuLfBzZLmG04HfaiUFZWyXUiY3b
	 NOrDebubV8NXP2+xHibhg0oC83Y1Drj6iEkTPe7Iixx9Rp82J0ydcn31oQJc1IAlAn
	 G8MEwggJNANGjkx+oZl52oVPOIVlgU6i1SI34tN4=
Date: Mon, 5 Feb 2024 05:14:53 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [v6.7][PATCH 00/23] eventfs: Linus's updates for 6.7
Message-ID: <2024020529-reproach-unleaded-d7a5@gregkh>
References: <20240204011615.703023949@goodmis.org>
 <20240203202503.0e37a22f@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203202503.0e37a22f@rorschach.local.home>

On Sat, Feb 03, 2024 at 08:25:03PM -0500, Steven Rostedt wrote:
> On Sat, 03 Feb 2024 20:16:15 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > This is the update for 6.7. It includes Linus's updates as well as all the
> > patches leading up to them.
> 
> Hmm, I just realized I didn't include the sha of the upstream commit. I
> simply ran the following command against v6.7.3:
> 
> git log --reverse --no-merges --pretty=oneline v6.7..origin/master fs/tracefs/ | cut -d' ' -f1 | while read a; do if ! git cherry-pick $a; then break; fi ; done
> 
> And I believe I removed one unrelated patch.
> 
> I know that cherry-pick has a '-x' option that adds a: "(cherry picked from commit ...)"
> I can re-run it and make sure it still matches this branch if it makes
> it easier for you.

Please do, otherwise I have to dig out the sha1 "by hand" from the
original commits, which is a huge pain.

thanks,

greg k-h

