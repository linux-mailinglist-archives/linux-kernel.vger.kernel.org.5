Return-Path: <linux-kernel+bounces-105409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F3787DD81
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671E4B20CF9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272E2F9F0;
	Sun, 17 Mar 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="R9nfu/8W"
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E2634
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710686742; cv=none; b=SX9q+KYgCei/baxBuqhd27OnDhWjZ+ZTrYiwoMPmI3SU6wVoQo8DD0hyby8ZcnicUI8/d6Ef2br+EVPRvm26YX2eLNwVGOg/hGz0jeKtRPWYkUKg1o8OpHC4EmbVEE0pecS3bPePoe8NbknCD88NNYbixV2Is/JDcICOdHJkZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710686742; c=relaxed/simple;
	bh=0LpglAaWdweBNVfbarVRWH2wRkjN+rXBpqwUWjZZTAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VwY8WBDL6AUwtSqGjORe0GzNgGRxsjc2ZMMnotB5RZ3fKJcuUyRV4k9QGm4HP2R6kW+PN1KiEF46bjjugCmw6Q1e5aqzUGMmBNE03neitwY77TAVP0J9h2D/Tp+SaFiRqDGKj/q6ZHeqKQvcWj+JwhXRCosOAFegjLaidytpyT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=R9nfu/8W; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id lrlLrJiu2k8gIlrlMrrLrr; Sun, 17 Mar 2024 15:45:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710686737;
	bh=JFZ1VFuu4hUP4CMuNv45SyAr0XsYYQP18KS2flx8Fps=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=R9nfu/8W4b6JIaUaGKmiF5SCYgPGcXhWXh9SQ9zsBvvFCY7h7vo3P3/w8SFXFSjmE
	 uBm504uEL15KosVsO2o5s/ystqMswMi3o9AKkQMu7ZmYsEo72vPZg+ULRH6dgaVV/w
	 uC0m2dP9PNH43p5XKhNYfgtOxu2/Yxys6/zmHUDCCQsPKKHvWEFFflPhwLOZWWAGSy
	 auTabFtkDZ0q/pGmA0Peg/Mh5cIopoPk4VTS0gLlVb2ZiTBClT7wfHmYSgShLCk3i6
	 D9H31RYsgUuUalCYJexgub00ABbcuZAwW4w6YqHVrU2Hxjrq6VamSteTtVieitucjV
	 /k3EZIurCRXjw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Mar 2024 15:45:37 +0100
X-ME-IP: 92.140.202.140
Message-ID: <0c6974b4-ba1f-474c-aed4-6c06d26ddb0a@wanadoo.fr>
Date: Sun, 17 Mar 2024 15:45:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/14] fork: Remove assumption that vm_area->nr_pages equals
 to THREAD_SIZE
Content-Language: en-MW
To: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de,
 brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
 dave.hansen@linux.intel.com, dianders@chromium.org,
 dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
 hch@infradead.org, hpa@zytor.com, jacob.jun.pan@linux.intel.com,
 jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com,
 kent.overstreet@linux.dev, kinseyho@google.com,
 kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org,
 mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com,
 mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com,
 peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com,
 rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de,
 urezki@gmail.com, vincent.guittot@linaro.org
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-5-pasha.tatashin@soleen.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240311164638.2015063-5-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/03/2024 à 17:46, Pasha Tatashin a écrit :
> In many places number of pages in the stack is detremined via
> (THREAD_SIZE / PAGE_SIZE). There is also a BUG_ON() that ensures that
> (THREAD_SIZE / PAGE_SIZE) is indeed equals to vm_area->nr_pages.
> 
> However, with dynamic stacks, the number of pages in vm_area will grow
> with stack, therefore, use vm_area->nr_pages to determine the actual
> number of pages allocated in stack.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   kernel/fork.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 60e812825a7a..a35f4008afa0 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -243,13 +243,11 @@ static int free_vm_stack_cache(unsigned int cpu)
>   
>   static int memcg_charge_kernel_stack(struct vm_struct *vm)

Maybe s/vm/vm_area/ as done in 03/14?

CJ

>   {
> -	int i;
> -	int ret;
> +	int i, ret, nr_pages;
>   	int nr_charged = 0;
>   
> -	BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
> -
> -	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> +	nr_pages = vm->nr_pages;
> +	for (i = 0; i < nr_pages; i++) {
>   		ret = memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL, 0);
>   		if (ret)
>   			goto err;
> @@ -531,9 +529,10 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>   {
>   	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
>   		struct vm_struct *vm = task_stack_vm_area(tsk);
> -		int i;
> +		int i, nr_pages;
>   
> -		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +		nr_pages = vm->nr_pages;
> +		for (i = 0; i < nr_pages; i++)
>   			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
>   					      account * (PAGE_SIZE / 1024));
>   	} else {
> @@ -551,10 +550,11 @@ void exit_task_stack_account(struct task_struct *tsk)
>   
>   	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
>   		struct vm_struct *vm;
> -		int i;
> +		int i, nr_pages;
>   
>   		vm = task_stack_vm_area(tsk);
> -		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +		nr_pages = vm->nr_pages;
> +		for (i = 0; i < nr_pages; i++)
>   			memcg_kmem_uncharge_page(vm->pages[i], 0);
>   	}
>   }


