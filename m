Return-Path: <linux-kernel+bounces-4084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7058177C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31282878BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D575A855;
	Mon, 18 Dec 2023 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Elhm48y4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C4B5A846
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a234938c7f3so194198066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702917753; x=1703522553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG2qZG/XdvJUEvAVYY7hNHtIGwP/B3fi4Ki1iIxEYOI=;
        b=Elhm48y42Vj3PsvCeytXphbT6DlOitC8/MtYyyMSkpfhVZp6oqyX6sBhqeS3pLGNav
         WTpwdPd0jgyTsrWLQzmVXkhglQ8/jM3k7oldmzX4RlnwS1MdZkw/NyD06JuU+uhcJAfE
         u3GiHrGP+JXD4JMlSXtkcqNClHYB3EcanMprk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917753; x=1703522553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG2qZG/XdvJUEvAVYY7hNHtIGwP/B3fi4Ki1iIxEYOI=;
        b=KfjY69k/B/abZkXN+TVx8HdjEiqFTY9IsyN7JUX/LGQXn1QFE2qR/O5lUKsQ+4bbSL
         zu1aYYgHwgMz6HVhqZOwapU8yad+RSbj69fuNH0LUjWwovUJMDBmJF83F3uXr39IcMpl
         WosTr/IkifC8OtGfDOZ6cdnBlFA/hCv3KcK2tg8AfxafgKSVEtkVJy3FrhQZRV+X87rm
         9oU+joAb8wLC4erq9wurkSyPnEn7g0x0/QH1vZbpZGOxXEowA9Z35JCGVNJJcEyKzwxI
         AvphxRjd35U3sSA05a9U0xsYrm80stJjDWPEKKfydL1WP2wU8qz0CJYkydoZ0APshrpB
         XfxA==
X-Gm-Message-State: AOJu0Ywv+ALb+qCS4X1i5tAVMxKH4G0Dr5/rLPfr8MBZk5RvyQ7qeKKv
	LH6bb9k3cCrdGyj3q4NoKPiVZI2BRKsk/ojWf4y2kfjJ
X-Google-Smtp-Source: AGHT+IEugBaad78r10gWAyM8A2tdODIL1rcdotSspuCadZnkkJSUeTjMbDx5Qr4hY5MVvrJq728xAw==
X-Received: by 2002:a17:906:da08:b0:a19:a19a:eadf with SMTP id fi8-20020a170906da0800b00a19a19aeadfmr7102103ejb.152.1702917753590;
        Mon, 18 Dec 2023 08:42:33 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id vx6-20020a170907a78600b00a1e852ab3f0sm14490229ejc.15.2023.12.18.08.42.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 08:42:33 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-552eaf800abso20517a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:42:32 -0800 (PST)
X-Received: by 2002:a05:6402:5216:b0:553:6de7:43d7 with SMTP id
 s22-20020a056402521600b005536de743d7mr111830edd.6.1702917752681; Mon, 18 Dec
 2023 08:42:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214152817.2766280-1-treapking@chromium.org> <20231214152817.2766280-4-treapking@chromium.org>
In-Reply-To: <20231214152817.2766280-4-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Dec 2023 08:42:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xd3TJNBSzUQ=4td9t6Nqnbd3QAt7fmnn_aT0QXSkRn0Q@mail.gmail.com>
Message-ID: <CAD=FV=Xd3TJNBSzUQ=4td9t6Nqnbd3QAt7fmnn_aT0QXSkRn0Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/panel-edp: Add some panels with conservative timings
To: Pin-yen Lin <treapking@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <groeck@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 14, 2023 at 7:28=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> These panels are used by Mediatek MT8173 Chromebooks, and they used to
> work with the downstream v4.19 kernel without any specified delay.
> Back in the v4.19 kernel, they used the "little white lie" approach,
> which is making the devicetree claim a specific panel's compatible
> string for many different panels. That was a common solution before the
> generic edp-panel driver.
>
> After we uprevved the device to a newer kernel and used the edp-panel
> driver, we saw multiple devices reporting warnings of using an unknown
> panel and falling back to the conservative timings, which means that
> they turn on/off much more slowly than they should. We tried to fill in
> the timings for those panels, but we failed to find all the data sheets
> for them.
>
> Therefore, instead of having them use the default conservative timings,
> update them with less-conservative timings from other panels of the same
> vendor. The panels should still work under those timings, and we can
> save some delays and suppress the warnings.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ---
>
> Changes in v3:
> - Update the commit message.
> - Collect review tag.
>
>  drivers/gpu/drm/panel/panel-edp.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Pushed to drm-misc-next:

7c8690d8fc80 drm/panel-edp: Add some panels with conservative timings

