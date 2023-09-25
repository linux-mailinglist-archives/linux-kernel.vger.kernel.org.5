Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4187AD663
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjIYKub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjIYKu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:50:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F250C6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A935C433CB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695639022;
        bh=J7kIa1cM5bEdHS4N+xMwZ3c7Uz5zj8sAKah5rpEeCwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hn+BbPts5Ac7rs/t0nB2iQ8+xLazfZxe5oY2zC9Vs9/mldeyPbd7Ce1czztMgQD1h
         4tPVkAVfwpGiqTBtscdGt76JGnMirT/+N9QcFaASOsY9xkMJ1tgfl2K8oUqx2YzXT0
         IrkaDteE922Lh97kZ5i/qqdbTJ0BOhBiekshZk7lO18UMvXIcs5xOfLYT3VcBs00lU
         t1trnea3pWrGKhC+UT+YQ3Qg/42DBbn8rhI2b/U83dMpgvqS27N8BKL+bZ02RnuY2N
         DSjBBOHkxih9ZyIjihgspYig5tXi21vmGq0vDaKixMr2gWIc45Gha/Z9eeaVfxDg9W
         85kC8OxRu7qjw==
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1c4194f769fso41553265ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:50:22 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywza5/JXg+yo9BX/z785Tm+YrVNQ2wcrLECHPxPFGXly/nSvvEU
        x2DAuySn0sPOftrMMNvtHcrtjwmhadxkVx2AU8k/cw==
X-Google-Smtp-Source: AGHT+IGrn8safol45gEMcotPjO8/w+u1uNeKaOoYjqxt2ntm7MxjH3yv23NR6uAUTs77Cl4KNb91lYjntRsnBywifQo=
X-Received: by 2002:a17:90a:4141:b0:268:5431:f2a7 with SMTP id
 m1-20020a17090a414100b002685431f2a7mr4271368pjg.28.1695639022192; Mon, 25 Sep
 2023 03:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230920004400.81091-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230920004400.81091-1-yang.lee@linux.alibaba.com>
From:   Robert Foss <rfoss@kernel.org>
Date:   Mon, 25 Sep 2023 12:50:11 +0200
X-Gmail-Original-Message-ID: <CAN6tsi44s3h3Ox3mK2pi+Mw8pGCB9fgMcoWmJhCenHoK9=t=-w@mail.gmail.com>
Message-ID: <CAN6tsi44s3h3Ox3mK2pi+Mw8pGCB9fgMcoWmJhCenHoK9=t=-w@mail.gmail.com>
Subject: Re: [PATCH -next] drm/bridge: clean up some inconsistent indentings
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAK

Personally I value maintaining a simple to follow `git blame` history
over correcting indentation.

Ideally bad indentation should never be committed in the first place.

On Wed, Sep 20, 2023 at 2:44=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c:336 dw_hdmi_cec_suspend() w=
arn: inconsistent indenting
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/=
drm/bridge/synopsys/dw-hdmi-cec.c
> index 673661160e54..fe2ff4984fc5 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> @@ -333,9 +333,9 @@ static int __maybe_unused dw_hdmi_cec_suspend(struct =
device *dev)
>         struct dw_hdmi_cec *cec =3D dev_get_drvdata(dev);
>
>         /* store interrupt status/mask registers */
> -        cec->regs_polarity =3D dw_hdmi_read(cec, HDMI_CEC_POLARITY);
> -        cec->regs_mask =3D dw_hdmi_read(cec, HDMI_CEC_MASK);
> -        cec->regs_mute_stat0 =3D dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT=
0);
> +       cec->regs_polarity =3D dw_hdmi_read(cec, HDMI_CEC_POLARITY);
> +       cec->regs_mask =3D dw_hdmi_read(cec, HDMI_CEC_MASK);
> +       cec->regs_mute_stat0 =3D dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT0=
);
>
>         return 0;
>  }
> --
> 2.20.1.7.g153144c
>
