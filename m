Return-Path: <linux-kernel+bounces-158935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C7B8B271C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581B3281C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA814E2E0;
	Thu, 25 Apr 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cK9Z9xlq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D014D717;
	Thu, 25 Apr 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064678; cv=none; b=ZJvhjPGzxPq18f3vy39qWrc/Ap5yEY7rGzHwMdlFC0xoXkm7zcUohMIHsA7BN1dLz/y6OY1GZ1LsMbnZVuOIubJyK+BNcA4t/qLpJafSfdr+BcwROniKHqXLJecTBP044TJskuI6UOEsoygdSc9VmdvOcCaRIWf+dPA92O2kWj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064678; c=relaxed/simple;
	bh=10seaOuogLecZ+rmxfHQABFw/3RsOlWdgZz3zMbZs4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fictwhkqxTdXjMSVFdtr9duACVESTS4Ph8gIS6ie1fpJ0sfMVqBhjKsq4wh/Bf7SATwi9wcmNAfP7gtsNl6+9sS3lw5wGVZ1nytA3RQL1oGq8+tsIfwE19OAJCSjibAFy8/UkW0EpC1zpSbpC+x+M0FK+9pSAVlAhJVRJwXHydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cK9Z9xlq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714064671;
	bh=10seaOuogLecZ+rmxfHQABFw/3RsOlWdgZz3zMbZs4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cK9Z9xlqxGw75YqQktQFKZFa7lA7SfBzHD82hMw2EXRSS3QIKCV+c1NsyVcG8lCCv
	 jd9dAxh2IngIxZ36GtizEYTucrmZxZzPGut8E3uz78Mnqv0Xb/VjYtZsMQqBhJUIDc
	 +d4FtjPycKi9gJk1O53nm+344LdA2Huw0SJ/teZEhhGmku5FC7jMFdrpisY2QpPMk1
	 JdA04+DM3gOXapSbmeSTfSb+y0v7iCx8eJXmhvshZ8e58J9rI/YLSa9fjJ91ZWRVIa
	 TO6+qqqbHF4+Az3A1yaITZwcXWUBiLcRA8FUPt9Z+NW2ytKZ497xT2rLjTnnxkROzj
	 xSSCZikm/ZOrQ==
Received: from [100.95.196.182] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrzej.p)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 743FB378148F;
	Thu, 25 Apr 2024 17:04:31 +0000 (UTC)
Message-ID: <043e53c5-98a0-4205-8065-cd57dceacd3f@collabora.com>
Date: Thu, 25 Apr 2024 19:04:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: cyapa - add missing input core locking to
 suspend/resume functions
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <CGME20231009121026eucas1p19ed2a6a88fa6b899ef9b915a73ad87b5@eucas1p1.samsung.com>
 <20231009121018.1075318-1-m.szyprowski@samsung.com>
 <5f9052f0-ef5f-4c4f-85f9-f07fffd2b5ef@samsung.com>
Content-Language: en-US
From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <5f9052f0-ef5f-4c4f-85f9-f07fffd2b5ef@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marek,

W dniu 25.04.2024 o 12:02, Marek Szyprowski pisze:
> On 09.10.2023 14:10, Marek Szyprowski wrote:
>> Grab input->mutex during suspend/resume functions like it is done in
>> other input drivers. This fixes the following warning during system
>> suspend/resume cycle on Samsung Exynos5250-based Snow Chromebook:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 1680 at drivers/input/input.c:2291 input_device_enabled+0x68/0x6c
>> Modules linked in: ...
>> CPU: 1 PID: 1680 Comm: kworker/u4:12 Tainted: G        W          6.6.0-rc5-next-20231009 #14109
>> Hardware name: Samsung Exynos (Flattened Device Tree)
>> Workqueue: events_unbound async_run_entry_fn
>>    unwind_backtrace from show_stack+0x10/0x14
>>    show_stack from dump_stack_lvl+0x58/0x70
>>    dump_stack_lvl from __warn+0x1a8/0x1cc
>>    __warn from warn_slowpath_fmt+0x18c/0x1b4
>>    warn_slowpath_fmt from input_device_enabled+0x68/0x6c
>>    input_device_enabled from cyapa_gen3_set_power_mode+0x13c/0x1dc
>>    cyapa_gen3_set_power_mode from cyapa_reinitialize+0x10c/0x15c
>>    cyapa_reinitialize from cyapa_resume+0x48/0x98
>>    cyapa_resume from dpm_run_callback+0x90/0x298
>>    dpm_run_callback from device_resume+0xb4/0x258
>>    device_resume from async_resume+0x20/0x64
>>    async_resume from async_run_entry_fn+0x40/0x15c
>>    async_run_entry_fn from process_scheduled_works+0xbc/0x6a8
>>    process_scheduled_works from worker_thread+0x188/0x454
>>    worker_thread from kthread+0x108/0x140
>>    kthread from ret_from_fork+0x14/0x28
>> Exception stack(0xf1625fb0 to 0xf1625ff8)
>> ...
>> ---[ end trace 0000000000000000 ]---
>> ...
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 1680 at drivers/input/input.c:2291 input_device_enabled+0x68/0x6c
>> Modules linked in: ...
>> CPU: 1 PID: 1680 Comm: kworker/u4:12 Tainted: G        W          6.6.0-rc5-next-20231009 #14109
>> Hardware name: Samsung Exynos (Flattened Device Tree)
>> Workqueue: events_unbound async_run_entry_fn
>>    unwind_backtrace from show_stack+0x10/0x14
>>    show_stack from dump_stack_lvl+0x58/0x70
>>    dump_stack_lvl from __warn+0x1a8/0x1cc
>>    __warn from warn_slowpath_fmt+0x18c/0x1b4
>>    warn_slowpath_fmt from input_device_enabled+0x68/0x6c
>>    input_device_enabled from cyapa_gen3_set_power_mode+0x13c/0x1dc
>>    cyapa_gen3_set_power_mode from cyapa_reinitialize+0x10c/0x15c
>>    cyapa_reinitialize from cyapa_resume+0x48/0x98
>>    cyapa_resume from dpm_run_callback+0x90/0x298
>>    dpm_run_callback from device_resume+0xb4/0x258
>>    device_resume from async_resume+0x20/0x64
>>    async_resume from async_run_entry_fn+0x40/0x15c
>>    async_run_entry_fn from process_scheduled_works+0xbc/0x6a8
>>    process_scheduled_works from worker_thread+0x188/0x454
>>    worker_thread from kthread+0x108/0x140
>>    kthread from ret_from_fork+0x14/0x28
>> Exception stack(0xf1625fb0 to 0xf1625ff8)
>> ...
>> ---[ end trace 0000000000000000 ]---
>>
>> Fixes: d69f0a43c677 ("Input: use input_device_enabled()")
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Gentle ping?

Thanks for pinging this gently ;)

Unfortunately I am unable to test it now, but I assume this
fixes the problem for you. If so, you can add my

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> 
>> ---
>>    drivers/input/mouse/cyapa.c | 12 +++++++++++-
>>    1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
>> index a84098448f5b..cf23f95b5f11 100644
>> --- a/drivers/input/mouse/cyapa.c
>> +++ b/drivers/input/mouse/cyapa.c
>> @@ -1347,10 +1347,16 @@ static int cyapa_suspend(struct device *dev)
>>    	u8 power_mode;
>>    	int error;
>>    
>> -	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
>> +	error = mutex_lock_interruptible(&cyapa->input->mutex);
>>    	if (error)
>>    		return error;
>>    
>> +	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
>> +	if (error) {
>> +		mutex_unlock(&cyapa->input->mutex);
>> +		return error;
>> +	}
>> +
>>    	/*
>>    	 * Runtime PM is enable only when device is in operational mode and
>>    	 * users in use, so need check it before disable it to
>> @@ -1385,6 +1391,8 @@ static int cyapa_suspend(struct device *dev)
>>    		cyapa->irq_wake = (enable_irq_wake(client->irq) == 0);
>>    
>>    	mutex_unlock(&cyapa->state_sync_lock);
>> +	mutex_unlock(&cyapa->input->mutex);
>> +
>>    	return 0;
>>    }
>>    
>> @@ -1394,6 +1402,7 @@ static int cyapa_resume(struct device *dev)
>>    	struct cyapa *cyapa = i2c_get_clientdata(client);
>>    	int error;
>>    
>> +	mutex_lock(&cyapa->input->mutex);
>>    	mutex_lock(&cyapa->state_sync_lock);
>>    
>>    	if (device_may_wakeup(dev) && cyapa->irq_wake) {
>> @@ -1412,6 +1421,7 @@ static int cyapa_resume(struct device *dev)
>>    	enable_irq(client->irq);
>>    
>>    	mutex_unlock(&cyapa->state_sync_lock);
>> +	mutex_unlock(&cyapa->input->mutex);
>>    	return 0;
>>    }
>>    
> 
> Best regards


