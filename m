Return-Path: <linux-kernel+bounces-135693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BE689C9CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA99F28AA43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE84142E6C;
	Mon,  8 Apr 2024 16:38:04 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225E142645;
	Mon,  8 Apr 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594283; cv=none; b=ZEgsmDFh51gZEWRTtjdG40sOmOhYyi17hQs9L24JiFVCJRrOOzosySXJDQSsEd4LwCbhVDb+m8HyojHlqXp6aCs4zFICgaIjamkS+LdaQEzXbR0pXGK9qw0KcJ4mV1L7d+8J7zQnNTSxlxs2FPQgFSc0Z9OnsJYfaJOGf/4MKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594283; c=relaxed/simple;
	bh=tHxJ3krplcWnanw+f2gs+vuLQSJPq5GNtNrhO6CiBXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqIWgjiVOb9mjkdblnx2OQ1EIOmCF2n4U+9I3A2mPr8KSGzCgs+dWdzYU4IQUq+1924BVGy5hKy6k8edX9s9HYF4BEA1gSmCBT+O+IGPdWbPratfjr5F04C/0Mdfa4I4gWz0l33y6z6isyiJEm3WVmLn+SNVv+uzTuUSHvd+JOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af0ad.dynamic.kabel-deutschland.de [95.90.240.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2DF9361E5FE01;
	Mon,  8 Apr 2024 18:37:23 +0200 (CEST)
Message-ID: <bd4bdabc-2d83-4022-87f4-8c599009d9f5@molgen.mpg.de>
Date: Mon, 8 Apr 2024 18:37:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not part
 of current TD ep_index 1 comp_code 1
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
 =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <58bca6f2-797a-4e20-a476-2294309afdd5@molgen.mpg.de>
 <20240405113247.743e34b2@foxbook>
 <7090d3af-18ce-40e1-8ac2-bf18152e5c4a@molgen.mpg.de>
 <20240406183659.3daf4fa0@foxbook>
 <c57f2116-8c42-44fb-9c32-6115ad88f914@molgen.mpg.de>
 <20240407142542.036fb02f@foxbook>
 <1f64af9a-0618-a7da-4acc-f043b6580308@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1f64af9a-0618-a7da-4acc-f043b6580308@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mathias, dear Michał,


Thank you very much for your assistance.


Am 08.04.24 um 09:17 schrieb Mathias Nyman:
> On 7.4.2024 15.25, Michał Pecio wrote:
>> This (and the absence of any earlier errors on the endpoint) looks
>> like the hardware may be confirming a "successful" transfer twice or
>> the driver may be processing one such confirmation twice.
> 
> It's also possible this TD/TRB was cancelled due to the disconnect.
> Could be that even if driver removes the TD from the list and cleans out 
> the TRB from the ring buffer (turns TRB to no-op) hardware may have read
> ahead and cached the TRB, and process it anyway.
> 
>> [   94.088594] usb 1-2: USB disconnect, device number 8
>> [   94.089370] xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 1 comp_code 1
>> [   94.089403] xhci_hcd 0000:00:14.0: Looking for event-dma 00000001250310f0 trb-start 0000000125031100 trb-end 0000000125031100 seg-start 0000000125031000 seg-end 0000000125031ff0
>> [   94.089427] xhci_hcd 0000:00:14.0: last xhci_td_cleanup: first_dma 1250310f0 last_dma 1250310f0 status -115 from finish_td
>>
>> (I say "successful" but it really isn't - the device is no longer
>> listening. But there is no delivery confirmation on isochronous OUT
>> endpoints so the xHC doesn't suspect anything.)
>>
>> Could you try again with this updated debug patch to get more info?
> 
> Would also be helpful to add xhci dynamic debug and xhci tracing (two 
> separate logs). These will show in detail everything that is going on.
> 
> Steps:
> 
> mount -t debugfs none /sys/kernel/debug
> echo 'module xhci_hcd =p' >/sys/kernel/debug/dynamic_debug/control
> echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control
> echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
> echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
> echo 1 > /sys/kernel/debug/tracing/tracing_on
> < Reproduce issue >
> Send output of dmesg
> Send content of /sys/kernel/debug/tracing/trace
> 
> please copy the /sys/kernel/debug/tracing/trace file somewhere as soon
> as possible after reproducing the issue. It grows fast.

For posterity I created Linux Kernel Bugzilla issue #218695 [1], and 
attached the files there. Hopefully everything was captured, that you 
need. The discussion could continue on this list, but do as it suits you 
best.


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218695

