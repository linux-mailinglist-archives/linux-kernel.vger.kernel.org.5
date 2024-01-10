Return-Path: <linux-kernel+bounces-22560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7184C829FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E311F299CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C553A4D105;
	Wed, 10 Jan 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwcLq4B7"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38B495C1;
	Wed, 10 Jan 2024 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7cbdd011627so1396946241.3;
        Wed, 10 Jan 2024 09:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704908978; x=1705513778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mbg66VkY0QaqHXfFLrf8OY9TWNu6WuHTMrnzUC6iFeg=;
        b=WwcLq4B7VNSOWNxsN55dFkhkQ8LssyivmE5JboZzshpi9wYPEnZsRZ+oyRRoFAkxwZ
         oolTdvSeAq5moDT2pPAWEcSqyO5qFIASp0U81HpgYlGwGtxrxtnSfxLfprjVEANrdV0c
         m4IqzecXKLeCdUej5cNiCflLVWE+n9fWDFGtpla1mz80Zr19QGRUdXCvh2Snc84+BQax
         PJ3oA0PwrRmP1wfPz2L6XNhfJlD1LAWk6ZW8J3rv2/+OfDtgnJ2tsDAfqKL+aMxOZOqx
         1VwiR2zqvhojTf3Zrf7GIOuN6NvM3n0fqGsldelkdFeKRUcOSbSgHtOkULKRVvKojLz2
         Z8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704908978; x=1705513778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mbg66VkY0QaqHXfFLrf8OY9TWNu6WuHTMrnzUC6iFeg=;
        b=D3ATv21dvLjkU9Oq5J+O3JAn3yHlW6E0TXP5X/VcyyMOagGuKyW8jMtkyxunQDX9nH
         DRGkFrw9Ob4JVFX07TFQO/zPoqyatAsOGvDDhznx2PTRsK8epBeQajtR3CeQnb7Y8K6P
         51yTAb1vQkmkCHz6RSgPg1QoQ2RaIwCUeFX2WLpB88YICSjfOcZfmYYJqR79jcaALR0A
         y2pu7NGfldOYHxD8mF9Qhx6KJ3EtmZxH+1CsViODIABue3WRLbxQ7NPt/wZq1xWuM4K/
         qBRAqPl7YohTyLUATTLiMDDEoOnSPxsftrGGPBzp4uxxli2mtdlMtKXxg2rQNIbKv0ae
         BKZA==
X-Gm-Message-State: AOJu0YyR7s2DABs5WR2EHVSel5El4PVBEADw21jUeaq1jvKBf3Gwxfe7
	pBIGNYO09mWg+nkeieoI7Ogc02SCPP2gM54qJDA=
X-Google-Smtp-Source: AGHT+IH2pgxFIe+QWYX2kQmv5eZIAAusM2D6KOHmIwu3nJbu0apRAEUDAwepio0oV6hGCinhyNkFetDvS4X0Cp/ERBI=
X-Received: by 2002:a05:6122:4b88:b0:4b7:51e6:1276 with SMTP id
 fd8-20020a0561224b8800b004b751e61276mr927278vkb.16.1704908978270; Wed, 10 Jan
 2024 09:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109175844.448006-1-e.velu@criteo.com> <CAJZ5v0ipYQURmFGGwmS5oyOuAOFDbG7TaaaWg4Ze-7PpBnSwkQ@mail.gmail.com>
 <ZZ7RnYy1xINapcSC@amd.com>
In-Reply-To: <ZZ7RnYy1xINapcSC@amd.com>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Wed, 10 Jan 2024 18:49:27 +0100
Message-ID: <CAL2Jzuzq-HVnhGZ8W0bSH6xibpYWXdXc30kC1Ub4vESfc4w7xA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq/amd-pstate: Adding Zen4 support in introduction
To: Huang Rui <ray.huang@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Erwan Velu <e.velu@criteo.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> How about modifying here as "partial Zen2, Zen3, and future processors"?
And all processors starting Zen4 ?

Le mer. 10 janv. 2024 =C3=A0 18:19, Huang Rui <ray.huang@amd.com> a =C3=A9c=
rit :
>
> On Wed, Jan 10, 2024 at 10:21:20PM +0800, Rafael J. Wysocki wrote:
> > On Tue, Jan 9, 2024 at 6:58=E2=80=AFPM Erwan Velu <erwanaliasr1@gmail.c=
om> wrote:
> > >
> > > amd-pstate is implemented on Zen4, adding this architecture in the
> > > introduction.
> > >
> > > Signed-off-by: Erwan Velu <e.velu@criteo.com>
> > > ---
> > >  drivers/cpufreq/amd-pstate.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstat=
e.c
> > > index 1f6186475715..9a8d083f6ba5 100644
> > > --- a/drivers/cpufreq/amd-pstate.c
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -14,7 +14,7 @@
> > >   * communicate the performance hints to hardware.
> > >   *
> > >   * AMD P-State is supported on recent AMD Zen base CPU series includ=
e some of
> > > - * Zen2 and Zen3 processors. _CPC needs to be present in the ACPI ta=
bles of AMD
> > > + * Zen2, Zen3 and Zen4 processors. _CPC needs to be present in the A=
CPI tables of AMD
> >
> > IMO, it would be really nice to avoid extending this line so much, but
> > this is up to the AMD people.
>
> Agree. Actually, we will use this driver for all future AMD CPU generatio=
ns
> that starts from paritial Zen2.
>
> >
> > Also, while you are at it, "include" in the first sentence should be
> > "including" and a new paragraph after "processors." would make this
> > comment easier to follow from the logical standpoint, because the
> > first sentence is about the supported platforms and the second one is
> > about additional requirements (ie. something else).
> >
>
> How about modifying here as "partial Zen2, Zen3, and future processors"?
>
> Thanks,
> Ray
>
> > >   * P-State supported system. And there are two types of hardware imp=
lementations
> > >   * for AMD P-State: 1) Full MSR Solution and 2) Shared Memory Soluti=
on.
> > >   * X86_FEATURE_CPPC CPU feature flag is used to distinguish the diff=
erent types.
> > > --

