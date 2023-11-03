Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6B27E0611
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345127AbjKCQCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344868AbjKCQCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:02:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B7AD50
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 09:02:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c2a0725825so344313966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699027340; x=1699632140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ol6GV8EiIMu1rs0jqnxJjaaICGPgFzAznUYX0oUGW0=;
        b=SvjBP+lmXesO2uR4ZH03jAE6E5LW/UHusW0l9+HSWAvELEatqdBZ/THST7hTlLFiVH
         USkGA43Wd25JQvem5KTSZJlanyAOBjXzOGY3X56H5x8ybDXRV4J3htn8cs/skjfoYN6Q
         CP1ahDeS3+uUPqSueo+u0oOinByFq4XJWcWyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699027340; x=1699632140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ol6GV8EiIMu1rs0jqnxJjaaICGPgFzAznUYX0oUGW0=;
        b=bxqEA7o6skY/+tcJ3pvwUzfo3phPPQY1oVQxVwvlAgV2YtPYCNdzFovib08k98TR7v
         HQs+Z5/IAdBZZfCZfPFvnffONBIXGlQSr45CiOZf1T65QwX8nV9mwdhPSb9g/pVbbjK6
         HLx997kWeiQ8c6eXeWg2gaJ0/SKDCwHtWTYXgthNw+dstwbwyIk8+HiB1x0SEHCSUB3v
         sEpGCBCz8j9il15xTUopkSnLc67Iml336vvsLNq3s3YMjLFp73flXKAw3VaDwWB6S3zb
         KIr6CytO8TFq3JuOJauREFaVZxp+qFpo2VGe2l3rESGx9qBftKPAn/qcB4+Qv8otdY5s
         WeFw==
X-Gm-Message-State: AOJu0YwSXIVUWYjSOEOgPFTcKoUDq7fGibw+MCvfHETuHG4wgcLlRHjD
        02Q4lCZPCMGva9j1E+tDlBPPmriwiWn5evvtwfaxE4bz
X-Google-Smtp-Source: AGHT+IH5hLOZX1qqtq0SWQZ52QGydWh2QUZHqi+QcioA3rhnEVBzkA6UNZnoANHCfdWyzaopuZMgxg==
X-Received: by 2002:a17:907:d2a:b0:9ae:6a51:87c3 with SMTP id gn42-20020a1709070d2a00b009ae6a5187c3mr6957618ejc.9.1699027340646;
        Fri, 03 Nov 2023 09:02:20 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id h17-20020a17090791d100b009ddc90505desm143642ejz.141.2023.11.03.09.02.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 09:02:20 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so15489a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 09:02:19 -0700 (PDT)
X-Received: by 2002:a50:d50f:0:b0:542:d737:dc7e with SMTP id
 u15-20020a50d50f000000b00542d737dc7emr242196edi.0.1699027339321; Fri, 03 Nov
 2023 09:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231102221309.1971910-1-hsinyi@chromium.org> <20231102221309.1971910-2-hsinyi@chromium.org>
In-Reply-To: <20231102221309.1971910-2-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Nov 2023 09:02:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Unv+PtHd=QoFOgY_4tjxPGWeU7-hzp3YHfc2DjWu3wcQ@mail.gmail.com>
Message-ID: <CAD=FV=Unv+PtHd=QoFOgY_4tjxPGWeU7-hzp3YHfc2DjWu3wcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/panel-edp: Add several AUO/BOE panels
To:     Hsin-Yi Wang <hsinyi@chromium.org>
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

Hi,

On Thu, Nov 2, 2023 at 3:13=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> w=
rote:
>
> Add a few generic edp panels used by mt8186 chromebooks.
> Besides, modify the following panel:
> - AUO 0x235c B116XTN02 renamed to B116XTN02.3.
> - AUO 0x405c B116XAK01 adjust the timing of auo_b116xak01. According
> to the datasheet: T3=3D200, T12=3D500, T7_max =3D 50.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v1->v2: Address comments: update delay for auo_b116xak01, sort entries.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 57 +++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)

This seems good to me now. I guess a tiny nit is that the ${SUBJECT}
mentions AUO/BOE panels but a few other model panels are also added,
but it's not a huge issue for me.

Normally I apply patches to this table near-instantly, but since it's
Friday and this touches a lot of panels, I'll probably wait until
sometime next week.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
