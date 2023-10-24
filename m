Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777887D4F46
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjJXL5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjJXL5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:57:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DADEBD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:57:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B9CC433C7;
        Tue, 24 Oct 2023 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698148647;
        bh=P/62AzhAT4KUu+utmsfzDa4VRGeCzMsZgfgeMsb7fFQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U38GQfbR3I5gJybWpH3LqCbdHqpdPDApaYa1y7mhdHfH2MA7aXAYD+2IlpfaC18ma
         ay52CdaP3lbY7qoerCPgb9NzBkZaYvVu6JOy6tttoVEA/9mwRg6ZlI0aiqvEeInWsf
         kOd9ellhuLwmoQl6mfxAOuMpu+8dt9wLEIdk/FScqAlOGcsHo8PqLqskRi6YiRSxlr
         NaPcuKp9WnIagQ1fYKvNijy78f+vYKm/NxP7lIuAqlZd/dVtwz/vPsm47pdz6uMMdW
         SXvqgXOgbwqZFCX4/1BYlXn7j2iOMuHpR9lEIalQ/nNPG4+BlxKqWdsLHMuJxaJ+IJ
         XV8pef6DwsLOQ==
Message-ID: <59767fb8-8b9a-472a-884c-009cb00ed0b9@kernel.org>
Date:   Tue, 24 Oct 2023 13:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        andrew@lunn.ch
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2023 17:46, Parthiban Veerasooran wrote:
> The LAN8650/1 is designed to conform to the OPEN Alliance 10BASE‑T1x
> MAC‑PHY Serial Interface specification, Version 1.1. The IEEE Clause 4
> MAC integration provides the low pin count standard SPI interface to any
> microcontroller therefore providing Ethernet functionality without
> requiring MAC integration within the microcontroller. The LAN8650/1
> operates as an SPI client supporting SCLK clock rates up to a maximum of
> 25 MHz. This SPI interface supports the transfer of both data (Ethernet
> frames) and control (register access).
> 
> By default, the chunk data payload is 64 bytes in size. A smaller payload
> data size of 32 bytes is also supported and may be configured in the
> Chunk Payload Size (CPS) field of the Configuration 0 (OA_CONFIG0)
> register. Changing the chunk payload size requires the LAN8650/1 be reset
> and shall not be done during normal operation.
> 
> The Ethernet Media Access Controller (MAC) module implements a 10 Mbps
> half duplex Ethernet MAC, compatible with the IEEE 802.3 standard.
> 10BASE-T1S physical layer transceiver integrated into the LAN8650/1. The
> PHY and MAC are connected via an internal Media Independent Interface
> (MII).
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  MAINTAINERS                              |   6 +
>  drivers/net/ethernet/microchip/Kconfig   |  11 +
>  drivers/net/ethernet/microchip/Makefile  |   2 +
>  drivers/net/ethernet/microchip/lan865x.c | 415 +++++++++++++++++++++++
>  4 files changed, 434 insertions(+)
>  create mode 100644 drivers/net/ethernet/microchip/lan865x.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9580be91f5e9..1b1bd3218a2d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14001,6 +14001,12 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/microchip/lan743x_*
>  
> +MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
> +M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/ethernet/microchip/lan865x.c
> +
>  MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
>  M:	Arun Ramadoss <arun.ramadoss@microchip.com>
>  R:	UNGLinuxDriver@microchip.com
> diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
> index 329e374b9539..596caf59dea6 100644
> --- a/drivers/net/ethernet/microchip/Kconfig
> +++ b/drivers/net/ethernet/microchip/Kconfig
> @@ -59,4 +59,15 @@ source "drivers/net/ethernet/microchip/lan966x/Kconfig"
>  source "drivers/net/ethernet/microchip/sparx5/Kconfig"
>  source "drivers/net/ethernet/microchip/vcap/Kconfig"
>  
> +config LAN865X
> +	tristate "LAN865x support"
> +	depends on SPI
> +	depends on OA_TC6
> +	help
> +      	  Support for the Microchip LAN8650/1 Rev.B0 MACPHY Ethernet chip. It
> +	  uses OPEN Alliance 10BASE-T1x Serial Interface specification.
> +
> +      	  To compile this driver as a module, choose M here. The module will be
> +          called lan865x.

That's odd indentation. Kconfig help goes with tab and two spaces.

> +
>  endif # NET_VENDOR_MICROCHIP
> diff --git a/drivers/net/ethernet/microchip/Makefile b/drivers/net/ethernet/microchip/Makefile
> index bbd349264e6f..1fa4e15a067d 100644
> --- a/drivers/net/ethernet/microchip/Makefile
> +++ b/drivers/net/ethernet/microchip/Makefile
> @@ -12,3 +12,5 @@ lan743x-objs := lan743x_main.o lan743x_ethtool.o lan743x_ptp.o
>  obj-$(CONFIG_LAN966X_SWITCH) += lan966x/
>  obj-$(CONFIG_SPARX5_SWITCH) += sparx5/
>  obj-$(CONFIG_VCAP) += vcap/

...

> +static void lan865x_remove(struct spi_device *spi)
> +{
> +	struct lan865x_priv *priv = spi_get_drvdata(spi);
> +
> +	oa_tc6_exit(priv->tc6);
> +	unregister_netdev(priv->netdev);
> +	free_netdev(priv->netdev);
> +}
> +
> +#ifdef CONFIG_OF

Drop ifdef

> +static const struct of_device_id lan865x_dt_ids[] = {
> +	{ .compatible = "microchip,lan865x" },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id lan865x_acpi_ids[] = {
> +	{ .id = "LAN865X",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, lan865x_acpi_ids);
> +#endif
> +
> +static struct spi_driver lan865x_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +#ifdef CONFIG_OF

Drop ifdef

> +		.of_match_table = lan865x_dt_ids,
> +#endif
> +#ifdef CONFIG_ACPI

Why do you need this ifdef?

> +		   .acpi_match_table = ACPI_PTR(lan865x_acpi_ids),
> +#endif
> +	 },
> +	.probe = lan865x_probe,
> +	.remove = lan865x_remove,
> +};
> +module_spi_driver(lan865x_driver);
> +
> +MODULE_DESCRIPTION(DRV_NAME " 10Base-T1S MACPHY Ethernet Driver");
> +MODULE_AUTHOR("Parthiban Veerasooran <parthiban.veerasooran@microchip.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("spi:" DRV_NAME);

You should not need MODULE_ALIAS() in normal cases. If you need it,
usually it means your device ID table is wrong.


Best regards,
Krzysztof

