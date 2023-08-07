Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE59772FF2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjHGTzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjHGTzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D710F8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4C50621AE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF1BC433C7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691438114;
        bh=I7YekNGJ+q77+BCcHkYasGTompOMy1uYPX3HwJjAgxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ccR8/zzJEiIQEg1wdkmJigITfBlfj+ryyuCmb6X2Hk6nuDF2xPb1/1b21h2Rh5BRg
         8zylV1ylRpA9oBlundvuk+jslPrip8a0E75eYNBv+jlPjm5UwaGGWyQWov9dCgoxpa
         i+fwq8Q8Jhr9D45kayhvJjFNMk+x3Hr19VnVY5jOkp21rcX9Tk21C7fvQijEH7IohQ
         TKiBxglhBXywVX7ZDDKtbUA3glXvnsZt0jaXD61VB20oRtYUqCCgpuPZWVutUNJ1Sd
         KscZ6ZQCq5JAoQxcU5x6wQ3vTemWmAbNxhms9zrataX4x3hp7khNlV1HwkYFwIeY1H
         QNVzzilp1v00g==
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2681223aaacso3240883a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 12:55:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YztHF+QXygbFRgQv5vSBDBIztT1dwhO1GmBiVeC0PsO0iyDMlJZ
        986dDlk8VszcbZwmeYfLegYYn2EMG+xjvinok5U5LQ==
X-Google-Smtp-Source: AGHT+IFjzk2KfzcRhjSxPtvwMq4e2tlrWhN5WnNUHI5MSPdHZu92vftmpqlZaDWH8qW186T/PB8hhO33+aFTk7CHL5o=
X-Received: by 2002:a17:90a:889:b0:268:2af6:e48c with SMTP id
 v9-20020a17090a088900b002682af6e48cmr9504287pjc.4.1691438113884; Mon, 07 Aug
 2023 12:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230807004256.25609-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230807004256.25609-1-yang.lee@linux.alibaba.com>
From:   Robert Foss <rfoss@kernel.org>
Date:   Mon, 7 Aug 2023 21:55:03 +0200
X-Gmail-Original-Message-ID: <CAN6tsi7rpi6kePZQc7i_nS-84rz7cixWW6znBm_NqocnhKMAaQ@mail.gmail.com>
Message-ID: <CAN6tsi7rpi6kePZQc7i_nS-84rz7cixWW6znBm_NqocnhKMAaQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm: bridge: dw_hdmi: clean up some inconsistent indentings
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 2:43=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.com>=
 wrote:
>
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c:332 dw_hdmi_cec_suspend() w=
arn: inconsistent indenting
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D6101
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/=
drm/bridge/synopsys/dw-hdmi-cec.c
> index be21c11de1f2..14640b219dfa 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> @@ -329,9 +329,9 @@ static int __maybe_unused dw_hdmi_cec_suspend(struct =
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

NAK

The value of maintaining the git blame history is higher than
following the correct whitespace
