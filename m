Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD607B8E01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbjJDU2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjJDU2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:28:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AE493
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:28:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF07C433C8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 20:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696451297;
        bh=ESQvJZctYiv8lN6ltsro47C1eNao1M4P8HhyGWJi1h4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h1x1dXpxsW0znEXAMg1TsOxUEQAeL4mameKwEflZkI3ud72E4SfSnMLv4MTyPJOGK
         91xKEos+lnRlsdOawtcs1w7xjj/NrHk6TkQun8DsZU6AEJZ9kq8yvqhWsCcAP7ToV0
         3GMHy78dDOOJgAnAvr2ii/YekvQwjb2tiYwKcj8h+qj46tO8durP9jmgOwujcb89DT
         1Fcvt0BdxthkDKsconPNNWQjko1VboNg1Q5AJwRe7Wl23lo/dozWL04bt+Kplgmc+I
         i/sX6rb9bwFGm0GxmpG+U6qFYRmMILtd8DUJKRvdgDyKyyQ3S4+2RbKVtrvmaizWbG
         91yqWlSOeijRA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2bfea381255so3116671fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:28:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YwfE2ZwTuM55a8yYwHpEGDtSX1p1WY4c4cyTzpSyuiqzbCwFLS0
        BL/VULQb+or816pRssJuSUWRQuzWPAFZtI+A3g==
X-Google-Smtp-Source: AGHT+IFXJfh8tz1TfG4klEB0mQGxX4Kz28T+ev5c9ShobOxqcsUhL+MV/lbeEpe9jSwPaddrVVnL759EryfLJI5QK0U=
X-Received: by 2002:a05:6512:605:b0:503:1ca6:c590 with SMTP id
 b5-20020a056512060500b005031ca6c590mr2798624lfe.22.1696451275113; Wed, 04 Oct
 2023 13:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-dt-asoc-header-cleanups-v2-0-e77765080cbc@kernel.org>
 <20231004-dt-asoc-header-cleanups-v2-1-e77765080cbc@kernel.org> <72f8f521-93f0-4e3d-929c-f7478622ddb3@sirena.org.uk>
In-Reply-To: <72f8f521-93f0-4e3d-929c-f7478622ddb3@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 4 Oct 2023 15:27:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLw6TKBsTee6U5Yfiz_T7WDt+1LZZNWzW1pL+z9bK5R0w@mail.gmail.com>
Message-ID: <CAL_JsqLw6TKBsTee6U5Yfiz_T7WDt+1LZZNWzW1pL+z9bK5R0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ASoC: Explicitly include correct DT includes
To:     Mark Brown <broonie@kernel.org>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>, nuno.sa@analog.com,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kiseok Jo <kiseok.jo@irondevice.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Ban Tao <fengzheng923@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
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

On Wed, Oct 4, 2023 at 12:39=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Oct 04, 2023 at 10:58:05AM -0500, Rob Herring wrote:
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it was merged into the regular platform bus=
.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those includ=
e
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
>
> This is breaking various builds for me, for example arm64 defconfig:

I believe I got some of the include changes in the wrong place. They
should go into patch 5.

Rob
