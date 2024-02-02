Return-Path: <linux-kernel+bounces-49947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F8D8471E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707CAB2AE35
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA813EFED;
	Fri,  2 Feb 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="iHvft8L4"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F01854;
	Fri,  2 Feb 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883992; cv=none; b=layv9/Kx7lkj9FOBrREzcFgO9pwx+K5UoYYYjA6Wg/iP87pddzFx6UBuXaS0KCJP0PEfZm2NpYrTbjiO3ox2QBYZhcF9V6U1Vr7vy4W85F7Cy98XpfgUcgd1IA1VNEkIAX0V1DfBWLhYsfRf6SL98FXeJPLY+MBjIaqWM9KEZ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883992; c=relaxed/simple;
	bh=Hek7OsUPTK/+2iL5vxjRI0TRniJiNEvzpxxb70WqieY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDuT/VDmvGTRxUSiEF8nsGzZORsKTFEsE9+cxVjGnEun+5QEXRI+bbMnBiNjrydhIIqRjy0pEoVZ8q5eI0ED7fuWqZ3uJoDf2FXr0EIEiVBe98bTmyWBZK4cKtuzQFBgCnBb74IdeXinulzWy71/bAfOnTiZIZ6mFPGkfkSrzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=iHvft8L4; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id D1CF22FC0055;
	Fri,  2 Feb 2024 15:26:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1706883980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjb1X9/opxrO69KIAP8GbmQxkKMjdNz9fFqZgIlfaFo=;
	b=iHvft8L4Q/QKjbUsU6dGjcf9ASdUNkAWJjCWZ9XpweIkg3TWZIgzbS6msRf325wL1JuRYC
	zRhwp9dJJbbDCM8nbPN3UlDu4RiDQ63Iu1SgOfZafAeoZxN0DJw5tDC9JQeqy+BP9coPSA
	yBw1hrh6D+Wd+ZwVZ9Hajt82HB9My5k=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <029a0d30-c68a-4e12-80a6-db3203ff3907@tuxedocomputers.com>
Date: Fri, 2 Feb 2024 15:26:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix strange behavior of touchpad on Clevo NS70PU
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231205163602.16106-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20231205163602.16106-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

gentle bump

Am 05.12.23 um 17:36 schrieb Werner Sembach:
> When closing the laptop lid with an external screen connected, the mouse
> pointer has a constant movement to the lower right corner. Opening the
> lid again stops this movement, but after that the touchpad does no longer
> register clicks.
>
> The touchpad is connected both via i2c-hid and PS/2, the predecessor of
> this device (NS70MU) has the same layout in this regard and also strange
> behaviour caused by the psmouse and the i2c-hid driver fighting over
> touchpad control. This fix is reusing the same workaround by just
> disabling the PS/2 aux port, that is only used by the touchpad, to give the
> i2c-hid driver the lone control over the touchpad.
>
> v2: Rebased on current master
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/input/serio/i8042-acpipnpio.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
> index 9c39553d30fa2..b31d3285bea69 100644
> --- a/drivers/input/serio/i8042-acpipnpio.h
> +++ b/drivers/input/serio/i8042-acpipnpio.h
> @@ -1200,6 +1200,12 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>   					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
>   					SERIO_QUIRK_NOPNP)
>   	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NS5x_7xPU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
> +	},
>   	{
>   		.matches = {
>   			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),

