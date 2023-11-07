Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451CC7E47EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjKGSL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjKGR41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:56:27 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9498F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:56:24 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso896123866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699379781; x=1699984581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8StncZh/iw8rVTbFpbMeIoiTuJSwCnvKTl9QP94ClOw=;
        b=X8swh9l6UiEyclAGFZwhvbLe4wkWcO9/d7EkqZkSi2d3wWkFbBIjIufsG2TNOSnx1E
         WxRFf7AHoIV9y5VAMPFoE0rRKQnHkz2OWxiYP+J+kUF3UpJEGMCdVAHDNOTDyB9nZcOV
         Hl2d8nbtZx1OgIqI0AkFqTXlBdNZWSMRzmveI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379781; x=1699984581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8StncZh/iw8rVTbFpbMeIoiTuJSwCnvKTl9QP94ClOw=;
        b=gtiycnFs+jNczg2/eKq1qIJgQRGQLuzVI7WgXuX1pqCYi95RjZD21RhMmACI7tErn9
         +FsxtB6H0aycs0cA7FEPzYw71hW+h+h0tMAR1YxDqFENn6+CRmEYH8jCQx9upD6IKHPY
         RsPlnjifYoKt6qGYTcKb24u2iyHX2eBlLB5elvEbC3HtzFV98VTl2l/WuQJwtLjG9G01
         OqZFnW6HbQ0c6a8BjvaN6K6eppweAenFT1SbxbKApbMYIoeZl596DVsNXxsDSIS/kCUU
         ZZNRfCXH+HTw7PtFZF+TnHOuG55tHAdzCd3h/sdYfBp92dYEqAALR2OExaxi+Rjzlwcb
         ryzA==
X-Gm-Message-State: AOJu0Yz9rKrtwnN6lN6cRKl83zVco9x6pjt8Sibt+U5euVV3oVQIxNNP
        jphC7xdE5GAVV/yyO4TA0tGJS2iSmEwyppRZWLuk72IH
X-Google-Smtp-Source: AGHT+IHqs0fQNPar/ieCtC1+fs7DePrCg3at8I6sg4aofbEJej9jC6jF/yUfOtqAPkSHEdT4MbJ5fg==
X-Received: by 2002:a17:906:4fd3:b0:9df:e457:cef6 with SMTP id i19-20020a1709064fd300b009dfe457cef6mr5740409ejw.77.1699379781030;
        Tue, 07 Nov 2023 09:56:21 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id xa25-20020a170907b9d900b0098921e1b064sm1293381ejc.181.2023.11.07.09.56.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 09:56:20 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so516a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:56:20 -0800 (PST)
X-Received: by 2002:a50:d68b:0:b0:543:fb17:1a8 with SMTP id
 r11-20020a50d68b000000b00543fb1701a8mr120839edi.3.1699379780027; Tue, 07 Nov
 2023 09:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20231107000023.2928195-1-hsinyi@chromium.org> <20231107000023.2928195-2-hsinyi@chromium.org>
In-Reply-To: <20231107000023.2928195-2-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Nov 2023 09:56:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XdVnFqbF9UZ-W1OWMVWSxk=CxP9WAb3q4rT7S+ryxXWA@mail.gmail.com>
Message-ID: <CAD=FV=XdVnFqbF9UZ-W1OWMVWSxk=CxP9WAb3q4rT7S+ryxXWA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02,
 B116XAK01 name and timing
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 6, 2023 at 4:00=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> w=
rote:
>
> According to decoding edid and datahseet:
> - Rename AUO 0x235c B116XTN02 to B116XTN02.3
> - Rename AUO 0x405c B116XAK01 to B116XAK01.0 and adjust the timing of
> auo_b116xak01: T3=3D200, T12=3D500, T7_max =3D 50.
>
> Fixes: 3db2420422a5 ("drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,=
836X2, NV116WHM-N49 V8.0")
> Fixes: da458286a5e2 ("drm/panel: Add support for AUO B116XAK01 panel")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> v4->v5: separate fixes patch.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

I hate to be a hassle since I don't think this will have any
meaningful impact on anyone, but given that it's now split out as a
fix it should probably be split into two separate patches (one for
each fix). That will save time for anyone dealing with the stable
channel.

-Doug
