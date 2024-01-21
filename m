Return-Path: <linux-kernel+bounces-32111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90A883569F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67867281D8B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EBB37714;
	Sun, 21 Jan 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWK5XkWW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB63770E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705854031; cv=none; b=bvRlciAeyWyXoSOe92ug8di6K+qA7JFJ1jFcHjnkMXjVJ9p3Cn/MkLXMpnw8pM1cCvfcoi5y0innObF70Etllx7iKAStWmELqkkmbZl9inwudP+KGxk2yNsV2SQaBe4HfmMJEgae1MG8UzLFDatXQzPkyTEoZX4V8NxGKxXVAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705854031; c=relaxed/simple;
	bh=jH1gywoYqVxjp8+XbwBdiS52w3k77mgzDxFnmO+Ld5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcAo/bQXXAMo/hPGQQsw/ZrLmjbRWICTddxJEqnGR1CmZ+/VHfs4bob25DLwkd/ojW2ZinENePX+OwD0VnB57LE/7Cfshc1v+94YS9DGsrqiXzzpDPmDSqXRJHnTT1ipRknpZ4EqsfY0r0JXaESuwBeVQODN/KAoEtVCMPMZ4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWK5XkWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09E5C433F1;
	Sun, 21 Jan 2024 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705854031;
	bh=jH1gywoYqVxjp8+XbwBdiS52w3k77mgzDxFnmO+Ld5U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sWK5XkWWLn+hGKXP4iaPFLcgM1818T7UMltbkbdNF2pFIwKjRbiOZieL1dY2zBJij
	 IaM2/shJfNwGm0QhHFGuMVRTi28WnwMiVUAp3zQIZGJoisS9KsiG0BSS1kJQP5Q2nn
	 uF+NSM0aCRPJ2Tivxwe53Ze0UtrROBX+JIHvtPzQy3NpF2cHqHVDC3XvnyWaCpKHpg
	 So6Xl7UfOaNDdIy2wS2RZc8CvNbXQT8r3XFt4AZTd3r6O7778IHMG+egBiZJLU7vS6
	 WMJzh9CSdkX5K3vjNRsYfgd0e1v6a2/lQ/Gg5B1fL2RHDV9/LL9YZg49D7M5vAKVvF
	 XH5dnhYN3sIRQ==
Message-ID: <a2517861-cfd4-4ddd-b6b9-faedcd229da8@kernel.org>
Date: Sun, 21 Jan 2024 17:20:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip v2] x86/kprobes: Drop removed INT3 handling code
Content-Language: en-GB, fr-BE
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
 Jinyang He <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
References: <166981518895.1131462.4693062055762912734.stgit@devnote3>
 <06cb540e-34ff-4dcd-b936-19d4d14378c9@kernel.org>
 <20240120170517.5cadbc20@rorschach.local.home>
 <20240121112852.381ebd7bf37ea6d2236db9f2@kernel.org>
 <20240121180544.8c663977651d2a18291318d5@kernel.org>
 <f8bbf989-f709-4ceb-af5c-87e1e20de914@kernel.org>
 <20240121103144.4bf735c6@rorschach.local.home>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240121103144.4bf735c6@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Steven,

On 21/01/2024 16:31, Steven Rostedt wrote:
> On Sun, 21 Jan 2024 16:23:35 +0100
> Matthieu Baerts <matttbe@kernel.org> wrote:
> 
>> Hi Masami, Steven,
>>
>> On 21/01/2024 10:05, Masami Hiramatsu (Google) wrote:
>>> On Sun, 21 Jan 2024 11:28:52 +0900
>>> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>>>   
>>>> On Sat, 20 Jan 2024 17:05:17 -0500
>>>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>>>  
>>>>> On Sat, 20 Jan 2024 18:44:38 +0100
>>>>> Matthieu Baerts <matttbe@kernel.org> wrote:
>>>>>  
>>>>>>
>>>>>> I'm sorry to reply on a patch that is more than one year old, but in  
>>>>>
>>>>> No problem, I've done the same.  
>>>>
>>>> Yeah, thanks for reporting! I realized the problem.  
>>
>> Thank you both for your quick reply, very useful explanations, analysis
>> and patch!
>>
>> (...)
>>
>>> So this another solution is already done. I think we need to add the
>>> ghost INT3 check in the exc_int3() as follows;
>>>
>>> Thank you,
>>>
>>> From add8cf7da99cdb096a0d6765b3dc5de9a3ea3019 Mon Sep 17 00:00:00 2001
>>> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
>>> Date: Sun, 21 Jan 2024 17:16:50 +0900
>>> Subject: [PATCH] x86: Fixup from the removed INT3 if it is unhandled
>>>
>>> INT3 is used not only for software breakpoint, but also self modifying
>>> code on x86 in the kernel. For example, jump_label, function tracer etc.
>>> Those may not handle INT3 after removing it but not waiting for
>>> synchronizing CPUs enough. Since such 'ghost' INT3 is not handled by
>>> anyone because they think it has been removed already.
>>> Recheck there is INT3 on the exception address and if not, ignore it.
>>>
>>> Note that previously kprobes does the same thing by itself, but that is
>>> not a good location to do that because INT3 is commonly used. Do it at
>>> the common place so that it can handle all 'ghost' INT3.  
>>
>> I just tested it, and I was able to run pings for 3h without any issues!
>>
>> While at it, and just to be on the safe side, I also re-run the tests
>> after having added a "pr_warn()" -- I know, using printk(), especially
>> when talking to you... but I was not sure what was safe to use at this
>> place in the code :) -- before returning "true" in the new function you
>> added, and we can see that the crash is avoided thanks to the new code:
>>
>> [   27.422518] traps: crash avoided, addr=18446744071882050317
>> [   27.426182] traps: crash avoided, addr=18446744071882050317
>>
>> [  370.483208] traps: crash avoided, addr=18446744071882075656
>> [  370.485066] traps: crash avoided, addr=18446744071882075656
>> [  370.485084] traps: crash avoided, addr=18446744071882075656
>>
>> [  592.866416] traps: crash avoided, addr=18446744071882075656
>> [  592.867937] traps: crash avoided, addr=18446744071882075656
>>
>> [  980.988342] traps: crash avoided, addr=18446744071882050317
>> [  980.989866] traps: crash avoided, addr=18446744071882050317
>>
>> (from my VM running with 2 CPU cores)
>>
>>
>> Again, thank you for the fix!
>>
>> (Just in case you need it:)
>>
>> Tested-by: Matthieu Baerts <matttbe@kernel.org>
> 
> The thing is, the bug is with qemu and *not* the kernel. Masami's patch
> just paper's over the real bug, and worse, if the kernel has a bug
> that's not doing proper synchronization, the patch will keep it from
> being detected. So no, I do not think this is the proper solution.
> 
> The real problem is that qemu does not seem to be honoring the memory
> barriers of an interrupt. The reason the code does the ipi's is to
> force a full memory barrier across all CPUs so that they all see the
> same memory before going forward to the next step.
> 
> My guess is that qemu does not treat the IPI being sent as a memory
> barrier, and then the CPUs do not see a consistent memory view after
> the IPIs are sent. That's a bug in qemu!
> 
> This should be reported to the qemu community and should be fixed
> there. In the mean time, feel free to use Masami's patch in your local
> repo until qemu is fixed, but it should not be added to Linux mainline.

Thank you for the explanation!

For QEmu, I'm currently not using a recent version: v6.2.0, while the
latest one is v8.2.0. I was already suspecting that QEmu could be
responsible for this issue -- we don't have the issue with KVM, only TCG
-- but it looks like it is not that easy to upgrade it: for the CI, we
use virtme, which doesn't support newer versions. We will switch to
virtme-ng, upgrade QEmu to a version that is still supported, try to
reproduce the issue without Masami's patch, and report that to QEmu
community.

For the time being, the CI will run the tests with Masami's patch.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

