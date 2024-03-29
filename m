Return-Path: <linux-kernel+bounces-125077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C58892114
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5869CB30A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532141465B8;
	Fri, 29 Mar 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="pnxVq16l"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF891C0DF1;
	Fri, 29 Mar 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720317; cv=none; b=TtPfBZRl0GTZwCSvrbDwTJDcNRliSDwvF/DAg4C/QGADMtIJ0pbYspj37p4HUqT7HZsNMCNL7PU4+UxUZBvrJ3YFSFfNfs0o3H3+xhdZQxD3xz1x7XGUCwRyRgsgsXwP5LXy0C5JVIVDWU3hY3QLAnhY8xWgBu7Fq9hdO9C1jy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720317; c=relaxed/simple;
	bh=1CtEIoW5Had2QClPgeyy73NMyNE2vfzEvp6rwVupVy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsY8Z30U3YSPmylknW2uxART9nBy2lEkIkBHB1TDBIoV0WK+GKVb4PQLsQjX2qLyZgPo62DmBLDA9jxjhKBSbqB791Wx4f5oEwZiXeV+NwHg1TQH3sRih4+Wnnur0PGBeoGUymVB4pgeX4nUg6Sa0Ti72QA2CBFnfTG7kcSH9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=pnxVq16l; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=alXGIJuT49Qp7PxLLBHbTD5jAobwVRz5/+8YtYzfgt0=;
	t=1711720315; x=1712152315; b=pnxVq16l1hp8mJs8kpmu42j+TltxDSKbXlVKtgzWcMWVmyy
	vyVxqKenFSkOm6c2huPnzCRaWep7vdvL4qahX+qdlz0dfp4rQ2cXTE3FSs6xIU6+x5WpuiQe6ZXSD
	njzgrDkhofXOJhQwWTq6EotYeFMaSew4JIuYr5kETsVCOT8g967xmtYEedoSypGrUKY+8CBdPUDfu
	xJMvVp20tjRM5+sG2mKF5B7TYswCZ1QgrfuDDED/Gh3q4XFGYfwbIA6qm8BcgOPmWWVgK1FJ2zUko
	bhBVQf8TXceQ0v+8LVXbokifaIFzF2w+VBN2xRgzI5HR4Jg4qn3jvDLMZNVELWvw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rqCe3-0000RK-QN; Fri, 29 Mar 2024 14:51:47 +0100
Message-ID: <1198933e-bf89-4237-a6e8-f7daeeebf885@leemhuis.info>
Date: Fri, 29 Mar 2024 14:51:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/1] platform/x86/intel/hid: Don't wake on 5-button
 releases
To: David McFarland <corngood@gmail.com>, Chris Feng <chris.feng@mediatek.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Alex Hung <alexhung@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-pm@vger.kernel.org
References: <20240318191153.6978-1-corngood@gmail.com>
 <20240318191153.6978-2-corngood@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240318191153.6978-2-corngood@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711720315;987166c3;
X-HE-SMSGID: 1rqCe3-0000RK-QN

[CCing Chris, who authored the culprit; also CCing the platform folks
and a few lists]

On 18.03.24 20:11, David McFarland wrote:
> If, for example, the power button is configured to suspend, holding it
> and releasing it after the machine has suspended, will wake the machine.

David, from here is looks like this is stalled for ten days now. Or was
there some progress and I just missed it?

> Also on some machines, power button release events are sent during
> hibernation, even if the button wasn't used to hibernate the machine.
> This causes hibernation to be aborted.

From the cover letter[1] is sounds a lot like a "Fixes: 0c4cae1bc00d31
("PM: hibernate: Avoid missing wakeup events during hibernation")" would
be appropriate here.

Regarding the patch itself: hopefully this mail will get things moving.

[1]
https://lore.kernel.org/linux-pm/20240318191153.6978-1-corngood@gmail.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> Signed-off-by: David McFarland <corngood@gmail.com>
>> ---
>  drivers/platform/x86/intel/hid.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
> index 7457ca2b27a6..707de9895965 100644
> --- a/drivers/platform/x86/intel/hid.c
> +++ b/drivers/platform/x86/intel/hid.c
> @@ -504,6 +504,7 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>  	struct platform_device *device = context;
>  	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
>  	unsigned long long ev_index;
> +	struct key_entry *ke;
>  	int err;
>  
>  	/*
> @@ -545,11 +546,16 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>  		if (event == 0xc0 || !priv->array)
>  			return;
>  
> -		if (!sparse_keymap_entry_from_scancode(priv->array, event)) {
> +		ke = sparse_keymap_entry_from_scancode(priv->array, event);
> +
> +		if (!ke) {
>  			dev_info(&device->dev, "unknown event 0x%x\n", event);
>  			return;
>  		}
>  
> +		if (ke->type == KE_IGNORE)
> +			return;
> +
>  wakeup:
>  		pm_wakeup_hard_event(&device->dev);
>  

