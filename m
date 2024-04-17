Return-Path: <linux-kernel+bounces-148160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D2F8A7E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F8C1F21D63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3E127B5F;
	Wed, 17 Apr 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XkRqJaSf"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629769E0C;
	Wed, 17 Apr 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343233; cv=none; b=hfxqNWRFyH+QcwOa57cPvC3iqsyLt6UGd9WwuTVPNkOp/dGkvJ3fPEqiVTpw9skpIglXkieQp/jSvoLU1Gr6X5RYGVTAh6Pg/UIac0nYz2XLwiQhX9AM1Gp9u1ngRjsB6VzHXf5MjIcIANJhglKvkLnkHNyBYFQKndUnOokrya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343233; c=relaxed/simple;
	bh=2gUk4M9TngyGQgtsMWTN8/cAxIo9MS7DMSJJ3qECf0I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RP8M6WGSmlJgKKEEAbZqB9X0h+qZa0q/3V9fNd3x50VAiYktbGPyVdZ7SrrWo1MHn81+wUdd4bRzFXxjgDOMVzGuY1X9p+qqjYu4RjlMIDVK0gcKxuzBz4m1QExZNacsOuNQY1SyJgXwZd2Nv1jsA0qMKsaH8SpSB2Ca2a3cSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XkRqJaSf; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=iihPq/dR7kMxFz857c8og3rkIZKdP6iLGcTAyMbnfpw=;
	t=1713343232; x=1713775232; b=XkRqJaSfkSLimXHw0ozAgnMAcw1r9n5L5CPj09eTS4EvQf1
	gMx5SyuatTLHHw1xzXK9V8iyY9bnM9D5d6LeKEPhq+/ZA5z6k6zu0zTai09NWqeA9ck9sDqvjfojx
	kyR3Hv56Mgkvxj6x66mw9u+ObFONOafPnc078GWDDfPI0lH3OVHyUvNMWB6VFxj93QaTVkWGSK0VQ
	ihJlexoxBVdLSqvYvUG+Co8IyN4XWsjDbI9T6z6Us3Q9VNZeebws4btNgXz7KSch+DSkle2zbgmHm
	7VwB3EsxK4jPc1FkPfJPHA4h3wb7tUv6SmNHodPVVJTuC2WYKsdIy3q8fR+szX3g==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rx0qC-0003cF-VV; Wed, 17 Apr 2024 10:40:29 +0200
Message-ID: <d721ab1a-e1e9-486d-b2d8-34053a8c9d65@leemhuis.info>
Date: Wed, 17 Apr 2024 10:40:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bisected] Kernel v6.9-rc3 fails to boot on a Thinkpad T60 with
 MITIGATION_RETHUNK=y (regression from v6.8.5)
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Erhard Furtner <erhard_f@mailbox.org>, Klara Modin <klarasmodin@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, x86@kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 jpoimboe@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
 Borislav Petkov <bp@alien8.de>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240413024956.488d474e@yea> <ZhpOIeVq1KQXzjBp@archie.me>
 <68e3503c-5573-4d82-8fb0-5b955c212d67@leemhuis.info>
 <20240414083626.GAZhuViviWKudQ5Apm@fat_crate.local>
 <20240414090810.GBZhuc-lN6tyKbF_-M@fat_crate.local>
 <edf4fb6f-0f27-44fd-8f2a-ab60a156b20c@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <edf4fb6f-0f27-44fd-8f2a-ab60a156b20c@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713343232;615a079e;
X-HE-SMSGID: 1rx0qC-0003cF-VV



On 17.04.24 10:38, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 14.04.24 11:08, Borislav Petkov wrote:
>> On Sun, Apr 14, 2024 at 10:36:26AM +0200, Borislav Petkov wrote:
>>>> There was an earlier report about this here:
>>>> https://lore.kernel.org/all/78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com/
>>> Am looking at the whole thing. Stay tuned...
>>
>> Something like this, I guess...
>>
>> Execution goes off somewhere into the weeds during alternatives patching
>> of the return thunk while it tries to warn about it in the alternatives
>> code itself and it all ends up in an endless INT3 exceptions due to our
>> speculation blockers everywhere...
>>
>> I could chase it as to why exactly but the warning is there for all
>> those mitigations which need a special return thunk and 32-bit doesn't
>> need them (and at least the AMD untraining sequences are 64-bit only
>> so...).
> 
> Erhard Furtner, did you try if this helps for a kernel with
> MITIGATION_RETHUNK=y? Klara Modin, or could you give it a try?
> 
> Without a check this is unlikely to be merged and then more people might
> run into problems like you two did.

Ignore that, I only not noticed the discussion continued in the other
thread and Klara Modin already provided a tested-by. Sorry for the noise.

Ciao, Thorsten

>> IOW:
>>
>> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
>> index e674ccf720b9..391059b2c6fb 100644
>> --- a/arch/x86/lib/retpoline.S
>> +++ b/arch/x86/lib/retpoline.S
>> @@ -382,8 +382,15 @@ SYM_FUNC_END(call_depth_return_thunk)
>>  SYM_CODE_START(__x86_return_thunk)
>>  	UNWIND_HINT_FUNC
>>  	ANNOTATE_NOENDBR
>> +#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || \
>> +    defined(CONFIG_MITIGATION_SRSO) || \
>> +    defined(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)
>>  	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
>>  		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
>> +#else
>> +	ANNOTATE_UNRET_SAFE
>> +	ret
>> +#endif
>>  	int3
>>  SYM_CODE_END(__x86_return_thunk)
>>  EXPORT_SYMBOL(__x86_return_thunk)
>>

