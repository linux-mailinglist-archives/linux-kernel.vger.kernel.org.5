Return-Path: <linux-kernel+bounces-71067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D0185A039
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA06C1C20E24
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CDF24B50;
	Mon, 19 Feb 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c8DmZUwp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IigoxJE8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cLrOiFe3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p+hzl82W"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831325616;
	Mon, 19 Feb 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336341; cv=none; b=MPFyjefP+q613WIMaBtQsKnKIoJsucLAKJYM3uJ6Zk3E285Ri69MSUct7IZUNLOuzMsnITW737pyVbXAspIs+uBnLeatP/zuvT0KA5/CHsTECGnm2EHNVJIGamIsQxc3mZuTOukDW6jrgrEfGA6u0QbORicniC/wewZAvLsS0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336341; c=relaxed/simple;
	bh=3d00+GUu13rz1nfovatna97QA1Os+YmMETWrC4U6iI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eTVcFwq6tn/xry3LQyL7AzMKnMh1IhVE4qgkwjnw4rkPez+Jik0AVv6u+8JcuWL375KEEXlAGkW81WId3fEwjLfeI4paCANAMYDg0gzUIEog8A0OucL4knqapYnpfYv2KMEh2Y+F7GpITtvs0ZGQu0gcllDnCkKaHMLlARRx68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c8DmZUwp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IigoxJE8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cLrOiFe3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p+hzl82W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id CCEF41F7EA;
	Mon, 19 Feb 2024 09:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708336338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDQgdyESjlbctAYYG7FMAE0n7tgZiYwLtu/Lui10k14=;
	b=c8DmZUwpHQ0dCj8cppBstca2d2VvYD4mCZPnQ5+Rzc0ZvJH7l+yQhje0bOu+yWcBmdUCcY
	Fr4FbTW2jpaLufu6DtnOKZVDTqH6z+FnCvgu/GNHn4BFxQMAVBB+dF7qkD9Sn5LQjPJUED
	jK0s5Kol+lXtfcC4lg0CJ43mnghTTGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708336338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDQgdyESjlbctAYYG7FMAE0n7tgZiYwLtu/Lui10k14=;
	b=IigoxJE8qW+2CrzGU7Ty4XYQT3Mo/JzrXFN5z2c+xq5RbB24CNnLVg4fBVuKKw3LB0y2no
	apTg9Q8QdR2poBAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708336337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDQgdyESjlbctAYYG7FMAE0n7tgZiYwLtu/Lui10k14=;
	b=cLrOiFe3IjshB32bDdg7Ji7Kl82Emt/PA8Oyw/zOww8ewAKssrG5a10H1t5omQb/YqEH/0
	Hy6zizXQ2v8qieo729QUEaGava4rAmoNfPB+LrIfRPhPMmLTF4tRGxer/1gCQmJ7VOC7Yk
	S3bkHGrU/34FoCTBieFQxWdcczpC0cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708336337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDQgdyESjlbctAYYG7FMAE0n7tgZiYwLtu/Lui10k14=;
	b=p+hzl82WGyK2rLikBGa7bH9V8ByXpw4i9Jiq9NpOzKzjBvlpVqTid8dm08unBmc9YGw9oE
	g6CsPTuVlCbo9MBw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id BCE7F4A051A; Mon, 19 Feb 2024 10:52:17 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: tony@atomide.com,  lee@kernel.org,  robh@kernel.org,  wens@csie.org,
  linux-omap@vger.kernel.org,  linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mfd: twl6030-irq: Revert to use of_match_device()
In-Reply-To: <20231029114843.15553-1-peter.ujfalusi@gmail.com> (Peter
	Ujfalusi's message of "Sun, 29 Oct 2023 13:48:43 +0200")
References: <20231029114843.15553-1-peter.ujfalusi@gmail.com>
X-Yow: RELAX!! ... This is gonna be a HEALING EXPERIENCE!!  Besides,
 I work for DING DONGS!
Date: Mon, 19 Feb 2024 10:52:17 +0100
Message-ID: <mvmttm4ye5q.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.41 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 BAYES_HAM(-1.81)[93.86%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FREEMAIL_TO(0.00)[gmail.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.41

On Okt 29 2023, Peter Ujfalusi wrote:

> The core twl chip is probed via i2c and the dev->driver->of_match_table is
> NULL, causing the driver to fail to probe.
>
> This partially reverts commit 1e0c866887f4.
>
> Fixes: 1e0c866887f4 ("mfd: Use device_get_match_data() in a bunch of drivers")

That commit id does not exist, which is why it hasn't been picked up by
stable.  The correct commit id is 830fafce06e6f.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

