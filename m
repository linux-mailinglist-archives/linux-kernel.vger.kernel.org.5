Return-Path: <linux-kernel+bounces-13199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B8820113
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0872834EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3C412B9B;
	Fri, 29 Dec 2023 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAM2rQie"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3B12B92
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e8ca6c76dso1727758e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703875552; x=1704480352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw8IwBYWmxLQpniIBFrvuX5MLvTF3xaFsIocGifjYlk=;
        b=KAM2rQie/MXwDXmkpdlAzmS5bBGiIUhpBp4LGjtCAhh3jQR6ogwLsJBRpjXHJhSX0A
         +uqjS+TCDflhs9VAdyLilibmLgwtM/iUGa1vSakXZJlWz+Y63Ez9tjqIRNRI32eMTAfV
         qeh0kFPGOXLEhTrl/Wf+pcF+2Yl6M4Ep1X/Dj+qkmWrZoAplgej6enYsxViPOu8WyGRZ
         6pLiSgsudnI7vU/P4+Hcn837cPCZK+zAufT+wer7KNHYcc1XOhUSuy8ispE2yhK9BkuZ
         XbUVSbp8HpH+bZ02SXh0qSvGzenuFIIq27MXcBWUYgD5bqLFbOEcM3P1ACBdQb+FvLi9
         9LfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703875552; x=1704480352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pw8IwBYWmxLQpniIBFrvuX5MLvTF3xaFsIocGifjYlk=;
        b=ceoN9u9UPebX0XDQfNrXlhAXCPEDEVWJFKy2u4GCVyMmjtS1dy+k4M0oidgrJ60JOL
         Q7NdmuCxO083Nl0TwyuehoNRnOjBYxJU5alwVnzvfFcwTPlSJrJ/jrwuk9MnVu4wy0nt
         A2n8/NN18hgZneGL05ZSgz3R9hUZH5umVeB/7GEBK2oyc53dx+gFr56gbJCZanbIam01
         OM+JZkh7BQUTESmZCfj1u64UXNs3WSZskB8LMAMULatmEhVSrRv3QYZl6Yh5QgoKU3Wm
         KUSijkw5DfUwrXIGyYAaKiWkDs6/zpOF3hdL5C3Dcxi1u2LUfXEwEO3nYwoBgz8U7xQh
         AqPQ==
X-Gm-Message-State: AOJu0YxjwGItIXJ93uhmxXGVGNO/X1gD2irQqgnWGwhhKUrV2pvOKkBl
	TKe3QjfXTYeTi+DbRX+I9YSjsKwGTuyaLwHeIGbmKPq986A=
X-Google-Smtp-Source: AGHT+IELxGcaLRkaPzasLhR9lVe/fd0jx7ijdIc7tEo82u8zm64EUlH9S5ROiM7H/34aSgLyCrIz6G/KyfjIOjnEjbA=
X-Received: by 2002:a19:6d1d:0:b0:50e:4ecb:d68c with SMTP id
 i29-20020a196d1d000000b0050e4ecbd68cmr4056752lfc.118.1703875551546; Fri, 29
 Dec 2023 10:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228200936.2475595-1-yury.norov@gmail.com>
 <20231228200936.2475595-4-yury.norov@gmail.com> <20231229103948.4a78a75a83962df0874d04f1@linux-foundation.org>
In-Reply-To: <20231229103948.4a78a75a83962df0874d04f1@linux-foundation.org>
From: Yury Norov <yury.norov@gmail.com>
Date: Fri, 29 Dec 2023 10:45:40 -0800
Message-ID: <CAAH8bW86DsJadrV5jSSp-wsCfAc5+zb7Qya9qSSOcomFv5ZsfQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] lib/group_cpus: relax atomicity requirement in grp_spread_init_one()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ming Lei <ming.lei@redhat.com>, 
	linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 10:39=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 28 Dec 2023 12:09:30 -0800 Yury Norov <yury.norov@gmail.com> wrot=
e:
>
> > Because nmsk and irqmsk are stable, extra atomicity is not required.
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > NAKed-by: Ming Lei <ming.lei@redhat.com>
>
> Well that's unusual.  I suggest that the changelog at least describe the
> objection, and its counterargument?

Sorry, forgot to copy it from v3 discussion. Please find below:


> > > > I think this kind of change should be avoided, here the code is
> > > > absolutely in slow path, and we care code cleanness and readability
> > > > much more than the saved cycle from non atomicity.
> > >
> > > Atomic ops have special meaning and special function. This 'atomic' w=
ay
> > > of moving a bit from one bitmap to another looks completely non-trivi=
al
> > > and puzzling to me.
> > >
> > > A sequence of atomic ops is not atomic itself. Normally it's a sing o=
f
> > > a bug. But in this case, both masks are stable, and we don't need
> > > atomicity at all.
> >
> > Here we don't care the atomicity.
> >
> > >
> > > It's not about performance, it's about readability.
> >
> > __cpumask_clear_cpu() and __cpumask_set_cpu() are more like private
> > helper, and more hard to follow.
>
> No that's not true. Non-atomic version of the function is not a
> private helper of course.
>
> > [@linux]$ git grep -n -w -E "cpumask_clear_cpu|cpumask_set_cpu" ./ | wc
> >     674    2055   53954
> > [@linux]$ git grep -n -w -E "__cpumask_clear_cpu|__cpumask_set_cpu" ./ =
| wc
> >      21      74    1580
> >
> > I don't object to comment the current usage, but NAK for this change.
>
> No problem, I'll add you NAK.

You can add the following words meantime:

__cpumask_clear_cpu() and __cpumask_set_cpu() are added in commit 6c8557bdb=
28d
("smp, cpumask: Use non-atomic cpumask_{set,clear}_cpu()") for fast code pa=
th(
smp_call_function_many()).

We have ~670 users of cpumask_clear_cpu & cpumask_set_cpu, lots of them
fall into same category with group_cpus.c(doesn't care atomicity, not in fa=
st
code path), and needn't change to __cpumask_clear_cpu() and __cpumask_set_c=
pu().
Otherwise, this way may encourage to update others into the __cpumask_* ver=
sion.

