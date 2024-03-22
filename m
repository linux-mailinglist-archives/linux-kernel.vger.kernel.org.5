Return-Path: <linux-kernel+bounces-111778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD668870DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C054B22429
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AC459B5F;
	Fri, 22 Mar 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="EWBrLKgq"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1152B57876;
	Fri, 22 Mar 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124933; cv=none; b=qrA+MsD2Oplsxos9p7TT5RCyNJ/mZZRTZLJy1oJEsXA6OgIIsm8x3ujAS5UxW4+TgEZR4h8+9aQ3jsrqigmEqyV9A3bLlPllKisPmBHr6SQUX+aIM8jt8Yoz6nXyjmtc92uT+vWyfThIJtRnGmV8pEoPryXHddhThPbM9q83zP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124933; c=relaxed/simple;
	bh=HCHPduluDxyIyH+NvikE4NsWGI6bZ5WsJcGstMkaba8=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LAggexJTMmkMOKqgPMmOVUByzRcohbVw4v71ILzq8UgAxII/jK0b1xZsw6iDVUojsCCmDEaxEjY+sUu/UwfufoMpwny3uqBQiIFKKT7y0OY82IuqSU/7Ast/n9+6xMKIkYNFWd6vxUY0mHJd1TxY0/OxZC9m+DBmKQyKcWk3V9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=EWBrLKgq; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hixCqn+Oc2muuJ+PQhMb4XfVD5sY/7+CWBK1O86fCP8=; b=EWBrLKgqN4m8l3O6+O94qP2ODo
	URMp6tGn683BPwRb8Fpew2vnz3OQ5WBxW29yWsVTp4ehqWT/HbD247K0L1F1lqRMaHZexptq5uaLg
	x/rWMQysn22z28qRpDQaOBNykOb7EYHGrlrEoihYdaHLXUY5bXE+OkuSuafWrJ/phSNR8xCmM3wVj
	OEkGRc6cuEz6RpKsXPLA3segwnrc+WKTj08v26v02VUkjw4JJtqUpcyYidyqRTcRBKEy4l82bDbh2
	k5wOf5tBTYOPLzFyF+4FqK+CG3zivP2hhwVYJbvxPwDrIFVBNc+mSndvNs0JTMhu8XJoEeF2CtMWZ
	atWNIHvw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rnhks-000Ook-0x; Fri, 22 Mar 2024 17:28:30 +0100
Received: from [178.197.248.30] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rnhkq-000BhN-1s;
	Fri, 22 Mar 2024 17:28:28 +0100
Subject: Re: [PATCH bpf v4] bpf: verifier: prevent userspace memory access
To: Puranjay Mohan <puranjay12@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240321124640.8870-1-puranjay12@gmail.com>
 <9f2b63b5-569c-1e00-a635-93d9cd695517@iogearbox.net>
 <mb61p4jcyxq5m.fsf@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <15ba79e3-14b2-d92e-3f94-e4f5f963e15d@iogearbox.net>
Date: Fri, 22 Mar 2024 17:28:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <mb61p4jcyxq5m.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27222/Fri Mar 22 09:30:59 2024)

On 3/22/24 4:05 PM, Puranjay Mohan wrote:
[...]
>>> +		/* Make it impossible to de-reference a userspace address */
>>> +		if (BPF_CLASS(insn->code) == BPF_LDX &&
>>> +		    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
>>> +		     BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
>>> +			struct bpf_insn *patch = &insn_buf[0];
>>> +			u64 uaddress_limit = bpf_arch_uaddress_limit();
>>> +
>>> +			if (!uaddress_limit)
>>> +				goto next_insn;
>>> +
>>> +			*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
>>> +			if (insn->off)
>>> +				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, insn->off);
>>> +			*patch++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_AX, 32);
>>> +			*patch++ = BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, uaddress_limit >> 32, 2);
>>> +			*patch++ = *insn;
>>> +			*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
>>> +			*patch++ = BPF_MOV64_IMM(insn->dst_reg, 0);
>>
>> But how does this address other cases where we could fault e.g. non-canonical,
>> vsyscall page, etc? Technically, we would have to call to copy_from_kernel_nofault_allowed()
>> to really address all the cases aside from the overflow (good catch btw!) where kernel
>> turns into user address.
> 
> So, we are trying to ~simulate a call to
> copy_from_kernel_nofault_allowed() here. If the address under
> consideration is below TASK_SIZE (TASK_SIZE + 4GB to be precise) then we
> skip that load because that address could be mapped by the user.
> 
> If the address is above TASK_SIZE + 4GB, we allow the load and it could
> cause a fault if the address is invalid, non-canonical etc. Taking the
> fault is fine because JIT will add an exception table entry for
> for that load with BPF_PBOBE_MEM.

Are you sure? I don't think the kernel handles non-canonical fixup.

> The vsyscall page is special, this approach skips all loads from this
> page. I am not sure if that is acceptable.

The bpf_probe_read_kernel() does handle it fine via copy_from_kernel_nofault().

So there is tail risk that BPF_PROBE_* could trigger a crash. Other archs might
have other quirks, e.g. in case of loongarch it says highest bit set means kernel
space.

