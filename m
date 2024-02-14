Return-Path: <linux-kernel+bounces-65817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0E0855245
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D331C22302
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7940B134738;
	Wed, 14 Feb 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hgJnHJfj"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905595D493;
	Wed, 14 Feb 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935929; cv=none; b=oLf14/96GDo0fMIckTdvqxawOkD/cAkmx6Z7y6FpfaZEiB/fH99vNrch+J5VnIawSJCcS+SQF1jDlGCo+2SjYFAznCLjfO1IXJb6IRGpfJjgZ9aa/QH7eEdS5K8n0clm5ddOTenAE6pt4eq+L32iReMU4hMY/dq9TnIVsYq5Xrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935929; c=relaxed/simple;
	bh=QVq3liDeH2KL42FCECf1+liwAvFENQw3050DpAJwYG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wjs5xvBUIUcd8XSviSLP+9QhtLGfw4pU1J+fMLF/4yFepvlhMKzOFnwXbKIvVAXrk+olYjL5qpKhyNgO3s2h4+gdMc+/rb6yVlmXHniAXqMVwGnyZl5Q6tsQMEI73E/IKqGQ+EBW1H77D8dBRJZcjyoL9NoDDtDnvW7IUtCk4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hgJnHJfj; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.187] ([71.202.196.111])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 41EIbLoR1382415
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 14 Feb 2024 10:37:22 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 41EIbLoR1382415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1707935845;
	bh=Wyscpp4BeSOOqkorWNUGlqTxHcB1H2qViK6BNum7IEA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hgJnHJfjYr57XAd5LwZE5FNAwg9V6OIe22OtpG20MftHzDhneGEzZwogu0MVU++0D
	 Q9DHMn3y0Dr5RUqUD4dKd+2C70ozwo3Y7MV4ifV71zXwOHh1khFcs5QDYURQhwbZRA
	 OoZICB64lDGeLnzY28rmxDN2S552mNTc8xE04XwPGqwsikIjBeHo9VzYE2TaoROcxy
	 B6BuKq86pEPlTRUn1fYLfz72rCtWW9e6gaFMXaD4L9FlRtJdGe8hSdKy4wm6veAJ3M
	 JLquy9Us+R1SYz8m0vqWjEDCMN6Q+9zggfVmuqfuYzmm8OV2wzKNDIGDmGUk+cT+gi
	 4sHVN13YitHtA==
Message-ID: <eec160a4-fc59-4e7e-885f-0384a7ede4cf@zytor.com>
Date: Wed, 14 Feb 2024 10:37:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/8] sbm: documentation of the x86-64 SandBox Mode
 implementation
Content-Language: en-US
To: Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Xin Li <xin3.li@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao <zegao2021@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
        Brian Gerst <brgerst@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Joerg Roedel <jroedel@suse.de>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan
 <jacob.jun.pan@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
 <20240214113516.2307-8-petrtesarik@huaweicloud.com>
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240214113516.2307-8-petrtesarik@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/2024 3:35 AM, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> Add a section about the x86-64 implementation.
> 
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>   Documentation/security/sandbox-mode.rst | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/security/sandbox-mode.rst b/Documentation/security/sandbox-mode.rst
> index 4405b8858c4a..84816b6b68de 100644
> --- a/Documentation/security/sandbox-mode.rst
> +++ b/Documentation/security/sandbox-mode.rst

where is this file?

I assumed it's newly added, but your patch doesn't say so.

> @@ -111,6 +111,31 @@ These hooks must be implemented to select HAVE_ARCH_SBM.
>   		:identifiers: arch_sbm_init arch_sbm_destroy arch_sbm_exec
>   			      arch_sbm_map_readonly arch_sbm_map_writable
>   
> +X86_64 Implementation
> +=====================
> +
> +The x86_64 implementation provides strong isolation and recovery from CPU
> +exceptions.
> +
> +Sandbox mode runs in protection ring 3 (same as user mode). This means that:
> +
> +* sandbox code cannot execute privileged CPU instructions,
> +* memory accesses are treated as user accesses.
> +
> +The thread stack is readable in sandbox mode, because an on-stack data
> +structure is used by call helpers and thunks to pass target function
> +arguments. However, it is not writable, and sandbox code runs on its own
> +stack. The thread stack is not used by interrupt handlers either. Non-IST
> +interrupt handlers run on a separate sandbox exception stack.
> +
> +The interrupt entry path modifies the saved pt_regs to make it appear as
> +coming from kernel mode. The CR3 register is then switched to kernel mode.
> +The interrupt exit path is modified to restore actual pt_regs and switch the
> +CR3 register back to its sandbox mode value, overriding CR3 changes for page
> +table isolation.
> +
> +Support for paravirtualized kernels is not (yet) provided.
> +
>   Current Limitations
>   ===================
>   




