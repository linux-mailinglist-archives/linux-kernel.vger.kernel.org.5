Return-Path: <linux-kernel+bounces-123822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC232890E73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7587A2957BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BA41386A4;
	Thu, 28 Mar 2024 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="O1irU1hx"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1503A132810;
	Thu, 28 Mar 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668039; cv=none; b=YC6j5ixwktVeTTwwOoCIjov8OYtqCoMbUeQup0WJw4Y7+dQ+LLKvUtr7th2o4NX0wgG8q330z9fyD5f0AjMi4a8VadfVPLXO4v5cOWjRCwci581lSEZNzIxYVpAHAbR3atvclI7yaJsPeH7C9fA5C9Gtz5SPr16iLulUihh5fGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668039; c=relaxed/simple;
	bh=34jIQYyG3HwhAtKIumxUv8XfeSTT8CDhCLqScz3CDRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHXy2QQB7JtNid+MDH6LYmiiwPniqCiA7GhRn3M+yaunEoR9A7JzW9+JX/0V8kFyl6POBRK0HJoZ/gP8mGuZVrQbM304y4NcomfGaUB0Au+Hz4tD+EoxkS2bIElIWr8ZRVObdLk+ny7nl7oyuf99iFiKBy/6aD+jiXdhVagOGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=O1irU1hx; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (pd9e59192.dip0.t-ipconnect.de [217.229.145.146])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id D0DBC2FC0063;
	Fri, 29 Mar 2024 00:20:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1711668032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhkvNvnameJwMfmvqN5hnsuhbbtE6or15TxgqStiKbk=;
	b=O1irU1hxVaN+6UhGvajjQ1uwRXgPkPeyIM4GE+Bo7CuszA0mnkies30vjYPFK/8u8QJ99Z
	cl3vDPy7/WQqtIIhfB19Nnja+ql3Q/AYrrWpdo8orGTGmjG8cwasNR/PKcccT5yh2MD7wY
	DQiAZTvHQn/sAET7aMYiouQCpGVCC5c=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <29d54137-f3b9-4556-b99e-61a0f681f164@tuxedocomputers.com>
Date: Fri, 29 Mar 2024 00:20:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel: Add devices to
 HCI_QUIRK_BROKEN_LE_CODED
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Christoffer Sandberg
 <cs@tuxedo.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328131800.63328-1-wse@tuxedocomputers.com>
 <CABBYNZ+OaJ9QVE_KmBNL8QbBv4r5erL57u3BzFv0AnmUzY=PTA@mail.gmail.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <CABBYNZ+OaJ9QVE_KmBNL8QbBv4r5erL57u3BzFv0AnmUzY=PTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

Am 28.03.24 um 15:17 schrieb Luiz Augusto von Dentz:
> Hi Werner,
>
> On Thu, Mar 28, 2024 at 9:18 AM Werner Sembach <wse@tuxedocomputers.com> wrote:
>> From: Christoffer Sandberg <cs@tuxedo.de>
>>
>> For HW variants 0x17, 0x18 and 0x19 LE Coded PHY causes scan and
>> connection issues when enabled. This patch disables it through
>> the existing quirk.
>>
>> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>   drivers/bluetooth/btintel.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
>> index cdc5c08824a0a..6dbfb74d0adf9 100644
>> --- a/drivers/bluetooth/btintel.c
>> +++ b/drivers/bluetooth/btintel.c
>> @@ -2881,6 +2881,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>>          case 0x17:
>>          case 0x18:
>>          case 0x19:
>> +               /* 0x17, 0x18 and 0x19 have issues when LE Coded PHY is enabled */
>> +               set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
> If it is just these 3 then we are missing a break here.

The cases are not added by the patch, the fallthrough was here before. This 
patch just adds this quirk for these 3 cases on top to the other things done 
below, aka the fallthrough is intentional.

Best regards,

Werner

>
>>          case 0x1b:
>>          case 0x1c:
>>                  /* Display version information of TLV type */
>> --
>> 2.34.1
>>
>

