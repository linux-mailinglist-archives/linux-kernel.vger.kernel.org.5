Return-Path: <linux-kernel+bounces-90167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D4786FB52
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CC61C21B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BF8171BC;
	Mon,  4 Mar 2024 08:08:46 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653E171AF;
	Mon,  4 Mar 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539725; cv=none; b=PLLMEz1Xgq8sA5y0356pwtaR6Nhj+Re0vUnZiAwS0ioS7pz3asqWf/QEK5K4waFaTWlENQKrftb+cJYSl7oAYqxNQqhFZRD5kzMbaWSEIL1kTyJdEA1pd4sjXLWcUS+qJqn+eWCI6iMNn+hl3qmN8o1dJ134Cm9SS1OT+gg1TFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539725; c=relaxed/simple;
	bh=yHwqB2Upd50z2cFRBEvqAhh9bCUpbHfzPJX7IFAjoPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWym2f9jizo9OgmgpauVBQJXe94OS+8fIxI7cGkNX5l/hCByY58Ldz+eePYiiHofuHBUw6njqn6qEdRHRANNmDIsR0wCl2MlKsCfxancRe2io5hz4dZYIUFRpfhMWzfeMeOlbZj9vkYIx3qezOAzgGYnyx6uijrze/PIFgNxY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D51CE0002;
	Mon,  4 Mar 2024 08:08:32 +0000 (UTC)
Message-ID: <79b41dfc-004e-4939-b045-0c320037e584@ghiti.fr>
Date: Mon, 4 Mar 2024 09:08:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Mar 1 (riscv 32-bit)
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>
References: <20240301165705.07d9b52c@canb.auug.org.au>
 <e111f031-1015-4c35-b89b-263f7174431c@infradead.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <e111f031-1015-4c35-b89b-263f7174431c@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Randy,

On 02/03/2024 06:37, Randy Dunlap wrote:
>
> On 2/29/24 21:57, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20240229:
>>
> on riscv 32-bit:
>
> In file included from ../arch/riscv/include/asm/uaccess.h:12,
>                   from ../include/linux/uaccess.h:11,
>                   from ../include/linux/sched/task.h:13,
>                   from ../include/linux/sched/signal.h:9,
>                   from ../include/linux/rcuwait.h:6,
>                   from ../include/linux/percpu-rwsem.h:7,
>                   from ../include/linux/fs.h:33,
>                   from ../kernel/events/core.c:11:
> ../kernel/events/core.c: In function 'perf_get_pgtable_size':
> ../arch/riscv/include/asm/pgtable.h:443:41: error: implicit declaration of function 'napot_cont_size' [-Werror=implicit-function-declaration]
>    443 |                                         napot_cont_size(napot_cont_order(pte)) :\
>        |                                         ^~~~~~~~~~~~~~~
> ../kernel/events/core.c:7588:24: note: in expansion of macro 'pte_leaf_size'
>   7588 |                 size = pte_leaf_size(pte);
>        |                        ^~~~~~~~~~~~~
> ../arch/riscv/include/asm/pgtable.h:443:57: error: implicit declaration of function 'napot_cont_order'; did you mean 'get_count_order'? [-Werror=implicit-function-declaration]
>    443 |                                         napot_cont_size(napot_cont_order(pte)) :\
>        |                                                         ^~~~~~~~~~~~~~~~
> ../kernel/events/core.c:7588:24: note: in expansion of macro 'pte_leaf_size'
>   7588 |                 size = pte_leaf_size(pte);
>        |                        ^~~~~~~~~~~~~
>
>
> Full randconfig file is attached.
>

I missed it because this patch interacts with FAST_GUP support merged in 
for-next. But what this means is that the fix I sent for 6.8-rc7 was not 
needed at all...my bad, sorry.

I have just sent a fix here: 
https://lore.kernel.org/linux-riscv/20240304080247.387710-1-alexghiti@rivosinc.com/T/#u

Thanks,

Alex




