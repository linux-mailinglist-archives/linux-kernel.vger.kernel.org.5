Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECB37693CF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjGaKzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjGaKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA010CA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B27961014
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A361DC433CA;
        Mon, 31 Jul 2023 10:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690800857;
        bh=qUUzChgXILMkFs1qWKm4e4VSQjq2/07zqiCyUPEce64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bpo27gCLeApYVC+LxJkQhZV6u6aMqrQ9Pw3VirBR82fLXG5agwvEbP1A4OkV2Csu7
         onVLKYnpcZ0XZdTTIzvyPyNzCuLaF2wL4TmFyHluL5MMbk2leqIoBClHHWoT2AgR6M
         a0SCaRzxUNri8L/pCZ2qzb4Qs1cXhAtnbSFi7+NPVvYxaW/dTBJVxpMop7Qm8bVyV0
         aEw/FU31nRu4VOMhgEWtjObGu+kohpyQdMm5Ylxl3IiqIJFqzT7cA5X0f5hWAPS8nC
         s/KdcalhfsP8tBiHlS7JIoIU9WTrAg1clXwh/RNeEsu1QejlozrPOKhaqhsiKz8WBq
         aU+W6RR/KsiyA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fe216edaf7so3401808e87.0;
        Mon, 31 Jul 2023 03:54:17 -0700 (PDT)
X-Gm-Message-State: ABy/qLY8X9v8le9Nkanj9wSSvDJdbB9Bxlrtf6sWYYoQHrhWeeT+Ys4L
        Wy2IT5mbdyzYoXPLmPNk0jtm+8dOU9vj8zxkq+c=
X-Google-Smtp-Source: APBJJlElcOX/PyaOy/9AdG1EcRLk+Vjf8P0kGiXIhfqI2S1kn+HgBkMGaspKUnSHCkMd8ybRaEMbhhiGxq97FbzdEWw=
X-Received: by 2002:a05:6512:12d4:b0:4fe:28cd:b3f with SMTP id
 p20-20020a05651212d400b004fe28cd0b3fmr1654733lfg.5.1690800855622; Mon, 31 Jul
 2023 03:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230731-synquacer-net-v3-1-944be5f06428@kernel.org>
In-Reply-To: <20230731-synquacer-net-v3-1-944be5f06428@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 31 Jul 2023 12:54:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF_AZ9bFWHPjDURkZUdAdrX0Qh2Q03FNYq99pfrJGtFjQ@mail.gmail.com>
Message-ID: <CAMj1kXF_AZ9bFWHPjDURkZUdAdrX0Qh2Q03FNYq99pfrJGtFjQ@mail.gmail.com>
Subject: Re: [PATCH v3] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
To:     Mark Brown <broonie@kernel.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 at 12:48, Mark Brown <broonie@kernel.org> wrote:
>
> As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> property on ACPI systems") the SocioNext SynQuacer platform ships with
> firmware defining the PHY mode as RGMII even though the physical
> configuration of the PHY is for TX and RX delays.  Since bbc4d71d63549bc
> ("net: phy: realtek: fix rtl8211e rx/tx delay config") this has caused
> misconfiguration of the PHY, rendering the network unusable.
>
> This was worked around for ACPI by ignoring the phy-mode property but
> the system is also used with DT.  For DT instead if we're running on a
> SynQuacer force a working PHY mode, as well as the standard EDK2
> firmware with DT there are also some of these systems that use u-boot
> and might not initialise the PHY if not netbooting.  Newer firmware
> imagaes for at least EDK2 are available from Linaro so print a warning
> when doing this.
>
> Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> Changes in v3:
> - Typo fixes.
> - Link to v2: https://lore.kernel.org/r/20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org
>
> Changes in v2:
> - Unlike ACPI force what appears to be the correct mode, there are
>   u-boot firmwares which might not configure the PHY.
> - Link to v1: https://lore.kernel.org/r/20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org
> ---
>  drivers/net/ethernet/socionext/netsec.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
> index 2d7347b71c41..0dcd6a568b06 100644
> --- a/drivers/net/ethernet/socionext/netsec.c
> +++ b/drivers/net/ethernet/socionext/netsec.c
> @@ -1851,6 +1851,17 @@ static int netsec_of_probe(struct platform_device *pdev,
>                 return err;
>         }
>
> +       /*
> +        * SynQuacer is physically configured with TX and RX delays
> +        * but the standard firmware claimed otherwise for a long
> +        * time, ignore it.
> +        */
> +       if (of_machine_is_compatible("socionext,developer-box") &&
> +           priv->phy_interface != PHY_INTERFACE_MODE_RGMII_ID) {
> +               dev_warn(&pdev->dev, "Outdated firmware reports incorrect PHY mode, overriding\n");
> +               priv->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
> +       }
> +
>         priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
>         if (!priv->phy_np) {
>                 dev_err(&pdev->dev, "missing required property 'phy-handle'\n");
>
> ---
> base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> change-id: 20230727-synquacer-net-e241f34baceb
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>
