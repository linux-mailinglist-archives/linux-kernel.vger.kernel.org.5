Return-Path: <linux-kernel+bounces-122950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CC6890021
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DD4B22797
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA49F81216;
	Thu, 28 Mar 2024 13:23:35 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34437E572;
	Thu, 28 Mar 2024 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632215; cv=none; b=MQzzjZTi9ZiW3TdwzFkW+FtRtPtimpEYLR3VSRJF20Xz1TyyeJtfvE4oClz1J9KLM5YcwMy/FT5EmwbphtF2UEIhCZFX81gXRpcr//hkWAg2TZXHl3c/AZe1d2ak29UwPHDILi6XCIN8xfGhXwxz5gJ3RvvhpIGLvd2c7GwX2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632215; c=relaxed/simple;
	bh=N4yTjas9j7qGVfweDAx3sAp4wgslQ/UbAo2nZXCtzI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fn16lt7HpP9KRVf+6ug0UeeBlLpXbUNpcS9zdRVJSanP6IasjeBV2rwqLpLs2JcFMvR5UoBebAROgI0q9/YNReL3TVUMiUNLxfTvKA0xXGrki5RxcmuUhO44NsTv0Hqyy4MztAOqPbUk54LUbbhVUfRB63/rKKaZj17PsSQlIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.12.201] (g201.RadioFreeInternet.molgen.mpg.de [141.14.12.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2F7F661E5FE07;
	Thu, 28 Mar 2024 14:23:21 +0100 (CET)
Message-ID: <ee6259a2-05c3-4d6d-9dda-7a7b8f55fbfe@molgen.mpg.de>
Date: Thu, 28 Mar 2024 14:23:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel: Add devices to
 HCI_QUIRK_BROKEN_LE_CODED
To: Werner Sembach <wse@tuxedocomputers.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240328131800.63328-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240328131800.63328-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Christoffer, dear Werner,


Thank you for the patch.

Am 28.03.24 um 14:18 schrieb Werner Sembach:
> From: Christoffer Sandberg <cs@tuxedo.de>
> 
> For HW variants 0x17, 0x18 and 0x19 LE Coded PHY causes scan and
> connection issues when enabled. This patch disables it through
> the existing quirk.

It would fit in two lines with 75 characters per line.

On what hardware with what clients do you experience this exactly?

> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: <stable@vger.kernel.org>
> ---
>   drivers/bluetooth/btintel.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index cdc5c08824a0a..6dbfb74d0adf9 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2881,6 +2881,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   	case 0x17:
>   	case 0x18:
>   	case 0x19:
> +		/* 0x17, 0x18 and 0x19 have issues when LE Coded PHY is enabled */
> +		set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
>   	case 0x1b:
>   	case 0x1c:
>   		/* Display version information of TLV type */


Kind regards,

Paul

