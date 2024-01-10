Return-Path: <linux-kernel+bounces-22498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32806829EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DD31F27318
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F44CDF0;
	Wed, 10 Jan 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nS/ZPVYt"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA34CDE9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e36375f91so2894e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704904170; x=1705508970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYd13Zejpu03Q/f4ErgpB8c40cbt6HWQmYbgmsVrrrI=;
        b=nS/ZPVYt/WFSBZS4JpFk2hobSuBW7l1mICI6a60EsxEqD8KcPpdA3RJ+dpwYytoDUZ
         3nFVHGCbD3ryL9iGFESC8U4Ukx6hscao6wCvfllN0xgG4MB/TZ8vPbnTxsS+HJKtuf8E
         aKVuuq3Faw4YfWCMAmpFLburaqKN8r2up6bHgxa/he9wZKz84bBCHMfRFFVvvWlIru/D
         3FArvcuUVC8xWGFHcSei8PMAx70JOiNWjQHTO6tSEIfIXbMoCwDyrEk5v7iVzC9rCpYK
         9wDrPJDesDSttlAvs8U/SK9xc8cGLfmJkmodLgpXXbVeSRSpyMw6YnsK+IZe4KbeYvIy
         jkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704904170; x=1705508970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYd13Zejpu03Q/f4ErgpB8c40cbt6HWQmYbgmsVrrrI=;
        b=t+NGkWgCatluJkWkWqbJnPgohWREJDT1D/iG9fgODydaEYHxFz345xJmS/lq8EWNjY
         DGE7yr9Lwawlpb1a6WW8ekVktUglEB6xy2HXIVDGBPiyHXpT34PtyzWEI3Mah/9f1pm1
         sWbr0fbolui06ag1yK7UdBPmqq+t2I2EkmR7iPZ9UPUAz9Gm4crGbAKXH/lKBKVQHcbn
         Sz4GfB3AELHtO/4+ncUeizwPzS7IXWDZs60KKUmTjIbtuD56uxF+7SyGfyibnXUY1S+w
         khIh79PbOSPq3nxAXZEVR6DpGn9K09Us/TqWaFeLELN/p6e/PWILqv3QiYhsIJ1xBPUs
         hxSQ==
X-Gm-Message-State: AOJu0Yw4Z2oLci9dfVDO4mh8sJZJke+yRqeJIEcObmxWcEJz7kHFvuUP
	JbzlB6BsBtU/I0w4MKjego9x3vNzrwIV/54retyqNAZ5n0PW
X-Google-Smtp-Source: AGHT+IF5vM4N157aKb2AtB6x57aJsQ++ajAOqzDCXdw5TMmo4troBe/GusuB30ksORNAUtvkL8aYJotylri36ah/+bs=
X-Received: by 2002:a05:6512:2205:b0:50e:d1f8:461d with SMTP id
 h5-20020a056512220500b0050ed1f8461dmr44339lfu.4.1704904169658; Wed, 10 Jan
 2024 08:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZYbm5L7tw7bdpDpE@kernel.org> <4d86f3b6-eaee-4673-bdf5-3b97c1c1ad17@linux.intel.com>
 <CAP-5=fUfJ-VBGS1D2+WM_eBu4uPGvxJ2KyD4WXzgKRCfGKHTQQ@mail.gmail.com>
 <ZZfwjG-HL5yOEh6z@FVFF77S0Q05N> <CAP-5=fUK+t1p0g3dKtgyP0g3oixM1G7Xm4BFneY5EMzRW_urdw@mail.gmail.com>
 <ZZ12PhUfA_wPAaRR@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZZ12PhUfA_wPAaRR@FVFF77S0Q05N.cambridge.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jan 2024 08:29:18 -0800
Message-ID: <CAP-5=fWCn88KchSdQg87FRY0cpH4tVqO0UEYMhE=ioANeRBdwg@mail.gmail.com>
Subject: Re: perf test hybrid failing on 14700K
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 8:37=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Fri, Jan 05, 2024 at 09:21:21AM -0800, Ian Rogers wrote:
> > While much has been done in the perf tool to work around latent issues
> > with ARM's PMU drivers and the behavior changes they have instigated,
> > except for 5c816728651a ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE
> > capability") where I wrote the original version, there doesn't seem to
> > have been progress made on the ARM PMU driver nor on ARM testing -
> > which was why such an issue could exist for so long, across numerous
> > Linux releases and ultimately break Hector and Martin.
>
> Ian, which latent issues in the PMU drivers are you referring to?

Core PMUs generally have a lookup from legacy to non-legacy event,
from the past discussion this was missing on the problematic PMUs
hence the sysfs versions.

> I already pointed out that one of the problems you have claimed to be a d=
river
> bug is actually due to userspace incorrectly detecting support for the ex=
tended
> HW type, and I suggested some options which you have so far ignored:
>
>   https://lore.kernel.org/lkml/ZV-CUlQhlkdOzfFZ@FVFF77S0Q05N.cambridge.ar=
m.com/
>   https://lore.kernel.org/lkml/ZV-ItX1eMeIdo_00@FVFF77S0Q05N.cambridge.ar=
m.com/

Those suggestions look fine but you seemed to be suggesting testing.
Lacking hardware with the broken PMU(s) I'm not able to do this. Could
you turn the suggestion into a patch and test on BIG.little? I can
test on Intel Alderlake.

Thanks,
Ian

> I agree that testing is a problem, and we need to do better from the arm =
side.
>
> Thanks,
> Mark.

