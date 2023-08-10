Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0D6777E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjHJQfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjHJQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C72698;
        Thu, 10 Aug 2023 09:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E7D866239;
        Thu, 10 Aug 2023 16:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0D1C433CB;
        Thu, 10 Aug 2023 16:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691685343;
        bh=tAd8cGqWXnMp+MhyA+QN6jDgfWonWi3hyrZySG4ENN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JXB07tmP1/SRRe6/WnKUKx+EHTRS4Y+3pwfbddMMxRPcFQgijA8lk9u7PsqrzAkcb
         kP3L1o8hmC2780WNQmMuCB98OLnqSNHNpst0XbcQN4U+D0MqFxhb1++CSDuDDSlYsx
         zEvn5o1aiaKfFVqGZ2mlqpuw/FZRIzikDM+Lerc99HGS/COF6NHA4bWhPk2XiZ/tll
         vaAH7atcMxYLNbmf9yylYAkTRcpYaSZWddJelDqvyW6JheiuC95U0ElFUlouJ1DYda
         r747Yp2U8Ikh2VPT4HapI39XQUSd9GoQ5JOmBvFGHPyH9P/X2RQ/VqUhFY8A+PPNVN
         tL5YcKIQnCRgg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b9d3dacb33so17202611fa.1;
        Thu, 10 Aug 2023 09:35:43 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx190o8ay6zWaIjwADPq+RUNcgM9Irxm2d+4Kmb/4K7kA/KBjtK
        UVbdtTY/9h2GDCEzswTbVhV3oscGIVf3f2A/NQ==
X-Google-Smtp-Source: AGHT+IGMhThSGcH6iK3+zXMwVeXv9qRB2ftg4Knvd20JgbzEnsxMFjNJQ8haNG3+I9TXP94jb4Whom2WJEFxRHLe5Aw=
X-Received: by 2002:a2e:3c11:0:b0:2b6:a804:4cc with SMTP id
 j17-20020a2e3c11000000b002b6a80404ccmr2488397lja.53.1691685341671; Thu, 10
 Aug 2023 09:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
 <20230810063300.20151-2-krzysztof.kozlowski@linaro.org> <169165201641.3911557.18445521260746432395.robh@kernel.org>
 <137a734e-0e5a-5fcb-f0d3-1fdbb5e8da34@linaro.org>
In-Reply-To: <137a734e-0e5a-5fcb-f0d3-1fdbb5e8da34@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Aug 2023 10:35:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL-x5V2mJOCgDC8xoHuvu6A1enQh-idmxGJjy80A9fdow@mail.gmail.com>
Message-ID: <CAL_JsqL-x5V2mJOCgDC8xoHuvu6A1enQh-idmxGJjy80A9fdow@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] ASoC: dt-bindings: mediatek,mt8188-mt6359: use
 common sound card
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Judy Hsiao <judyhsiao@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rao Mandadapu <srivasam@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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

On Thu, Aug 10, 2023 at 1:47=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/08/2023 09:20, Rob Herring wrote:
> >
> > On Thu, 10 Aug 2023 08:32:50 +0200, Krzysztof Kozlowski wrote:
> >> The mediatek,mt8188-mt6359 Linux sound machine driver requires the
> >> "model" property, so binding was incomplete.  Reference the common sou=
nd
> >> card properties to fix that which also allows to remove duplicated
> >> property definitions.  Leave the relevant parts of "audio-routing"
> >> description.
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@col=
labora.com>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  .../bindings/sound/mediatek,mt8188-mt6359.yaml  | 17 +++++++---------=
-
> >>  1 file changed, 7 insertions(+), 10 deletions(-)
> >>
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> >
>
> I think the bot responds like this if the patch could not be applied.
> Probably we can ignore it.

It's because I converted dtschema to use pyproject.toml (the newest
and 3rd way to do python packaging). I started getting deprecation
warnings on debian testing due to using setup.py. Converting breaks on
ubuntu 22.04. Seems to be this bug[1]. The CI job should now be fixed
by installing the latest pip version.

Rob

[1] https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/2018288
