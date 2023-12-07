Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD6808D20
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjLGQEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjLGQD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:03:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9194F98
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:04:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2944DC43395
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701965045;
        bh=2FpbQI5Mt0gSqQq/XXJLLf+1SovVdA+maQYMnRTJ0m4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K1poRaLOvXp7vPNZy1zTsvpIEeSRBjZnrNr1knbGToNVPOkTEZeVMv3dLcA9/wUAt
         f/GaW2gY4cuyGpYx/hvja35r+6rddX/MDh2l8j5PS8IiniikINpA6Uw4qcpFwC0NO+
         Qd+MguwDTW8PLznyqXlZKjUO3wTXFaZjWXqHThLNOC+1h2kg7KyKA76KWfgHpa1vZa
         AAHyWxy1mLsVob6lMPjInBaIarOditi64w63T0yENhrTRmxjW0qZgvj/YHcGBexZ0n
         IabUplIYdGOZPkUY7RM0j4klzy91ov/RSobm2wRqcvq5cDqzfETvf+XlknuhT60rp6
         I74mVI0oK+IWw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2c9f751663bso11655141fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:04:05 -0800 (PST)
X-Gm-Message-State: AOJu0YztWAUr+BEo33l7oyN+yqVRgqHnilHH6hOKQhwaSgvWVCuKWUqv
        2N9LsDyOtwWljRoxPj40eHzi0ZiuD6Af+ccKkw==
X-Google-Smtp-Source: AGHT+IF1cG0pFemXauUHVxHSNj9qWubes+vp4DakrHk/R1risj9jDhlo+9GulMhEdM2kdfcyW16MHWWxKi/zTK9166I=
X-Received: by 2002:a05:651c:1030:b0:2ca:bcb:e798 with SMTP id
 w16-20020a05651c103000b002ca0bcbe798mr849220ljm.157.1701965043173; Thu, 07
 Dec 2023 08:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20230412064635.41315-1-yang.lee@linux.alibaba.com>
 <20230412064635.41315-3-yang.lee@linux.alibaba.com> <de13cb5f-abf2-86b3-d2e0-2b1131cd8dfa@baylibre.com>
In-Reply-To: <de13cb5f-abf2-86b3-d2e0-2b1131cd8dfa@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 8 Dec 2023 00:03:51 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-cO3P2GnMPK68GSRJKe8jguCK-cWENiu-3mXaRaHwmMA@mail.gmail.com>
Message-ID: <CAAOTY_-cO3P2GnMPK68GSRJKe8jguCK-cWENiu-3mXaRaHwmMA@mail.gmail.com>
Subject: Re: [PATCH -next 3/3] drm/mediatek: Use devm_platform_ioremap_resource()
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yang:

Alexandre Mergnat <amergnat@baylibre.com> =E6=96=BC 2023=E5=B9=B44=E6=9C=88=
12=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:49=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 12/04/2023 08:46, Yang Li wrote:
> > Remove variable 'res' and convert platform_get_resource(),
> > devm_ioremap_resource() to a single call to
> > devm_platform_ioremap_resource(), as this is exactly what this function
> > does.
> >
> > Signed-off-by: Yang Li<yang.lee@linux.alibaba.com>
>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> --
> Regards,
> Alexandre
>
