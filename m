Return-Path: <linux-kernel+bounces-47799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD60845305
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D14B29477
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADEA158D9B;
	Thu,  1 Feb 2024 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WjjoW9JB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133015A4B1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777099; cv=none; b=pDFFNPuC/z9saE2ARU0LD/3qzOw+162npoAz3+EEt6thBUW7TWLse2hBgJq9mgEhoZYyCOaNG/jZv3K7d7xf7dG1RsSGh1TfDG7lwnCBotjYTGRPRns+ajNblH0iN5/uVS44RDxR3fs2O9n/L18DQrUSZznxZ6a61z2YgvtUQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777099; c=relaxed/simple;
	bh=SSQaV5ATZoNLfZMtApEWvimSypLVgmPZGof4nD6i2Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeQhZXZo4lPxrCpiSaSA09+5BQXIwxufFCfY0DSqR6h3IgsNLGgIU1CnIx6/JOZrIUrVZ/i60bNK8Xy6kPKxtJ6NEIhHWI4d4p+zBmvW9R65vuWwrcHV3tjlUFvnACCP02Es93R8EmTWmgDeYdVIaJdhsp9AB3bP/oCdFZH+qK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WjjoW9JB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706777090;
	bh=SSQaV5ATZoNLfZMtApEWvimSypLVgmPZGof4nD6i2Ug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WjjoW9JBQ/fZUHJOjUjU61p5G9EkjthjuRCB5LQMUULNJh8H64A90Bl7mp74QIvfz
	 S+T0fFQGSiFLomQVbcFQoEx/+VvZFHsBPuFJ4QLy0apX0JwoIci2A22pzZurwrLXia
	 n0xqROZmqgeUnrw1+2fGmxYBVUpUy1w23LVYZHN2pSrFe5HRAYQgBYExBrQ5m5f9Yj
	 pACvv9BeXYrz6Fl8JGpIwqHGythw+CnDtOJGHScYooQ6RREdE2teY5v47fyytMjr0x
	 hiWKGtMV5AkoJLxzv0lYO7ewGils76Iw3Jn+RQ80p3CmUzACL6QwtWDhJDBrIgdaO3
	 LAwYe/oaMNOeg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8A91F3780022;
	Thu,  1 Feb 2024 08:44:49 +0000 (UTC)
Message-ID: <7cf660b8-240f-442e-be55-2e6e6521338b@collabora.com>
Date: Thu, 1 Feb 2024 09:44:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: arm_scmi: Avoid to call mbox_client_txdone on
 txdone_irq mode
To: Pin-Chuan Liu <flash.liu@mediatek.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: wsd_upstream@mediatek.com, cylen.yao@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240201045253.14390-1-flash.liu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240201045253.14390-1-flash.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/02/24 05:52, Pin-Chuan Liu ha scritto:
> On txdone_irq mode, tx_tick is done from mbox_chan_txdone.
> Calling to mbox_client_txdone could get error message
> and return directly, add a check to avoid this.
> 
> Signed-off-by: Pin-Chuan Liu <flash.liu@mediatek.com>
> Change-Id: Iacbe0d36ef9cc16974c013c3e94c47dc79eae52b

Change-Id is something internal to you and has no meaning upstream.
Please remove it.

> ---
>   drivers/firmware/arm_scmi/mailbox.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
> index b8d470417e8f..f6fe801c2e34 100644
> --- a/drivers/firmware/arm_scmi/mailbox.c
> +++ b/drivers/firmware/arm_scmi/mailbox.c
> @@ -8,6 +8,7 @@
>   
>   #include <linux/err.h>
>   #include <linux/device.h>
> +#include <linux/mailbox_controller.h>
>   #include <linux/mailbox_client.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> @@ -275,7 +276,12 @@ static void mailbox_mark_txdone(struct scmi_chan_info *cinfo, int ret,
>   	 * Unfortunately, we have to kick the mailbox framework after we have
>   	 * received our message.
>   	 */
> -	mbox_client_txdone(smbox->chan, ret);
> +
> +	/*
> +	 * With txdone_irq mode, kick can be done by mbox_chan_txdone.
> +	 */

Besides, you need one single line for this comment

Regards,
Angelo

> +	if (!(smbox->chan->mbox->txdone_irq))
> +		mbox_client_txdone(smbox->chan, ret);
>   }
>   
>   static void mailbox_fetch_response(struct scmi_chan_info *cinfo,



