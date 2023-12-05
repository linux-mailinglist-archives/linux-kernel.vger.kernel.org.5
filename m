Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0471F805DA6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345563AbjLESGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbjLESGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:06:21 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7131BC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:06:27 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54cd8f5bb5cso2684254a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701799583; x=1702404383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8H1TVEfqWDVKjsBzidGMR3JoOaMrLGMGY6/yIdEsvY=;
        b=S7t138HEDcVBI9M+qGbgNw1uoftVk9DRjlmWu2xjL9tG9Dl+YPXF70RvnN8A/rOCLe
         iaKjOtB5gobicKbQ7bPJ5wluYXYYj89uQNeTJKsDhOMdekpv7m+May2A95DzFh+UysoH
         w08TFMxicfF3dBo0vmxIhZxHlVz/o+cblJ4MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799583; x=1702404383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8H1TVEfqWDVKjsBzidGMR3JoOaMrLGMGY6/yIdEsvY=;
        b=cZ/P0530Z4ht2un0bxKt9rIID1GmhdL7vRdIxo98Xh4jvBMql9rPlKgN6uF9FCCJee
         pO5bQjEYuumVDTeSiwgWzUF80BOyy2LYF6jmGzVw/SOwPdiu+Sws0De3GG8Q20DBo98B
         8Uz+iPD8KxC4JuKzMIe1JR6+zImpG1QvIIVCBU2rsS6eV0Ul2VntsOEoMTTTDT1VNd2C
         dVC46IzhE51Ncqrsq0nAqoilfGjSW2Rf09ptdBBbfUmva2cSy39R1pwIzcNH9/H7MDSK
         QrGmm1nfb1GhJW/gxWw57B3gQkVPOy9gYvrYocOEPozIoKlkLDgEoDIqpbon50Ox9C9K
         2ZJg==
X-Gm-Message-State: AOJu0Yz23x6rq4jZ4zANcWZW2bea0/z013C7jA9+AJcbrdQJ+pji9pzD
        DgEHJsjFYG5YbIRyxfkl3O2a5x5PZyFhH1J7znJcTAqn
X-Google-Smtp-Source: AGHT+IEZAorUcxA/XAiqeqo/gFEF65Oh5t0I92pxRRyfPeKSVuqM6eRlAeIX3j8EQIesOXGjYYriZA==
X-Received: by 2002:a17:906:b358:b0:a19:a37:ab80 with SMTP id cd24-20020a170906b35800b00a190a37ab80mr842410ejb.47.1701799583571;
        Tue, 05 Dec 2023 10:06:23 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id d15-20020a170906344f00b00a10f3030e11sm7019889ejb.1.2023.12.05.10.06.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 10:06:22 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso2015e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:06:22 -0800 (PST)
X-Received: by 2002:a7b:c4c6:0:b0:40b:3d89:ba70 with SMTP id
 g6-20020a7bc4c6000000b0040b3d89ba70mr550221wmk.7.1701799582662; Tue, 05 Dec
 2023 10:06:22 -0800 (PST)
MIME-Version: 1.0
References: <20231205123630.988663-1-treapking@chromium.org> <20231205203536.3.I8fc55a1de13171aa738b14a167bab8df76c2ea2a@changeid>
In-Reply-To: <20231205203536.3.I8fc55a1de13171aa738b14a167bab8df76c2ea2a@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Dec 2023 10:06:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WcrW8pKmTq0fFK6OUoaXxUgAocO=eNd-oGxF7jtbyiGA@mail.gmail.com>
Message-ID: <CAD=FV=WcrW8pKmTq0fFK6OUoaXxUgAocO=eNd-oGxF7jtbyiGA@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/edp-panel: Add panels delay entries
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org
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

Hi,

On Tue, Dec 5, 2023 at 4:36=E2=80=AFAM Pin-yen Lin <treapking@chromium.org>=
 wrote:
>
> @@ -1999,10 +2031,17 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "R1=
33NW4K-R0"),
>         EDP_PANEL_ENTRY('I', 'V', 'O', 0x8c4d, &delay_200_150_e200, "R140=
NWFM R1"),
>
> +       EDP_PANEL_ENTRY('K', 'D', 'C', 0x044f, &delay_200_500_e50, "KD116=
N9-30NH-F3"),
> +       EDP_PANEL_ENTRY('K', 'D', 'C', 0x05f1, &delay_200_500_e80_d50, "K=
D116N5-30NV-G7"),
>         EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv=
_a010.delay, "116N21-30NV-A010"),
>         EDP_PANEL_ENTRY('K', 'D', 'C', 0x0809, &delay_200_500_e50, "KD116=
N2930A15"),
> +       EDP_PANEL_ENTRY('K', 'D', 'B', 0x1118, &delay_200_500_e50, "KD116=
N29-30NK-A005"),
>         EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "1=
16N29-30NK-C007"),

Huh, I apparently missed it when reviewing an earlier patch, but the
above table mixes 'KDB' and 'KDC'. Can you fix that and then base your
patch atop it?



-Doug
