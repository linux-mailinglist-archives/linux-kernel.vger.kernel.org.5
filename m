Return-Path: <linux-kernel+bounces-105582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDE987E104
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291991F216BD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E482110E;
	Sun, 17 Mar 2024 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVPAOFIf"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F41C6A4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710716676; cv=none; b=ZGOiX7Hi8OouQ8l2NBu4WPSHwsrLxFxdj2faqUINywr7akhRGiXkOo/U1CB8VuU2poRoQQMz8LXZ3S18TPDxvBuUtj9YJduAGmF6tDiZHjWvJ/Snsbdsn7YfB3x6hBkyQKT69LOEE+mqNs+BmumTQ+ToM7c6OsW/DHlmCQuWVGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710716676; c=relaxed/simple;
	bh=LB0YO0X/yOcoXq3yRv6871lkEZDmBv+ZFncU5kniCcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wv5CJpvh4Z4BnWFzxpqTSU13B2BX8+5kYddm33BVyQMaGAsfkNKLQrnJ8xvgBJIFgnORHGZG/Wg9aV7cTRTPTGdKLSvqBBrl+rk+39lLYNSZQp9Tr+RP1DiBfSisYQPLNkk5yjv6P8pFmQbLBhOQ9YFPlC3xooKhIX5m0VfpN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVPAOFIf; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42ee0c326e8so292211cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710716674; x=1711321474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LB0YO0X/yOcoXq3yRv6871lkEZDmBv+ZFncU5kniCcY=;
        b=WVPAOFIfY0qAAVoh+akvzIcftsuHRi8AmufzmRv1dk0Wcve3Hn1TYxUBn23po2rKJ+
         V1pJayHM9UQ0m5a871UQp9RuszHm3v8/ruN5IV4QtYgYTdaNxM0pbYRShTvkhCjmXHR4
         JJdbxboDeXDrTMXsqZw6e35x5b38VJhkTJeu4ejjxm5aKfCiZn59a/2otL4wlX/aEBpZ
         ru0DYl15vDasO18Um0oLpPiEqxJWVacoi9x0xeWxuCM+DQefIQId97ti2TZ7I10zJsVQ
         t4/wrlzL7thpADCbQfBbrK1jqkH/gMiOyVOeX10QVxOk1PcD3CyvwW4xejQW85wSFEqS
         H1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710716674; x=1711321474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LB0YO0X/yOcoXq3yRv6871lkEZDmBv+ZFncU5kniCcY=;
        b=JghSIfsXkAmU1s2FMgYFWC4IMwVwoGAnyrmK4n7T/SSH1oi4riDXHQ0AUQtFwudRCB
         aGdhYHI8C5nw8B2I4FoK+Ap05GUqqTiRaZxsdbZqZA+xXdNYwy+namN0I72JNVYYSE2i
         5TsJZJsTIEHagBqz4vECCn2/3aKK6j6Cxl+Q3apivbKtuQJcH/32FRmUVyveDtKIBaL6
         8YH/t4GxKQ6KeJ0fiVoPFhXc4CmDSq/BZ8YqxXnGOLL4SR6Cf91dwK0bi6sHWc5/AP12
         zoFKH7TnrAQ3cAf3YgsDEMS+BtCUOhqAgf3+PD46h/1n0iry55ixeP9aK5qz+oRAleZG
         oS2w==
X-Forwarded-Encrypted: i=1; AJvYcCWzy6+6DJu1Omgu5ybh+4QSpRbZLJcCKJNAHvqjkfPKGPNazM8FFAXjuI06T3wYlRnr8k+XMK3mpblqDPmOMtgqHHWRRTarSrobhYjx
X-Gm-Message-State: AOJu0YxkOS4JE/444cJOaeU5JEat0D/ByyJ0zhL3/DK2MwsU4a0shWdB
	E03AqIS3Bcf3U4th6/oHMQVUQdGO1jYUOevi5qt+qXxbLfwAk3L1Hm2HBMulauYZMY1FIcuYS0h
	ulaLXZXleNoK03m36zR08q9NCAXzeYvxF8hJe
X-Google-Smtp-Source: AGHT+IHfOFGX12eG65qMH0GVp5YVkBWChy6kpSDAoM8jVO5ICeAeZkqiAhAPui4UliLKhEzJP8O59+3whIQ7Lf86oWI=
X-Received: by 2002:a05:622a:11c4:b0:430:d767:e9ac with SMTP id
 n4-20020a05622a11c400b00430d767e9acmr3628qtk.27.1710716673946; Sun, 17 Mar
 2024 16:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226201517.3540187-1-irogers@google.com> <0b2ff06f-099c-424a-97b5-fdf638892e41@linux.intel.com>
 <CAP-5=fVTOgOO=N7uf4CaANWu+WCCLXXMuNBnDdBOP3E6vijG_A@mail.gmail.com>
 <2b950564-fe20-4426-ac91-5b40a2087099@linux.intel.com> <CAP-5=fURvd4nx_-QLgRBWSoJbXDUqO=WbsLkqMgjiyucXHVrjw@mail.gmail.com>
 <ZfSvwBQRBhfWGb98@x1>
In-Reply-To: <ZfSvwBQRBhfWGb98@x1>
From: Ian Rogers <irogers@google.com>
Date: Sun, 17 Mar 2024 16:04:17 -0700
Message-ID: <CAP-5=fUxw21-1SXBbaPoGgvZv98E5k+V6KGM41e=8XTFhyQohA@mail.gmail.com>
Subject: Re: [PATCH v1] perf vendor events intel: Add umasks to PCU events.
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 1:29=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Feb 28, 2024 at 08:12:10AM -0800, Ian Rogers wrote:
> > On Wed, Feb 28, 2024 at 6:55=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> > > On 2024-02-27 9:12 p.m., Ian Rogers wrote:
> > > > Kan, what's the right way to deal with this?
> > >
> > > There is no umask in the uncore spec. Please see P120 of the spec.
> > > https://www.intel.com/content/www/us/en/develop/download/intel-xeon-p=
rocessor-e5-2600-v2-product-family-uncore-performance-monitoring-reference.=
html
> > >
> > > It should be occ_sel.
> > > The occ_sel =3D (the umask from the event list >> 6) & 0x3.
> > >
> > > I don't think we want to change either the kernel or the perf tool.
> > > There is nothing to help either if we add the occ_sel in the original
> > > event list. So it seems the only choice should be handling it in the
> > > convertor tool.
> > >
> > > Is it possible to check the UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 in I=
VT
> > > and use "Filter": "occ_sel=3D0x1" to replace "UMask": "0x40"?
> > >
> > > It seems everything in the filter will directly be appended. Is my
> > > understanding correct?
> >
> > Yep. From the manual:
> > C0 =3D 1
> > C3 =3D 2
> > C6=3D 3
> > So I'll need to fix all 3 events during the conversion to perf json.
> > The same problem exists for haswell and broadwell, so I'll do the fix
> > on those architectures too. I was able to test on a jaketown but the
> > kernel source makes me think the same fix is necessary there too. I'll
> > send out a new patch with this.
>
> Please clarify if this remains reviewed and should be merged as-is.

v2. is already applied in perf-tools-next [1] so we don't need v1. Thanks,
Ian

[1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/?h=3Dperf-tools-next&id=3Ddd267d056fed323f1684fa52d2a864fc93ca3be0

> - Arnaldo
>

