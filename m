Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308197776B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjHJLRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjHJLRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:17:22 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAFE2684
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:17:22 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d5d64d2961aso689174276.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666241; x=1692271041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADRnTf+HtriZ7mqwDU3wWvmXrT7FB+Ztxvgw7H2KXeU=;
        b=QFhKu9tkFZ+fkU1lcY4zVfF0dk/FWoUgZD0eH36Sz7H5E6vylleVAxrx4pnTaXqwhk
         0+gy/gZj3JZk12Km6iz/EZoWzKbi128l5ProuMk6rD8PXzxfQdAWHaHfYFH+hT3tRM5T
         JhuEe8IlHx2uTiKvZWsgQrv6fkFqrBx0+2vETEZCqjNX/pWDMRwL/0BRd5MvDHtFVvKa
         BM/Lp+D9Uqm7WCUrVCer3WiE1OLLbVSPYEz4lyAydeXxxun5B/2ka3EMFk7a+ErH42db
         gw2/aA6IBStBu2S2LDjrdyts3q5jk/zxoySCSTATECPSlKOeat6hCKBGV6ZorzoWY9HV
         DN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666241; x=1692271041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADRnTf+HtriZ7mqwDU3wWvmXrT7FB+Ztxvgw7H2KXeU=;
        b=kQZa1uOl6xVAmR1MeF4HwTe8PeZGLwOqhJijq4K5Dmc4ouDDxv3upJU1Y3s5mWXsIP
         jsNLJSx5ejGd318lbs9b+UqikqpQC7EWXSWiFn0+Z5H5Wo2B81Kxr2U47teWt0rlERp0
         EdoApFa5+KihItZjgIpaQS3k2T1WXZlhCyHOW1ZACcXrdbhRbvtIXZTJ/aqFyTniNjXT
         ogKWD2gn7XWxzTWqOxUQIuETuyKmCZMDUbtVGUPd6BWKSI7TErkXXtoM600gX5DKnfpz
         hbWICctsAfj7VeLjd2xeW5+e1Vtq4Gmp/iSWPOS+tKzYZPiWmNGvlfP5N2f5lVDtUHB/
         TX8Q==
X-Gm-Message-State: AOJu0YwBklj/rZGvFCnn01gAZoqRMGs2PdVAh6otGv+d8UpjVVSucrma
        R7b+4bgLN3E7KIpavrfwXRu30HWbgjJsnssz/6w5Jg==
X-Google-Smtp-Source: AGHT+IG0cc60EKwg6aO/Vl/FWx+h3xKBM7qpk0WTUOrKZYJlTlQ3xEW/05G+n7KdFt0H+qP3lFIXHa3H2q7KcJby2j8=
X-Received: by 2002:a25:250f:0:b0:cea:6760:d2c6 with SMTP id
 l15-20020a25250f000000b00cea6760d2c6mr2046852ybl.41.1691666241474; Thu, 10
 Aug 2023 04:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230809132757.2470544-1-herve.codina@bootlin.com> <20230809132757.2470544-22-herve.codina@bootlin.com>
In-Reply-To: <20230809132757.2470544-22-herve.codina@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 13:17:09 +0200
Message-ID: <CACRpkdZQ9_f6+9CseV1L_wGphHujFPAYXMjJfjUrzSZRakOBzg@mail.gmail.com>
Subject: Re: [PATCH v3 21/28] net: wan: Add framer framework support
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herve,

On Wed, Aug 9, 2023 at 3:28=E2=80=AFPM Herve Codina <herve.codina@bootlin.c=
om> wrote:

> A framer is a component in charge of an E1/T1 line interface.
> Connected usually to a TDM bus, it converts TDM frames to/from E1/T1
> frames. It also provides information related to the E1/T1 line.
>
> The framer framework provides a set of APIs for the framer drivers
> (framer provider) to create/destroy a framer and APIs for the framer
> users (framer consumer) to obtain a reference to the framer, and
> use the framer.
>
> This basic implementation provides a framer abstraction for:
>  - power on/off the framer
>  - get the framer status (line state)
>  - be notified on framer status changes
>  - get/set the framer configuration
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

I love it, very clear commit message telling us what it is all
about.

The placement in the WAN subsystem also hints that this has
something to do with long distance links (relative to something)
so maybe mention that?

> +menu "Framer Subsystem"
> +
> +config GENERIC_FRAMER
> +       bool "Framer Core"
> +       help
> +         Generic Framer support.
> +
> +         This framework is designed to provide a generic interface for f=
ramer
> +         devices present in the kernel. This layer will have the generic
> +         API by which framer drivers can create framer using the framer
> +         framework and framer users can obtain reference to the framer.
> +         All the users of this framework should select this config.

But this description just says this is a framing framer that frames frames =
;)

So please copy some of the nice description from the commit message
into this Kconfig helptext.

Is "long distance link time division multiplexing (TDM) framer" more
to the point for example? Or is the ambition to frame other multiplexing
techniques as well with this subsystem? Such as FDM? Then mention
that.

Yours,
Linus Walleij
