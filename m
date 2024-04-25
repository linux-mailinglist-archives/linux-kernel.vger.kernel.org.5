Return-Path: <linux-kernel+bounces-158565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A768B2223
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691151F24618
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684A8149C41;
	Thu, 25 Apr 2024 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh9dR4xm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1041494C4;
	Thu, 25 Apr 2024 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050019; cv=none; b=W8SvWUaRwkiyFxb9U9mrjtzGROc/NlNcbwBr6pFaq0UApxgsrHigXQDFycwdbx4Tb9klhohbHorwD/0EqAwQlqPNPusZCHKsoLcbPBvbEM+fOU5hW9IRnfbJsM+jjeiynj5JlBt8TOWE0kus/CQ76ifPsIJSHe92Lf4s8bxWv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050019; c=relaxed/simple;
	bh=Jrl7YgxIea/FrZp8PD/JLGrIfdU7/cSbjtD/+9nylvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFPSH5P04mWKoUfcJ7IxW35CEVVsHKwblCLMFzYFhwadqErP3CTo4neIsMIYf/mBNUOIHHTsRH15mgXC/1vlS4auLownceN204oT2h/OGC1jhJvcilcxPU6yqGSPHYvsOI/FQophqgT3o4F/9EtAA9Gh2YVAmO7AJlJKKS+MonU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh9dR4xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD66C3277B;
	Thu, 25 Apr 2024 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714050019;
	bh=Jrl7YgxIea/FrZp8PD/JLGrIfdU7/cSbjtD/+9nylvQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hh9dR4xm4prP0BLliKCNl8d7abHCN7qL86LsIOicC/cRHFkQyLDunvok85agoGaOF
	 Cr4S3CyaIJZj5M4VGGS9r1eBC2+F24eRPQS78hCM8uoItjBiRyNmtIGpIRI6Y1UKJt
	 MhG94uQxUeii9q+c1kdk0oArRf71/3GnfSSnbtpqLTBB7lWHuTHnutFkKu+/OnwGPk
	 7hCRKsekXY7dZ8Y2/YcFesKKtEUi7FCRCZKxB9vqXPZBgzzgXAsDbuYPgaLJKeV6xe
	 KNiEHS/UTtp939UbV8z36cTqb/cA/xamKSvhQ96D0Jp+fs+IGN0GeKB9EnDyUzpaeU
	 ibSfh5s00jeSQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ad288442bdso155507eaf.3;
        Thu, 25 Apr 2024 06:00:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVv9/WTfN+qjwZNMQVJYrfmhak9YdNeDVSU72RckRH2664KQ6wHCRUrgFY/BSakuXdrLcDhU6+/+GrXZAFjRJ8aCEQpahX62O9sshiuBNwFPZVSmmJOEtR6L1C3yZ1+eqtrL/0RAJM=
X-Gm-Message-State: AOJu0YxhZfMiqBakIiOQCp87zkyJzkuG3xJjgQdZX/54oeHuMF85ffXu
	mJc+YfZsTqYPB1/V8//Aelt15I+iwpcprQWc6s/gLUcpIkV8PvM5xk+BuMttwUTMZDXyCU1DdU1
	dVQ624hmZmVDMfCUAxK6L31SCpRs=
X-Google-Smtp-Source: AGHT+IEENrDyvzVq1OlQwtnbjz4B/H+1Un+4iNhD0S4KH5d7zTFd2Yv4PeyfIZy4cwPlIE9eGPlHjK+p/t0tXuuNGKY=
X-Received: by 2002:a05:6870:4183:b0:23b:7ff:91cb with SMTP id
 y3-20020a056870418300b0023b07ff91cbmr5610112oac.4.1714050018405; Thu, 25 Apr
 2024 06:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5774279.DvuYhMxLoT@kreacher> <2181352.irdbgypaU6@kreacher>
 <e9be06af-48bf-45ec-8d6d-6147d20b6780@arm.com> <CAJZ5v0i=HS_-S3N7ixK=FM0S=7o21cfW5jXMq=AWObwGpUkPdA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i=HS_-S3N7ixK=FM0S=7o21cfW5jXMq=AWObwGpUkPdA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Apr 2024 15:00:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ik_EqSXzTkowz=ha-U+JU+=KtqEMwD5+r329og2d4t=A@mail.gmail.com>
Message-ID: <CAJZ5v0ik_EqSXzTkowz=ha-U+JU+=KtqEMwD5+r329og2d4t=A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 2:36=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi Lukasz,
>
> On Thu, Apr 25, 2024 at 12:02=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com=
> wrote:
> >
> > Hi Rafael,
> >
> > On 4/23/24 19:00, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > If cdev_dt_seq_show() runs before the first state transition of a coo=
ling
> > > device, it will not print any state residency information for it, eve=
n
> > > though it might be reasonably expected to print residency information=
 for
> > > the initial state of the cooling device.
> > >
> > > For this reason, rearrange the code to get the initial state of a coo=
ling
> > > device at the registration time and pass it to thermal_debug_cdev_add=
(),
> > > so that the latter can create a duration record for that state which =
will
> > > allow cdev_dt_seq_show() to print its residency information.
> > >
> > > Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device deb=
ugfs information")
> > > Reported-by: Lukasz Luba <lukasz.luba@arm.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >   drivers/thermal/thermal_core.c    |    9 +++++++--
> > >   drivers/thermal/thermal_debugfs.c |   12 ++++++++++--
> > >   drivers/thermal/thermal_debugfs.h |    4 ++--
> > >   3 files changed, 19 insertions(+), 6 deletions(-)
> > >
> >
> > I'm trying to test it on my board and do the review, but faced issue.
> > For some reason I couldn't apply that patch on the latest bleeding-edge
> > branch.
> > Could you help me in this please? Is there something missing in the
> > patch set (like one more fist patch)?
>
> I messed up the ordering of patches (patch [2/3] should be the last
> one in the series) and on top of that, you'll need a small rebase on
> that patch.
>
> Sorry about this, I'll send a v2.

Actually, the ordering was OK, but the rebase of the second patch is
still needed.  I'll send a v2.

