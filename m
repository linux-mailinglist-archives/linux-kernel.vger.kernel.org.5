Return-Path: <linux-kernel+bounces-129649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0A6896DD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDDA1F28C8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BBC1419BC;
	Wed,  3 Apr 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="uxvdKthd"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6D36D1AE;
	Wed,  3 Apr 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142859; cv=none; b=m2g7QSQWNbxLTldXRQEeieSR6Nqvkwt3XuPTIPeNJn263w/+9hrWkkZwV+1VXrzFIplEgJbJORNkTxq3GvoFqvO+cqLub5IjBcaMRvXiEx205TBC+n9SuNFiz5F3suu5kGlaPtSbJZtwAd3NKs/XxIYxQxwZD3QvtMaMvFm68co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142859; c=relaxed/simple;
	bh=dZ19RSEwhVWhjhnaqZ0vIwPLtYWaedZYkYvYqGJ1kwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3SB73JTTEkMCiPgT8bZ1gVaL+bY75rwJD1rgp3YpKkjbZR4Y/HaB1zSm7WR5kh/s4bWi7kigr7toUaon0UC4tq2tgtO8zwXRrxP0KznSskv3LvX6gSFGZ712CGsVku86E+I7/Tg61ZDxkha3cnLCnFJJPqdPUh6NkQkm6lj9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=uxvdKthd; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Cwvg1mTQQrARNTqbIviETmjFgblYY9ykcZc99ybA6qo=;
	t=1712142857; x=1712574857; b=uxvdKthdQP0mhcG+yPoollm/13bCdv9jtHmG+Mh7gDmR+PE
	EwQEyVmOFeia1fLKH5CvZ863l3CRu54KmImNuvpP8mOcq1rNDfEyj/tAhF/pZtm7q6ElEiUoR6qxv
	VIWKB+myahmtn9r4OGISCtY9IYdl5zfu+XJV2X0jXaL/9MxZJ0Zlicxsq1Kx/jby5Flk51Lg0Jjel
	Yby64/BjfjN+yp6QHO4f0rzNNvq9pIyEdCbP1gW9inHb91LM5vjTct/aUij98+x8qKgNZOkUfnR+8
	pPrEr6415AIXBsTCpGOwp6w+4qc31XvAAFyQ9xY7CoW6WxPxBqHU2yFjV7ed9X0g==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rryZD-00023p-QR; Wed, 03 Apr 2024 13:14:07 +0200
Message-ID: <21a230d8-92cf-4ae9-ae4c-34b3a2fe2670@leemhuis.info>
Date: Wed, 3 Apr 2024 13:14:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 6.8 000/715] 6.8.2-rc1 review
To: Jon Hunter <jonathanh@nvidia.com>, Sasha Levin <sashal@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
 <0cdbf4d6-3dce-42ee-8029-c486ec999fb5@nvidia.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <0cdbf4d6-3dce-42ee-8029-c486ec999fb5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712142857;846c7af8;
X-HE-SMSGID: 1rryZD-00023p-QR

On 03.04.24 12:02, Jon Hunter wrote:
> On 24/03/2024 22:22, Sasha Levin wrote:
>> Tejun Heo (9):
>>    workqueue: Move pwq->max_active to wq->max_active
>>    workqueue: Factor out pwq_is_empty()
>>    workqueue: Replace pwq_activate_inactive_work() with
>>      [__]pwq_activate_work()
>>    workqueue: Move nr_active handling into helpers
>>    workqueue: Make wq_adjust_max_active() round-robin pwqs while
>>      activating
>>    workqueue: RCU protect wq->dfl_pwq and implement accessors for it
>>    workqueue: Introduce struct wq_node_nr_active
>>    workqueue: Implement system-wide nr_active enforcement for unbound
>>      workqueues
>>    workqueue: Don't call cpumask_test_cpu() with -1 CPU in
>>      wq_update_node_max_active()
> 
> 
> Sorry I am late on this, but I was not copied and so did not see this. I
> noticed a suspend regression on Tegra186 with v6.8.y and bisect is point
> to commit "workqueue: Implement system-wide nr_active enforcement for
> unbound workqueues".
> 
> Reverting commits "workqueue: Don't call cpumask_test_cpu() with -1 CPU
> in wq_update_node_max_active()" and "workqueue: Implement system-wide
> nr_active enforcement for unbound workqueues" does fix the problem.
> 
> Note that I am not seeing this regression on the mainline with v6.9-rc2
> and so I am not sure if there is something else missing? I am also still
> seeing the problem with v6.8.3-rc1.

FWIW, there is a ongoing discussion about the workqueue backports (and
if those should be removed) due to a earlier regression report (about
hibernate, not suspend) here:

https://lore.kernel.org/all/ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info/

Ciao, Thorsten

