Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB88812D56
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443740AbjLNKts convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 05:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443716AbjLNKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:49:47 -0500
X-Greylist: delayed 307 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Dec 2023 02:49:53 PST
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5981E10F;
        Thu, 14 Dec 2023 02:49:53 -0800 (PST)
Received: from [10.10.1.198] ([84.226.64.168]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LgJO6-1rahYl3X9Q-00nlIy;
 Thu, 14 Dec 2023 11:44:36 +0100
Message-ID: <34f364a5ed0703b562b631efa1f3cd1fd8f3a93a.camel@ziswiler.com>
Subject: Re: [PATCH v3] wifi: mwifiex: add extra delay for firmware ready
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        stable@vger.kernel.org
Date:   Thu, 14 Dec 2023 11:44:29 +0100
In-Reply-To: <20231208234029.2197-1-yu-hao.lin@nxp.com>
References: <20231208234029.2197-1-yu-hao.lin@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.1 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:XeA/xXqrmulH1plKeWO0XxF2pnY5I9eUikZ1d+Eg2nx5HVSmlu6
 UQSW5RY8/TQmpHT8FK/kjCI0oQgf4eMlCo62ZKFedOyOLjGVvTStfK7h3S3S5FmJ4/9PU3S
 pdl2Yu0KcqHGH3HzHElQ4dVB8xnY4/1TFMUH12hDhOR6/Iwo/x2a1zYa1oao6Agzds5EmEg
 5gxbhKsTP6EQJxpTI6eNw==
UI-OutboundReport: notjunk:1;M01:P0:fP6UGUopE7c=;FLVEd0jnlTpVRgmon88h/Q8qtvR
 OjiMLM29xt+lGFHEGefMsnL8kXnnTwRxoJSJFSYRI5vXKTnTfg4gX5n3zml/Nglx03FJYSfI9
 C0EMJMCawL+RTTun5W5joMvDZ0S6YICefjPXNiWZPBkBIUnHSGSlhjrlYhioAHye6dkryJeDX
 cHqHbJEXXfb2yUkgZiH/Y7U2wJer8yOMQ2JD+O2h54yg04pFo23JLEhB4s0RlBTgAHUFadGfN
 VP7IlZUCucjDmpjM5/rBhvY7v/sMfQxij2Pf95OXpXy6qstLNY0rqW+HRLFckST6nZ6o9psS7
 Y0McWog8eBMmZcKTsg/8fIO96oGRsthMl42aE+NlgNvT3WNCKHVth+e3K7I6qCbmyZRkcW7qS
 d+7MbK+rawPMTjfejRtQVLBCD3s3H4C49tYVT93wInC2aYmCzMf9XzNG5J4A1ruJlQRW2adl2
 NOtAW0tW9PQVPoARaF7AC6//e7aXhzRmQzi1Jja9MDduyg5QQ315XGGdL1QXx8JcSWPofXPth
 v2YDiThWtjuxo78wxQ7Qpa2QmYSobgJbxeIqFzoJR783d/alSnZEvxWTsN92XEBsxspRYZxCk
 0TXEOB4px1QIgjD9bN1xRyNPDg4vPUS8KWFlK8xKlBnQM1iH0efiurL3fNNhg57O5Nealoe+o
 ubwltyfJ4mfLQXaTfOM0XE+15VxdL8q0xlPhUyTKWcGjMwjgp9LwMnCDjTS+65RrmXoHDHDTS
 aA0rLJ56rnFvNv1jS2QzdHBapk8Wr0Ix8JUbafEhnOU0AdTkLyCb4wOagZJROUMP5TJ7m9Hkg
 O7giSIVxFob06LdNkTr6r0ClXAk447glbubpVRU0zVCJJ0+Fr4By3Bf8k0QPSOIyEseyXBJdb
 cjznSj+HF5fosOg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-12-09 at 07:40 +0800, David Lin wrote:
> For SDIO IW416, due to a bug, FW may return ready before complete
> full initialization.

BTW: What makes you think this issue is exclusive to the IW416?

We have also seen this in the past both on our Verdin iMX8M Mini (SDIO/SDIO) and Verdin iMX8M Plus (SDIO/UART)
with 88W8997.

good case:

[    6.496541] mwifiex_sdio mmc0:0001:1: info: FW download over, size 594556 bytes
...
[    7.272436] mwifiex_sdio mmc0:0001:1: WLAN FW is active
[    7.314958] mwifiex_sdio mmc0:0001:1: Unknown api_id: 5
[    7.347647] mwifiex_sdio mmc0:0001:1: info: MWIFIEX VERSION: mwifiex 1.0 (16.92.21.p55) 
[    7.355977] mwifiex_sdio mmc0:0001:1: driver_version = mwifiex 1.0 (16.92.21.p55) 

bad case:

[    8.720216] mwifiex_sdio mmc0:0001:1: info: FW download over, size 594556 bytes
...
[   24.976699] mwifiex_sdio mmc0:0001:1: FW failed to be active in time
[   24.983098] mwifiex_sdio mmc0:0001:1: info: _mwifiex_fw_dpc: unregister device

> Command timeout may occur at driver load after reboot.
> Workaround by adding 100ms delay at checking FW status.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Cc: stable@vger.kernel.org
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com> # Verdin AM62 (IW416)

> ---
> 
> v3:
>    - v2 was a not finished patch that was send to the LKML by mistake
>    - changed check condition for extra delay with clear comments.
>    - added flag to struct mwifiex_sdio_device / mwifiex_sdio_sd8978 to
>      enable extra delay only for IW416.
> ---
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 19 +++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/sdio.h |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> index 6462a0ffe698..ef3e68d1059c 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> @@ -331,6 +331,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8786 = {
>  	.can_dump_fw = false,
>  	.can_auto_tdls = false,
>  	.can_ext_scan = false,
> +	.fw_ready_extra_delay = false,
>  };
>  
>  static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 = {
> @@ -346,6 +347,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 = {
>  	.can_dump_fw = false,
>  	.can_auto_tdls = false,
>  	.can_ext_scan = true,
> +	.fw_ready_extra_delay = false,
>  };
>  
>  static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 = {
> @@ -361,6 +363,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 = {
>  	.can_dump_fw = false,
>  	.can_auto_tdls = false,
>  	.can_ext_scan = true,
> +	.fw_ready_extra_delay = false,
>  };
>  
>  static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 = {
> @@ -376,6 +379,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 = {
>  	.can_dump_fw = true,
>  	.can_auto_tdls = false,
>  	.can_ext_scan = true,
> +	.fw_ready_extra_delay = false,
>  };
>  
>  static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
> @@ -392,6 +396,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
>  	.fw_dump_enh = true,
>  	.can_auto_tdls = false,
>  	.can_ext_scan = true,
> +	.fw_ready_extra_delay = false,
>  };
>  
>  static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
> @@ -408,6 +413,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
>  	.fw_dump_enh = true,
>  	.can_auto_tdls = false,
>  	.can_ext_scan = true,
> +	.fw_ready_extra_delay = true,
>  };
>  
>  static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
> @@ -425,6 +431,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
>  	.fw_dump_enh = true,
>  	.can_auto_tdls = false,
>  	.can_ext_scan = true,
> +	.fw_ready_extra_delay = false,
>  };
>  
>  static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
> @@ -440,6 +447,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
>  	.can_dump_fw = false,
>  	.can_auto_tdls = true,
>  	.can_ext_scan = true,
> +	.fw_ready_extra_delay = false,
>  };
>  
>  static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
> @@ -456,6 +464,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
>  	.fw_dump_enh = true,
>  	.can_auto_tdls = true,
>  	.can_ext_scan = true,
> +	.fw_ready_extra_delay = false,
>  };
>  
>  static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
> @@ -471,6 +480,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
>  	.can_dump_fw = false,
>  	.can_auto_tdls = false,
>  	.can_ext_scan = true,
> +	.fw_ready_extra_delay = false,
>  };
>  
>  static struct memory_type_mapping generic_mem_type_map[] = {
> @@ -563,6 +573,7 @@ mwifiex_sdio_probe(struct sdio_func *func, const struct sdio_device_id *id)
>  		card->fw_dump_enh = data->fw_dump_enh;
>  		card->can_auto_tdls = data->can_auto_tdls;
>  		card->can_ext_scan = data->can_ext_scan;
> +		card->fw_ready_extra_delay = data->fw_ready_extra_delay;
>  		INIT_WORK(&card->work, mwifiex_sdio_work);
>  	}
>  
> @@ -766,6 +777,7 @@ mwifiex_sdio_read_fw_status(struct mwifiex_adapter *adapter, u16 *dat)
>  static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
>  				   u32 poll_num)
>  {
> +	struct sdio_mmc_card *card = adapter->card;
>  	int ret = 0;
>  	u16 firmware_stat;
>  	u32 tries;
> @@ -783,6 +795,13 @@ static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
>  		ret = -1;
>  	}
>  
> +	if (card->fw_ready_extra_delay &&
> +	    firmware_stat == FIRMWARE_READY_SDIO)
> +		/* firmware might pretend to be ready, when it's not.
> +		 * Wait a little bit more as a workaround.
> +		 */
> +		msleep(100);
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
> index b86a9263a6a8..cb63ad55d675 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.h
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
> @@ -255,6 +255,7 @@ struct sdio_mmc_card {
>  	bool fw_dump_enh;
>  	bool can_auto_tdls;
>  	bool can_ext_scan;
> +	bool fw_ready_extra_delay;
>  
>  	struct mwifiex_sdio_mpa_tx mpa_tx;
>  	struct mwifiex_sdio_mpa_rx mpa_rx;
> @@ -278,6 +279,7 @@ struct mwifiex_sdio_device {
>  	bool fw_dump_enh;
>  	bool can_auto_tdls;
>  	bool can_ext_scan;
> +	bool fw_ready_extra_delay;
>  };
>  
>  /*
> 
> base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
