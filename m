Return-Path: <linux-kernel+bounces-155889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580E68AF891
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F62288E34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9CB143868;
	Tue, 23 Apr 2024 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PPud5hXC"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE4143886
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905460; cv=none; b=tYBc9kZHq+mEZXNusoBLGF79YbjblBAyyilzQGUXYqcTv1MxiKhSbHMjND2tFIakaAI1+fUbOhHWuTJvgfCeidsJndiGsN7lPYH3PS5qLJd/wlhHIiqtzCof97vi7mkEi1xcd3b6K3dp0LQLOoMmiwqnRFCsOdauq4Slrv5UNw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905460; c=relaxed/simple;
	bh=8xedF1eK6k6HSq3GJK78fgc3VP0W0QvZ+oxKsToRDpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Os0LbIFJN9XtfxdFuxfHpuyUHgu0mhoILr5vbLmtQK2jtJz1eVIUE+tNhFgAICNTF5au6VLC4IUWxtJenMugQWuh0eT5AbEertpNPPIwUN+zqIO+xI7kM7UOvti5KN3NDo2mmrXI7UmzlxFi0QLjA6CP/mxTOQiptLsZehVFmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PPud5hXC; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ffd53a0e-9f72-4129-92aa-30c62a134676@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713905456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uomJjCahNPJJRHdkxYcrPpdrf73kWiA2w/xyGNFhF8g=;
	b=PPud5hXC1Dy/t0SfmHygc6+TivtNFBP+EXei/cj+wj8mZZYoGvuimZtgJ2oyZNhReLPKKL
	YW6sIqRXbzUyG4XTWu7Sihtjg6RMsGca4xlR612Yf/9SOROS9NtkVDJEPFnk1qTBpTDtWX
	qy4uOC4Gbnt3pSLkjby/ClpPt1Q3UyA=
Date: Tue, 23 Apr 2024 16:50:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm: zynqmp_dpsub: Always register bridge
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, Michal Simek
 <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20240308204741.3631919-1-sean.anderson@linux.dev>
 <222c0245-b8bc-48d8-b4e1-a9fb276774ae@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <222c0245-b8bc-48d8-b4e1-a9fb276774ae@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 3/22/24 02:01, Tomi Valkeinen wrote:
> Hi,
> 
> On 08/03/2024 22:47, Sean Anderson wrote:
>> We must always register the DRM bridge, since zynqmp_dp_hpd_work_func
>> calls drm_bridge_hpd_notify, which in turn expects hpd_mutex to be
>> initialized. We do this before zynqmp_dpsub_drm_init since that calls
>> drm_bridge_attach. This fixes the following lockdep warning:
>>
>> [   19.217084] ------------[ cut here ]------------
>> [   19.227530] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>> [   19.227768] WARNING: CPU: 0 PID: 140 at kernel/locking/mutex.c:582 __mutex_lock+0x4bc/0x550
>> [   19.241696] Modules linked in:
>> [   19.244937] CPU: 0 PID: 140 Comm: kworker/0:4 Not tainted 6.6.20+ #96
>> [   19.252046] Hardware name: xlnx,zynqmp (DT)
>> [   19.256421] Workqueue: events zynqmp_dp_hpd_work_func
>> [   19.261795] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   19.269104] pc : __mutex_lock+0x4bc/0x550
>> [   19.273364] lr : __mutex_lock+0x4bc/0x550
>> [   19.277592] sp : ffffffc085c5bbe0
>> [   19.281066] x29: ffffffc085c5bbe0 x28: 0000000000000000 x27: ffffff88009417f8
>> [   19.288624] x26: ffffff8800941788 x25: ffffff8800020008 x24: ffffffc082aa3000
>> [   19.296227] x23: ffffffc080d90e3c x22: 0000000000000002 x21: 0000000000000000
>> [   19.303744] x20: 0000000000000000 x19: ffffff88002f5210 x18: 0000000000000000
>> [   19.311295] x17: 6c707369642e3030 x16: 3030613464662072 x15: 0720072007200720
>> [   19.318922] x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 0000000000000001
>> [   19.326442] x11: 0001ffc085c5b940 x10: 0001ff88003f388b x9 : 0001ff88003f3888
>> [   19.334003] x8 : 0001ff88003f3888 x7 : 0000000000000000 x6 : 0000000000000000
>> [   19.341537] x5 : 0000000000000000 x4 : 0000000000001668 x3 : 0000000000000000
>> [   19.349054] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff88003f3880
>> [   19.356581] Call trace:
>> [   19.359160]  __mutex_lock+0x4bc/0x550
>> [   19.363032]  mutex_lock_nested+0x24/0x30
>> [   19.367187]  drm_bridge_hpd_notify+0x2c/0x6c
>> [   19.371698]  zynqmp_dp_hpd_work_func+0x44/0x54
>> [   19.376364]  process_one_work+0x3ac/0x988
>> [   19.380660]  worker_thread+0x398/0x694
>> [   19.384736]  kthread+0x1bc/0x1c0
>> [   19.388241]  ret_from_fork+0x10/0x20
>> [   19.392031] irq event stamp: 183
>> [   19.395450] hardirqs last  enabled at (183): [<ffffffc0800b9278>] finish_task_switch.isra.0+0xa8/0x2d4
>> [   19.405140] hardirqs last disabled at (182): [<ffffffc081ad3754>] __schedule+0x714/0xd04
>> [   19.413612] softirqs last  enabled at (114): [<ffffffc080133de8>] srcu_invoke_callbacks+0x158/0x23c
>> [   19.423128] softirqs last disabled at (110): [<ffffffc080133de8>] srcu_invoke_callbacks+0x158/0x23c
>> [   19.432614] ---[ end trace 0000000000000000 ]---
>>
>> Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>>   drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
>> index 88eb33acd5f0..639fff2c693f 100644
>> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
>> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
>> @@ -256,12 +256,11 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>>       if (ret)
>>           goto err_dp;
>>   +    drm_bridge_add(dpsub->bridge);
>>       if (dpsub->dma_enabled) {
>>           ret = zynqmp_dpsub_drm_init(dpsub);
>>           if (ret)
>>               goto err_disp;
>> -    } else {
>> -        drm_bridge_add(dpsub->bridge);
>>       }
>>         dev_info(&pdev->dev, "ZynqMP DisplayPort Subsystem driver probed");
>> @@ -288,9 +287,8 @@ static void zynqmp_dpsub_remove(struct platform_device *pdev)
>>         if (dpsub->drm)
>>           zynqmp_dpsub_drm_cleanup(dpsub);
>> -    else
>> -        drm_bridge_remove(dpsub->bridge);
>>   +    drm_bridge_remove(dpsub->bridge);
>>       zynqmp_disp_remove(dpsub);
>>       zynqmp_dp_remove(dpsub);
>>   
> 
> I sent a similar patch:
> 
> https://lore.kernel.org/all/20240312-xilinx-dp-lock-fix-v1-1-1698f9f03bac@ideasonboard.com/
> 
> I have the drm_bridge_add() call in zynqmp_dp_probe(), as that's where the bridge is set up, so it felt like a logical place. You add it later, just before the bridge is used the first time.
> 
> I like mine a bit more as it has all the bridge code in the same place, but I also wonder if there might be some risks in adding the bridge early (before zynqmp_disp_probe()), although I can't see any issue right away...
> 
> In any case, as this works for me too:
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
>  Tomi
> 
Can someone pick up this fix before the release? I am still running into this bug on linux-next/master.

--Sean

