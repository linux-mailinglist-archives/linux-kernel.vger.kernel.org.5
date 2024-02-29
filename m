Return-Path: <linux-kernel+bounces-85988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C7986BE19
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50CA1C23791
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3BE25765;
	Thu, 29 Feb 2024 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1sQ0kM3"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D5021350
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709169190; cv=none; b=FbryYadrEJUnvEC4Td2QTcSL7lRAemkXN9Fo081EjFcqvVcqFeg3dmLIWJSshVC9r3R95A35fpKEn+QZnmc60uiQwserZYzRoBC2ECAHYd/d46KtD0+2UXlNwyA+xWDEFjdUSG2/o8yikU/o9oHpbzDAfXf1emMfPdKMjvbGaeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709169190; c=relaxed/simple;
	bh=AhpRTC47m/0wASfaFl8PNSHlLAhy60LLx6DXCMebBMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrg9GLVaVhSsxU0NWQesQ6XtiAWlCY6UG9PIte3wTTSN699L0L8z/v5hJmLaXC5fwL4H7ygWWgJqaJsJTpO8pFA01vCE0t7GyAkswMfw/bOzOPPbKGnMcSLUuTlFfw/smESHsTw5CDUMyIzUBSGgaIk1XEooRzkjxwyNQZj7IMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O1sQ0kM3; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so1541385276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709169187; x=1709773987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6MGGAumrxRXV1Gl26nEoiePX3KShp1oKjTHnhKmtSY=;
        b=O1sQ0kM3ZI7sbm6Cw09GGKz3hQhTdto9wah1aXpDmDgZ/oU+4foAdGXfb8+1Jjot+s
         O4LGqy6BPmnaG8lyBT92lTh9i+H6e31L9w+9VSpY5Ny71qdP8N+jyXZC2Okgb8bI6Z6Z
         5AhOuYkxTnRxysS5U2u+XaAHgdZnF1UEUUKApyB/MdsqLAorjQs7fKEH+LkOgS8TMhcZ
         fVdAC0NjfTU4DcCq5KlNtQznKKeP/7kKxLtwAWDk50/+wYV6MKxIWnc2Vr7+5yW2T8i2
         GepEJTLI98lhY39WsgA0CP9u4Uq7V5wnBPp4/Exwdvu3+WWv58gg3J3xF2PBg1hIhhgy
         YvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709169187; x=1709773987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6MGGAumrxRXV1Gl26nEoiePX3KShp1oKjTHnhKmtSY=;
        b=coHdCgjXR0l/AjkmDTheN01ecTTx0IS2xsfLdzXQUFL6m9oOJ6biMlkA135LaJWlYR
         6aRzi1lc4Repfuk2XYOr3D4zLoSkd7FuzYHtJ++hur9Ut/rl+SQ0U+eazcpTDAh+3Zns
         L9aU3t0Gxd3aMUummqR0AoohfqmInEfhHESxsJ+uT0eKMunfm9PKA+2o6aEZjJm8GW+p
         u7lOWSvqsfC+aTtyqlnyJjCBUFZY8k2vz8lfFuzB66xWo4dk5fDXHjySG5ecebhiawyg
         SX0cvwePOQZ6Go66ufAK0sFD97wwpX+hzKyjo/HPaUlc6Ig2mhRkCmg3Sfm18BoB85P5
         4sxw==
X-Forwarded-Encrypted: i=1; AJvYcCUZW418b+2yxuOvFlnSG2eAmRY9KLlzZh4tdwAUPdQBsxnIDt7s91A4RH4vapQnUx1p+gNweN4Bg00+0g2Iq5qQ8ijGkFVqpTgzTtY3
X-Gm-Message-State: AOJu0YwrkkczpcZvXm74yOLwtKU1cJvHf2TUhZ/egNWruVpFkWVLXYil
	F43r23W6KCbl9FrQ8yS4l1vl3CLRQe3vAt1lcgR15OUJNdPDPtbfIaG6Pbac3FniJ9lB27OI3/D
	hH9+nfrcO8zSRxJsGrsiMcNi/vtXNZ7wIHhttGQ==
X-Google-Smtp-Source: AGHT+IEFJ7xKJ1yrUDbA9KTBjQB2oqRAl32r9mwdzugC5/qL3JiMFQ1HljV22KhztWAIckKawWgmC4zG3YYAOHipqQs=
X-Received: by 2002:a25:e0d4:0:b0:dc7:46fd:4998 with SMTP id
 x203-20020a25e0d4000000b00dc746fd4998mr303378ybg.13.1709169187453; Wed, 28
 Feb 2024 17:13:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228011133.1238439-1-hsinyi@chromium.org> <20240228011133.1238439-4-hsinyi@chromium.org>
 <CAD=FV=VV6fprky=v9koiVGmWcXKL3V4F2LOu7FriPbT_zT6xyA@mail.gmail.com> <CAJMQK-gmWHXNmxk4fWM0DEDN0kdUxVJF_D8pU_8CYCpBnd3-Ag@mail.gmail.com>
In-Reply-To: <CAJMQK-gmWHXNmxk4fWM0DEDN0kdUxVJF_D8pU_8CYCpBnd3-Ag@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 29 Feb 2024 03:12:56 +0200
Message-ID: <CAA8EJpr7LHvqeGXhbFQ8KNn0LGDuv19cw0i04qVUz51TJeSQrA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: panel-edp: Fix AUO 0x405c panel naming
 and add a variant
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 at 03:05, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Wed, Feb 28, 2024 at 4:22=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Tue, Feb 27, 2024 at 5:11=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.o=
rg> wrote:
> > >
> > > There are 2 different AUO panels using the same panel id. One of the
> > > variants requires using overridden modes to resolve glitching issue a=
s
> > > described in commit 70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_mod=
e").
> > > Other variants should use the modes parsed from EDID.
> > >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > ---
> > > v2: new
> > > ---
> > >  drivers/gpu/drm/panel/panel-edp.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > The previous version of this patch that we reverted also had an
> > override for AUO 0x615c. Is that one no longer needed?
> >
> >
> > > @@ -1990,7 +2003,9 @@ static const struct edp_panel_entry edp_panels[=
] =3D {
> > >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B=
116XAN06.1"),
> > >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B=
116XTN02.5"),
> > >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B=
140HAN04.0"),
> > > -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, =
"B116XAK01.0"),
> > > +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, =
"B116XAN04.0 "),
> > > +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay,=
 "B116XAK01.0 ",
> > > +                        &auo_b116xa3_mode),
> >
> > The name string now has a space at the end of it. I _guess_ that's OK.
> > Hmmm, but I guess you should update the kernel doc for "struct
> > edp_panel_entry". The name field is described as "Name of this panel
> > (for printing to logs)". Now it should include that it's also used for
> > matching EDIDs in some cases too.
>
> The space here is because in the EDID, there is space at the end,
> before 0x0a (\n).
> Okay I will update the kernel doc to mention that the same should be
> exactly the same as the panel name.

Maybe it would be better to strip all the whitespace on the right?

--=20
With best wishes
Dmitry

