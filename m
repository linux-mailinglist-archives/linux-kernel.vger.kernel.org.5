Return-Path: <linux-kernel+bounces-92013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD898719B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B2C282002
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B52653365;
	Tue,  5 Mar 2024 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9mOKvwJ"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C74CB58;
	Tue,  5 Mar 2024 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631333; cv=none; b=TApL6uLfpvA3CmSBb2HtsDa7LSuLSjg+32Galm1BFKXrGTftkkylZmeov16i30bOCGScis5IgxxMOhpCe13CZDgFNYiWKxwit2eHctYFw4Guyk1ZgSKUoh+hRydtArXNCAL38f4XEfbMZeBzybHBXBW0pBTPhLG2QT61YCZexkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631333; c=relaxed/simple;
	bh=DHgXuAEmDJyMyUFnpe8rDA1XSXtYVi585YlAo3AOdD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Utcg69XsrYeQy4Ig5IAGjcjVWvgfsGhfx9mo6A04qSHXfukdlpQU7kyjUmC+bmKqrMSeluMQnKJs2WNvwsxIRBSdud8WmMZjqA7VHwQwdb6eRzkJrgS1kYyzAe8MJWlvKHZgsxy6kj3/ffiD2VXsKjTL2EknpUzBpyFwSp0mgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9mOKvwJ; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21f2f813e3bso2844114fac.0;
        Tue, 05 Mar 2024 01:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709631330; x=1710236130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ+TMPfkrk6Rwx5VIdBp/wiudj0mwYz48jbgJ44a/7A=;
        b=B9mOKvwJjkoLmadCK3ld8dzdGoXC1Pof/iCQb9KuD3Ow90Of0sVX4J/RxXA/NqRLyY
         655zEiWe2Leh2bsZJBiZL/WR71hyDIbwgROwZVTiSPMB5vHQ/Xsscc8qlWmk4TWvvQ5h
         TznFrYfLJ1FoxaxiJA9HnJ2F7676rsofcegKXUM1vDhAcw3E2G0/pQZ2G8bceolDLRhj
         70qnHvaAE8wFA+NBSVZjAMfzr3zd4xc15I55VgjpU/UzlcIbf7yvKevCiremA9/XmxFF
         0aLOELLvIVB6aVka6tuYap15Z230fGlcHbf9ZHjO4/g74EBv8vkcaHjWwoBZYHGFGRvQ
         rr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709631330; x=1710236130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJ+TMPfkrk6Rwx5VIdBp/wiudj0mwYz48jbgJ44a/7A=;
        b=bQ6tZSQn2vcUfdQVfwUzIbjMTlvhebVjF4VPcueQQLp/9poW+cLfhUQJtuHzrOOmeV
         rXo9OdW5SMx96e5vSNgiKltIoTrfg6vnGs+ztJiIW4b6b2waz1ibsnEcpF6Sutrb02XD
         TmKhKZOynbWQlwVBdN4H4OnhdBZOS4e98MM+4ABMWFc6l7EbYWoTJ+8AKvfRVnKbDBbq
         dJgTDLUp33/WjdjJC2X1Pd0wDh2XX2GRhFcJJ62ZWcF3zYwuUxNN8gvsMjz8D2Do5s/7
         mXkqMVs3w5CBURkKXFv4jr/+WdNQtVu7juktPxlzrHP7TT0w2wdnEwecU9hP+sn49Ef+
         oUbw==
X-Forwarded-Encrypted: i=1; AJvYcCU7VLM0jdl/XgvD51j/x8Z0QItv9S8+RGrFSUiHrzsqV4nbTGlZeWmiaAFH9LvElnEHPoSq2Tu16AIGU1aVILIu0jeoMnlq5k+Ur9kOmQ50otEZcDZNS2TJV9EgopqE2oqO+E/A
X-Gm-Message-State: AOJu0YxldX7HaByHpE9Gc+2/XpqSRExzvXTtuX3YfsBHlODqSGHhjePU
	bfGnSa4BsbEjSTbNXe00ZvT9yZ2QufBaWAn9wf7jMbgDBDu3As1ZxQeAC7VG6gdIOOiSRFPfcfQ
	ReELn4gS5wjUoXUs9kzYqdRKUCvY=
X-Google-Smtp-Source: AGHT+IGlNVnmjim6uRGqIalPRRaaQMdQU4pii3S6HeqHF8AaGgC1xR+n8J9AEzznZLRAdMikUPRipCOC6dTtwb0mOq0=
X-Received: by 2002:a05:6870:9a08:b0:221:4140:2f33 with SMTP id
 fo8-20020a0568709a0800b0022141402f33mr91294oab.8.1709631330408; Tue, 05 Mar
 2024 01:35:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305074649.580820283@linuxfoundation.org> <20240305-arson-panhandle-afa453ccb0aa@wendy>
 <CADo9pHg4teVS7Lt1j+gOt4G9U=dZF9G92AUK=Km6PTdURkc0pg@mail.gmail.com>
 <20240305-series-flogging-e359bae88efd@wendy> <CADo9pHh6fnOz7d6+WCwkKz6_T4Ahru=0YDuc6q+KNnKYqQ2gBg@mail.gmail.com>
 <20240305-squeezing-backlit-d952f4503e57@wendy>
In-Reply-To: <20240305-squeezing-backlit-d952f4503e57@wendy>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 5 Mar 2024 10:35:15 +0100
Message-ID: <CADo9pHhtugqWO19dc7qT+sDruHBP0GR+5Kpd4RXVqb21SA+tmg@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/163] 6.7.9-rc2 review
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

Den tis 5 mars 2024 kl 10:34 skrev Conor Dooley <conor.dooley@microchip.com>:
>
> On Tue, Mar 05, 2024 at 10:21:46AM +0100, Luna Jernberg wrote:
> > Den tis 5 mars 2024 kl 10:20 skrev Conor Dooley <conor.dooley@microchip.com>:
> > >
> > > On Tue, Mar 05, 2024 at 10:07:37AM +0100, Luna Jernberg wrote:
> > > > Den tis 5 mars 2024 kl 09:32 skrev Conor Dooley <conor.dooley@microchip.com>:
> > > > >
> > > > > On Tue, Mar 05, 2024 at 07:58:57AM +0000, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 6.7.9 release.
> > > > > > There are 163 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > >
> > > > > > Responses should be made by Thu, 07 Mar 2024 07:46:26 +0000.
> > > > > > Anything received after that time might be too late.
> > > > >
> > > > > > Samuel Holland <samuel.holland@sifive.com>
> > > > > >     riscv: Save/restore envcfg CSR during CPU suspend
> > > > > >
> > > > > > Samuel Holland <samuel.holland@sifive.com>
> > > > > >     riscv: Add a custom ISA extension for the [ms]envcfg CSR
> > > > >
> > > > > I left a comment in response to the off-list email about this patch,
> > > > > I don't think it's gonna work as the number this custom extension has
> > > > > been given exceeds the max in 6.7/
> > > > > >
> > > > > > Samuel Holland <samuel.holland@sifive.com>
> > > > > >     riscv: Fix enabling cbo.zero when running in M-mode
> > > >
> > > > Works fine on my Arch Linux desktop with model name    : AMD Ryzen 5
> > > > 5600 6-Core Processor
> > > > after the Arch Linux manual intervention for new mkinitcpio settings
> > > > and version in Arch
> > > >
> > > > Tested by: Luna Jernberg <droidbittin@gmail.com>
> > >
> > > This problem is riscv only, your x86 machine should not be affected
> > > by it.
> >
> > Ah alright then i know, did feel like compiling the latest test kernel
> > anyways, but thanks for the heads up
>
> Ah, I understand now. You meant to reply saying that you had tested
> 6.7.9-rc2 but you replied to me instead of Greg's original posting which
> confused me into thinking you tried to test these specific patches.
>

Yeah sorry i did reply all in Gmail, maybe should just only have
replied to Greg and the mailinglist sorry for the confusion

