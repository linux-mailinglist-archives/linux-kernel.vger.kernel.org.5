Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5482679CF47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjILLHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjILLGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:06:25 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0061719
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:06:09 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58fc4d319d2so54689897b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694516768; x=1695121568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxeKap40n9N0Jct85TnQoxJYlNgRlyoVOdviavwIIv8=;
        b=hxq6TJF8HMyjqFW1Zxj5wQy1nlsOBDVUSQnjCPAO0BVV49/32UolcLMMwgtEfQWxyv
         h4KosWWVPrmcXDdlZOUVS+2dCFfDhBd6Em++i+z2reqCPZrd0ImmfnuMmnfKN6zIvugq
         2KTPCzv5M24UwOzFIOZx4yi1NQlTPeMw62b7O8oTRekmb/y+bYtpInRDkDnaMlfayAyI
         neLIU1iQKoa9CjJzkM0Yn0yqAc8Zo2ZeT1aCIRbGTx70HMWniIL08xkUs74lAjyCEAYU
         z2CnZW5bBcTDJjce7yw4JLl7STtIHtp5lb5ZOvZe6pCnSJwlymassacuIIjo37MwyAJ0
         rvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694516768; x=1695121568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxeKap40n9N0Jct85TnQoxJYlNgRlyoVOdviavwIIv8=;
        b=NqX8BWG+bGDjVkiEszrlL4261uAtPkpoL3P2MdfK5DMrGvEeFPMG0FAZjM/GMWyzcy
         F+7Ei71WCdzh34rWdpGdHyNO8cyAaWcNNQu3bctxXwGipQTJZ9baJlsLcfr6fxB6SvjN
         +CLU0DQTheXPwWRFvS/qLOoqxDibdz4wdDgr6reNLcKBO1b/Og7f/tJMxKOeD9v8+a/r
         vbzAtGQEbQ2tDGDg6bp4Da/RK/P0Qg5AZPwes6LlMMg5E5o7Qe/J3133pePgZSOOrGFX
         FUEB9c66j/WFPD4mCZox9OuYPGV5mVeViztSMJm5gkVEgXvm28ft8G5S+PwNnKP34i7Q
         xjnw==
X-Gm-Message-State: AOJu0YyfHHaKxJKzcGJ9/Lij1b53nAIlvZ/5v81z7Hmdxl4Rbd13ID+R
        9JFb68kG0xhAHHn6nI9ojRluQm8J0rMfgvGFb0S8lw==
X-Google-Smtp-Source: AGHT+IGyZPp4TVH1sBukbcNRmYX2EySx2o/za6wxn39EVFdbUk9RivbE+m6qOSfkNS/rkWMpLDTgnTAoDhF0TgN1JVo=
X-Received: by 2002:a5b:743:0:b0:d79:d23f:b49c with SMTP id
 s3-20020a5b0743000000b00d79d23fb49cmr10905306ybq.35.1694516768133; Tue, 12
 Sep 2023 04:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230912081527.208499-1-herve.codina@bootlin.com> <20230912101510.225920-1-herve.codina@bootlin.com>
In-Reply-To: <20230912101510.225920-1-herve.codina@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 13:05:57 +0200
Message-ID: <CACRpkdZ2svQJVG4wiJu90X6HhKudMuAerz12zw2nd84ekLaEJA@mail.gmail.com>
Subject: Re: [PATCH v5 29/31] MAINTAINERS: Add the Lantiq PEF2256 driver entry
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
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:15=E2=80=AFPM Herve Codina <herve.codina@bootlin=
.com> wrote:

> After contributing the driver, add myself as the maintainer for the
> Lantiq PEF2256 driver.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8b987f2c8633..dbc5867016bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11876,6 +11876,15 @@ S:     Maintained
>  F:     arch/mips/lantiq
>  F:     drivers/soc/lantiq
>
> +LANTIQ PEF2256 DRIVER
> +M:     Herve Codina <herve.codina@bootlin.com>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
> +F:     drivers/net/wan/framer/pef2256/
> +F:     drivers/pinctrl/pinctrl-pef2256-regs.h
> +F:     drivers/pinctrl/pinctrl-pef2256.c

Just use a glob expression:
F:     drivers/pinctrl/pinctrl-pef2256-*

Yours,
Linus Walleij
