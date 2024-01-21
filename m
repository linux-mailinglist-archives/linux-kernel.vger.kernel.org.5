Return-Path: <linux-kernel+bounces-32195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 810CE835805
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5DAFB20DC8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986738DE7;
	Sun, 21 Jan 2024 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlllRKS5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226EC1E4A7
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705874367; cv=none; b=QjSZoccRtg51/wjhxU3HtMEFNzi6UZwdmZNK/LiIwiX1Vm0JGtLAL2OF/WsjuEaXlUZ3Rfls6pP+fTVshyjBCGcwytjEV41zXPi4G0qmtdr+ROgnuRv+GjZ4u0O4e16g5GEpJDxqkq3WFW+ONU5GMOgKESN0BZCnnq9pRwXPi9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705874367; c=relaxed/simple;
	bh=/jYiK26STCXYyt+lGnnT6MoAGgLiLgYemonFTIAbdqY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ibotrBLTftbS2lcZlYNFZVAhY29753uth1A3Fj5jrlE/nCFxM865btLNAmw8MoVe+mYbzbuyyFdfnsPfAcH7QWKEScfBUqu/9Tb0Wo4q2BD2jc3bk846zL78Mibr6BvZJYdKlMUY/nTK7RQMTyD7E8G+2brLt9jzgkN5b5Cz0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlllRKS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D49C433C7;
	Sun, 21 Jan 2024 21:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705874366;
	bh=/jYiK26STCXYyt+lGnnT6MoAGgLiLgYemonFTIAbdqY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=DlllRKS5MxmHGvbE734OVuQSK2qVxFRgqhIXCiElYk/ueRIbv1LP+pmN0Tzf/FXHQ
	 igjidLyGDN7FjFGeKNsRhZ7qdXX3FSR8PYySEdf5Vd1XJagoRh72BCci0Jm4nKl+Qf
	 Uw4Xrn5j6uVLc6cXeVDFPaVm5YGSUaVjbKwBbJQEYNF4mM2jTUVQ3+qn5nLmTT5W1y
	 htl+hYUHmY3o4I1J8ZwnoPJ95FL4kB0J+hGt9c303JmauBmPTesedfqBbEms/QNOWO
	 Lnm7atVYTaehmaDymp+7NHB0KNpkGXO7s5tCWJybkxXmXTzF2xQny43n6B9b1K8+CK
	 RQpiQ+y6himYw==
Message-ID: <074e3e38-f0bc-4ab3-8051-1cce7923987d@kernel.org>
Date: Sun, 21 Jan 2024 22:59:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip v2] x86/kprobes: Drop removed INT3 handling code
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
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
 <a2517861-cfd4-4ddd-b6b9-faedcd229da8@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a2517861-cfd4-4ddd-b6b9-faedcd229da8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Steven,

On 21/01/2024 17:20, Matthieu Baerts wrote:
> On 21/01/2024 16:31, Steven Rostedt wrote:

(...)

>> The thing is, the bug is with qemu and *not* the kernel. Masami's patch
>> just paper's over the real bug, and worse, if the kernel has a bug
>> that's not doing proper synchronization, the patch will keep it from
>> being detected. So no, I do not think this is the proper solution.
>>
>> The real problem is that qemu does not seem to be honoring the memory
>> barriers of an interrupt. The reason the code does the ipi's is to
>> force a full memory barrier across all CPUs so that they all see the
>> same memory before going forward to the next step.
>>
>> My guess is that qemu does not treat the IPI being sent as a memory
>> barrier, and then the CPUs do not see a consistent memory view after
>> the IPIs are sent. That's a bug in qemu!
>>
>> This should be reported to the qemu community and should be fixed
>> there. In the mean time, feel free to use Masami's patch in your local
>> repo until qemu is fixed, but it should not be added to Linux mainline.
> 
> Thank you for the explanation!
> 
> For QEmu, I'm currently not using a recent version: v6.2.0, while the
> latest one is v8.2.0. I was already suspecting that QEmu could be
> responsible for this issue -- we don't have the issue with KVM, only TCG
> -- but it looks like it is not that easy to upgrade it: for the CI, we
> use virtme, which doesn't support newer versions. We will switch to
> virtme-ng, upgrade QEmu to a version that is still supported, try to
> reproduce the issue without Masami's patch, and report that to QEmu
> community.

FYI, I managed to upgrade QEmu to 8.2.0, and launch the tests: I was not
able to reproduce this issue.

I guess the bug has already been fixed, I'm sorry for the noise!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

