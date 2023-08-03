Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697F876F45C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjHCU62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjHCU61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:58:27 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C0B1AB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:58:26 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d414540af6bso953576276.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691096305; x=1691701105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjlEpLtDWCaHQNzIvw/oWVXI8qmod6Vrc/lqAa0yowI=;
        b=Nso93zDPNd9CWURgtwFyh541rO0TyxlgyuXiyB0fEEnZVy5ZAY0tDaa7W8PLmPzE+n
         gT27euh6OiICUtZAuKZVgnAjzArG49TTON9Bj5BhaoPTDdfVR10nfaoTGqAvVIC0ULih
         k3K7XcxDHT8v5ElP5kMCoWcnZ4WnnZnGRb0Oewo1KZgNkx2tHoi3zma2gY3xFth8CWa8
         5xVrdJusxDwRRtC49EWWZ0wacy5Y+apZHnl93elCYPnxZ1P2EcnXrMbbWAGguZfkKzv/
         myp9kUH6XOSv1Uz8MwVt3lQlAOD0MPLaUvFr0ID//EjpFjtlZuYKEnbFDAUh2Ojc1MRA
         lLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691096305; x=1691701105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjlEpLtDWCaHQNzIvw/oWVXI8qmod6Vrc/lqAa0yowI=;
        b=lzUmaU6ljYTMeCce7jPgndIlCzR+e6ezzd6zjz/CDEWaJQdfr05n6LUt0GyPwuX7WJ
         wzM0iYNJZqge+GBQ4u+1V+wW/F3gRV9tRVwp/FEcZ8s8tahBKpPYUBEQh8d0MdmPNPIj
         zRYJYDRM3J7VpFtBj2emXIuPa4kM6sO/VzYsQQH5TCaAJ1GO8nioOlYVTatlqvLeAWS1
         OVN1t43VAnppgiCahvKV7jSKmOmTLH4PQ51i0HWREHNxjxwE/9q3iDi7ln930V7EUvzs
         yAhL0pF4m2m0DoudTH60nm2iCcFN2cFVVAn2wkhrK3+6FfOsbHwvKNeTDvczB2xmi7cS
         ZyFg==
X-Gm-Message-State: ABy/qLbsFykciFhhu3YBPUTwr1h+9VywWoSzhAh6nU9jKYbWhGfWXl7W
        iO8ztfVG0JcW0X5XxHZOSFkpt07AUIkhj0DvquWtqg==
X-Google-Smtp-Source: APBJJlGuzq0NckuzDre5BL3koRxawetNy79lFnqnqYa5pONMwFSUF1VrGzcKpqSgJGLFHDL//ysKWqTSE3Z8qR4tkqw=
X-Received: by 2002:a25:86ca:0:b0:d06:d1ae:dcf2 with SMTP id
 y10-20020a2586ca000000b00d06d1aedcf2mr15364225ybm.13.1691096305166; Thu, 03
 Aug 2023 13:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
 <20230729004913.215872-4-dmitry.baryshkov@linaro.org> <20230802185547.GC32500@pendragon.ideasonboard.com>
 <a32ce695-038f-0ef8-3584-5bd1ba528131@linaro.org> <20230802191351.GA1407@pendragon.ideasonboard.com>
 <DE2B4523-D16C-4AFC-8352-212B23548DD5@linaro.org> <b6oOVz2YMIG4hJDWhq9lTh6R2HYcrpRwHENhplig9KSQMD8dIjTgC5KdH1Ij3URgV2HESp67Ax7QUsByGjMLouvbs-5q7PiPRdLkgJz6Fwk=@emersion.fr>
 <ADjuOeqA6575DKutMPaR9mW9rLhm-wjLc4ruoUkNwImf-GB90FdwDB7v7y6LFdzVG3BC4R52A0RUtStK4_smmGYTUs3UPDOX4T4Zl2YHkxE=@emersion.fr>
 <20230803204459.GD27752@pendragon.ideasonboard.com> <TR8IBdXbd0C4U8Z4zf9ZLEH66QMutWs0QAAkPnMlKiOvgEZCk6AfEIPcIfRC555XWs8eSzeCCCW9R-3NwxZg6hDhPvPseAgAULAdUQ6epDA=@emersion.fr>
In-Reply-To: <TR8IBdXbd0C4U8Z4zf9ZLEH66QMutWs0QAAkPnMlKiOvgEZCk6AfEIPcIfRC555XWs8eSzeCCCW9R-3NwxZg6hDhPvPseAgAULAdUQ6epDA=@emersion.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 3 Aug 2023 23:57:27 +0300
Message-ID: <CAA8EJpo_HKMFya-OTVFK9hK6RTzWqZyVS-1u230eXM1XW5N24Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/uapi: document the USB subconnector type
To:     Simon Ser <contact@emersion.fr>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Janne Grunau <j@jannau.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 at 23:47, Simon Ser <contact@emersion.fr> wrote:
>
> On Thursday, August 3rd, 2023 at 22:44, Laurent Pinchart <laurent.pinchar=
t@ideasonboard.com> wrote:
>
> > On Thu, Aug 03, 2023 at 03:31:16PM +0000, Simon Ser wrote:
> >
> > > On Thursday, August 3rd, 2023 at 17:22, Simon Ser contact@emersion.fr=
 wrote:
> > >
> > > > The KMS docs describe "subconnector" to be defined as "downstream p=
ort" for DP.
> > > > Can USB-C (or USB) be seen as a DP downstream port?
> > >
> > > To expand on this a bit: I'm wondering if we're mixing apples and
> > > oranges here. The current values of "subconnector" typically describe
> > > the lower-level protocol tunneled inside DP. For instance, VGA can be
> > > tunneled inside the DP cable when using DP =E2=86=92 VGA adapter.
> >
> > Doesn't this contradict the example use case you gave in your previous
> > e-mail, with wlroots stating "DP-3 via DVI-D" ? I understand that as DP
> > carried over a DVI-D physical connector, did I get it wrong ?
>
> No, this is DVI carried over DP. DP cannot be carried over VGA/DVI/HDMI,
> but VGA/DVI/HDMI can be carried over DP.

Well, not quite. It means that the sink (display) connected to this
port identifies itself as an VGA / DVI / HDMI monitor.
E.g. on if connect HDMI/DVI monitor through the DP-DVI dongle (native
DP connector), AMD driver still identifies it as 'subconnector HDMI',
despite dongle a DVI connector on the other side.

--=20
With best wishes
Dmitry
