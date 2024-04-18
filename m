Return-Path: <linux-kernel+bounces-150316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4499E8A9D43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D8CB21AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2504158A08;
	Thu, 18 Apr 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoxCES8r"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0056FB0;
	Thu, 18 Apr 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450877; cv=none; b=fyw3DCFesTBwVrTyWbX2yJXVAFIlz0gH+6jN4gV4lgiOKPA2JoTH3QOHMJRVb0C8kJP09MTs1Ds2L5Zxn1kXILI+W5qGA6GWreepyfELmlZg535fYf5llIK3rHdOL1h7DBmuVXQ/lPYox+6NaQtKX9FELJZyqE2yCrQj9P5OvVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450877; c=relaxed/simple;
	bh=AWhqJ/PhhN6VwcvGP4fb2OzJCE4W/q26RaYjel+sdg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcnLnrI0uyJetsbD76ITDLzfLwB/1YMZpb0Z2sgr0c5OR8FJT1ozuqdvoVN4vX0t50Nsocoab1F0be9AeyonWYt+b3ASKdZjDYBR855IfuI0EYZiV3UxIKD/MLuX6uXvfYGr7vR5x//STCLFhcyGHQ2Tw3F2VHRGy8KzDgpmAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoxCES8r; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-617e6c873f3so9813837b3.2;
        Thu, 18 Apr 2024 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713450874; x=1714055674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWhqJ/PhhN6VwcvGP4fb2OzJCE4W/q26RaYjel+sdg0=;
        b=HoxCES8rH3XAAHi9HHL/8wxrbtpaFwQXuMZtf2qx+Xx0J0J87aFMEiDu0M65pmtT5X
         Zz08gUBJvwtq+MAJ/k7kZgLQinyQZUiWCBCPWsJOG0dA18NI3uOUMF1VM7yfbA4mw0yv
         nqIaj0EdcDLC8sawci4vNu0hXUspfCcU7sspCws2SuMXDg14QZJ5rJmdoG2ve+3EkuEF
         SEX9plfmo3g2fk7jgy/EkthKr1BkcWNV2ygYuFBdDV4xnA0N49AVO8Wty3kuCDJe209M
         3bpKwsQh3WSi5RThepf0xEjk22As8AWDpKW+xUa94QSsx/mV8Ht8paioGo8mCtpLpUzc
         CWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450874; x=1714055674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWhqJ/PhhN6VwcvGP4fb2OzJCE4W/q26RaYjel+sdg0=;
        b=ps1azzsAyD8KTXiBJ9iJ8kY/ZFx1It8C8c2xPVmizZJHV5/WQeN5ylxzYrW1+9fa2D
         tPrx1QntMfiGl1Anru+VK0F5wKu5v0QWouyBWd370Dort7vkcvvXuUgIPebWI3HRz6EJ
         RfLbbvwzhvdh/r5euDpMNhagpknxgk/YyYvyP68sobobXsumRSdQijCkV5cv6CGaVCBl
         j8rdYegKk6yPfNGRPFO8aU3VF1uQ8MB1icnQbvnTqd3Xh4j5xwKdP+vH0rAscjSEJzXh
         M+Sn3h2AfPfXdOBljjGkBLmUER+GRf4cja700Z9vlcZjOTO+mGttA2KTIAtmnINcef3G
         IthA==
X-Forwarded-Encrypted: i=1; AJvYcCUVlxZoU1Zh8RHBVNkTQfTX/c4UC85PxzTo9CM9l+69XJv1X3J50IkXUpNsspQ1WBBKZXbIOVqfOrD32OW71TzjgWwpChiwa2JV5y7y36oD6ckXZ2uudh7hHhCE8Hja8brSQsqqT02D4+k=
X-Gm-Message-State: AOJu0YwnWe7Bxc4bFjC4693TqwxhE4MhWhWV8La3L7bpZvxTaVvOwILA
	TyCzKFjJKTO+NC/YPXo2+XRNAn3G6B/qL2bpHQ6R/PtnQ4opY94PkaJ8KuouziyCnSe9oXvs/kR
	YZcNCMkM1z/AhM9N8fbqqOxLgyc4=
X-Google-Smtp-Source: AGHT+IHPljfyR5qozrc6exU2JcpOuPMAZ8pZtMm0j+hGfBQ8TM8Ir1vjxTKtwDJRN4TQtvGjjcG18rN15x9F7IeAmPc=
X-Received: by 2002:a05:690c:d18:b0:61a:af67:1cfd with SMTP id
 cn24-20020a05690c0d1800b0061aaf671cfdmr3008285ywb.5.1713450874003; Thu, 18
 Apr 2024 07:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
 <CAMeQTsbCESSTrEyHgqF9HreSuzQ9kMBnGpKLT0QNJ+n4hv9qOw@mail.gmail.com> <20240418160526.3b3c385f@namcao>
In-Reply-To: <20240418160526.3b3c385f@namcao>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Thu, 18 Apr 2024 16:34:22 +0200
Message-ID: <CAMeQTsaGXv6hUmXg3ROLb83JZEAfoSuQGCQgz0wG38Me8UtQYA@mail.gmail.com>
Subject: Re: [bug-report] task info hung problem in fb_deferred_io_work()
To: Nam Cao <namcao@linutronix.de>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, jayalk@intworks.biz, 
	Daniel Vetter <daniel@ffwll.ch>, deller@gmx.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, tiwai@suse.de, bigeasy@linutronix.de, 
	LKML <linux-kernel@vger.kernel.org>, Vegard Nossum <vegard.nossum@oracle.com>, 
	George Kennedy <george.kennedy@oracle.com>, Darren Kenny <darren.kenny@oracle.com>, 
	chuansheng.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 4:05=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> On 2024-04-18 Patrik Jakobsson wrote:
> > This sounds similar to the SUSE bug [1]. We fixed it by reverting [2]
> > in the SUSE kernel. The problem seems to be that flush_delayed_work()
> > kills the timer and re-queues the work but doesn't guarantee that it
> > is finished when returning. So when the device is closed, the
> > fb_deferred_io_work() function can still be queued and tries to access
> > memory that's been freed.
>
> flush_delayed_work() *does* guarantee the work is finished before
> returning.

Right, flush_work() does guarantee that the work is finished, but it
doesn't guarantee that the queue is idle if work has been requeued
since flush started. So fb_deferred_io_work() should be able to happen
after the device is closed. Or am I missing something?

>
> > Patch [2] tries to solve the problem of not throwing away pending data
> > when closing the device. Perhaps calling cancel_delayed_work_sync()
> > and then follow up with a manual call to fb_deferred_io_work() would
> > be enough to flush the remaining data?
> >
> > -Patrik
> >
> > [1] https://bugzilla.suse.com/show_bug.cgi?id=3D1221814
> > [2] 33cd6ea9c067 fbdev: flush deferred IO before closing
> >
> > >
> > >
> > > Thanks,
> > > Harshit
>

