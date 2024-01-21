Return-Path: <linux-kernel+bounces-32081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0AD835643
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B0D281C59
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E62376E2;
	Sun, 21 Jan 2024 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e26Lo+Cx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00682EB19
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705850621; cv=none; b=I1zmfnJR4PbOFOhv1eEutUfdY0YN3w9TteCexlP3sHXoojorDy/+eQ/aU2I2hoPfRgcHxpSubYyihQ7b1pLp0XJoetNWXnsRRb7QpKNzJ7HFY6E40sq7tyH0BoBK8CQBPd4CmQu653q4YqlgHAkuW5ZDV3osJm220eO1Gg/YVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705850621; c=relaxed/simple;
	bh=ZwcDC2Zn8owVk+p5ZZRsu7MNXT2ErpX+qzUlu6bk/vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7djTgNIvLaw41aDMZlvGvbFdABkMlnqp3nSakNgMZ16m0ynRBfUk618ODzSTn+lH+cA4N0Ze921n06Kwv9ALqsBwMhhA/r9+H+iHoobUtt60EGO5AA+AgAM13CYE+/OC7NbKUuyKqb9p1CnFaoK/AMXJd4BBkjOQg1/slPHy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e26Lo+Cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13794C433C7;
	Sun, 21 Jan 2024 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705850620;
	bh=ZwcDC2Zn8owVk+p5ZZRsu7MNXT2ErpX+qzUlu6bk/vQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e26Lo+CxZF3GUS4gF0wtqguwOrTOz5xSZBMwHtXyMAExyVjyQW6yPYJoNCK5vn7ik
	 RB4ceRLq2hvcWKV6bFAHolQpbzW69o6B7gbmIHONXMZ2FL9TTtOUY3qeGSqImh7CsC
	 1Z/ES6IcZFGPuSBH49DKcWJBDPOXm03cb8EKQmIlVmjgOfWv25T4DwL+3QVWj2o5uR
	 xk7mUqW4x8KGRkSODbIbCn/J04Pv8oCALfnhwPuucsi3YB5v74p0LgAq2L6xDi59Ae
	 rSlozA+bQ0KyqeFDleNPxTL7Po3Q4OzouqeQj3+Rkx97KV478IoY+/0d6rqVsytDz0
	 XabeXBHemOyQA==
Message-ID: <f8bbf989-f709-4ceb-af5c-87e1e20de914@kernel.org>
Date: Sun, 21 Jan 2024 16:23:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip v2] x86/kprobes: Drop removed INT3 handling code
Content-Language: en-GB, fr-BE
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
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
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240121180544.8c663977651d2a18291318d5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Masami, Steven,

On 21/01/2024 10:05, Masami Hiramatsu (Google) wrote:
> On Sun, 21 Jan 2024 11:28:52 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
>> On Sat, 20 Jan 2024 17:05:17 -0500
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> On Sat, 20 Jan 2024 18:44:38 +0100
>>> Matthieu Baerts <matttbe@kernel.org> wrote:
>>>
>>>>
>>>> I'm sorry to reply on a patch that is more than one year old, but in
>>>
>>> No problem, I've done the same.
>>
>> Yeah, thanks for reporting! I realized the problem.

Thank you both for your quick reply, very useful explanations, analysis
and patch!

(...)

> So this another solution is already done. I think we need to add the
> ghost INT3 check in the exc_int3() as follows;
> 
> Thank you,
> 
> From add8cf7da99cdb096a0d6765b3dc5de9a3ea3019 Mon Sep 17 00:00:00 2001
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Date: Sun, 21 Jan 2024 17:16:50 +0900
> Subject: [PATCH] x86: Fixup from the removed INT3 if it is unhandled
> 
> INT3 is used not only for software breakpoint, but also self modifying
> code on x86 in the kernel. For example, jump_label, function tracer etc.
> Those may not handle INT3 after removing it but not waiting for
> synchronizing CPUs enough. Since such 'ghost' INT3 is not handled by
> anyone because they think it has been removed already.
> Recheck there is INT3 on the exception address and if not, ignore it.
> 
> Note that previously kprobes does the same thing by itself, but that is
> not a good location to do that because INT3 is commonly used. Do it at
> the common place so that it can handle all 'ghost' INT3.

I just tested it, and I was able to run pings for 3h without any issues!

While at it, and just to be on the safe side, I also re-run the tests
after having added a "pr_warn()" -- I know, using printk(), especially
when talking to you... but I was not sure what was safe to use at this
place in the code :) -- before returning "true" in the new function you
added, and we can see that the crash is avoided thanks to the new code:

[   27.422518] traps: crash avoided, addr=18446744071882050317
[   27.426182] traps: crash avoided, addr=18446744071882050317

[  370.483208] traps: crash avoided, addr=18446744071882075656
[  370.485066] traps: crash avoided, addr=18446744071882075656
[  370.485084] traps: crash avoided, addr=18446744071882075656

[  592.866416] traps: crash avoided, addr=18446744071882075656
[  592.867937] traps: crash avoided, addr=18446744071882075656

[  980.988342] traps: crash avoided, addr=18446744071882050317
[  980.989866] traps: crash avoided, addr=18446744071882050317

(from my VM running with 2 CPU cores)


Again, thank you for the fix!

(Just in case you need it:)

Tested-by: Matthieu Baerts <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

