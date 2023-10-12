Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A8F7C735E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379554AbjJLQpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344038AbjJLQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:45:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B01C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:45:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b95622c620so211360566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697129123; x=1697733923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XB7Wf5LgsYf36+k+zhs9TduHabjcJcCiXT3QAGky0tQ=;
        b=PQXg8gaPH0o714Os32OyWfzyCYiyDCtxPyzicgHC20w0Nt9ap5iiuNZ3Ts2VL1M8Y3
         S5zQeHzgLQBqzJAdHU472H7KTWqJ0bAKiZNRDyYs4kQlOgosMsBJq6jSEQqbezrFktkn
         rPQzoCKSCiVhZeOaN9DrynQLGfqllnb+psJe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129123; x=1697733923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XB7Wf5LgsYf36+k+zhs9TduHabjcJcCiXT3QAGky0tQ=;
        b=asn2PXCkQOrL2RFpWEgp7Zk48dSDO+g5OZZ27xp+/7xvboUXOdUfXoPGBF6pRA0y47
         75GKe2b1W7Qzr/KeraPtlLEpuU3QA6dt2YcFC+vORp3RQr9lR9TK+GCZSay4ux85jTDz
         ZFfLaKty5NZwyp5MPzzhn0jOjH6SMB8VbYF2qqgKMs14mG1JL9IurlT7FM1LkuNt0kyY
         UVLxwQilNLLvl7cBNoCbQMWCCrdr4mMi/DDaxOHgT0mjdkUZvRDIfCjncjO4wMMh2ysi
         rNxbI8G5feYJS9QyDAuZshYC35d2g3/6SpgBawbbusgISdkEW1Y5AJvm4GyLAa0u0omJ
         6QDg==
X-Gm-Message-State: AOJu0YyoDL6bCBZ6jcaIrjatxF7igaslxDTSw4br/m3l8Hgcc1LXMXAO
        CDwxUBQdKQS3QJE98zQYfBvVUyDAb4FhYyutH8U73A==
X-Google-Smtp-Source: AGHT+IHFtP+jrJQW1shxQiHRlMJh8oJKDgACFbx+6EICXMex0nzO4fNt+ya6T+DBVRHjZ8dLziZFVg==
X-Received: by 2002:a17:906:23e2:b0:9ad:7d5c:3d4b with SMTP id j2-20020a17090623e200b009ad7d5c3d4bmr19643471ejg.35.1697129122945;
        Thu, 12 Oct 2023 09:45:22 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id z9-20020a170906240900b009b2b7333c8bsm11133908eja.81.2023.10.12.09.45.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 09:45:22 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-405459d9a96so1995e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:45:22 -0700 (PDT)
X-Received: by 2002:a05:600c:3c96:b0:3f6:f4b:d4a6 with SMTP id
 bg22-20020a05600c3c9600b003f60f4bd4a6mr262956wmb.7.1697129121865; Thu, 12 Oct
 2023 09:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230925150010.1.Iff672233861bcc4cf25a7ad0a81308adc3bda8a4@changeid>
 <b0037c9f-588b-4eb8-6415-0fe75bed264f@collabora.com> <CAD=FV=UWQgLLfU4X+6OUR5AWOkJKwG9J7BbKGRCgze6LTY6JNw@mail.gmail.com>
 <CAD=FV=UqG6DiAyjcLKeoUWKutepGd46Zx=8O-NWKoYC-fZEG6g@mail.gmail.com> <c3380c97-1b8c-5a68-168e-fc6150701365@postmarketos.org>
In-Reply-To: <c3380c97-1b8c-5a68-168e-fc6150701365@postmarketos.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Oct 2023 09:45:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WAYYv5h6oWWhEJHyZesE5cguBqVufCmK6s4gvMeNkCWg@mail.gmail.com>
Message-ID: <CAD=FV=WAYYv5h6oWWhEJHyZesE5cguBqVufCmK6s4gvMeNkCWg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Move AUX B116XW03 out of panel-edp back to panel-simple
To:     Anton Bambura <jenneron@postmarketos.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>, airlied@gmail.com,
        daniel@ffwll.ch, jitao.shi@mediatek.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        quic_jesszhan@quicinc.com, sam@ravnborg.org,
        Anton Bambura <jenneron@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 8, 2023 at 1:52=E2=80=AFPM Anton Bambura <jenneron@postmarketos=
.org> wrote:
>
>
> On 10/5/23 21:10, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Sep 26, 2023 at 7:01=E2=80=AFAM Doug Anderson <dianders@chromiu=
m.org> wrote:
> >> Hi,
> >>
> >> On Tue, Sep 26, 2023 at 1:06=E2=80=AFAM AngeloGioacchino Del Regno
> >> <angelogioacchino.delregno@collabora.com> wrote:
> >>> Il 26/09/23 00:00, Douglas Anderson ha scritto:
> >>>> In commit 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of
> >>>> panel-simple") I moved a pile of panels out of panel-simple driver
> >>>> into the newly created panel-edp driver. One of those panels, howeve=
r,
> >>>> shouldn't have been moved.
> >>>>
> >>>> As is clear from commit e35e305eff0f ("drm/panel: simple: Add AUO
> >>>> B116XW03 panel support"), AUX B116XW03 is an LVDS panel. It's used i=
n
> >>>> exynos5250-snow and exynos5420-peach-pit where it's clear that the
> >>>> panel is hooked up with LVDS. Furthermore, searching for datasheets =
I
> >>>> found one that makes it clear that this panel is LVDS.
> >>>>
> >>>> As far as I can tell, I got confused because in commit 88d3457ceb82
> >>>> ("drm/panel: auo,b116xw03: fix flash backlight when power on") Jitao
> >>>> Shi added "DRM_MODE_CONNECTOR_eDP". That seems wrong. Looking at the
> >>>> downstream ChromeOS trees, it seems like some Mediatek boards are
> >>>> using a panel that they call "auo,b116xw03" that's an eDP panel. The
> >>>> best I can guess is that they actually have a different panel that h=
as
> >>>> similar timing. If so then the proper panel should be used or they
> >>>> should switch to the generic "edp-panel" compatible.
> >>>>
> >>>> When moving this back to panel-edp, I wasn't sure what to use for
> >>>> .bus_flags and .bus_format and whether to add the extra "enable" del=
ay
> >>>> from commit 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash
> >>>> backlight when power on"). I've added formats/flags/delays based on =
my
> >>>> (inexpert) analysis of the datasheet. These are untested.
> >>>>
> >>>> NOTE: if/when this is backported to stable, we might run into some
> >>>> trouble. Specifically, before 474c162878ba ("arm64: dts: mt8183:
> >>>> jacuzzi: Move panel under aux-bus") this panel was used by
> >>>> "mt8183-kukui-jacuzzi", which assumed it was an eDP panel. I don't
> >>>> know what to suggest for that other than someone making up a bogus
> >>>> panel for jacuzzi that's just for the stable channel.
> >>>>
> >>>> Fixes: 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash backlight w=
hen power on")
> >>>> Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-s=
imple")
> >>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>>> ---
> >>>> I haven't had a snow or peach-pit hooked up for debugging / testing
> >>>> for years. I presume that they must be broken and hope that this fix=
es
> >>>> them.
> >>> We could avoid backport breakages by avoiding to backport this to any=
 kernel
> >>> that doesn't contain commit 474c162878ba ("arm64: dts: mt8183: jacuzz=
i: Move
> >>> panel under aux-bus")... because creating a dummy panel to get two wr=
ongs
> >>> right is definitely not ok.
> >> Sure, except that leaves us with ... a breakage. :-P
> >>
> >> Although I haven't tested it, I have a hard time believing that
> >> exynos5250-snow and exynos5420-peach-pit will work properly with the
> >> panel defined as an eDP panel. That means that they will be broken. If
> >> someone cared to get those fixed in a stable backport then we'd be
> >> stuck deciding who to break. If you have any brilliant ideas then I'm
> >> all ears.
> >>
> >> ...then again, I presume this has been broken since commit
> >> 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash backlight when power
> >> on"). That was a little over 3 years ago. Maybe I'm wrong and somehow
> >> things still limp along and sorta work even though the panel is
> >> defined incorrectly?
> > I dug out a exynos5250-snow out of my pile and booted postmarket OS on
> > it, which was shockingly easy/pleasant (kudos to those involved!). I
> > found that it was booting a kernel based on 6.1.24. Digging into
> > sysfs, I found that indeed it appeared to be using the "panel-edp"
> > driver, so I guess it is limping along with the wrong driver and wrong
> > flags...
> >
> > It wasn't totally clear for me how to build a new kernel and deploy it
> > for postmarket OS, so I wasn't able to confirm this change. I've CCed
> > the person listed on the postmarket OS wiki though to see if they have
> > any insight.
> Tested it on peach-pit using linux-next with this patch applied. Panel
> still works and "dmesg | grep panel" returns panel_simple instead of
> panel_edp.
>
> Tested-by: Anton Bambura <jenneron@postmarketos.org>

Pushed to drm-misc-fixes:

ad3e33fe071d drm/panel: Move AUX B116XW03 out of panel-edp back to panel-si=
mple

-Doug
