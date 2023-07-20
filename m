Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895DA75A7EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjGTHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjGTHgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:36:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945C32128;
        Thu, 20 Jul 2023 00:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DA70618CE;
        Thu, 20 Jul 2023 07:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBECC433C8;
        Thu, 20 Jul 2023 07:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689838596;
        bh=LUim4iA1rEub4ej24cVAaFE7IsrgANMEUpzqZntSILI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usRSBvj8U0AaHPn97SViZPgjuRb8lRk7g+sTio4mdTyn+2ankpEU0thg6RPJuRdDz
         1bFfiv0jgE63H7a0l7ZMdWe7bTeUdb5d/m2BZ3rRoTMnFfDwyt9m0FUOrmSW5grpTx
         N96FmCncpvUwyniMVSl0v3MLG1uLcQ3t8WepgGh9Wc56SMxp2vSDBVl1/D/SnKgJ/h
         HFF+z05OUytKYuOTy93v8+ee4qR/Qsa2P1951rgfd/wuLb+nlT+n5/QQAJ+ng8V0wD
         zgSJO9HiU2QkFJCoslq5gnzJwpk7MRtGhGlETKbIVh4lYI1jOGiWuToWEeqq8/4NX5
         51eZnAOxNMbgQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMODL-0007Re-07;
        Thu, 20 Jul 2023 09:36:43 +0200
Date:   Thu, 20 Jul 2023 09:36:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mohsen Tahmasebi <moh53n@moh53n.ir>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mostafa Ghofrani <mostafaghrr@gmail.com>
Subject: Re: [PATCH v2] USB: serial: option: add Quectel EC200A module support
Message-ID: <ZLjkC88x39tEX28c@hovoldconsulting.com>
References: <20230710075218.8895-1-moh53n@moh53n.ir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710075218.8895-1-moh53n@moh53n.ir>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:22:18AM +0330, Mohsen Tahmasebi wrote:
> Add Quectel EC200A "DIAG, AT, MODEM":
> 
> 0x6005: ECM + RNDIS + DIAG + AT + MODEM

This device appears to only have four ports. Can you switch between ECM
and RNDIS using some AT command?

Does the device use the same PID in RNDIS mode?

Or is RNDIS perhaps not at all supported?

I've applied the patch after dropping RNDIS above and with the minor
changes below, but please clarify this so I can update the commit
message if needed (e.g. if this should have said "ECM/RNDIS" or
similar).

> T:  Bus=01 Lev=01 Prnt=02 Port=05 Cnt=01 Dev#=  8 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=6005 Rev=03.18
> S:  Manufacturer=Android
> S:  Product=Android
> S:  SerialNumber=0000
> C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
> I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=88(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
> 
> Signed-off-by: Mohsen Tahmasebi <moh53n@moh53n.ir>
> Tested-by: Mostafa Ghofrani <mostafaghrr@gmail.com>
> ---
> V1 -> V2: Add proper changelog text
> 
>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 288a96a74266..ed4405efc18f 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -271,6 +271,7 @@ static void option_instat_callback(struct urb *urb);
>  #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
>  #define QUECTEL_PRODUCT_EM061K_LCN		0x6009
>  #define QUECTEL_PRODUCT_EC200T			0x6026
> +#define QUECTEL_PRODUCT_EC200A			0x6005

Next time, please keep the PID defines sorted by value.

>  #define QUECTEL_PRODUCT_RM500K			0x7001
>  
>  #define CMOTECH_VENDOR_ID			0x16d8
> @@ -1228,6 +1229,7 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200A, 0xff, 0, 0) },

And the device-id entries sorted alphabetically.

>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
>  
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },

Johan
