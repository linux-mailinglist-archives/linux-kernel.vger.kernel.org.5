Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF857EF6C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjKQRLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjKQRLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:11:41 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FF3D57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:11:38 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so1570172a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700241095; x=1700845895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDNnd6/aPHHekufZp74kyH5A3dFam5hx1vRv3RYwbhI=;
        b=TTeZL4XKClO5SazZvy7rCpqdKkKVpD2FV9H44GInZEdAWclxi4tUkZo3iDQ+3kxqQK
         iTIe7Zz4zE4a46eneNJFvLCq9BXRUKQ1FUib49XrlhOWrkcHtcELZ/aw0r71RA8aILJg
         aThf4WLrs3E4pYZmOry01gr19PGbP3N0eNBJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241095; x=1700845895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDNnd6/aPHHekufZp74kyH5A3dFam5hx1vRv3RYwbhI=;
        b=QGp8k/n5guo++nIaGA9Apw27uDSlpTR4B0/X0F3aIRU8CIIjtKgQs8NJ3eHQ/K6msi
         A2xhKKGEOa13ubfaiatdcry0W/xM+RkrzRssJodHjU5MnMSMJe9r39MxH2U7GTwFgHB+
         Vq+tmjnTb341x0BydKrDBDD5grJjQEGDXZ8+awWHZAq6fXLARdgWa8/0WXBS1nr/zIUP
         +dxnrm0WRUnYDuluUUn2XYUTWGrQkMXDVvoN3SnW/cUrPUnhDTRQQGO/KzlyYTYYUPET
         ysCyAVhjWWcZlLgjBqr0jrYo0n3FUscVcJDXKd6xv7vJQBENR0Jj1Pijha/1LkVoBGPv
         OP2g==
X-Gm-Message-State: AOJu0Yx/DDfl4DRAUQh+z1sc5Y/gTGyGlVRQ7D0mACM/y2EjQYNW0vr7
        pE+jADOdsOngh4RM4Apm/9/O8aLT3xxITCm+81YPQQ==
X-Google-Smtp-Source: AGHT+IHo7+RNv44cGuBbvuYrXwp1laO5VmMLTcPxzOgh+gAbj7o3obaeKMuXRJomgztyv+IEAw26ZQ==
X-Received: by 2002:aa7:c6cc:0:b0:544:1fb7:d5e4 with SMTP id b12-20020aa7c6cc000000b005441fb7d5e4mr15089885eds.0.1700241095229;
        Fri, 17 Nov 2023 09:11:35 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id d13-20020a056402000d00b005484785e506sm708528edu.43.2023.11.17.09.11.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 09:11:34 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40837124e1cso93515e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:11:33 -0800 (PST)
X-Received: by 2002:a1c:7504:0:b0:404:74f8:f47c with SMTP id
 o4-20020a1c7504000000b0040474f8f47cmr7198wmc.5.1700241093083; Fri, 17 Nov
 2023 09:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20231117032500.2923624-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231117032500.2923624-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Nov 2023 09:11:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WAPAhMfK5jgkMS=m3grxaUtrDoZnQs3rmbLpLX84+j1w@mail.gmail.com>
Message-ID: <CAD=FV=WAPAhMfK5jgkMS=m3grxaUtrDoZnQs3rmbLpLX84+j1w@mail.gmail.com>
Subject: Re: [PATCH V2] drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02
 panel HFP and HBP
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@google.com>,
        David Airlie <airlied@gmail.com>, zhouruihai@huaqin.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 16, 2023 at 7:25=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The refresh reported by modetest is 60.46Hz, and the actual measurement
> is 60.01Hz, which is outside the expected tolerance.

Presumably you've swapped the numbers above? The value reported by
modetest is 60.01Hz and the actual measurement is 60.46Hz?

> Adjust hporch and
> pixel clock to fix it. After repair, modetest and actual measurement were
> all 60.01Hz.
>
> Modetest refresh =3D Pixel CLK/ htotal* vtotal, but measurement frame rat=
e
> is HS->LP cycle time(Vblanking). Measured frame rate is not only affected
> by Htotal/Vtotal/pixel clock, also affecte by Lane-num/PixelBit/LineTime

s/affecte/affected

For me, the important part would be to explain the reason for the
difference. I assume that the DSI controller could not make the mode
that we requested exactly (presumably it's PLL couldn't generate the
exact pixel clock?). This new mode was picked to be achievable by the
DSI controller on the system that the panel is used on.


> /DSI CLK. If you use a different SOC platform mipi controller, you may
> need to readjust these parameters. Now this panel looks like it's only us=
ed
> by me on the MTK platform, so let's change this set of parameters.
>
> Fixes: 1bc2ef065f13 ("drm/panel: Support for Starry-himax83102-j02 TDDI M=
IPI-DSI panel")
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
> Chage since V1:
>
> - Update commit message.
>
> V1: https://lore.kernel.org/all/20231110094553.2361842-1-yangcong5@huaqin=
.corp-partner.google.com
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

As per discussion in V1, I'm OK with this.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll probably give it at least another week before applying in case
anyone else wants to speak up. It would be nice if you could send a V3
with a few more touchups to the commit message, especially since the
60.01 and 60.46 numbers were backward (unless I'm mistaken).


-Doug
