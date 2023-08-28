Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B2478BB12
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjH1Wjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjH1WjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:39:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15726184
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:39:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c09673b006so18163615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693262354; x=1693867154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcWugy4FfAsRRLNZLuk5CmgbDUPnvpdUf0zbh9zIsCo=;
        b=MP73UVnC8bBJVHy9EOZoaC7oTS4K4ufjuIJl8WvnOMcBi9atD5HtD66EJAJj7UrDqz
         Z2V1PadfaFqPbDYzgdKaYtIBWoY2SFh7xMWKf2um0Ziab1SUTqqO3DynvtjftkicUkhZ
         ANZClw9uwndzhHfTwfMWjTFV0HJI3S86QfaofrYGMa8uEtWPr30U1fZK5qH9l+Tn9R5E
         EWXEZuE/9K16EMBPQfrQG4FLJdzC9JHyCEH5buHMk9Bp3mxEx8E4YGPnqQFu3XzzoOWd
         l6eVePBAnfd2ATzxbVLTj1RtiPivm6T6jfWoRs5smJNPUVxbG7VKDyP1q+Y6BlFdrl1B
         9jKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693262354; x=1693867154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcWugy4FfAsRRLNZLuk5CmgbDUPnvpdUf0zbh9zIsCo=;
        b=kOvmXh/dgVKrmOJ01s/uw9Sf2+GfmzfosI6AkOBR7rBSbv6t66OH7MQ3JJKcfDvuu4
         fPllc8FXkadh2s4Moc1gpOoO8+3zl0nn5cRKINOhiO+68QYsrdGE0uh3KqzsoKJ07qmO
         KlHyOLcKB6Dw9sLGWV34xLcqvfOD/pLDa/cS8kkTs2GmkSJ+31f8OWcif1382oIFVspg
         zVeKXti7aHhuiTcEWePSEgACdcYV1dx1gMntU70pK2paLkIk0+NBHFGgcbVtTW5KZa9X
         7rxRum06jTRWV+VKItWDg/vZrJBgyn70GnWU85zrcKf6KQRPac7V20rhr3Wh1E91aSDb
         a/cg==
X-Gm-Message-State: AOJu0YxXRpc/YTxTRVlTC+QSYp5t2g60zMqI7LSJ4TuKyzjguD2F3Xet
        0NSNM1a15wT9cuD1YJuVzj8wEl8Ae1h3xeIHi94=
X-Google-Smtp-Source: AGHT+IGHXO796tTurZs6XtySiM72Rkx3bFG0r8wCpRe3WhLIBaVJBUr0b/cvwAyijyMcVeAMRboJUNzS1fRZjh41zk0=
X-Received: by 2002:a17:90a:7021:b0:268:ac99:4bb4 with SMTP id
 f30-20020a17090a702100b00268ac994bb4mr20964263pjk.46.1693262354315; Mon, 28
 Aug 2023 15:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
 <20230818-samsung-dsim-v1-4-b39716db6b7a@pengutronix.de> <CAOMZO5AFEDMT1de2O2sUUuw8E0ZRCyD4QVVCKxAtfRaisU5gVw@mail.gmail.com>
In-Reply-To: <CAOMZO5AFEDMT1de2O2sUUuw8E0ZRCyD4QVVCKxAtfRaisU5gVw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 28 Aug 2023 17:39:03 -0500
Message-ID: <CAHCN7xLuzWk53dTOM_ySVTGuqNZwCXDiZ236CXavyjSKZp-sRA@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/bridge: samsung-dsim: adjust porches by rounding up
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Michael Tretter <m.tretter@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>, kernel@pengutronix.de,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 1:26=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Michael,
>
> On Mon, Aug 28, 2023 at 12:59=E2=80=AFPM Michael Tretter
> <m.tretter@pengutronix.de> wrote:
> >
> > The porches must be rounded up to make the samsung-dsim work.

...at some resolutions and refresh rates.

>
> The commit log could be improved here.
>
> The way it is written gives the impression that samsung-dsim does not
> work currently.

This is a big improvement in the number of resolutions and refresh rates.

Reviewed-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
Tested-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
