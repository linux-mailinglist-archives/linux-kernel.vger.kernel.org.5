Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E58769732
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjGaNIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjGaNI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:08:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1967C1BE5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:07:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso2619358e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690808865; x=1691413665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sloIk4WWUeov37xdllLzD6j7lRUmJiAHMp2I8RnM0nQ=;
        b=PXIv4WwQfZUPVLFdmtmO6wanYZ+Ol6lwdLMgNcjYxT4+ZPqxs1vC98OJfVI/kKv+Bp
         ST/1YvhrXuSdz0U9bdNcG7TNHoDor8Cd67JVrK0Igz9dCCvFJ3DeAHky/y/zV68f7jnb
         /CTpftBeqjrEpoD4Fy9Pq6/nCMBZLob334QXhnlOdXchs02ZrYO5HYY/DW002vpSwQ1N
         LbfAphyjIITncn82tuK5vOnTYSfzjAq5LlTA1IrWISZgtPdHLAfBZGC7AlQzFZcOFWsT
         tc/+hq8KF8lVA5DkC43KllU9fg0KeBJw5vHgP/4QIfij3QOntAT+kGm/3Fwj+ahdSRk5
         t9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690808865; x=1691413665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sloIk4WWUeov37xdllLzD6j7lRUmJiAHMp2I8RnM0nQ=;
        b=P5ATI9bY5UrNu+lL2THePpPYefaWngF0o9bFEkmVRTeNc5Kc0XCqsbPamWe7chd1Vp
         mZNajtMQ6272QsP8xZeTvKjUXKWrr+qsKk1S8nuaAFncPLsw5EV1J0N0rYzUKh8BuE7I
         bR2Cf/pwAoVprJ3mge/qsp8amMo3wWXI7VJKXD3Tv+ulX1R88N+/T+WmUHMjqBcdPytD
         yrsIJmLNBiYSUaLOBUz8n5/d5tq/Frk7qcB+N1qe5V8Xvlr9mjDCLaiTo2gRYqaI4wlA
         6uwAL6Lrjb0RZc1joMfDaq2wbJ/G8MACuni5EX6CmBLjeuGKwCKATofN+B37TDPFUmNw
         kL9w==
X-Gm-Message-State: ABy/qLb8MDzZgB2Kwz3xNHw1WlqbYSfiwL6SogYCdJE3bDJ1EPJcdcSM
        5xghtXHJGbKCJ+HeXdN0I0rPwiDK3WMA7XqHPCFe/A==
X-Google-Smtp-Source: APBJJlF8otKcRiEBYT+w5swQvKj8Vmx/DdTyLNpFy7XON+JoUQyxVul5eQy7lVIbhbUN5//cv00xJntHIwYuqlbtBa8=
X-Received: by 2002:a05:6512:358c:b0:4fe:3e89:fcb2 with SMTP id
 m12-20020a056512358c00b004fe3e89fcb2mr141079lfr.34.1690808865288; Mon, 31 Jul
 2023 06:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230731-synquacer-net-v3-1-944be5f06428@kernel.org> <CAMj1kXF_AZ9bFWHPjDURkZUdAdrX0Qh2Q03FNYq99pfrJGtFjQ@mail.gmail.com>
In-Reply-To: <CAMj1kXF_AZ9bFWHPjDURkZUdAdrX0Qh2Q03FNYq99pfrJGtFjQ@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Mon, 31 Jul 2023 16:07:09 +0300
Message-ID: <CAC_iWjKL0ejVAeZfcY7unc2KeM73+_jzXdZ=cn0=XOrYMikfQw@mail.gmail.com>
Subject: Re: [PATCH v3] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 at 13:54, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 31 Jul 2023 at 12:48, Mark Brown <broonie@kernel.org> wrote:
> >
> > As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> > property on ACPI systems") the SocioNext SynQuacer platform ships with
> > firmware defining the PHY mode as RGMII even though the physical
> > configuration of the PHY is for TX and RX delays.  Since bbc4d71d63549bc
> > ("net: phy: realtek: fix rtl8211e rx/tx delay config") this has caused
> > misconfiguration of the PHY, rendering the network unusable.
> >
> > This was worked around for ACPI by ignoring the phy-mode property but
> > the system is also used with DT.  For DT instead if we're running on a
> > SynQuacer force a working PHY mode, as well as the standard EDK2
> > firmware with DT there are also some of these systems that use u-boot
> > and might not initialise the PHY if not netbooting.  Newer firmware
> > imagaes for at least EDK2 are available from Linaro so print a warning
> > when doing this.
> >
> > Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
> > Signed-off-by: Mark Brown <broonie@kernel.org>
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> > ---
> > Changes in v3:
> > - Typo fixes.
> > - Link to v2: https://lore.kernel.org/r/20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org
> >
> > Changes in v2:
> > - Unlike ACPI force what appears to be the correct mode, there are
> >   u-boot firmwares which might not configure the PHY.
> > - Link to v1: https://lore.kernel.org/r/20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org
> > ---
> >  drivers/net/ethernet/socionext/netsec.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
> > index 2d7347b71c41..0dcd6a568b06 100644
> > --- a/drivers/net/ethernet/socionext/netsec.c
> > +++ b/drivers/net/ethernet/socionext/netsec.c
> > @@ -1851,6 +1851,17 @@ static int netsec_of_probe(struct platform_device *pdev,
> >                 return err;
> >         }
> >
> > +       /*
> > +        * SynQuacer is physically configured with TX and RX delays
> > +        * but the standard firmware claimed otherwise for a long
> > +        * time, ignore it.
> > +        */
> > +       if (of_machine_is_compatible("socionext,developer-box") &&
> > +           priv->phy_interface != PHY_INTERFACE_MODE_RGMII_ID) {
> > +               dev_warn(&pdev->dev, "Outdated firmware reports incorrect PHY mode, overriding\n");
> > +               priv->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
> > +       }
> > +
> >         priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
> >         if (!priv->phy_np) {
> >                 dev_err(&pdev->dev, "missing required property 'phy-handle'\n");
> >
> > ---
> > base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> > change-id: 20230727-synquacer-net-e241f34baceb
> >
> > Best regards,
> > --
> > Mark Brown <broonie@kernel.org>
> >

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
