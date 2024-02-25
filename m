Return-Path: <linux-kernel+bounces-80039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 077BE862A09
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 11:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94ACEB21181
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9DA10962;
	Sun, 25 Feb 2024 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGCzAexm"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08F10949
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708858570; cv=none; b=omBAZw4RSs1m/1FAV8hT6Px/q6fVc3/Rkxo1weMMhVTtAjSjB8UtajU2m4WPT7T1XAS5pWmXq0UpS7a1HuCWSBHsS6PDCy5BI4LnZrFXRKFtKi2VH/lgSpX5MFzMCkRqI+ZgXgcJQWPSubbRwKMEI30YRDqh9SIySDE21R8qLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708858570; c=relaxed/simple;
	bh=7MDigij2ytus+ZDu282w8SmE9LeifK/Nrfz78jcW1m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mF3tXlBc3WgUXkfGDTJYRYL/VSHnGe8EFJg9zSNj/JPRzjAJS6NvNjrsNgOGWsKb8gERDlO3y5J8T+hyQ7VAdubTLGTgtGAqwmKn+xXtYKSYa90uQGNAezE8sk+17lMBFbRVnzP5v9RHa1VAo9Cst6NTfr7wMsgBA6JT5E+Z6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGCzAexm; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59fc4d05861so1269817eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708858568; x=1709463368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV/OTNZlfkMYwxSL22klk0scbvVeTjeLynYoq+PqVvg=;
        b=QGCzAexmI+V5L4gFvlHUl89Lw6tVBV/kCaZQtHNZQgCQYVJNK1QLzymW1YAsPqBrsd
         Z8v9PSz4WVrc+x7IrFuxK58UTMuctAwbFeDIof7RdLakzPZ+WgGpV+6Itu6q+oYw5ZUG
         iOAW1mpTBc/ciXtQAwWbkkywxyoRgDMwN5J32Fmu/6awiJIqc261LsVZPpWgmQKkFUA5
         EAwJUAn4xdEtTa6Y2uFEdM2jP2t0+NTn/xoZ8at5rXv8U2kZ1vyKfEbOjgR3Ci49EnoI
         SYjAR12yEoiIP1MbaMxjfTe1hPv8GYUwUcLiOVDqKuFO7SHFmRJlRUzmFMzSzSDRHKgA
         6mEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708858568; x=1709463368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jV/OTNZlfkMYwxSL22klk0scbvVeTjeLynYoq+PqVvg=;
        b=gAyVt1Mt19HLATCsD6Hk7YycYqDQEjLqPIQvVoY3dM4Dw2vYJXyYgZotMV/VEccsPn
         TVL6sQzWiMoz25v7DBXgKemlwA12/KCRRBGsAT4PCTygUz9+Wxj06tmwrIQRfcjNBSWT
         VlB6wcpu89kL/j8sm5mE9tGBuKg2493XjG61O4uvqJlTAWAywffy3cy1m2Sicv2AYHAT
         vx10/pZL6A1qFmwKJbnTFz5LWf+vYP8KWpiWS0F7ptw/EsiaZt01CqvnJnAC4Lt4cOHl
         dCf3CNiPA1Y7OoVa2f8VdZ4X9nJ/iBkkgHKURo4QUdnSj08GLnbPp7y6R4395ezZSQLt
         Ywww==
X-Forwarded-Encrypted: i=1; AJvYcCUKUozgffjn84QARA5gUXeOah/q8RGtPED6PlrFdm5hyST5oFFVrXUQFlJ0oRGL4oxSzPU4smS+GC/u/IAj+hheOt2EtqmnBPhJUQwA
X-Gm-Message-State: AOJu0YyhuH6GdtXIkYzFgHMxmezrEFp4lyQLSCNAL6aTRIA39Iz8FO8k
	hDTBMNrlbKQ1qVXpJiYbfTKnRl/HMWAigdlWTMGtBFTrWtRNcv5EqmV7xUeKdBSmE92ODmywshM
	WgeMWDMh+oRIe+qCQ8qk44qL0zsA=
X-Google-Smtp-Source: AGHT+IHnH5Kk8Thkr7mnhiJfCvO2z4ysjBumRCQ9Un+ANLbjK/sc4txO3mSPSyOA/8RF+NaovXT4+0/CzODjWMr+U10=
X-Received: by 2002:a05:6358:548a:b0:17b:602f:24e7 with SMTP id
 v10-20020a056358548a00b0017b602f24e7mr5170172rwe.14.1708858567650; Sun, 25
 Feb 2024 02:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221174333.700197-1-tj@kernel.org> <CAJhGHyCJS7Pb_5dwTQtcZ25yOVzxFULJEYT4o3id_3xdj32EYA@mail.gmail.com>
 <ZdcQ1jfOKNTlbB6C@slm.duckdns.org>
In-Reply-To: <ZdcQ1jfOKNTlbB6C@slm.duckdns.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Sun, 25 Feb 2024 18:55:56 +0800
Message-ID: <CAJhGHyAic563hZMLvbQ2X7RsZNmHHEYfh5Lr48cE1LGTUm_K_w@mail.gmail.com>
Subject: Re: [PATCHSET v2 wq/6.10] workqueue: Implement disable/enable_work()
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:16=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Feb 22, 2024 at 11:33:24AM +0800, Lai Jiangshan wrote:
> > From the last patch:
> > > - tasklet_disable_nosync()      -> disable_work()
> > > - tasklet_disable[_in_atomic]() -> disable_work_sync()
> >
> > I think it is a misuse-prone conversion.
> >
> > A developer familiar with tasklet_disable() might happily use disable_w=
ork()
> > and, to her/his surprise, leave the running works unsynced.
> >
> > And tasklet_disable_nosync() is used at only 3 places while tasklet_dis=
able()
> > is used a lot.  I think the shorter name for the most common cases is b=
etter.
>
> While I agree that this can be argued either way, keeping the interface
> congruent with the existing cancel_work_sync() and friends seems a lot mo=
re
> important to me. It can be a bit more confusing for users who are used to
> tasklet interface but then again we aren't gonna rename cancel_work_sync(=
)
> to kill_work() and the conversion overhead isn't all that significant or
> lasting. However, if we break the consnistency within workqueue API, that=
's
> a source of lasting confusion.
>

Hello, Tejun

I don't want to object to any names. But I'm still thinking of just providi=
ng
disable_work_nosync() rather than disable work().  It will be used
at only places at most.

Thanks
Lai

