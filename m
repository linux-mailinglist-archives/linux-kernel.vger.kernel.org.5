Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633C47D2CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjJWIk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjJWIk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:40:56 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203C9DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:40:54 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a877e0f0d8so32516647b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698050453; x=1698655253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaL68/qeer0rqmvgi8CDg0bYTQpez2jRXyNtczwGTGY=;
        b=Jny/V4UoH7SF3JDIHj7MqWIKiwOqRhCGexce7aV4xy3KzRlaKj5eknJuN/HK3+PlKK
         GGyvmtVzq14jzCwg1SzOJgg2ESPBXi5PTs5mBlzJ5p2wRrCdALTeJYsR2kefIWZRjQNE
         lsKKZYu0aZeiCOlg9SEMmCGkfz84ExBZAJrcVIzDHCLn0t8tLu1gPbvv+q/16xzeEWBw
         kkt0WPGNjbriX/gAikju93pQm6sVbLM6ICjLWN3a5aZyte+M7e0j0b+JGVT2wmOanuTH
         dpsqIldsg9TUdyuRH19LAXmD5dfO1QLliZ9JmCoJWIuMSL23ygHl3Ut6CiJvDsPwbEY0
         3fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698050453; x=1698655253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaL68/qeer0rqmvgi8CDg0bYTQpez2jRXyNtczwGTGY=;
        b=BlcQqc+gOb18epf03l8D0+crtxKTRIrkA1cN+ts09weLy117e7ZP4mBJIEHwrVpotR
         P7sJoYezCDOQBInlm+rZwy7COFZk7w1HXfuh88W7wj3czwIo+53I00idvaHWgGL/sb1j
         CKkig7RWfcAgUmLYswf0u882YL0jUkNSh5/MUb3p6vSMLoTBhqRfjtSPwGZBihGX03Jq
         yiMLveyw+DxtZSS+48Zq9Ju9QJKac+OBerQl+/h9qVQyIyPo9n5bC6hP+GxRyrHwEeoK
         5wD6joCgj99hHFncWl1XgeebSqiu/0aXns6hcOjT+rB88JQkA0HPTp8H0eiS94qsLqJ2
         geNA==
X-Gm-Message-State: AOJu0YzvXjtqDN5cYE0IcWOMCtcCVf6WIoaKZpt5u9nT21Ab4526pt+g
        mlFzi7z+SoBKUlB0XcuV3jolFTDypVOwOAQ9+sDAvg==
X-Google-Smtp-Source: AGHT+IGAkh/c3GbWNcWRXLTZ32eNfXArR9TC3Fd+iqsnvwbLzueIKhgdFmlb34ugIHWdJbPKSIqmrLsbZYsECiGgkW4=
X-Received: by 2002:a0d:d6c2:0:b0:5a7:fcad:e865 with SMTP id
 y185-20020a0dd6c2000000b005a7fcade865mr11281424ywd.2.1698050453310; Mon, 23
 Oct 2023 01:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
 <1871104.tdWV9SEqCh@steina-w> <CAA8EJpofiawC5z3jw1-TsxS+ZWz4QobCby3kScDDdk9Z-74mgQ@mail.gmail.com>
 <3266380.44csPzL39Z@steina-w>
In-Reply-To: <3266380.44csPzL39Z@steina-w>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 23 Oct 2023 11:40:42 +0300
Message-ID: <CAA8EJpoF+r6a9cAnW0uT_YgBi=oC1dw9JYShau8ji-sR71iUxw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Marek Vasut <marex@denx.de>, Robert Foss <rfoss@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 at 11:14, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Am Montag, 23. Oktober 2023, 09:34:42 CEST schrieb Dmitry Baryshkov:
> > On Mon, 23 Oct 2023 at 09:52, Alexander Stein
> >
> > <alexander.stein@ew.tq-group.com> wrote:
> > > Hi Dmitry,
> > >
> > > Am Sonntag, 22. Oktober 2023, 12:49:41 CEST schrieb Dmitry Baryshkov:
> > > > On Thu, 19 Oct 2023 at 14:42, Alexander Stein
> > > >
> > > > <alexander.stein@ew.tq-group.com> wrote:
> > > > > Hi,
> > > > >
> > > > > Am Donnerstag, 19. Oktober 2023, 13:19:51 CEST schrieb Dmitry
> Baryshkov:
> > > > > > On Thu, 19 Oct 2023 at 12:26, Maxime Ripard <mripard@kernel.org=
>
> wrote:
> > > > > > > On Mon, Oct 16, 2023 at 07:53:48PM +0300, Dmitry Baryshkov wr=
ote:
> > > > > > > > The MIPI DSI links do not fully fall into the DRM callbacks
> > > > > > > > model.
> > > > > > >
> > > > > > > Explaining why would help
> > > > > >
> > > > > > A kind of explanation comes afterwards, but probably I should c=
hange
> > > > > > the order of the phrases and expand it:
> > > > > >
> > > > > > The atomic_pre_enable / atomic_enable and correspondingly
> > > > > > atomic_disable / atomic_post_disable expect that the bridge lin=
ks
> > > > > > follow a simple paradigm: either it is off, or it is on and
> > > > > > streaming
> > > > > > video. Thus, it is fine to just enable the link at the enable t=
ime,
> > > > > > doing some preparations during the pre_enable.
> > > > > >
> > > > > > But then it causes several issues with DSI. First, some of the =
DSI
> > > > > > bridges and most of the DSI panels would like to send commands =
over
> > > > > > the DSI link to setup the device. Next, some of the DSI hosts h=
ave
> > > > > > limitations on sending the commands. The proverbial sunxi DSI h=
ost
> > > > > > can
> > > > > > not send DSI commands after the video stream has started. Thus =
most
> > > > > > of
> > > > > > the panels have opted to send all DSI commands from pre_enable =
(or
> > > > > > prepare) callback (before the video stream has started).
> > > > > >
> > > > > > However this leaves no good place for the DSI host to power up =
the
> > > > > > DSI
> > > > > > link. By default the host's pre_enable callback is called after=
 the
> > > > > > DSI bridge's pre_enable. For quite some time we were powering u=
p the
> > > > > > DSI link from mode_set. This doesn't look fully correct. And al=
so we
> > > > > > got into the issue with ps8640 bridge, which requires for the D=
SI
> > > > > > link
> > > > > > to be quiet / unpowered at the bridge's reset time.
> > > > >
> > > > > There are also bridges (e.g. tc358767) which require DSI-LP11 upo=
n
> > > > > bridge
> > > > > reset. And additionally this DSI-(e)DP bridge requires LP11 while
> > > > > accessing
> > > > > DP-AUX channel, e.g. reading EDID. So bridges need at least some
> > > > > control
> > > > > over DSI line state.
> > > >
> > > > For sending commands in LP11 it is typical to toggle the
> > > > MIPI_DSI_MODE_LPM flag, for example see panel-=3Djdi-lt070me05000.c=
 or
> > > > some other drives. It might be a good idea to make that more explic=
it.
> > > > All suggestions here would be appreciated.
> > >
> > > The biggest difference between that display and the tc358767 bridge i=
s
> > > that
> > > the display uses DSI commands, while the bridge is using i2c transfer=
 to
> > > issue DP-AUX commands. There is no host_transfer [1] which would enab=
le
> > > LP-11. It seems this DSI-DP bridge requires LP-11/HS on DSI lanes all
> > > times. This contradicts current Linux behaviour.
> >
> > I see. I took a quick glance at the driver. Does the device mark AUX
> > as busy when there is a HS transfer?
> > Because otherwise it might be pretty hard to synchronise DP-AUX
> > transfers with the DSI link state. We might need to add an API for
> > this, if the DSI hosts actually can signal the blanking / DSI LP.
>
> I don't see that a synchronization would be required. AUX should be
> independent from DSI transfers. ASFAICS the bridge internals just require=
s DSI
> lines to be LP-00 or HS for AUX channel to be functioning.

Ah, LP or HS. Then it should be fine. I probably misread your original
email. I thought that AUX transfers work only in the LP mode.

>
> >
> > Side note: the driver needs some care. It doesn't support the aux-bus
> > bindings for eDP panels, it doesn't support other bridges on top of DP
> > connectors (but there can be e..g. dp-connector device).
>
> I don't think that this is necessary as you add an optional endpoint to p=
ort2
> which will then add an eDP display panel bridge. This should then handle =
aux-
> bus bindings.

Not quite, see Documentation/devicetree/bindings/display/dp-aux-bus.yaml
and devm_of_dp_aux_populate_bus().

It is expected that eDP panels are to be placed under the edp_bridge /
aux-bus device node. But this is a separate topic, I just wanted to
point out other missing pieces.

>
> Best regards,
> Alexander
>
> > > Best regards,
> > > Alexander
> > >
> > > [1]
> > > https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html#mipi-=
dsi-> > bridge-operation
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>


--=20
With best wishes
Dmitry
