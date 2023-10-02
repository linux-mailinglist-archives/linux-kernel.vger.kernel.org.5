Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E0D7B4AEC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 05:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbjJBDcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 23:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjJBDcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 23:32:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A1CC9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 20:32:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5045cb9c091so18490966e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 20:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696217520; x=1696822320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWv/fAJ8KXJqmxtsUaOg9Lo1TrGsfrhH4MozFvJpS0M=;
        b=gS/pN2Edhq+rLqrKXln44wHZCiUrE6izL6wxoamJCCPnEyOQX75NOngyNlH2K0Vdd9
         2uFaQl00zQvbNEpW/WeWdSwIgLqTYpKxkuwlmUJVnPJsLBmYkSAF1OOFWMyoo+5fHZQv
         +W4b8duWLKBvUqLlaDg+DM3zYH7bOdeczJ4xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696217520; x=1696822320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWv/fAJ8KXJqmxtsUaOg9Lo1TrGsfrhH4MozFvJpS0M=;
        b=hvwV7PXKb1Ymiij/SM2Xx2jVxCOwLWoJJTexWMciAJmitMk3Fay2UKH+p/ofLXkhKT
         RyG8dxARZlQ+SsZCF6XmjpBSry2JHx7rYLicbja09u86Oz36M7paKzbXt5LUHWytCjnC
         V8seaa5damVczN71qngkWXqjyEW0pn8g71BUpgX/9DBCaJC4bhU99hPqZ4YCdeAz9/98
         +8vEoWxGD2uGcCTERmpJAj3zgFETThqJkLqCtSKFKWh+XuvBfBMuCAIuWEdqBaew+VI6
         Q9yHc9bT4d6OZzD6i2AcH4iD+Q3zhF28U1VW5nGOs4pMV2Y7InYIRmE+Y/KsmT+OkPe4
         L6DA==
X-Gm-Message-State: AOJu0YwSDEjIM5jYVy7R4vh4UJ/z5+AgFuYfmUcYbUz2jAZWNg+xGTAz
        qL2qc6wJGJzRq2Hh60vhyYVblN2fgcM8oSEZgYcCoQ==
X-Google-Smtp-Source: AGHT+IHA/+yPyNmWeR7RlmC08qBdT/8fj4Ys1puQzDzqaq+77KqxGiTyXpFVIt9j9xUiIEMQNJy+1PX4h78yu3Mw35g=
X-Received: by 2002:a05:6512:b8b:b0:4ff:aeef:b582 with SMTP id
 b11-20020a0565120b8b00b004ffaeefb582mr10046958lfv.66.1696217520317; Sun, 01
 Oct 2023 20:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com> <52BBF3AC-ED0B-4B5B-8773-E7C3E0DBED73@public-files.de>
In-Reply-To: <52BBF3AC-ED0B-4B5B-8773-E7C3E0DBED73@public-files.de>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 2 Oct 2023 11:31:49 +0800
Message-ID: <CAGXv+5GLG0UErUyzVExjfpOiVx=JmBs_FRgj=jsXYwcv6duLZA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
To:     frank-w@public-files.de
Cc:     linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        matthias.bgg@gmail.com, robh@kernel.org, amergnat@baylibre.com,
        arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 3:55=E2=80=AFPM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> Am 29. September 2023 10:20:09 MESZ schrieb AngeloGioacchino Del Regno <a=
ngelogioacchino.delregno@collabora.com>:
> >I am a top reviewer mainly for MediaTek SoC related patches in most
> >subsystems and I've also been upstreaming both improvements, fixes
> >and new drivers and devicetrees when required.
> >
> >The MediaTek scene saw a generous increase in number of patches that
> >are sent to the lists every week, increasing the amount of required
> >efforts to maintain the MTK bits overall, and we will possibly see
> >even more of that.
> >
> >For this reason, and also because of suggestions and encouragement
> >coming from the community, I'm stepping up to be a co-maintainer of
> >MediaTek SoCs support.
> >
> >Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@col=
labora.com>
> >---
> >
> >P.S.: I tried to reach to Matthias for almost two months, but I couldn't
> >find any way to talk to him and he has been unresponsive on the mailing
> >lists as well.
> >
> >P.P.S.: This also comes after Rob Herring's suggestion to have myself as
> >a MediaTek SoC co-maintainer [1] and support from other people.
> >
> >[1]: https://lore.kernel.org/all/20230804225813.12493-1-robh@kernel.org/
> >
>
> Hi,
>
> Thank you Angelo for supporting Matthias here. I also have no information=
 why his tree is stale for more than 2 months and also got no response on d=
irect contact. I hope he is still ok and do only need some free time.
>
> I waiting for these to be merged:
>  https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D76129=
3   https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D7777=
12
>
> Do you have created an own tree from matthias' one or can you directly wo=
rk on it? If working on own tree please send me the link,so that i can trac=
k when changes (also from others) are merged.

It's likely going to be under a new namespace. Matthias used his own
namespace, which is not shared.
AFAIK the kernel.org git infrastructure doesn't allow others to push
to a user's namespace.

> regards Frank
>
