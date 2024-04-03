Return-Path: <linux-kernel+bounces-129032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4162D89637E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BD01C22C5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21884446D2;
	Wed,  3 Apr 2024 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="gZE5dRG/"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A34120B;
	Wed,  3 Apr 2024 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712118389; cv=none; b=RsFaRwgxNRlMTxVM9myWwcvoREgbL9vbM23uZsq+pWUOWXRv92Oeu1goWhEV9QOARCzCv3jOGVMatP7GeRV6nHuzHniOID7HCFM9tE0Ik1BieJVrDtVVv0y0gxZsC7+C0moYBsLIbcWhNzpT7RK+4wnyUOdY7+04dsr8Ge7urg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712118389; c=relaxed/simple;
	bh=GFopZvyivykktQ72jqds+qx9RyJ0KszyGSYlJEDTeuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IX3XaEX9ZD78szhQ0HOL6e/IGoT64bXi+6/JMFTcqKKfEgWSer3Jbmm23DbqkRglW6CI1sMfdaVE/Z6JHXp2jpEEh1SWSjQ1b1qOrODREo65kMZyEGkqj8rYED6nU7lnMHT9Ljf4KbwKiMh6ZzUEWvM4bUKRoVSsZiOjggHJzwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=gZE5dRG/; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=QyVQuuWUk2XuaF7soW3Q/khOH9t0orQsT6WSZbVXx2k=;
	t=1712118387; x=1712550387; b=gZE5dRG/tMD/U4WVfh0XI/UVHhBN+SCx+1Kox4o5wsdWe61
	arEgelcyS5/AKBKvk6wsR0cToZczV7dujVd+mslqcekX8KCElai6BsknqjPcWbaeYrcwAzq5wyleS
	9DinbuEgmN5JPqSJqxxI3J8V5NXqT1xEa6agub+5wMynUNqMUC+YywIWoLz+j0wVJ2iytacgnRbQK
	n/aKUMs3B9Ha/bbBpJ/6cssGI3uYML/N4xmYgrOcEWq1l+m5BUdCtuRaUAV0EGQdce3PQf1at9YFu
	IXW1AtWH+mCU9uP4c4IZUHyDWcdl13DpPcstu9wUTj0lqZMQGky+6AyW2UJ8xgnA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rrsCe-000542-LX; Wed, 03 Apr 2024 06:26:24 +0200
Message-ID: <b6cdb17f-206c-4dff-bb45-a60317e0a55e@leemhuis.info>
Date: Wed, 3 Apr 2024 06:26:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hibernate stuck after recent kernel/workqueue.c changes in Stable
 6.6.23
To: Tejun Heo <tj@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info>
 <ZgylCe48FuOKNWtM@slm.duckdns.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZgylCe48FuOKNWtM@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712118387;eb609220;
X-HE-SMSGID: 1rrsCe-000542-LX

On 03.04.24 02:38, Tejun Heo wrote:
> On Tue, Apr 02, 2024 at 10:08:11AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Hi stable team, there is a report that the recent backport of
>> 5797b1c18919cd ("workqueue: Implement system-wide nr_active enforcement
>> for unbound workqueues") [from Tejun] to 6.6.y (as 5a70baec2294) broke
>> hibernate for a user. 6.6.24-rc1 did not fix this problem; reverting the
>> culprit does.
>>
>>> With kernel 6.6.23 hibernating usually hangs here: the display stays
>>> on but the mouse pointer does not move and the keyboard does not work.
>>> But SysRq REISUB does reboot. Sometimes it seems to hibernate: the
>>> computer powers down and can be waked up and the previous display comes
>>> visible, but it is stuck there.
>>
>> See https://bugzilla.kernel.org/show_bug.cgi?id=218658 for details.
>> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
>> not CCed them in mails like this.
>>
>> Side note: there is a mainline report about problems due to
>> 5797b1c18919cd ("workqueue: Implement system-wide nr_active enforcement
>> for unbound workqueues") as well, but it's about "nohz_full=0 prevents
>> kernel from booting":
>> https://bugzilla.kernel.org/show_bug.cgi?id=218665; will forward that
>> separately to Tejun.
> 
> Sorry about late reply

No problem at all, really, thx for your reply!

> but that commit is not for -stable. It does fix an
> undesirable behavior from an earlier commit, so it has the Fixes tag but it
> has a series of dependencies that need to be backported together

Not sure if you know, but the stable team apparently recently backported a
bunch of other workqueue commits as well; I see 10 from a quick look here:
https://lore.kernel.org/all/20240326223803.2647796-1-sashal@kernel.org/

$ git log --grep='workqueue:' --oneline v6.6.22..stable/linux-6.6.y -- include/linux/workqueue.h kernel/workqueue*
7df62b8cca38aa workqueue: Don't call cpumask_test_cpu() with -1 CPU in wq_update_node_max_active()
5a70baec2294e8 workqueue: Implement system-wide nr_active enforcement for unbound workqueues
b522229a56941a workqueue: Introduce struct wq_node_nr_active
bd31fb926dfa02 workqueue: RCU protect wq->dfl_pwq and implement accessors for it
5f99fee6f2dea1 workqueue: Make wq_adjust_max_active() round-robin pwqs while activating
4023a2d9507691 workqueue: Move nr_active handling into helpers
6c592f0bb96815 workqueue: Replace pwq_activate_inactive_work() with [__]pwq_activate_work()
bad184d26a4f68 workqueue: Factor out pwq_is_empty()
82e098f5bed1ff workqueue: Move pwq->max_active to wq->max_active
43a181f8f41aca workqueue.c: Increase workqueue name length

And there is also "workqueue: Shorten events_freezable_power_efficient name"
in the queue for the next 6.6.y release:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.6

That leads to the question: what is the better patch forward here: pick
up what's is missing or back out?

Side note: I have no idea why the stable team backported those patches
and no option on whether that was wise, just trying to help finding the best
solution forward from the current state of things.

> which would
> be far too invasive for -stable, thus no Cc: stable.
>
> I didn't know a Fixes
> tag automatically triggers backport to -stable. I will keep that in mind for
> future.

/me fears that more and more developers due to situations like this will
avoid Fixes: tags and wonders what consequences that might have for the
kernel as a whole

Ciao, Thorsten

