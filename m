Return-Path: <linux-kernel+bounces-156788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE978B082D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9871BB212C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECDE15A491;
	Wed, 24 Apr 2024 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jJSeSyGt"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8D8152E0B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957275; cv=none; b=Ot2UBGYn34sJcb7+GEswzyiFc8MARPcCcwbGmhOT/ZrCaQmyd3YJJaZXb+0czT/uRwkzUgzuw95pbxoIhmaGwnPh65i9a+Gdes4ZPjp28FyQo81AHPOJ9ctTXZxf7xjC2zvaaiQNIBmBzuocU4gtFMZMYPdGdocGxX8rWr7kHDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957275; c=relaxed/simple;
	bh=nk2KxyugWmWO8/K8ORBnXEGAjgPl9wDphXRsl20uXOQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NJ2GONDfM2MA/CdRr/zndScoi7Gg1HkRRWW5E0cwMdnmUls6c5bcoRZEdbLlG2hPZoYIyH3wBjrLlPf+Qa/57X7ptvbMJJeiNmerwbPIfYopGort+ylq8VU48rMtSfXCVdTdLGbiYLPk+Rbc3ICGrNxiEOmxrA5Pu9bHE1c9GKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jJSeSyGt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41aa2f6ff01so16797125e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713957271; x=1714562071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltMWs5vRKAEZzTN8eLbo/CaiCpuGi0nU3bBtsdiJYBQ=;
        b=jJSeSyGto/V63YNQxxp1O1Sicn5ccWfxg9JlcETBsHlQgd/DP/RcTQojKKZCPre6Oq
         DlPQJbdE59ej/nNcyH0zZfurNTi2yFC/p+TcOtxRIk7s8HQSrvl9lfXaS44uJNINVAwI
         gybfrQa4+luWEpUQudP79/aL0gVBB+pba3ekWLLo1bw78B7aSnI9dRajgmqoQOQFZc7N
         95H9cQvbYTXXMEXsdYAV2rwXJ1OZbQyTOzgq0W0Ij8fK5o9zSmmu8IRVS0IoPYcj7EtJ
         AVygLHLQENMY67CyXrFQ7PYHSnNSYdK0T90qV9mLDl/oWHJrkwfWoZTXV8rIeE/mg4wI
         kcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713957271; x=1714562071;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltMWs5vRKAEZzTN8eLbo/CaiCpuGi0nU3bBtsdiJYBQ=;
        b=OGckpWZyTKVqReC361DG7C7j0zaHhuZh64733CTkbGuqJZ2vAZ0mgFMDqP18mc1Bnp
         TQNggcCAC3/T58mdUeuOXIlnBvwb4uhqIs299lFirZGZOcxes7YBXqtebuOzWM2fo4A2
         ds8EWnPIdWRtpPG+zlYd0Mu8zPrubv4FMjqHn6omYRCCOYNwDXxmaR+a7Brqo2QwXNo0
         2VMOyKqnXulD/zv6NP6NN4S9Q08JamqsS9hHKD/x+LMd2aE6RgwwiEX/Pjcm7XUr+Jw2
         qCuhcX9KF4JADFgwNEm1wnDjoL3HcV4MepLucB6sWMFlKK73PKnpV1iOsa3up7yj24/9
         FOkg==
X-Forwarded-Encrypted: i=1; AJvYcCX3gd3Yv2rkhuitSrnmBZJOgXZF/KeDVu6XQVBfhI59UJ47EljKpC3CNN3Ij2xbwk9Llg2rFb3PnnZHS1xqTeshgplJ1Qjs+GV2ejvl
X-Gm-Message-State: AOJu0Yxx8hkCXi9L9/nz/Dn/tS/qEZ9953xQVAM6IArFlfx+2K/FY47U
	Io/BveiPjv2thGuywfXVPX7HrMZJowBJWL+vjILvQ34zdEUvG60NhPgKPcEc1kI=
X-Google-Smtp-Source: AGHT+IE/C0L+29QYZm0cbbUKjIoMbxv529O5ACPPWiOR4dDxxX8aZYQdv6fXmf0X8Hy7WdajhXYuLg==
X-Received: by 2002:a05:600c:4f0d:b0:41a:14f9:dcee with SMTP id l13-20020a05600c4f0d00b0041a14f9dceemr1659996wmq.21.1713957271320;
        Wed, 24 Apr 2024 04:14:31 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b00418a6d62ad0sm27290070wmq.34.2024.04.24.04.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:14:30 -0700 (PDT)
Message-ID: <2d674a18-006f-4182-bc85-bcfa50615495@tuxon.dev>
Date: Wed, 24 Apr 2024 14:14:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v8 09/10] watchdog: rzg2l_wdt: Power on the PM
 domain in rzg2l_wdt_restart()
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 geert+renesas@glider.be, magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFqq+gMDHx_-g-j9rO3nBDcXRSoXRjJK9D51=VaQ5XaGvw@mail.gmail.com>
 <af9c6747-120e-48c1-8c04-9594c9b49666@tuxon.dev>
In-Reply-To: <af9c6747-120e-48c1-8c04-9594c9b49666@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ulf,

On 12.04.2024 17:02, claudiu beznea wrote:
> Hi, Ulf,
> 
> On 12.04.2024 14:14, Ulf Hansson wrote:
>> On Wed, 10 Apr 2024 at 16:19, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> The rzg2l_wdt_restart() is called from atomic context. Calling
>>> pm_runtime_{get_sync, resume_and_get}() or any other runtime PM resume
>>> APIs is not an option as it may lead to issues as described in commit
>>> e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'")
>>> that removed the pm_runtime_get_sync() and used directly the
>>> clk_prepare_enable() APIs.
>>>
>>> Starting with RZ/G3S the watchdog could be part of its own software
>>> controlled power domain (see the initial implementation in Link section).
>>> In case the watchdog is not used the power domain is off and accessing
>>> watchdog registers leads to aborts.
>>>
>>> To solve this the patch powers on the power domain using
>>> dev_pm_genpd_resume() API before enabling its clock. This is not
>>> sleeping or taking any other locks as the power domain will not be
>>> registered with GENPD_FLAG_IRQ_SAFE flags.
>>>
>>> Link: https://lore.kernel.org/all/20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> ---
>>>
>>> Changes in v8:
>>> - none, this patch is new
>>>
>>>  drivers/watchdog/rzg2l_wdt.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
>>> index c8c20cfb97a3..98e5e9914a5d 100644
>>> --- a/drivers/watchdog/rzg2l_wdt.c
>>> +++ b/drivers/watchdog/rzg2l_wdt.c
>>> @@ -12,6 +12,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/of.h>
>>>  #include <linux/platform_device.h>
>>> +#include <linux/pm_domain.h>
>>>  #include <linux/pm_runtime.h>
>>>  #include <linux/reset.h>
>>>  #include <linux/units.h>
>>> @@ -164,6 +165,17 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>>>         struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>>>         int ret;
>>>
>>> +       /*
>>> +        * The device may be part of a power domain that is currently
>>> +        * powered off. We need to power it up before accessing registers.
>>> +        * We don't undo the dev_pm_genpd_resume() as the device need to
>>> +        * be up for the reboot to happen. Also, as we are in atomic context
>>> +        * here there is no need to increment PM runtime usage counter
>>> +        * (to make sure pm_runtime_active() doesn't return wrong code).
>>> +        */
>>> +       if (!pm_runtime_active(wdev->parent))
>>> +               dev_pm_genpd_resume(wdev->parent);
>>> +
>>
>> I doubt this is the correct solution, but I may be wrong. Unless this
>> is invoked at the syscore stage?
> 
> On my case I see it invoked from kernel_restart(). As of my code reading,

With the above explanations, do you consider calling dev_pm_genpd_resume()
here is still wrong?

Do you have any suggestions I could try?

Thank you,
Claudiu Beznea

> at that point only one CPU is active with IRQs disabled (done in
> machine_restart()). Below is the stack trace decoded on next-20240410 with
> this series
> (https://lore.kernel.org/all/20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com/)
> on top and the one from here (adding power domain support):
> https://lore.kernel.org/all/20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com/
> 
> Hardware name: Renesas SMARC EVK version 2 based on r9a08g045s33 (DT)
> Call trace:
> dump_backtrace (arch/arm64/kernel/stacktrace.c:319)
> show_stack (arch/arm64/kernel/stacktrace.c:326)
> dump_stack_lvl (lib/dump_stack.c:117)
> dump_stack (lib/dump_stack.c:124)
> rzg2l_wdt_restart (drivers/watchdog/rzg2l_wdt.c:180)
> watchdog_restart_notifier (drivers/watchdog/watchdog_core.c:188)
> atomic_notifier_call_chain (kernel/notifier.c:98 kernel/notifier.c:231)
> do_kernel_restart (kernel/reboot.c:236)
> machine_restart (arch/arm64/kernel/process.c:145)
> kernel_restart (kernel/reboot.c:287)
> __do_sys_reboot (kernel/reboot.c:755)
> __arm64_sys_reboot (kernel/reboot.c:715)
> invoke_syscall (arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/syscall.c:53)
> el0_svc_common.constprop.0 (include/linux/thread_info.h:127
> arch/arm64/kernel/syscall.c:141)
> do_el0_svc (arch/arm64/kernel/syscall.c:153)
> el0_svc (arch/arm64/include/asm/irqflags.h:56
> arch/arm64/include/asm/irqflags.h:77 arch/arm64/kernel/entry-common.c:165
> arch/arm64/kernel/entry-common.c:178 arch/arm64/kernel/entry-common.c:713)
> el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:731)
> el0t_64_sync (arch/arm64/kernel/entry.S:598)
> 
> The watchdog restart handler is added in restart_handler_list and this list
> is invoked though do_kernel_restart(). As of my code investigation the
> restart_handler_list is invoked only though do_kernel_restart() and only
> though the stack trace above.
> 
> Thank you,
> Claudiu Beznea
> 
>>
>>>         clk_prepare_enable(priv->pclk);
>>>         clk_prepare_enable(priv->osc_clk);
>>>
>>> --
>>> 2.39.2
>>>
>>>
>>
>> Can you redirectly me to the complete series, so I can have a better
>> overview of the problem?
> 
> This is the series that adds power domain support for RZ/G3S SoC:
> https://lore.kernel.org/all/20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com/
> 
> This is the series that adds watchdog support for RZ/G3S SoC:
> https://lore.kernel.org/all/20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com/
> 
> Thank you for your review,
> Claudiu Beznea
> 
>>
>> Kind regards
>> Uffe

