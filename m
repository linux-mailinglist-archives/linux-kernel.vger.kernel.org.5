Return-Path: <linux-kernel+bounces-11415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FC381E5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DC71F224E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E3E4CDE5;
	Tue, 26 Dec 2023 08:39:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4388925778;
	Tue, 26 Dec 2023 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af7f4.dynamic.kabel-deutschland.de [95.90.247.244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F2B0461E5FE01;
	Tue, 26 Dec 2023 09:38:53 +0100 (CET)
Message-ID: <e9586bad-0101-415e-ba34-390fd34bf252@molgen.mpg.de>
Date: Tue, 26 Dec 2023 09:38:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btrtl: Add the support for
 RTL8852BT/RTL8852BE-VT
To: Max Chou <max.chou@realtek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex_lu@realsil.com.cn, hildawu@realtek.com, karenhsu@realtek.com
References: <20231226015713.13673-1-max.chou@realtek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231226015713.13673-1-max.chou@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Max,


Thank you for your patch.

Am 26.12.23 um 02:57 schrieb max.chou@realtek.com:
> From: Max Chou <max.chou@realtek.com>
> 
> Add the support for RTL8852BT/RTL8852BE-VT BT controller on USB interface.

It’d be great if you stated, how it differs from the existing devices. 
Judging from your diff, only the ids need to be added.

> The necessary firmware will be submitted to linux-firmware project.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> T:  Bus=02 Lev=02 Prnt=02 Port=05 Cnt=01 Dev#=  8 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0bda ProdID=8520 Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
>   drivers/bluetooth/btrtl.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 277d039ecbb4..cc50de69e8dc 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -69,6 +69,7 @@ enum btrtl_chip_id {
>   	CHIP_ID_8852B = 20,
>   	CHIP_ID_8852C = 25,
>   	CHIP_ID_8851B = 36,
> +	CHIP_ID_8852BT = 47,
>   };
>   
>   struct id_table {
> @@ -307,6 +308,15 @@ static const struct id_table ic_id_table[] = {
>   	  .fw_name  = "rtl_bt/rtl8851bu_fw",
>   	  .cfg_name = "rtl_bt/rtl8851bu_config",
>   	  .hw_info  = "rtl8851bu" },
> +
> +	/* 8852BT/8852BE-VT */
> +	{ IC_INFO(RTL_ROM_LMP_8852A, 0x87, 0xc, HCI_USB),
> +	  .config_needed = false,
> +	  .has_rom_version = true,
> +	  .has_msft_ext = true,
> +	  .fw_name  = "rtl_bt/rtl8852btu_fw",
> +	  .cfg_name = "rtl_bt/rtl8852btu_config",
> +	  .hw_info  = "rtl8852btu" },
>   	};
>   
>   static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
> @@ -645,6 +655,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>   		{ RTL_ROM_LMP_8852A, 20 },	/* 8852B */
>   		{ RTL_ROM_LMP_8852A, 25 },	/* 8852C */
>   		{ RTL_ROM_LMP_8851B, 36 },	/* 8851B */
> +		{ RTL_ROM_LMP_8852A, 47 },	/* 8852BT */
>   	};
>   
>   	if (btrtl_dev->fw_len <= 8)
> @@ -1275,6 +1286,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
>   	case CHIP_ID_8852B:
>   	case CHIP_ID_8852C:
>   	case CHIP_ID_8851B:
> +	case CHIP_ID_8852BT:
>   		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
>   		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
>   
> @@ -1505,6 +1517,8 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bs_fw.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8852btu_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8852btu_config.bin");

Should btu be ordered before bu?

>   MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");


Kind regards,

Paul

