Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487B27FAD48
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjK0WTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjK0WTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:19:04 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398D75FFA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:13:45 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db048181cd3so4554099276.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701123224; x=1701728024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKi3mY9gEWYH12Kzcguh8/xdDNFjc2yj/HRXk8xcrl0=;
        b=L+KKjfYWy/HWQtj7IlGC5nSnq0AROWcLD5UtCMeYYDckNMm9+TvZx4bOq+jGix8UMQ
         kHW1POQ3O2L3HwW43G8rTVKsnGmaaSkc7mCPo6HDsezcZdCAk1yHi88kqq4B5pwXdA/6
         YzONWZksgUxHjk4ffekDD+4IzdmqzeZ2un8eBu3pgCTaLEjiewElOZKbXVbL796ZZT6Q
         9IC/bi+X4SP3/PZhn1aJEoTUcZBqkQF1ohWlE5mkTcWue93O2+IMCa4YUSBGnYa8En7u
         Aot1zHGFiD/GDTxlMM5ZbS7s7at9bUxfhk2Mx0q0QAUQ4u4l610Jmgb/G8aDw/XZajf9
         Sujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123224; x=1701728024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKi3mY9gEWYH12Kzcguh8/xdDNFjc2yj/HRXk8xcrl0=;
        b=iL2Lr52cBXmFD6wd4M2ZH/EplZx7S7eKPho/eapzhQzOgReKwxcz2Uonxf93W/9Z4c
         F9Ipo7SkC9O5P9jSoOXEu2XSRQbTVelFtCqYgeumcFeSGt/KVi9jz82akJKf+fx/lKxF
         zNOE2z3yWIxjhxdfPtE+eerP4wWgsiZo/cFpByYWEdsYUAGT86AQhvYfSkvdDu3yCs+v
         sbJsWmP22c7P0QDvbZ5vwnvQuOvYUDoUv8rfm+lZgPTaF8Hat824aTOs+1Zenz+bzim6
         Qs97bvVTKedE1aL5a4AP5Xfif5FNRYXEcqR3lEg5GDbTW6u1oAoTU/rqPAm0IJxpyzef
         na3A==
X-Gm-Message-State: AOJu0YwX78ddmEJiZ+Z8hekmXIJbs96RWyvf0yQ7NTOdFBKYN9mToDMv
        dL5UXvg8X3FHVh89anh2ZL8spSq3xrkyeDoKr6LEFg==
X-Google-Smtp-Source: AGHT+IFgZ18g6DnXLy7RFiYscXNiAu4gCNhHYaxDE8NSduVNzVKpXKWsD8UbOdacoRARcYAA9beD8h6cHEgYoT90gZo=
X-Received: by 2002:a05:6902:49:b0:d9a:cd50:b99a with SMTP id
 m9-20020a056902004900b00d9acd50b99amr12883192ybh.12.1701123224146; Mon, 27
 Nov 2023 14:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20231127051414.3783108-1-victor.liu@nxp.com> <CACRpkdZAtxh5muhbPKvmUQGtQogs3UhGxNZqnSGWoWQNUL7=9g@mail.gmail.com>
 <k65hxlckssjd46nsrlly6vjrr5nnkrakouzw5pmxgbf6ui3mdl@5ny7j7blkwyj>
In-Reply-To: <k65hxlckssjd46nsrlly6vjrr5nnkrakouzw5pmxgbf6ui3mdl@5ny7j7blkwyj>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Nov 2023 23:13:31 +0100
Message-ID: <CACRpkdbKwycpjuhMfnriqMUcbmwCTb3vJzgzCF7+ARax54q7WQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: panel: Check device dependency before
 managing device link
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Liu Ying <victor.liu@nxp.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, gregkh@linuxfoundation.org,
        rafael@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        angelogioacchino.delregno@collabora.com, ulf.hansson@linaro.org
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

On Mon, Nov 27, 2023 at 5:29=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
> On Mon, Nov 27, 2023 at 05:03:53PM +0100, Linus Walleij wrote:

> > > Liu Ying (2):
> > >   driver core: Export device_is_dependent() to modules
> > >   drm/bridge: panel: Check device dependency before managing device l=
ink
> >
> > I just applied patch 1 directly to the drm-misc-fixes so we don't have =
to
> > revert and then re-apply patches, because that is a bigger evil. (We ca=
n't
> > rebase these branches...)
>
> Erm, you did wait for GKH or Rafael's ACK to do that, right?

No.

It is a bigger evil to leave the tree broken than to enforce formal process=
,
and it is pretty self-evident. If any of them get annoyed about it we can
revert the patch, or both.

Yours,
Linus Walleij
