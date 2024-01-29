Return-Path: <linux-kernel+bounces-42290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB4883FF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17CFC2838BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045864F1F6;
	Mon, 29 Jan 2024 07:42:13 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940F1E883;
	Mon, 29 Jan 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514132; cv=none; b=biPd4rItOknKY/6tHDd4lWtQ6BYTew/J40xdlQex2XybvCxHN+45+ViDfV3/UWsbhxK3Yfl54/ByfJgaybuxB/a7T45uqPlTYk0ig6uLzTRaXVpnQb/iuyQiR6BfC6F85AZwdj4pm7XjSDiqL7UF3grPCiLfcGPuNg424AlQA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514132; c=relaxed/simple;
	bh=CqKak82DKuvMol0BLjon5b1CL3W0Gvv1hZYXKnCinuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=o9F0RhbNNps0buRVM+S1vGVMipsGohSWUzBu218BKXyv8VhJGsdIIh34osx2ECDTgNiMqUDdsZktGYLQBKkQG2U/e40ccko13WaT8yeIwMOlLXtaYdvtkXjIA4aTXqq6B+ahGriymkwm1BuinDJAVmW9NeiraAeX7EEyDfkBtRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aec51.dynamic.kabel-deutschland.de [95.90.236.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B24CA61E5FE04;
	Mon, 29 Jan 2024 08:40:58 +0100 (CET)
Message-ID: <c8af1073-22ed-4c14-be85-67632d82a3fa@molgen.mpg.de>
Date: Mon, 29 Jan 2024 08:40:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/3] gnss: Add AI2 protocol used by some TI combo
 chips.
To: Andreas Kemnade <andreas@kemnade.info>
References: <20240128173352.2714442-1-andreas@kemnade.info>
 <20240128173352.2714442-2-andreas@kemnade.info>
Content-Language: en-US
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 johan@kernel.org, jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?Q?P=C3=A9ter_Ujfalusi?=
 <peter.ujfalusi@gmail.com>, robh@kernel.org, hns@goldelico.com
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240128173352.2714442-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andreas,


Thank you for your patch. I think Linux Bluetooth patches need to be 
have Bluetooth as the prefix for the commit message summary/title. Also, 
it’d be great if you removed the dot/period at the end of the commit 
message summary/title.

Am 28.01.24 um 18:33 schrieb Andreas Kemnade:
> Texas Instruments uses something called Air Independent Interface (AI2) for
> their WLAN/BT/GPS combo chips.
> No public documentation is available, but allow that protocol to be
> specified.

I’d add a blank line between paragraphs.

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/gnss/core.c  | 1 +
>   include/linux/gnss.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
> index 48f2ee0f78c4d..cac9f45aec4b2 100644
> --- a/drivers/gnss/core.c
> +++ b/drivers/gnss/core.c
> @@ -335,6 +335,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
>   	[GNSS_TYPE_SIRF]	= "SiRF",
>   	[GNSS_TYPE_UBX]		= "UBX",
>   	[GNSS_TYPE_MTK]		= "MTK",
> +	[GNSS_TYPE_AI2]		= "AI2",
>   };
>   
>   static const char *gnss_type_name(const struct gnss_device *gdev)
> diff --git a/include/linux/gnss.h b/include/linux/gnss.h
> index 36968a0f33e8d..16b565dab83ea 100644
> --- a/include/linux/gnss.h
> +++ b/include/linux/gnss.h
> @@ -23,6 +23,7 @@ enum gnss_type {
>   	GNSS_TYPE_SIRF,
>   	GNSS_TYPE_UBX,
>   	GNSS_TYPE_MTK,
> +	GNSS_TYPE_AI2,
>   
>   	GNSS_TYPE_COUNT
>   };

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

