Return-Path: <linux-kernel+bounces-142151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B960E8A2823
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4650EB2203F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2144CE0F;
	Fri, 12 Apr 2024 07:33:06 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31CB482DA;
	Fri, 12 Apr 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907185; cv=none; b=hLNFlzkVNzdZ7AvLW6XTCeffbRVgNtWjry3O7V6UbKMWeCjX0z4Pryxkz3YePGdqwgb4sqyEpxgpQ1rm+4nVVozLXdUwwm5OlWEzbOa06wvlGldSkak7SZ2wgm4hBaqERmxx6qgtSZRF92BVsM8v8nB/YHuF0h6sLin80JY9ZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907185; c=relaxed/simple;
	bh=Mt8IzKrTJIg0OktXcVnjo6qucYM6NxyBrcGfo6gQT70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVO5YWB9V21mBvH/Y4/qY0j+TwVqpgv6rwtjSizCbH27W2TVsvb0WXJAJj52Wv1gbUFlkTDvAZjMvSQScXn1cVXvUO/R1cHtbOjIXpAXLgPS+sMYKdqIaVWydtMqHVlREO64XT+9iV2eRVlWycD94gVavCdCBCbLAgjCD6ia/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.18.169.210] (ip-185-104-138-49.ptr.icomera.net [185.104.138.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 40BCE61E5FE01;
	Fri, 12 Apr 2024 09:32:20 +0200 (CEST)
Message-ID: <74e93b3c-66c2-45e6-a1e1-0679ac59371c@molgen.mpg.de>
Date: Fri, 12 Apr 2024 09:32:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Bluetooth: btusb: Add USB HWID to usb_device_id table
 for Acer NB
To: Jiande Lu <jiande.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Chris Lu <chris.lu@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
 Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
 linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20240412064307.6478-1-jiande.lu@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240412064307.6478-1-jiande.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jiande,


Thank you for your patches. Some minor comments from side.

Am 12.04.24 um 08:43 schrieb Jiande Lu:
> From: "jiande.lu" <jiande.lu@mediatek.com>

I’d spell your name Jiande Lu:

     $ git config --global user.name "Jiande Lu"
     $ git commit --amend -s --author="Jiande Lu <jiande.lu@mediatek.com>"

For the commit message summary/title, I’d use:

Bluetooth: btusb: Add USB HW ids for MT7921/MT7922/MT7925

> This commit add HWID for wireless modules specific to Acer

This commit add*s* is redundant. Just use imperative mood: Add HW ids for …

> notebook models to ensure proper recongnition and functionality

recognition

> 
> Https://acer.com/tw-zh/support/product-support/
> SFE16-42/NX.KH5TA.0.01/downloads

Please put it in one line and spell the schema https:// all lowercase.

It’d be great if you listed the models in the commit message too, and 
mentioned, on what device you tested your change.

> Signed-off-by: jiande.lu <jiande.lu@mediatek.com>
> ---
> v4: Update title
> ---
> v3: Fix patch fail
> ---
> v2: Update commit description and fix typo
> ---
> ---
>   drivers/bluetooth/btusb.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c391e612b83b..b71efca2af73 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -616,6 +616,9 @@ static const struct usb_device_id quirks_table[] = {
>   	{ USB_DEVICE(0x0e8d, 0x0608), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH |
>   						     BTUSB_VALID_LE_STATES },
> +	{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },

Unfortunately, these entries are not sorted by the id. Can you please 
send a follow-up patch to sort the ids in these sections?

>   	/* MediaTek MT7922 Bluetooth devices */
>   	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
> @@ -662,11 +665,32 @@ static const struct usb_device_id quirks_table[] = {
>   	{ USB_DEVICE(0x35f5, 0x7922), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH |
>   						     BTUSB_VALID_LE_STATES },
> +	{ USB_DEVICE(0x13d3, 0x3614), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },
> +	{ USB_DEVICE(0x13d3, 0x3615), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },
> +	{ USB_DEVICE(0x04ca, 0x38e4), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },
> +	{ USB_DEVICE(0x13d3, 0x3605), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },
> +	{ USB_DEVICE(0x13d3, 0x3607), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },

Please sort the entries.

>   	/* Additional MediaTek MT7925 Bluetooth devices */
> +	{ USB_DEVICE(0x0489, 0xE113), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },

Lowercase: 0xe113

>   	{ USB_DEVICE(0x13d3, 0x3602), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH |
>   						     BTUSB_VALID_LE_STATES },
> +	{ USB_DEVICE(0x13d3, 0x3603), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },
>   
>   	/* Additional Realtek 8723AE Bluetooth devices */
>   	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },


Kind regards,

Paul

