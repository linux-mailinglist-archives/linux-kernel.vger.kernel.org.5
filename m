Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F2B8110E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377507AbjLMMSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjLMMSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:18:40 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C82CD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:18:46 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-dbc72b692adso3609338276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702469926; x=1703074726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWh2TAmXbh0nz9apU3tkS8M7aheQ9d8T7G1VI3vxO7M=;
        b=lCTXiHGAEd2uw3ucP/Zso179Vu5/QbLV8D9iZqiDFaPErANlWhxV8oYkTzG3F77Boh
         8Azq3XXnJdDAG/cTnFzq6Kqk9PHvKlk6EmI6fc5oRnVGN7WPd8VvgKauQ2a/bWsld1Eg
         jusqfNucbcf5LKnsThIMVy2G7nVjZXsQUfwr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702469926; x=1703074726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWh2TAmXbh0nz9apU3tkS8M7aheQ9d8T7G1VI3vxO7M=;
        b=YzPaJJdn+Hwf+P+WAWgRqBHGCCM/CUAdEzAhYw4gd9cxSLOdtb9fL4uPUCkLY2rOBt
         wtnf5ywStuZ81KrQG+mPCQATTe7NxRFoSjQD4D4NqkiSDBaR/XnIO5YXpy1J3110txLY
         n7R+oSQcVbdIBToM0IAI1cmm4COJpuSwNbM/CYMPmaOPcvp0IM62fgRVkJd2qrLCbGpx
         59w++KenWaZFHpph3ETTkqOOLEFSba4KxEvnT8G364tXHJYJFgtZh4GvI3OD4F02BrRJ
         6UctCn4fbwxFa13eU9vTUsBCrtm1ULfyiyOnbC/XEyVwXPj1eNPHopI6fGIg9wsuB6T+
         8j3w==
X-Gm-Message-State: AOJu0YyP4jT8/BS851OVFnRw9PIXtO7eLyujz2wwwG1uLTgttjdPlB8R
        1oWvwGOEuK/oCGqUsJZAQCElPPihTPIfR+5IRQ6zPg==
X-Google-Smtp-Source: AGHT+IHRSVC8g3B8lYtUT1BmmUNibAhdEKjzXIv4l2Nn0+pVfN5TKMdrtjmbetU3VgJeCkdzdphWTs7NgCfnhTuirBk=
X-Received: by 2002:a25:2e04:0:b0:dbc:d342:4e77 with SMTP id
 u4-20020a252e04000000b00dbcd3424e77mr250667ybu.92.1702469925813; Wed, 13 Dec
 2023 04:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com> <170228617622.2409693.12899768447819855539.b4-ty@linaro.org>
In-Reply-To: <170228617622.2409693.12899768447819855539.b4-ty@linaro.org>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 13 Dec 2023 13:18:34 +0100
Message-ID: <CABGWkvp+40oCpajZKH8GDJq6qTD1g_+sVrcxHv6yHAxk4szXiw@mail.gmail.com>
Subject: Re: (subset) [PATCH v5 00/10] Add displays support for bsh-smm-s2/pro boards
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        David Airlie <airlied@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
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

Hi Neil,

On Mon, Dec 11, 2023 at 10:16=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On Thu, 07 Dec 2023 15:16:29 +0100, Dario Binacchi wrote:
> > The series adds drivers for the displays used by bsh-smm-s2/pro boards.
> > This required applying some patches to the samsung-dsim driver and the
> > drm_bridge.c module.
> >
> > Changes in v5:
> > - Replace a 'return ret' with a 'goto fail' in the r63353_panel_activat=
e()
> > - Add 'Reviewed-by' tag of Krzysztof Kozlowski
> >
> > [...]
>
> Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (=
drm-misc-next)
>
> [06/10] drm/panel: Add Synaptics R63353 panel driver
>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D2e87bad7cd=
339882cf26b7101a1c87dab71962c9
> [07/10] dt-bindings: display: panel: Add Ilitek ili9805 panel controller
>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D549240c98e=
50207244bc1ac182622b8daba89a89
> [08/10] drm/panel: Add Ilitek ILI9805 panel driver
>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3Dedbf1d506e=
be8c0857c406bd5d5b81d46ffd8437
> [09/10] drm/panel: ilitek-ili9805: add support for Tianma TM041XDHG01 pan=
el
>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3Db1fcb7ee37=
07290466b2cc4956325fb91f09f13b
>
> --
> Neil
>

I think you forgot the patch:
[05/10] dt-bindings: display: panel: Add synaptics r63353 panel controller

I received an email complaining about the lack of documentation for
the Synaptics panel.

Thanks and regards,
Dario

--

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
