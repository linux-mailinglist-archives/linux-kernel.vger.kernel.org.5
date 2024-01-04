Return-Path: <linux-kernel+bounces-16342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CBD823D0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B351F24B85
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49209200A6;
	Thu,  4 Jan 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S95tPCHg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C47200A0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a271a28aeb4so21144366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704355019; x=1704959819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQZtCo3H6h9b3FM5QY391lvIOdqO2eyj0lGwNL8bJqA=;
        b=S95tPCHgJNnQ3TpvCOTbcNlaOpZQWXSFFLfmJp2Uiu7puvlHal7KxjiE4plrDPW7OR
         KR0Q3PWkB+vPttyBch1dw7haePMDJF6nz9umA/CjNK01BMXHHUI30DiJVr5B3Yi4et1p
         KCtjmnc5xQuv+citnFB32s75uyLqavl42X8geKlQfM8Zo9VTBes2DX9o+f2S5A9ZlxP+
         8WDoex/1Ychi6ak5CIff/mZr1phuaGKFItbqEs07/ZN57YG/0jRamLu7yTwf8eeThT/a
         h8hpbywwKzMAcAoy7QCWR/v7G5GxKmuKAPuu3XuBhnEgFimSONeaNC+pfVemt0ym+2HA
         y4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704355019; x=1704959819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQZtCo3H6h9b3FM5QY391lvIOdqO2eyj0lGwNL8bJqA=;
        b=Pn2kgGsrowjxEQ1E+Q8/ZwchwkxZfDdZ1X0BgdFxIeYBBXYNv5XbDoNAWfbq2mnjTU
         RQf4W4aAI5Xg9iAWs3ljMgPsH7c+CLbwSzkko69lY1UFbKslgcX1OPHSVjba658U7c/0
         TjOMPi4HAc0TTmfiIKe2RtliGRJ1u3ddwzUqDPfIzcj/V3VNWlfakMwljvkeppLoyglf
         GbCAs9qzcsO6tpZhtRjRRDbbqS5r87Wz2wzvTbYp/D2G7ovC0rlJ7LSvHL9Cq2Q3iPMo
         dRFcYMka77OOGIWEe0cmTtPZgAePyUEjkPOa3cz0KlC8ifMCWMj7nxdqRPb/W9bcTIe/
         atBQ==
X-Gm-Message-State: AOJu0Yy9h4RYgbndXDAL5ounptviodDaf6j0GtQqPmxloiYnGuXGnTB4
	q5zifU4uJ/AF4dFQBGlHZFgPr5YJdDkb82DXW+0=
X-Google-Smtp-Source: AGHT+IE1JTGVNUTahI3trVuJeAMhaaPUB0c1cR4kSjljhpmtMqxMGbY2HA7cCIYGJfGnGUlobuKwg32pNcr1dqxXnvY=
X-Received: by 2002:a17:906:c94e:b0:a26:85ed:78dc with SMTP id
 fw14-20020a170906c94e00b00a2685ed78dcmr109586ejb.133.1704355019018; Wed, 03
 Jan 2024 23:56:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102073351.1527503-1-alexs@kernel.org> <xhsmhplykjawj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJy-Am=R=gRFqSdGjXaMqq7Yetpp-4=bLtnP-87GepN4zff5Tg@mail.gmail.com>
 <xhsmhjzork8x5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJy-AmkG+6jZCGFBnqA_33NtBBq_hjemqkPCbZX2Jty0KWQE+w@mail.gmail.com> <xhsmhbka2jzaj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhbka2jzaj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Alex Shi <seakeel@gmail.com>
Date: Thu, 4 Jan 2024 15:56:22 +0800
Message-ID: <CAJy-Ammtn1Asw98fnB28ym-FF8Wafc=p9Nv_dDfY1pL3V8bCQA@mail.gmail.com>
Subject: Re: [PATCH] sched/tracing: correct the task blocking state
To: Valentin Schneider <vschneid@redhat.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org, curuwang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 9:56=E2=80=AFPM Valentin Schneider <vschneid@redhat.=
com> wrote:
>
> On 03/01/24 11:14, Alex Shi wrote:
> > On Wed, Jan 3, 2024 at 12:16=E2=80=AFAM Valentin Schneider <vschneid@re=
dhat.com> wrote:
> >>
> >> Why is that an issue? If those tasks didn't have to be
> >> TASK_UNINTERRUPTIBLE (via TASK_IDLE), we'd make them TASK_INTERRUPTIBL=
E and
> >> they'd also inflate the 'sleeping' schedstat (rather than the 'blocked=
').
> >>
> >> What problem are you facing with those tasks being flagged as blocked =
during
> >> their wait?
> >>
> >
> > Uh, Tencent cloud has some latency sensitive services, a blocked state
> > means the service has
> >  some trouble, but with IDLE state involved, it's failed on this judgem=
ent.
> > and 2nd, if a service has abnormal, we want to check if it's hanging
> > on io or sth else, but the top
> > 3 D tasks are often queuework in our system, and even a task in
> > blocked state we have no
> > quick way to figure out if it's IDLE or BLOCKED.  2 different states
> > will help us a lot.
> >
>
> That's useful information - generally it's good to add the motivation for=
 a
> patch in the changelog.

Thanks a lot for coaching, I changed the commit log in the v2 patch:
https://lore.kernel.org/lkml/20240103081042.1549189-1-alexs@kernel.org/
Btw, which way is usual prefered, send v2 patch in a separate thread
or add '--in-reply-to' to follow this thread?

Thanks
Alex

>
> > Thanks!
>

