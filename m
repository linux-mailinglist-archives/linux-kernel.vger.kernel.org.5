Return-Path: <linux-kernel+bounces-136498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D627F89D4D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE628350B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA4175804;
	Tue,  9 Apr 2024 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="nYgd725y"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75DC1EA6E;
	Tue,  9 Apr 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652459; cv=none; b=PBABZiOrpm/ahJ/aTX0Oy+xIsCofcXrwkqO+TKJ7Ji6L7WqMFziK7rPad+NMW6Scf6QEzP49h5ctKFAo6dGnBGJ6Ox2s+QGIvNErY2/YUBcmobzuCXU2vwd1qU8m6PiYsGoguu8FKli1ijXA9BdKZG9HZFPKne87hG7lX4eKWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652459; c=relaxed/simple;
	bh=toTafaLbEIkQZDdlb3VP4CE1biVwrTMD83oodJzhGeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l+RLS2NSmzdHhN5rTy2maquEX+EycLxzFSYjP6llRm0zlYiDM6MJ0bDmQxVb+0nbpVuuE0unWWV5bPix5HTJ5S1R6hj/ckQM6izAUfON4eUaKkvbZrbK8RJLmvh7aHbODWL8dVVNZl51kA0pO/TUE3Zii2DBfhdAT6WXTr/t/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=nYgd725y; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:Reply-To:MIME-Version:Date:Message-ID:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=H/07XNt3AU4Wqk/vGpIEoTskvG7+O+ExSifSn/hGscA=; t=1712652457;
	x=1713084457; b=nYgd725y9emv12j4zO39g43lWDcxZrinOqnxYXg1Ff84u0+0iXxY8uIBZP6+p
	MyH3YacK4KJ2KNCrSBrx7h2TluehNWwG0bQfLNb1Bpg+LlVUnmaYp8edpVaIjtjnBZtPqr+c9e5nP
	5ALuMAv6lN0H/GgbrC+t71eEQEV2j+k9W64lyAWphQBhksgQ00BVSRHpe+SSs3pCheLyw1ykxjf1+
	nKIOjnQCAIB/fu3amwT85vVmofBktT+UbNZDi7F/FnlbCJar5Wqjt8X/h3zd3bffDZ0+26d0SCIEX
	yZu7la4irFstrN63nuME0+6+mckW4wIHXuPjECrSKLdyHL1Wkw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ru78g-0005TG-M8; Tue, 09 Apr 2024 10:47:34 +0200
Message-ID: <93494f0b-ad05-4566-b454-fa36a7dac248@leemhuis.info>
Date: Tue, 9 Apr 2024 10:47:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
To: Johannes Berg <johannes@sipsolutions.net>,
 Ben Greear <greearb@candelatech.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-leds@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
 <05545ecdd2b05223b9204131b0ce9ba33460f44c.camel@sipsolutions.net>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <05545ecdd2b05223b9204131b0ce9ba33460f44c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712652457;e048850d;
X-HE-SMSGID: 1ru78g-0005TG-M8

On 08.04.24 18:35, Johannes Berg wrote:
> On Wed, 2024-04-03 at 12:35 -0700, Ben Greear wrote:
>>>
>>> So, deadlock I guess....
>>>
>>>   INFO: task kworker/5:13:648 blocked for more than 180 seconds.
>>>        Not tainted 6.9.0-rc2+ #23
>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>> task:kworker/5:13    state:D stack:0     pid:648   tgid:648   ppid:2      flags:0x00004000
>>> Workqueue: events deferred_probe_timeout_work_func
>>> Call Trace:
>>>   <TASK>
>>>   __schedule+0x43d/0xe20
>>>   schedule+0x31/0x130
>>>   schedule_timeout+0x1b9/0x1d0
>>>   ? mark_held_locks+0x49/0x70
>>>   ? lockdep_hardirqs_on_prepare+0xd6/0x170
>>>   __wait_for_common+0xb9/0x1d0
>>>   ? usleep_range_state+0xb0/0xb0
>>>   ? __flush_work+0x1ff/0x460
>>>   __flush_work+0x287/0x460
>>>   ? flush_workqueue_prep_pwqs+0x120/0x120
>>>   deferred_probe_timeout_work_func+0x2b/0xa0
> 
> This seems ... complex.
> 
> Does changing iwlwifi's request_module() to request_module_nowait() in
> iwl_req_fw_callback() (only) fix it? I think we can do that, we don't
> really care at that point, and the issue here seems to be waiting for it
> while also other modules are loading and due to the hashing in
> idempotent() (kernel/module/main.c) it can't make progress.

Not my area of expertise, so listening to me my send you off-track.

Might this be related to the issue discussed here:
https://lore.kernel.org/all/ZhRD3cOtz5i-61PB@mail-itl/

See also:
https://lore.kernel.org/all/2695e9db-a5a0-4564-9812-a50b91fb1b46@gmail.com/

Ciao, Thorsten

