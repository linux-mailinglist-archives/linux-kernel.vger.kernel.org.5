Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6637E2E3F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjKFUdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjKFUdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:33:17 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C79D71
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:33:13 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9d10972e63eso723591866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 12:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699302790; x=1699907590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yu558aCQ58tOsOXlyTwpsX2dRSxkRn2ndl7ZRwGGxrQ=;
        b=kZ2vfnMSYihukJfOT0ckRHzZqE5MHec7lwLS9I8quS2AzEhTYS9e629Moo3B80GaUF
         HxujgyaSK9deGk+fpigIxMX9O6bZYXASAFmCBdSQvl8Qm6iaziaHcBSk3wsbt4W6P2ZA
         GASuG6GAAqyg+ARlsjgwB6C/WBDZ0OUt/68gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699302790; x=1699907590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yu558aCQ58tOsOXlyTwpsX2dRSxkRn2ndl7ZRwGGxrQ=;
        b=EwpknLBto0LUDA6PUMJI36byiplI7GFvuMZOwejfymk++Kve9fd9M6P7Eo0xFFh9fP
         GKlv0kMqzkLpARDjV+VCOp9tgpA+Tmr+FyJ4Lddyizyc9diVmc4TnVEcFKgSKHDQiiFh
         gUeRsFf051aFC5lVtmv7/nuVwSyqj1pq2jpsIDNFZg9JxbokAuoKBW+78cZq1YHft39V
         q1/PMTSKpsgwFRL/LunUze/fpVBh92Kz0uyHB8piofPNbXUew/+tHzaRz9KS25UOq3/y
         eq6XTw+W5jipu7mozkt1KP3oA/HiFv/xgPhhO8JxpCyJaEfS6jZfJM8cWrRhDXBMOkzN
         FBww==
X-Gm-Message-State: AOJu0YxLRBgzyYXH2EhJx13xZyUQtIm7gP3D5OF5hDgNDDp1a0lgK6GY
        lNS5pU+XRU1Ce2PjL/i7CR/sjgZ8ZsC46HsvVLwxAoh1
X-Google-Smtp-Source: AGHT+IHqy77KgfIe1ve/5vCbXMrIDiQE+pheeNajLYLsuKUp3pV+3hP/sI+jJP83JuJVPsgF4Klo0g==
X-Received: by 2002:a17:907:25cb:b0:9e0:727a:e491 with SMTP id ae11-20020a17090725cb00b009e0727ae491mr3577163ejc.35.1699302790285;
        Mon, 06 Nov 2023 12:33:10 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906175600b009b2ba067b37sm217885eje.202.2023.11.06.12.33.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 12:33:10 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40837124e1cso21065e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 12:33:09 -0800 (PST)
X-Received: by 2002:a05:600c:5104:b0:409:222d:87d2 with SMTP id
 o4-20020a05600c510400b00409222d87d2mr39925wms.4.1699302789261; Mon, 06 Nov
 2023 12:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20231106202718.2770821-1-hsinyi@chromium.org> <20231106202718.2770821-4-hsinyi@chromium.org>
In-Reply-To: <20231106202718.2770821-4-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Nov 2023 12:32:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WZS0ADX+0MyK3W75BkJ6qcohbj0ZC5CvnT0gedx0z0gg@mail.gmail.com>
Message-ID: <CAD=FV=WZS0ADX+0MyK3W75BkJ6qcohbj0ZC5CvnT0gedx0z0gg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/panel-edp: Avoid adding multiple preferred modes
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

On Mon, Nov 6, 2023 at 12:27=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 0fb439b5efb1..54dbbdf62ec0 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -594,8 +594,20 @@ static int panel_edp_get_modes(struct drm_panel *pan=
el,
>                                       p->detected_panel !=3D ERR_PTR(-EIN=
VAL) &&
>                                       p->detected_panel->override_edid_mo=
de;
>
> -       /* probe EDID if a DDC bus is available */
> -       if (p->ddc) {
> +       /*
> +        * If both edid and hard-coded modes exists, only add hard-coded =
modes
> +        * to avoid multiple preferred modes.
> +        */
> +       if (p->desc->num_timings || p->desc->num_modes) {
> +               /*
> +                * Add hard-coded panel modes. Don't call this if there a=
re no
> +                * timings and no modes (the generic edp-panel case) beca=
use it
> +                * will clobber the display_info that was already set by
> +                * drm_add_edid_modes().
> +                */
> +               num +=3D panel_edp_get_non_edid_modes(p, connector);
> +       } else if (p->ddc) {
> +               /* probe EDID if a DDC bus is available */

As per discussion in v2, I think if you have the "ddc" you still want
to fetch the EDID, you just don't want to add the modes from the EDID.
This will mean that the EDID is present in sysfs if userspace wants to
look at it for whatever reason.

-Doug
