Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA297E299C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjKFQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjKFQVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:21:09 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FA1F4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:21:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c603e235d1so687265466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699287663; x=1699892463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJv2xHGqT26SHPZhKKhHJF6XJv7tbJEJlMwgJnhS9Io=;
        b=Z8lDSJPVri/krR+5Oz9r+/8OUehZVONTKDuHvDagIbIZHrkiQD96LqSUVOUVGf8C/k
         DaUx1cB3V6miSDudZtOr49pTMVmBA0VzPvoNCRyeV6StJCmz7x+nJPNm+TRrPPiDQGt+
         ZfnJtxEA8Zx2ZerWS8sLozNdL216oSIyb4HeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287663; x=1699892463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJv2xHGqT26SHPZhKKhHJF6XJv7tbJEJlMwgJnhS9Io=;
        b=wXJEsfYBLbUXOeIEkRsIMTq9rh8c6MMdIl8eQvQtgA//a3MCGntujtU5n1FGOLZjpv
         fyeU9n3znn3g6IZjWIlVGL44FYMUlRawL8h4kwWNLA5tu31K/KGJ085KAfhGrmNPeKt7
         G2g49lt7oJb+r4pbcvQxLRyu5oNSzxJJ8ZbQF1+I/J7TpWHJ0m/cKHOEIKO69J+QvwJa
         BCcuixYSaz1ZjbapmG4mmRZmF5wBJu6Nflms+mmL96fYBnr2vlcOSD6rC1hVQ6Z15J4n
         XELWKqECdbTi6bnIH0IBbxwcxHYENytpQ0QOKofLXyESSOb8d81bjOZuSjBwBuI2s24A
         Pzrg==
X-Gm-Message-State: AOJu0YxHtA0GAsHhTQnaQo2Y+qF/wMVG9yR3YOCatNEnuWKD6lDo3HvH
        HvHFWYO/EUDsHK7PE8Gv5d450apTbfWJCgRnl+OZUA==
X-Google-Smtp-Source: AGHT+IE5aMPIo3gQZZdnpMEqmsnfkm3/sz7pknD+7ANSC6kK+h8QJN/Pqs0TFnA2tJU4g9hl6uearg==
X-Received: by 2002:a17:907:8689:b0:9be:ca44:87b6 with SMTP id qa9-20020a170907868900b009beca4487b6mr14688535ejc.3.1699287663677;
        Mon, 06 Nov 2023 08:21:03 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id eg38-20020a05640228a600b0053ff311f388sm4458862edb.23.2023.11.06.08.21.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 08:21:02 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so104755e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:21:02 -0800 (PST)
X-Received: by 2002:a05:600c:5406:b0:404:74f8:f47c with SMTP id
 he6-20020a05600c540600b0040474f8f47cmr138103wmb.5.1699287662548; Mon, 06 Nov
 2023 08:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20231101212604.1636517-1-hsinyi@chromium.org> <20231101212604.1636517-4-hsinyi@chromium.org>
 <CAA8EJpoPMkQRhCD-9SPSheiio1dH8V6BUv89MZKfZdrBzsBW-w@mail.gmail.com>
 <CAD=FV=WHzCdiYumsxUm_am+ALqq9SOOrjf=JYHqJuiKFB+Dnsw@mail.gmail.com> <ze5xz52jt4helttcmntzmr6fr4ohu7wtslywalbxc4w7w6uvly@nwweqyyl4wf2>
In-Reply-To: <ze5xz52jt4helttcmntzmr6fr4ohu7wtslywalbxc4w7w6uvly@nwweqyyl4wf2>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Nov 2023 08:20:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U0sVSGEECFEOeNOEXty2UkO2-F7gK_FVhQ7MCsmn1Qkw@mail.gmail.com>
Message-ID: <CAD=FV=U0sVSGEECFEOeNOEXty2UkO2-F7gK_FVhQ7MCsmn1Qkw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/panel-edp: Choose correct preferred mode
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 6, 2023 at 12:06=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Thu, Nov 02, 2023 at 07:33:48AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Nov 1, 2023 at 11:31=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Wed, 1 Nov 2023 at 23:26, Hsin-Yi Wang <hsinyi@chromium.org> wrote=
:
> > > >
> > > > If a non generic edp-panel is under aux-bus, the mode read from edi=
d would
> > > > still be selected as preferred and results in multiple preferred mo=
des,
> > > > which is ambiguous.
> > > >
> > > > If a hard-coded mode is present, unset the preferred bit of the mod=
es read
> > > > from edid.
> > >
> > > Can we skip the EDID completely if the hardcoded override is present?
> >
> > Yeah, I wondered about that too. The blending of the hardcoded with
> > the EDID predates my involvement with the driver. You can see even as
> > of commit 280921de7241 ("drm/panel: Add simple panel support") that
> > the driver would start with the EDID modes (if it had them) and then
> > go onto add the hardcoded modes. At least for eDP panels, though,
> > nobody (or almost nobody?) actually provided panel-simple a DDC bus at
> > the same time it was given a hardcoded panel.
> >
> > I guess I could go either way, but I have a slight bias to adding the
> > extra modes and just making it clear to userspace that none of them
> > are "preferred". That seems like it would give userspace the most
> > flexibility
>
> I disagree. "Flexibility" here just means "the way to shoot itself in
> the foot without knowing it's aiming at its foot".
>
> If a mode is broken, we shouldn't expose it, just like we don't for all
> modes that require a maximum frequency higher than what the controller
> can provide on HDMI for example.

In this particular case we aren't saying that modes are broken. There
are two (somewhat separate) things in Hsin-Yi's series.

The first thing is a quirk for panels with incorrect modes in their
EDID when using the generic "edp-panel" compatible. In that case we
now _replace_ the broken mode with a more correct one because, as you
say, we shouldn't be telling userspace about a broken mode.

The second thing in Hsin-Yi's series is for when we're _not_ using the
generic "edp-panel". In that case we have a hardcoded mode from the
"compatible" string but we also have modes from the EDID and that's
what ${SUBJECT} patch is about. Here we don't truly know that the
modes in the EDID are broken.


> > and also is closer to what we've historically done (though,
> > historically, we just allowed there to be more than one "preferred"
> > mode).
>
> I have no idea what history you're referring to here

History =3D historical behavior? As above, I pointed out that the kernel
has been merging the hardcoded and EDID modes as far back as commit
280921de7241 ("drm/panel: Add simple panel support") in 2013.

That being said, the historical behavior has more than one mode marked
preferred which is bad, so we're changing the behavior anyway. I'm not
against changing it to just have the hardcoded mode if that's what
everyone else wants (and it sounds like it is).
