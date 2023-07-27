Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF7A76490E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjG0Hmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjG0HmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:42:19 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BDC7EC4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:36:12 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-486519e5da0so186317e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690443368; x=1691048168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FFoh9fAwBO6Qv5kET29/SxFxnrcdEE+m5hTMz9s4Bg=;
        b=q0HF9MS26IkAFLWMqUaYkeU/ml7JU6fOjvs9mkcMkUYBMQDmB+wteYy1+4vCYvoIT3
         WoCZe0p+GWcSPt34UWC/5idwii1oNdmWCh8ykdoQDamfinn33x/lMWO38wwpjFeqilFJ
         vBR/MiQdXjb1xuGuf8cTiu6h0MmGHmnIHgEDxAGaePq9egp/fkBLzn0k3hRezpr+6W+U
         I+SNjPxtFPpg1egQnlTMq1tVjtDXCct+qevbqsazPTEbHMpcp+iRHhTaF9QchpJJLbsh
         GZy+x5GsF6/NBAbwKdg/jhRA1IeVgbh2+NfehAvQUSKGSyZee5mPx2Xr3oq/J7oB7aiD
         X8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443368; x=1691048168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FFoh9fAwBO6Qv5kET29/SxFxnrcdEE+m5hTMz9s4Bg=;
        b=J4GNsBuJGs2PqVqA4/bv1qj8h21ma/ZlxoJQ1HhdoSsyo7PvLs2D+irM9mQNB5HsfI
         B8OvGKw2omVoNtB2Hf7z4kpK15NTDsKc7Bm7n+7IMVyQLQyKwzSSsCUw2G2HGIiZ1kdD
         Q7O0Va3+r6yCj1bc6XDvoBqimrtVhLby0E06tGVcJpEoglyJr1JnS92hjb3CHv74RmkP
         ujubL+aqbIVqyMA1K/QtSSMf3BBImkWp2JWK7Mv4i5Slst8I8fgubn36LVeM61ewaFX5
         WfIqE/Vb6tX9mOKA7Y2IUKDw128KCewODM8BILBu44Brc/DQ10ceLtnnaT00pnegd7B3
         I2SA==
X-Gm-Message-State: ABy/qLYSeGakRKrFi6Hd9MPa1lXLK0HaxMOTtgJcClJUXw2mUobY0bS1
        H92FliCQ80Zfn+DVKPKSBaUc+bjF+8UwBYNqBWC9qQ==
X-Google-Smtp-Source: APBJJlFvB+57WYpfabIcu2VZAkq5/iTwfaa2jKLHI63ja8RnH7KtCPvmmmTypGsMiDpMYWxiPVIcWf2bRst+1MyVCz0=
X-Received: by 2002:a1f:600a:0:b0:486:3a95:f90 with SMTP id
 u10-20020a1f600a000000b004863a950f90mr420717vkb.5.1690443368460; Thu, 27 Jul
 2023 00:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230725102330.160810-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230725102330.160810-1-peng.fan@oss.nxp.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 27 Jul 2023 09:35:57 +0200
Message-ID: <CAMRc=McLqe9QOd3DFVO=4ByaOtRg+y1u3R4CiStp4P_QTHs+vw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: fsl-imx-gpio: support i.MX8QM/DXL
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, stefan@agner.ch, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 12:18=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add i.MX8QM/DXL gpio compatible which is compatible with i.MX35.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/D=
ocumentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> index ae18603697d7..d0ca2af89f1e 100644
> --- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> @@ -32,10 +32,12 @@ properties:
>                - fsl,imx6sx-gpio
>                - fsl,imx6ul-gpio
>                - fsl,imx7d-gpio
> +              - fsl,imx8dxl-gpio
>                - fsl,imx8mm-gpio
>                - fsl,imx8mn-gpio
>                - fsl,imx8mp-gpio
>                - fsl,imx8mq-gpio
> +              - fsl,imx8qm-gpio
>                - fsl,imx8qxp-gpio
>                - fsl,imxrt1050-gpio
>                - fsl,imxrt1170-gpio
> --
> 2.37.1
>

Applied, thanks!

Bart
