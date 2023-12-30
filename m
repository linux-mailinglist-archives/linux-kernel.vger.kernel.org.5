Return-Path: <linux-kernel+bounces-13592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B27482087E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 21:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC246283BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 20:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12934C2E6;
	Sat, 30 Dec 2023 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z/gENgRA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EDFC139
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cce6c719caso25074351fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 12:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703969966; x=1704574766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XGj2dvokpHswaDS3CEAC9U/qRCEFu6exlHCSnvHBeOU=;
        b=Z/gENgRAkxezGvymyECjXeUAvpAGHbTeQ8RjR9veGDXME9dDIaf9yyPY7FP9bgHDyA
         Vr1ODig1GXeXWh8eh7MjnqrZWfUPs9CR4E0vMMTJKfJgDdStqhr8ix1Nq6UVeM8GxLvi
         glBzUM1FUjByxqIOrawztFdX2BIBB57GRlzMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703969966; x=1704574766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGj2dvokpHswaDS3CEAC9U/qRCEFu6exlHCSnvHBeOU=;
        b=MiY7b5NWrBpyVmV6R+GpzlMP/zUEyZtoVgUrfpfuwL6YxL8A6RGyRiDh4QRBTs1MnA
         znfe/hWb+ZY59WTCr5JkErtTYoRvXN7FaxtCxcagqKP+x/n9cumoVuAWyKZQhoyxPPFo
         OkjTAKBRobPrysUFDnCVW/rpE3hQr6XHMr9QrvPxluepJEfWbVYZIA5JzyvNsTVaHhg0
         Z/p0VFXlHsBMp5FjPb+AStERBp12zn6+ci8WpuX4gnWEvASR87zmXGZEMx0kLQDqPwTw
         +0MMjGM83WuIPBqs2ZJNO5YugQc8M3UhZmeSD7v1aHnCRW+jFbgwePS86E/UUfcQ99eF
         PdVg==
X-Gm-Message-State: AOJu0YzvK9+1DvPg/MPDZw4PfMeQ1e6vWcRfYW3ycLkTBSsyU6J9XFVk
	PkzbTm0vEwPg+FcJQZjkjXVEXa6c6izqz46RVSXjdqlMvY5geg==
X-Google-Smtp-Source: AGHT+IEDrAj1mIf4EDlpJWEQO65PYggdPrTaMAxf7sU0n+0PQD2eJOsfX559lx+dEhXOEiQa/ORaDQ==
X-Received: by 2002:a2e:8794:0:b0:2cc:d547:7efb with SMTP id n20-20020a2e8794000000b002ccd5477efbmr3442929lji.80.1703969966352;
        Sat, 30 Dec 2023 12:59:26 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id e10-20020a2e9e0a000000b002cc6ef9f6b9sm3936008ljk.29.2023.12.30.12.59.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 12:59:25 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e49a0b5caso8753394e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 12:59:25 -0800 (PST)
X-Received: by 2002:a05:6512:3e24:b0:50e:6b5d:5976 with SMTP id
 i36-20020a0565123e2400b0050e6b5d5976mr6269030lfv.40.1703969965196; Sat, 30
 Dec 2023 12:59:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com> <CAHk-=wjbWTbRKDP=Yb9VWBGjSBEGB3dJ0=--+7-4oA2n1=1FKw@mail.gmail.com>
In-Reply-To: <CAHk-=wjbWTbRKDP=Yb9VWBGjSBEGB3dJ0=--+7-4oA2n1=1FKw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Dec 2023 12:59:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsO=ODvUcwi=SPSzvsxW7Gj+3OU8q4CfHa+zMcivF6Bw@mail.gmail.com>
Message-ID: <CAHk-=wjsO=ODvUcwi=SPSzvsxW7Gj+3OU8q4CfHa+zMcivF6Bw@mail.gmail.com>
Subject: Re: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data accesses.
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "longman@redhat.com" <longman@redhat.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, 
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"xinhui.pan@linux.vnet.ibm.com" <xinhui.pan@linux.vnet.ibm.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	Zeng Heng <zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Dec 2023 at 12:41, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> UNTESTED patch to just do the "this_cpu_write()" parts attached.
> Again, note how we do end up doing that this_cpu_ptr conversion later
> anyway, but at least it's off the critical path.

Also note that while 'this_cpu_ptr()' doesn't exactly generate lovely
code, it really is still better than caching a value in memory.

At least the memory location that 'this_cpu_ptr()' accesses is
slightly more likely to be hot (and is right next to the cpu number,
iirc).

That said, I think we should fix this_cpu_ptr() to not ever generate
that disgusting cltq just because the cpu pointer has the wrong
signedness. I don't quite know how to do it, but this:

  -#define per_cpu_offset(x) (__per_cpu_offset[x])
  +#define per_cpu_offset(x) (__per_cpu_offset[(unsigned)(x)])

at least helps a *bit*. It gets rid of the cltq, at least, but if
somebody actually passes in an 'unsigned long' cpuid, it would cause
an unnecessary truncation.

And gcc still generates

        subl    $1, %eax        #, cpu_nr
        addq    __per_cpu_offset(,%rax,8), %rcx

instead of just doing

        addq    __per_cpu_offset-8(,%rax,8), %rcx

because it still needs to clear the upper 32 bits and doesn't know
that the 'xchg()' already did that.

Oh well. I guess even without the -1/+1 games by the OSQ code, we
would still end up with a "movl" just to do that upper bits clearing
that the compiler doesn't know is unnecessary.

I don't think we have any reasonable way to tell the compiler that the
register output of our xchg() inline asm has the upper 32 bits clear.

              Linus

