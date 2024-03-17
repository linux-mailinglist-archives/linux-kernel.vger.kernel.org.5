Return-Path: <linux-kernel+bounces-105414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AD787DD91
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8300AB20AE3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E881C2A3;
	Sun, 17 Mar 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lUI78kaR"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B03D1B964
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710687113; cv=none; b=uYz/CVmkoC5V5FCrnIzxONmqFegtKW5joagr9m5CfdcDtxCSh8G8BmuNiW7/TZHJLcf35ILpN4SPTA7hNUKfVhH6uLBfZSPJwVkUn3z95q7sXSUVUc7jKg2/lDzGDcDghgLmZKosP4ALuY3MWLHOBA0/XamEvfGEiAnnpi1mYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710687113; c=relaxed/simple;
	bh=z920P4ZDLvkSl02Dp/ph/NZ0TNImdlFqF//xRtWgElI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TqgsyhE5b5BvG1FhiY/W6AUnaVn4MYc/7K4mE99awbHBtje5LaY1rb1149d0ViVoj1WBvWMASdJEUvu1KMIPDVqZVy8ls42t79xLhCcGJPQxHZnZiN/X9NcVvE6nGT+mR4nfdWVT5ahMDvYH25xVKNi1KdI29QlXW+ZiTcc+UN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lUI78kaR; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id lriWr6OaujgOxlriWrD77y; Sun, 17 Mar 2024 15:42:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710686558;
	bh=Yan/AlvVbMuiA/SKqp2eF5APWJaKjCjDOI2XvgxxnbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lUI78kaRgm8mQYNgkli/z47tX53piBtp36x9s69tM+jOLyIyL8Nu/h3Bu5CgBSJ+V
	 mAwK4TZiAvdrZdxYo7bF38IaBsij+VPgnTWa6/H+6dl3Sni29cG8OViMakFdXrsV0C
	 HoP9Gd7Bs8ETWFDvG1KG1ZeWMSzuwAlHuOe1wfqSfbGol9NixjsXPiyU5a71rjL/VI
	 9DxZF7AbfCCfyHj0WbaNJH7OETzZ2r3Ains3VR1erE+An2B+d/Mn3NRFrbxw7gRixS
	 9DBS6zg8ZxmuGhiAlv5BzILvh8j6fguqGJkTTFZm4Va6Yc1RobmqnU43ysRXaMsI2k
	 WpOz6ZUKQeNzQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Mar 2024 15:42:38 +0100
X-ME-IP: 92.140.202.140
Message-ID: <1af02bc8-1b20-4508-909d-342f3b06bf78@wanadoo.fr>
Date: Sun, 17 Mar 2024 15:42:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 03/14] fork: Clean-up naming of vm_strack/vm_struct
 variables in vmap stacks code
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
 <20240311164638.2015063-4-pasha.tatashin@soleen.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240311164638.2015063-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/03/2024 à 17:46, Pasha Tatashin a écrit :
> There are two data types: "struct vm_struct" and "struct vm_stack" that
> have the same local variable names: vm_stack, or vm, or s, which makes
> code confusing to read.
> 
> Change the code so the naming is consisent:

Nit: consistent

> 
> struct vm_struct is always called vm_area
> struct vm_stack is always called vm_stack
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   kernel/fork.c | 38 ++++++++++++++++++--------------------
>   1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 32600bf2422a..60e812825a7a 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -192,12 +192,12 @@ struct vm_stack {
>   	struct vm_struct *stack_vm_area;
>   };
>   
> -static bool try_release_thread_stack_to_cache(struct vm_struct *vm)
> +static bool try_release_thread_stack_to_cache(struct vm_struct *vm_area)
>   {
>   	unsigned int i;
>   
>   	for (i = 0; i < NR_CACHED_STACKS; i++) {
> -		if (this_cpu_cmpxchg(cached_stacks[i], NULL, vm) != NULL)
> +		if (this_cpu_cmpxchg(cached_stacks[i], NULL, vm_area) != NULL)
>   			continue;
>   		return true;
>   	}
> @@ -207,11 +207,12 @@ static bool try_release_thread_stack_to_cache(struct vm_struct *vm)
>   static void thread_stack_free_rcu(struct rcu_head *rh)
>   {
>   	struct vm_stack *vm_stack = container_of(rh, struct vm_stack, rcu);
> +	struct vm_struct *vm_area = vm_stack->stack_vm_area;
>   
>   	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
>   		return;
>   
> -	vfree(vm_stack);
> +	vfree(vm_area->addr);

This does not look like only a renaming of a variable. Is it?

If no, should there be a Fixes tag and should it be detailed in the 
commit description?

CJ

>   }
>   
>   static void thread_stack_delayed_free(struct task_struct *tsk)
> @@ -228,12 +229,12 @@ static int free_vm_stack_cache(unsigned int cpu)
>   	int i;
>   
>   	for (i = 0; i < NR_CACHED_STACKS; i++) {
> -		struct vm_struct *vm_stack = cached_vm_stacks[i];
> +		struct vm_struct *vm_area = cached_vm_stacks[i];
>   
> -		if (!vm_stack)
> +		if (!vm_area)
>   			continue;
>   
> -		vfree(vm_stack->addr);
> +		vfree(vm_area->addr);
>   		cached_vm_stacks[i] = NULL;
>   	}
>   
> @@ -263,32 +264,29 @@ static int memcg_charge_kernel_stack(struct vm_struct *vm)
>   
>   static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>   {
> -	struct vm_struct *vm;
> +	struct vm_struct *vm_area;
>   	void *stack;
>   	int i;
>   
>   	for (i = 0; i < NR_CACHED_STACKS; i++) {
> -		struct vm_struct *s;
> -
> -		s = this_cpu_xchg(cached_stacks[i], NULL);
> -
> -		if (!s)
> +		vm_area = this_cpu_xchg(cached_stacks[i], NULL);
> +		if (!vm_area)
>   			continue;
>   
>   		/* Reset stack metadata. */
> -		kasan_unpoison_range(s->addr, THREAD_SIZE);
> +		kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
>   
> -		stack = kasan_reset_tag(s->addr);
> +		stack = kasan_reset_tag(vm_area->addr);
>   
>   		/* Clear stale pointers from reused stack. */
>   		memset(stack, 0, THREAD_SIZE);
>   
> -		if (memcg_charge_kernel_stack(s)) {
> -			vfree(s->addr);
> +		if (memcg_charge_kernel_stack(vm_area)) {
> +			vfree(vm_area->addr);
>   			return -ENOMEM;
>   		}
>   
> -		tsk->stack_vm_area = s;
> +		tsk->stack_vm_area = vm_area;
>   		tsk->stack = stack;
>   		return 0;
>   	}
> @@ -306,8 +304,8 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>   	if (!stack)
>   		return -ENOMEM;
>   
> -	vm = find_vm_area(stack);
> -	if (memcg_charge_kernel_stack(vm)) {
> +	vm_area = find_vm_area(stack);
> +	if (memcg_charge_kernel_stack(vm_area)) {
>   		vfree(stack);
>   		return -ENOMEM;
>   	}
> @@ -316,7 +314,7 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>   	 * free_thread_stack() can be called in interrupt context,
>   	 * so cache the vm_struct.
>   	 */
> -	tsk->stack_vm_area = vm;
> +	tsk->stack_vm_area = vm_area;
>   	stack = kasan_reset_tag(stack);
>   	tsk->stack = stack;
>   	return 0;


