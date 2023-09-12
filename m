Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0922279CBFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjILJhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjILJhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:37:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA5912E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:37:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-502984f5018so7493658e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694511449; x=1695116249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzOy9+i/I3/0IAop11I8QZ9KuzjqNEblUBdj8hE/TNs=;
        b=Nm7qZQfVf5AWdNieynLmPeauzFxFDRSwv8fpI16YYB1ro732yfRwT4lx45H+6hzTZB
         4cddXMmRi99xqbfZKL//EEEeZeC8GrW48UkECqSz5PKTN6zWCCAE6RQ4CX6HD68v9LQQ
         HyMvSBq9liGWlszeTX/oHB9zsxPa5P6dW6IY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694511449; x=1695116249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzOy9+i/I3/0IAop11I8QZ9KuzjqNEblUBdj8hE/TNs=;
        b=edwxfQfYsED6pIDHvckEucH3YFTE5ocDUJdO1JvJSvv0JDqqN8do19zb4F5Mb7xh0Z
         FfJUwfYy5oBxYxnbvXJK2IcD+5nOhcYhi+twarCT3YVbwskUfoVyjLk+tmUhYmdH+gTA
         mYTgvm69AEwYZqM7pmSBy7CZAQXFO4jKD3GfbDLEheSswOzQ+o6SquenHKpnA1Oa1Ttq
         o5TS8IfuitXtS90EOMzyi3x2hNx6KDvmosBI2GDQi+Y1uXXNgTULwS0BH39+QJDL9wxz
         4ph6ieSsWJ3sBrql8nvShwQ/cl+HOUdfeXZIWrozOJKal6F9pkg5sTo6jZeW6NBKMtiY
         /71g==
X-Gm-Message-State: AOJu0Yz7IzuPuNofujygvsSbONqYteVT3aEl4DueatNQsAGhbqMaHjpJ
        QoKmb5kzVJxptlqwaQCWTanEYUHLYKPAcWrSpp0SSA==
X-Google-Smtp-Source: AGHT+IE5nYxQfZ/p5JEjeqA28AdkacyPuXzw3SozYcbXSTHvYQRz83ev3q6BCV7+1dnYJ4QqMVA8anjAE8x57wQR11Q=
X-Received: by 2002:a05:6512:2829:b0:4fd:fecf:5d57 with SMTP id
 cf41-20020a056512282900b004fdfecf5d57mr10819604lfb.39.1694511448719; Tue, 12
 Sep 2023 02:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230912075805.11432-1-moudy.ho@mediatek.com> <c0bd7428-1330-58c5-64d2-78af479dfcf4@collabora.com>
In-Reply-To: <c0bd7428-1330-58c5-64d2-78af479dfcf4@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 12 Sep 2023 17:37:17 +0800
Message-ID: <CAGXv+5FhsKVGwoJxLP=-gV+rSHbQ8DUX0YACy0mPxYw+MC85=g@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] add support MDP3 on MT8195 platform
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Moudy Ho <moudy.ho@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 5:00=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 12/09/23 09:57, Moudy Ho ha scritto:
> > Changes since v4:
> > - Rebase on v6.6-rc1
> > - Remove any unnecessary DTS settings.
> > - Adjust the usage of MOD and clock in blending components.
> >
> > Changes since v3:
> > - Depend on :
> >    [1] https://patchwork.kernel.org/project/linux-media/list/?series=3D=
719841
> > - Suggested by Krzysztof, integrating all newly added bindings for
> >    the mt8195 MDP3 into the file "mediatek,mt8195-mdp3.yaml".
> > - Revise MDP3 nodes with generic names.
> >
> > Changes since v2:
> > - Depend on :
> >    [1] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek=
/list/?series=3D711592
> >    [2] MDP3: https://patchwork.kernel.org/project/linux-mediatek/list/?=
series=3D711618
> > - Suggested by Rob to revise MDP3 bindings to pass dtbs check
> > - Add parallel paths feature.
> > - Add blended components settings.
> >
> > Changes since v1:
> > - Depend on :
> >    [1] MDP3 : https://patchwork.kernel.org/project/linux-mediatek/list/=
?series=3D698872
> >    [2] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek=
/list/?series=3D684959
> > - Fix compilation failure due to use of undeclared identifier in file "=
mtk-mdp3-cmdq.c"
> >
> > Hello,
> >
> > This patch is used to add support for MDP3 on the MT8195 platform that
> > contains more picture quality components, and can arrange more pipeline=
s
> > through two sets of MMSYS and MUTEX respectively.
> >
> > Moudy Ho (14):
> >    arm64: dts: mediatek: mt8183: correct MDP3 DMA-related nodes
> >    arm64: dts: mediatek: mt8195: add MDP3 nodes
>
> Please send the DTS patches separately, those go through a different main=
tainer.

I thought most people prefer the _full_ view in a patchset?

> P.S.: The dt-bindings patch can be sent inside of this series, please do =
that.
>
> Thanks!
> Angelo
>
>
