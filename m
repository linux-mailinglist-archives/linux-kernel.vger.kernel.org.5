Return-Path: <linux-kernel+bounces-28321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C144482FCEC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB5F1C28385
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D7208BC;
	Tue, 16 Jan 2024 21:54:03 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABA1D6BD;
	Tue, 16 Jan 2024 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442043; cv=none; b=s5OWPmiug9h4/vNIJtm/X+vRGzJMHf/OZnE4bzDIh76uBpPYupGHdgDHdw3j/JVB4/zseQgZEJ2bjyS/FIkzJ3LZMtH2hRZ0THHt1O9m1g/H6xWB5oGUhmcePIn3e+GUtnMK6/agVIz/SgUyBnGzGplS7dVspsPHbaqFOXC9VgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442043; c=relaxed/simple;
	bh=etsIip4ervQ72CbIa+MN2P8hU3lpHAA1QXD3Z7KizAY=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=aClxlfNpxeZ5d8BVVvMxGtECevkFuGAkbirb8EWRAKufumkVFLbFierq2g8KpqzNFbfr/UcoWyjc1qdqQASovdBf2bUxk3lFP3Rria4PiQdWv9Q4l6Epx4KPB4Ffvz4T7xQwWo9FHSYR2YegDHNasYOGAgFkTNlVs6lEvx7DQBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so4552897a12.0;
        Tue, 16 Jan 2024 13:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442040; x=1706046840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P00sqh0pFFh48+YMUrZPqOjo0LVvWK+WBACLbeRVv8E=;
        b=p10/bRIwETHbY+NFeTu5/inmdAaf7s6koXAQ/v0Y2YYV4SG8VG6PZ6LppWB6w5ddKY
         WX6+YfbzcJmwnyBNtYGpLSjVo44ke4ghrVQKDZZ9lB4RrAfPw2lI7ynpynVXbcAD3ZjM
         zQSeg4dMBPccHbqwHI/6OEzMcevwll82AWcVpl4QTtmjvULXqMIy3SV3ei5fKZL2ivW+
         YoxqDMz6EMpMHHr7quFsNwetNW5lyQFB4ZVrabN7ogIzC6I0oe6n+pnj9oVoI4CpL0eC
         uC47PlhH69racAWGFj8ogs+HEUM/7jTsfjHolFQaklaqSeVfYEdWvvAdTMOt3w/K+mux
         K1RQ==
X-Gm-Message-State: AOJu0Yxf1lkuoAZZ8IfW9/bfuBmiAbzVqJXziFBNQI4/aC6g8j8nq68P
	onprHJQpmv7J6vgxnG8DYRMUxN8gUZqkMG0taog=
X-Google-Smtp-Source: AGHT+IH2AaH6n80iEZ+QwdWC6xihpoOiv4ps2Jm+yyQE5NzmhytsqLldrZ2tFMJWbBrOiC0C4oywe8eL61aFBGhTl0k=
X-Received: by 2002:a05:6a20:8418:b0:199:aeaf:cd3b with SMTP id
 c24-20020a056a20841800b00199aeafcd3bmr4230377pzd.42.1705442040272; Tue, 16
 Jan 2024 13:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111232923.8138-1-ilkka@os.amperecomputing.com> <2c9f5893-450c-012b-b748-a8fe8ddfae86@arm.com>
In-Reply-To: <2c9f5893-450c-012b-b748-a8fe8ddfae86@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 16 Jan 2024 13:53:49 -0800
Message-ID: <CAM9d7ch5b9XHzQ-Hb=kPu-6jLyESWqgizz6MRNWb0d-NnK9aqg@mail.gmail.com>
Subject: Re: [PATCH] perf data convert: Fix segfault when converting to json
 on arm64
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jan 12, 2024 at 3:35=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 11/01/2024 23:29, Ilkka Koskinen wrote:
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
> >  tools/perf/util/data-convert-json.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data=
-convert-json.c
> > index 5bb3c2ba95ca..5d6de1cef546 100644
> > --- a/tools/perf/util/data-convert-json.c
> > +++ b/tools/perf/util/data-convert-json.c
> > @@ -97,6 +97,11 @@ static void output_json_format(FILE *out, bool comma=
, int depth, const char *for
> >  static void output_json_key_string(FILE *out, bool comma, int depth,
> >               const char *key, const char *value)
> >  {
> > +     if (!value) {
> > +             pr_info("No value set for key %s\n", key);
> > +             return;
> > +     }
> > +
> >       output_json_delimiters(out, comma, depth);
> >       output_json_string(out, key);
> >       fputs(": ", out);
>
>
> It looks like this would hide new errors on any of the other fields that
> output_json_key_string() is called on. Maybe it would be better to only
> wrap the call to output cpu_desc with the if? If that's the only one
> that we think is optional, and even better only do it for arm64.
>
> I mention this because the test for 'perf data convert' only checks for
> valid json syntax, but not any fields. So we might want to avoid others
> going missing.

Makes sense.  Ilkka, can you send v2 with this?

Thanks,
Namhyung

