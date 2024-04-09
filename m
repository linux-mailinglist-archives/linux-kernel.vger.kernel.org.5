Return-Path: <linux-kernel+bounces-137275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C595889E061
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0298B2135E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF9513D53C;
	Tue,  9 Apr 2024 15:55:06 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26513B293;
	Tue,  9 Apr 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678106; cv=none; b=UCueXl24J299Z4u0ruRpcfW2Tr+xhWY9dE0FxSuNwG286bDhUnDu24JIv6yPaQmMruKRTFSgHLiPgJbz2L5zM5/C1Jm1qL0T42P3zpaFheFWRrNcQONab2bCqEIHaz1+bXkM517hMUsZipZ+pqK8/SFqWnKarUrvcl9LmsSFLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678106; c=relaxed/simple;
	bh=0lPHtPQnZWwOuPYNH0Mij7OvM1YjXB78i9gew5k4nBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/Nhrh2hJJBCZbXaZrdjBziBgBgfBFjOeu9bsfR4GAwMQSk5MaVnSIm/jD8mNX4bJea5KtM5CNHka84g2myQr5GZ3UdoK8YPTfkBxIE+R9GHnWMo1qIz1TMeRj8gM0vZuCZ5yESLg5GDTnk71y1k4BuFSEwSW6SkX8XtPvAY+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so4435961a12.1;
        Tue, 09 Apr 2024 08:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712678104; x=1713282904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6krUFkZxSu7NHCuJ24hvqtrbwkrF1MhKocaeSXBeP1g=;
        b=BVTkKK/MdEWX6HBXWry60C1xxrWD9IFMx+se6VU9KlsAeaw9cJWHRS689RPSKhXTHs
         GZTCqB0I8/TkEaZnR8hFyJDPEdu/FaDhGhtCe43bWp5PvLtUcdpyY7KpfRl9ngevTb30
         DbwX45tdYgSAuy5w+PeEBkv90LuU75HAPa/p9+UTGYL/291zG8edNiuikYg1t1oWvffg
         1LGqnL1+K6VwLfncFqfCo9fUj8Xe1UGZBmmFb7bK3DjpSB7n9etNkDfrIHCoojXxrNFO
         G6bYC7bssTiyHNJxMHpBZyTg5i1/aWEZOhfZo8dwJZx8inNbB3Mpz0Fms1/C1SjmSYTR
         9PRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXgKioS39D+vOK6OChRLWYE/VCg/usgUYVa11WUK9MtYnjf+jOJRSvdeOWvsrUchocHCK6IEcfD6lWw7ALQWJvy3nGG7CQpM36z/1xm9LZMxB2xheJnnQ+TG3RvajurrjlRd2MoUWVkZ9hSe40eQ==
X-Gm-Message-State: AOJu0Ywgm6y4bCj1+bujwjDBLkWa1NLXmiFK/oaoKLqI9mv/HSceruaf
	pYCo00CfoKPh9JthI9NmTfbNgxodBtAkICdUXzxfD+IAIDJWN0DxlbD1+s8w2KsBaMRFMAmADmc
	Ceq1lsY/AE3MWWKEysAkI/vL/QY4=
X-Google-Smtp-Source: AGHT+IHE/dEmZWu5fRh3HefzkZZpkUkBWoB/yZw6LtaPY8lxKNr+Qil08N6s7/bplA2zcN7caznfjTQ4tImCgt1wQzo=
X-Received: by 2002:a17:90a:101:b0:29b:ccb4:a250 with SMTP id
 b1-20020a17090a010100b0029bccb4a250mr40293pjb.16.1712678103729; Tue, 09 Apr
 2024 08:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408185520.1550865-1-namhyung@kernel.org> <CAMuHMdXQ_osFeknmg=oR6-fMH_MkVqabCtbynxQ6UvpZRwry3Q@mail.gmail.com>
 <ZhVG_9KpcWLLhc-s@x1>
In-Reply-To: <ZhVG_9KpcWLLhc-s@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 9 Apr 2024 08:54:51 -0700
Message-ID: <CAM9d7ci+r73oNUOS7zjHmRGkQk0OhLAdv4zqt7BV+y4jb1rkwg@mail.gmail.com>
Subject: Re: [PATCHSET 0/9] Sync tools headers with the kernel source
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 9, 2024 at 6:47=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Apr 09, 2024 at 09:15:02AM +0200, Geert Uytterhoeven wrote:
> > Hi Namhyung, Arnaldo,
> >
> > On Mon, Apr 8, 2024 at 8:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > > I'm gonna carry these changes on the perf tools tree.  I'll update th=
e
> > > vhost.h once it lands on the mainline.
> > >
> > > This is the full explanation from Arnaldo:
> > >
> > > There used to be no copies, with tools/ code using kernel headers
> > > directly. From time to time tools/perf/ broke due to legitimate kerne=
l
> > > hacking. At some point Linus complained about such direct usage. Then=
 we
> > > adopted the current model.
> >
> > Do you have a reference to that?
>
> I would have to do a search on the mailing list to find the exact
> exchange, this is from memory and from people asking this repeatedly.
>
> Ingo replied with reasons similar to the ones I use in this canned
> explanation when sending the notice of updating the files.

This is the Ingo's reply:

https://lore.kernel.org/r/ZhTwPLliHXKPAJUQ@gmail.com/

Thanks,
Namhyung

