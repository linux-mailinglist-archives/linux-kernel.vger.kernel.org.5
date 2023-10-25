Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F5A7D716F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbjJYQGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjJYQGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:06:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559F9BB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:06:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so847078066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1698249995; x=1698854795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA1TaIzD7xrNnY5nd8THopOsUlZxiQdrx4MWOzBPxns=;
        b=TxhjuJ+T6ZGYx9JvuI25PM+s1h3HIMf+YaPvwy8m8d5OIddQ05FzLezdmIPpt3Wzbw
         PBfwhlPfIi1LheoxZ4HLSlMJ0wd9p/nMcmbYjX2BXO5wzlH/On9T4AKABskiq7J+mHKl
         Di5lmcKW//bosCfoMNvnTPHI/wm/E1JGUOQ7RkGoIqmnOhm/QTtU0nnbuv0LTn3YVRfP
         QJZRpriRqrUjlCeFaUSGgYu3fp4Zrp2iDD3dPvyyDyuME1NN4UeZdK9AenDfxBZRlW8t
         gSBEfGTirMuWHAsV7L+waICoXf21NdQNrB28QpDJ9tOrAjSBF5hxx3mmovvKqzJr1Xfi
         a10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698249995; x=1698854795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA1TaIzD7xrNnY5nd8THopOsUlZxiQdrx4MWOzBPxns=;
        b=U37/fUQ39U9zaShaC7pMOU65MrEiZLZvUPyF3D1MgzpOLD1fJNfKvd2+f2NbhMLrpb
         xoCI5NOYLYlZYZ4d5Jx0g/fFuPUsF4+DdhN3gIYD03hb6bfGCvzska2pndTk7BIGFncp
         UW6lG/RiO10gLzn+OlczWaUyWr5b148On9Fr/3ZccG8RcjimrlMJAYQHiIT+GopMudKD
         qlYr7IsC5cZgX1sz8x/WkNvhlkaX888TYwOpHJBNhmcYcA00GW65+DZmGm2loo7mxPxr
         kacdr2dGseAoIBLiHJoEVXifU9qpZl1C3WsSKhyF0dYRi0xo+/vXzbO3A5hKjQg8Y503
         x/HQ==
X-Gm-Message-State: AOJu0YweaLigjZEsQK5Dn+Z5+gF4v7USZUUPczrm0AB1TjhjZMh2OeSY
        XbJi4HvVohFzkj/dLbfsZWr+GiHn9BCeCNpJ/w3nXQ==
X-Google-Smtp-Source: AGHT+IEu7rDthHy9P1IjnAy1EG0s1E1tiSNiMkbPL5HzW9YHXiGgsKiPjN/fLeO4kHI3nKgn4yoE6QyKBV7g1ZyszVQ=
X-Received: by 2002:a17:907:2d27:b0:9a1:c991:a521 with SMTP id
 gs39-20020a1709072d2700b009a1c991a521mr12829236ejc.4.1698249994772; Wed, 25
 Oct 2023 09:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230719152920.2173-1-tharvey@gateworks.com> <20231025-pessimist-irritate-927b64fbd2fa-mkl@pengutronix.de>
 <20231025-payback-parachute-72fb483c34ae-mkl@pengutronix.de>
In-Reply-To: <20231025-payback-parachute-72fb483c34ae-mkl@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 25 Oct 2023 09:06:21 -0700
Message-ID: <CAJ+vNU2c=5HopuJ60JFx4CA9dyOGminFAPDeZg494GE9dHTe5g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mp: add imx8mp-venice-gw74xx-rpidsi
 overlay for display
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 8:25=E2=80=AFAM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 25.10.2023 16:33:07, Marc Kleine-Budde wrote:
> > Hey Tim,
> >
> > On 19.07.2023 08:29:20, Tim Harvey wrote:
> > > Add support for the following Raspberry Pi displays:
> > >  - DFROBOT DRF0678 7in 800x480 TFT DSI capacitive touch
> > >  - DFROBOT DRF0550 5in 800x480 TFT DSI capacitive touch
> > >
> > > Both have the following hardware:
> > >  - FocalTech FT5406 10pt touch controller (with no interrupt)
> > >  - Powertip PH800480T013-IDF02 compatible panel
> > >  - Toshiba TC358762 compatible DSI to DBI bridge
> > >  - ATTINY based regulator used for backlight controller and panel ena=
ble
> > >
> > > Support is added via a device-tree overlay. The touch controller is n=
ot
> > > yet supported as polling mode is needed.
> >
> > I'm just integrating the 7in Raspberry Pi display for a customer on an
> > imx8mp. Do you have a (non-mainline) touch driver that works for the
> > Raspberry Pi display? I might fight some time in this project to work o=
n
> > it.
>
> Replying to myself:
>
> Have a look at drivers/input/touchscreen/edt-ft5x06.c
>

Hi Marc,

The specific display I have is the one from DFROBOT which emulates the
original Rpi display as far as I know.

I came up with two different approaches, neither of which I got any
comments from. I haven't spent any additional time on it and have just
been carrying around a custom patch to support it.

You can find my patches here:
https://patchwork.kernel.org/project/linux-input/list/?series=3D596977&stat=
e=3D%2A&archive=3Dboth
- add support for DFROBOT touch controller
https://www.spinics.net/lists/linux-input/msg76457.html - proposal of
adding a new driver

There's possibly a newer version of the patch that adds a new driver
on a 6.1 kernel here:
https://github.com/Gateworks/linux-venice/commit/5bf0ffcf0352b45c29d33184e9=
33a35dd53f27bb

Is this the same touch controller you are working with?

Best Regards,

Tim
