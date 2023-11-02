Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDAF7DF2E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346867AbjKBMw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKBMw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:52:56 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE63BBD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:52:50 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5b35579f475so10848567b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698929570; x=1699534370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkAF/PZfI+WcIMVb9OirzvXLigR8HCnTm5LBRbHreQ8=;
        b=HKFjuCEBzZNDtxo9mafOGcMP2X8s7uKQEkDa0gw88hmSN9Cp6HUlecaLFoMR/NgxHR
         H180gAotxMwDNENxS1gaHZ2/7Q2dC2Jr0RZp55GJuOFdOxfIyxeBhOr9PudzZroKG8Kn
         AmAEBY1nR97bTwKGhsL/dbkpEyfcfQXVHSQQDGJZmJzkW3uPSkrq3/qTGlt02vgy8xKS
         f+Ck2Q+alNhVT36BDAN1w+SMNBbMtqkMeD5/o4NT9q9vAGrW2ZIi7rMTqmsumn3eul0x
         J73rQMMprF4nrdIK10Q8LvYEBmELmj1muN85e3zssgrXwUDgJa2br8uEYqUaWyFm+Y34
         yF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698929570; x=1699534370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkAF/PZfI+WcIMVb9OirzvXLigR8HCnTm5LBRbHreQ8=;
        b=v6NOtmXwXvQq71WgSMSiZ6eJd6fB5HGUydlyiJH6g4L3zGUsDMfbrRBGA3EFemNa2d
         F1pY/HI0cdW/nY7pf/P58Jq9qZhnmiT+o80kb7tTns1O7cPQVU9V7nsjs+r3EDXJ71Kx
         KHrUN3X/SC2GE8xCik7HWdcxft5opHSxfcAOtRQnrkhP2qTJ/ihqoEYiBbvQY0DXBXFN
         rGaCrsavgO16lF5J+zOeSIa38HjiqMODgKTiARlRX3cYjzj3jXwdFjLHRDgd/ipClHte
         RmjDRoy0fLVzEAaU+/wkwb1FUxJTf5+nQDBmXUwYZBgiJkHMpJr/Zx2BZLlK2NZYf2gB
         YOeg==
X-Gm-Message-State: AOJu0Yye5MpbA/2ye8Oy5enKBKT6URudj6GJzjEZ7VjMskzU7ohL/2m1
        bl6cRHoahWo6BG32Va3jmdVOrga2zg/b2rkJIPqKyA==
X-Google-Smtp-Source: AGHT+IEm5KTzKFJCbkkeKGbycJaUyyW8Clx4xfeXUOila9bUE2hnM4hISA/tiCWJmcYbmvIqZOLlyTt4OscrRjvOsrI=
X-Received: by 2002:a05:690c:ec8:b0:5a7:cc02:68b0 with SMTP id
 cs8-20020a05690c0ec800b005a7cc0268b0mr28010361ywb.23.1698929570185; Thu, 02
 Nov 2023 05:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231030072337.2341539-2-contact@jookia.org> <20231030072337.2341539-6-contact@jookia.org>
In-Reply-To: <20231030072337.2341539-6-contact@jookia.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Nov 2023 13:52:39 +0100
Message-ID: <CACRpkdZYfqyOhzzoNMUCAkQoUKSLD99SNUthZ7-m=rmcNvWUMg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/7] drm/panel: nv3052c: Add Fascontek FS035VG158
 LCD display
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

> This display is extremely similar to the LTK035C5444T, but still has
> some minor variations in panel initialization.
>
> Signed-off-by: John Watts <contact@jookia.org>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
