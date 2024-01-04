Return-Path: <linux-kernel+bounces-17070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32DF8247DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922AB1C2430E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E217A28DBA;
	Thu,  4 Jan 2024 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beTwPQu0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6328DAB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e70b9a840so78e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 09:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704391027; x=1704995827; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXgbTOAEkcnN9x3L3X6XAXMZYd9HjGggBKwplycVfKo=;
        b=beTwPQu0+yZwrolnWvg82uWAsq7JVTx4xH4jzBXcWxs/mDbhA4Er0shmZxvg/f2icS
         xbn5ssX6ATIgRbnutjMlPqRQ4xsDLoevnUBvwu9PVOEKklrh1erryX3hARHOJJyyifnb
         MkjKyRE0yWTRKKzsvEflngTcFy73I4iGJROB0ZbAZyS54uG9Y0dJxQKyHda1a2vJf8cU
         xW9FEoAyOW/UOmTYTU8kK2Dvc9mN6UVmPunJtGfA97aMcNOl1ObTRRYxUAwZZeMNtkNf
         ALjpe5jMzaIrH+stvH2JUNF8fAV/gbhxeLik/d90HLjBuN/i9ba7FMGjTG27KG6Q91sF
         4AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704391027; x=1704995827;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXgbTOAEkcnN9x3L3X6XAXMZYd9HjGggBKwplycVfKo=;
        b=Wt6kLjIXxZnpPYiX8sCkObCwk2brmHoDjO/UZNhy2Sf6qX+ynp1PtXNyvufoZlTEM/
         ICib3WEH1EYqSdh5c0LJq6vmi9Uj7jgoEFByCFAN2OrgVe0sdUxNHvneEgKA+0PIBVdc
         bIEByXO2a89Ma+zBx4oIdVtW1DeRqr2AYztL9UytQpxYh4cN0TdQ1alGrS54PyMrCKLS
         kxvSNicUHnf8kQWBXCKfALwScUgg1qFSrg4RDvQDkJNryTlsZb7QgpkIi0VkSPduCdDs
         BL0ZKNcMw7bDDqOZuvy+o3sog++VQeEmfxytT2VChBkhiatrbMFjc9y8ErSfUaWjrsF6
         TOYw==
X-Gm-Message-State: AOJu0Yw9dQMeFv6+NhemBmftIlDinzyub5/2EXtz02OzUyXFSgShGZDL
	sND8wlI2atCc5vTUy2uZPdpEUCo+dwLfJj2GrHewQRoRI1k3
X-Google-Smtp-Source: AGHT+IH+Lnu96FD2lTLdKRXh6DZgpHN8V0gwgbqVDQNL0SDcqcWkwW8cYHQfF3F3nGFltzPNGRNZ9d8bzc9t2YQBYIs=
X-Received: by 2002:a05:6512:788:b0:50e:84b4:2bdc with SMTP id
 x8-20020a056512078800b0050e84b42bdcmr3551lfr.2.1704391027487; Thu, 04 Jan
 2024 09:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208000515.1693746-1-irogers@google.com> <CAP-5=fVQfqS6gu9Ua3Exijc_ZaBzrt2=1PMopgdoyC_6R_cnaQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVQfqS6gu9Ua3Exijc_ZaBzrt2=1PMopgdoyC_6R_cnaQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Jan 2024 09:56:55 -0800
Message-ID: <CAP-5=fXqKjQ3Rn=N9sV-6Accce1qsMK19Hy3yGJE4s0OHy6XVQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] lib subcmd: Fix memory leak in uniq
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Chenyuan Mi <cymi20@fudan.edu.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:30=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Dec 7, 2023 at 4:05=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > uniq will write one command name over another causing the overwritten
> > string to be leaked. Fix by doing a pass that removes duplicates and a
> > second that removes the holes.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Ping for this series, no comments since sent.

Would be nice to land this set, especially for giving suggestions for
inbuilt commands:
https://lore.kernel.org/lkml/20231208000515.1693746-2-irogers@google.com/

Thanks,
Ian

