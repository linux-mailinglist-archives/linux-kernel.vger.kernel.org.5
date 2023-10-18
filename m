Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7267CD11F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 02:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjJRAH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 20:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJRAH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 20:07:27 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4DF9F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 17:07:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so67568041fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 17:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697587642; x=1698192442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL5IHSgiOPCaseF8jxFxoTKSJkLG4FnIxMof3Q5FawM=;
        b=clXo2BuXwWDeIGHWv6y1m7WBxmQt5y7kTjRrxV5RlJ7+e4RmwbCkHBdPYHWmcpday+
         e6/HW3c/+1HuhSfRrVOBwA1ph13ytHoAh4u9tVwWF6VttJOHf9tMh8KJN6OzKDL8RuLd
         1ElbON6TzF86S9AhHUnouq75QrEyuySIsu1+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697587642; x=1698192442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL5IHSgiOPCaseF8jxFxoTKSJkLG4FnIxMof3Q5FawM=;
        b=Tb3epPu+4CHEbGFmNzgWtwp3KXO/drwnziwvuhQl0ud4YihSVWNlKo2uxO+7KLsOn2
         qN+i4gf0g2Sye9XeCS+bs+BeHgCVXBmbnRN9zbMoty6omp2ZLZNZxKximn7WchBtkhss
         stsZ+EJKlb+IDSrLXBq1a5Ye/zrCNZNgI1QM0sDB7SgJ+Kk6cpsLWvOUzbneN/r5P/8y
         WYpDnX+co0CrlComNKHHMANnoPb1JQrV/z0m79D761zBFEm3+tiN1uGKhuYKPk+BbqML
         r4TEhBHDoDE7s27IqPVzTprOWrz0JvdCODaWyOZ7SnSfL3L5dpKuTkfos0L0ONs1uUTF
         lrSg==
X-Gm-Message-State: AOJu0YziwH31b3OHZePDRdAbhDMBnp71xoyksSDdZRMqVVjkOsIn8y9Z
        Le+BM+0rAGAoZL+eDKuLAAW4ASPMx17saVYZztp/Wg==
X-Google-Smtp-Source: AGHT+IHdYpQ7b2GTg0pg2e6yXIg3WUzgg6FphjxIscthWaEOsQp4Vnpo/InQm+NVk8R54x4Et7gna/2lIz01hIOxMHE=
X-Received: by 2002:ac2:598c:0:b0:507:a33f:135d with SMTP id
 w12-20020ac2598c000000b00507a33f135dmr2672443lfn.4.1697587641970; Tue, 17 Oct
 2023 17:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231017190545.157282-1-bero@baylibre.com>
In-Reply-To: <20231017190545.157282-1-bero@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 17 Oct 2023 17:07:10 -0700
Message-ID: <CAGXv+5FwkBU3wfyZWWaiOgzLACfMVs4Bnu2KM4oSCUa28SzXVw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Add LVTS support for mt8192
To:     =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dunlap@infradead.org,
        e.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        ames.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 17, 2023 at 12:05=E2=80=AFPM Bernhard Rosenkr=C3=A4nzer
<bero@baylibre.com> wrote:
>
> Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTe=
k MT8192 SoC.
> Also, add Suspend and Resume support to LVTS Driver (all SoCs),
> and update the documentation that describes the Calibration Data Offsets.
>
> v5 changes are a lot smaller than originally assumed -- commit
> 185673ca71d3f7e9c7d62ee5084348e084352e56 fixed the issue I
> was originally planning to work around in this patchset,
> so what remains for v5 is noirq and cosmetics.

I see two series in my inbox and on the mailing list. Which one is the
correct one?

Thanks
ChenYu

> Changelog:
>    v5 :
>         - Suspend/Resume in noirq stage
>         - Reorder chipset specific functions
>         - Rebased :
>             base-commit: 4d5ab2376ec576af173e5eac3887ed0b51bd8566
>
>    v4 :
>         - Shrink the lvts_ap thermal sensor I/O range to 0xc00 to make
>           room for SVS support, pointed out by
>           AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora=
.com>
>
>     v3 :
>         - Rebased :
>             base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e
>         - Fix issues in v2 pointed out by N=C3=ADcolas F. R. A. Prado <nf=
raprado@collabora.com>:
>           Use filtered mode to make sure threshold interrupts are trigger=
ed,
>           protocol documentation, cosmetics
>         - I (bero@baylibre.com) will be taking care of this patchset
>           from now on, since Balsam has left BayLibre. Thanks for
>           getting it almost ready, Balsam!
>
>     v2 :
>         - Based on top of thermal/linux-next :
>             base-commit: 7ac82227ee046f8234471de4c12a40b8c2d3ddcc
>         - Squash "add thermal zones and thermal nodes" and
>             "add temperature mitigation threshold" commits together to fo=
rm
>             "arm64: dts: mediatek: mt8192: Add thermal nodes and thermal =
zones" commit.
>         - Add Suspend and Resume support to LVTS Driver.
>         - Update Calibration Data documentation.
>         - Fix calibration data offsets for mt8192
>             (Thanks to "Chen-Yu Tsai" and "N=C3=ADcolas F. R. A. Prado").
>         https://lore.kernel.org/all/20230425133052.199767-1-bchihi@baylib=
re.com/
>         Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>
>     v1 :
>         - The initial series "Add LVTS support for mt8192" :
>             "https://lore.kernel.org/all/20230307163413.143334-1-bchihi@b=
aylibre.com/".
>
> Balsam CHIHI (5):
>   dt-bindings: thermal: mediatek: Add LVTS thermal controller definition
>     for mt8192
>   thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
>   thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
>   arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones
>   thermal/drivers/mediatek/lvts_thermal: Update calibration data
>     documentation
>
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 454 ++++++++++++++++++
>  drivers/thermal/mediatek/lvts_thermal.c       | 163 ++++++-
>  .../thermal/mediatek,lvts-thermal.h           |  19 +
>  3 files changed, 634 insertions(+), 2 deletions(-)
>
> --
> 2.42.0
