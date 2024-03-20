Return-Path: <linux-kernel+bounces-108755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E77880F97
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D40D1F2232A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0A3D388;
	Wed, 20 Mar 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBfTNxbq"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA843BB48;
	Wed, 20 Mar 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930244; cv=none; b=YyLKQPUvEL4sZJ8yuFtJRt0YEKbvl0146GfxkKJ+b137Ylq8/GgVGcUHsSFcHmClPp3gDVdMuLL9GXR21Wurwzp+k4xxuN1IVjxtCDi/8nZ0B/ofGYv9xHDCbBIiAWb8EOdiQ2PwIn4JxAXHZB+69ya8XJ0lSmZ5TPtSAdLnR/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930244; c=relaxed/simple;
	bh=Pu2Eg/h/hDx/kano+99b34NmYI/PhyT0wLaL/eqWdQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgxYLGVaI19g+9oGQ/dgKJZDRwDm4D01+icdC8S9GosMxxq+e3niaXOfolcQNx5k4clQKffh8CsnC4rtL7nSYhHSV5YL2eryL+uyCw5/c7ggMR4R1duw/Zpud7wI5zSCBboGF3qNtUImmfR3P1GCIiPNLn82VlH546mlku3Z+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBfTNxbq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e8f76f18d3so161493b3a.0;
        Wed, 20 Mar 2024 03:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710930242; x=1711535042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNGMZWeqHHPRZokEtGbRCLAdS7h0Tg/vqYb0u5nw81w=;
        b=FBfTNxbqv3loqqyJ16NIyR6sX/ZwmB7wKPMLw74bqCwY5RIbFRyl0qEas201HPBBPJ
         BopZrQeJDOlhMK8bmvTQFl3IY3rc2TMXelDsPC2f6srOMs7oj1gHnmhRifNqYaHIBsx3
         sB1bICjngcNFaevDerirDoYs4vino24S/PqBwqcENoeW9Qnp8GthdTdtWMNGkjAnF/ML
         JR258NiUcq1wEbeIPbWHptaGzN3tDSD7FJ6NtV/MjWzDlSPsRQbcC4Kaard3x7bOFI6x
         YMwpDSUSYYAVb/8nsYUUAohawP6I0aPUg0dcGN1gI96fpthxzmpX0gaspYkFuOGtt7cP
         3EpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710930242; x=1711535042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNGMZWeqHHPRZokEtGbRCLAdS7h0Tg/vqYb0u5nw81w=;
        b=KVQzH470mLEWiRQkDoNGfINIHyBzmE1ihjbbhJOr9+P/MAny5NMcK8AIM/09f28wKp
         pyidU+aB/Gsm5z66UE0N4uq0BrQcwQY83PmH4tVMvl74P1gD9PTiKUxBfcZOqzF6oLF7
         uR2X4XIFos8yJwRS3dLlpR5VavVfwxgOMVJtNTh8mFAqANJsdqJ9rtPnbLVXYaNNpfOc
         82hO7Wm/A83K75jTsyORic6SrtqK3yhKzh5nwWFk3htNdbuuvq6IJjxC/kldLMt0Ux29
         Vht3wsElda2b62gIjOLjqeI3UH7Pa9hw15mLRQR+VAP11JM/mAfLlj7fednv5+jXbN0F
         QRxA==
X-Forwarded-Encrypted: i=1; AJvYcCUdzc3k3bvfDWrY1wJ4hPA6263/Tt3jru/pstGX+zOs7fVcZTNt3xO3B9D5yg3YruirEbUSf2KOgeRJYD8xNazhpczNuKPhCu1lqgOqgoXisaYI1e0YujdswIb3MszHtR67NC7Xamdr
X-Gm-Message-State: AOJu0Yx2Iu4gyhOsCvcMFWCO7/q4J1L0E1H8sbWS2JytfQM6vPRgpRIZ
	pkXZYyQ4YKBYLKUoNdsrGywMBsYq+I9uOY5tEAMgRutB2T76qFdD
X-Google-Smtp-Source: AGHT+IEujSEs4FveM9ht/jiwh624mr5TyvzCP2dGfgdNz+yQW78JveIR86trmHk6n8XLp5FFG94/wQ==
X-Received: by 2002:a05:6a00:8c18:b0:6e7:6bc4:ef8c with SMTP id ih24-20020a056a008c1800b006e76bc4ef8cmr3346244pfb.3.1710930242368;
        Wed, 20 Mar 2024 03:24:02 -0700 (PDT)
Received: from [192.168.1.7] ([159.192.167.165])
        by smtp.googlemail.com with ESMTPSA id v4-20020aa799c4000000b006e6f1eab2f9sm10062119pfi.159.2024.03.20.03.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 03:24:02 -0700 (PDT)
Message-ID: <436b1082-4288-4d6d-8865-f857e386e62d@gmail.com>
Date: Wed, 20 Mar 2024 17:23:56 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] USB: serial: option: add GosunCn GM800 series
Content-Language: en-US
To: Chukun Pan <amadeus@jmu.edu.cn>, Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240320070020.77280-1-amadeus@jmu.edu.cn>
From: Lars Melin <larsm17@gmail.com>
In-Reply-To: <20240320070020.77280-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-20 14:00, Chukun Pan wrote:
> Add support for GosunCn GM800 series which are based on
> Qualcomm SDX55 chip:
> 
> Download mode:
> 0x1402: DIAG + AT + MODEM
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=305a ProdID=1402 Rev= 4.14
> S:  Manufacturer=GSW
> S:  Product=GSW_GM800_123456
> S:  SerialNumber=12345678
> C:* #Ifs= 3 Cfg#= 1 Atr=80 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> RmNet mode (old):
> 0x1403: DIAG + AT + MODEM + RMNET + ADB
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=305a ProdID=1403 Rev= 4.14
> S:  Manufacturer=QCOM
> S:  Product=SDXPRAIRIE-MTP _SN:12345678
> S:  SerialNumber=12345678
> C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=86(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> RmNet mode:
> 0x1421: DIAG + AT + MODEM + RMNET + ADB
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=305a ProdID=1421 Rev= 4.14
> S:  Manufacturer=QCOM
> S:  Product=SDXPRAIRIE-MTP _SN:12345678
> S:  SerialNumber=12345678
> C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=86(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> EAP mode:
> 0x1422: RNDIS + RMNET + IPC + DIAG + MODEM + AT + ADB
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=305a ProdID=1422 Rev= 4.14
> S:  Manufacturer=QCOM
> S:  Product=SDXPRAIRIE-MTP _SN:12345678
> S:  SerialNumber=12345678
> C:* #Ifs= 8 Cfg#= 1 Atr=80 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=03
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=option
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=89(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=option
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>   drivers/usb/serial/option.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 55a65d941ccb..6bcf74f13ed5 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2278,9 +2278,13 @@ static const struct usb_device_id option_ids[] = {
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
>   	  .driver_info = RSVD(4) },
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1402, 0xff) },			/* GosunCn GM800 (Download mode) */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1403, 0xff) },			/* GosunCn GM800 (rmnet, old) */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1421, 0xff) },			/* GosunCn GM800 (rmnet) */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1422, 0xff) },			/* GosunCn GM800 (EAP) */
>   	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
>   	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
>   	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },

Hi Chukun,
do you really want the option driver to handle the ADB and NET interfaces?

thanks
Lars


