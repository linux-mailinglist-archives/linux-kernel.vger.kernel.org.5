Return-Path: <linux-kernel+bounces-46616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F7F844207
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AFF1B29AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6881684A29;
	Wed, 31 Jan 2024 14:40:37 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E983CBD;
	Wed, 31 Jan 2024 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712037; cv=none; b=GFz+l9yxiQX2ia6TQTVSfXR+84wjyZGSI6BwLbJ3CwQciOlQPdcq2sguoJnz/MyjmdiDb6WUgSVjB10RYSCy5Fg2bopx2VVH5Xb6qjumsqGv1q5V5xovj89/vGKbkmBtUz9Uwjk88A75cNFb/nC/EMHnPjgz97XKo6w2xALjQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712037; c=relaxed/simple;
	bh=Fwcw2cPDAwIciG0BItTKZ36UPF98fOieRW1+rPpVaHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMoGnJiAn9i9zC99kC38D5fWlkK/WlsI31gY+OjS5PCJObob+E3ywHXw3P+nZ4IwJhlWn8AgM8d6moLZn9ZGyX+rxg2emDTk2HMbrf0QC8KHycp7dp8tDfViXLwpW6xxarRSpA6ytVtYEBtBGlNpC36SpHb6Up3QMxJ5suslWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59a47232667so300247eaf.0;
        Wed, 31 Jan 2024 06:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712034; x=1707316834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BD3UVMmeNz9pMouS0MvbW77uq+ci4jcIYtk355EGXM=;
        b=qiav921kJYj8k24bm7MV1ZC9zXQEZ7Qvqb9KbCXazJdyrxm0BVHBvD/IaHjiNZXjqB
         lCzJgTvZ2VRhsW8/Cg+OIh+s1xEWA2I0HS7qmHkGR8J26Dm2mlnLrRFsAEveCBopCeHO
         57PimPKf0xYn+BhiOnXBIfWkgjenqzHZoOxz8S44FdrXRagF03w0zmzgZeviNyySpeKg
         AgMWGWA1oBt/+VP/u+4u5mWedsSe8iuJYjfpgvErkhCG46e8PcOFX9n7O6hMJcbajvRY
         kb5S4WTmeto+NOi3Vho3X4kQMdRMP4HYu/TR2+MXGkigq2xR7PsttA3www1WR23xhof6
         97TQ==
X-Forwarded-Encrypted: i=0; AJvYcCXFj9dqFC3kHckZOC110RXsC72rf3LjVdyywOtj5GKlo4/Dq/JfUSOg42kvfHIbHlPuDP8+8xi0sswzUgcxyC/gpm/YjFw1L49zQI5D0PjeyKNV8H/HA81vYy9uBPaAxTrxhklibq8=
X-Gm-Message-State: AOJu0YyS5Opaj0proWUA/wIWN9WMU+wFmH0nJKEHvjfbUeuCmlWOnTvs
	9jnQalmAtZBaVdPpB2wpBxysKL6rTP8CGLuPNNzcN6AyVrhCvdkVRvYygXqXlJdyZ+H5arp66Hj
	5RX3asNzR96p4zh2g62+SXcxr89M=
X-Google-Smtp-Source: AGHT+IG+qCpZkbzKO9zbzYQUuRwqYFxucZBrbVASTVX9qn1+oOJGU5ZauyR0kyZe8EDdiB2/9gBY6vpLIfvj0UWqOss=
X-Received: by 2002:a05:6820:139:b0:599:9e03:68da with SMTP id
 i25-20020a056820013900b005999e0368damr1733131ood.0.1706712034521; Wed, 31 Jan
 2024 06:40:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131142335.84218-1-rui.zhang@intel.com>
In-Reply-To: <20240131142335.84218-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jan 2024 15:40:23 +0100
Message-ID: <CAJZ5v0ioEx7xSagqeuByqTqefgenZnccrXX1nGBJib72O2qjJA@mail.gmail.com>
Subject: Re: [PATCH 0/5] intel_rapl & perf rapl: combine PMU support
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, peterz@infradead.org, mingo@redhat.com, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:24=E2=80=AFPM Zhang Rui <rui.zhang@intel.com> wro=
te:
>
> This patch series is made based on the patch series posted at
> https://lore.kernel.org/all/20240131113713.74779-1-rui.zhang@intel.com/
>
> Problem statement
> -----------------
> MSR RAPL powercap sysfs is done in drivers/powercap/intel_rapl_msr.c.
> MSR RAPL PMU is done in arch/x86/events/rapl.c.
>
> They maintain two separate CPU model lists, describing the same feature
> available on the same set of hardware. This increases unnecessary
> maintenance burden a lot.
>
> Now we need to introduce TPMI RAPL PMU support, which again shares most
> of the logic with MSR RAPL PMU.
>
> Solution
> --------
> Introducing PMU support as part of RAPL framework and remove current MSR
> RAPL PMU code.
>
> The idea is that, if a RAPL Package device is registered to RAPL
> framework, and is ready for energy reporting and control via powercap
> sysfs, then it is also ready for PMU.
>
> So introducing PMU support in RAPL framework that works for all
> registered RAPL Package devices. With this, we can remove current MSR
> RAPL PMU completely.
>
> Given that MSR RAPL and TPMI RAPL driver won't funtion on the same
> platform, the new RAPL PMU can be fully compatible with current MSR RAPL
> PMU, including using the same PMU name and events name/id/unit/scale.
>
> For example, on platforms use either MSR or TPMI, use the same command
>  perf stat -e power/energy-pkg/ -e power/energy-ram/ -e power/energy-core=
s/ FOO
> to get the energy consumption when the events are in "perf list" output.
>
> Notes
> -----
> There are indeed some functional changes introduced, due to the
> divergency between the two CPU model lists. This includes,
> 1. Fix BROADWELL_D in intel_rapl driver to use fixed Dram domain energy
>    unit.
> 2. Enable PMU for some Intel platforms, which were missing in
>    arch/x86/events/rapl.c. This includes
>         ICELAKE_NNPI
>         ROCKETLAKE
>         LUNARLAKE_M
>         LAKEFIELD
>         ATOM_SILVERMONT
>         ATOM_SILVERMONT_MID
>         ATOM_AIRMONT
>         ATOM_AIRMONT_MID
>         ATOM_TREMONT
>         ATOM_TREMONT_D
>         ATOM_TREMONT_L
> 3. Change the logic for enumerating AMD/HYGON platforms
>    Previously, it was
>         X86_MATCH_FEATURE(X86_FEATURE_RAPL,             &model_amd_hygon)
>    And now it is
>         X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd)
>         X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd)
>         X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd)
>
> Any comments/concerns are welcome.

Say the first patch in the series is applied and the last one is not.
Will anything break?

Regardless of the above. if any existing code is moved unmodified by
this series to a new location, it would be nice to be able to see that
in the patches.  Otherwise, some subtle differences may be missed.

