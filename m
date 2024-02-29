Return-Path: <linux-kernel+bounces-87280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296C86D21F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C219528726F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8957A127;
	Thu, 29 Feb 2024 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUlnkrWF"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C187E10E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231088; cv=none; b=NJv8eHYZs5ayLgS9vs5QrGfpY0+ldkEyE3AuCQTqlXbLgzt7ZQWUxTtzHMmc2asQPWsTokR1JK/Qz+IIAhA7Sdrf1rEpW/UC7S3u7VRuivAtgi2rR1aFvzmkm6nYJgIA++65hc0AALAEgzaMEjrnHBVh/qRLuk9xLbAzSvtqs2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231088; c=relaxed/simple;
	bh=rE1QGAQIMQNISpryIKboGbeCPEJkAJj9czSAuY5OF1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjYAZAWMWAtsYcjSR22ib3SZKrMM995Eo736YMeyLo3yKnlmy4Ku2H/YvUj8ww/dQWTlwUhJaN9wCIG3wHfaMTTZJ2wtyelJ0ZKkPWnRUdI18YPeFatmckMIzJ131bOr0M1DZHuB59WWqcYwJ1DF6mW79ZgXsrw9W0ZxuG3pDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUlnkrWF; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4d34144d710so645021e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709231086; x=1709835886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v0Mujkn98YoxMOevo9EeDyb5ToENPRR73FypNAgjKP4=;
        b=iUlnkrWFJ75nmkqKvAqqXG7dadj7bKCD6hWyP5VeHYVOSW/1HM/jqQENE8rosZd5q8
         RLtDClLdKf02dWSgorPmQj+8aM7eOthHzmmpc+MvCySZzQopLLRdAhP2Dt48jW9F35t6
         blc0QfVCeYiwaVGmkeVXXASzfHPtcuIiKa7P5jX+rOvcNRR9j2E6NZD1iE2lnwxmMwY7
         R9Tsvw0B6l7bOK6RWd+fGwqUDyrvCH9n/Khuc9Ut9stwfvVsb2pAJGn+OP4xvzO+v/Si
         7txubJPOpEX/hu9YkQkMvouccGeBoCK4usUybl4zljKnPHxnTi168i4jppOw3u6uo4M4
         cFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231086; x=1709835886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0Mujkn98YoxMOevo9EeDyb5ToENPRR73FypNAgjKP4=;
        b=ifg0M1krQqzneLcQwn/mMbUjP5flNfpSDTSYvJIz3F9XIcOf1KOamMnmD+O30dixv1
         Gf+J4UILkGaO1MNHfp2TbwL0OhJvI7/R75S0/1fsJDM39PivWs2VBmPO6nuJ9zGiyuQ1
         yyC1QcZAL9L3zR7yOGdLuUqA+HkZf1FnNjPR6z07lHIaqpNH3r1Bp9EiiVQsTdQr2WBX
         oyfjUwiVRlrl2qJahKKmR35kArJE+2w4i6JTdtBUpX7NCQZMyUGB6Sg0XFUPPs/e0oEA
         sAcvWwfmcrX2BsPpnA93ENKp1szOopjfj6au6hKd+1PfWyLRFP6220pOvouFSN5nUKnD
         M7lg==
X-Forwarded-Encrypted: i=1; AJvYcCX65bmkpyeoddyu2oHmQ6jhBch9RkVIe8BdqxYredNT3jgC9DeYHDjHdttHd3uYZDI3KKf0J/hXSkhCVUk/y2WbTY/ccEufv3as8Gio
X-Gm-Message-State: AOJu0YztkIuTsumLPnUmwLM8G0ADMaUhe2KrA16ycFY57cnF3HkCinBX
	rbwlIvheCIx/dJ3FewEmoqgiMzNhQiqe8uoYAbsBFR3rPfp0wQdA+6ouWPn4dP0Jvpa+xsFZklm
	N0BavftSrBYgASPag2KsM+ZdVOh0=
X-Google-Smtp-Source: AGHT+IFkpe5/8avg3RP4Z8PG/UwuLgjZBiOKBsA9uo0CxaR+dgGS1CB3r53SRyDZ+Xk7TBpcWrs+K0NPQnJX2fT+ly4=
X-Received: by 2002:a1f:e604:0:b0:4bd:54d0:e6df with SMTP id
 d4-20020a1fe604000000b004bd54d0e6dfmr2157995vkh.1.1709231085720; Thu, 29 Feb
 2024 10:24:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228181850.5895-1-apais@linux.microsoft.com> <CAJhGHyD8cruwAkr+hqysv7fTQX1ovpn2cu_wU2C4TXrE5Qy8zg@mail.gmail.com>
In-Reply-To: <CAJhGHyD8cruwAkr+hqysv7fTQX1ovpn2cu_wU2C4TXrE5Qy8zg@mail.gmail.com>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 29 Feb 2024 10:24:33 -0800
Message-ID: <CAOMdWSL2RTBin-FHWEv7b_1FRYs-KUztk7Ev5vaLSNe=zECuDA@mail.gmail.com>
Subject: Re: [PATCH] kernel: Introduce enable_and_queue_work() convenience function
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Allen Pais <apais@linux.microsoft.com>, tj@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >
> > +/**
> > + * enable_and_queue_work - Enable and queue a work item on a specific workqueue
> > + * @wq: The target workqueue
> > + * @work: The work item to be enabled and queued
> > + *
> > + * This function attempts to enable the specified work item using enable_work().
> > + * If the enable operation is successful, the work item is then queued on the
>
> Could you please specify what "successful" means and also please
> document it that it might cause unnecessary spurious wake-ups and
> the caller should prepare for it if it is not desired.

 Thank you for the review. I will work on documenting it.

Thanks.
> Thanks
> Lai
>
> PS:
>
> I'm afraid it can cause unnecessary spurious wake-ups in cases
> where the work item is expected to be dormant ordinarily but disable/enable()
> are called often for maintenance.  However, the user can resort to other
> synchronization in this case rather than just disable/enable() only to avoid the
> wake-ups overheads.
>
>
>
> > + * provided workqueue using queue_work(). It returns %true if the work item was
> > + * successfully enabled and queued, and %false otherwise.
> > + *
> > + * This function combines the operations of enable_work() and queue_work(),
> > + * providing a convenient way to enable and queue a work item in a single call.
> > + */
> > +static inline bool enable_and_queue_work(struct workqueue_struct *wq,
> > +                                        struct work_struct *work)
> > +{
> > +       if (enable_work(work)) {
> > +               queue_work(wq, work);
> > +               return true;
> > +       }
> > +       return false;
> > +}
> > +
> >  /*
> >   * Detect attempt to flush system-wide workqueues at compile time when possible.
> >   * Warn attempt to flush system-wide workqueues at runtime.
> > --
> > 2.17.1
> >
>


-- 
       - Allen

