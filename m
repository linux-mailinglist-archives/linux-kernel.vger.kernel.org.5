Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2740805DD6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbjLESF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjLESFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:05:24 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0496B2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:05:30 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a1a0bc1e415so560569666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701799526; x=1702404326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQY0vlSpKcmwWyHOVhQ8rGvlB1TLuij1Tr7g/xZpQa4=;
        b=OIbotLurTUSns0Jb+gW2tMAf4WbXFKgmmfstALA1f1WcnwRi3mEoi5bqBhLmYZriYk
         6lGWF0rTVO41AhM/fMNk+25A6ujHp3ERO42ih8gxql5YCwXWzMv5e1qxzmRkZWNY22Mx
         pGqDDoee5xg71tiiMuLiMmB6SUKDsXRod1llU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799526; x=1702404326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQY0vlSpKcmwWyHOVhQ8rGvlB1TLuij1Tr7g/xZpQa4=;
        b=tX36fsYxpfeXOgZyQ4/nY6MmJZZQodwgsEPPnqqunJLB+vHbMWpdlECW4JEZSSiWvY
         j0HRn0kVgtiDItTWefjtaG+sm7DIEFqlDNxJ+kYZMq1ykddhqSxTWKh3kdLR5Vnio/+W
         r8fQo1ZlsqIWJ+Bgy/89r5C4nNoq6koNXxHZ9OnDr3UFPVcloc16KdLzm1pLo9bEOzCq
         GmgJHWP/qalbOO6FtTKEoOAdUsUYYc2FA3r67gJzWh17UxncqISR888tW1GHxYggKHpH
         EductEBi/6E5VkZqPdF1NCcTv6IpL5YNvnX2NdJty7ZqOBOjN1IDqotFkMO7o+BmJ4ir
         gTFA==
X-Gm-Message-State: AOJu0YzHX76xvM8NmLAgDDGks/rwVFC50sqvSeczB9PRg0YeMMAcVD7P
        lMJIS6tPabJ93Ru+TvjQMWGLhEv9cM36j8qb07DVS877
X-Google-Smtp-Source: AGHT+IFT0WHPED7jmu8bZ4YWJ4xLcpuCi9DknUxSN0DLjBHgfY2nRFWtO6GBZ4rEPCxMorQNzdcAMA==
X-Received: by 2002:a17:906:4a58:b0:a1c:e980:3c3 with SMTP id a24-20020a1709064a5800b00a1ce98003c3mr683823ejv.28.1701799526725;
        Tue, 05 Dec 2023 10:05:26 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id d9-20020a170906370900b009ae57888718sm6956161ejc.207.2023.12.05.10.05.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 10:05:26 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so1895e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:05:25 -0800 (PST)
X-Received: by 2002:a05:600c:5247:b0:405:320a:44f9 with SMTP id
 fc7-20020a05600c524700b00405320a44f9mr573795wmb.5.1701799525559; Tue, 05 Dec
 2023 10:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20231201-x1e80100-drm-panel-edp-v2-1-b0173484631a@linaro.org> <CAD=FV=Wx_W-Jspx4S4k-Jze8eBm5zGanzqt0-fWjYZhHB_=1qQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Wx_W-Jspx4S4k-Jze8eBm5zGanzqt0-fWjYZhHB_=1qQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Dec 2023 10:05:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VmY8OPfW9awuikUdL8h=vphoeGLwfKmsyZjvQou9MCGA@mail.gmail.com>
Message-ID: <CAD=FV=VmY8OPfW9awuikUdL8h=vphoeGLwfKmsyZjvQou9MCGA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add SDC ATNA45AF01
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 4, 2023 at 8:46=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Mon, Dec 4, 2023 at 12:54=E2=80=AFAM Abel Vesa <abel.vesa@linaro.org> =
wrote:
> >
> > Add support for the SDC ATNA45AF01 panel.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > Changes in v2:
> > - moved the panel entry in the proper place, as suggested by Doug
> > - Link to v1: https://lore.kernel.org/r/20231201-x1e80100-drm-panel-edp=
-v1-1-ef9def711d8a@linaro.org
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/=
panel-edp.c
> > index 825fa2a0d8a5..78565c99b54d 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -1983,6 +1983,8 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >         EDP_PANEL_ENTRY('K', 'D', 'C', 0x0809, &delay_200_500_e50, "KD1=
16N2930A15"),
> >         EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, =
"116N29-30NK-C007"),
> >
> > +       EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "AT=
NA45AF01"),
> > +
>
> Looks fine to me now. I will note that e200 is pretty long and I
> wonder if you've got this because of a requirement of T3+T4+T5+T6+T8
> being more than 200ms. If so, I wonder if Pin-yen's patch [1] would
> help you optimize things?
>
> In any case, this looks fine to me.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ...I'll wait a day in case you say this would be better atop Pin-yen's
> patch and want me to wait, but I also have no objections to landing
> this now and later optimizing the delays.
>
> [1] https://crrev.com/c/5052150

Pushed to drm-misc-next.

8ebb1fc2e69a drm/panel-edp: Add SDC ATNA45AF01

If you can optimize this after Pin-yen's patch, feel free to send another p=
atch.

-Doug
