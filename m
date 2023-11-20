Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97897F1BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjKTSGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjKTSGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:06:03 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8458EB9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:05:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40837124e1cso3565e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700503557; x=1701108357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1oMCfMGwdX7/yasXUH/6qCLEAX+oZ5Ltl+iiFvw12M=;
        b=F3aMTFdVbNXdY8Mse0KDsQCLURVoUt/Mlj9P/AvoZBo4soUBl4dreiAV98BvDrp91c
         zKsdWlIt9iBILKjfyO/eTHrkoBg1cwF8YVzVwb11o067REXjt7VJo5iMuIXCRaabsa8b
         pdjcn68Yrspcl3OTOCEEvIacvTt1bsgg9XBhqHqcbUZYmyuFUF1AZ/QHcNcNIRKcCis+
         YIAEGv3/8bA2Lp4Gr6v/wd2ZNGWRYbCjfJJubUCzTtxbgSiZnSYPy4zT2Z+rcwzD+Lsd
         MpPt1DvazaD061D9LfhRJcth1HKuw7hN2u2KtQgQO+78KmsNPCU9qioquPScpNPEwGD7
         LYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700503557; x=1701108357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1oMCfMGwdX7/yasXUH/6qCLEAX+oZ5Ltl+iiFvw12M=;
        b=UnMSAlKKxNGh/GkJYlccv2PqF2uqa174wt0PGw4df4GQ0gh1RBZZ4IADRULBdL2nod
         yCWtGWX2k9zUhO5GJTv2X//IpnCWeKH2b7QzVzpZ39XMzNBM1CxKcCUM5ut16brPpEG5
         rPP5N/D1N5Hg65ddtbGrr7rzuH85ngoLMpOzGDmn+oNEwNOrS8QrBmehayWSpbIH42oH
         u0Cx+p/3Vmf0RrGqZ4b6lwOthg0I57x9Bjve9/+4h/+gB3S+iyR/bv7JQPW5T7wHVPwJ
         cqxSNCG35nkVax11CAQ3T5QLXSRGJtd6wyDNr4DcFXRAaHqoeJNUYgR6TKrhNE7Q3irG
         y1uA==
X-Gm-Message-State: AOJu0YxXlXWEl/UMjmzErTuHvxrnP2LKylLfF76EoTYWexeuyvTkTcVD
        yocC/GPR6SlrCdQWH0YIMNjQLiucjPheiJg2dimctQ==
X-Google-Smtp-Source: AGHT+IHWrtCrXcVOwKo199pcpai/48XCtrsULlO6pY+GdNy7QBAZjsD1Hi9YGbmweptlK5z8xbw9Dp3Z1R0tzlykCXs=
X-Received: by 2002:a05:600c:1c83:b0:3fe:eb42:7ec with SMTP id
 k3-20020a05600c1c8300b003feeb4207ecmr273004wms.1.1700503557295; Mon, 20 Nov
 2023 10:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20231120020109.3216343-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231120020109.3216343-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Mon, 20 Nov 2023 10:05:44 -0800
Message-ID: <CAD=FV=WKMrnAqYNHpcKw4=X75Ts_cCkoXZKQ+b7G1pXstUCMRg@mail.gmail.com>
Subject: Re: [PATCH V3] drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02
 panel HFP and HBP
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, zhouruihai@huaqin.com, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 19, 2023 at 6:01=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The refresh reported by modetest is 60.46Hz, and the actual measurement
> is 60.01Hz, which is outside the expected tolerance. Adjust hporch and
> pixel clock to fix it. After repair, modetest and actual measurement were
> all 60.01Hz.
>
> Modetest refresh =3D Pixel CLK/ htotal* vtotal, but measurement frame rat=
e
> is HS->LP cycle time(Vblanking). Measured frame rate is not only affecte
> by Htotal/Vtotal/pixel clock, also affected by Lane-num/PixelBit/LineTime
> /DSI CLK. Assume that the DSI controller could not make the mode that we
> requested(presumably it's PLL couldn't generate the exact pixel clock?).
> If you use a different DSI controller, you may need to readjust these
> parameters. Now this panel looks like it's only used by me on the MTK
> platform, so let's change this set of parameters.
>
> Fixes: 1bc2ef065f13 ("drm/panel: Support for Starry-himax83102-j02 TDDI M=
IPI-DSI panel")
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Chage since V2:
>
> - Update commit message.
>
> V2: https://lore.kernel.org/all/20231117032500.2923624-1-yangcong5@huaqin=
.corp-partner.google.com
>
> Chage since V1:
>
> - Update commit message.
>
> V1: https://lore.kernel.org/all/20231110094553.2361842-1-yangcong5@huaqin=
.corp-partner.google.com
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

As per previous discussions, this seems OK to me. I'll give it one
more day for anyone to speak up and then plan to land it.

-Doug
