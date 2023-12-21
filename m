Return-Path: <linux-kernel+bounces-9042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B253E81BF85
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC71B22372
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D913745D7;
	Thu, 21 Dec 2023 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCqbZt6S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B625B1DA3B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28bc8540299so761548a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703190097; x=1703794897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YbFjGH80BA4VduiXuChGc2yL1fnFJ1q2+v81EA2deQ=;
        b=DCqbZt6S8JM6khFR79lyHdW8gvS7xC4CDqBi7zaABAVBNO3XkKfEyPSldgHWCQVwTu
         Y/9BU9N5aHglsmbH4yl6svSY41tvWa+AeEoMe8RUNey9m+pWxyNxIkA3ZeSCAKtHGyEE
         yT6EFOSMYj1MtNCpZeBjuD/qO7B99r2Zcq0aqh6HfBo5fNkujm8O8aX1VwCQWzfv7fRT
         9wmZfPXrMwnSEUlG1Ze+t0LE9dIoBB5wqRScThas4vRa5IgcNSrYU8eW+lvSpCrUAn57
         2lGzoUO2Cr6jdalThMkNnkRcOlZcg51KPr0fyN9l8tDUMO3UC0ZJEEMOkVuS7hnOR5yG
         XW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703190097; x=1703794897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YbFjGH80BA4VduiXuChGc2yL1fnFJ1q2+v81EA2deQ=;
        b=Pm+2HGUcVU0VXwA14mWXfo906yKZyktcVDKXUZ8SzHmCljeI2guyf1F/UkO2gR/jRv
         /dSFwC0wiWLZ3CaBqY2YB3Oh2jT7o59jeZBTmLkdzLJl/TI71cEofjqBI/FREw9PNEU7
         cFtA0Ne0IDnWbwtN6LXBfHyh9wn/0U//7hbyJ3Nzyd5TtAKbk0OzpWiFrhVL9DGbP3lD
         yeyoZUGX08uzpuLgQVi92wj6cTGErG4cCFBoP06xCllgkLvLK/iFYmx1I1xqvR/UXEcx
         0AH0PwoOXqtMOvxW/59PGQRj4ijikK8mXjo2PbQDlsZ2dUtECUeY2OKYot12HPXcL+WJ
         xnyg==
X-Gm-Message-State: AOJu0Yyw4g+yxa49NcTkdQLWSWHFvkgW4/qztEelR6MIAAQwvDkp5PCL
	bf9IQpWG+GC+AUEoLz4k9a77L546eXk/xITTBo8=
X-Google-Smtp-Source: AGHT+IFcfHudS9n+XdyuSgT14JuAuy08kzr2Lki2isJtrEE6UATH2ipSDHVm/TT+0qLBLVx/gaR8cpAe0Tq/vYHwkFE=
X-Received: by 2002:a05:6a20:2926:b0:195:687:7921 with SMTP id
 t38-20020a056a20292600b0019506877921mr218388pzf.58.1703190096948; Thu, 21 Dec
 2023 12:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221183540.168428-1-andrey.konovalov@linux.dev>
 <20231221183540.168428-3-andrey.konovalov@linux.dev> <CANpmjNNkgRbj4jgAGHtKTBB0Qj_u+KmFnBS5699zjL7-p1eV+Q@mail.gmail.com>
In-Reply-To: <CANpmjNNkgRbj4jgAGHtKTBB0Qj_u+KmFnBS5699zjL7-p1eV+Q@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 21 Dec 2023 21:21:25 +0100
Message-ID: <CA+fCnZf1TDEu9JwT2my7-p9XKrHjyWyjpXiGJ2y6SV9mxcCZvA@mail.gmail.com>
Subject: Re: [PATCH mm 3/4] kasan: simplify saving extra info into tracks
To: Marco Elver <elver@google.com>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	Juntong Deng <juntong.deng@outlook.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 9:12=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Thu, 21 Dec 2023 at 19:35, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Avoid duplicating code for saving extra info into tracks: reuse the
> > common function for this.
> >
> > Fixes: 5d4c6ac94694 ("kasan: record and report more information")
>
> Looking at this patch and the previous ones, is this Fixes really
> needed? I.e. was the previous patch broken?

Yeah, maybe it's not needed in these 3 patches. The original patch
works, these are just clean-ups.

