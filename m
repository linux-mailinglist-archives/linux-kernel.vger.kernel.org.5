Return-Path: <linux-kernel+bounces-141462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B81748A1E92
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CAE1C223E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C771798E;
	Thu, 11 Apr 2024 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NujZLe3A"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27F168DD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859373; cv=none; b=Z3ADbgurrLgjGjt+PzjBAE+jVW114TyTKbmKl2lMXhFr2tnlnimQrraj9FfZW4PvbpGCNI7oIP6kRhQu5vGbUk7UWHVyIeHa4s4ZEBHKxAZV6GqCvIL7xh4KkHRWLikrHSYUHdr78TiIQ676esx4UxMH3IDyaxn10Vp6/zKrtyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859373; c=relaxed/simple;
	bh=Ho5HKMrHsYHBj97jJ6q/xDBtZbPcTs+t1YmVTN+iWoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8vMXwCxTjtCkJJcGfuAAXM2cn57TPfg+FgVsN1VyQ/1gsCQ7PZMC4lFOsmNCLTi1dzzquHn2S+4SlXyGWtJwRNZltKNyFdGYUt5K9v8sr38eRSk8sE8b75oM2C45VsNxR4dVPQQCE8rKtoL2spAWkrqkxnvtTc8jxSPQzYl6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NujZLe3A; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-22a96054726so121694fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712859371; x=1713464171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDS6c2ghnYUkSwWbtZftPqPTODtRchsS8qiLJfzkVWw=;
        b=NujZLe3AkI0Jut6UPlGMvxMlB0yOalI9cFij1lYoQ2fsJWCOC6V2GA33m0l2IsOJnY
         gwrwHh1B/7qPP24wpeZItgKIGP7plj/nO9kB4w4XSxdVoCFy4/voQWLm3tcdd2DUK6Qs
         O7Eie3PE1pKilAdH/+8NU4C67yO4subQ2FUWYlq9cmdj97phaFmYZCosA374aL01oG0V
         XFb07kcylFvMeC3jOrqG6yQbEK93F/AFFUSY5fR5V+nUGXNug/FkEd1zsKwnb6Mc9yEb
         sT2df3QFTGIpJ2AHKIxL2kwJzsUX41SctfsYij6d1EBsnIIkO6znU/odbBEp1PGJ3CBS
         2mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859371; x=1713464171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDS6c2ghnYUkSwWbtZftPqPTODtRchsS8qiLJfzkVWw=;
        b=BaeehsvwimUKzR9gW9NTBJywbrfHPgrqDnWywol5RJOYrrISzXSeYri26PqfPcHXq3
         a61425dPPBV5XriVEs9LnNaqcrqhc7974QeEfBKWrR1y+z+rNbaMKu39oRhUsxBcKR3P
         233LoEacIg0rDNRORv+d8SBVRY7XZrBhNTCNrnjccCGCF8yG6yWHJSNwK+tIdUGORZuc
         3IGcYcuX3lzkDWsdj531EU8Ylb7Oc8AwNhuARhCWj0ZHu/ur69vsir5gn31YyXk3LDQF
         EH03A45a0UDmXnPq0sjgKUMzK/NFfSJy4w8QtKZebp5LODRqgEPlKn4LmtX6AscNhDqI
         xD0g==
X-Forwarded-Encrypted: i=1; AJvYcCWvdYjVmokRecUERvJVk9uGoTVHXanVvXkqKJZgqvyX9n0t1BMJsOAtwfwI1BqaAMGNzSP59BpvebqoD1IlQ/p4ht48Pp0LtOq81wMi
X-Gm-Message-State: AOJu0Yw+Fh0xdEEmpwdK6FfIQ9tYQoIF8xQohDbjuP9eBgzb23C6oBpS
	VN2piXaFKJc4VC0tBkMEXj9vRl7ynC23GpK8+qLA78cLQ8Y04pbyCbAoDdUBl4GSpXr+sAk0+aC
	G5bwYWOkDRSvHRkoseST+Yd5bfA==
X-Google-Smtp-Source: AGHT+IF2hVKasS43gNxPvK3Yxqe3GnEmv7WnsgCokhD0KHgBvCacyvI7d2RHHBMtMHdJooKADEYd0Vu236vMpiguadg=
X-Received: by 2002:a05:6871:8795:b0:22a:dc7:7d64 with SMTP id
 td21-20020a056871879500b0022a0dc77d64mr267337oab.10.1712859371153; Thu, 11
 Apr 2024 11:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410194850.39994-1-jason.andryuk@amd.com> <20240410194850.39994-3-jason.andryuk@amd.com>
 <CAMzpN2h6S69bOLXCUhmkVJErvoKxq-wPmfoaqR7eGHYLgirn+Q@mail.gmail.com> <74465ac2-0060-4047-97d7-acadcdff4cd4@amd.com>
In-Reply-To: <74465ac2-0060-4047-97d7-acadcdff4cd4@amd.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 11 Apr 2024 14:15:58 -0400
Message-ID: <CAMzpN2iCYXuQXXHmg9qevJXDuzvxDF9L=Vw+w2ZAaPk6vZZFDQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] x86/pvh: Make PVH entrypoint PIC for x86-64
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:26=E2=80=AFAM Jason Andryuk <jason.andryuk@amd.c=
om> wrote:
>
> On 2024-04-10 17:00, Brian Gerst wrote:
> > On Wed, Apr 10, 2024 at 3:50=E2=80=AFPM Jason Andryuk <jason.andryuk@am=
d.com> wrote:
>
> >>          /* 64-bit entry point. */
> >>          .code64
> >>   1:
> >> +       UNWIND_HINT_END_OF_STACK
> >> +
> >>          /* Set base address in stack canary descriptor. */
> >>          mov $MSR_GS_BASE,%ecx
> >> -       mov $_pa(canary), %eax
> >> +       leal rva(canary)(%ebp), %eax
> >
> > Since this is in 64-bit mode, RIP-relative addressing can be used.
> >
> >>          xor %edx, %edx
> >>          wrmsr
> >>
> >>          call xen_prepare_pvh
> >>
> >>          /* startup_64 expects boot_params in %rsi. */
> >> -       mov $_pa(pvh_bootparams), %rsi
> >> -       mov $_pa(startup_64), %rax
> >> +       lea rva(pvh_bootparams)(%ebp), %rsi
> >> +       lea rva(startup_64)(%ebp), %rax
> >
> > RIP-relative here too.
>
> Yes, thanks for catching that.  With the RIP-relative conversion, there
> is now:
> vmlinux.o: warning: objtool: pvh_start_xen+0x10d: relocation to !ENDBR:
> startup_64+0x0
>
> I guess RIP-relative made it visible.  That can be quieted by adding
> ANNOTATE_NOENDBR to startup_64.

Change it to a direct jump, since branches are always RIP-relative.

Brian Gerst

