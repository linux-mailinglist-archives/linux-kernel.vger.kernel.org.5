Return-Path: <linux-kernel+bounces-61510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8045A85130E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10561B24B39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B06D39FE2;
	Mon, 12 Feb 2024 12:03:23 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D053D964;
	Mon, 12 Feb 2024 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739402; cv=none; b=cCR1OW/rJs0JBmc8wzVUIOHKQH14P1xyGp0LurSweP4lmj0Hj85idnXMrg63klJAOasvPJRSmI4gZRDrWlyGSrbGj1LPOrNE0vxIYD4e0H6IvaD61puHaVti8TiSVqeBtSEsVt6P03eC6gGwQ0m6xSA9kgPN9uIIeqm+NtaQCA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739402; c=relaxed/simple;
	bh=rfED2IXGqOBD+K1HnRdLQdhtHs14ZMAFcdInDfpTlXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEmRuP4jJlvPE7P4cAM3fNZa+Jf6j+QNFL3nA0BM4h/VHA77MRZcw0+XQlzQaoLOKBidx10aXiIoLu8D89OBNFBO/Ky56O1HuEva7v0qq60nApgiK+jEHTQTl5awQ9Y0D6SwtVAWBs0D/TXAcSAJDRf+oOq873KIo8aBLvq8ZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-218e7bb0034so752005fac.0;
        Mon, 12 Feb 2024 04:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707739400; x=1708344200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOYodCfh0GuqCNxZvnHyKyee8GZYuYBo58cLH6hYt/c=;
        b=j8dsYKWC5SmOnPXgIteRWMuXUiK3Oa69EZdy3xxr+CaRv7HrsuU/+P2GL3a8Oq/4Pi
         a1xxvCs0HceZQE9mENQPwOFLRC6YnVJ1lo8GbjZ8BukPzna5kN0Ms+SLBSNZ+5JXsLc8
         O1TwyA3rEvSUFzfgmf7nBzxK6RFquIOZNra/0DREkdZRzm4j7STjUfNguxU+SMvEhls6
         jwgt+Nal+8E1vazXC7Nosm8YSDbGNzO2OdnkrMQmgpfghcTdrPleSaoXGDNXQ3VXk2OK
         SMW0rOdNeifn72DwxLxWFqacA6ptVy4uLW7LOzGaAj44yGAtnRN1IJhXR41Bbi8XU3sB
         yzfw==
X-Forwarded-Encrypted: i=1; AJvYcCXd9I5Wzwk+78IewwEkzmnfmWdoV9VEpUlH6FYMllkeI26FsVR+2qExolBhZ4WcX+sjQg2jvUro7QfcOWi2XfkOEnvoBNOuKnrmHACspPgLPWQbns+v1kN5GcTKbu0BtkFD46ABQXdRPShhukW+PPMAV33jGJptkcIh/G+XtxUZnaR57M+CH7eVEdvQbOBGEFPDxhFSSK58WK4M5OtiOw==
X-Gm-Message-State: AOJu0YzKY1mQHkZwqDppSficfX9XqaCNdfHVh4KqMsb1n2ggp4b/L0EP
	BGMAMZQ4pW0frPXlwMktMcVzw/Rade+u+IrGFbxp3k4jsMpBrgR3GTWx1CNVdov+pXSACxDf0Ie
	O2Kj5v2k4bO8OgSkIUwpkGt4//xI=
X-Google-Smtp-Source: AGHT+IFwlMsnEvSMtcwsucXokcWRI/75RN6SqVnxJGnEBRUDfA73uBY+jzDu02IY306Xvo9uMMkaNiqNntOeaLxWXAg=
X-Received: by 2002:a4a:a6cd:0:b0:59c:d8cd:ecee with SMTP id
 i13-20020a4aa6cd000000b0059cd8cdeceemr5262334oom.1.1707739399881; Mon, 12 Feb
 2024 04:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3232442.5fSG56mABF@kreacher> <3757041.MHq7AAxBmi@kreacher>
 <ZcY7jyyFJq1yfOCj@linux.intel.com> <CAJZ5v0gZ1tpNmdkvRLA6-ydnhKPKgsM_FCwrW+q1=5ZiD=vbWA@mail.gmail.com>
 <35d4ae8f4c5157e3d0da39295a5b15eced367ab6.camel@sipsolutions.net>
In-Reply-To: <35d4ae8f4c5157e3d0da39295a5b15eced367ab6.camel@sipsolutions.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 13:03:08 +0100
Message-ID: <CAJZ5v0jJzGR1LSDaXDCAeysCerT7A_OOyMKqJpLbxEBR4_HyqQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] iwlwifi: mvm: Set THERMAL_TRIP_WRITABLE_TEMP directly
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:31=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Fri, 2024-02-09 at 17:15 +0100, Rafael J. Wysocki wrote:
> > > >       for (i =3D 0 ; i < IWL_MAX_DTS_TRIPS; i++) {
> > > >               mvm->tz_device.trips[i].temperature =3D THERMAL_TEMP_=
INVALID;
> > > >               mvm->tz_device.trips[i].type =3D THERMAL_TRIP_PASSIVE=
;
> > > > +             mvm->tz_device.trips[i].type =3D THERMAL_TRIP_WRITABL=
E_TEMP;
> > >
> > >                 mvm->tz_device.trips[i].flags =3D THERMAL_TRIP_WRITAB=
LE_TEMP;
> > >
> > > Consider using diffrent prefix for constants to diffrenciate flags an=
d types.
> >
> > Well, I can use THERMAL_TRIP_FLAG_RW_TEMP or similar, but is it really
> > so confusing?
> >
> > I'm wondering what others think.
> >
>
> I'd tend to agree with Stanislaw. I did (eventually) notice the double
> assignment to .type above, but had that not been visible in the context,
> or you'd have removed the first one by accident, I'd really not have
> thought about it twice.
>
> The bug also makes it look like you even confused yourself ;-)

No, that's just a mistake.

> So having a clearer indication that it's a flag would make sense, I'd say=
.

Sure, thanks!

