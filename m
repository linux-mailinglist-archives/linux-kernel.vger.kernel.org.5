Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD52C80911A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjLGTOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjLGTOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:14:53 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4E11703
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:14:58 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bf1e32571so1283365e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 11:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701976494; x=1702581294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge3Rk2B21QhsOmEMG5m3LjdIZh1PEMQWoh/W4fwv0Lg=;
        b=Q1CMkJ5g+RL6PTVwgb5QQufZqdsWNmzQRQiazGtIlHHlgdoSK6C5GRPqG1XK7lXfLA
         b6Cu0ZT8BtZLHtRfrL+hJeixp8zNopGohdt+5gB8L0yisP0DIeW1WTZ7WoXe94LTmBem
         Lnq+W+BwpqQpwhok2gGNlW/xXEKmsO/SGCsHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701976494; x=1702581294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge3Rk2B21QhsOmEMG5m3LjdIZh1PEMQWoh/W4fwv0Lg=;
        b=twQlmX563Tb0DBKHn70BLOFiykwcPtHyn8neLPZZpxq9VPuo3heujm8sJlZO0P8iz1
         215WcLBtN2gL9mCPeSsqTYBsv1TE/+w5lwcWuisqCQ0vVQ5VB4CH4hvL/VYCQsQaiOJA
         2gB138ZLC0BsQNZiUN3gNZTcoTkQaetzgrNOgNlJbISXGWfOnwPn3JuYnRdi7N5rqHhb
         vZEnR+z+s+SfxC/xRVlEtOl5Tgmn1CmxX9J7c9JUIIc1P6XP0tQYo14inpomM0hvlTAb
         HYKohohlI4pmlNQW+YyLke8bCzTjTTPWOOCo1RsUlCUnU+R56Wp2dFxEHhM1SFLOcM5e
         ugWQ==
X-Gm-Message-State: AOJu0YxWCPbDdUzrSBXAwiuIkCACklRLB6vrZ0i/VOaGfJ9JQjLwj+ZH
        dxtnibfE5MmG5csi3nh5x80cG5/KBN+s3JIhcFOrSQ==
X-Google-Smtp-Source: AGHT+IFJy6xpHhqulbatIdYKILT179oDkTUOJk3yt67sTK+BbnpP6X3cCbbsuAqxYfTmfthzrpRouA==
X-Received: by 2002:ac2:4428:0:b0:50b:efd4:1475 with SMTP id w8-20020ac24428000000b0050befd41475mr1724314lfl.9.1701976493719;
        Thu, 07 Dec 2023 11:14:53 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id cw15-20020a170907160f00b00a1937153bddsm103764ejd.20.2023.12.07.11.14.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:14:53 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so8935e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 11:14:53 -0800 (PST)
X-Received: by 2002:a05:600c:364b:b0:40c:1e46:508e with SMTP id
 y11-20020a05600c364b00b0040c1e46508emr8036wmq.0.1701976492706; Thu, 07 Dec
 2023 11:14:52 -0800 (PST)
MIME-Version: 1.0
References: <20231207081801.4049075-1-treapking@chromium.org>
 <20231207081801.4049075-5-treapking@chromium.org> <CAD=FV=U6M5rpQXmjC+iGf0BGtiyjRAAcMfo4Fr3pDyYVp3m4aQ@mail.gmail.com>
 <fctpvshu5ychxketsf35jfg2qzi6i3nfup5hy7r7hzmmbpd2j4@xmsik3cycjlj>
In-Reply-To: <fctpvshu5ychxketsf35jfg2qzi6i3nfup5hy7r7hzmmbpd2j4@xmsik3cycjlj>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Dec 2023 11:14:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V=K9L=bJiNvFJ+K_DHUTPxA4WtukXA+E_VW6uihE8kdQ@mail.gmail.com>
Message-ID: <CAD=FV=V=K9L=bJiNvFJ+K_DHUTPxA4WtukXA+E_VW6uihE8kdQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/panel-edp: Add some panels with conservative timings
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org
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

On Thu, Dec 7, 2023 at 10:58=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Thu, Dec 07, 2023 at 10:23:53AM -0800, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Dec 7, 2023 at 12:18=E2=80=AFAM Pin-yen Lin <treapking@chromium=
.org> wrote:
> > >
> > > These panels are used by Mediatek MT8173 Chromebooks but we can't fin=
d
> > > the corresponding data sheets, and these panels used to work on v4.19
> > > kernel without any specified delays.
> > >
> > > Therefore, instead of having them use the default conservative timing=
s,
> > > update them with less-conservative timings from other panels of the s=
ame
> > > vendor. The panels should still work under those timings, and we can
> > > save some delays and suppress the warnings.
> > >
> > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > >
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  drivers/gpu/drm/panel/panel-edp.c | 31 +++++++++++++++++++++++++++++=
++
> > >  1 file changed, 31 insertions(+)
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > Repeating my comments from v1 here too, since I expect this patch to
> > sit on the lists for a little while:
> >
> >
> > This is OK w/ me, but it will need time on the mailing lists before
> > landing in case anyone else has opinions.
>
> Generally speaking, I'm not really a fan of big patches that dump
> whatever ChromeOS is doing ...
>
> > Specifical thoughts:
> >
> > * I at least feel fairly confident that this is OK since these panels
> > essentially booted without _any_ delays back on the old downstream
> > v4.19 kernel. Presumably the panels just had fairly robust timing
> > controllers and so worked OK, but it's better to get the timing more
> > correct.
>
> ... especially since you have to rely on the recollection of engineers
> involved at the time and you have no real way to test and make things
> clearer anymore, and we have to take patches in that are handwavy "trust
> us, it's doing the right thing".
>
> I'd really prefer to have these patches sent as they are found out.

It's probably not clear enough from the commit message, but this isn't
just a dump from downstream 4.19. What happened was:

1. Downstream chromeos-4.19 used the "little white lie" approach. They
all claimed a specific panel's compatible string even though there
were a whole pile of panels out there actually being used. Personally,
this was not something I was ever a fan of (and I wasn't personally
involved in this project), but it was the "state of the art" before
the generic panel-edp. Getting out of the "little white lie" situation
was why I spent so much time on the generic edp-panel solution
upstream.

2. These devices have now been uprevved to a newer kernel and I
believe that there were issues seen that necessitated a move to the
proper generic panel-edp code.

3. We are now getting field reports from our warning collector about a
whole pile of panels that are falling back to the "conservative"
timings, which means that they turn on/off much more slowly than they
should.

Pin-yen made an attempt to search for panels data sheets that matched
up with the IDs that came in from the field reports but there were
some panels that he just couldn't find.

So basically we're stuck. Options:

1. Leave customers who have these panels stuck with the hardware
behaving worse than it used to. This is not acceptable to me.

2. Land Pin-yen's patch as a downstream-only patch in ChromeOS. This
would solve the problem, but it would make me sad. If anyone ever
wants to take these old laptops and run some other Linux distribution
on them (and there are several that target old Chromebooks) then
they'd be again stuck with old timings.

3. Land a patch like this one that at least gets us into not such a bad sha=
pe.

While I don't love this patch (and that's why I made it clear that it
needs to spend time on the list), it seems better than the
alternatives. Do you have a proposal for something else? If not, can
you confirm you're OK with #3 given this explanation? ...and perhaps
more details in the commit message?


I would also note that, hopefully, patches like this shouldn't be a
recurring pattern. Any new Chromebooks using panel-edp will get
flagged much earlier and we should be able to get real/proper timings
added. I believe that we've also added a factory test so that
(assuming it doesn't get ignored by someone) devices that aren't
supported don't even make it out of the factory.

> Also, the fact that the 4.19 kernel mentionned in the commit log is
> actually a downstream tree needs to be made much clearer.

Yeah, that would help too.
