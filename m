Return-Path: <linux-kernel+bounces-55746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ABC84C11E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872671C22E33
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99923320A;
	Wed,  7 Feb 2024 00:01:40 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579A1CD21;
	Wed,  7 Feb 2024 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707264100; cv=none; b=X9EC0iYkhWEFs9WjrmyFpH5ESGe5U5sYmnx8ubRTBEKf0EE3ujnvhhcmm35GrmWerxis3OrTdfvMOdiPR7HbIbr9vpeBkjlybYWLaqDnEvQRRNdIogdxLxAmw+pWdIyrGXTa11nQf+g9NN3C+n1mRlKACTS75L+7exhhTFah4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707264100; c=relaxed/simple;
	bh=p3cCyYpZZsU3rRtdl4vxs+Yw0c2aMZzobtjeNJFoCc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+XTPg8knTg33NPQi8deZm46ak5WEc1PbiQDGmgSGV9fahcBoPkNNZgTWc1frzlovW5xGY+n646/vuPrR6Y5L0LVUqwEZ87nNp5ZRbGp5R5/VBSj3clVpqA5+JtZTBB7qhXzCwR7FG6nkv0n5GUI40jRaTZdoNqh8lEV6VsOU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so41392a91.1;
        Tue, 06 Feb 2024 16:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707264098; x=1707868898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBPZC+4srisd68ZncoOUuxyi0NgzTLAaSaxaA+A43OU=;
        b=fsLgjlCi/gDiPU03gmPjL3WJFbeuxFZQsNmMx5osdRGmn5Jr83naUKFCimoderjElA
         AuRG2QY/rWnNbpVSlaB5Yi56h1m4PEZqSqnQNb4XDAsjmtvFecjdDIKKmFALB1mfbwsf
         YWuMHxZG8qDkYAhHbsgPyFVID8r3BDBVBhNwi0XA86SJkbOD+CfBdA1ZO9b0CJqCeCrV
         thFoZyKNQ1A+u3deH9jCZ5lBMzCwE3zNSV3E6PMeYKxXaNqrwiVVeVANaNBKZfwSofvQ
         agm1K+g1o1UXsNXM9vP3vBn9hGbZmoQd1xRxuddiouE+uvQZ22PCvxF1WEp3pzA/6Xzc
         QURg==
X-Gm-Message-State: AOJu0YxytiMVCM7upyf8qhG82LmduysM0tlte+t8fqKUrurI3rplad7b
	xJRFuuXsMBNwhYc8k8xH46yEal2KkhHSUDSax8/dKonU6ApJMdr+Tcjuub4FUaCVZughYQktr0i
	l8n7r+96JsxKiMsGSpxWa6EGTGyDpAvCgq7U=
X-Google-Smtp-Source: AGHT+IHCF+fC9VUF72QrSbFbOJYdpuMJaefNg4aWifwJnoOQmv3cCY08kAJ1IGyt8s7uLZw6BAed+4qlrG8Naruuu/Y=
X-Received: by 2002:a17:90a:2ecb:b0:296:84e1:de64 with SMTP id
 h11-20020a17090a2ecb00b0029684e1de64mr1071726pjs.20.1707264098078; Tue, 06
 Feb 2024 16:01:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206235902.2917395-1-irogers@google.com>
In-Reply-To: <20240206235902.2917395-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Feb 2024 16:01:26 -0800
Message-ID: <CAM9d7cjD4KQaC2LyDhRMfPP8ccbxba_pRHEmVn90S6Nok+U3ug@mail.gmail.com>
Subject: Re: [PATCH v1] perf kvm powerpc: Fix build
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:59=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Updates to struct parse_events_error needed to be carried through to
> PowerPC specific event parsing.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: fd7b8e8fb20f ("perf parse-events: Print all errors")
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung <namhyung@kernel.org>

Thanks for the quick fix!
Namhyung


> ---
>  tools/perf/arch/powerpc/util/kvm-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/po=
werpc/util/kvm-stat.c
> index d9a0ac1cdf30..c8357b571ccf 100644
> --- a/tools/perf/arch/powerpc/util/kvm-stat.c
> +++ b/tools/perf/arch/powerpc/util/kvm-stat.c
> @@ -114,7 +114,7 @@ static int is_tracepoint_available(const char *str, s=
truct evlist *evlist)
>
>         parse_events_error__init(&err);
>         ret =3D parse_events(evlist, str, &err);
> -       if (err.str)
> +       if (ret)
>                 parse_events_error__print(&err, "tracepoint");
>         parse_events_error__exit(&err);
>         return ret;
> --
> 2.43.0.594.gd9cf4e227d-goog
>

