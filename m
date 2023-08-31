Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9CC78E6FA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243464AbjHaHMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjHaHMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:12:37 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9301A3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:12:34 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7a505727e7eso237882241.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693465953; x=1694070753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReysCIs7gq0oi5nUfD4Oni43aeEvSwKZl5a77+O+C1o=;
        b=oZpyqN9fMbqWp8XgrNXehC3toF4nAqF9j2Y1kctJnmMViwjsA+DNYQXbKNyoer8YO0
         C2xLOuAN53/6QuuIwndWVEauzMEfhzoR8KRr4dYshakUukXSrRKwR4PbNhqMJNEK1nFB
         C9+MtoomwwgFzOAqO+oOb+0GP528qafzRL+LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693465953; x=1694070753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReysCIs7gq0oi5nUfD4Oni43aeEvSwKZl5a77+O+C1o=;
        b=WWIfPthBeXjVBpIHDCxCmkPqFmP0XTbkCcz9Ih6f7bDrdl18Qlgm1r/BEfpuWrTxa+
         a+KAhRNRZn9aE4Y1uhBegYYW15fvij2kxfMtfSLqWBgZipKR2c1euATC/qwepkUBRR+4
         aVg41m3IbJ6ZSF4f7NBqN+qerTVB3fYxGfBHInC+0ppi+RjBINuUNM2vNrbUVecImOT3
         ugXkRXjx6f19ph0DXFb1D7X4PsfPysMkiY0E4bdTE89P9ZeCWdMWRBNYkCp4dSCdIUla
         +2aLdnIPTf2tb+NzZQqaMaOfs2vU6lrMAzg+6OrjbN+mtUuSWlho0hef0jscKojj+Et/
         PJJg==
X-Gm-Message-State: AOJu0YxlNhC0qExFrlBmOxZorp65bldP2nPhKnBSEVjLv44qjZcEvmEF
        wtjnsSL5qzmo2n6FHM8kYEkQ31dCvjyrlsol9zjFgg==
X-Google-Smtp-Source: AGHT+IEneBwezWd78+nn9jl49tfxl8BZvYZXgWguzLYuo4e9Q+XIEon8QDAlyMWu54MCqddD8Jskma2vLyFTYNb89kU=
X-Received: by 2002:a67:cd11:0:b0:44e:dd14:24a4 with SMTP id
 u17-20020a67cd11000000b0044edd1424a4mr4319898vsl.29.1693465953651; Thu, 31
 Aug 2023 00:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230725073234.55892-10-angelogioacchino.delregno@collabora.com>
 <20230825120109.3132209-1-mwalle@kernel.org> <5b438dba-9b85-4448-bc89-08a11ddb822a@notapiano>
 <fc6c054941420ac2d016496ccbeecad4@kernel.org> <00f65d49-497c-4ade-a2f3-7a5b7ad803b6@notapiano>
 <18bfffdd7ce3bd7693c8362b28651b49@kernel.org> <cce6f9c2-e0b6-47e4-ae1c-9a3d8a4e4b02@notapiano>
 <7a3257dddac78c46408341253a3286f4@kernel.org>
In-Reply-To: <7a3257dddac78c46408341253a3286f4@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 31 Aug 2023 15:12:22 +0800
Message-ID: <CAGXv+5E4nWSuZdHmRhgYDUG4WhYs5o+-ZQBh3pnd2T_fdf9Edg@mail.gmail.com>
Subject: Re: [PATCH v7 09/11] drm/mediatek: dp: Add support for embedded
 DisplayPort aux-bus
To:     Michael Walle <mwalle@kernel.org>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, angelogioacchino.delregno@collabora.com,
        airlied@gmail.com, amergnat@baylibre.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, ehristev@collabora.com,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
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

On Wed, Aug 30, 2023 at 7:11=E2=80=AFPM Michael Walle <mwalle@kernel.org> w=
rote:
>
> >> While digging through the code I realized that all the outputs and
> >> pipelines
> >> are harcoded. Doh. For all the mediatek SoCs. Looks like major
> >> restriction
> >> to
> >> me. E.g. there is also DSI and HDMI output on the mt8195. I looked at
> >> the
> >> downstream linux and there, the output is not part of the pipeline.
> >> Are you
> >> aware of any work in that direction?
> >
> > I'm not sure I get what output and pipelines are hardcoded that you're
> > referring
> > to (besides the one in the mtk-dsi/dpi driver that you already sent the
> > patch
> > fixing).
>
> Have a look at [1]. That main path ends with the DP_INTF0 which is the
> eDP output. But from what I understand that path can also use the DSI
> output. But that is a pattern for all the paths in that file. Looks like
> all supported boards in the kernel will have the output type for a given
> SoC/path (or maybe the mt8195 is the first one which supports different
> output interfaces).
>
> If you have a look at the mediatek kernel instead [2], there the last
> part of the path is not fixed, but there is also a .conn_routes property
> by which you seem to be able to choose the actual output interface.
>
> I was just curious if you know of any development for that (or similar)
> in the kernel.

This is probably because support for this SoC began with Chromebooks,
which have fixed and defined uses for the pipelines. I suspect that
what you are working on is much more flexible.

The driver should be made to allow dynamic selection of outputs, as
is commonly seen with other drivers, but I don't know if that's on
anyone's TODO list.

ChenYu

> > And I'm not familiar with the DSI and HDMI output support on MT8195, so
> > I can't
> > help with that.
> >
> > Thanks,
> > N=C3=ADcolas
>
> [1]
> https://elixir.bootlin.com/linux/v6.5/source/drivers/gpu/drm/mediatek/mtk=
_drm_drv.c#L210
> [2]
> https://gitlab.com/mediatek/aiot/bsp/linux/-/blob/mtk-v5.15-dev/drivers/g=
pu/drm/mediatek/mtk_drm_drv.c?ref_type=3Dheads#L425
