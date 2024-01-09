Return-Path: <linux-kernel+bounces-20325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB2827D59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D08A1C21992
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27030612E;
	Tue,  9 Jan 2024 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1OHM3ql"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0056103
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e4d64a431so4172795e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 19:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704770880; x=1705375680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5FTBQx6CxuffH+TulsrcO2jk2wY7catmAEyarNb8Sk=;
        b=V1OHM3ql1tJIYzGc3ioCumz6GNk/nNa5JgbhX/8Wnta7CuvUXaV+W2QnOATUENidql
         isg98tyYqR1UKnAD6D/7/YQ2dEcW9dKF0aEzlitSiHbjlkGB54DkrMdPntie29wsKN9c
         zn8eFcn8CzWMVGisWtMECrERH/piOhesmf4d50zvwRZ5REnC211xh66uVPyptaDy6mn7
         e/r1X/ImXehuIU5D6A5p+VG3ex4h83su56+dukh0bbmMTnZVAykkZ2CFja5qFUf5WjDP
         ea0qqvB8X4+dlWDCG4JnAz5L8emLXnb5OW3rRV4+sbf4O5xJFsGIK2tZt3mC35rJ7Piw
         WK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704770880; x=1705375680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5FTBQx6CxuffH+TulsrcO2jk2wY7catmAEyarNb8Sk=;
        b=JdQYVkKEGD2NCswbIJHzS+gPeV5sNwthQk3+/heL1pMTJCk60rjOiDS1VDUtd9hd4s
         HQ4Ys08e2FUY2q2U3HosAlKj7NDynaFOS4oEXbprF88vLvChoWKfilI5qFJfFz/S9Y1j
         Gu3G72iQJhKk/6ikL5o39tnIVEQNULagUaANw6k4Mx9IT142wHqbA5EYgjCeGReZw9dZ
         yDi3ep/MroMtqJUZZ8Lt34SP2cghEQmUpozW0tZMEaoEqdgSPMMqdUlIjvdZgixxgaD4
         IJS4GgeMu4qHZC/v543YDhn2hwRRAzYtXkIfPZAbuKMWB28HE4Ub55SgK8HaRl25/JJZ
         oE1A==
X-Gm-Message-State: AOJu0YwB6yhV7wITd9n/7chQ9PI+oJN8pIcPNQczG6gvVen0GU758Ldi
	3dm946cPHYvzSbP+E135wrRx+m2tPyKEZm9XIx4=
X-Google-Smtp-Source: AGHT+IHPIExeEAc+7tHw4Ngvh29666cwbbZi06fQzwvscm6FiKYjj59QIPW+EnAlLzIBUaSUNfRdcs/fAcd95mZtRwM=
X-Received: by 2002:a5d:5406:0:b0:336:5b14:525f with SMTP id
 g6-20020a5d5406000000b003365b14525fmr215214wrv.132.1704770880022; Mon, 08 Jan
 2024 19:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <6db160185d3bd9b3312da4ccc073adcdac58709e.1693328501.git.andreyknvl@google.com>
 <ZO8IMysDIT7XnN9Z@elver.google.com> <CA+fCnZdLi3g999PeBWf36Z3RB1ObHyZDR_xS0kwJWm6fNUqSrA@mail.gmail.com>
 <CANpmjNNtT1WUpJu_n5x_tA2sL4+utP0a6oGUzqrU5JuEu3mowg@mail.gmail.com>
 <CA+fCnZdAUo1CKDK4kiUyR+Fxc_F++CFezanPDVujx3u7fBmw=A@mail.gmail.com> <CANpmjNNfyKV0Ky=GRiw9_6va3nJMtYejWZJL0tn5cjwXTY8e1Q@mail.gmail.com>
In-Reply-To: <CANpmjNNfyKV0Ky=GRiw9_6va3nJMtYejWZJL0tn5cjwXTY8e1Q@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 9 Jan 2024 04:27:48 +0100
Message-ID: <CA+fCnZdjF=8bchUs1RNA2e+8HSZTkOw6Tkz0Ye6Znh=zdf8yrA@mail.gmail.com>
Subject: Re: [PATCH 11/15] stackdepot: use read/write lock
To: Marco Elver <elver@google.com>
Cc: andrey.konovalov@linux.dev, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 1:59=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> > I started looking into using percpu-rwsem, but it appears that it
> > doesn't have the irqsave/irqrestore API flavor. I suspect that it
> > shouldn't be hard to add it, but I'd rather not pursue this as a part
> > of this series.
> >
> > So I still propose to keep the rwlock for now, and switch to
> > percpu-rwsem later together with the other perf changes.
>
> I may have gotten lost in the post-vacation email avalanche and missed
> it: did you already send the percpu-rwsem optimization? I am a little
> worried about the contention the plain rwlock introduces on big
> machines.

I didn't get to working on that part unfortunately :(

I filed https://bugzilla.kernel.org/show_bug.cgi?id=3D218312 for this.

