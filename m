Return-Path: <linux-kernel+bounces-138388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E79789F093
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F32284653
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4251598EB;
	Wed, 10 Apr 2024 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox8VhrXm"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EE15920A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748293; cv=none; b=owJfUbtUmfWTm7eziAZk+IMOF93z4sQWBuc91WZZqLMwWJ5e5J0w0rMaMLOPznwDbkPfSvcLyvvSK3FAialt/j8AN5It6UccGrDXwxkV7S6pV2qxScbMtgmVWPBP24ABsLqnidWy00yzVkTCzdxuQYfj5+jMGNycDiUn+zbuV74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748293; c=relaxed/simple;
	bh=RulsX+ZQ0xI3FOCjWtjixDk2aZyRKbqsfynJZlC85YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlRTY1FxN5sA3w/375Qup45bDmLALrPya8B0m+UUbWWyOrdbCaKHyyqOxZikzV+7ItJxWiWORGlWtjOdCi74oDETpFZbkY1B84oI46IVCy3rStiYGpjQq45O82WOhPANPRnNEe22FMhAIS2ioFUoqiOe5h8hj0I65JCDz1/nr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox8VhrXm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343b92e54f5so4901368f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712748290; x=1713353090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RulsX+ZQ0xI3FOCjWtjixDk2aZyRKbqsfynJZlC85YY=;
        b=Ox8VhrXmKiHq+SvF3G29BpvLWpw6MPYqumFLi7bTOs9tyaTvSAuc5bJEuxCXLhZQlY
         ZekobgtnuYeIAmZjt8gksIH/X1/B4UIE7avsfb0pdu6oJRs4NX2vbNqs9a+vUKLkne9v
         ym5xmFFbnLbjBWrSlPdYOCPQOI0DKvUyhwx9Ck714GeIQm9a+XLMA/KDKeVnucGbsWQd
         P15E5Zg9ht58UM117dPDuEaOCRCp9qEbA6Dc3xjUXpejzfBhym6QEN6HfTmgUwF+hD9i
         kPe+0z6ZZ7OYva+LItUxf/XcXIqEHjF2KTDu301OyjN6XX1r6xt4bnZcbVP0liNniYaM
         2hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712748290; x=1713353090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RulsX+ZQ0xI3FOCjWtjixDk2aZyRKbqsfynJZlC85YY=;
        b=hoPOeM52uf9CxxRH16idlYNe8OhJ68neoDd/4FzfBRTsThQiQ3HBullBN/QB4/LPGT
         HQF0p6zz6G0asp+BSKjZTQ5M7egBCFV02TbPcnwPqYUvZ7Ag9msHVqxmwY1Nlxlk7cdq
         EtQQKkH8YnajZhI8AKyhcFCrLbI99Uy6J/TvI6NqM0zrLN34ZFgovI3spDE66WsAVWHe
         uPOPmXDrXEK1dyEJWxpy7LOi9LNnja1mEgTV4rWz+G4F1KA7vOdtHQUA1k2HfQ1xny6P
         lD1kryIO5a+QTL5Icoy49aKz39sLPzYhrWQY8F/Bhn3C8mndtfiYwCQNVLH1x0SK0lyX
         fNnw==
X-Forwarded-Encrypted: i=1; AJvYcCXzAO6Er0Crwr6CFzZMVUPOea+QXTAduDY+7K7W385GQYXzrfm3xAzyOYArFPZqmKTV2avN5oLU6wFga2wjr4HOqWaEmnFoluZciz5S
X-Gm-Message-State: AOJu0YyuwjROu4YmI0iDXhhnrWudH1t+gcsrS2BIar2wTu+71//r3QOa
	x1mxJMfSDVmzFAt79MWUqsrs0MGX1J2khtBVTv6JCeM1CoS3LsPo3oNZpvMCRcR2S/WgtcfO08G
	CX87gV+CBuTYSUZL3tnKp0hDlULUE04z3RP0=
X-Google-Smtp-Source: AGHT+IF9feX54onok2ZCe/GqwajBd7Pd0t6MmOGkEe+atSYvdfX9IQvLDWobQ07Vq9QKWNS9hc3uGOwicuBtYVR1M+k=
X-Received: by 2002:a05:6000:1ac8:b0:343:c58f:7af4 with SMTP id
 i8-20020a0560001ac800b00343c58f7af4mr1603177wry.59.1712748289941; Wed, 10 Apr
 2024 04:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004145137.86537-1-ubizjak@gmail.com> <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
 <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
 <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
 <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com>
 <ZSPm6Z/lTK1ZlO8m@gmail.com> <CAFULd4Z=S+GyvtWCpQi=_mkkYvj8xb_m0b0t1exDe5NPyAHyAA@mail.gmail.com>
 <CA+fCnZen+5XC4LFYuzhdAjSjY_Jh0Yk=KYXxcYxkMDNj3kY9kA@mail.gmail.com> <CAFULd4aJd6YKXZr=AZ7yzNkiR4_DfL5soQSvhMhNiQEPUOS87g@mail.gmail.com>
In-Reply-To: <CAFULd4aJd6YKXZr=AZ7yzNkiR4_DfL5soQSvhMhNiQEPUOS87g@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 10 Apr 2024 13:24:38 +0200
Message-ID: <CA+fCnZcB5GuwUx7SPKyCMVb2V-dc4GkJbY2PvmzhqHB5vszS6g@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, 
	Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 1:21=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> > Filed a KASAN bug to track this:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D218703
>
> Please note the fix in -tip tree that reenables sanitizers for fixed comp=
ilers:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=3Dx=
86/percpu&id=3D9ebe5500d4b25ee4cde04eec59a6764361a60709
>
> Thanks,
> Uros.

Ah, awesome! I guess this will be in the mainline soon, so I'll close
the bug then. Thank you!

