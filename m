Return-Path: <linux-kernel+bounces-93834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F73387355D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E50B22201
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3323762D9;
	Wed,  6 Mar 2024 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E5jsxhP5"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40407745E0;
	Wed,  6 Mar 2024 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723379; cv=none; b=mQKGJ7wDZytwukixb98SXrN8vWvEhllBvz82K9V5ku2Vjv9vQ+u8/5WMZVEBC9welZfA9pDhejqV7D3rxRpsZLMjWlGcJZregRBsNrNDyWYKOOjm5wvij7BydFhlOE3W857ruSOl54rXjthgDdq1u9TlJx+TW55ssEmbT0vbgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723379; c=relaxed/simple;
	bh=bsqrALh0inF+TFlRsJEQnmW6pnmcqBx2LnKvjJAweAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltNQfIpUAF0qLCUmYUxFA0e+GRSYpNUtGqdFECgZHomQrQFRO4WNjH8LFTw+MtWOCfG2OQFdetNQCYjwLr6k95to9WPvTem4weQOFpsa42HHTFsx/0ENRW42yGuOuM6iQQ5HmMuyLUhZ3n1lIrnOyqCYsqd9OzthV6y5OJ++gV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E5jsxhP5; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709723373; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ceV/dYyY4lcQMo0rvtqY++7MI8S81r5Jn7ui5rksdP4=;
	b=E5jsxhP5C/OA6D8VQ9/QQVnVv3DdiyN3eQnRcxkX6GJ7r/JxUTj3RCXzwtTUmhvOGZtnbt69n/b0RGqeL93kA5sHsr9HU0CD4gZMpjU2p7ofVycDyax3kwIdTu4fTSZqohwsx2q1jhEdfNKfI9e0cYZVqRGBXHDbMW+QjUR2pPE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W1xQ1s7_1709723370;
Received: from 30.178.67.110(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W1xQ1s7_1709723370)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 19:09:32 +0800
Message-ID: <5ab46413-5810-475a-b8c1-3c9b142ea35c@linux.alibaba.com>
Date: Wed, 6 Mar 2024 19:09:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 2/4] genirq: Provide a snapshot mechanism for interrupt
 statistics
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 Doug Anderson <dianders@chromium.org>
Cc: liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
 jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, yaoma@linux.alibaba.com
References: <20240228072216.95130-1-yaoma@linux.alibaba.com>
 <20240228072216.95130-3-yaoma@linux.alibaba.com>
 <CAD=FV=U1b+8atmju_w4eRmVKmSqjj6WCsy5EawYqj31fQ1kvrw@mail.gmail.com>
 <87plwdwycx.ffs@tglx>
 <3a89fafb-f62e-472f-b40b-8bf97954e9e3@linux.alibaba.com>
 <87wmqiulaw.ffs@tglx>
 <28a24e4b-c322-4631-ad6d-7259ca3d084d@linux.alibaba.com>
 <87h6hkvcor.ffs@tglx>
From: Bitao Hu <yaoma@linux.alibaba.com>
In-Reply-To: <87h6hkvcor.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/3/6 00:57, Thomas Gleixner wrote:
> 
>> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
>> index 2531f3496ab6..a28e5ac5fc79 100644
>> --- a/kernel/irq/Kconfig
>> +++ b/kernel/irq/Kconfig
>> @@ -108,6 +108,10 @@ config GENERIC_IRQ_MATRIX_ALLOCATOR
>>    config GENERIC_IRQ_RESERVATION_MODE
>>           bool
>>
>> +# Snapshot for interrupt statistics
>> +config GENERIC_IRQ_STAT_SNAPSHOT
>> +       bool
>> +
>>    # Support forced irq threading
>>    config IRQ_FORCED_THREADING
>>           bool
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 49f652674bd8..899b69fcb598 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1032,6 +1032,7 @@ config SOFTLOCKUP_DETECTOR
>>    config SOFTLOCKUP_DETECTOR_INTR_STORM
>>           bool "Detect Interrupt Storm in Soft Lockups"
>>           depends on SOFTLOCKUP_DETECTOR && IRQ_TIME_ACCOUNTING
>> +       select GENERIC_IRQ_STAT_SNAPSHOT
> 
> This goes into the patch which adds the lockup detector parts.
> 

OK, I will implement this in the next version.

Best Regards,
	Bitao Hu

