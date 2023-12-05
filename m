Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7F805DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345839AbjLESJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLESJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:09:44 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B7DA5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:09:51 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a00191363c1so822023766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701799787; x=1702404587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRQn44/aTuYgsI6zHupZ2XRpsR2rUlkoEa03YW7tLjw=;
        b=Od9eYWKwd/LhOH+mgkF38wO30pmtJR154a/3hjpHq1yIi90zyJfdThVhX4iSX8659/
         F5MoA9gOz81RFq5wPFSyhmhp7dTLmF5jMcvDSEnaiahr4NU0clSNntsafiFN4fLAvWnF
         jEMFulpHeG/GxZ832a6BHOPWbLloLaDIntAok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799787; x=1702404587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRQn44/aTuYgsI6zHupZ2XRpsR2rUlkoEa03YW7tLjw=;
        b=uI74ojXVrp48EUJr9GPJTaacmmD7fGWB3skyMI03Y0ARLcTOoNfDpBtWswM9IhY3Ne
         v+nOnRnp5TInDKLu1OseFd2u8NPFe0jUukAl2d8yyQuAxNUoXDzZsWxV8w2WnCyno1xL
         UZf+YduV0ZELirwQhxV/4s4TU4jXKWoX5LIOaRibh4gevUezl2ACFs7rmqu+9SN7szNK
         3MS8IVNlLQCAIqAk3D1/4sKCjdh4NUrydKC4nVpmObbkujo1DmSLDehlfH/wXA/erK2X
         iPAvjRM4U7FLJ/iM4F0T509iGz5BaiihEG8cP6Li75KyJj2pPURE5ViM7ym2tdeoN+5p
         wwiQ==
X-Gm-Message-State: AOJu0YxWrdPNYsOrwC2uPrSwZfYfB571GB+6i5WvrGA7w5tuTebtHHTq
        fIW/RdZYv0njwEJgNDuV6BiFG4sW1meouha0as7yXSpD
X-Google-Smtp-Source: AGHT+IG5JEep/1E3P9fQCMYJd4O7RnUIKUC7u8EBAmI6cfzGZ+XW4+3fCnTEmQiQ+KWNNex9ndCrWQ==
X-Received: by 2002:a17:906:7d48:b0:a1c:d52f:e242 with SMTP id l8-20020a1709067d4800b00a1cd52fe242mr324614ejp.271.1701799787293;
        Tue, 05 Dec 2023 10:09:47 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id p4-20020a170906140400b00a1b61096ce6sm3766261ejc.129.2023.12.05.10.09.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 10:09:46 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso348a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:09:46 -0800 (PST)
X-Received: by 2002:a05:6402:22c4:b0:54c:f4fd:3427 with SMTP id
 dm4-20020a05640222c400b0054cf4fd3427mr221749edb.7.1701799786563; Tue, 05 Dec
 2023 10:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20231205123630.988663-1-treapking@chromium.org> <20231205203536.4.Iaa6257fcf9e7fe3ca88c50ab6e5aa3fbf55266d0@changeid>
In-Reply-To: <20231205203536.4.Iaa6257fcf9e7fe3ca88c50ab6e5aa3fbf55266d0@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Dec 2023 10:09:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WNJP=aCC1hmSp8h0hgcXxzt1q-nPTPcU159i4OCQ7+_g@mail.gmail.com>
Message-ID: <CAD=FV=WNJP=aCC1hmSp8h0hgcXxzt1q-nPTPcU159i4OCQ7+_g@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/panel-edp: Add some panels with conservative timings
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 5, 2023 at 4:37=E2=80=AFAM Pin-yen Lin <treapking@chromium.org>=
 wrote:
>
> These panels are used by Mediatek MT8173 Chromebooks but we can't find
> the corresponding data sheets, and these panels used to work on v4.19
> kernel without any specified delays.
>
> Therefore, instead of having them use the default conservative timings,
> update them with less-conservative timings from other panels of the same
> vendor. The panels should still work under those timings, and we can
> save some delays and suppress the warnings.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

This is OK w/ me, but it will need time on the mailing lists before
landing in case anyone else has opinions. Specifical thoughts:

* I at least feel fairly confident that this is OK since these panels
essentially booted without _any_ delays back on the old downstream
v4.19 kernel. Presumably the panels just had fairly robust timing
controllers and so worked OK, but it's better to get the timing more
correct.

* This is definitely better than the very conservative timings and the
WARN_ON splat.

* I don't love the "Unknown" string, but it doesn't do anything other
than print to dmesg anyway and at least it conveys to anyone else
reading the table that the timings may not be quite as tight.

-Doug
