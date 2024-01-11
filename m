Return-Path: <linux-kernel+bounces-23387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3665682AC13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE00C1F23B88
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68FB14A9C;
	Thu, 11 Jan 2024 10:33:58 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC614F60;
	Thu, 11 Jan 2024 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (unknown [95.90.244.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5D67861E5FE03;
	Thu, 11 Jan 2024 11:33:45 +0100 (CET)
Message-ID: <9f776426-b01f-4204-b508-485d3f13e933@molgen.mpg.de>
Date: Thu, 11 Jan 2024 11:33:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Disable Power Save feature on
 startup
Content-Language: en-US
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 amitkumar.karwar@nxp.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, sherry.sun@nxp.com, rohit.fule@nxp.com
References: <20240111080642.270123-1-neeraj.sanjaykale@nxp.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240111080642.270123-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Neeraj,


Thank you for your patch. Some nits below.

Am 11.01.24 um 09:06 schrieb Neeraj Sanjay Kale:
> This sets the default power save mode setting to enabled.

This contradicts the commit message summary, which says “Disable”.

> The power save feature is now stable and stress test issues,
> such as the TX timeout error, has been resolved.

have been

Please reference one commit, that fixed this.

> With this setting, the driver will send the vendor command
> to FW at startup, to enable power save feature.
> User can disable this feature using the following vendor
> command:
> hcitool cmd 3f 23 03 00 00 (HCI_NXP_AUTO_SLEEP_MODE)

It would help me, if you used the full 75 characters per line for commit 
messages, and would not break the line after every sentence. If a 
paragraph makes sense, please separate it by a  blank line.

> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>   drivers/bluetooth/btnxpuart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index 7f88b6f52f26..42e929f0d141 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -281,7 +281,7 @@ static u8 crc8_table[CRC8_TABLE_SIZE];
>   
>   /* Default configurations */
>   #define DEFAULT_H2C_WAKEUP_MODE	WAKEUP_METHOD_BREAK
> -#define DEFAULT_PS_MODE		PS_MODE_DISABLE
> +#define DEFAULT_PS_MODE		PS_MODE_ENABLE
>   #define FW_INIT_BAUDRATE	HCI_NXP_PRI_BAUDRATE
>   
>   static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

