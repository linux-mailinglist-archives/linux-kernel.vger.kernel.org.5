Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C216E759E41
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjGSTLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSTLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:11:47 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850321BF3;
        Wed, 19 Jul 2023 12:11:46 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1b038d7a5faso5969675fac.1;
        Wed, 19 Jul 2023 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689793905; x=1692385905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yawocYEJ44V0eHQLJuZe86F3h3cwFvu38nD+qkGCl5c=;
        b=DJiOlhEE2RklGMQv2eKPVbLCkXO6As3b59Rcyp/9poyvIj9TAGmk/6sarD2QgdiNRr
         GjJeGLxJe8lKoFEH+Un3VclURyZv4CA1p8x3VMGZgb+31HuEdFrpMvICI3qw/hgMLW51
         mpySn2hgHj765/TGFJf7KQCZQrrVqmi/OoGh2LyqoUaNmW82N0k7fIwqPht0YWKIS3wi
         gmqe4bTkhnSDM/LTBLV2oPw95NCQsPlzGhxW0Joq7ZEpUwS3FxhNInraIriMpQMbbcAj
         t/8O3Gz94cV7pCW8X1Qvns7q6dcTTxnfi8LHyVbtVaFm9jERpJSMtQ4nwEdl1c9S7pqd
         1TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689793905; x=1692385905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yawocYEJ44V0eHQLJuZe86F3h3cwFvu38nD+qkGCl5c=;
        b=c023IkAI2RqbO/zTc0SInxkFa0CGn9koG8K5fa2uOXvawoTbhCXOOT4icMNhLvg4Or
         SpjHKiQSCOVi+yMuQATbdwpt/eeSkgg/nRCJOP2OUno0rS3EZ7eg7AzYSKsMjjq18qc5
         plXa8nz29tk6c06f3Q6WrYbOV9bt6Dlgdllud4bnEwpG5giEa3MS8VC95MM72RwMMQfU
         i6Z0Ea7aWxceLkqcE1ozm1s4Jig23rqsBjLt9iOGt37hUf+AXtsxNTP9iCNDDOA51Lje
         2qW1rUh9reyKwB6EPU/pZH7VgECpdEKtRRo5Vva2pikRAJ6SXfkPthLRvISQlycN22rh
         LwIQ==
X-Gm-Message-State: ABy/qLYDLynv7XZJSeGrGMd1+stzkgObyDoY7ORin6BWifNdB1MGvh8y
        T2F1oAz9qX8AMH7hczMjJ1Zw92TL4VmiSYSnGGFy37B8QUNOlQ==
X-Google-Smtp-Source: APBJJlGptWfcIcTTronFnKnMMIshwN3gP7pSWP7bAHwZjMet49AEuwP+SHndRnhbKpqCIKbb2NIUYsTAA7pI+BqUwgE=
X-Received: by 2002:a05:6870:8a1f:b0:1ba:df9e:f2e9 with SMTP id
 p31-20020a0568708a1f00b001badf9ef2e9mr1845566oaq.0.1689793905589; Wed, 19 Jul
 2023 12:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230719160048.2737423-1-james.hilliard1@gmail.com>
 <20230719160048.2737423-2-james.hilliard1@gmail.com> <15268646-a38f-f530-4c04-1164617d2b25@linaro.org>
In-Reply-To: <15268646-a38f-f530-4c04-1164617d2b25@linaro.org>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 19 Jul 2023 13:11:33 -0600
Message-ID: <CADvTj4oPjGZzjJzjRNXprF1Nz9Hmn=Qs+s=0cke5e3Lb27YLFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6q: Add Variscite MX6 Custom board support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:18=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> > +
> > +&ldb {
> > +     status =3D "okay";
> > +
> > +     lvds-channel@0 {
> > +             fsl,data-mapping =3D "spwg";
> > +             fsl,data-width =3D <24>;
> > +             status =3D "okay";
>
> Again, why do you need it? Is it disabled?

I think so?
https://github.com/torvalds/linux/blob/v6.5-rc2/arch/arm/boot/dts/nxp/imx/i=
mx6qdl.dtsi#L87
