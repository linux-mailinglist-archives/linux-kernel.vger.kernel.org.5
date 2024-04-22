Return-Path: <linux-kernel+bounces-152878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692E28AC5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6F31C21D26
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CE84CE05;
	Mon, 22 Apr 2024 07:33:04 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB856482CA;
	Mon, 22 Apr 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771184; cv=none; b=FkRCOM9+qRrMoZ1jXpdIrz6jkZIgKNN64bcs599V1LOyj8Epwbj1LCXpTgLJXK9xDT2hqxcFur8jNsEd6kJVM86cvRV4Ki1Fex5XHrRNmclBT2arEOQawuy/dPZ6cDDfvc0GNnx5MSCPrONbOVQT95m0y6uvbJlvUZpVyNIkxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771184; c=relaxed/simple;
	bh=aypG6bs6Wzxn78bIcan0Wy8naV63+hfk5083L3Gs2nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfBSovpsKpWkN9JvWp49AgHCnfBT4q0FprUIycg8TjvK4tTA34pDrvg6t8ny7ccD4WD68nJjLbnC7WIHor4vhz2h5EBUy2mHE3dA3/9pW9M6QQ5jADwvszZND6Y7146XKLjf4Mta0m4g2dZOg5e7ZwdMCm90HQFDtfZqnWUo3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (unknown [95.90.245.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 561E861E5FE04;
	Mon, 22 Apr 2024 09:32:48 +0200 (CEST)
Message-ID: <687c8f6a-d5d6-4918-bfd5-93d4b04da086@molgen.mpg.de>
Date: Mon, 22 Apr 2024 09:32:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: Populate hci_set_hw_info for Intel and Realtek
To: Archie Pusaka <apusaka@google.com>, Archie Pusaka <apusaka@chromium.org>
Cc: linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 chromeos-bluetooth-upstreaming@chromium.org,
 Abhishek Pandit-Subedi <abhishekpandit@google.com>,
 linux-kernel@vger.kernel.org
References: <20240422152413.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240422152413.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Archie,


Thank you for your patch.

Am 22.04.24 um 09:24 schrieb Archie Pusaka:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> The hardware information surfaced via debugfs might be usable by the
> userspace to set some configuration knobs. This patch sets the hw_info
> for Intel and Realtek chipsets.

Could you please add an example paste to the commit message?

> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
> 
> ---
> 
>   drivers/bluetooth/btintel.c | 9 +++++++++
>   drivers/bluetooth/btrtl.c   | 7 +++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index a19ebe47bd951..dc48352166a52 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2956,6 +2956,11 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   			err = -EINVAL;
>   		}
>   
> +		hci_set_hw_info(hdev,
> +				"INTEL platform=%u variant=%u revision=%u",
> +				ver.hw_platform, ver.hw_variant,
> +				ver.hw_revision);
> +
>   		goto exit_error;
>   	}
>   
> @@ -3060,6 +3065,10 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   		break;
>   	}
>   
> +	hci_set_hw_info(hdev, "INTEL platform=%u variant=%u",
> +			INTEL_HW_PLATFORM(ver_tlv.cnvi_bt),
> +			INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
> +

Why does it need to be added at two places?

>   exit_error:
>   	kfree_skb(skb);
>   
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index cc50de69e8dc9..4f1e37b4f7802 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1339,6 +1339,13 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
>   
>   	btrtl_set_quirks(hdev, btrtl_dev);
>   
> +	hci_set_hw_info(hdev,
> +			"RTL lmp_subver=%u hci_rev=%u hci_ver=%u hci_bus=%u",
> +			btrtl_dev->ic_info->lmp_subver,
> +			btrtl_dev->ic_info->hci_rev,
> +			btrtl_dev->ic_info->hci_ver,
> +			btrtl_dev->ic_info->hci_bus);
> +
>   	btrtl_free(btrtl_dev);
>   	return ret;
>   }


Kind regards,

Paul

