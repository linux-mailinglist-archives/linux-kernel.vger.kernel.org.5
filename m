Return-Path: <linux-kernel+bounces-57038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0884D31D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11B3289C4F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20A676039;
	Wed,  7 Feb 2024 20:43:28 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11C1E525;
	Wed,  7 Feb 2024 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338608; cv=none; b=rOBYNyBKtzjDmmjjKatA+NG0t5LrhmFjWxJXUNUlS0BEpJ9Afep33x7h0KK3TC+cAncXbzP8wKarEvUNC1SQccc8DX5ejmCotYTuGpuRT2MlpYWLpn3aR1EGD4pEl8Uob9KfNFLkQ6NfSPbkhZfkqYQWFQgVo8qQDcyMcr8WLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338608; c=relaxed/simple;
	bh=BJhZkmvW+KdW+0d3wfZKlhM8nJh15CtP3k9ZXOVshc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2fzK7SjpitWfTNCqtR6sD1TANvIU04JLRIY35LdeOep3G+HdpX8DWjL+JK9BXLI+n3zZgdx45/nmel3G1yhYV31yTUH4yZ5oBey0OISpOU3HiyhvoGmWufc8wxMtRGlS66JNbtAFW+q0RQUSnL1vGoxLyv4u5MiOrLYKPLARu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e04fd5e05aso193080b3a.0;
        Wed, 07 Feb 2024 12:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707338606; x=1707943406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SR135J3otmhqAafGVl5D5NnoHYrYuXrRvaKntsyJrCo=;
        b=qzTX7wG9l6+6h6wMmO0vP72hp7XD9e8BbXp/+hACiDUyvGKq2xPRk3OrChwYkF79pm
         eTRRz1D2bXxtHJcgk27P+TU1HdBIdK3kcmNaMqh61rKlqGpZbfLgao2cLtEhuAtO1zcd
         0BGBr2twZxLOiT73334GMaVYUHqw5MN6jVYC+h8PiTwK49zbUCbHHNydF+5ZuU+8Qv1T
         QK62S0SRaOIrgEw4rDUW1kyubwSTiNy5e1tl4F8l7cUH3tTrjpui9DkSNHW+HEdbSHtX
         36BRt4+LlE/PM2oFzjKHuZ8WtIyPVxw3ys1LjYsrd7XpYwUfQzif/LlXmnGSPPtigrXB
         dWEA==
X-Gm-Message-State: AOJu0Yy12MwjcfIxvMQbosdxe/Y8sqsp6w5DeQEdR5fNnLe1xmk2wV5N
	41Zft5lAZYTxYDFsGr3QuNSMoOpW4Xu8FYM+wp3YSjhebmNbbnslMpW653fyxgJ6rPqnNZpOZ1u
	XIvWJw6c6qa8PA/IMGG1zi4fVmdM=
X-Google-Smtp-Source: AGHT+IFsEQ8sL8b6AD2ekluF5dNoZslXaWTOENuuFGVg/RtxgS9TbXJSUOv0mF81cSKf5MAB/nR79Iw6aEwu578WE1w=
X-Received: by 2002:a05:6a00:1e17:b0:6da:bcea:4cd4 with SMTP id
 gx23-20020a056a001e1700b006dabcea4cd4mr849261pfb.16.1707338606117; Wed, 07
 Feb 2024 12:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-5-namhyung@kernel.org>
 <CAP-5=fU=P-ib+n+OfqJAbm8gS2RY-W-KcBskoSHkC+aCmXYcXQ@mail.gmail.com>
 <CAM9d7chvEw6r8_7agxOpWxufTo+dLaNForSFFShCFGd9KDBtoA@mail.gmail.com>
 <CAP-5=fWx9Uub9uRgQJq_ekQScm4fJXMdr9_cr19vcckCPjPt9w@mail.gmail.com>
 <CAM9d7ciGna7tm5gxoVAQexj_to9sRSL-emmCTSkMbGZgY8mthw@mail.gmail.com> <CAP-5=fXWew4c-0zAAny-1R+6mZpfATUc8pEi0G6G79BebiaPuA@mail.gmail.com>
In-Reply-To: <CAP-5=fXWew4c-0zAAny-1R+6mZpfATUc8pEi0G6G79BebiaPuA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 7 Feb 2024 12:43:14 -0800
Message-ID: <CAM9d7ciK5XVBCuaSmTPkqMGaK=rqA1xKpE8VOqZh9V_tYEb5pw@mail.gmail.com>
Subject: Re: [PATCH 04/14] perf map: Add map__objdump_2rip()
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 11:56=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Feb 7, 2024 at 11:04=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Tue, Feb 6, 2024 at 3:34=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > On Tue, Feb 6, 2024 at 3:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Fri, Feb 2, 2024 at 5:42=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > > >
> > > > > On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@ker=
nel.org> wrote:
> > > > > >
> > > > > > Sometimes we want to convert an address in objdump output to
> > > > > > map-relative address to match with a sample data.  Let's add
> > > > > > map__objdump_2rip() for that.
> > > > >
> > > > > Hi Namhyung,
> > > > >
> > > > > I think the naming can be better here. Aren't the objdump address=
es
> > > > > DSO relative offsets? Is the relative IP relative to the map or t=
he
> > > > > DSO?
> > > >
> > > > AFAIK the objdump addresses are DSO-relative and rip is to map.
> > > > They are mostly the same but sometimes different due to kASLR
> > > > for the kernel.
> > >
> > > Perhaps we need to use names like map_rip for mapping relative and
> > > dso_rip to clean this up, or to add a different mapping_type to the
> > > enum. For non-kernel maps addresses for map are either the whole
> > > virtual address space (identity) or relative to a dso:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/map.h?h=3Dperf-tools-next#n115
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/map.h?h=3Dperf-tools-next#n20
> > > The dso addresses should work for objdump so perhaps the kernel
> > > addresses need map__pgoff fixing?
> >
> > I'm not sure about the vDSO case.
> >
> > By the way, I need to take a look if we can make this objdump-rip
> > thing simpler as you mentioned.  My feeling is that it can be done
> > but I'd like to do it in a separate work and to move this forward.
>
> Makes sense. Could we add a comment to the header file definition to
> capture some of this? Perhaps a "to be removed" to avoid later patches
> adding dependencies to the function.

Sure, will add that in v6.

Thanks,
Namhyung

