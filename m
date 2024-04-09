Return-Path: <linux-kernel+bounces-137690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46BD89E600
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8782847E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0059158DB8;
	Tue,  9 Apr 2024 23:17:43 +0000 (UTC)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80B157476;
	Tue,  9 Apr 2024 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704663; cv=none; b=APQVXO0iIsfnS8OlVWqxLM3LEtmtC6/60LZJUq7+D03ZGpkaQr3Z5XOJLm5TMKzny67BOQL/vAhEZ4ZY5u8sLcYUgQ+JOUktjKfkCvdSzXZ9bmwwScd2Tj+qBORp/mlxgDLGqSqsqIGoWqqtA7ydmytUBBWrp3PTF3siNZ1Mhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704663; c=relaxed/simple;
	bh=XzfRDNRGPZVbbxVVG5TQM5B8RqqnACAXlUaLzu/rLQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hT93bvvbA5fLm+9S1C/6qomGrdanEVyIjp/symLs+wnXYemdBEFMrmAkq2HK+OCPC/ltP6RZpyGAMXDwu1h3NfFwKbES1v0WAw47rsanQ5u0P+DVl748UhtuNaKvifPcw9PiNS4c0k6IUsU59Lvdey6M/yG5YvBAEXdPms0eIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4da5eb33c45so1505162e0c.0;
        Tue, 09 Apr 2024 16:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712704660; x=1713309460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZRdzvjTP1IiYFiNM6neO/CKV1723f7tgntEnWqUvYk=;
        b=YEYQpT8b3YlVjlVq1E09ckx/Rd3igxB45/L/ZmJckvKjITJnou2LRk8f1SwHmbO4Kn
         5QmaVSe6GmxfVDyunawxxGCErHbJzGkmoBh8P0FkNwu6H0IVdztbcnyWo7aYlFwRaUdQ
         otnfja++neB+jgJGm1XLZKcyl+0LAyIm4Kj0DkDy9X6nawQviv0f4apSOSlZd01XGJBl
         Z9lHgFo/J2fq1IpC4ccWwEve7wCv4Xl9nN9jvrpFrmH3xEhb/TFCy6QSXPZf4UJW3Fip
         iN2tyoWyAB+L9EXQjNumxkgKrdyxe1BYH1qopoMrfUPRDzegC2Nzn0ejBr9/eSselrmv
         /93g==
X-Forwarded-Encrypted: i=1; AJvYcCX4D0CAvHlQ00o5RIf4NKbOJVE4AuLqhgjvBYUFVuRS1I10NCr5XZO7NOBwG02SejlHIYwd6f9NiWVh/tHBS1znVdIrnvM1HKclWLSPyNzL4lyO9dGWwQJ93jjbDWn8wZHEzk0wV58kacgO0cMnKQ==
X-Gm-Message-State: AOJu0YyNAKlrDWG/gSbvVKKOkWhQQkNZPmOWtW/alldLPxyEZ3Pwcy54
	Gsl0g3GOmLtXaK7NIo9vptrJtldxRwJ4dEzC3jjZhBd5NLHXw0IqNAnxGF1Ga6M4E418T+nYMtl
	n36dA00TQBTcV+NreKvCAaMIEpdg=
X-Google-Smtp-Source: AGHT+IHNDxLPNgcQXhQLC6gMByHBE5tO0KLOEhiOzKz+Il4TiFL/ag6z6u+wFZdYLk4Z2sXSQgcHVMQR36btc96oDa4=
X-Received: by 2002:ac5:c77b:0:b0:4c7:7407:e8ab with SMTP id
 c27-20020ac5c77b000000b004c77407e8abmr1163331vkn.12.1712704660524; Tue, 09
 Apr 2024 16:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409084741.405433-1-james.clark@arm.com> <20240409084741.405433-4-james.clark@arm.com>
 <CAP-5=fXRODCKJexjxqkW_Wkf5MTxFJeq8zmu-iUbpEJM-9gjgg@mail.gmail.com>
In-Reply-To: <CAP-5=fXRODCKJexjxqkW_Wkf5MTxFJeq8zmu-iUbpEJM-9gjgg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 9 Apr 2024 16:17:28 -0700
Message-ID: <CAM9d7cio+JYnzwtiVSpsmGrxJWyqv3m0ppmqGidHs5psZdi93w@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf tests: Skip "test data symbol" on Neoverse N1
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Leo Yan <leo.yan@linux.dev>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian and James,

On Tue, Apr 9, 2024 at 8:39=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Apr 9, 2024 at 1:48=E2=80=AFAM James Clark <james.clark@arm.com> =
wrote:
> >
> > To prevent anyone from seeing a test failure appear as a regression and
> > thinking that it was caused by their code change, just skip the test on
> > N1.
> >
> > It can be caused by any unrelated change that shifts the loop into an
> > unfortunate position in the Perf binary which is almost impossible to
> > debug as the root cause of the test failure. Ultimately it's caused by
> > the referenced errata.
> >
> > Fixes: 60abedb8aa90 ("perf test: Introduce script for data symbol testi=
ng")
> > Signed-off-by: James Clark <james.clark@arm.com>
>
> This change makes me sad :-( Is there no hope of aligning the loop? We
> have little enough testing coverage for memory events and even precise
> events on ARM that anything take away testing coverage feels like we
> should try to do better.

Can we just add some noise in the loop?

Thanks,
Namhyung


diff --git a/tools/perf/tests/workloads/datasym.c
b/tools/perf/tests/workloads/datasym.c
index ddd40bc63448..e2514bf393cd 100644
--- a/tools/perf/tests/workloads/datasym.c
+++ b/tools/perf/tests/workloads/datasym.c
@@ -16,6 +16,8 @@ static int datasym(int argc __maybe_unused, const
char **argv __maybe_unused)
 {
        for (;;) {
                buf1.data1++;
+               if ((buf1.data1 % 100129) =3D=3D 0)
+                       buf1.data1++;
                buf1.data2 +=3D buf1.data1;
        }
        return 0;

