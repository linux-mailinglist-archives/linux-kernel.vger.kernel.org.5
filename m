Return-Path: <linux-kernel+bounces-159564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2768B3059
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E48D1F23BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD2413A889;
	Fri, 26 Apr 2024 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ZxJxTbjJ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462E282FD;
	Fri, 26 Apr 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714112732; cv=none; b=OAUW96tzmpvMpF181kxV/9e2AYF9F99VoYNIzmrB7j4FHnMKixdzirL869NqyQbAuhMmWHrOOAK9I5d6nxh4ePOMN4ATbBjAe6E85bNsSuBbjIdJhummGBLjrql/Ce4J2R/Rbz3TCW0FMahHbSqlUmH1uMqHUhNKZnOLWs8jkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714112732; c=relaxed/simple;
	bh=xDOqNGbeSe6pXMEwzFpo1cSQcwhLWILxGVo8CczI1Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njZIpGBhJPtRb9Gl1YLK2iqHSVWeRcMGcK/1kEc4Wd1u3x58omvBPrlPDiJo0WjaDIh8nYMfwLhSjw0qE0t+hQmdBI6dNSOAFNRTEoJS0vJUMgKyGHamktdg+duzxNH5Qya0W5BWhyGNEOtePjAKwJq/ia37XPEtS5AGRY5aM4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ZxJxTbjJ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=hBtXuHAJ4otz2hqkKXeXuHHZ4NRvPizZ3qOHTCtx7p4=;
	t=1714112729; x=1714544729; b=ZxJxTbjJh4W5LLmD6S/3aDdKnkznlhiLuANoti76Yj0rb6P
	ms4xZlHNL/Z9NNrd32vHDNaXJg1ipqKQB3//sToXYT0AkwpiOILu+hfQ0QgPchHCwlFftoC+ANE2x
	sj1sQYwlQynckL4stusYNyldduzZwTDAhHS8cE0M+Jyc0XJnhIcL6oim3b5UNfs5O5m0EvwZodtiU
	fS+g/L+SoNmSxmNZVb529yNsudsW3rz953T0iXlA8qeWl3nnxsBm3wWu2EHMf7r03hCdHpddhkcwj
	P7Y1utA/BReokEnmq2G5MerAdVlMJuWdwhRiDtL4tcfHtQpjBURCziTNllUtLKQQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s0F1Q-0002G7-Vx; Fri, 26 Apr 2024 08:25:25 +0200
Message-ID: <ded3e7ae-6a7d-48b2-8acc-c125874ee09f@leemhuis.info>
Date: Fri, 26 Apr 2024 08:25:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] e1000e: change
 usleep_range to udelay in PHY mdic access
To: Sasha Neftin <sasha.neftin@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, netdev
 <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>, intel-wired-lan@osuosl.org
References: <20240417190320.3159360-1-vitaly.lifshits@intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240417190320.3159360-1-vitaly.lifshits@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714112729;d19d277f;
X-HE-SMSGID: 1s0F1Q-0002G7-Vx

[CCing the maintainers and a few lists]

On 17.04.24 21:03, Vitaly Lifshits wrote:
> This is a partial revert of commit 6dbdd4de0362 ("e1000e: Workaround
> for sporadic MDI error on Meteor Lake systems"). The referenced commit
> introduced an issue on vPro systems, where disconnecting and reconnecting
> the LAN cable might result in a kernel panic.
> 
> This was root caused to the usage of usleep_range in an atomic content
> while trying to access the PHY. Change back the usleep_range calls to
> udelay.
>
> Fixes: 6dbdd4de0362 ("e1000e: Workaround for sporadic MDI error on Meteor Lake systems")

Hi everyone. What's the status here? It seems like this regression fix
did not make any progress for about a week. Which is not really ideal,
as the issue afaics causes quite a few people headaches, as a quick and
rough search indicates (there might be some false positives in here):

https://bugzilla.kernel.org/show_bug.cgi?id=218740
https://bugzilla.suse.com/show_bug.cgi?id=1223109
https://bugzilla.suse.com/show_bug.cgi?id=1222945
https://bbs.archlinux.org/viewtopic.php?id=294913
https://bbs.archlinux.org/viewtopic.php?id=294828
https://forum.manjaro.org/t/networkmanager-stability-issues-since-latest-update/159960
https://discussion.fedoraproject.org/t/kernel-6-8-5-stops-at-splash-screen/113519
https://bugzilla.redhat.com/show_bug.cgi?id=2276325
https://bugzilla.redhat.com/show_bug.cgi?id=2276852
https://www.reddit.com/r/voidlinux/comments/1c9s8ut/bug_scheduling_while_atomic/

Side note: would be nice to add these tags to the patch
description, too:

 Reported-by: Jérôme Carretero <cJ@zougloub.eu>
 Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218740
 Closes: https://lore.kernel.org/lkml/a7eb665c74b5efb5140e6979759ed243072cb24a.camel@zougloub.eu/ 

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

