Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D057F4862
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344126AbjKVN6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjKVN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:58:46 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE95101
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:58:42 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cc3dd21b0cso9763717b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700661522; x=1701266322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRzdz+ULxtzYNqA4ymScV/usLl4Bsrd31iiECM6OPPo=;
        b=jAUmq5nEw5rcmMkBJLhl7/ShbiKLU5sL8EEg7/RPg4A77qvhfWvGZZaQR087fJmFkF
         MAVqvB6Q8Vve0AMN5ZFejHQHS3US7dcWel9QX+3iOmwm9mQzrJn3EMdA7/sYsPkd0I2p
         WqZH7F2jVG2Rg5neVOXeIFg4kZBX3eK5ZguO++TNHVu7XpFrL0/WRWbvegqrZtfQt1Ms
         cXCe1UFgFgjyYQbct5HthT/sOL3zHusFPfOVFqVKV/OsD35TW3xVeBf77LKLsnstz6+Q
         q/zLStl2eHy/rG1/y4oN66Dq5DJTbsdOdMqzLTvc+YthZh8F2m1RM9ixl+wjVAy4ZMXm
         cMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700661522; x=1701266322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRzdz+ULxtzYNqA4ymScV/usLl4Bsrd31iiECM6OPPo=;
        b=lTneQEcZ7uguJs6/wfcEGZEI8OvLq/5toyam8pBCputkjWrg7h33wOVxyLSPVV6Gxn
         KnZLGL+XbAC7//wA1iZUVP7f4DMpOQBQ0cdcecMqptvhGjyM+zLa803GukgrxRpmXE9P
         zDlbOKq4soTpMQX/4qSfGgu5bFCZLFB21hraRYU0J2ahY5JoF0hB1hPIngwXQqA456Yo
         ficbOH0R3e188er2uKX3StQHmYLeHocNoygV5MrQoLBdxsC3OAV/Y21WiadgBZ/dPrMg
         eOddgB53Phr7APqc+Lv01bPDvsbwPYNmR+PjS6dR5ALjnDxLx2TPbw9F0TPtdNCfo4de
         5BsA==
X-Gm-Message-State: AOJu0Yz146X4VPiCUUszfD1nzehnhgJLKij0klO/YchDZ+hsNaokhF+0
        s1m/GHpLK/KOCxfkenhdkEp5lbEdohH5oT7YfPkTew==
X-Google-Smtp-Source: AGHT+IFgbL+aCpZ2yEkLH3RABDRWWhYPzT5ywvUl4rKnVtTXVwbELC/RJ30BaQTE4700g74RBAovNHoIf6eX/Zbx6kM=
X-Received: by 2002:a81:4a02:0:b0:5be:ae23:c002 with SMTP id
 x2-20020a814a02000000b005beae23c002mr2576971ywa.26.1700661522056; Wed, 22 Nov
 2023 05:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20230807061115.3244501-1-victor.liu@nxp.com> <CACRpkdaGzXD6HbiX7mVUNJAJtMEPG00Pp6+nJ1P0JrfJ-ArMvQ@mail.gmail.com>
 <AM7PR04MB7046863700EA909289EAC17798B4A@AM7PR04MB7046.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB7046863700EA909289EAC17798B4A@AM7PR04MB7046.eurprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 22 Nov 2023 14:58:30 +0100
Message-ID: <CACRpkdYPDi+TYj4Y89+iLKa__oFTuMKCPDB7UrVThEGd=6H3qw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: panel: Add a device link between drm
 device and panel device
To:     Ying Liu <victor.liu@nxp.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "rfoss@kernel.org" <rfoss@kernel.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>
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

Hi Ying,

On Mon, Nov 20, 2023 at 11:08=E2=80=AFAM Ying Liu <victor.liu@nxp.com> wrot=
e:

[Me]
> > > v2->v3:
> > > * Improve commit message s/swapped/reversed/.
> >
> > This patch causes a regression in the Ux500 MCDE
> > drivers/gpu/drm/mcde/* driver with the nt35510 panel
> > drivers/gpu/drm/panel/panel-novatek-nt35510.c
> > my dmesg looks like this:
(...)
> Sorry for the breakage and a bit late response(I'm a bit busy with intern=
al
> things).
>
> I think device_link_add() fails because a0351000.dsi.0 already depends
> on a0350000.mcde.  Can you confirm that device_link_add() returns NULL
> right after it calls device_is_dependent()?
>
> Does this patch fix the issue?

Yep it works!

You missed one device_link_del() instance on the errorpath.

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Can you send it as a proper patch?

Yours,
Linus Walleij
