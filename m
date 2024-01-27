Return-Path: <linux-kernel+bounces-41381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E3683EFD4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A101C22ED5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAE72E634;
	Sat, 27 Jan 2024 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="GB1KW9Qu"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC3A2E626;
	Sat, 27 Jan 2024 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706384891; cv=none; b=dY+uNlROQ/tJNYzSHTSLWUvd25FSBb5YfHBhGIPKaDDQDq6lfjtOsUxpfe20vIA40o5hxU9Ch5PgMm0k/vxXktwK9NYqnQ8Vyvms72kdKYkrxl4tdi2ZCav8jk7PfjaILrNabuUzmxX+koPIe6njdImF5oJGwzrWJweDTARBaIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706384891; c=relaxed/simple;
	bh=rdgatAYjjoEr2tTsPC9ZlGPbaVz0FL4qRco3vhj96KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc57jJ5FkST8nXdTyXQjVPCniVkoPIdIqKVmKEHFHIrZSyaFjkfW9NQOPhOAVFjVxzRhRa8gg27KZNCYonIZdsdEBf3tHdm+9E8OeE3WJoOHdHqa0Ik6ol6c3R7FiwmER74/lFDfhC52yTWg+u1UGoyub5RJ17nJzTN55OsIKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=GB1KW9Qu; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.187] ([73.202.249.128])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40RJlSfj1287190
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 27 Jan 2024 11:47:29 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40RJlSfj1287190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706384850;
	bh=vdtoRWtPevl85cGDyBhkbuw0MUYwEA7T+UstKWSXl+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GB1KW9QuxS/8pv1y+9J3h2s6K3yAwQESMnDTyQ2bE+QRkLHGBtR1bKB50138Qfxb3
	 kS+xQNb9L24IuqpFr0H8m0cFXSYHa/EMsUcVm95lWt6VyLDIV6WtjMbxzpJ/zzSePA
	 D5g/tiVxfZRmmN64rOzP9xNKtPTeb7HHvmzfTvl+z+ngliO9wEUnwi6uudl/nw676F
	 tj3AjZq/62h9WTZazeObprQLh/1OVZTLj17tJtEmWLcXs5XqAlbtwBabKbkbapQKVc
	 4kDvv83s/alDDPD705Mcij5IqhTzlolZKYW5CMHr3vTKF841a1HdaeDmJhaUjLhMOG
	 OZ49cuEMaR+NQ==
Message-ID: <30966e59-d757-43f2-a89b-75bf41426611@zytor.com>
Date: Sat, 27 Jan 2024 11:47:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] x86/kprobes: Prohibit kprobing on INT and UD
To: Jinghao Jia <jinghao7@illinois.edu>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240127044124.57594-1-jinghao7@illinois.edu>
 <20240127044124.57594-2-jinghao7@illinois.edu>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240127044124.57594-2-jinghao7@illinois.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/26/2024 8:41 PM, Jinghao Jia wrote:
> Both INTs (INT n, INT1, INT3, INTO) and UDs (UD0, UD1, UD2) serve
> special purposes in the kernel, e.g., INT3 is used by KGDB and UD2 is
> involved in LLVM-KCFI instrumentation. At the same time, attaching
> kprobes on these instructions (particularly UDs) will pollute the stack
> trace dumped in the kernel ring buffer, since the exception is triggered
> in the copy buffer rather than the original location.
> 
> Check for INTs and UDs in can_probe and reject any kprobes trying to
> attach to these instructions.
> 
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> ---
>   arch/x86/kernel/kprobes/core.c | 33 ++++++++++++++++++++++++++-------
>   1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index e8babebad7b8..792b38d22126 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -252,6 +252,22 @@ unsigned long recover_probed_instruction(kprobe_opcode_t *buf, unsigned long add
>   	return __recover_probed_insn(buf, addr);
>   }
>   
> +static inline int is_exception_insn(struct insn *insn)

s/int/bool

> +{
> +	if (insn->opcode.bytes[0] == 0x0f) {
> +		/* UD0 / UD1 / UD2 */
> +		return insn->opcode.bytes[1] == 0xff ||
> +		       insn->opcode.bytes[1] == 0xb9 ||
> +		       insn->opcode.bytes[1] == 0x0b;
> +	} else {
> +		/* INT3 / INT n / INTO / INT1 */
> +		return insn->opcode.bytes[0] == 0xcc ||
> +		       insn->opcode.bytes[0] == 0xcd ||
> +		       insn->opcode.bytes[0] == 0xce ||
> +		       insn->opcode.bytes[0] == 0xf1;
> +	}
> +}
> +
>   /* Check if paddr is at an instruction boundary */
>   static int can_probe(unsigned long paddr)
>   {
> @@ -294,6 +310,16 @@ static int can_probe(unsigned long paddr)
>   #endif
>   		addr += insn.length;
>   	}
> +	__addr = recover_probed_instruction(buf, addr);
> +	if (!__addr)
> +		return 0;
> +
> +	if (insn_decode_kernel(&insn, (void *)__addr) < 0)
> +		return 0;
> +
> +	if (is_exception_insn(&insn))
> +		return 0;
> +
>   	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
>   		/*
>   		 * The compiler generates the following instruction sequence
> @@ -308,13 +334,6 @@ static int can_probe(unsigned long paddr)
>   		 * Also, these movl and addl are used for showing expected
>   		 * type. So those must not be touched.
>   		 */
> -		__addr = recover_probed_instruction(buf, addr);
> -		if (!__addr)
> -			return 0;
> -
> -		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
> -			return 0;
> -
>   		if (insn.opcode.value == 0xBA)
>   			offset = 12;
>   		else if (insn.opcode.value == 0x3)

-- 
Thanks!
     Xin


