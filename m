Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD317AC9EC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjIXOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:09:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB53FA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 07:09:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BF6C43395;
        Sun, 24 Sep 2023 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695564569;
        bh=hzaEJsc/MvyTSiwHDbUNHX3pHjivtFFehSFljD3hx+8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JM4HtDoi5L9D14lI5GjMrgBYkePbSfp+99S9Vxtv2UgpN6rzsdjlKCjQQ3Ot9n34Y
         tMMnyMNOz6LtOPhj3Jy2SurZw80l3tQUw36I8sua/AgmCkMdj5SCrCTgk1ZdTkGu3v
         GB2O6xlqj3GT01oaMFF5LLs9BrvuZASKoIlXlFVQCj5XFNM/h42GWVCQ10pr4cozh1
         y23Uw1Lw8PMUyefeFQsBVlxUThZjxCEejfo4Gm3jhmZSWb6riwO7WAfxK4hC1R0chU
         xjhOrfjk+wTonCh0qL5tty5G9ZA3OuJLUYlpioJ1CnV+hLPgV8e4aMAeCVoWpeVBCR
         NyTpgJBHn4JPA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50307759b65so7844258e87.0;
        Sun, 24 Sep 2023 07:09:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YwxjspVuwoTSdq/Xsx0blGUo59cnbum7G5K6hd2j00B6IeeJdH9
        AnJmxFth4Sv6A0WY7OOM5wRbIEKKkjnbCJQceA==
X-Google-Smtp-Source: AGHT+IGJ8a+c8899BJiT8DoTZkR0LqKr6jfxQvm+fUmHwVYOOXPzJ4ByxiWLhAZmxxEqpxpqDluyHoh50ZPqstltjjY=
X-Received: by 2002:a19:3803:0:b0:4fb:89b3:3373 with SMTP id
 f3-20020a193803000000b004fb89b33373mr3292427lfa.43.1695564567547; Sun, 24 Sep
 2023 07:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230822024155.26670-1-shuijing.li@mediatek.com>
In-Reply-To: <20230822024155.26670-1-shuijing.li@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 24 Sep 2023 22:09:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-xEunh0AOKTYEWn6BV5DM9zU81gsP38P1x1a-3FnpQXg@mail.gmail.com>
Message-ID: <CAAOTY_-xEunh0AOKTYEWn6BV5DM9zU81gsP38P1x1a-3FnpQXg@mail.gmail.com>
Subject: Re: [PATCH v6,0/4] Add compatible to increase MT8188 audio control
To:     Shuijing Li <shuijing.li@mediatek.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
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

Hi, Shuijing:

Shuijing Li <shuijing.li@mediatek.com> =E6=96=BC 2023=E5=B9=B48=E6=9C=8822=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8810:41=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add dt-binding documentation of dp-tx for MediaTek MT8188 SoC.
> Mainly add the following two flag:
>
> 1.The audio packet arrangement function is to only arrange audio
> packets into the Hblanking area. In order to align with the HW
> default setting of g1200, this function needs to be turned off.
>
> 2.Due to the difference of HW, different dividers need to be set.
>
> Base on the branch of linus/master v6.4.

For this series, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Shuijing Li (4):
>   dt-bindings: display: mediatek: dp: Add compatible for MediaTek MT8188
>   drm/mediatek: dp: Add the audio packet flag to mtk_dp_data struct
>   drm/mediatek: dp: Add the audio divider to mtk_dp_data struct
>   drm/mediatek: dp: Add support MT8188 dp/edp function
>
>  .../display/mediatek/mediatek,dp.yaml         |  2 ++
>  drivers/gpu/drm/mediatek/mtk_dp.c             | 36 ++++++++++++++++++-
>  drivers/gpu/drm/mediatek/mtk_dp_reg.h         | 23 ++++++++----
>  3 files changed, 54 insertions(+), 7 deletions(-)
>
> --
> 2.40.1
>
