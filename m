Return-Path: <linux-kernel+bounces-50818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65340847E47
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13CF1F280C8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF06612B;
	Sat,  3 Feb 2024 01:54:47 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C425522C;
	Sat,  3 Feb 2024 01:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706925286; cv=none; b=Y+ndncEYVjgDyj3b5W2gtf8zGiwYSfbhQnkRGQxswl1FhFhiHJkB89LODe3t3R3WQDTAIlEQBs18VnYej6gPvbTnByXwt2GquQrq4LGFQG57+HUe6236CujH6fW0H2yXAauiKPopleo7rfXLun+xTnc0MFIFSeqm9A/b7AgJrT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706925286; c=relaxed/simple;
	bh=ru3a+7plwttqZ2saoByjAcpMkbi4wbz86/ikmmtOWfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZI6XMQQFrpsJIvahAjqCos95LaIxZg1sbvabgkMjcoO1kGgcTi3ZU25PS0pTeOzs/Es5v6ez3NsrUTTK42g+C7Ptnila/SOduxpMCigrydGllepR1bY078rlPT1orCzx6bj0fn5CNuTcZJxBkKRZRKgFMkMhDe7cWFABrR89uXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2963ddea851so1094889a91.3;
        Fri, 02 Feb 2024 17:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706925285; x=1707530085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyHFg4Q3szLDlbtLnSwgKC+pD1zvFdMTcgfevkc4/bs=;
        b=i6WNOkLUPP6Wbe0Eb8rnqINcysXos9G/o7ezPJjI+jYDV4NHuc3TwotsP67kg57+36
         BtZVJWP13kgNB7T74O+aWprfHTDrAEy2f9lh1JhMiuwtl9LdY1LeKpQ9InbU+Mk2cNXL
         O8SgudQvZAnqDzmtPreqJrzoLABM2T03EUEIBQHahvXsPt0auildxi9m3N7ArpjiseY7
         4YN7WZI6AqKDbTGzFDd+A/dfET2TwNx3lka8nN/2UHpxNDwhAIhbhrqOQ0i6Rb50bFP1
         6WnNeDYi4HR6s++z5gSbkwQG23hHOQ7yA5uEbtNdb4kiKlYzyuoXLcur/Q2AdGGReRs0
         0jSg==
X-Gm-Message-State: AOJu0YybJpJnH7gQGunz+rvO3lec6dhq/9ZLgY9VZFFEVnhjT89+w3t5
	Wd5AF9EGn/D0GbOv8nZ2tm5oJLwE1E4JDiHwZ4GJp1I9CB/rFnYDNAbZbMxgLyLRO5bPzzl6vil
	QKpB9sYG5Oip0U2OhqOwX/WgJV18=
X-Google-Smtp-Source: AGHT+IE68NUGHJAcWfnjwco7PqFYhaQkuaZkWiv7BrCZ1e+RcjYI9I+0uhathfurw5+smL+Pgi5FzYF94RayljJigTc=
X-Received: by 2002:a17:90b:295:b0:295:e8ea:3724 with SMTP id
 az21-20020a17090b029500b00295e8ea3724mr4039304pjb.34.1706925284654; Fri, 02
 Feb 2024 17:54:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123103137.1890779-1-ben.gainey@arm.com>
In-Reply-To: <20240123103137.1890779-1-ben.gainey@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 2 Feb 2024 17:54:33 -0800
Message-ID: <CAM9d7cjTm0y9cPy7RpRVGaphD6TBEbnRANc+8kRAvjrBtfq6NQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] tools: perf: Expose sample ID / stream ID to python scripts
To: Ben Gainey <ben.gainey@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 23, 2024 at 2:32=E2=80=AFAM Ben Gainey <ben.gainey@arm.com> wro=
te:
>
> This patch modifies the perf python scripting engine so that the ID and
> STREAM_ID are exposed as part of the sample so that they may be
> correlated to the corresponding throttle/unthrottle event (for example).
>
> NB: For scripts where perf_db_export_mode =3D True, this may be a breakin=
g
> change depending on how the script is constructed. Each field is passed
> to `sample_table` as an argument so any script that is written as:
>
>     def sample_table(db_id, evsel_id, machine_id, ..., cyc_cnt, flags)
>
> will now fail due to the changed number of arguments with:
>
>     TypeError: sample_table() takes 25 positional arguments but 27 were g=
iven
>
> Scripts that use:
>
>     def sample_table(*args)
>
> or some variation thereof will not be affected.
>
> When `perf_db_export_mode =3D False`, the script should be unaffected as
> all the arguments are inserted into a dictionary.
>
> The export-to-xxx.py scripts use the (..., *x) form so are not affected.

As long as all in-tree users are fine, I think it's ok.

Thanks,
Namhyung

>
>
> Ben Gainey (1):
>   tools: perf: Expose sample ID / stream ID to python scripts
>
>  tools/perf/Documentation/perf-script-python.txt        | 4 ++--
>  tools/perf/util/scripting-engines/trace-event-python.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> --
> 2.43.0
>

