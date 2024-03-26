Return-Path: <linux-kernel+bounces-119271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E040B88C66B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF541C27DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FDB13C698;
	Tue, 26 Mar 2024 15:12:38 +0000 (UTC)
Received: from out0-206.mail.aliyun.com (out0-206.mail.aliyun.com [140.205.0.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8BB1CAA5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465958; cv=none; b=H7eWbG0/Z8vxsoOZFAnu9Wpws9UM27phr+bOO4iQynkXpgNpyx7M2FNfLgCAkpSGtxVfCxoOvwDoaPehI5tlsvsV1Uffy2Sf3rzc++wiCplaOK3+WZgkOtahWcPfxDg3dTqp2GFLxRHMiPNh93R/1KNWlnxzDhtueynQAJhzVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465958; c=relaxed/simple;
	bh=MYV9TzwGRyjDceakpJ5Cs2ISDl1dg5au4U578vK7RFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIs2Ohzh+vzFh3JjMnWJFhiOEZ7gYimgRoMe8lHQD8bu5yIO+bwGzwnX+HSD17BFJmEuK7XMa30imx6RWmzuOSpkgLAgloCsycz4YpNNnYwnOtO0lwPhGlDLlK8iqEZKQC0Y76quhB3P2KYX/k9Aaz7qxkFp8CNe8qcaE3ybRVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047209;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.WwaCo0l_1711465551;
Received: from 30.39.128.129(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WwaCo0l_1711465551)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 23:07:11 +0800
Message-ID: <9e396277-f742-41d7-be82-290c0b2368d2@antgroup.com>
Date: Tue, 26 Mar 2024 23:07:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] um: Minor fixes and cleanups
Content-Language: en-US
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, jani.nikula@intel.com,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
 <fbd44e8a-713b-4e66-9241-e18fc78c9168@antgroup.com>
 <zhm2eyo5hy6wta5ga6zqgg546q2atjekdxoivksht2kdrqppoy@6ck7iwpfxidr>
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <zhm2eyo5hy6wta5ga6zqgg546q2atjekdxoivksht2kdrqppoy@6ck7iwpfxidr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/26/24 10:16 PM, Lucas De Marchi wrote:
> On Tue, Mar 26, 2024 at 08:27:25PM +0800, Tiwei Bie wrote:
>> Hi,
>>
>> Gentle ping.. Please take a look at this series if possible. The changes
>> in this series are very straightforward, so it shouldn't require much effort
>> to review. But they cover a wide area, making them prone to conflicts
>> with other patches :/, e.g.
>>
>> https://lore.kernel.org/linux-um/20240326073750.726636-1-surenb@google.com/T/#u
>>
>> Sorry to be impatient, but pinging this. This series was originally posted
>> two months ago, and hasn't received a review yet. Just want to make sure that
>> this series is not lost..
>>
>> PS. I have tested this series on both of 64bit and 32bit platforms manually.
>> There is also a CI test report from patchwork@emeril.freedesktop.org:
>>
>> https://lore.kernel.org/all/87bk7rzj70.fsf@intel.com/
> 
> 
> yeah, it's a clear improvement.
> 
> For patches 1-5 and 7, feel free to add my Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
> I commented on patch 8 as I'm not sure it's the right approach and same
> thing applies to patch 9.  Patch 6 I'm just not sure as it's the first
> time I see that file, so I will leave it to others.

Thanks for the review! I do appreciate it. :)

Regards,
Tiwei

> 
> thanks
> Lucas De Marchi
> 
>>
>> Thanks,
>> Tiwei
>>
>> On 3/6/24 6:19 PM, Tiwei Bie wrote:
>>> A series of minor fixes and cleanups for UML.
>>>
>>> Most changes in this series are very straightforward. Please consider
>>> picking this series for v6.9.
>>>
>>> There are still some remaining -Wmissing-prototypes warnings. I plan to
>>> send a followup RFC series first to fix those warnings.
>>>
>>> Feedbacks on this series would be appreciated. Thanks!
>>>
>>> Changes since v2:
>>> https://lore.kernel.org/lkml/20240205114708.25235-1-tiwei.btw@antgroup.com/
>>> - Add "um: Move declarations to proper headers";
>>> - Add "um: Fix -Wmissing-prototypes warnings for text_poke*";
>>> - Add "um: Fix -Wmissing-prototypes warnings for __warp_* and foo";
>>> - Make do_set_thread_area() static;
>>> - Add the missing header for calibrate_delay_is_known;
>>>
>>> Tiwei Bie (9):
>>>   um: Make local functions and variables static
>>>   um: Fix the declaration of vfree
>>>   um: Remove unused functions
>>>   um: Fix the return type of __switch_to
>>>   um: Add missing headers
>>>   um: Stop tracking host PID in cpu_tasks
>>>   um: Move declarations to proper headers
>>>   um: Fix -Wmissing-prototypes warnings for text_poke*
>>>   um: Fix -Wmissing-prototypes warnings for __warp_* and foo
>>>
>>>  arch/um/drivers/pcap_kern.c                |  4 +-
>>>  arch/um/drivers/ubd_user.c                 |  2 +-
>>>  arch/um/include/asm/ptrace-generic.h       |  3 ++
>>>  arch/um/include/shared/as-layout.h         |  1 -
>>>  arch/um/include/shared/kern_util.h         |  1 +
>>>  arch/um/include/shared/um_malloc.h         |  2 +-
>>>  arch/um/kernel/kmsg_dump.c                 |  2 +-
>>>  arch/um/kernel/mem.c                       |  2 +
>>>  arch/um/kernel/physmem.c                   |  3 +-
>>>  arch/um/kernel/process.c                   | 48 +++++-----------------
>>>  arch/um/kernel/ptrace.c                    |  3 --
>>>  arch/um/kernel/reboot.c                    |  1 +
>>>  arch/um/kernel/skas/mmu.c                  |  1 +
>>>  arch/um/kernel/skas/process.c              |  5 +--
>>>  arch/um/kernel/time.c                      |  7 ++--
>>>  arch/um/kernel/tlb.c                       |  7 +---
>>>  arch/um/kernel/um_arch.c                   |  1 +
>>>  arch/um/kernel/um_arch.h                   |  2 +
>>>  arch/um/os-Linux/drivers/ethertap_kern.c   |  2 +-
>>>  arch/um/os-Linux/drivers/tuntap_kern.c     |  2 +-
>>>  arch/um/os-Linux/main.c                    |  5 +++
>>>  arch/um/os-Linux/signal.c                  |  4 +-
>>>  arch/um/os-Linux/start_up.c                |  1 +
>>>  arch/x86/um/asm/ptrace.h                   |  6 +++
>>>  arch/x86/um/bugs_32.c                      |  1 +
>>>  arch/x86/um/bugs_64.c                      |  1 +
>>>  arch/x86/um/elfcore.c                      |  1 +
>>>  arch/x86/um/fault.c                        |  1 +
>>>  arch/x86/um/os-Linux/mcontext.c            |  1 +
>>>  arch/x86/um/os-Linux/registers.c           |  2 +-
>>>  arch/x86/um/os-Linux/tls.c                 |  1 +
>>>  arch/x86/um/ptrace_32.c                    |  2 -
>>>  arch/x86/um/shared/sysdep/kernel-offsets.h |  3 ++
>>>  arch/x86/um/tls_32.c                       |  2 +-
>>>  arch/x86/um/user-offsets.c                 |  3 ++
>>>  35 files changed, 63 insertions(+), 70 deletions(-)
>>>
>>


