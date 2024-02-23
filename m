Return-Path: <linux-kernel+bounces-77864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1D860B30
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3AE1C236C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB73114AB8;
	Fri, 23 Feb 2024 07:12:23 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10791134D1;
	Fri, 23 Feb 2024 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708672343; cv=none; b=UUpsqC6XiiS1LYzg0zNC0JdLHuGo8T73eyxGAV7oZ+I9t0ZkpjMb9xt9zR2YooTSJ138mc69tijeUf7Wh/tBn6wAWLJy0xJt6hF1NMbxpWnnkCyXFD+s/YCMTQyA/NhkCFw4IH7ylYS5iypFKSY08XoUcdqd5nTugt3VabsCbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708672343; c=relaxed/simple;
	bh=euV3Flsf99oKeUKttYEXVxgR56sxpAk7m4tJQ5C4w54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UldeoLB78VLC3IepSozinlZZsMeaVihQontBiuVjOru/xYkZ+L1kal7TU8cmgWctU1xFZ96X9bbm4Y24LdUO0hSWKPQExJbMWjF0Msk9m793UKjvphx+oUhDgBlPIOKFVJ8e9KYxAqAmLTy3Z/Wdxr5D6nJZG9w8OIXrDhJP7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e45bd5014dso223569b3a.1;
        Thu, 22 Feb 2024 23:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708672341; x=1709277141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1/oy7XlfxqEsqkzmdhnzCfKVnHYh7+xgUlJxwYGD9g=;
        b=O4KvCWIY+t5D6YW89hqeHetQWJ8/BmFJ2MYwxkQvvJNSCCq7R6fg5sVxxGdM7Aw2H5
         oivQvtoBgRxd1KUQaIFF3arBLnZoyjdAkVu1D3N3PMzlYRCyxObCcjE6eHWoE+B6AH+l
         FzZVaZUboWQlaBhLrQqY6uiRSdQvQ81xED/Styi4E3f2IEENtCydc0qpSDWtVUDdgw/t
         HpL/ALgXVpPFnYliGNzmJC6Oy4BWRfCGNjUUB1n76A1tV9eU+4C2oYdvEBGQbUYMbcs2
         gSDNJs34ukClOozZDoGxc4OmpV6CEhOB8X7pNE369+JNM2bKYR6DDF/Ij9VO6m7YdSlA
         apPg==
X-Forwarded-Encrypted: i=1; AJvYcCV2ag02dfJvx14UNrQa01D4BFRFEUGhh7kKUVcn44DPWSO53qIn5xVT7mVfOrbLGOvcmfBx63xcXR/1PgnKqXC0tWy0asbrsN2idLBan/7fvy2vd0byAuu0FeERcg6k2w7gSqtNbS4yIG+nLJ/Ulw==
X-Gm-Message-State: AOJu0YzofEJxDet37cudrDv7lpCKSn9db8mTRl9S0k6U4FEkiQ+/VnEc
	aotFopn+CZu5QHiCrWFLBTI8bCdPPsUUEVUpxbxHVjz3ShDkKKP/RXWFMumPrZLxui9joBjS8b6
	u+s4Nqdpmwm9mCzaZmMB6wHuZBIygFbRc
X-Google-Smtp-Source: AGHT+IEforQ2SGC2OG7bnanDl/MQmLhCpn3pZiGTnH73P8oXC/479csrdfRM55HOSMkzoFpAviFyvLaHBATwYkrf5C8=
X-Received: by 2002:a17:90a:9dc2:b0:29a:827d:e805 with SMTP id
 x2-20020a17090a9dc200b0029a827de805mr224644pjv.34.1708672341348; Thu, 22 Feb
 2024 23:12:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117215101.77713-1-ilkka@os.amperecomputing.com> <d77856e0-50e8-b7b4-734-93be3447ed73@os.amperecomputing.com>
In-Reply-To: <d77856e0-50e8-b7b4-734-93be3447ed73@os.amperecomputing.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 22 Feb 2024 23:12:09 -0800
Message-ID: <CAM9d7cibn7ygfZoHCMNJF0DvRNw4dcyBHSbF0Jm20BaEoQbC=Q@mail.gmail.com>
Subject: Re: [PATCH v3] perf data convert: Fix segfault when converting to
 json on arm64
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: James Clark <james.clark@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Evgeny Pistun <kotborealis@awooo.ru>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Feb 22, 2024 at 1:42=E2=80=AFPM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
>
> cc: Evgeny Pistun since he submitted a patch pretty similar to my first
> version
> (https://lore.kernel.org/all/20240125184411.30757-1-kotborealis@awooo.ru/=
)
>
>
>
> Namhyung and James,
>
> What's your thought on this? Is one of the patches (Evgeny's or mine)
> good enough or should we try some other approach?

Sorry for the long delay.  Please see my comments below.

>
>
> On Wed, 17 Jan 2024, Ilkka Koskinen wrote:
> > Arm64 doesn't have Model in /proc/cpuinfo and, thus, cpu_desc doesn't g=
et
> > assigned.
> >
> > Running
> >       $ perf data convert --to-json perf.data.json
> >
> > ends up calling output_json_string() with NULL pointer, which causes a
> > segmentation fault.
> >
> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > ---
> > v1:
> >    - https://lore.kernel.org/all/20240111232923.8138-1-ilkka@os.amperec=
omputing.com/
> > v2:
> >    - Changed the patch based on James's comments.
> > v3:
> >    - The architecture is checked from the actual data file to allow one=
 to do
> >      conversion on another system. (thanks to James for the feedback)
> > ---
> > tools/perf/util/data-convert-json.c | 8 +++++++-
> > 1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data=
-convert-json.c
> > index 5bb3c2ba95ca..405c38371870 100644
> > --- a/tools/perf/util/data-convert-json.c
> > +++ b/tools/perf/util/data-convert-json.c
> > @@ -284,7 +284,13 @@ static void output_headers(struct perf_session *se=
ssion, struct convert_json *c)
> >       output_json_key_string(out, true, 2, "os-release", header->env.os=
_release);
> >       output_json_key_string(out, true, 2, "arch", header->env.arch);
> >
> > -     output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_=
desc);
> > +     /*
> > +      * Arm64 doesn't have Model section in /proc/cpuinfo and, thus, c=
pu-desc
> > +      * is not set.
> > +      */
> > +     if (strncmp(header->env.arch, "aarch64", 7))
> > +             output_json_key_string(out, true, 2, "cpu-desc", header->=
env.cpu_desc);

I prefer checking cpu_desc (if it's NULL) not the arch string.
Maybe other arch has the same problem or can introduce one later..

Thanks,
Namhyung

> > +
> >       output_json_key_string(out, true, 2, "cpuid", header->env.cpuid);
> >       output_json_key_format(out, true, 2, "nrcpus-online", "%u", heade=
r->env.nr_cpus_online);
> >       output_json_key_format(out, true, 2, "nrcpus-avail", "%u", header=
->env.nr_cpus_avail);
> > --
> > 2.43.0
> >
> >

