Return-Path: <linux-kernel+bounces-56010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F56A84C4E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0159289DFD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753F81CFB2;
	Wed,  7 Feb 2024 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a3d45aJ4"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB011CFB9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286754; cv=none; b=B2ib0bjDAQyP77/Vu2ygX08t2hamP3qIVD7JolxiMrKs9WyO2nvFu43MIRBF/ssTTEfc7MX6HAVrkza1sPNuZgZAxQDrjWddnKqjdNs1ksXMJqmi/1atzpqYFtec7JemqTL5fIp5YIQ4ywY7LK0AOCEwmABd9munakOS+SAgCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286754; c=relaxed/simple;
	bh=h6+bbngOw6Ohz7LqsUDrGXlKkg4OzH+vEbsYAMm1fic=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hAiJsk9lTw4GIV1KmBcV/lQZ3fJ14YCCRkcmdAy48y/THZbswmfHs99XaUZ4uklcTXDvzWNlvFrCF9vsONnw8+pWJRMYO3WQNFrRifSwUXENP02ZF+HF+cidkSmR1YWYYuRmAF77NkOs32kddwHlk9H2L5gJIia3UZJvNEa6ltM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a3d45aJ4; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707286749; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=7SrCJEJUbgaaO8LSY+S0f3ku7YdljvxpwznRF4B58Ig=;
	b=a3d45aJ4HCb10DXaoslLB/5weQINaXdQn/O0C5lGgkGKEph2Xg+/4WiH8EvTcEhllA5lsXkqvTk0r1GWwpKM/eCQq79p1o7+pmXK2eA/WeNdJQ7YzFTOboo2dev0laaLmLSP5USo3v/QddDYTJHnXdaQebOA1KN0hpMdtocIzpw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0Fmdax_1707286737;
Received: from 192.168.0.104(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W0Fmdax_1707286737)
          by smtp.aliyun-inc.com;
          Wed, 07 Feb 2024 14:19:09 +0800
Message-ID: <92a6e940-560d-4a61-bfcd-27a2df369b0f@linux.alibaba.com>
Date: Wed, 7 Feb 2024 14:19:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCHv5 3/3] watchdog/softlockup: add
 SOFTLOCKUP_DETECTOR_INTR_STORM Kconfig knob
To: Doug Anderson <dianders@chromium.org>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com,
 liusong@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yaoma@linux.alibaba.com
References: <20240206095902.56406-1-yaoma@linux.alibaba.com>
 <20240206095902.56406-4-yaoma@linux.alibaba.com>
 <CAD=FV=XtZvgv8_gceKF0zztOv-yk7_0Kd19M93sWFqu-DF9V1Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAD=FV=XtZvgv8_gceKF0zztOv-yk7_0Kd19M93sWFqu-DF9V1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/7 05:42, Doug Anderson wrote:
> Hi,
> 
> On Tue, Feb 6, 2024 at 1:59 AM Bitao Hu <yaoma@linux.alibaba.com> wrote:
>>
>> The interrupt storm detection mechanism we implemented requires a
>> considerable amount of global storage space when configured for
>> the maximum number of CPUs.
>> Therefore, adding a SOFTLOCKUP_DETECTOR_INTR_STORM Kconfig knob that
>> defaults to "yes" if the max number of CPUs is <= 128.
>>
>> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
>> ---
>>   kernel/watchdog.c |  2 +-
>>   lib/Kconfig.debug | 13 +++++++++++++
>>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> IMO this should be squashed into patch #1, though I won't insist.
Agree.
> 
> 
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 26dc1ad86276..1595e4a94774 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -338,7 +338,7 @@ __setup("watchdog_thresh=", watchdog_thresh_setup);
>>
>>   static void __lockup_detector_cleanup(void);
>>
>> -#ifdef CONFIG_IRQ_TIME_ACCOUNTING
>> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM
>>   #define NUM_STATS_GROUPS       5
>>   #define NUM_STATS_PER_GROUP    4
>>   enum stats_per_group {
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 975a07f9f1cc..74002ba7c42d 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1029,6 +1029,19 @@ config SOFTLOCKUP_DETECTOR
>>            chance to run.  The current stack trace is displayed upon
>>            detection and the system will stay locked up.
>>
>> +config SOFTLOCKUP_DETECTOR_INTR_STORM
>> +       bool "Detect Interrupt Storm in Soft Lockups"
>> +       depends on SOFTLOCKUP_DETECTOR && IRQ_TIME_ACCOUNTING
>> +       default y if NR_CPUS <= 128
>> +       help
>> +         Say Y here to enable the kernel to detect interrupt storm
>> +         during "soft lockups".
>> +
>> +         "soft lockups" can be caused by a variety of reasons. If one is caused by
>> +         an interrupt storm, then the storming interrupts will not be on the
>> +         callstack. To detect this case, it is necessary to report the CPU stats
>> +         and the interrupt counts during the "soft lockups".
> 
> It's probably not terribly important, but I notice that the other help
> text in this file is generally wrapped to 80 columns. Even though the
> kernel has relaxed the 80 column rule a bit, it still feels like this
> could easily be wrapped to 80 columns without sacrificing any
> readability.
OK.
> 
> In any case:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

