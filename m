Return-Path: <linux-kernel+bounces-132007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1480898E89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90028B2B019
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105EC1311B4;
	Thu,  4 Apr 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCMe2af4"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7AF1327FB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257396; cv=none; b=G6E+IQAz7+6lPAVwNXQLqLocWGwY/OPPy1qCiuEL1usag2z4z+xM3ihjubtlhMHcfy7Cw5QIybT/22Co0vrP2/pzRCNx+7wCMraiwQiEwYunonOuX0xQv61ZxMWlOd1F3f4c9pgl03hVtsW0ODW3b+ZxROPudLdqDnM4gtcY3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257396; c=relaxed/simple;
	bh=Up4fTzTynoabJ2E7aaGaGTB5fG3flPTeSrq8xC4kwsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIqCrkCo5+xyCTFGiU21fI/a65xBfcsCMInuH1MkYnt3seHg79DlTK+7y2J8oh8VZSkDK+zl0VBLCepcBIJD48ETzA1jq9/M9GPUFDCWcPIpZDhD/cYibn79mrPA94vsKqxAiQDbbhnFlF7BPyFwQnyOZzEzUjDY/8E3dTQw6Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SCMe2af4; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc71031680so1420882276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712257394; x=1712862194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slnGfuuzmIMf6Z733Fe9b+D2m+7gmHDi6Pd+kB2215g=;
        b=SCMe2af4MMfZ2/cl+d4PENvE2MUnmyb0OMeUNagz8xAPwXZDqzUDh+8pROvP2E1i86
         R+5FCxt/Prm2r8yQri0X8LleeeocXxgy2lDGO3MZPPweJEcnqVfQNP2W/8608tbJFD1w
         rFrdijnaBFfXo6Ij+fECQfiVfUFfF3lVapKIHBwcT4k39uKC6Azcx6k+58GkoE1PZeK3
         5tf3ZjTgpSAicDT6ZB+6omgMNVKpCyiXJn+TA9Xur3tRJca4Of55gL8DSsYPdJhRMkws
         wlZSpEvIdZgis0Go3spWC4fmc7caMjkGj9Ex+BuvhVwBaNlwzJ60B4HXFDGDuvrwl2lp
         0ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712257394; x=1712862194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slnGfuuzmIMf6Z733Fe9b+D2m+7gmHDi6Pd+kB2215g=;
        b=o893X5yZ3xSbkJCAPodvbieIIMrgIz/STGROw1vw3Ftd5nniYPTGDaHfM/BihjnHJK
         c12ccje+QBAIiztxiM4pzUx/26Cwn6Zko9Pufhh8rSyd+EFpgUFvpqxDQ3oTUNFfnTNh
         1W+ezjHtXXZnVxhCgjV2tuTHFiicdqr3WGBFz1CqXbEI/gwjPRqqb7zQkThRCw+V80tJ
         hUweRhCQl0I2GDlEw3T/pafHp5r2fjZ6mwGbGqRj+jRg6AUZhjs6etLLrhOIii6CYShP
         KSYdxyaI/V4R0H3ix5c3+1JL4DQN04LQY4Ni+vjnbLnCIMjVcvLkZfN4cldzcdxlvEWO
         Kygw==
X-Forwarded-Encrypted: i=1; AJvYcCX6T05AcyQWhUje3MUmik+rnGF6VXtHHuiS+2N+bT+O6H9PqmywLCMuMV9kH5JkEvfrVWWaa0sYQ4RmX2cvqpxVgbSPChVRwX/fzk/C
X-Gm-Message-State: AOJu0YxcGQnciicH2Khc8inmvv3q2iuL2pPXZMcgL0D8hgf5biIkf2uL
	pv/Sf9nKdsNMcIlUrfB8vzOeLCsnipPJIjPZgDt6wzM/c9o1Q9ael2/93SajSxYlp+MA8rPoWNG
	8vNpLOK8GAZ9BRl06fQe++JPWLeItH4NQh7ckmw==
X-Google-Smtp-Source: AGHT+IFvM8rqYI1T67O8DXnXqrU7ruyZEXe824lrTAb9rX/aRN74jrOAC2QGbb9GHQwfakLVE7pncf1/FqUcHhATKUA=
X-Received: by 2002:a25:8691:0:b0:dcd:19ba:10df with SMTP id
 z17-20020a258691000000b00dcd19ba10dfmr3380010ybk.56.1712257393756; Thu, 04
 Apr 2024 12:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com> <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
In-Reply-To: <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 21:03:02 +0200
Message-ID: <CACRpkdYLqO1XGMiWuGhZoM5wn8T7kFOvJ9LkiUp9W6zPufiP0w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cristian.marussi@arm.com, sudeep.holla@arm.com, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Thu, Apr 04, 2024 at 01:44:50PM +0200, Linus Walleij wrote:
> > On Mon, Apr 1, 2024 at 4:02=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp=
com> wrote:
> >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The SCMI error value SCMI_ERR_SUPPORT maps to linux error value
> > > '-EOPNOTSUPP', so when dump configs, need check the error value
> > > EOPNOTSUPP, otherwise there will be log "ERROR READING CONFIG SETTING=
".
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > (...)
> > >                         ret =3D pin_config_get_for_pin(pctldev, pin, =
&config);
> > >                 /* These are legal errors */
> > > -               if (ret =3D=3D -EINVAL || ret =3D=3D -ENOTSUPP)
> > > +               if (ret =3D=3D -EINVAL || ret =3D=3D -ENOTSUPP || ret=
 =3D=3D -EOPNOTSUPP)
> >
> > TBH it's a bit odd to call an in-kernel API such as pin_config_get_for_=
pin()
> > and get -EOPNOTSUPP back. But it's not like I care a lot, so patch appl=
ied.
>
> Hmm... I would like actually to get this being consistent. The documentat=
ion
> explicitly says that in-kernel APIs uses Linux error code and not POSIX o=
ne.
>
> This check opens a Pandora box.
>
> FWIW, it just like dozen or so drivers that needs to be fixed, I prefer t=
o
> have them being moved to ENOTSUPP, rather this patch.

Andy is one of the wisest men I know so I have taken out the patch.

Peng, what about fixing the problem at its source? Patch away,
we will help you if need be.

Yours,
Linus Walleij

