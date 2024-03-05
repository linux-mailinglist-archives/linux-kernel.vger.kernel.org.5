Return-Path: <linux-kernel+bounces-92366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE4871F23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C03A1F21FCB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C865B5A3;
	Tue,  5 Mar 2024 12:26:02 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501855B053;
	Tue,  5 Mar 2024 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641561; cv=none; b=oXTx7SivqZHRL7KJT13Sy0KN2fO9p9GLh7XYVmT8UvLVYcIZRu6kvCoDY+DF/xXIRXsOXDzn3PQ3QHD0zDWzZY6lbUEgk8aIk6TYs2vNEOLQmYxxyKQLazz1iFDa2N+AUBSBAo8OR9mmQsPKN5rRJcgxsshTSVUbYKO1VSdLviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641561; c=relaxed/simple;
	bh=r9yzeQ1USF9QiKB2zh8B9hSiTL8C5a3FM3pSiSj1CZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gm6x2YjCuOds/u+mnBe/A9JmBJnovhaoG4ejZORaNYK4br9nbhIBCw70lBarf4LGChPRojQIKhinty8UzVxjkOIA4NVKfIdWGCBCe/7nHupbdjXUs2TOSuZ+6PbY4VX0klv/6ycjQbQrswEzjNk0LAs0V0qs9Hn8+0kOJMQ3gnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21f10aae252so471320fac.0;
        Tue, 05 Mar 2024 04:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641559; x=1710246359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1ex7KlGqEzuj1DMQ9WhCdaRqB3PF9Cp1RLgsDYAOWc=;
        b=JwGIKVAd/+ApRA9P29dEaNRymKxdG6ccWkkJFiNDOB5/WpaQMJfevJs7Lwp2+xr43Y
         k/64NXL7cXWN28rI5aaTNzWwx3zg+pEt1Wdq6ylVkPkQ/m6BN/jd/aajtashMbS38Fxu
         6uYJqgZVeiWt0PRT4XGE8+SY2WPw7s64R33FqMmFSWimvh4qQlzAR5giITHqlydInlgf
         Z7+UsH2f1T7M4azt0EB/YR3QOFL0JZNtGe3994S6wUrD2l8o79CXV8v/hrTuys1eEA9c
         KXarxU36m+iauV6SNlYavEu6DIGNSzjZqtiK2/rmxfs9pxtLJNzM28qjjsPrjSkhmYQh
         U6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu28yhVrYYQTP5GkWqYqdCDvyNLCbLICjkWkw6pcHoO/9IDpRfLZP1+Zt3CUVeHlTC61yBFCm8wbdA07zHlEXJMDLduNVlFRls9L7xSXMWTT2U58hsqcaiLUJDNHpnBZgcbP21KUQ=
X-Gm-Message-State: AOJu0YxwZw1df/CFIbWI2/G+jFEDGy9uB/C+gKhV0WD5MNDrGnwXDW9r
	1y6SNmUfQNr0y+XFpXxwbHvCEuXfW0T978YhuB9x6QJUG2b/wFWTN5kT6kHChOpA6u2pK2VgXOM
	s8u9cIxMiMx1Wp9pGe0y848D+zfM=
X-Google-Smtp-Source: AGHT+IHo6jW6k0S3DUQfUvUpe9zUXvuTpA56xV5/ZEgm1a3EKZdJJZ9qX9l5rv20RoOGU/w8kayiFC8d1MJ7vo5+HC8=
X-Received: by 2002:a05:6870:b507:b0:21f:cd7d:9904 with SMTP id
 v7-20020a056870b50700b0021fcd7d9904mr117969oap.4.1709641558407; Tue, 05 Mar
 2024 04:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707363758.git.perry.yuan@amd.com> <f6ace4124c45e523e984b4eeab3760b95a70b72d.1707363758.git.perry.yuan@amd.com>
 <ZcRs7Ki8dhxCfCM9@BLR-5CG11610CF.amd.com>
In-Reply-To: <ZcRs7Ki8dhxCfCM9@BLR-5CG11610CF.amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Mar 2024 13:25:47 +0100
Message-ID: <CAJZ5v0iqhvi7tkrLw7FnG2PQh8oXbn=XF7meHU06cbTQJ0=Gaw@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] ACPI: CPPC: enable AMD CPPC V2 support for family
 17h processors
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com, 
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com, 
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, 
	Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 6:56=E2=80=AFAM Gautham R. Shenoy <gautham.shenoy@am=
d.com> wrote:
>
> Hello Perry,
>
> On Thu, Feb 08, 2024 at 11:46:28AM +0800, Perry Yuan wrote:
> > As there are some AMD processors which only support CPPC V2 firmware an=
d
> > BIOS implementation, the amd_pstate driver will be failed to load when
> > system booting with below kernel warning message:
> >
> > [    0.477523] amd_pstate: the _CPC object is not present in SBIOS or A=
CPI disabled
> >
> > To make the amd_pstate driver can be loaded on those TR40 processors, i=
t
> > needs to match x86_model from 0x30 to 0x7F for family 17H.
> > With the change, the system can load amd_pstate driver as expected.
> >
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > Reported-by: Gino Badouri <badouri.g@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218171
> > Fixes: fbd74d1689 ("ACPI: CPPC: Fix enabling CPPC on AMD systems with s=
hared memory")
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > ---
> >  arch/x86/kernel/acpi/cppc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> > index 8d8752b44f11..ff8f25faca3d 100644
> > --- a/arch/x86/kernel/acpi/cppc.c
> > +++ b/arch/x86/kernel/acpi/cppc.c
> > @@ -20,7 +20,7 @@ bool cpc_supported_by_cpu(void)
> >                   (boot_cpu_data.x86_model >=3D 0x20 && boot_cpu_data.x=
86_model <=3D 0x2f)))
> >                       return true;
> >               else if (boot_cpu_data.x86 =3D=3D 0x17 &&
> > -                      boot_cpu_data.x86_model >=3D 0x70 && boot_cpu_da=
ta.x86_model <=3D 0x7f)
> > +                      boot_cpu_data.x86_model >=3D 0x30 && boot_cpu_da=
ta.x86_model <=3D 0x7f)
>
> This looks ok to me.
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Applied as 6.9 material, thanks!

However, I'm not sure what to do with the rest of the series.  It
doesn't appear to be ready yet as they are comments that need
addressing AFAICS.

