Return-Path: <linux-kernel+bounces-153988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847478AD5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59B01C209DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EA51553B0;
	Mon, 22 Apr 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCn6ihSb"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7133153BE4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816746; cv=none; b=Y80bPFldc7mnudEDMEVwVVb4+LAuP+G+5zJ/PraW4HrFfToQQamYWEKckdzzMJMacxshyMCBQiwouoou94/Qz35UXEWnfq1eAz2N0sVpIFI/Be0oaBQ8jZTKDRSZO7wh0BCMBulV8vQx2UUf7Zg2IkKFhdtNkRiSkAymc3kPrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816746; c=relaxed/simple;
	bh=raeU5zI++up4g4kra+u3lA7/z1aEJaTNNxdJPgPMYXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuAVL1MCoXQO+yXCMXPSLZJvDOSIEt6LWs+N3AhkP1XHAYnPndpon/I2asduJZiQ4lUzd28UxLrMy6VKeiEhhzPIxaj0wxf/3O5OVJ7BCkhklctlyoo1zoQ8tHLiULH43PKuLNdyyNF7ZsC455WM2N2pUX9lRDYdQ5aqrghcwjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCn6ihSb; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d872102372so44503321fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713816743; x=1714421543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn4tMIf6pjNTvax1oNxBr2Cc6HOC5Rj/gnb2ttcyBPM=;
        b=jCn6ihSbEfjAUz+jRxnVmE2cs3l9l6xtAw6GSnkmk757zkBQv1of6tobUtuQgSIWa2
         b/ntZIICZb8bj8t0JAhLUlPGg7n+bxJR9qWl/K7lXQu2W2VJ0p/Apu7MgEtohEmGV0vw
         y4IW87BDT13H7UhFWJGV0yGQLEW4rvvAlPK9VGco2HIWp/DgWF2J8mYNVNWA8QoYj8tO
         CmQf3xJcWMHLstF7u7VujH6CedM9MA4/xeaeF9wzZ+WpgOrQ2gtghqnmv6hMB4Ojbd5o
         Meo3WkTSO3A36ylSvKtIjPDnKRHgdjTEJHDTXVlwSQiSBlBHc4hU6H4mCqV0L4cquNGE
         WLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816743; x=1714421543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn4tMIf6pjNTvax1oNxBr2Cc6HOC5Rj/gnb2ttcyBPM=;
        b=ENgYkEoPMXCFoInkDg4SUfjnyM67FbQh2qQ/reT1YNPYl8zEvYa5m21R94vOD3cNQB
         kwnECuZylhjUX8bA9W47xrRHF7qIgfftTwjYnPdBDrJ0PYd2tfnwzw6I9NeSECqJdBBy
         vT6BiFTGOW8h41jCtrOX2WQ/vvBqC4r3RI8kiH/FiIRpMFaIDugI1Idu0WqMMC/spP41
         xyDrjIrUrGgMCzM+yQTx9htMhyH7VHnAlAT3ZBM6239XFHz7gN/Zk011c3t7WP5kcDmt
         GxuWOpEvrORtFslHlwJQC7ON7xRItYaGNzwHEUxSUHMfZAbGuhs82PfFyuCyo2jfcDzt
         NvoA==
X-Forwarded-Encrypted: i=1; AJvYcCVPDlhft9bhIjEUVd+w8+XcPsUIT+3+ORk8sILWaSQaKkAyuvqBXL37x/EiCZ/wchjpuUFOVkJWUOMhwMZE7HN/xNonZ2XvyHF2RmaF
X-Gm-Message-State: AOJu0YwS4QBjHAvbuZHKMy9ishuJnuS4ZQ8pX1a5fCvCRJocsuWaygGa
	pOyuKPxvcGlQx+O6ElIUKozOjOVYVfl8yK5AxigtTTrGiQKZ7TXtsGSbTJHnJ9lSpf759bNChYa
	Q3NFvy0M4boVCceLFbG3wi/yH9Vs=
X-Google-Smtp-Source: AGHT+IEYTGdXSTntE2pI8PyZ8wNsTHGaLozN823ZIuiiV3g+c1Vg3dYrWQBhQiDsemQBMsSrCGAsSQEQ7M0HnofdYZo=
X-Received: by 2002:a2e:9958:0:b0:2da:be98:83e3 with SMTP id
 r24-20020a2e9958000000b002dabe9883e3mr229698ljj.21.1713816742827; Mon, 22 Apr
 2024 13:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422151752.53997-1-ubizjak@gmail.com> <Zia-VeObR-m6Bf39@boqun-archlinux>
 <CAFULd4ZhTAY9irw8V=MLZpjQK+q0AM_Aw8g2E=ivHjv7+5m9Zg@mail.gmail.com> <ZibB5zp5DcCmC9gP@boqun-archlinux>
In-Reply-To: <ZibB5zp5DcCmC9gP@boqun-archlinux>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 22 Apr 2024 22:12:11 +0200
Message-ID: <CAFULd4bxtH_Eo3j6kXDBOs_a4u4qsneOfm9t0c-fxGHo5L_FuQ@mail.gmail.com>
Subject: Re: [PATCH] locking/pvqspinlock/x86: Use _Q_LOCKED_VAL in
 PV_UNLOCK_ASM macro
To: Boqun Feng <boqun.feng@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 10:00=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Mon, Apr 22, 2024 at 09:57:04PM +0200, Uros Bizjak wrote:
> > On Mon, Apr 22, 2024 at 9:45=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> >
> > > > diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/i=
nclude/asm/qspinlock_paravirt.h
> > > > index 466af57b8ed6..0a985784be9b 100644
> > > > --- a/arch/x86/include/asm/qspinlock_paravirt.h
> > > > +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> > > > @@ -40,7 +40,7 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlo=
ck_slowpath, ".spinlock.text");
> > > >  #define PV_UNLOCK_ASM                                             =
           \
> > > >       FRAME_BEGIN                                                  =
   \
> > > >       "push  %rdx\n\t"                                             =
   \
> > > > -     "mov   $0x1,%eax\n\t"                                        =
   \
> > > > +     "mov   $" __stringify(_Q_LOCKED_VAL) ",%eax\n\t"             =
   \
> > > >       "xor   %edx,%edx\n\t"                                        =
   \
> > > >       LOCK_PREFIX "cmpxchg %dl,(%rdi)\n\t"                         =
   \
> > > >       "jne   .slowpath\n\t"                                        =
   \
> > >
> > > There is also a "cmp $0x1,%al" afterwards.
> >
> > Not anymore. Please note that the patch is against -tip, where we have:
> >
>
> Oh, thanks for the information. Maybe it makes sense to mention the
> patches dependency in the commit log?

Hm, yes ... I should mention this as "[PATCH -tip]" in the subject
line to avoid confusion with this particular patch.

Thanks,
Uros.

