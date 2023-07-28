Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3597663B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjG1FqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG1FqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:46:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F209935AD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1153961FCD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F53C433C8;
        Fri, 28 Jul 2023 05:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690523158;
        bh=bXg8BOFDCBRkgEdmVW5LzCWvnDGdPy1ePQLapozkYLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SFDJsONLk3ChdAsI4YH1Qys0BPE+ne9tSusb25cOXfCqrvkDLsYo32Ty2nGEhM9AH
         s526ho+IdNDIRNuS+haenPnsOC91cIlBY1E1QHNvFKuuK/fAO+Qx7mNUtmS3i86lUq
         zGI4MDgainrt902m6p2U6kCqjQ2dyUoxiWFVARqDtHE6I/igGMD4BkTxXCuGUqpGEW
         GcMVD6yHR6vQZAXkvMhaHA8AvBuj5bcQVPCdnd8zt3if5XbrRi6dyyYMPB8IKHKUq+
         XwiuybhCfXvvUTbM5vjJpBH95uY08X6baby2BprNkcbQj0vhNs32+BVEVrWRtiiYWr
         rT7z+JtpfHNhw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fdd31bf179so2959616e87.2;
        Thu, 27 Jul 2023 22:45:58 -0700 (PDT)
X-Gm-Message-State: ABy/qLb42qgOgv/7i+Kr8AlvA4sAAzW776yaK0cI2h1sgout0SypMfpa
        /rTqNgQu1rMrHbj+5bCE/nN4j1XcoW68RLf7iM8=
X-Google-Smtp-Source: APBJJlEf2EWPMr2EtPxznEkh00y1MLDF1i7AA7sSnM3UzBnKAWa9VhFPOoeUH2HM/hV3iozs1qjnJ66obFdMyBjAEIU=
X-Received: by 2002:a19:e041:0:b0:4f8:70f8:d424 with SMTP id
 g1-20020a19e041000000b004f870f8d424mr751228lfj.65.1690523156367; Thu, 27 Jul
 2023 22:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
In-Reply-To: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Jul 2023 07:45:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
Message-ID: <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
Subject: Re: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
To:     Mark Brown <broonie@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc Masahisa)

On Thu, 27 Jul 2023 at 23:52, Mark Brown <broonie@kernel.org> wrote:
>
> As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> property on ACPI systems") the SocioNext SynQuacer platform ships with
> firmware defining the PHY mode as RGMII even though the physical
> configuration of the PHY is for TX and RX commits.  Since
> bbc4d71d63549bc ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> this has caused misconfiguration of the PHY, rendering the network
> unusable.
>
> This was worked around for ACPI by ignoring the phy-mode property but
> the system is also used with DT.  Since the firmware used with DT is the
> same (the firmware interface is selectable in the firmware
> configuration) and the firmware configures the PHY prior to running the
> OS we can use the same workaround.
>

Wouldn't this break SynQuacers booting with firmware that lacks a
network driver? (I.e., u-boot?)

I am not sure why, but quite some effort has gone into porting u-boot
to this SoC as well.


> Limit this to the SynQuacer, though practically speaking this is the
> only currently known system using this device.
>
> Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/net/ethernet/socionext/netsec.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
> index 2d7347b71c41..ae4d336efaa4 100644
> --- a/drivers/net/ethernet/socionext/netsec.c
> +++ b/drivers/net/ethernet/socionext/netsec.c
> @@ -1845,10 +1845,20 @@ static int netsec_of_probe(struct platform_device *pdev,
>  {
>         int err;
>
> -       err = of_get_phy_mode(pdev->dev.of_node, &priv->phy_interface);
> -       if (err) {
> -               dev_err(&pdev->dev, "missing required property 'phy-mode'\n");
> -               return err;
> +       if (of_machine_is_compatible("socionext,developer-box")) {
> +               /*
> +                * SynQuacer reports RGMII but is physically
> +                * configured with TX and RX delays, since the
> +                * firwmare configures the PHY prior to boot just
> +                * ignore the configuration.
> +                */
> +               priv->phy_interface = PHY_INTERFACE_MODE_NA;
> +       } else {
> +               err = of_get_phy_mode(pdev->dev.of_node, &priv->phy_interface);
> +               if (err) {
> +                       dev_err(&pdev->dev, "missing required property 'phy-mode'\n");
> +                       return err;
> +               }
>         }
>
>         priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
>
> ---
> base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
> change-id: 20230727-synquacer-net-e241f34baceb
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>
