Return-Path: <linux-kernel+bounces-167059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE978BA3F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62171282BA9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF4520322;
	Thu,  2 May 2024 23:28:13 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2CF1CAA1;
	Thu,  2 May 2024 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692493; cv=none; b=OKqubrttKE6xz/TW5otNEwxuCZ0n6CAhJy8yYc5pUBwNDXwyVIJCymhXLryUmQYl3rMZvhKKOnuz1oyD0B+wd5fhi7MV5JMZ3oq+2hfmtybqYH07TRA/gBuA/2qog5C+68E4PAc2+zkutIiRmYjKOr8ArsLccyfqp9Ng6NTf2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692493; c=relaxed/simple;
	bh=b6o52TjdzdCt4jSSKwghb4/NyW7Kt0gS4Op5y8cytcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dugvBm9HegTD1eOr+2GcN3W4iU7YUZKWR+jPDZvqE7HHTNDHUX/45NwA7GtdtDevXSuLNYLVHe4Uh0/m4m8oi/nTtzLv3UdgWrLdl/3VGzUrCwao6fNrcwMazjLYeamPAPLAsDUbw4lj9ykIk/0pH3Kd8poMa3pxJl/0kcROdQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b43490e0e2so147894a91.2;
        Thu, 02 May 2024 16:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692491; x=1715297291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPejxyFKU1Zh3kN9Scg088bpLLbAnsYPfIC5g4m7D1E=;
        b=Ep11gXlMojryXhsHIteQC9ZFW8BgNCeZ+Q3LMydryKQkCx9jY5COasOp61q6weITpe
         yddrP0lSR4bDv5w64y4QUJNXtSiZ3Lb7FhMU1kmk5uLVBI6Vpuqqgiv24rHHt7k6sO6q
         WY2qOKgI2UbimkSLaQl/KEuB7sSWYFqgM/CBqds8P40Z0F4oYibM+tZtpuYn8Mlb2VZ0
         3BV/cqXB53cdhMp7NKeakJkO3veBNY8Z5sclpmZEzi9oBccAVoha1QKjr2Ryu6sDyA9v
         EdfGxTtX/SmZUza4f+1eEyV6OgSO8jnpmqjngpRMAbzDZkIQImsPs2rvVycikWD1giuT
         J6vA==
X-Forwarded-Encrypted: i=1; AJvYcCW0KZ+BXR2aCNI56gzaVAj2oNC8DHq6XMmZVq1sk6rTXUlTbDWtaCLnz5SPysgGZGvhBS1crR02/7QMEeg/8ZPc4XMZX0KF/7Six1IyfoGzK1JQUAdkWf7yql9dR/zwWkT5yYYJHsAIK+VNW15ifg==
X-Gm-Message-State: AOJu0YyY44FIpUSgZs52LLci6awqp5cS6IisDMdAs4Nz7M2QHGR4GKyS
	fVK2lIHBwI6DWg1E8hzMs2JaDzN7PlWMPdy016hAOeWyGcdcVwkVGm62tOwOcQsPfjZI2ivDfw6
	RNwDS0DQWhHL1VutHUk4LXx3GRW4=
X-Google-Smtp-Source: AGHT+IGCfFayYnMJu50+R6ypYEmLWC90DGrdLB1SJVicZ0gOaO0Ww9JBcpPMRwWuybiMLiWOpNVphhDBzI5/UlBk9GA=
X-Received: by 2002:a17:90a:ea08:b0:2ae:7f27:82cd with SMTP id
 w8-20020a17090aea0800b002ae7f2782cdmr1274067pjy.7.1714692491345; Thu, 02 May
 2024 16:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502060011.1838090-1-namhyung@kernel.org> <20240502060011.1838090-3-namhyung@kernel.org>
 <ZjOaFS7_vEojFnUZ@x1> <CAM9d7chGYy9X=3=iRwocUWJurXPGd0WZaE=yr8U1JkrLcaUrow@mail.gmail.com>
In-Reply-To: <CAM9d7chGYy9X=3=iRwocUWJurXPGd0WZaE=yr8U1JkrLcaUrow@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 2 May 2024 16:28:00 -0700
Message-ID: <CAM9d7cgQn48sq-mF42sqSAkUeO_n=a7Jcs+J1zV+YzCuGLj7uQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf annotate-data: Collect global variables in advance
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 11:23=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, May 2, 2024 at 6:50=E2=80=AFAM Arnaldo Carvalho de Melo <acme@ker=
nel.org> wrote:
> >
> > On Wed, May 01, 2024 at 11:00:07PM -0700, Namhyung Kim wrote:
> > > Currently it looks up global variables from the current CU using addr=
ess
> > > and name.  But it sometimes fails to find a variable as the variable =
can
> > > come from a different CU - but it's still strange it failed to find a
> > > declaration for some reason.
> > >
> > > Anyway, it can collect all global variables from all CU once and then
> > > lookup them later on.  This slightly improves the success rate of my
> > > test data set.
> >
> > It would be interesting you could provide examples from your test data
> > set, i.e. after this patch these extra global variables were considered
> > in the test results, with some tool output, etc.

Here's the example:

Before
-----------------------------------------------------------
find data type for 0x6014(PC) at entry_SYSCALL_64+0x7
CU for arch/x86/entry/entry_64.S (die:0x85e1d)
no variable found

After
-----------------------------------------------------------
find data type for 0x6014(PC) at entry_SYSCALL_64+0x7
CU for arch/x86/entry/entry_64.S (die:0x85e1d)
found by addr=3D0x6014 type_offset=3D0x14
 type=3D'struct tss_struct' size=3D0x5000 (die:0x74dbe1)

It was asm code so it doesn't have the type info in the CU.
With this change it can see the type (from a different CU).
It seems we have a per-cpu variable called cpu_tss_rw at
address 0x6000.

  $ nm vmlinux | grep 6000 | grep tss
  0000000000006000 D cpu_tss_rw

Thanks,
Namhyung

