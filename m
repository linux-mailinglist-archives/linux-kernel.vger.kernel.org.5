Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F187E5BF0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjKHREc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjKHREa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:04:30 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19583E8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:04:28 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c41e95efcbso1076894166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 09:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699463063; x=1700067863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDcupbe+5qAO0hhDSEHW5GSzZCVe/uaRnl7TSsp+HAs=;
        b=c+mj0HTRDTOZsSPLdBU/bRSzOqDm45aOl/QVkXiYrkZpNsqrJoIkXx+cCCUDUbp92o
         HNl2oTYR7fJEelj6pAeHxDy+0tnU7KEmMP9PER6RvOYHGavNzmUHZDg/N3KISbeiwclF
         45jIy3vRKO4pRjtFImsbTDP5NCIWtxAFEBAms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699463063; x=1700067863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDcupbe+5qAO0hhDSEHW5GSzZCVe/uaRnl7TSsp+HAs=;
        b=iuy+5DuZajHvvHGGKKR3nMV4FCO2XgF3LmoAo+Hn1UCGDpTb/dkxIeztlviYg5XNO+
         QpCCHMRiJSOStU2aXUd7sYXOT4Z1VHZxxH5CLoaKJDYCABoH7RN0LnLqGMy+17AEcIT9
         qJ5ySJZ7IdhpS35SBPtEsHLUV1Fr79HrL/Qay/v7F+3rjBWmILm/eyUHJxYYxjb8H2FH
         YpJxOlnAxJZqt956IJr8RDqyPr3BrbYOakFJuSvpbxtgqCtRorF89E3AuRXphzsGYx0u
         9kxOMzS6e9in7Jdn1x5ui/edW7uemvFyVYvRzmYz5HsygBegiQS96CURRQ7M+kotIHLR
         ONGQ==
X-Gm-Message-State: AOJu0YwsxgzV1DwU3G2ZNadgA3FUlDTKSwxF/i5iFNgxQQCSKk/ba8/J
        7H4925DVM74nmDpzo3QPvVI96dLFq+PtLNm9WsmtJRre
X-Google-Smtp-Source: AGHT+IEo1Ro0fHnIcdrJBw+bV+WqwAci7y6R9OBEf/47Y0P81aVgxWZ0eGOqrUFF08Rq0GJwTub3FQ==
X-Received: by 2002:a17:906:c115:b0:9c2:2d0a:320c with SMTP id do21-20020a170906c11500b009c22d0a320cmr1999825ejc.46.1699463063348;
        Wed, 08 Nov 2023 09:04:23 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id mj24-20020a170906af9800b00992e265495csm1310289ejb.212.2023.11.08.09.04.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 09:04:23 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so75605e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 09:04:22 -0800 (PST)
X-Received: by 2002:a05:600c:3110:b0:405:320a:44f9 with SMTP id
 g16-20020a05600c311000b00405320a44f9mr219580wmo.5.1699463062323; Wed, 08 Nov
 2023 09:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20231107204611.3082200-1-hsinyi@chromium.org> <20231107204611.3082200-5-hsinyi@chromium.org>
 <xnyf3ul7pwsgrmxgbareh5lhhmpfuvfksj3nyd4zmup7khaer2@fbwgbrq4vywb>
In-Reply-To: <xnyf3ul7pwsgrmxgbareh5lhhmpfuvfksj3nyd4zmup7khaer2@fbwgbrq4vywb>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Nov 2023 09:04:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WuwJGsDraFt=i0NbN-HkocsYgL=kCrZTxqVN+Oo1u8pg@mail.gmail.com>
Message-ID: <CAD=FV=WuwJGsDraFt=i0NbN-HkocsYgL=kCrZTxqVN+Oo1u8pg@mail.gmail.com>
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 8, 2023 at 7:45=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:
>
> > @@ -575,9 +599,18 @@ static int panel_edp_get_modes(struct drm_panel *p=
anel,
> >
> >               if (!p->edid)
> >                       p->edid =3D drm_get_edid(connector, p->ddc);
> > -
> > -             if (p->edid)
> > -                     num +=3D drm_add_edid_modes(connector, p->edid);
> > +             if (p->edid) {
> > +                     if (has_override_edid_mode) {
>
> It's not clear to me why the override mechanism is only there when
> there's a ddc bus?

I think you're confusing the two different (but related) issues
addressed by this series. One is when you're using the generic
"edp-panel" compatible string. In that case the mode comes from the
EDID and only the EDID since there's no hardcoded mode. We need a mode
override there since some EDIDs shipped with a bad mode. That's the
subject of ${SUBJECT} patch.

The second issue is what to do with a hardcoded mode. That's the
subject of the next patch in the series (patch #5). Previously we
merged the hardcoded and EDID modes. Now (in the next patch) we use
only the hardcoded mode. There's no need for a fixup because the mode
is hardcoded in the kernel.


> You mentioned before that you were following panel-simple,

As of the newest version of the patch, it's no longer following
panel-simple in response to your feedback on previous versions.

> but that's a
> clear deviation from what I can see. If there's a reason for that
> deviation, that's fine by me, but it should at least be documented in
> the commit log.

I think the commit log is OK. I suspect the confusion is only because
you've reviewed previous versions of the series. Please shout if
things still look confusing.


> > @@ -950,6 +983,19 @@ static const struct panel_desc auo_b101ean01 =3D {
> >       },
> >  };
> >
> > +static const struct drm_display_mode auo_b116xa3_mode =3D {
> > +     .clock =3D 70589,
> > +     .hdisplay =3D 1366,
> > +     .hsync_start =3D 1366 + 40,
> > +     .hsync_end =3D 1366 + 40 + 40,
> > +     .htotal =3D 1366 + 40 + 40 + 32,
> > +     .vdisplay =3D 768,
> > +     .vsync_start =3D 768 + 10,
> > +     .vsync_end =3D 768 + 10 + 12,
> > +     .vtotal =3D 768 + 10 + 12 + 6,
> > +     .flags =3D DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> > +};
>
> That should be a separate patch

That's fair. I didn't think it was a huge deal, but I agree that it's
slightly cleaner.

-Doug
