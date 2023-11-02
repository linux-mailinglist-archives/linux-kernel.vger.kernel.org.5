Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2667DF2E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376286AbjKBMxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjKBMxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:53:19 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D565184
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:53:13 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a90d6ab962so10904737b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698929592; x=1699534392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFoF+rUCSw1DXnPriHOXt0pQ5UV5P52GBE5q91mWyNs=;
        b=eyaC9JIFVe/Vfs+9N8dunlglK7lmSYUXMdC8yxtFpx2m2dbOix+UGGWsJVczuxGM+2
         aRoVHOJsyXOu/3wCEIdzBVEyjXuYLqvLgGcJNTc+thUwhcamOcDrvi5w6dq7+GcIvmCG
         wZELMyQ554YqOvCfC2BGqOnWnwvYmOsmbbXHqXburhw/DmeGd7PZMyHk1Bz6+5CakXGn
         EGHpwNbnsFxhGevr/5VfjttJ4dPq6oJ4nQv05lVjf4mLYEWa716Z2mN9WMxkvXO0p6/j
         xXtkuVKs9Lmb0qbpx9Ni2O65H8eSci1GVMLPQm6m4c+6bQmExgwH0jdawe0GuMoNGw5P
         MeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698929592; x=1699534392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFoF+rUCSw1DXnPriHOXt0pQ5UV5P52GBE5q91mWyNs=;
        b=d7dhO5L+UmZPIq7h/t8pq5dEqCUXYZAdCS1rnMSgx8C0rnb7iV4Y5FXpVDqhU+D7on
         U+HQaA9w09TCa0ftrnVIknLi02gMxlzpQrJEBHYe4xr99Kc7P20CVSIo065riMQlal+s
         UVZFRLrgbQaxYPg9dXYB5Zu8f5VPcxWbgr/3qb6iMBRfq1KpoPvCS8D2gmb0iih6zdKc
         QbkSbsFo0q5Rsqin/diknUt5stOaKmgcJTbbtvzBktXyeW/A4pftIxmv7Jg/tQVPDRLC
         DAUUNUsSe5Ef8n2G5dsUFWK6Qdd5aW51u9V0g2jjiOjaMdCbfOL5a6UfyshwmbvVhTS3
         YwHQ==
X-Gm-Message-State: AOJu0YxivXJn8N4AhdgQY1EK0qoIKH3hHjdQk+kUXIxFMQCKSyVNa0aC
        D5rzdD9DT7aO/usQalV/KWf3TXzMuHw7iyG4/GXgEg==
X-Google-Smtp-Source: AGHT+IHZZRwVG5o+29dUJLi0bz6XUWcThV/K14cb1kkY1dBok7Rk7sKIBa545LanZB5QGQUhrYgLko+YGz98LWpPfOE=
X-Received: by 2002:a05:690c:dcb:b0:5a7:ba53:6544 with SMTP id
 db11-20020a05690c0dcb00b005a7ba536544mr28560196ywb.12.1698929592437; Thu, 02
 Nov 2023 05:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231030072337.2341539-2-contact@jookia.org> <20231030072337.2341539-4-contact@jookia.org>
In-Reply-To: <20231030072337.2341539-4-contact@jookia.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Nov 2023 13:53:00 +0100
Message-ID: <CACRpkdbfox8J=dKbuFf4d_DsmdEZgN3+=z8BYxo4MwW7dGeeYA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] drm/panel: nv3052c: Add SPI device IDs
To:     John Watts <contact@jookia.org>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 8:24=E2=80=AFAM John Watts <contact@jookia.org> wro=
te:

> SPI drivers needs their own list of compatible device IDs in order
> for automatic module loading to work. Add those for this driver.
>
> Signed-off-by: John Watts <contact@jookia.org>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
