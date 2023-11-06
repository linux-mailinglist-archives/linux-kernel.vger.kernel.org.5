Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6CC7E2D13
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjKFTks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjKFTkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:40:32 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E343210EC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:39:40 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce2b6b3cb6so3187496a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699299580; x=1699904380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLjTTp2u01IElZGHml90XkiK04GyI0lhbaUbWi23A5s=;
        b=mcoF9QvQxOlafc8+y0gD5eocqr/jpT6TBj3bCMeC+5gXgIrDxELH60E/Lc9Uc4kImD
         XzR9SfF175WO572Kce0A0bl+zVdBMtJM5j33nEwiNX6aP8EurmujsWidrik1ZxmWZOlr
         kkx2KDDzwn64BUY9ry2ea8GHA1AIlQlHr0viM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299580; x=1699904380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLjTTp2u01IElZGHml90XkiK04GyI0lhbaUbWi23A5s=;
        b=QSHkNbg6BEHzb/6POihHBW+QR2142I7aohNajUJx/J1AiNftr8WjlNcmHP4LVhYyz1
         Br6tyH+mXRUDojB5+6AttoSZueBgz8o86GvvdRpR7ceYwZmWjy9dMg5a0f3fes3Y+vbd
         GcVCm5GLqSeJs8b39OXrBYBfGm/J0XRoVLFJovXPByqwhK6iq3TplCF+xv/S1Rtn+Jwl
         d9z8OjwPuVXVOVs18kyLwklUU6ovuItEFYDb3SBdmf9yDYctTdGvCpDO/2eJLbbSmKkn
         bblPRujXe5Ku4G20At5F4IwSI+g7pnjyn6v85MfwBuZJUsTHtL/ao6hANqJaLrFi34uQ
         lAFw==
X-Gm-Message-State: AOJu0YzNtcItai+o0CffmJMHqsvyN+ziJc2gAdHyOuurqxkJqXpEKSgx
        5TcYeGBeZcDUV/f+zKjC3yxT/dPdHr1UuogWYqhvDQ==
X-Google-Smtp-Source: AGHT+IFKDR9uQHvB7VJxnRv/VD1p/NKzbbk+zvXjVN9+dYZu9QefNjkgF45opouqp4IHkywBd23awpIsOMNE5WdXBO4=
X-Received: by 2002:a05:6830:3105:b0:6bc:c542:6f75 with SMTP id
 b5-20020a056830310500b006bcc5426f75mr42805371ots.0.1699299580218; Mon, 06 Nov
 2023 11:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20231101212604.1636517-1-hsinyi@chromium.org> <20231101212604.1636517-4-hsinyi@chromium.org>
 <CAA8EJpoPMkQRhCD-9SPSheiio1dH8V6BUv89MZKfZdrBzsBW-w@mail.gmail.com>
 <CAD=FV=WHzCdiYumsxUm_am+ALqq9SOOrjf=JYHqJuiKFB+Dnsw@mail.gmail.com>
 <ze5xz52jt4helttcmntzmr6fr4ohu7wtslywalbxc4w7w6uvly@nwweqyyl4wf2> <CAD=FV=U0sVSGEECFEOeNOEXty2UkO2-F7gK_FVhQ7MCsmn1Qkw@mail.gmail.com>
In-Reply-To: <CAD=FV=U0sVSGEECFEOeNOEXty2UkO2-F7gK_FVhQ7MCsmn1Qkw@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 6 Nov 2023 11:39:14 -0800
Message-ID: <CAJMQK-jFca51-wDCDgb-+mcJpbV2DmX04dxvaG6Xg+p5e2X8kg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/panel-edp: Choose correct preferred mode
To:     Doug Anderson <dianders@chromium.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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

On Mon, Nov 6, 2023 at 8:21=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Mon, Nov 6, 2023 at 12:06=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> >
> > On Thu, Nov 02, 2023 at 07:33:48AM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Wed, Nov 1, 2023 at 11:31=E2=80=AFPM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On Wed, 1 Nov 2023 at 23:26, Hsin-Yi Wang <hsinyi@chromium.org> wro=
te:
> > > > >
> > > > > If a non generic edp-panel is under aux-bus, the mode read from e=
did would
> > > > > still be selected as preferred and results in multiple preferred =
modes,
> > > > > which is ambiguous.
> > > > >
> > > > > If a hard-coded mode is present, unset the preferred bit of the m=
odes read
> > > > > from edid.
> > > >
> > > > Can we skip the EDID completely if the hardcoded override is presen=
t?
> > >
> > > Yeah, I wondered about that too. The blending of the hardcoded with
> > > the EDID predates my involvement with the driver. You can see even as
> > > of commit 280921de7241 ("drm/panel: Add simple panel support") that
> > > the driver would start with the EDID modes (if it had them) and then
> > > go onto add the hardcoded modes. At least for eDP panels, though,
> > > nobody (or almost nobody?) actually provided panel-simple a DDC bus a=
t
> > > the same time it was given a hardcoded panel.
> > >
> > > I guess I could go either way, but I have a slight bias to adding the
> > > extra modes and just making it clear to userspace that none of them
> > > are "preferred". That seems like it would give userspace the most
> > > flexibility
> >
> > I disagree. "Flexibility" here just means "the way to shoot itself in
> > the foot without knowing it's aiming at its foot".
> >
> > If a mode is broken, we shouldn't expose it, just like we don't for all
> > modes that require a maximum frequency higher than what the controller
> > can provide on HDMI for example.
>
> In this particular case we aren't saying that modes are broken. There
> are two (somewhat separate) things in Hsin-Yi's series.
>
> The first thing is a quirk for panels with incorrect modes in their
> EDID when using the generic "edp-panel" compatible. In that case we
> now _replace_ the broken mode with a more correct one because, as you
> say, we shouldn't be telling userspace about a broken mode.
>
> The second thing in Hsin-Yi's series is for when we're _not_ using the
> generic "edp-panel". In that case we have a hardcoded mode from the
> "compatible" string but we also have modes from the EDID and that's
> what ${SUBJECT} patch is about. Here we don't truly know that the
> modes in the EDID are broken.
>
>
> > > and also is closer to what we've historically done (though,
> > > historically, we just allowed there to be more than one "preferred"
> > > mode).
> >
> > I have no idea what history you're referring to here
>
> History =3D historical behavior? As above, I pointed out that the kernel
> has been merging the hardcoded and EDID modes as far back as commit
> 280921de7241 ("drm/panel: Add simple panel support") in 2013.
>
> That being said, the historical behavior has more than one mode marked
> preferred which is bad, so we're changing the behavior anyway. I'm not
> against changing it to just have the hardcoded mode if that's what
> everyone else wants (and it sounds like it is).

I'll change the behavior to: if hard-coded mode presents, don't add
edid mode since it will result in multiple preferred modes.
