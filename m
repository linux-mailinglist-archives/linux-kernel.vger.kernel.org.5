Return-Path: <linux-kernel+bounces-9398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FF481C500
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38C31C219AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DFCC127;
	Fri, 22 Dec 2023 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy7DJr4i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE7BE5F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d099d316a8so1512505b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703226003; x=1703830803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9TfaeQ/e55ca5rREKZmd6+dLcKbLLpUfdI5rG0zE/E=;
        b=Xy7DJr4iZodZhy8tYY6C8tIvuqm4loz/nwNQkgA707N4xSfS0CNUvUdhrhsSf2LFLz
         3KB3JYRZm6FgrM7LJ5xZDDPhOJs1XBZ/O9yx5EzyahkTpD9vA8yDV7xETfrm3r1X/zNS
         BH5QTZh9LooWm1Ki0cK8zFnC4UIxYHiB6mV2Bo0l+92i18EjhKgXc30bwJBAUP1xpC0V
         tPpotDM9BKh3KufhJ6iZhjL82IBGp+0WJAIvcWR50p22UBLEcWPsAkExxdW969/2VL9K
         OWFfHNAHgrt7LM39IY4D/F7DoTBAFSyhqe2ITtYFfEUtMJPkaKnLwQBr4NGdXpvBifz1
         Pe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703226003; x=1703830803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9TfaeQ/e55ca5rREKZmd6+dLcKbLLpUfdI5rG0zE/E=;
        b=Z+Nzoj5E1uEaD8IrYKG82ZfGutQngLGgORZmqTmB/uf78Yg5bWfXzSkBvGZr6iYowP
         P4sbIQbrKdgvQrScXiytc+PLVLGHLBxxSsSg9dhGcjYtLvyAO3IHKBLsjLtXsJfij1kG
         FeuuLFQYe6rOULKWA00i7Y4X4pMT3Qr142SsTs7FRBLVVh1QL655AiKiW8hOfb8h47Uw
         kXUC8B0l3E3L3O7g7shCmPrr4S82CBUVD0B+No6Uvl511pTS3madLL3PPsHGlq1TSQ45
         3i7E14kC4lh5GSWeucsMxNCzPeb8HVrw3l+SLHUyT9n2qAbElK/QnDorhtIWZK+brTDB
         cASg==
X-Gm-Message-State: AOJu0Yzm/PGt3Np2bXbmHxXH311SeiccNJLE3CckGQ1+4BiL2Fih1B5d
	F+zYIOdTaskt5Ilzd9wUz2QytMEDdK18D6hT6k4=
X-Google-Smtp-Source: AGHT+IGYnf8qMcbRTBP8LBMIpA5ZyX4pFoKeRr9EZGX19R8VWbg9hhI87VLCqwbeti8d5IlZcvVXzHz4dWoCmVkg4Mw=
X-Received: by 2002:a05:6a21:78a7:b0:195:3eb6:da1b with SMTP id
 bf39-20020a056a2178a700b001953eb6da1bmr120999pzc.72.1703226003030; Thu, 21
 Dec 2023 22:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215115857.575697-1-ghanshyam1898@gmail.com> <87il4rlrw2.fsf@mail.lhotse>
In-Reply-To: <87il4rlrw2.fsf@mail.lhotse>
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date: Fri, 22 Dec 2023 11:49:26 +0530
Message-ID: <CAG-Bmoejy6t-EHv96OTnGhvo-P82fhw5pSUM-LqLfh7Hgh5Qew@mail.gmail.com>
Subject: Re: [PATCH] arch: powerpc: kernel: fixed some typos
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 4:55=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Ghanshyam Agrawal <ghanshyam1898@gmail.com> writes:
> > Fixed some typos
> >
> > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > ---
> >  arch/powerpc/kernel/eeh_pe.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Please also fix the case in arch/powerpc/include/asm/eeh.h
>
> The subject should use the correct prefix. You can see what it should be
> using:
>
> $ git log --oneline arch/powerpc/kernel/eeh_pe.c
>
> Please give the patch a better subject, not "some typos", tell me what
> misspelling you're fixing. Same comment for the commit description.
>
> > diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.=
c
> > index e0ce81279624..8e0c1a8b8641 100644
> > --- a/arch/powerpc/kernel/eeh_pe.c
> > +++ b/arch/powerpc/kernel/eeh_pe.c
> > @@ -24,10 +24,10 @@ static int eeh_pe_aux_size =3D 0;
> >  static LIST_HEAD(eeh_phb_pe);
> >
> >  /**
> > - * eeh_set_pe_aux_size - Set PE auxillary data size
> > - * @size: PE auxillary data size
> > + * eeh_set_pe_aux_size - Set PE auxiliary data size
> > + * @size: PE auxiliary data size
>
> While you're changing it you could also mention what the units of the
> size are.
>
> >   *
> > - * Set PE auxillary data size
> > + * Set PE auxiliary data size
>
> This should gain a full stop at the end of the sentence.
>
> >   */
> >  void eeh_set_pe_aux_size(int size)
> >  {
> > --
> > 2.25.1
>
>
> cheers

Hi Michael,

Thank you very much for your suggestions. I will implement them
and send a v2 patch.

You mentioned I need to specify the units of "PE auxiliary data size".
Is the unit BYTES? Sorry for the silly question, I am only beginning
to contribute to the linux kernel.

Thanks & Regards,
Ghanshyam Agrawal

