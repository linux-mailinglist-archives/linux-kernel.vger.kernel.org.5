Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B77E75DE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345440AbjKJATa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjKJAT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:19:29 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C693A1BEC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:19:26 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9e61e969b1aso17128266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699575564; x=1700180364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrwEGwvAYg6tlhnlsOoqbubdC8uRYqTrfQGGYbxS8Nc=;
        b=ag68k2L2p8Ez9rb9yWDyHrpVYUP23GVgsggW+c8DWzaF+Z+BSkcKx4zz5Co/smd0wg
         P5ZLa1hc74X3Qdb0ogJ1VzYjrzJDTqEfcLYXphbR9ENS8OUJltN0nI47V0ZFLw40segI
         +yDTDjsyp63XlelbiQZd+H2IBkfl43JtMKSMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699575564; x=1700180364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrwEGwvAYg6tlhnlsOoqbubdC8uRYqTrfQGGYbxS8Nc=;
        b=GF39NTbjpgIv3AuDBnewVsK5vKlSzORoMKRDdwDRDKuneKzxsWskMFWr+jbqONF8er
         9RAgwekSowKyDN8WpXyMBdMMjHWzxl06CYz39wxKg7BdUjROdenZolwvE2GwC7pFoqyN
         RGCvRrF18TFO2xGaMH/8A9Ncq/GntM3KQuspeusXYztEFLss9J1x+5p5fcVvWqucdTMP
         J7s2jl6MYmoYy7yyao7l6oECRyhwAUxiODlLbeKHvz12BzUlUM+23xEqTyyh2WCoRU3X
         uTkrlaJhy3v70a8pN/kImhewRDUTWCrFaJNKaUV281LKK1QufC1AQ/0z5rHJxbc/60uv
         LJLA==
X-Gm-Message-State: AOJu0Yz6n0HFi1dll5/HSRYrLWGHzo8/bddtrSwXG2IGl+uwkh/wiQ0U
        qeZXfZuTM6dWFLaRGepG3GNe/pl8tm7zRuuNRLGPMA==
X-Google-Smtp-Source: AGHT+IGgPmvuFb/ryzAmIpXXAizDdrnDve4QmGPlroXd7F5knbPCncnjL45je0wHO6a45pQoawdF2w==
X-Received: by 2002:a17:907:9603:b0:9be:481c:60bf with SMTP id gb3-20020a170907960300b009be481c60bfmr6283539ejc.55.1699575564021;
        Thu, 09 Nov 2023 16:19:24 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id bw25-20020a170906c1d900b009bd9ac83a9fsm3205275ejb.152.2023.11.09.16.19.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 16:19:23 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so124285e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:19:23 -0800 (PST)
X-Received: by 2002:a05:600c:a45:b0:405:320a:44f9 with SMTP id
 c5-20020a05600c0a4500b00405320a44f9mr286238wmq.5.1699575563245; Thu, 09 Nov
 2023 16:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20231107204611.3082200-1-hsinyi@chromium.org> <20231107204611.3082200-5-hsinyi@chromium.org>
 <xnyf3ul7pwsgrmxgbareh5lhhmpfuvfksj3nyd4zmup7khaer2@fbwgbrq4vywb> <CAD=FV=WuwJGsDraFt=i0NbN-HkocsYgL=kCrZTxqVN+Oo1u8pg@mail.gmail.com>
In-Reply-To: <CAD=FV=WuwJGsDraFt=i0NbN-HkocsYgL=kCrZTxqVN+Oo1u8pg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Nov 2023 16:19:11 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vq4eMh0sKZn4qwT4vtxvKjZ48xkEZ7QUbBybDRyVdMVw@mail.gmail.com>
Message-ID: <CAD=FV=Vq4eMh0sKZn4qwT4vtxvKjZ48xkEZ7QUbBybDRyVdMVw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] drm/panel-edp: Add override_edid_mode quirk for
 generic edp
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 8, 2023 at 9:04=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Wed, Nov 8, 2023 at 7:45=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
> >
> > > @@ -575,9 +599,18 @@ static int panel_edp_get_modes(struct drm_panel =
*panel,
> > >
> > >               if (!p->edid)
> > >                       p->edid =3D drm_get_edid(connector, p->ddc);
> > > -
> > > -             if (p->edid)
> > > -                     num +=3D drm_add_edid_modes(connector, p->edid)=
;
> > > +             if (p->edid) {
> > > +                     if (has_override_edid_mode) {
> >
> > It's not clear to me why the override mechanism is only there when
> > there's a ddc bus?
>
> I think you're confusing the two different (but related) issues
> addressed by this series. One is when you're using the generic
> "edp-panel" compatible string. In that case the mode comes from the
> EDID and only the EDID since there's no hardcoded mode. We need a mode
> override there since some EDIDs shipped with a bad mode. That's the
> subject of ${SUBJECT} patch.
>
> The second issue is what to do with a hardcoded mode. That's the
> subject of the next patch in the series (patch #5). Previously we
> merged the hardcoded and EDID modes. Now (in the next patch) we use
> only the hardcoded mode. There's no need for a fixup because the mode
> is hardcoded in the kernel.
>
>
> > You mentioned before that you were following panel-simple,
>
> As of the newest version of the patch, it's no longer following
> panel-simple in response to your feedback on previous versions.
>
> > but that's a
> > clear deviation from what I can see. If there's a reason for that
> > deviation, that's fine by me, but it should at least be documented in
> > the commit log.
>
> I think the commit log is OK. I suspect the confusion is only because
> you've reviewed previous versions of the series. Please shout if
> things still look confusing.
>
>
> > > @@ -950,6 +983,19 @@ static const struct panel_desc auo_b101ean01 =3D=
 {
> > >       },
> > >  };
> > >
> > > +static const struct drm_display_mode auo_b116xa3_mode =3D {
> > > +     .clock =3D 70589,
> > > +     .hdisplay =3D 1366,
> > > +     .hsync_start =3D 1366 + 40,
> > > +     .hsync_end =3D 1366 + 40 + 40,
> > > +     .htotal =3D 1366 + 40 + 40 + 32,
> > > +     .vdisplay =3D 768,
> > > +     .vsync_start =3D 768 + 10,
> > > +     .vsync_end =3D 768 + 10 + 12,
> > > +     .vtotal =3D 768 + 10 + 12 + 6,
> > > +     .flags =3D DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> > > +};
> >
> > That should be a separate patch
>
> That's fair. I didn't think it was a huge deal, but I agree that it's
> slightly cleaner.

I've pushed the first 3 patches but not this patch nor the next one.
It wouldn't hurt to split patch #4 as Maxime requests and then send
the split patch #4 plus patch #5 as a v7. It's probably worth holding
off until either some time passes or Maxime responds and says that his
other concerns are addressed.


-Doug
