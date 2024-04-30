Return-Path: <linux-kernel+bounces-164522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A731D8B7EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0422835DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC281802BE;
	Tue, 30 Apr 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkxI4nZa"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D71369AC;
	Tue, 30 Apr 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498392; cv=none; b=rFgq/2zKtULlXFSLoLcezHMp0K9etsWbSYKv3tqPXkOj7oiISR1QR+RyOMPgtqdJPomudzt+l8xzF9/aKkt+R+Yg7OK2FNSiaMHsTdSPMFDnufqVi5SwQWvOk4m/1o7W+odJUXFnRBCLovGkCP6ftAp77zQGTwoSIfEaIeqzQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498392; c=relaxed/simple;
	bh=TnBNsH1qoOox53D2xquim2Kd4d2fYV/Y0z/AXor4gLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKh3pD9o0SiqgXALhlxdkLkN6ep689KJ0hLvkLIAazYVSyK+Z0rmKgSuecZxXdZTxshXDJl00/kq9Fk8AaHj3BjcBWAynOOt/EPte+g0icM23jkxALuFwviJhnP59EaNnBbnOdmlTA76t8l98Xyq9EZabgPIrqRSQMsWhKCanms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkxI4nZa; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so5207580b3a.0;
        Tue, 30 Apr 2024 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714498391; x=1715103191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/PBhkPsNiWn95+5+BFaBpB6Qi1Y6lvU8hjeywtEr7z8=;
        b=KkxI4nZa8fCsoowkfu69K8DDhFMg+Say20E+nx0B3Cg75vNI4yr/E/jpNdFgcJtLAQ
         wPYwnEKb98/dH7nkJBYPnkH+X6hL4vFwjt+bJKPDatCdUwnqYkFCxQM+a9IsOuJYXGX5
         QYWrfyT0ArerzcweZj4vhLewEQhkIFXDbjWnOCvSd1IfTaYXE7s24NGJMDuKWwzbk4k5
         ZMHpxpWXdlaHrooifAzPsFb1y6kJNTrNvDA+XANNgtGgHqsXg/myRsvmmZ7TbefIs7vE
         eTXLhJ2Bu/dkV+vwySFusJa5/NF/KtabTldvLNWIguDL/cifBu54LPysjugB8BfirphL
         IkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498391; x=1715103191;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PBhkPsNiWn95+5+BFaBpB6Qi1Y6lvU8hjeywtEr7z8=;
        b=tpT8zHFVMOVUFCOnxG4eacm8BzhwfXJ1hMuDJVFJHdhaWWW/XaxF6KGmgrKvLU2Bte
         HE/LRq24Ab3/A+/B4PU+cnm1/ELWHdznbwxWPjJLs7rZ1U9iA+kzrCQvMXq7omFUrRUN
         J3Oh/yT1LlAptZRJMoSAmREBJtva7OGTax76MRWA25J5GzkxskyUAdlR4KUWhB3wM3nK
         hAS0dZ/SdqGIuHXCoBgzzoAQqnJM73B/kfnnk/WZWUWWMv0HNPS2ntef5PDoRKsVtUGs
         7pRq39SjBaoby8hRRzXDJpdxAENvptGvE3gQosYYTKWq+X9Yar5aFbIm8OhVEA38PQOT
         qiNg==
X-Forwarded-Encrypted: i=1; AJvYcCWn2niA6fmLGJyMZgCX1X/3n1yG/huRn0FkQhIpxvs5Ik3P4l2Jl/irmQAcp3tm8T5aXGCM+9GnYYMN5Jot0TZJ6lR8c+ZUcbaYc3UICOqLaudm6CQplfeBGygi7GHwoALfYkAJGJ4Vldo=
X-Gm-Message-State: AOJu0Yy1/eC98R3kp8xpksRBQo3DcUG0kWLrDWrdZRaBTXjr1ZSh9k0K
	zA7XLcxFbLQiCKaDl0Og1XqjiCCzNnIImKvieHSJAD8RldAyz/VJ
X-Google-Smtp-Source: AGHT+IEymF1cIJqn5YaAiWlf30Uf6dOwySPRj5Jy5B9mnRRCxaoB9GwxgTPvM5uUdhQXj2PXZwwKBA==
X-Received: by 2002:a05:6a21:800f:b0:1ad:8335:1a45 with SMTP id ou15-20020a056a21800f00b001ad83351a45mr443049pzb.55.1714498390500;
        Tue, 30 Apr 2024 10:33:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902edc400b001e29c4b7bd2sm22683181plk.240.2024.04.30.10.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 10:33:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2a9ce60e-1708-4ac4-9311-240a59048224@roeck-us.net>
Date: Tue, 30 Apr 2024 10:33:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] hwmon: Fix spelling mistake "accesssible" ->
 "accessible"
To: Colin Ian King <colin.i.king@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240429074923.1073720-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240429074923.1073720-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 00:49, Colin Ian King wrote:
> There is a spelling mistake in the module description. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/hwmon/lenovo-ec-sensors.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/lenovo-ec-sensors.c b/drivers/hwmon/lenovo-ec-sensors.c
> index 50adeb82468b..143fb79713f7 100644
> --- a/drivers/hwmon/lenovo-ec-sensors.c
> +++ b/drivers/hwmon/lenovo-ec-sensors.c
> @@ -598,5 +598,5 @@ static void __exit lenovo_ec_exit(void)
>   module_exit(lenovo_ec_exit);
>   
>   MODULE_AUTHOR("David Ober <dober@lenovo.com>");
> -MODULE_DESCRIPTION("HWMON driver for sensors accesssible via EC in LENOVO motherboards");
> +MODULE_DESCRIPTION("HWMON driver for sensors accessible via EC in LENOVO motherboards");
>   MODULE_LICENSE("GPL");

Squashed into original commit (I gave you credit in the description).

Thanks,
Guenter


