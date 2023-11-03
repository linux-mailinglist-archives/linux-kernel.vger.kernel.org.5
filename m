Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503E07E094F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377009AbjKCTMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjKCTMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:12:16 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E31DBD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 12:12:10 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1f0820b7657so375386fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699038729; x=1699643529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqSGG3PRTCl3pCDwU0Cdv8eHz8EUQW+Q1dGS28H6GdE=;
        b=G3nVeqvpjVkqTwJDg1guutHHw3KlgCg2cH3ixjrckAbZI0xV53rjVAwkWH6SzICfGY
         bFw+OGgcUECIVbBPCpDAYJvYKMA0iMWDkpjt/wvGg+1uji7K5DRTT0YcRwc2zw17V8zm
         6Ccff6sygzedcOjAE6D2akFg5pqJLewXlyJBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699038729; x=1699643529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqSGG3PRTCl3pCDwU0Cdv8eHz8EUQW+Q1dGS28H6GdE=;
        b=nOf5jtgksxb4VXy/EvBwy/iYfOBAQmPMf4WRNsC0eSA+3IHgFQNi2p48JvygprtSKB
         1lye/cxOVvYhxjDgi8KWPWMg3t9v+UYY2tYCzGzX9h0mMAv9sbe5A9TLtSBV7pmc+IKu
         yjomq4RGuIp3e3OVVe5Dx5EaXjZukXqM39gCQrQq39fX+IZcP2nwGajY+SDYDTfnUKiJ
         hcb7WuCfUX9frdMRE6O4v0uQgrOk7m4AV+hif4WuAPUt20mT1ZpN6mqqB0pCfRjsqbzr
         5jKO3Or9L81hT9WaGRmJlLxmjpi3vNXAqsrqNflRxD3rA7a02BPPf/061iVVMOCHGXnc
         kIwA==
X-Gm-Message-State: AOJu0YwXWQWTHDfP98OGvAoi+GALhKifvDKre4llnV2x1hO91gxX4l0M
        o0XQqSLqf4bmvCVSk88V4QCPUE6iXE3LH7Oc30YzyA==
X-Google-Smtp-Source: AGHT+IGqbK/V1TFPWC+GZWHd8DsHefVvVcJBqIIffQ9V8MHnIqoMT1/bZZiL4fQUPgaB9pqcXAtmKZaWZU+GjbyLhGc=
X-Received: by 2002:a05:6870:4202:b0:1ea:7bd1:c48d with SMTP id
 u2-20020a056870420200b001ea7bd1c48dmr28837428oac.49.1699038729662; Fri, 03
 Nov 2023 12:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231102221309.1971910-1-hsinyi@chromium.org> <20231102221309.1971910-2-hsinyi@chromium.org>
 <CAD=FV=Unv+PtHd=QoFOgY_4tjxPGWeU7-hzp3YHfc2DjWu3wcQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Unv+PtHd=QoFOgY_4tjxPGWeU7-hzp3YHfc2DjWu3wcQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 3 Nov 2023 12:11:43 -0700
Message-ID: <CAJMQK-gpn+AWQQG9i=Oa2qvZ+9jJ1oVCFv7F7UpFFMco7C88Fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/panel-edp: Add several AUO/BOE panels
To:     Doug Anderson <dianders@chromium.org>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 9:02=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Thu, Nov 2, 2023 at 3:13=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org>=
 wrote:
> >
> > Add a few generic edp panels used by mt8186 chromebooks.
> > Besides, modify the following panel:
> > - AUO 0x235c B116XTN02 renamed to B116XTN02.3.
> > - AUO 0x405c B116XAK01 adjust the timing of auo_b116xak01. According
> > to the datasheet: T3=3D200, T12=3D500, T7_max =3D 50.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > v1->v2: Address comments: update delay for auo_b116xak01, sort entries.
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 57 +++++++++++++++++++++++++++++--
> >  1 file changed, 55 insertions(+), 2 deletions(-)
>
> This seems good to me now. I guess a tiny nit is that the ${SUBJECT}
> mentions AUO/BOE panels but a few other model panels are also added,
> but it's not a huge issue for me.
>
Yeah, it should be "drm/panel-edp: Add several generic edp panels",
the same as v1. If there are more comments that I need to send a v3,
I'll fix that in v3.


> Normally I apply patches to this table near-instantly, but since it's
> Friday and this touches a lot of panels, I'll probably wait until
> sometime next week.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
