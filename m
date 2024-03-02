Return-Path: <linux-kernel+bounces-89451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C05C86F089
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5117D1C20D7E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F9017578;
	Sat,  2 Mar 2024 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew0dk4F5"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27AF514
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709385638; cv=none; b=iUMlQ/dehTCmm8uZKGGEXyJyvxLuLKNIRjC02WDi3fx8XarXSnN2sMkO/D47ISjIHlKbMNlBlcNDzGAVncKROcTYpn2jYe6iJah/OLPjkQ7glFzN3ZDW7Gl6kjTGj85MwVJXm71Jiv+FxTfCynb9giFZ0Oc6CK4i8hwfy+S7I4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709385638; c=relaxed/simple;
	bh=Rdwv6q7zkx/EOKtSwec8hdrK9rTTs1ILER81Xg+YwQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htom24/KYd5NWz2v6aPkGtytA0Gj9urqmv9K2NJhSPDpxe+HjzakHQXqICUk7KsxyjbYN4BrEq64G01gZb+Oisu7i2ksXJzv+rigZGN0QjhJXbnwGBQAK+UDgdgVrsyqZkVGqsYIlAlXGPdY+gz/yQQqY9PFLN8JstcGHOwjhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew0dk4F5; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d204e102a9so29271351fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 05:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709385634; x=1709990434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcVowm1Jltj6dO+lMi7Ntjw1aFwqbehMBV3TDHsUgbM=;
        b=ew0dk4F5cawGl5EZnKnOJsAlqrjTapyRA9iUvdr7jtYFDY3M+A7MaytPSApg3d1ObN
         /HpVPavO64aAoUbUMr6ku5yVgxIePRtoW/Le9EcdcPlgROmi6RTA8OFW67Hc2+/BDWbU
         Te0z41/L/O/0WxzzWzsjxX3lp9q7k4Jmr/7sNQo00IqM0wFb17b+e4NVPF27MPZcSr6b
         pxh7Qy1qFc1ii+5XWy9sfcn+B9UL4Z1m5Qmg+GGfaqUJMlfpyaykQ7xIutOGozAm649u
         b6+uNZMr9UuRGI/wJGsj1WTBr/uq0F3ysZtU/+oBqG1EOj/vPht6WasjAhzyV+k+pT3E
         Z+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709385634; x=1709990434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcVowm1Jltj6dO+lMi7Ntjw1aFwqbehMBV3TDHsUgbM=;
        b=ERQKqgSw73UEIw9L9WUgcQPmjyaIuGHO4PaHXXSq6vodopC0G5t2INVZsFiSjbAl7f
         Jxl3gDwvQIr1LNDNNVgozbVGWQF4CuoaOoZB63EmpupAYmH7AzGOQw2qhuLsCvz7pGbI
         USlwUQhEmKb/HkedaP22dyWWtPTj0YpVETBQzLjzNZmJqWlw2UWMIqNKQvf67/PlsbBc
         eJrFQs24sFqfmjB1a+iuCMIWgD33fPXdEjf7HxdZ4j5gYX+0Jh3cm75nsskUpaleDvbk
         /uAawYWxdoGsVgL0xAROKDIycK5jv/jaJIF5Qq58ZUu+PNlNwR3k6lMQKRe1dJWz0W99
         MDkg==
X-Gm-Message-State: AOJu0YyyfJmQP4LsYHpZw7nrOExDwx55DHXjIL3KWKyey9lMXuOdXH6B
	BnMqsrbJH9Y8CfZyrGrGIc387Tn09j/Sm8TvSu1TbTCOX8Hi/tcihhaRCMl85xvpgkf8vKxh4se
	Pq5R/RItPKkjP3V7+SKZ8O1w17A==
X-Google-Smtp-Source: AGHT+IGFInUMAJn5JRUF6ILMXdJMvHFesYh4gIw050uMzmUrwC8SKPuMdW607qXfkph1oOClhmZYYBgGFa4RpWkppik=
X-Received: by 2002:a19:431d:0:b0:513:2983:75f5 with SMTP id
 q29-20020a19431d000000b00513298375f5mr3210763lfa.5.1709385634235; Sat, 02 Mar
 2024 05:20:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301084046.3370376-1-xin@zytor.com> <CAMzpN2j7xKcGx=+z8mu_2z2RsqjB-mpODdrOH7N1J2_OzuyEUQ@mail.gmail.com>
 <c4fb7c39-c99c-4e4c-bd85-470f5d0dc4dd@zytor.com>
In-Reply-To: <c4fb7c39-c99c-4e4c-bd85-470f5d0dc4dd@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sat, 2 Mar 2024 08:20:22 -0500
Message-ID: <CAMzpN2jpRov_zVp+8qXybS6dtm57uk1pfvRUUKeFGVGnC2G_Wg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] x86/fred: Fix init_task thread stack pointer initialization
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:18=E2=80=AFPM Xin Li <xin@zytor.com> wrote:
>
> On 3/1/2024 5:15 AM, Brian Gerst wrote:
> > On Fri, Mar 1, 2024 at 3:41=E2=80=AFAM Xin Li (Intel) <xin@zytor.com> w=
rote:
> > There is another spot in head_64.S that also needs this offset:
>
> I checked all references to __end_init_task before sending out this
> patch, and I doubt we need to make more similar changes.
>
> First of all, "movq    TASK_threadsp(%rcx), %rsp" you added in
> 3adee777ad0d ("x86/smpboot: Remove initial_stack on 64-bit") is exactly
> what we need to set up %rsp for the init task.
>
> > /* Set up the stack for verify_cpu() */
> > leaq (__end_init_task - PTREGS_SIZE)(%rip), %rsp
>
> As the comment says, it's a _temporary_ stack for calling verify_cpu()
> (but only for BSP, as APs use a different bring up stack), at which
> stage the concept of "task" has not formed. I'm thinking maybe it's
> better to do:
>
> /* Set up the stack for verify_cpu() */
> leaq __end_init_task(%rip), %rsp
>
> Previously it was "leaq    (__end_init_task - FRAME_SIZE)(%rip), %rsp",
> but the kernel unwinder goes up only to secondary_startup_64_no_verify()
> after the new way you introduced to set up %rsp for the init task, and
> it seems to me that there is no point to subtract FRAME_SIZE or
> PTREGS_SIZE.
>
> On the other hand, TOP_OF_KERNEL_STACK_PADDING is required for x86_32,
> but probably not for x86_64 (defined as 0 before FRED). The most
> important usage of TOP_OF_KERNEL_STACK_PADDING is to get the pt_regs
> pointer for a task, i.e., task_pt_regs(task), which assumes a fixed
> offset from the top of a task stack, but also limits the space that
> could be used by future hardware above the pt_regs structure. Thus I
> prefer to limit the usage of TOP_OF_KERNEL_STACK_PADDING on x86_64.

The point is to keep consistency with other kernel threads, which have
the pt_regs area cleared (see copy_thread()).  In particular, the CS
field can't have junk in it or else user_mode(regs) could return the
wrong result.  So the stack needs to start below pt_regs, or we need
to explicitly zero pt_regs later.

Ideally, the load from thread->sp should just shift RSP by phys_base,
pointing to the same memory location in the virtual mapping.

Brian Gerst

