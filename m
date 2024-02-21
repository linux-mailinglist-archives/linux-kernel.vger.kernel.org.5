Return-Path: <linux-kernel+bounces-75549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ED785EB07
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987BC1F274C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB2F12AAEB;
	Wed, 21 Feb 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmT3tKpU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21C128366;
	Wed, 21 Feb 2024 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550958; cv=none; b=ECNziEnhoeMnoc7ZbRob5mA65M7Ilm2A9WbXJY3moXxowCcg6xYrJ4SE7uGkckanIiMC/W7tn7xAUK+TVyd4jUW/7Vu1ZcHNfZzmJbk9OE7PdNPl2Q8rIf/d4hMo9oe9i24eCMRtXKr/C+9dDrEg/eTYqH7d6rEYV3/AKwCjBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550958; c=relaxed/simple;
	bh=JRgcBVS5XHMkL/8pMwqIfJAZLHXQePimKuWk2NELukw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfACVVGnuZjCNM6WAbUUyeXRIEubN+cJnKByoHTdOw0p0byWD9xPf8yVAbFquXjXwDg8j8GXWXEWKyMPNyPiyyl3sOLc/Fn1ZoDvWd0Qbjv0U/icnjwmSogPqD3iOwpS0bPGG+1pgZ/8qBln/mQ8R1nZh7W1fssLvXzsNX+lbbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmT3tKpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8ABC433C7;
	Wed, 21 Feb 2024 21:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550957;
	bh=JRgcBVS5XHMkL/8pMwqIfJAZLHXQePimKuWk2NELukw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JmT3tKpUUTmJMlBp4m8Rc90NH8SM6G61jzplm6+nsKJOLZW4UPY0Gc2tC6Jt8SG9a
	 mCYtlXTXStCkRjYRbI4b2E58hh2Z0gp89qDPBKRUPNoL1veS18Ib0VG6zkcWKbL285
	 6RY0zfyUJXv7VfWdlUtSzGP3qQ9Uy82eGgv3VTSjRzMMiuQRQsD7GPvnw55s6usZGN
	 /Jy6Dan0/n1EdJBgedESk6YXpPOOubw/tD2+en+fPtCCL0Jy9vmUkRCWPk1+wjN8ld
	 cVTiu+MnFB7niZt8NgwkT9VeN1ezVIkSQRGWdQsA40QZZmUQA4xWlbLRemp9L2Q3th
	 W4Z3AICHinHhg==
Date: Wed, 21 Feb 2024 13:29:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: syzbot <syzbot+039399a9b96297ddedca@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in hrtimer_active
Message-ID: <20240221132916.6c7c4219@kernel.org>
In-Reply-To: <875xytjnio.ffs@tglx>
References: <00000000000014671906112cb2ef@google.com>
	<875xytjnio.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 00:01:03 +0100 Thomas Gleixner wrote:
> So something in that syzbot test case manages to tear down a napi
> context which has not yet been fully initialized. While the rest of
> napi_disable() does not care much as long as neither NAPIF_STATE_SCHED
> nor NAPIF_STATE_NPSVC are set in napi->state, hrtimer_cancel() pretty
> much cares as demonstrated by the NULL pointer dereference.
> 
> While it would be trivial to harden the hrtimer code for the case that a
> non-initialized hrtimer is canceled, I wonder whether this invocation of
> napi_disable() is harmless (aside of the hrtimer issue) or if there are
> some hidden subtle issues with that.

Thanks for the forward, I stared at it for a bit and I can see one way
to make veth disable unregistered NAPI. I'll send a fix shortly.

