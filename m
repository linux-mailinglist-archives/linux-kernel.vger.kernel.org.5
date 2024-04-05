Return-Path: <linux-kernel+bounces-132689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8F18998A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C7DB21DC2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEED15FCEE;
	Fri,  5 Apr 2024 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIrPQ3fO"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB3611E;
	Fri,  5 Apr 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307382; cv=none; b=Ve8bWcb+cy26rOm6mdmEVTY+WDtA1Ge2ul3veXoAFsTIvQOYbGX/HaU2xwb+Jl1kPN6uA3cej/2XWqZYkNRhyTAwp0hbjJ3Jz44OW9b/jmCWX5mJJgbON2ZvPp7ZyWNolmz+V6P0eq6JtNxPPSuKXW6xuVpNTca+DUNoRldPDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307382; c=relaxed/simple;
	bh=9mH29mPxAOKPezMYs3FWiNFuq+e72vmkdp75jHJFhvk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+CM7z9koMmlY85cOEM0h3ZZgYsB50qx8yjFnJ4iyio/DjAvWiCXWJWL5qBCJhEAN4a47EzlQuHHrvAFSLDdqLmCTlh9MkEWe+2MJ8ft4PWW7wSEDlzeopQ6cs1eDIYsTnb089BsOVV+UzUEJI81K9UcNQ53XuLg7Az9L19gBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIrPQ3fO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56df87057bbso2004020a12.3;
        Fri, 05 Apr 2024 01:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712307379; x=1712912179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTuc9EJwZIHipEqAi292Whn+sPWqCiAHFZmxuUeoSkY=;
        b=WIrPQ3fOTArPaZaCtyXuurtNGgyR7P+rsSjgTTd6rDq21UKa+C6T4mHvHo9Tq04ARW
         TUjS42aUZR0fG0TdcR5xU7MPMmpBRV1W6ZOsAVaYAZZ8XAYrWf6eniVnMg/S1SnJXEUR
         USsMGuvH6A+OBYVuBGehwP/l0Zjs1OO3KF2V9Wd0PnU6eVyYUSTKBy+isOsN9yJoua7s
         uoDlMlP2mwebeU+oBTYzEH2omp1LhbMaWdCgSD7ACWVB4KT2Z7stOCwHZqgK0Y/0hUfL
         1a/QDoC6GJlY0jFUQ68b1rIbYj4bnUJk3Zdw4nM0kNeAD0LiGTIamNbOUGH9dPVMDF+O
         BzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712307379; x=1712912179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTuc9EJwZIHipEqAi292Whn+sPWqCiAHFZmxuUeoSkY=;
        b=Dhk2751snr76CzKjBoDHORmIG663/DG4212oDjQgqyGXo0fX+0PW/wA9WADNbbTw7X
         AUseiXMGapdrGrnDnbA7zYr13YS2kNikc6CQlo+7JLKAu7pIK0kbeHzEynIw/awOwryJ
         BCW0zYbPuQzjxnaJuJY8hnJMLq9pUajO7hgk86DUlyhdq5XE6A4KNnHN56Iuz17OtsfI
         zoRyQRwQWZTspCxAPfpmRJC+qgcuRgSYNZU2p72q5FwGh+iVbculPF5oEKwFz4I7BVMQ
         R9FxlAsdjWmDV9LsXaA0MR+KO3Sb4NCnGsUvKTecbkpjb5h0CC1Lnx65UL1tQavn1N7A
         Prng==
X-Forwarded-Encrypted: i=1; AJvYcCXOxNOMxYhyVRxThEaT3GXNYKh6EpPlZykkkpQlbuh191XencLGF3cVEVSgcGWnu1gujre2uIRCBC23gTXqTWmgbqQrA1kYvjPU1V8rfydw64EJDda26aKRltOHWcfESTJS3IWFIMaegJJAP0MhwtlDOparfxqL3aS+VbmbivQvjbs5bMhntAUR3KXsu+huc8fIQKexqPMi2XRyaavEkV9Y
X-Gm-Message-State: AOJu0YwDBaMQs8WloiSqGx4UWDosur0W4zO/YsTu2l2CPU/rXLExNzYE
	krjWfbhnhYK9eCUZ5imCKlOYJlcQKNCoDQZJEtmN3hP9drE1M1px
X-Google-Smtp-Source: AGHT+IH8u6z6LZMoimxuXhlPOWiRu65ig2OfNbn7jhKaH1xlHNq6MOqkQjgf4Zy/I+i4HPS8WNS20Q==
X-Received: by 2002:a50:8d11:0:b0:56e:cde:8983 with SMTP id s17-20020a508d11000000b0056e0cde8983mr667980eds.7.1712307378387;
        Fri, 05 Apr 2024 01:56:18 -0700 (PDT)
Received: from krava ([83.240.63.239])
        by smtp.gmail.com with ESMTPSA id a1-20020a508581000000b0056e2432d10bsm562570edh.70.2024.04.05.01.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 01:56:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 Apr 2024 10:56:15 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-ID: <Zg-8r63tPSkuhN7p@krava>
References: <20240402093302.2416467-2-jolsa@kernel.org>
 <20240403100708.233575a8ac2a5bac2192d180@kernel.org>
 <Zg0lvUIB4WdRUGw_@krava>
 <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
 <CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
 <20240404095829.ec5db177f29cd29e849169fa@kernel.org>
 <CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
 <20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
 <20240404161108.GG7153@redhat.com>
 <20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>

On Fri, Apr 05, 2024 at 10:22:03AM +0900, Masami Hiramatsu wrote:
> On Thu, 4 Apr 2024 18:11:09 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
> 
> > On 04/05, Masami Hiramatsu wrote:
> > >
> > > Can we make this syscall and uprobe behavior clearer? As you said, if
> > > the application use sigreturn or longjump, it may skip returns and
> > > shadow stack entries are left in the kernel. In such cases, can uretprobe
> > > detect it properly, or just crash the process (or process runs wrongly)?
> > 
> > Please see the comment in handle_trampoline(), it tries to detect this case.
> > This patch should not make any difference.
> 
> I think you mean this loop will skip and discard the stacked return_instance
> to find the valid one.
> 
> ----
>         do {
>                 /*
>                  * We should throw out the frames invalidated by longjmp().
>                  * If this chain is valid, then the next one should be alive
>                  * or NULL; the latter case means that nobody but ri->func
>                  * could hit this trampoline on return. TODO: sigaltstack().
>                  */
>                 next = find_next_ret_chain(ri);
>                 valid = !next || arch_uretprobe_is_alive(next, RP_CHECK_RET, regs);
> 
>                 instruction_pointer_set(regs, ri->orig_ret_vaddr);
>                 do {
>                         if (valid)
>                                 handle_uretprobe_chain(ri, regs);
>                         ri = free_ret_instance(ri);
>                         utask->depth--;
>                 } while (ri != next);
>         } while (!valid);
> ----
> 
> I think this expects setjmp/longjmp as below
> 
> foo() { <- retprobe1
> 	setjmp()
> 	bar() { <- retprobe2
> 		longjmp()
> 	}
> } <- return to trampoline
> 
> In this case, we need to skip retprobe2's instance.
> My concern is, if we can not find appropriate return instance, what happen?
> e.g.
> 
> foo() { <-- retprobe1
>    bar() { # sp is decremented
>        sys_uretprobe() <-- ??
>     }
> }
> 
> It seems sys_uretprobe() will handle retprobe1 at that point instead of
> SIGILL.

yes, and I think it's fine, you get the consumer called in wrong place,
but it's your fault and kernel won't crash

this can be fixed by checking the syscall is called from the trampoline
and prevent handle_trampoline call if it's not

> 
> Can we avoid this with below strict check?
> 
> if (ri->stack != regs->sp + expected_offset)
> 	goto sigill;

hm the current uprobe 'alive' check makes sure the return_instance is above
or at the same stack address, not sure we can match it exactly, need to think
about that more

> 
> expected_offset should be 16 (push * 3 - ret) on x64 if we ri->stack is the
> regs->sp right after call.

the syscall trampoline already updates the regs->sp before calling
handle_trampoline

        regs->sp += sizeof(r11_cx_ax);

jirka

