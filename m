Return-Path: <linux-kernel+bounces-41111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5C683EC05
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903721F23024
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E091DFD0;
	Sat, 27 Jan 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmWoSaSk"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB87712E6F;
	Sat, 27 Jan 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706344003; cv=none; b=iiH5SfT8Q7HtXrajSHJUdE2j4vLJ2kUWtQXosstY8RhAWPoOYCQBAdtiSnXBMRmQwApWyWGVRgue9VDg2GPwTqPT/SaUoO3ZScfxy0nkQWyPFTOiiiT83JrdqqrW3FiH/VShnmBDF7pXV3aBIfIedoz1PpEwx4Cw03Mu4mDJ3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706344003; c=relaxed/simple;
	bh=nR/U/k3Pzl0L5NvuvVWzu+aT2s+bUvPO8sbYJZr9EOI=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=h4ezkOU5Y08wEM5eA+6ohYAZ/5A/Y72F4o8nArgloBdbuL6cROLf9QIGPvf8DmsDmEkZwE+dLjW+Nk7j440TppqVUruhMBZ25388em2y9IiMupHxvVgImokbkeNFK1MNZf3KcvM15lm1KEfe61YzQmwR1RHFNDXFoosG1Vl4Sss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmWoSaSk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ae4eb360aso218733f8f.0;
        Sat, 27 Jan 2024 00:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706344000; x=1706948800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uehh41qNYPhg24j3C7un0JNB0v5MTT7KbCmBRQzEZgo=;
        b=LmWoSaSkZWjBOnFKbas6x4Rvq5VN5lZZqQZVAlqdFS6wss3YKW0uzp+bRxdYvW6VuI
         GCzNa5Gy4H5wDRDGBOmsYtyIF15EK4L0dcalti2Aw9N3PluxaYxtbKDMD0Ug3nmDuqF4
         KQKIc5lX9APGF2jOjRpJgGw7M86/5EwJ72wuG5c+RGcUPTmhzrTx7JBQPf5NRAoDSQSB
         tBnbue2R2NP/W68tcvhWKmzXTgIJrdvqK1y05bnCdodsUc/bOfH/Zr+KwLJ1vJUZvvZG
         QF+mw0qGjgJ2m2NG0K87zQcPTtYJi6SwL+2R+o7de7dodjjcFV7AeM6TewKLol8RFb5c
         QhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706344000; x=1706948800;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uehh41qNYPhg24j3C7un0JNB0v5MTT7KbCmBRQzEZgo=;
        b=w0wxuynWZy2QRDWJdQzkdz1/T1kyrh5zQI3MC+ps0G9jgoPYedz5cwcpopl1+R1cvG
         iY0CbhdRvcew1ZABy64xahtJ86BQuFl3ghhUFMzSbBHaywpFyM2QVPCGdIgxYumpTV94
         6vcXPTxneCoXqppMxQ/A1ICLuFyeUslfDwmxAwjbrvQzuIKk3wGpJFnTu2Wqb0yhEAV1
         hqx7FFtlwwtZ1Z44zDvvX+M9wkSYD+6SBy4oxGSK//QY0EoUF7xjCCl9jQ+qMAiz0Nsf
         krin6sVgIw0WU2V+785/B62e9SToLRuojojDf6o4XqUGEqSEcUzIES7Es66jvgVU5mgS
         r/UQ==
X-Gm-Message-State: AOJu0YzoqAhmG6HAPzDqW2rIzKHe5a90xbWE5VFyVOWJKabZrNEOCvdG
	1jBlmTZpXBDsE+9qiFwAeTSa/E+dWPn0oayBs/00xWx3Cz3W917l
X-Google-Smtp-Source: AGHT+IFLnqJ4y4jF1jFD1J4ZWolGZmabt02XyiJXOp+6lWppDcEgPmSZ8V7cc2rl7n0WbYWdgtX/ZQ==
X-Received: by 2002:a05:6000:1446:b0:337:b38d:6075 with SMTP id v6-20020a056000144600b00337b38d6075mr644009wrx.4.1706343999766;
        Sat, 27 Jan 2024 00:26:39 -0800 (PST)
Received: from [10.230.100.199] ([192.19.152.250])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b0033ade368c29sm2136573wrb.3.2024.01.27.00.26.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jan 2024 00:26:39 -0800 (PST)
From: Arend van Spriel <aspriel@gmail.com>
To: Kalle Valo <kvalo@kernel.org>, Breno Leitao <leitao@debian.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <abeni@redhat.com>, <edumazet@google.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, <dsahern@kernel.org>, <weiwan@google.com>, <linux-wireless@vger.kernel.org>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Sat, 27 Jan 2024 09:26:35 +0100
Message-ID: <18d4a071678.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
In-Reply-To: <877ck0eeqi.fsf@kernel.org>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-18-leitao@debian.org>
 <877ck0eeqi.fsf@kernel.org>
User-Agent: AquaMail/1.49.2 (build: 104902408)
Subject: Re: [PATCH net-next 17/22] net: fill in MODULE_DESCRIPTION()s for Broadcom WLAN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On January 23, 2024 7:38:36 AM Kalle Valo <kvalo@kernel.org> wrote:

> Breno Leitao <leitao@debian.org> writes:
>
>> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
>> Add descriptions to the Broadcom FullMac WLAN drivers.
>>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c | 1 +
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c | 1 +
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c | 1 +
>> 3 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
>> index d55f3271d619..c1f91dc151c2 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
>> @@ -20,6 +20,7 @@ static void __exit brcmf_bca_exit(void)
>> brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_BCA, THIS_MODULE);
>> }
>>
>> +MODULE_DESCRIPTION("Broadcom FullMAC WLAN BCA driver");
>
> It would be good to spell out BCA. I don't even know what it means :)

If my memory don't fail me it is Broadband Carrier Access. Basically it's 
the AP side of the Broadcom wifi business.

>
>
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
>> @@ -20,6 +20,7 @@ static void __exit brcmf_cyw_exit(void)
>> brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_CYW, THIS_MODULE);
>> }
>>
>> +MODULE_DESCRIPTION("Broadcom FullMAC WLAN CYW driver");
>
> Same for CYW.

A bit easier: Cypress Wifi.

Kalle does apparently knows what WCC stands for ;-p To be honest I am not 
sure but it is the mobility business.

So these modules a not standalone modules hence I didn't bother adding a 
description. My bad. These are plugin modules so to speak so if I can make 
a suggestion here please rephrase to something like:

BCA: "Broadcom FullMAC WLAN driver plugin for Broadcom AP chipsets" and
WCC: "... for Broadcom mobility chipsets" and
CYW: "... for Cypress/Infineon chipsets".

Regards,
Arend



