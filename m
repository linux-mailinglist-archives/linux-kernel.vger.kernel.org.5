Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0A87FB6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjK1KQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjK1KQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:16:29 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B466DC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:16:36 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db4050e68f3so4961294276.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701166595; x=1701771395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az09m0h7jONXF1DY571MoHHhddA+pAfUddfadnw5xbM=;
        b=MV7wVq4ZEB2qMptb6ELTkzUUjSBxrowseRSn1jmi/6yaZER/oGBEk8nKwDz6LJSOGk
         DaQSUZWtMGQ6oq555hIbd73Ia6VpywHV9zbtN2ain5YvfrXSkfvrhxUsQD5EZHJcSyAM
         DCJAKSaitFbKfnxnn4pnhBZRaPiUD8Sr+B/L1agng1wcqh1eHFxljovVnkxQuLxljB67
         fSpYr+VBnTta6Mz+6+gHnfQqu/GYzWhHdoeDROxOGt92lyLSeSmJqFJiNmNVYA25QpBm
         0hfdyQYYUH9EterTsO8nMD0pgnEsaa94dCCGn81ITmxtEvZ0I8lB1nrj5OH27v7g6QHQ
         Yujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166595; x=1701771395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=az09m0h7jONXF1DY571MoHHhddA+pAfUddfadnw5xbM=;
        b=a7uiPtrVHHm+WgajjQ4wWIN9m+mVqz/7pwt8ZqfppRcDcUHIHQFIYkLaJxL8DJ05Rt
         vsNyT+aE84TLylToN0tpjBKCVC3rL1S8Vh5I2pd70y71fBr5MJj40a5MSWoPJhUezO1h
         tgZefGgUujc+WMUko4QCuAZxqXNanlU15spsSzwmHtddkmtaHD3INGf3yVxuKT0nhfjv
         zafkKHlWGad5FalsU22OAh8OEES8JJtddG005ZVozrUpjqCl+oO8AESFAmjNrjnzB3JI
         jPeip6Cj0rFPY7aVjoUgV8ej4mB9vbx5cLWxau9Vn7Q3tHnTqWPQyT+UxB2ARK1RGgrI
         HwEg==
X-Gm-Message-State: AOJu0Yzw2J3fJA/I6uyJrJdVr3XWhEeQduIA8zQPEfJ0Z4ePXzPUdCJW
        M0xhJzN3IB94/1wVoHay/OhEBklL16/VBX/GtSINOg==
X-Google-Smtp-Source: AGHT+IEKfi0a8Ktnneb/ArA2n6UZ+H0NiLFIih34xe+5JdldBuidRBT70xvjvMtby6rJJlfMfCIcVYNAtUFQSGFfyGk=
X-Received: by 2002:a25:870b:0:b0:da0:c887:36cb with SMTP id
 a11-20020a25870b000000b00da0c88736cbmr13361932ybl.45.1701166595298; Tue, 28
 Nov 2023 02:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
 <170116632194.2250210.1478661000647719120.b4-ty@linaro.org> <b6d79cad-a545-48cb-a0e4-e9fdc457bec3@linaro.org>
In-Reply-To: <b6d79cad-a545-48cb-a0e4-e9fdc457bec3@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 11:16:23 +0100
Message-ID: <CACRpkdaAFoMnjha0+yWPDhj=RGyP3tzFOq5+bp7Uv8H2bkFW1w@mail.gmail.com>
Subject: Re: (subset) [PATCH 0/3] Revert panel fixes and original buggy patch
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

On Tue, Nov 28, 2023 at 11:13=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
> On 28/11/2023 11:12, Neil Armstrong wrote:
> > Hi,
> >
> > On Tue, 28 Nov 2023 00:10:18 +0100, Linus Walleij wrote:
> >> This series reverts the attempts to fix the bug that went
> >> into v6.7-rc1 in commit 199cf07ebd2b
> >> "drm/bridge: panel: Add a device link between drm device and panel dev=
ice"
> >> and then it reverts that patch as well.
> >>
> >>
> >
> > Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git=
 (drm-misc-fixes)
> >
> > [3/3] Revert "drm/bridge: panel: Add a device link between drm device a=
nd panel device"
> >        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D9b6a59e5d=
b87c2c6b3ca0391176ed4358623d5e4
> >
>
> b4 got really confused that I picked the patches in the wrong order, but =
I applied
> the 3 patched in the 2, 1, 3 order.

Special mistakes requires special fixes, sorry for the mess :(

Thanks a lot Neil!

Yours,
Linus Walleij
