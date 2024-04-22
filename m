Return-Path: <linux-kernel+bounces-153975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8584E8AD57C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D3EB24683
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD97155722;
	Mon, 22 Apr 2024 20:02:17 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266271553B8;
	Mon, 22 Apr 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816137; cv=none; b=P+IPnDUWWVsdlOq30MqvXQy31p7yMiB0cPNQbP53yoV1aGluSkhaO9i8owDz58JwKe++UIXWN10WO1+SPVCyejCsEQ5z5FDSE7QiI1ZijNrCic/Fs5NP+XL7/tvIgbece2+sWt277I7zsAQESZyAIovLHREqQZryJOilxXbYfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816137; c=relaxed/simple;
	bh=kyPGFrRjogg7eballx/psAJp/i0GSsb1eEhvh4VJrCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jykpOEAxS+CEis6Zfk1ngJNVGek7I9liI0m/LwE0+KNfnZ2OHuRubrmDLK5c6Ma1hYP8NGAuJywaH9G5tUPzHAzEgwxcidI8kMm2Wh428+KUDiX2hxyCgpJFLWldtFp16PwI9WpsRaSqutZHplAzGKO2rHOqYrONHiYRPBmA4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so3144650a91.3;
        Mon, 22 Apr 2024 13:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816135; x=1714420935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJ75A/8OgSdYaiyjnSCmItzI6PsJdpDOfLZO1MOPoYU=;
        b=d65JgKJzbo19p0HPeYAfJNHALO7gcnhlCetPQvUMzatIw326wgPAYPKWsavwJbu707
         Qamb4y1MocHo/S2Yr9pnLFTkfg77L+mberTs4YuLS9onDWIE9HcgYJfy9VWXr8PaNit4
         3lZlJzynLoiXUpjpT5d6Jb/ad5RdgR1qF5p8sgXy2m5+NwxtqeIfpTr4ywXS54Lc5mQO
         mc35NhUpqjHsnao8OxNL1Vt4UdiES7CegMW2e+IDiiy6rtZHIVkUnV7NTFQWm3yZugKu
         DosacvsdgBJswriE53Swupb4Y/Xa30BMoqw8/cwgHSncUAgY17QzScRIxexeGhyXwBt4
         SXOA==
X-Forwarded-Encrypted: i=1; AJvYcCXx0hue7sqQ7fTLb5aYfNdSRBMeGi67Pl5KmYoHnjqW/M6B28tQIOdQfE5ZqVFeyO8GSISILy9s5FCa6k4GUSuKJJOCo2PANicoXBFNInVbjMXAmfhbLaQANHiCw4j9nNATZlfkMLSRQ2LH5nNSBQ==
X-Gm-Message-State: AOJu0YxEaOnludd3SB2Q6A2YjOvTjSo2On4uHZ5dXtCfaP1KwlnIr+ZI
	pn/6EojBoa3+Rra/QGOh8xBroyvLiwJmKEF4rRNMrusqSVmlOvPVf/08cxB9yM1PtovFW6mrP3i
	A3zSzsasm+qBlKrLHaAucxHPkoX8=
X-Google-Smtp-Source: AGHT+IFkhhcTygRUy6jT95qwF2UikiLCSDJAzMDTRrm38muiu30modTYEthg0Srg7IW0nAWhZEasHhtwpgISC1wz1Pc=
X-Received: by 2002:a17:90b:3781:b0:2ae:9138:6d8e with SMTP id
 mz1-20020a17090b378100b002ae91386d8emr517966pjb.16.1713816135335; Mon, 22 Apr
 2024 13:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402214436.1409476-1-weilin.wang@intel.com>
 <20240402214436.1409476-6-weilin.wang@intel.com> <CAM9d7ciKUYAdu97O3p5VRYGjXwvOv+4kgERXKM6mjr6OUbRQZA@mail.gmail.com>
In-Reply-To: <CAM9d7ciKUYAdu97O3p5VRYGjXwvOv+4kgERXKM6mjr6OUbRQZA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 22 Apr 2024 13:02:04 -0700
Message-ID: <CAM9d7cjUkGFfbdWSxzs5tkLHdctjux1jGV0P_J9YsGP3QmWNOw@mail.gmail.com>
Subject: Re: [RFC PATCH v7 5/6] perf stat: Add retire latency print functions
 to print out at the very end of print out
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 12:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Apr 2, 2024 at 2:46=E2=80=AFPM <weilin.wang@intel.com> wrote:
> >
> > From: Weilin Wang <weilin.wang@intel.com>
> >
> > Add print out functions so that users could read retire latency values.
> >
> > Example output:
> >
> >  Performance counter stats for 'system wide':
> >
> >             25,717      MEM_INST_RETIRED.SPLIT_STORES    #      2.2 %  =
tma_split_stores
> >         28,365,080      CPU_CLK_UNHALTED.THREAD
> >              24.00      MEM_INST_RETIRED.SPLIT_STORES:p  #       96    =
    4
> >
> >        2.054365083 seconds time elapsed
> >
> > This output of retire latency data is in format:
> >  <val> <event-name> # <sum> <count>.
>
> Nop, please follow the perf stat output format.  It'd be
>
>   <sum> <event-name> # ...
>
> Hmm.. maybe you don't need this at all as it'll have the event
> anyway (probably without the 'p' modifier like in the example
> above).
>
> Then I think you can just add a metric value saying the average
> latency in the comment area.
>
>   Performance counter stats for 'system wide':
>
>              25,717      MEM_INST_RETIRED.SPLIT_STORES    #      2.2 %
>  tma_split_stores
>                                                                      #
>      24.0  average latency

Sorry for the line wrapping.  They should be in the same line.

Thanks,
Namhyung

