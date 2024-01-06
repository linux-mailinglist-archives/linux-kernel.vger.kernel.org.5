Return-Path: <linux-kernel+bounces-18544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29FE825F03
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 10:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E4328478D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36E663C0;
	Sat,  6 Jan 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V0CVmreh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9FB63AB
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-680adbf077dso3973466d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 01:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704533572; x=1705138372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCzELojOf7XR3y8WSqa5qQlK9psTGRHA9ep7x4N0xvA=;
        b=V0CVmrehAeTzRMNnFsFQLgVx6Ngs3vtShe9FMhfz2Y8zcrFQxYzMXntxjWPvxZwkK9
         OS3ekBiOxBDWPghU/+s3AVfC5T9LUrbhZ9b/4jevO44aaTuyrmsdRbfhc0m2Ktnv3eyR
         T1BI6rFQ0uy8kcsCmS9MQeJLYpX9Zob8FF8Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704533572; x=1705138372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCzELojOf7XR3y8WSqa5qQlK9psTGRHA9ep7x4N0xvA=;
        b=FIZJn+eDx2vwcsk9OLvqmyIjRMGREVsk7JH/EM5O7SL9vGN1hJNBvJG1Xni1WZpR1T
         NA9Jj2XZxkIOxbhBUPYgqHcQhOZIYBUcg/b8N4RasLX7e5csAGfeqJs7M+3M7wouqQzB
         oBBz1N52NALUvTtj23hWsr8wgeAjT7KiN0y0xxijmQtks81JCc+GNUtsVBzKAkJJB37m
         s3GwGvA81XhnaG34hRDxXDp13+zg8t9IwWjtTt3xZzW3np+mIZG3qNr0PoZwixCEqvMJ
         dSIRFpP/qpuYT3GIctziSO5nH80xWoGQLNNC3b9RH6hJJvuk5gCxFD0/dl9OxRAxFbAp
         oQqg==
X-Gm-Message-State: AOJu0YxtApwifG6SvR5qkKOBrr8XLQt7ynovWpgNQLnfhXFkkl9kEcfj
	hUZT57TAh0BV0PefINjowT9EFBv8Ldy4syTXqCL9zEPfNVft0gnaivcrI/Z8
X-Google-Smtp-Source: AGHT+IEoJzcvJ1WWTdTHCoVdZIRG0tYvkyXfIPVgMBjVGvNCJ6h7jGyeGI2WS4TaFsT73zmVMFO0cvtoLaFj4A1ggG8=
X-Received: by 2002:a05:6214:acd:b0:67f:ba18:7d59 with SMTP id
 g13-20020a0562140acd00b0067fba187d59mr1028539qvi.104.1704533572360; Sat, 06
 Jan 2024 01:32:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104084206.721824-1-dario.binacchi@amarulasolutions.com>
 <20240104084206.721824-8-dario.binacchi@amarulasolutions.com> <CACRpkdZ9uYj6geL+_NijdCP3mem-Lr+9RB1Nm4_hL3U480merA@mail.gmail.com>
In-Reply-To: <CACRpkdZ9uYj6geL+_NijdCP3mem-Lr+9RB1Nm4_hL3U480merA@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sat, 6 Jan 2024 10:32:41 +0100
Message-ID: <CABGWkvqaATABS+9_dJ3JVtYDT=a4e4m60epjUxLjv_ZJ7ik3QQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] drm/panel: nt35510: move hardwired parameters to configuration
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 8:08=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Thu, Jan 4, 2024 at 9:42=E2=80=AFAM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
>
> > This patch, preparatory for future developments, move the hardwired
> > parameters to configuration data to allow the addition of new
> > NT35510-based panels.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> I tested this patch on the NT35510-based Skomer and it makes the
> whole display mirrored around the Y-axis (text from right to left instead
> of the other way around, penguins appear mirrored upper right
> etc).
>
> +       /* Enable TE, EoTP and RGB pixel format */
> +       .dopctr =3D { NT35510_DOPCTR_0_DSITE | NT35510_DOPCTR_0_EOTP |
> +                   NT35510_DOPCTR_0_N565, NT35510_DOPCTR_1_CTB },
> +       .madctl =3D NT35510_ROTATE_180_SETTING,
>
> Changing this to NT35510_ROTATE_0_SETTING makes it work
> fine again.

Sorry for the mistake

Thanks and regards,
Dario Binacchi
>
> With that change:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
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

