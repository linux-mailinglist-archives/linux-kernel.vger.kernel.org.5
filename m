Return-Path: <linux-kernel+bounces-128667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EDD895DE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523E8B283B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79115DBC5;
	Tue,  2 Apr 2024 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="l1ueu5KH"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D32B9D8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090336; cv=none; b=VGsnWNZIYK/jnicx3PIfA9lihBszSbVa8wvjDrCxSyL7l2oskQD4c5HJ5RZnDQdjjberql3A/QRXb3yXaD9Uvf1fuRw8aTgdpSzBh2VYt9MJ/uEqfeHZg8JF+SDR8iXedNAcR3BvbPNf0MoQ6FKkQnqYEMYekz9SuH9Wk6Jl+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090336; c=relaxed/simple;
	bh=E4417AKAEISKOWN5UtcRGOvu82prr0VpEHlDBOHug/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okV8SleDvie75jtA/xTPghwxAMJmMi6jfgsRA1MBdQQPILtXio/5BA9snRZ/HYiCi6/Uh++RZF5u026J/XmyjnxxXrYy7Wq+1ycai0Twc0BtXvLo1XfK6RHlt3Sl6s9IvpPlz0ap2XUK8LIF5SIK7ANccxffMSOhBy3BPbtt/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=l1ueu5KH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6b22af648so233945b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712090334; x=1712695134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E4417AKAEISKOWN5UtcRGOvu82prr0VpEHlDBOHug/c=;
        b=l1ueu5KHL+0PYx9li6q6sib/GJvbXGwAyo5yTKCghGfX1Q+5ABoFEhDc5tVAv9lWvm
         KqyBeKHnESarlzKGoguK2U0Al08FDBl8hc4QGmqkcaKpb97P3v1B7s5QubFyMz/k05vi
         lBif+U6HYzjq12cUx9h22GJaozeiTKaOAKdWmj5Ogdnq6psE+yrmQQfxEALbF20AqDis
         guG/C8Rjn4OzvhtP7/3pzNRvXVkbTpIlPI+a378+YEwcmcohzpmmIBI2gMod2PKBxdf3
         h+RX0sjEzAAewUvjb8fGFfg015XYkaAZUG3r4+OoXLVb46v5HD32SnPzPtSq3jnSiG0l
         g3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712090334; x=1712695134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4417AKAEISKOWN5UtcRGOvu82prr0VpEHlDBOHug/c=;
        b=wDv/xaN63oQ2VaX9VtMPTUKrt7gI+tqOPrJaFR8X9pG8FJUJM5t3rvaOZUf5C/05SV
         W8ear+vkbWV5OiNig7q1hYEXJE0O9tasCeWbGa11X8Zrp86rxrMGZus97eo66l2ODB94
         sKDAAbu5G27vtpYVq0t+yFUwPwYAPO+bNAIWyOM66Kejs6vaKGJVBjpZ6+1kTMHY/aDA
         3wPUD6SKm5LY7u1b2ksHKLwdc0EI2lZg/+gPZsA0vQunDw0madVtTdGlHFtI2ZHPr5ZL
         g2qUQOEVFfwdLwU+PVQ3WPv3h4EAWUY3gr7z1YyzMMWy79kE9nzItHRrTEFcSYkVlq9C
         1DhA==
X-Forwarded-Encrypted: i=1; AJvYcCUSB67btVdrKwVGN32KxAy1F7hE70FA43p6nojXmuTjVcztaL/WhhAyEHCtm/Lr8mNEUzFF24BANlv1XPDcMt0QtuNdVHURQlkNY2YE
X-Gm-Message-State: AOJu0Yx9auGwQvMC/FX+P+bShL6/Vsn1bQt3e1BSypVe0uDa0WOy5Hgc
	7fAOFCyPPFj+1z54GBXi8P5Oej26Ks+70X3DuohRtSqLIkiaQI5jXhRlH7C+q+cI1W3YYS4Y0Y4
	mlbc=
X-Google-Smtp-Source: AGHT+IGhtKnvkThzXZfh20dMVKfZp4QTGsDJ7hiAV5zjA6214XeJ1u6Mg5QprLGrMqYA/Hy0m+LIbA==
X-Received: by 2002:a05:6a21:7883:b0:1a3:8d32:c182 with SMTP id bf3-20020a056a21788300b001a38d32c182mr753936pzc.11.1712090333978;
        Tue, 02 Apr 2024 13:38:53 -0700 (PDT)
Received: from [10.0.16.165] ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id b4-20020a63cf44000000b005e2b0671987sm10130533pgj.51.2024.04.02.13.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 13:38:53 -0700 (PDT)
Message-ID: <1bea609b-0acb-4adf-902c-e7e94de40977@rivosinc.com>
Date: Tue, 2 Apr 2024 13:38:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM SVE ABI: kernel dropping SVE/SME state on syscalls
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Andrew Waterman <andrew@sifive.com>,
 Palmer Dabbelt <palmer@rivosinc.com>, lkml <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
References: <bc21c53f-23b9-4596-b757-fc7707f91f24@rivosinc.com>
 <ZgxKXy6r0X7Whu5U@FVFF77S0Q05N>
Content-Language: en-US
From: Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <ZgxKXy6r0X7Whu5U@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+CC Bjorn

On 4/2/24 11:11, Mark Rutland wrote:
> On Wed, Mar 27, 2024 at 05:30:00PM -0700, Vineet Gupta wrote:
>> Hi Will, Marc,

Thx for the reply and apologies for fat-fingering your name above.

>> 1. The vector store instruction (in say bash) takes a page fault, enters
>> kernel.
>> 2. In PF return path, a SIGCHLD signal is pending (a bash sub-shell
>> which exited, likely on different cpu).
> At this point, surely you need to save the VTYPE into a sigframe before
> delivering the signal?

Yes we do.

>> 3. kernel resumes in userspace signal handler which ends up making an
>> rt_sigreturn syscall - and which as specified discards the V state (and
>> makes VTYPE reg invalid).
> The state is discarded at syscall entry, but rt_sigreturn() runs *after* the
> discard. If you saved the original VTYPE prior to delivering the signal, it
> should be able to restore it regardless of whether it'd be clobbered at syscall
> entry.
>
> Surely you *must* save/restore VTYPE in the signal frame? Otherwise the signal
> handler can't make any syscall whatsoever, or it's responsible for saving and
> restoring VTYPE in userspace, which doesn't seem right.

Indeed I later realized that sigreturn is special as it has its own
state to restore. The discard prior drops the state during signal
handler which is anyways transient / throw-away so doesn't hurt this
specific case.

>> 4. When sigreturn finally returns to original Vector store instruction,
>> invalid VTYPE triggers an Illegal instruction which causes a SIGILL (as
>> state was discarded above).
>>
>> So there is no way dropping syscall state would work here.
> As above, I don't think that's quite true. It sounds to me like that the actual
> bug is that you don't save+restore VTYPE in the signal frame?

We do, but there was indeed a different bug which Bjorn found, in
sigreturn V state restore where we were (re)clobbering the V state by
using V-regs in copy-from-user and returning back with that ill restored
state.

>> How do you guys handle this for SVE/SME ? One way would be to not do the
>> discard in rt_sigreturn codepath, but I don't see that - granted I'm not
>> too familiar with arch/arm64/*/**
> IIUC this works on arm64 because we'll save all the original state when we
> deliver the signal, then restore that state *after* entry to the rt_sigreturn()
> syscall.
>
> I can go dig into that tomorrow, but I don't see how this can work unless we
> save *all* state prior to delivering the signal, and restoring *all* that state
> from the sigframe.

You don't have to, Bjorn found the bug and he'll post a fix to lists soon.

Thx,
-Vineet

