Return-Path: <linux-kernel+bounces-111829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434188715E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC90B24265
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B17C5FEF5;
	Fri, 22 Mar 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSTRqoW8"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB15FDA9;
	Fri, 22 Mar 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126434; cv=none; b=TbIVGtju+9PBzPLrtD1kX5qqn4d4LfcPylAMRoLv3hp9WChhiEhb984HARgOG6TzQn0LUqaHGp8C4v4oZiVRHH0yz0Y0d5h2R0d/mI0jhH3IvuL200vbjpeGCOpR+yTZ6KQlozgAL+hKVQCCYSgvpq0QRMWsUsu1S03g5068/YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126434; c=relaxed/simple;
	bh=Rc4e+9q8cteiwcWOIW7T38A8/ToMIlusvAVBDyOL15M=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S9f987mJBqRcXtUS1B54gNZz9B2zDOITnnnrwUPgaUKDh8wzgIvHxKDocdfUgNm3A3DWvkG6+2xzOlEfW2E1V00h9waHpcsvLITLPDmfgKMymTzVBA4qIlNMfWqUs3fw+8VuVSuWCSMOKzF4uv3HsRPodk3wGpVQnfOGV+BXR5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSTRqoW8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e570ef661so1085874f8f.1;
        Fri, 22 Mar 2024 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126431; x=1711731231; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prwGqiUDr2MIwI/u9qAD6n1rOIPI2RfxncckA/0+HG4=;
        b=fSTRqoW8949esGuLPcYwLS05SHr93J/p4Q+HD3xdNqD32TbrFtjBMb/Cq27vplJFav
         Q4Q2yxfLIwU2IMT9CTvA3raUW3NxxJq0cARd8qNii89PELbVD1y4MrsYX50IC4j38GmE
         1HLwWRqzv9eSsV6oA7GYDMgBlNYKeB9LkPRYH8o1F98R2hUEBxbga+x4oZgsnbMNyN+q
         fpzQq3ermhDhLIXPBM4qg6CcTW2HAAa3nTIlGeuq5nz1YP6QpkhnqnvQzlBo4gbXBIey
         LQEXdzK8+oNky4SuXsOvXNrl14W1P0wKnyOyscIUcThiphObd7hhjplIVShdT6Qp4dBH
         SxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126431; x=1711731231;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prwGqiUDr2MIwI/u9qAD6n1rOIPI2RfxncckA/0+HG4=;
        b=m/wT/3ElWiJII232Yc9R3+cqwoqHOEfhKNgR+cKHGP04iFjuBuoTcRObZxv9AdlKPY
         X/oE1L+vwp7PbuihPBMOkAiLvInbPlV/VkslHA0JlI0/Fsgxy5lVuvzMbivzJKLb7jqQ
         9xWQ2LvLuqHqKHXgdjPlpINR6c8J2NflLwNsy7JoXSA4E0PGF04uGdS/KGGSTHb9rZkB
         PmfFJ2Yo7rTWToWbHixJrrmLwPTA4FXx9jaaDqeVx2bms2QIYX0l0YdlPKszoIJi8OmD
         FY7AQg5RiHNxq3RzOwrI62Bk+ffdUc3fHwu8JKo+exTuUe4ZC1Pm3OqiT9BS/bZ+5NAl
         NULw==
X-Forwarded-Encrypted: i=1; AJvYcCV5rhlBgcA4TcW5c+BaenT/qO4MsKUEUqekTmdbX9Eers8Ul12WmVQqbkVINI6zdXyIyVNlfKAmyzG+DHkamO9/lHilmSm8QBz7x2FDlc947jxCXJgSIGXKhuG01AQxpTlnnKbvjm0IbwT+4y/CecWIEdpTEs1n7Gln
X-Gm-Message-State: AOJu0YzuzuorbiMDA5wObNvxfU9nbYbbAuEhxif043FJJSZpzRZahBHs
	wqL6ZWeqvb56VP2yMVKgQB4gyBrcK1QQUZs2v3D81vlm7u2DI5fS
X-Google-Smtp-Source: AGHT+IH3aziBPUEw2pxrSbVmh2Fqw5q35d7kuBZURy7unTQvxoYvMLMvNLA3cDHQEFkQSZnpaw7PLw==
X-Received: by 2002:a5d:4944:0:b0:33e:7cdd:b559 with SMTP id r4-20020a5d4944000000b0033e7cddb559mr1991710wrs.56.1711126430520;
        Fri, 22 Mar 2024 09:53:50 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id y17-20020adff151000000b0033e43756d11sm2435796wro.85.2024.03.22.09.53.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2024 09:53:50 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf v4] bpf: verifier: prevent userspace memory access
In-Reply-To: <15ba79e3-14b2-d92e-3f94-e4f5f963e15d@iogearbox.net>
References: <20240321124640.8870-1-puranjay12@gmail.com>
 <9f2b63b5-569c-1e00-a635-93d9cd695517@iogearbox.net>
 <mb61p4jcyxq5m.fsf@gmail.com>
 <15ba79e3-14b2-d92e-3f94-e4f5f963e15d@iogearbox.net>
Date: Fri, 22 Mar 2024 16:53:47 +0000
Message-ID: <mb61pcyrm8axw.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 3/22/24 4:05 PM, Puranjay Mohan wrote:
> [...]
>>>> +		/* Make it impossible to de-reference a userspace address */
>>>> +		if (BPF_CLASS(insn->code) == BPF_LDX &&
>>>> +		    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
>>>> +		     BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
>>>> +			struct bpf_insn *patch = &insn_buf[0];
>>>> +			u64 uaddress_limit = bpf_arch_uaddress_limit();
>>>> +
>>>> +			if (!uaddress_limit)
>>>> +				goto next_insn;
>>>> +
>>>> +			*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
>>>> +			if (insn->off)
>>>> +				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, insn->off);
>>>> +			*patch++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_AX, 32);
>>>> +			*patch++ = BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, uaddress_limit >> 32, 2);
>>>> +			*patch++ = *insn;
>>>> +			*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
>>>> +			*patch++ = BPF_MOV64_IMM(insn->dst_reg, 0);
>>>
>>> But how does this address other cases where we could fault e.g. non-canonical,
>>> vsyscall page, etc? Technically, we would have to call to copy_from_kernel_nofault_allowed()
>>> to really address all the cases aside from the overflow (good catch btw!) where kernel
>>> turns into user address.
>> 
>> So, we are trying to ~simulate a call to
>> copy_from_kernel_nofault_allowed() here. If the address under
>> consideration is below TASK_SIZE (TASK_SIZE + 4GB to be precise) then we
>> skip that load because that address could be mapped by the user.
>> 
>> If the address is above TASK_SIZE + 4GB, we allow the load and it could
>> cause a fault if the address is invalid, non-canonical etc. Taking the
>> fault is fine because JIT will add an exception table entry for
>> for that load with BPF_PBOBE_MEM.
>
> Are you sure? I don't think the kernel handles non-canonical fixup.

Atleast for ARM64 for I don't see a differentiation between the handling
of canonical and non-canonical addresses.
do_translation_fault() checks if addr < TASK_SIZE and calls
do_page_fault() or if the address is greater than TASK_SIZE (it is a
kernel address), do_bad_area() is called.

Both of these call __do_kernel_fault() if fault is from kernel mode and it
does fixup_exception().

>
>> The vsyscall page is special, this approach skips all loads from this
>> page. I am not sure if that is acceptable.
>
> The bpf_probe_read_kernel() does handle it fine via copy_from_kernel_nofault().
bpf_probe_read_kernel() is skipping reading from the vsyscall page, that
is what this patch does as well.

ARM64, RISCV, and some other archs don't implement
copy_from_kernel_nofault_allowed() so I think the we should fix the
common case where the BPF program should not be allowed to access memory
below TASK_SIZE. This would be true for all architectures. 

>
> So there is tail risk that BPF_PROBE_* could trigger a crash. Other archs might

Can you explain this a bit more, how will BPF_PROBE_* trigger a crash?

> have other quirks, e.g. in case of loongarch it says highest bit set means kernel
> space.

Thanks,
Puranjay

