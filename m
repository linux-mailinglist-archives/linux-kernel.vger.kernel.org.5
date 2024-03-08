Return-Path: <linux-kernel+bounces-97199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545DC8766D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2D91F21600
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA9524A;
	Fri,  8 Mar 2024 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="UlbljNRT"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FADD139B;
	Fri,  8 Mar 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909855; cv=none; b=QT9W/Nev+QPFY7x5b7ImWffC/zQVNEgBJKn/vrjaQAd8hqIZvpRu/W/WAfxdQ9QlSdEYGWTOd1LfDSuidWvAhBx+QnZlaH0vEQA//80Txuz7CidQ36Udk8IB/xs7GrBO/VgeDTRdaweahx1rPLhS+UnRtUyw3DoTS6rh3X+glA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909855; c=relaxed/simple;
	bh=SoBP5zdgJWYtt7+AXt9ixFnf+qarEoVQ+eVaOaf4HfM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ppdKAcpNxJN/PVjhRT39lhPHvU9m7Jj43dVFaJd0ZIodrRtarIgCMkqQm1U7elgPsVmvRG9lkhDlriDYvwlsEKZRB9DqZs/BlHsSIid/EBo0weCnOyvuer/ldBonh1fm/iCO6Xi9YOnx+CIv+3pJYDhIDDGQSM61yAvpNYHjXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=UlbljNRT; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:Reply-To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=SoBP5zdgJWYtt7+AXt9ixFnf+qarEoVQ+eVaOaf4HfM=; t=1709909853;
	x=1710341853; b=UlbljNRTZWGCN7M4RmludKLlq9ABJVw11bVBJKR2wJBGT5P1NZBQwInAZB/nf
	jht1m7QT3z7i2w7yu43FxIiT8ndls9iB+kCgDiy16TCmBg+DDKyl3sxVcaPr2sw635OtuZwOoqE4g
	r1fjODltr3kD1upYy42zy5qsUQuYVTei9nw8tYirStw0a7bsUqR/r6GAVs4NMBXfYmSLzHAgP9ojO
	FOse0V8iYFJYnsGhKl+Llfie2y0MsdhhmYj9w2bysa8KhT5dY18wKCk7YyLqfYjxKOr8KEQH8EhUN
	/YDj0h/YnEep5ZTqS+1hEehLQUmhfaJ8jtMMpvOI+n3GvD4bmA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ribf8-0001bq-Uw; Fri, 08 Mar 2024 15:57:31 +0100
Message-ID: <d85b8998-f7b8-465d-b5f0-d8fbb5382cce@leemhuis.info>
Date: Fri, 8 Mar 2024 15:57:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Subject: "Extra" Linux regressions report for mainline slightly ahead of
 6.8-rc8/final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709909853;57c071e1;
X-HE-SMSGID: 1ribf8-0001bq-Uw

Hi Linus, here is a quick manual extra regression report due to the
nearing 6.8 release:


# Fixes for regressions from this cycle afaics unlikely to reach 6.8

* 3445139e3a594b ("Revert "Revert "md/raid5: Wait for
MD_SB_CHANGE_PENDING in raid5d""") in next, which reverts a commits from
6.8-rc1; Song thinks it's better to merge this revert for 6.9 and then
backport to 6.8:
https://lore.kernel.org/all/CAPhsuW51ND4qH4My8Uz1XaZSdvAjDR7eL7O-RLr5wKmFJA0XMQ@mail.gmail.com/
Report: https://lore.kernel.org/all/20240123005700.9302-1-dan@danm.net/

* 0d7dfc79fb9b4b ("drm/msm/a6xx: specify UBWC config for sc7180" in
next. No reply to my recent inquiry why this fix for a commit from this
cycle was queued for 6.9:
https://lore.kernel.org/all/4e55f6fd-8875-4a61-9070-f0ecad8082ea@leemhuis.info/
Report: https://gitlab.freedesktop.org/drm/msm/-/issues/49 and
https://lore.kernel.org/all/85581fad-da8f-4550-a1c8-8f2996425dcd@lausen.nl/



# Regressions fixes sitting on the list awaiting review:

* Fix divide-by-zero on DP unplug with nouveau
https://lore.kernel.org/regressions/ZeoAPFIF6NClUl4P@debian.local/

* u64_stats: fix u64_stats_init() for lockdep when used repeatedly in
one file
https://lore.kernel.org/lkml/20240306111157.29327-1-petr@tesarici.cz/

* drm/nouveau: keep DMA buffers required for suspend/resume
https://lore.kernel.org/dri-devel/20240229175822.30613-1-sidpranjale127@protonmail.com/



# Regression reports where no fix is in sight afaics

* dmaengine: CPU stalls while loading bluetooth module
https://lore.kernel.org/lkml/ZYhQ2-OnjDgoqjvt@wens.tw/ and
https://lore.kernel.org/lkml/1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com/
See also:
https://lore.kernel.org/all/000001da7140%246a0f1570%243e2d4050%24@samsung.com/
Revert might be counter-productive.

* drm/msm: Thinkpad X13s hard resets disconnecting external displays (
https://lore.kernel.org/lkml/Zd3kvD02Qvsh2Sid@hovoldconsulting.com/
See also: lore.kernel.org/all/ZesK1SKUB9BVKouF%40hovoldconsulting.com
and https://lore.kernel.org/lkml/ZesH21DcfOldRD9g@hovoldconsulting.com/
Maybe the whole series that causes this should have been reverted a week
ago...

* x86/mm/ident_map: kexec now leads to reboot
https://lore.kernel.org/stable/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
https://lore.kernel.org/all/CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com/
A revert apparently could fix this.



# For completeness: fixes that I assume will make it to you soon

* I assume Dmitry will send 7105e92c60c9cc ("Revert "Input: bcm5974 -
check endpoint type before starting traffic"") soon.

* I assume Greg will send ac3e0384073b24 ("misc: lis3lv02d_i2c: Fix
regulators getting en-/dis-abled twice on suspend/resume") soon.

* Not totally sure, but I assume the Btrfs folks will send
978b63f7464abc ("btrfs: fix race when detecting delalloc ranges during
fiemap") and 1cab1375ba6d53 ("btrfs: reuse cloned extent buffer during
fiemap to avoid re-allocations") to you, too.


Ciao, Thorsten

Side note: /me hopes this mail is not classified as spam due to all the
links...

