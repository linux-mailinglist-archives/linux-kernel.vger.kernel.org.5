Return-Path: <linux-kernel+bounces-98252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ADD877772
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B986F1F21ADB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19862381AA;
	Sun, 10 Mar 2024 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="QXOZfTtX"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AC374D9;
	Sun, 10 Mar 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710083918; cv=none; b=n2N8qqyzMM+UiSU438pV1ovIRFgGJ71RZb/HRkcpyFKUXh8+iWiY6IbhiAYxPYvKkeT70Fv/3HAQc/o6/b0F8n6XdTgktaaioje3voBYe/dw90alXAg9gz77QItdxp3UQU7es4hcDKc3H3c3qkMiVDekAHqzTdJgkdVly5hWHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710083918; c=relaxed/simple;
	bh=aSQY810y7xYhvmbNwoBlD7xvDxH/uK93An8wboVgD+4=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=WbzRNDibdgEJ21iabQjXqbzKPLp3Aq5il6P9Zd6ufaLABlaiL6HyffUyI0F7+dyI5LDRC8seZCHmWBjdMG4BbF+MsopfWTNJuVsTE6F3rplypx0XgB7FM7fGTX31P7LZJNrwSdBkDulw5VZ6Jk43CAv10FcDPY7G0kQ758XNvhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=QXOZfTtX; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=aSQY810y7xYhvmbNwoBlD7xvDxH/uK93An8wboVgD+4=; t=1710083916; x=1710515916;
	 b=QXOZfTtXfiJCt3plxDlvtz291VxuBksG3vf0QGl1jd8o4vmYDsE4fCDQj+IqtbcjEIZE592tLv
	Ep4A8/GZv+mT/8UqNCBLd8sMTXf6e6fEYqG8TOZN22fQtf0SFfaIAGM5cvCajVakz0pj9csu7d1U/
	XP9peWeajLuBuDc/0eqC78L5wDInYogXJGsFqMxsbJ/Y+kSuRYVy1JmMaW650TfylzNnih36SVYvw
	At/yuo6Ij6OUn1hheQvd+FMPCjU3kszS58QWHbARVcJGiXfc/momD9kTGAWvnWgwwC8Djj8wgtS1Q
	Smu+1RRT6GvqaqCYypkdGdc1+ZBQufgB5VJ1A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rjKwb-0003bL-FH; Sun, 10 Mar 2024 16:18:33 +0100
Message-ID: <053fb024-0fbf-4bdf-ac3a-26493ca08acd@leemhuis.info>
Date: Sun, 10 Mar 2024 16:18:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Linux regressions report for mainline [2024-03-10]
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710083916;5eee15a6;
X-HE-SMSGID: 1rjKwb-0003bL-FH

Hi Linus, here is a quick status update wrt. to regressions introduced
in this cycle. This time hand-complied instead of from regzbot (I just
broke something and lack time to fix it):


# Things that might or might not be a good reason for a -rc8

* Btrfs since v6.8-rc6 has a fiemap regression that "can actually have
serious consequences", as mentioned in
https://lore.kernel.org/linux-btrfs/cover.1709202499.git.fdmanana@suse.com/
The fixes in reply to that mail since Wednesday are in -next as
978b63f7464abc ("btrfs: fix race when detecting delalloc ranges during
fiemap") and 1cab1375ba6d53 ("btrfs: reuse cloned extent buffer during
fiemap to avoid re-allocations"), but not on the way to you afaics.

* A fix for Johan Hovold's last big Lenovo ThinkPad X13s regression
(hard resets disconnecting external displays) is currently up for review
and testing:
https://lore.kernel.org/lkml/ZeyOmJLlBbwnmaJN@hovoldconsulting.com/



# Fixes for regressions from this cycle afaics unlikely to reach 6.8

* -next commit 3445139e3a594b ("Revert "Revert "md/raid5: Wait for
MD_SB_CHANGE_PENDING in raid5d"""), which reverts a commit from
6.8-rc1; Song thinks it's better to merge it for 6.9 and then backport
to 6.8:
https://lore.kernel.org/all/CAPhsuW51ND4qH4My8Uz1XaZSdvAjDR7eL7O-RLr5wKmFJA0XMQ@mail.gmail.com/
Report: https://lore.kernel.org/all/20240123005700.9302-1-dan@danm.net/

* -next commit 0d7dfc79fb9b4b ("drm/msm/a6xx: specify UBWC config for
sc7180" No reply to my recent inquiry why this fix for a commit from
this cycle was queued for 6.9:
https://lore.kernel.org/all/4e55f6fd-8875-4a61-9070-f0ecad8082ea@leemhuis.info/
Report: https://gitlab.freedesktop.org/drm/msm/-/issues/49 and
https://lore.kernel.org/all/85581fad-da8f-4550-a1c8-8f2996425dcd@lausen.nl/


# Regressions fixes sitting on the list awaiting review

* "drm/nouveau: keep DMA buffers required for suspend/resume", which
fixes rendering freezes with multi-GPU setups:
https://lore.kernel.org/dri-devel/20240229175822.30613-1-sidpranjale127@protonmail.com/

* "Fix divide-by-zero on DP unplug with nouveau" which fixes a divide error:
https://lore.kernel.org/regressions/ZeoAPFIF6NClUl4P@debian.local/

* "u64_stats: fix u64_stats_init() for lockdep when used repeatedly in
one file" fixes a lockdep splat
https://lore.kernel.org/lkml/20240306111157.29327-1-petr@tesarici.cz/


# Regression reports where no fix is in sight afaics

* dmaengine: CPU stalls while loading bluetooth module
https://lore.kernel.org/lkml/ZYhQ2-OnjDgoqjvt@wens.tw/ and
https://lore.kernel.org/lkml/1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com/
See also:
https://lore.kernel.org/all/000001da7140%246a0f1570%243e2d4050%24@samsung.com/
Revert might be counter-productive.

* x86/mm/ident_map: kexec now leads to reboot
https://lore.kernel.org/stable/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
https://lore.kernel.org/all/CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com/
A revert apparently could fix this.



Ciao, Thorsten

