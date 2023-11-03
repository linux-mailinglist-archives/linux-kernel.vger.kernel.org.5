Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B008A7E0620
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbjKCQDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjKCQDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:03:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0923D64
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 09:03:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507e85ebf50so2770297e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699027389; x=1699632189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihGdFd0nqrzmFvEDZxhHQ2+8zpelaN2AcwyF1dKV48M=;
        b=G2yBKHfC5I4VBNSL4OadPQ5Ywl6SpyEWzx6qSO8LNDoNgYLxm871fRKmtagehGxHDF
         5gYdsrdb64kuAnO2tHRc7VjVewshryra9pQRgOTzTitfpNNNvCZJFKGdsTQF2yK3RZIk
         vvBMWB86TNEbMAc426+6uaoLSLV21SvHff62Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699027389; x=1699632189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihGdFd0nqrzmFvEDZxhHQ2+8zpelaN2AcwyF1dKV48M=;
        b=WuWnNqMXBHXOAcpLuBou0K8JXYjQK7cpV4hv+dlIIoGcuO6Nl+qytrH9oqv1p4Q7fd
         iArHcxWgISRJcRXQ6WRnDnFsIS92FnpJe/tc2pBzfTl9xieDUfnny16VTO12c41tE9OI
         eU2T3LFsAt6HjxVVucsUmUcpUpyeS9QFs7P9GqqnZvCM8vcUFAJqqbOjAslh4XE6YFjT
         QhKQXAoUnCVxa0uVWOClqr00gwc8HFspEU+OyJFurDCH1NAa80efznfUP5wa5uQ0QWDv
         1zAS2VNNj4tsKHFqbgSSNk4r0Ymf3rlYaf8hDI4MYPUwYO32PrmAFNCno7o053pXNjIA
         P/mg==
X-Gm-Message-State: AOJu0YzrvyQsosaDj6JdJmI5Bio9+xElk27SnPodQaJYr0cmpc3eZRuv
        u3w3/6elVNV6BASlO9RUwiUD3X/5bsxdCZEUUXX5Ffft
X-Google-Smtp-Source: AGHT+IH9xKMjl3Vqi9Msm5EtknWLMn7XXCwd6PLA9wPJfwnnst/G5Q/cKYe4ALPOHGg+Regm6vfgUw==
X-Received: by 2002:a05:6512:60f:b0:507:a9ae:5c2 with SMTP id b15-20020a056512060f00b00507a9ae05c2mr16639801lfe.44.1699027388839;
        Fri, 03 Nov 2023 09:03:08 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id c12-20020a056402120c00b005438ce5bf80sm1080981edw.20.2023.11.03.09.03.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 09:03:08 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so15263a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 09:03:08 -0700 (PDT)
X-Received: by 2002:a05:6402:254b:b0:543:faac:e135 with SMTP id
 l11-20020a056402254b00b00543faace135mr229008edb.3.1699027387964; Fri, 03 Nov
 2023 09:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231102221309.1971910-1-hsinyi@chromium.org> <20231102221309.1971910-5-hsinyi@chromium.org>
In-Reply-To: <20231102221309.1971910-5-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Nov 2023 09:02:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XEnk1TuWsJB6W5PGisg3_0A3HZMGpxEUrtcDxXK=Z+Eg@mail.gmail.com>
Message-ID: <CAD=FV=XEnk1TuWsJB6W5PGisg3_0A3HZMGpxEUrtcDxXK=Z+Eg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/panel-edp: Choose correct preferred mode
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 2, 2023 at 3:13=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> w=
rote:
>
> If a non generic edp-panel is under aux-bus, the mode read from edid woul=
d
> still be selected as preferred and results in multiple preferred modes,
> which is ambiguous.
>
> If a hard-coded mode is present, unset the preferred bit of the modes rea=
d
> from edid.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v1->v2: split patches from drm_modes.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Do you think this should have a "Fixes?" As per discussion on V1 [1],
this has probably been a bit broken from the beginning, though I guess
it only became a big deal after the AUX bus made it so that the panel
driver commonly had the EDID...

[1] https://lore.kernel.org/r/CAD=3DFV=3DWHzCdiYumsxUm_am+ALqq9SOOrjf=3DJYH=
qJuiKFB+Dnsw@mail.gmail.com
