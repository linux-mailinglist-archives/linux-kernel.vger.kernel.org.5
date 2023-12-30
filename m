Return-Path: <linux-kernel+bounces-13400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D4820499
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7EF1F21993
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0E979C2;
	Sat, 30 Dec 2023 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZS1dVcc5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F677481
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4280bd41317so5601851cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 03:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703935776; x=1704540576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdHRZOJmLihwmundfIYh/Hz760M3I/Nde2Bk7xxTT8A=;
        b=ZS1dVcc5xSN5J+8wM562Zu//LTlPPJLJM2U4IetRSufRMbA01mMVsgrr5mY7f+B2Ul
         BUAQZXAuHVZmen6u+6VhFAq/QfZqZH0W39gmMZaPPB0yYIVYIYPpE5RIbMVVO4pPTN3D
         Ppe/z+1/QialIU00YhmQip3YpCYuN9BBNw7Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703935776; x=1704540576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdHRZOJmLihwmundfIYh/Hz760M3I/Nde2Bk7xxTT8A=;
        b=csos+pIrFjbyHRjUNGBIy9gkHlI5FnBDuMJlu6lAeVR4oZpaQwIclv2SzYeG//6JQa
         2hMuiHWu2Sr4Ef0tKtcbdq+oiXVglSBRR4qpKO9bZATvBZMorXzXkGVhZbIpoifuTzxB
         qGgrigSgCyiebJbbMRvYn94ubx/Jg4//eoEOVNGmrqv4bNEPdAnSPn24/hN2AsWWs8TX
         LNZpWJC4q4YWr+GIlnjeXK9ZxCQnakPMGoriHHn+L79+8VqyfJtutuFnJuJ5967/EJfE
         royWyh0cRjn0vhfm9l7ireb5i9fA36hYLZy8Ac4e5RWXh3ieytKrAe7i3D5gpQHtOlVa
         eLVA==
X-Gm-Message-State: AOJu0YyfCOMttQZNdt1ebVREmGwnic5vo/eAgKy+wDTJBhEdeGujAHPU
	/PCn7Otlymwjhfqb9ggBl33F9s6mB3Z8K4hU1IF8TKu9Lhp8kw==
X-Google-Smtp-Source: AGHT+IERnlTpmOwuxpaJxtAALpkHsOCMYmErEeE799Q8hbMelUhNiSF7yID6JUsxUnY0tfGC2aD2IOPLZZPULy041zE=
X-Received: by 2002:a05:622a:1393:b0:428:c11:47aa with SMTP id
 o19-20020a05622a139300b004280c1147aamr1958131qtk.57.1703935775771; Sat, 30
 Dec 2023 03:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
 <20231229135154.675946-8-dario.binacchi@amarulasolutions.com> <CACRpkdbHodbAwoaTyxTX4LxYm6ZrBV6m6ht31Y2OaUPxS0Zhrw@mail.gmail.com>
In-Reply-To: <CACRpkdbHodbAwoaTyxTX4LxYm6ZrBV6m6ht31Y2OaUPxS0Zhrw@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sat, 30 Dec 2023 12:29:25 +0100
Message-ID: <CABGWkvpvze9pBg9_3r9A0oWjTQ8JrRzXU+-0HX_9kkJFNNW8ig@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/panel: nt35510: refactor panel initialization
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Fri, Dec 29, 2023 at 6:43=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Fri, Dec 29, 2023 at 2:52=E2=80=AFPM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
>
> > The previous implementation did not make it easy to support new
> > NT35510-based panels with different initialization sequences.
> > This patch, preparatory for future developmentes, simplifies the
> > addition of new NT35510-based displays and also avoids the risk of
> > creating regressions on already managed panels.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> The idea is to have the driver adapt to different panels, and encode a de=
ep
> understanding just like we do with all hardware drivers.
>
> NAK.
>
> This patch:
>
> - Deletes a lot of useful documentation on how the panel works.
>
> - Deletes defines and replaces them with magic numbers
>
> All it achieves is a bit of "magic sequences because we are used to
> magic sequences" and that doesn't look like an improvement at all,
> instead it creates a dumber driver which has no explanations at all
> to what is going on.
>
> Please rewrite the patch in the same style as the original driver.
> The fact that you (probably) are not used to writing display drivers
> in this way is not an excuse to destroy this nice structure.
>
> There are things that can be done, like create an abstraction for
> sequence encoding with less open coded command issue
> statements, by adding helpers to the DRM core, so if that is what
> you want to do, then do that instead?

Thanks for your explanations and suggestions.
I will rewrite the patch following your suggestions.

Thanks and regards,
Dario

>
> Yours,
> Linus Walleij



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

