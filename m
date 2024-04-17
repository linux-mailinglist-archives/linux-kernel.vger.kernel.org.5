Return-Path: <linux-kernel+bounces-148157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1A98A7E70
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A818B2829B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D276A126F0A;
	Wed, 17 Apr 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="agOG+Weh"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB837EF0F;
	Wed, 17 Apr 2024 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343143; cv=none; b=uj86eqA6b1jXw6luNQjwQHdNHhwsmMRsO6wsKhhz0QvR2b8yo18xCB8HC/FOw1XNN5qjZc3QKbYw9D47DRxk69MoT6YNPNo6xb27c2aukhaFlrIS8blFsICMOp3/4t1ZAXvs0ecC27J5a4M1p0pWgHaKuSo8/gnrRyqZgcSEnmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343143; c=relaxed/simple;
	bh=LwBpb21fU3Cxf2OzNOaJ1mak+EL69rnMsD5SA8s8T1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJSK5wdv/qBp8kIXYo2KrmFN5kriktRP9O5fZiajvGruLwN3T4cV3ONAebTlZhBdtwWi2nyNvbIvyzCbFlSzkxCeBLP/x5Qqv7DBr9ZgAtexYF14Vt4B3FkY/hngElV1r2U1KIAWjLb3S9LSz6uA3hcJthINEmGp3qpOLLsEvxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=agOG+Weh; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=JC9+CIw92EOAmR2BP/IPuLAvGyZ4A5SJv4/S79yXlRI=;
	t=1713343141; x=1713775141; b=agOG+Weh26gqAYMzdMxwmSwqLBJKG6yqdnOlG5XL0tByxRN
	L9Iq0T5IirQ6VYE1XNAch99p5wqDjZEIUfDZW4flU2At4omF6PC9/f93FM3l3AOgjanUEkVJ7o919
	KcykkUyZXSNphN3eyRJZ9ZHNmHbd8pR9Hi89N3JWZFkGke5a9cLLIISL0QWSCUyZwR5FfrXfjdAh2
	z7yVdUtA8V9EbfcWpX1Y61V+OVV0KGpEuZ4jqHaLAGJCRmS31CiIo+Mlg30jZENir+h4JC1KAy+4J
	NxjNBBl+abD6tXrBlShSypsTXRi0ZFL/klCkuKs0ZzdTCGvpbIjYk73erDWwPnsg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rx0oj-0003EA-75; Wed, 17 Apr 2024 10:38:57 +0200
Message-ID: <edf4fb6f-0f27-44fd-8f2a-ab60a156b20c@leemhuis.info>
Date: Wed, 17 Apr 2024 10:38:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bisected] Kernel v6.9-rc3 fails to boot on a Thinkpad T60 with
 MITIGATION_RETHUNK=y (regression from v6.8.5)
To: Erhard Furtner <erhard_f@mailbox.org>, Klara Modin <klarasmodin@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, x86@kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 jpoimboe@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
 Borislav Petkov <bp@alien8.de>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240413024956.488d474e@yea> <ZhpOIeVq1KQXzjBp@archie.me>
 <68e3503c-5573-4d82-8fb0-5b955c212d67@leemhuis.info>
 <20240414083626.GAZhuViviWKudQ5Apm@fat_crate.local>
 <20240414090810.GBZhuc-lN6tyKbF_-M@fat_crate.local>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240414090810.GBZhuc-lN6tyKbF_-M@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713343141;465fe6b0;
X-HE-SMSGID: 1rx0oj-0003EA-75

On 14.04.24 11:08, Borislav Petkov wrote:
> On Sun, Apr 14, 2024 at 10:36:26AM +0200, Borislav Petkov wrote:
>>> There was an earlier report about this here:
>>> https://lore.kernel.org/all/78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com/
>> Am looking at the whole thing. Stay tuned...
> 
> Something like this, I guess...
> 
> Execution goes off somewhere into the weeds during alternatives patching
> of the return thunk while it tries to warn about it in the alternatives
> code itself and it all ends up in an endless INT3 exceptions due to our
> speculation blockers everywhere...
> 
> I could chase it as to why exactly but the warning is there for all
> those mitigations which need a special return thunk and 32-bit doesn't
> need them (and at least the AMD untraining sequences are 64-bit only
> so...).

Erhard Furtner, did you try if this helps for a kernel with
MITIGATION_RETHUNK=y? Klara Modin, or could you give it a try?

Without a check this is unlikely to be merged and then more people might
run into problems like you two did.

Ciao, Thorsten
> IOW:
> 
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index e674ccf720b9..391059b2c6fb 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -382,8 +382,15 @@ SYM_FUNC_END(call_depth_return_thunk)
>  SYM_CODE_START(__x86_return_thunk)
>  	UNWIND_HINT_FUNC
>  	ANNOTATE_NOENDBR
> +#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || \
> +    defined(CONFIG_MITIGATION_SRSO) || \
> +    defined(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)
>  	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
>  		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
> +#else
> +	ANNOTATE_UNRET_SAFE
> +	ret
> +#endif
>  	int3
>  SYM_CODE_END(__x86_return_thunk)
>  EXPORT_SYMBOL(__x86_return_thunk)
> 

