Return-Path: <linux-kernel+bounces-104607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E387D0DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD6A1F24462
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FF544C77;
	Fri, 15 Mar 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="D6ZaLuJt"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02B93F9F4;
	Fri, 15 Mar 2024 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518469; cv=none; b=bpOvg4jd/yBvuR7MFGVDpe9sL5iWeXHFOfOEe7ABL6n+AKUxYlnJLkfvI+sHXlhBm6ySPlS/exebZ14mY2GiL1jaXR0TVgIYlLoiEblbgWaLcOapTGJM/PzmrscOIPv/pcFSFWWZZz9A/iOrO4W6TGvTt2qy1CpxJb/m2qyzsKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518469; c=relaxed/simple;
	bh=DY5bqcoMqBokCekqilHN7pFTOtuXZy4JlDrniyQss8k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TmI4AsvmcIFPRyXmB1+hpAWx+Z23+k/8OwI8Wkj6Sp063i+Wnm6PHzXYX1pdcLBFgjo9YnC0hsnlIFe4dvo/JvHD2Ud5rBkeT4EfU2rxXLsibRTGEVv5TQKevPOe48CnJ2M6rB/p4FiEeXNbD8jIM8SNN0kUnKPGM0ZkHe3sbv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=D6ZaLuJt; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=AYVnUm7ckwTfwVjLKqAldlVmSJddb6dwWNatvUe0+Kc=; b=D6ZaLuJtyhB2q4q9JVQZIHlVAB
	kyfLf+2Z2RpPP0xZYa9PI+08sKh2zZdxd1p4gAEAoCY+ngiXBifUaLhdWosR7g1U8dzEaYQBmu5c1
	fXHhsjgYDQUktOa+sSw08G9vtEyLhQofLLISLdbaSi0zyWd+nVUwUp+NjI3JvcquQXBnngraECpwB
	/LZM7Q6FcDnExS32+rh+E3rKJwSgPnjMhl2ZEoPu1leQ6HnhYOYETcuHSVvvlfiKiNxstTeSUrrOH
	+TagggIppv3BBqQUm8VETDBM7HzazugdVU425kNCmOHZSYsBQzaSPrX8aniLO35ifIoetW4fSa+Ca
	fEuv/2Iw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rl9z7-000EKR-Sa; Fri, 15 Mar 2024 17:00:41 +0100
Received: from [178.197.249.11] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rl9z6-000FYY-0L;
	Fri, 15 Mar 2024 17:00:40 +0100
Subject: Re: [PATCH bpf-next v2] bpf: Check return from set_memory_rox() and
 friends
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>
References: <883c5a268483a89ab13ed630210328a926f16e5b.1708526584.git.christophe.leroy@csgroup.eu>
 <14b840d4-631f-2ad9-fb92-540aa150250b@iogearbox.net>
 <7848b9e8-2326-4046-8cec-bac2255c8602@csgroup.eu>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d6159a82-284e-780d-b1b6-d583caf07fea@iogearbox.net>
Date: Fri, 15 Mar 2024 17:00:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7848b9e8-2326-4046-8cec-bac2255c8602@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27215/Fri Mar 15 09:31:18 2024)

On 3/15/24 3:55 PM, Christophe Leroy wrote:
[...]
>>>    {
>>>        WARN_ON_ONCE(size > PAGE_SIZE);
>>> -    set_memory_rox((long)image, 1);
>>> +    return set_memory_rox((long)image, 1);
>>>    }
>>> -void __weak arch_unprotect_bpf_trampoline(void *image, unsigned int
>>> size)
>>> +int __weak arch_unprotect_bpf_trampoline(void *image, unsigned int size)
>>>    {
>>> +    int err;
>>>        WARN_ON_ONCE(size > PAGE_SIZE);
>>> -    set_memory_nx((long)image, 1);
>>> -    set_memory_rw((long)image, 1);
>>> +
>>> +    err = set_memory_nx((long)image, 1);
>>> +    if (err)
>>> +        return err;
>>> +    return set_memory_rw((long)image, 1);
>>>    }
>>
>> Do we still need this? It looks like this does not have an in-tree user
>> anymore.
> 
> Looks like last user went away with commit 187e2af05abe ("bpf:
> struct_ops supports more than one page for trampolines.") but I'm having
> hard time figuring if it's valid or not.
> 
> But as there is no user anymore it surely can go away. Will you drop it
> or do you want a proper patch from me ?

My understanding is that the VM_FLUSH_RESET_PERMS would take care of this
via arch_alloc_bpf_trampoline(). Anyway, gvien there is a merge conflict
with this patch, pls include it with a v3.

Thanks,
Daniel

