Return-Path: <linux-kernel+bounces-127521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E4894D04
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8271C21CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D0C3D3A4;
	Tue,  2 Apr 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM2HVAAk"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A932C8B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044598; cv=none; b=W5XQ3Ql4R5IuJhhEp3s3u3AgY6qm30wdmKxbThHzRswC5D7IhZKtJ6McHnYlfAbxggBNieIEOMX4neB/0nILQuAzdnu9prELHi1oXmr2XZ5U7IVw988ZiXYGx27hjE7ma0CRmfaWfF/qoWv4C3E/nXtbPBm88n6K1xF4v5LZB5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044598; c=relaxed/simple;
	bh=x0EspklCfkC2YV0GStcnSeKPru8ZgAjvrE8QiTK8lF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMPWv8tpU9VfeTfMr9n5RtVN5TEWSJhKaT4bRa/v560OG51ZPLPKYrDlIfMMz1bR2hy9rOmwCMEnwJVp+A64jUK1o5dfUFJim1M0v17ujD2hlgUOEPgpHOnyc345ANw3kgDkssb9uoFITdDlFHe9hOZ0FsuTXY/W6YXP8bWuPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZM2HVAAk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78bd22f8257so176225185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712044596; x=1712649396; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sA1QwJwLBEqrda4F42f/VaV+6Ll5yOow+njNrcMa6RI=;
        b=ZM2HVAAkV74TMBPylBf3CCEoBE+n71yg5E5jrUts/mpkPpnCmBjKIfyLDfIi4WPP/d
         57Nfa3jKEX8/509fHMMtJJ8aPmLvy1RVN1vo0ScJzBUdLBUWx6ZvXmLq5nulexdB6b9T
         Tl85AMvUsNqAQdFtCCE0fhps6X27QNvvCnnKRtrVwGZ18fYGVntvrv+nZN9DKqJ+wGTo
         ETjLAuvc+5DpHlBeJLlzdOPwJjdJu5E13mFrnKFAYQx/9SKxq5dz7dOZ4zCNzjFHLdPK
         XgqIADLEzk0Q4nxpj40OJiBv9ZkZvnkDlDMIXA+Z+U04Fg3kfYPUnkx5k+eFW4BY4gIB
         DTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712044596; x=1712649396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sA1QwJwLBEqrda4F42f/VaV+6Ll5yOow+njNrcMa6RI=;
        b=Pub7KvOx3aU4fniGrkRf4wOc+qYANRThnFTnEZQPKp0AEur5661UqCA6dZb+TyMfHl
         qN63sV/R5k4zJ0fc12IU3ZgdnKpN0WsfULmARwimAuGNZZWgpxU1V+sj+nhUevNtNqKe
         o3krmPRHaCNNzl18uzjnnpytNNBBjVmTqD38qwVvFEJcbTXspZ7Ugr1aZsPGvpNQpi0o
         ElNgYQi+9vPwF+058jY23duBQd1QFXlWBZzUKFAWaxUwImW18IsnZjZM4SJxK1T31akE
         2UotnYVMT7hzFfDRW+gMPsKzH+LMo62QbRi2nMe0Li05kaDMKyU/q+ulAz/IGdxoxQFd
         XG2g==
X-Forwarded-Encrypted: i=1; AJvYcCUTm4CQiUnldhIRyHtJdPYZOyj0RBsG++TlZ7RYa6lqDUJOxnBPaqR02m9WhMgnRZIk9NXl0RRF5VBbeabQhrR3II2yZYaq03akgfOG
X-Gm-Message-State: AOJu0YyPh5ddXbaGjZHHbkHzfmbjPhdijbKZFayzt6f5OS0KnCGMHdL3
	+CAq6uJhnZwBsy7GXiWsLtvPeF4Mb86YAgu02cG/eRMfM09ArSPqMYSFK1FrfI209JRdIKxuqcL
	71FJs1ixinibdQ7bZXaEZcSzvsn4=
X-Google-Smtp-Source: AGHT+IFdz4wAJGBe4yh0jdBBWLcVCN6EC3maxyktxBbflQNgbmxjDD2YZkk2qWj034QZoheIx3uutyEc7c8iE5IS8RU=
X-Received: by 2002:a05:622a:d:b0:432:f394:ba6e with SMTP id
 x13-20020a05622a000d00b00432f394ba6emr5226558qtw.64.1712044595970; Tue, 02
 Apr 2024 00:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com>
 <CAFULd4a75kS=3cJzYKsOcJ3ULjW8k5M1cvPYZQ25zZqTo3QX9Q@mail.gmail.com>
In-Reply-To: <CAFULd4a75kS=3cJzYKsOcJ3ULjW8k5M1cvPYZQ25zZqTo3QX9Q@mail.gmail.com>
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Tue, 2 Apr 2024 09:56:24 +0200
Message-ID: <CAFGhKbx3dzrMC0euRMNe5=sAhM87v=6gLwOT+c9HwWKZrWc5Gg@mail.gmail.com>
Subject: Re: warning: cast removes address space '__percpu' of expression
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Luc Van Oostenryck <lucvoo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Am Mo., 1. Apr. 2024 um 21:16 Uhr schrieb Uros Bizjak <ubizjak@gmail.com>:
> > I would even go as far as saying that 1ca3683cc6d2 ("x86/percpu:
> > Enable named address spaces with known compiler version") together
> > with 3a1d3829e193 ("x86/percpu: Avoid sparse warning with cast to
> > named address space") triggered this problem

I think 1ca3683cc6d2 was wrong and is the last working one.


Just switch to 1ca3683cc6d2c2ce4204df519c4e4730d037905a and you won't
see the messages.

```
git reset --hard 1ca3683cc6d2c2ce4204df519c4e4730d037905a
git clean -dfx
make allnoconfig -j$(nproc)
make kvm_guest.config
make prepare -j$(nproc)
touch include/linux/netdevice.h
make C=1 net/core/dev.o CHECK="sparse -Wcast-from-as"
```

Go to 9a462b9eafa6dda16ea8429b151edb1fb535d744 and cherry-pick
3a1d3829e193c091475ceab481c5f8deab385023 and you would see the error.
On amd64  with 12.2.0, this would look like this:

```
git reset --hard 9a462b9eafa6dda16ea8429b151edb1fb535d744
git cherry-pick 3a1d3829e193c091475ceab481c5f8deab385023
git clean -dfx
make allnoconfig -j$(nproc)
make kvm_guest.config
make prepare -j$(nproc)
touch include/linux/netdevice.h
make C=1 net/core/dev.o CHECK="sparse -Wcast-from-as"
```

I would recommend to use `-Wsparse-all` for testing but for this
demonstration, it is easier to use `-Wcast-from-as` to reduce the
amount of noise in the demonstrator.

