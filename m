Return-Path: <linux-kernel+bounces-105402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F1287DD6A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985D4281259
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3771C2BD;
	Sun, 17 Mar 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kqPEaxHd"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568B51C288
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710686262; cv=none; b=G5Q+vNCxZaRlx81cuQ+ZQL2MrX/jXG0N8UW3zMope2acfwLtG3VW8jT4GSrLFgJS6VETnab1kGNVtBrlVUMjK/P87BLCPnDSvL1HQOKyUu4gjIU4/IUvWlAMjZNRwXpc7tqZ6/3RaV0kuxxOutqaJR2e4z5C5Wzrxy2PK7ljR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710686262; c=relaxed/simple;
	bh=Cn7sshV6Ai3ciMfT3t6YdbQohbNSOvEiyMKtrdVeacU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rTT0PwfqeG079gyhEP9YPP2zLrts8YnrSkOtmT/2/6ogAdjgLtbjHr3XIY4IYph4LPsxgVQE7RH59SiCaa9vv4ywCLdw312hQTdRDx5pXx1Kzrt5jfFiU/ICUxTmA20j/SgZYe+dMCmfiYYB8sp+PBXZL8IOjjGChcxqxOz393s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kqPEaxHd; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id lrcarrEtLbrwelrcbrVX3U; Sun, 17 Mar 2024 15:36:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710686188;
	bh=8aI/sId35KTohUb/c4ySdsUGwQQ2SaCPOh0Sg25jTnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=kqPEaxHdMXnVBHdDMI9fdy8YHO7KeMmgGb9UFnR/vvc/Q8y5stWlOpFRQnSE5QfFy
	 e29vYCUDAczOb6/7ESD6PQMu4Cc+MB4RIhKRXi+xsOuwby7cxup6KFYKsV9QPIJmoQ
	 7/DFxTpHCF7wsb2cc6BLs4XzJtQU/IUutyxQ6wH6lCuydshxKSgsv6rAarWrPKTo3Z
	 x++Ny3QAYe0VFakD4c3p9rnGMKq+QG4+2EP8ancAC5B/nR2wM4mjfOl8Q8jdw9I0cf
	 MURFz6516GWQLQvgfZRcaceorYqO4mio7ItADEuEUw1Sdl2vaEzWY4u6Uw5h4hFm82
	 wYPglgS1bELVg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Mar 2024 15:36:28 +0100
X-ME-IP: 92.140.202.140
Message-ID: <07e3705f-68be-40bc-80fb-ef81460f1674@wanadoo.fr>
Date: Sun, 17 Mar 2024 15:36:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/14] task_stack.h: remove obsolete __HAVE_ARCH_KSTACK_END
 check
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
 <20240311164638.2015063-2-pasha.tatashin@soleen.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240311164638.2015063-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/03/2024 à 17:46, Pasha Tatashin a écrit :
> Remove __HAVE_ARCH_KSTACK_END as it has been osolete since removal of
> metag architecture in v4.17.

Nit: obsolete

> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   include/linux/sched/task_stack.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
> index ccd72b978e1f..860faea06883 100644
> --- a/include/linux/sched/task_stack.h
> +++ b/include/linux/sched/task_stack.h
> @@ -116,7 +116,6 @@ static inline unsigned long stack_not_used(struct task_struct *p)
>   #endif
>   extern void set_task_stack_end_magic(struct task_struct *tsk);
>   
> -#ifndef __HAVE_ARCH_KSTACK_END
>   static inline int kstack_end(void *addr)
>   {
>   	/* Reliable end of stack detection:
> @@ -124,6 +123,5 @@ static inline int kstack_end(void *addr)
>   	 */
>   	return !(((unsigned long)addr+sizeof(void*)-1) & (THREAD_SIZE-sizeof(void*)));
>   }
> -#endif
>   
>   #endif /* _LINUX_SCHED_TASK_STACK_H */


