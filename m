Return-Path: <linux-kernel+bounces-104791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D787D3AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA98F284BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB13B125C7;
	Fri, 15 Mar 2024 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vgG9rOHu"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309AF17F5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527664; cv=none; b=noY4op3dB8Neyv8ESh896DQUMSGXo2EsrK4ViAa47xEDZUhGtj8sU3Un4sUFXMuX3GUvj+Vj6MzQI8/DcXgrdiijoGTfHbs9EDBp7skToau5asjmBmC7fselCz3LO3gpndPAdMwNmrsRHXhCfnkc8yIJXBW1vS9HPJZqKPA42AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527664; c=relaxed/simple;
	bh=f1MflJg0i2dTYFfJ/FvCXugz7LXWLRqLl9XukgJO8sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2AHhdSfQTU292ydnxhtaCXrbUEFEk84YmDvkGuAGGvaFr7UcQsSL17DKHpak2W0gGwLopJxubc/piAQ01WIamhGb0OQyOWGoOnDyHFr5AQ9x5WFUNRZaaKe7n59zJcN7EOzlf4gd/+MVmghUIFKSvSaVg9vmKlkGUnenUdcdDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vgG9rOHu; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8727ba1-0d8b-4c42-a4b1-e98bed061b22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710527660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwS8ifPQAGz1J3Hq6rVc1WHZcxma52yVomkFbeLKS2s=;
	b=vgG9rOHuxmCKaF8xIhfHf8fAEHOjraC0qZ2aRwEMFTxOuLTarOI2hdc5rm9lRh+ThmOmS6
	FNZGtOkmKRgPXu5ZnDn9bnfwz+JD8qeISh2MQ8eFBpNzG8z2rnmJDKpMgznz+X7mS4/CU2
	tW+s9N6w/ziM1+D788Trt2x/egeak68=
Date: Fri, 15 Mar 2024 11:34:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Check return from set_memory_rox()
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Kees Cook <keescook@chromium.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <2b9fdb119ef73cfa4516572026ba4936e86aedca.1710522112.git.christophe.leroy@csgroup.eu>
 <4d7cc25e937403ac61ae61be06f998f27e631a65.1710522112.git.christophe.leroy@csgroup.eu>
 <81492d37-47b2-4fca-ba2f-9528c2d41029@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <81492d37-47b2-4fca-ba2f-9528c2d41029@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/15/24 11:11 AM, Kui-Feng Lee wrote:
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -742,8 +742,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map 
>> *map, void *key,
>>           if (err)
>>               goto reset_unlock;
>>       }
>> -    for (i = 0; i < st_map->image_pages_cnt; i++)
>> -        arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
>> +    for (i = 0; i < st_map->image_pages_cnt && !err; i++)
>> +        err = arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
>> +
>> +    if (err)
> 
> nit: Can it be more specific? I mean to check err < 0, so we can reason
> that this function never returns a positive value other than 0.

I think "if (err)" is fine. It is pretty common in other places of the kernel.

Checking "(err < 0)" may actually mean the return value could be positive. At 
least it is how bpf_struct_ops.c is using "(err < 0)".

[ An unrelated side note is another (err < 0) check in bpf_struct_ops.c could 
have been changed after the recent changes in bpf_struct_ops_prepare_trampoline 
which no longer return +val ].



