Return-Path: <linux-kernel+bounces-129966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0F289729A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AF31F21635
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB51C14A082;
	Wed,  3 Apr 2024 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVlmGcW6"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769461487DF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154477; cv=none; b=QAcJhjFGI3yx5Jdw12Nios+sYaRQOt5CK7aGsnqmpyBaNgLzOalnkbtzXUE9Zu6MI8cp24yR5PIJBvMxRCJZdcG6Vy62CdyauujyP1Nf9gNoH0igagouIhMDh6oRF9KI1eyKCj3kCb1r171cgGv+NstBTVXyZ7lQo2g87Ro8S24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154477; c=relaxed/simple;
	bh=RhO3yqj3Tnuu1rk5ZXauX83BDkzLUhI8abjL79B5zbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzMeyKSWyPUcjjRPCObm6mD4B3+35SuH2gfm8qggvNsFRkPeOIwSg+zeItp2BErT3eCWU9lJ64aJDOAqVEYyrNMhW+41u7O6AbAsUfxli8kdpDKf4FHUTfCOnubNU8WkKgX7aSydvzwSmynmzJ+UmaG+4mCaJmnHmArq0l6W4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xVlmGcW6; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a4817189c8so4226669eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712154474; x=1712759274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wir0XqNzOW1Eyc63S6IeVyvUMxM+TuAJrTHrsNF8pNw=;
        b=xVlmGcW6AwhZcJIyuQCkgVHoa+J+8AgLJ+/3G55sKsAxPnmOY5unXC68DGnjEbCkXY
         HNpFTQnXcABTOeGFkkrWM0rYMFvJMV0OZx4hVjcorltbBD8Z4DW2h1fD9R40Y1dvRKuC
         y1ouHrkdcQ4T26OhwuOt8cE4vPrzCYSicobGkXVqul0sEERElftN9XM/UoIz7Wd+tRSf
         fUa7fRdZNSXxtbhd5kkhqjXogjNye+AU3jbyVS92hV2h0yuHOHPcHHbdRMJw3hzdMN3T
         cS3dvPa0yshWQflBnbvsIS0jj9z3fB+IDey11uxYpVJxl1VuP9iAY65EhkZG5gPKWqUn
         jWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712154474; x=1712759274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wir0XqNzOW1Eyc63S6IeVyvUMxM+TuAJrTHrsNF8pNw=;
        b=sGkxXlTTHWaFm0Jp/uoDPBy0xH3dyo2Sk4iNKtbt3MuAUPilGF0Ln/m+MRbwsHp155
         JeOWq/+VwxyFK+EoBFIs0PmKjZwHa13699w1DjC0PeIdbS6XSVWgv5hOUAExDf695heD
         15U/gvBjKoCIL63W3ce9/f+jocJlM1S148naw5ryAVZq2GaPvPHuwSRVq0ECimYwva6a
         i1mxMweY49sH4io4IKDjJjf1CUHJi8LWokrVu0ndwrn9H4wi3ubMjbST5Haixz+3/zIT
         1VMqC4zWpJLG5fIzCb+wyuLIgmve4owHh4Gzjo98TeYKxJRHQQFHo3tO7iiMAlGFE23I
         1ZHg==
X-Gm-Message-State: AOJu0YyTfCXA/3cgxEBgtk1E5qRb4dwPvXeIcAy7xOw+MUeq7E013bGG
	3Z3rTzZx5ua9VSXGD3DEtGwcqYdMQ8ueOrsweXFebeb1rSClYre9KaOBTDzgoB8B6wKlBoCmV1k
	O8ciBwU2WnOcFtoqc4J1AeTKDKfSzLMMf97DqEw==
X-Google-Smtp-Source: AGHT+IFY7sa1uVEbZ0WzsCQB4jUBrs8PbcUF1O/ZrMmO9+smKPit0VhyFlyjpbXGE1oV7/tfoyF7nM9M2PFYLPr64TI=
X-Received: by 2002:a05:6820:3094:b0:5a5:1fdc:8548 with SMTP id
 eu20-20020a056820309400b005a51fdc8548mr15236993oob.3.1712154474610; Wed, 03
 Apr 2024 07:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325081335.2326979-1-jens.wiklander@linaro.org>
 <ZgLrQ7FtDy3INX8F@bogus> <CAHUa44HuuPE_cs3i4XEvHpSV+T0koCqBPo66uOmYyQ1=Rx=NWw@mail.gmail.com>
 <Zg1TmTcqRbzla3nN@bogus>
In-Reply-To: <Zg1TmTcqRbzla3nN@bogus>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 3 Apr 2024 16:27:43 +0200
Message-ID: <CAHUa44HCfFJzw45361zpGGW+sXTcY6RZa0nsrdG6bu807PwoWg@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: arm_ffa: support running as a guest in a vm
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Marc Bonnici <marc.bonnici@arm.com>, Olivier Deprez <Olivier.Deprez@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Bertrand Marquis <Bertrand.Marquis@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:03=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Wed, Mar 27, 2024 at 10:23:35AM +0100, Jens Wiklander wrote:
> > On Tue, Mar 26, 2024 at 4:35=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.=
com> wrote:
> > >
> > > On Mon, Mar 25, 2024 at 09:13:35AM +0100, Jens Wiklander wrote:
> > > > Add support for running the driver in a guest to a hypervisor. The =
main
> > > > difference is introducing notification pending interrupt and that
> > > > FFA_NOTIFICATION_BITMAP_CREATE doesn't need to be called.
> > > >
> > > > The guest may need to use a notification pending interrupt instead =
of or
> > > > in addition to the schedule receiver interrupt.
> > >
> > > The above statement makes me worry a bit that we are still not on the=
 same
> > > page about NPI vs SRI. NPI need not exist in addition to SRI. And in =
v1
> > > you did mention you have SRI in the guest as well. Then why do we nee=
d
> > > NPI in addition to that. As part of SRI, the callback  ffa_self_notif=
_handle
> > > gets registered and will be called as part of SRI handling. What you
> > > do in  notif_pend_irq_handler(), exactly what ffa_self_notif_handle()
> > > already does.
> >
> > That's my understanding of what an NPI handler should do to be able to
> > receive per-vCPU notifications.
> >
> > >
> > > I am still struggling to understand the usecase here. If you just hav=
e
> > > NPI and no SRI when running the driver in the VM, then it aligns with
> > > my understanding of possible use-case(not the one you mentioned in v1=
:
> > > where FF-A driver in VM will have SRI as OPTEE is the secondary sched=
uler)
> >
> > OP-TEE is not a secondary scheduler. OP-TEE (the SP) is scheduled as
> > usual by the normal world using direct request. OP-TEE doesn't receive
> > FF-A notifications and I'm not sure it will ever be needed.
> >
>
> Sorry for my poor choice of words yet again. I meant VM kernel(running
> as NS virtual endpoint) with OPTEE driver running in it as secondary
> scheduler. IIUC, there will be another instance of OPTEE driver in the
> primary scheduler endpoint(i.e. host kernel) and it will take care of
> running SRI handler ?

Yes, that's what we have in the Xen configuration, except that we
don't use an OP-TEE driver, it's only generic FF-A processing.
The SRI in this case is a physical interrupt, raised by the SPMC.

>
> > >
> > > If we are supporting NPI or SRI, I think we can see if we can further
> > > simplify this change, but I want to get to an agreement with usage mo=
del
> > > before we dig into implementation details in this patch.
> >
> > The spec doesn't as far as I know explicitly make NPI and SRI mutually
> > exclusive, it doesn't make sense to use both in all configurations.
> > I'm trying to be as dynamic as possible when configuring the NPI and
> > SRI handlers.
> >
>
> Fair enough
>
> > If the kernel is a physical endpoint, it's easy, it only uses SRI and
> > the SPMC will not give an NPI when asked.
> >
>
> Agreed.
>
> > If the kernel is a virtual endpoint it might be more complicated since
> > a VM may need to act as a secondary scheduler. That's not fully
> > supported in this patch, since it can only schedule itself. SRI is not
> > used in my current configuration. If a hypervisor injects an SRI I
> > expect it to filter what's returned by FFA_NOTIFICATION_INFO_GET for
> > this VM so it doesn't interfere with notifications for other VMs.
> >
>
> OK
>
> > In my current configuration, the hypervisor uses NPI to signal pending
> > notifications to the guest. I do not need a secondary scheduler since
> > OP-TEE doesn't receive notifications. At a later time, we may have SPs
> > that need to be scheduled, but that's not a problem I'm trying to
> > solve here.
>
> Understood. I will take a look at the patch with the above information.

Thanks,
Jens

>
> --
> Regards,
> Sudeep

