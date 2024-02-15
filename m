Return-Path: <linux-kernel+bounces-67356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAEC856A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB151F2278E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5F9136657;
	Thu, 15 Feb 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/J1S7Q2"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0C131731;
	Thu, 15 Feb 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016410; cv=none; b=K3aAi2xZdrtcDKxCJQDbGZmbVwsm3nmzhHuPK1oQQyNqpLY0FP6A+hv9OWoUqR+Hzs5RUTGbkCyXfGhdKyqq8Jv5gJ1b2ONiVvrtQoIOTO2PGnguDE4wZMPTQzrqlnati6jh2LTN5RIv1d9mOf0OvfVtcvVDDnOFvSqKCmO+HP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016410; c=relaxed/simple;
	bh=pk7QVe4QgcWvlAh/ynxTe68bky3FpJ+XYUBsXQt+Vz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LE4TLGrpRo2++N401KHkPnTtHQKeYrANXYi4TUMHjEW5ukR6isMh8Utob3fduKAlB9LfUqeS+numKMnH3Kea4UBKwZfjjl7s9ujlvBadtjd8Lr4npUU7+uowHGCMoEStsvWU+/pTaBDh1AxeywEtWNXFnMc0P42LaUYJseEo7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/J1S7Q2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e0eacc5078so1011030b3a.0;
        Thu, 15 Feb 2024 09:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708016408; x=1708621208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=j8X2wgs720QDW2LTsvUkX4Xd2fXq1HeA2u5+0bOzQ5Q=;
        b=C/J1S7Q2kyt0eKaNULZLuN5mt30sJEdVwqE0CLTvDuEQBkUU+d9GWXr139Lybzlx+O
         TQlgiSx8LCuhyUe6PiEf1RLoX8sMzwfHabUqw79xkzLb3xYydhoZayClWP/58Kd23U8I
         rl+BtU6C/XN4EoJB4joZvGbhLUCaYSgtjt347SbJK3w3UKgeo3xDiTN+IIaFe3l/2Jse
         WDaNHPl8jOcfE7BpqvdeiTZKuCHu3j9Lr6CnlEVCEikFIOHnnK3yhhYSZgiLeXDBAMhb
         /EDSrymT0vGTYpYSoRCq8E0UHQsRzbHdg3E6MwQUQNzJb97hb2qsUwgPP0Pv2sw9fTJo
         fPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708016408; x=1708621208;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8X2wgs720QDW2LTsvUkX4Xd2fXq1HeA2u5+0bOzQ5Q=;
        b=OnOEx3BD+Mz9StTiJpLG1Iq1yTQ0+ZSATApaKATy14Ig8LPj1A1aMYnpBCxRmd/C9v
         cJtPx8/27WnEmDUrlykCK7Vwn//7HvdJjIHaL78cltOvnA4f4ZZ9Cs0Wb3jG+DjmfNnd
         TE1LXGcoc28vhTVWwFrlgsXCraYA/nyikcoQQwIHq9rlHpt3k/5zHGvXLDOfoSEFdCsV
         fX5PC0TxhkL4SPT6OfcbDGY1B7411i8CJxSASd9wj3d9x342R/+8x47IgrbOUrzoq65f
         TgxvWhlOBGbBUKBXprz0b29w48X3qsbPh9unfbgzYxbJC5BJ7S3QVjFIEAuRb/UTxTO6
         xjmg==
X-Forwarded-Encrypted: i=1; AJvYcCVSehFpfppamSUtbCNumBwB4940momBKyVDpedlzXtkcTY52Y8Mfua2Znb5zS4adDKr/RghMl3COaRMuYBUrBIMDp+GaKYT9d/R48sRWw/mv0hauY2A791wbNxw5ybX00IGi8pAMeqI
X-Gm-Message-State: AOJu0YzXOO+AZZUOpJHztWD50mqk8YDomBQuvx5z3u8HwOS22YtA0pvk
	NtOvy5Q3CN4T4gV9Rd791trU58bwT1SqkdzXgOE79U94NG5b/yNX
X-Google-Smtp-Source: AGHT+IFp9XjdsNy2SWMVQdrfUH6Pl9rTlRi0i18y3UXPQgDw3b2VmsMfLkzaflbIM9Nv/kD5El0nbQ==
X-Received: by 2002:a05:6a00:cd4:b0:6e0:a025:feb2 with SMTP id b20-20020a056a000cd400b006e0a025feb2mr3431769pfv.11.1708016407653;
        Thu, 15 Feb 2024 09:00:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lc25-20020a056a004f5900b006e0eece1ca4sm1548049pfb.4.2024.02.15.09.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 09:00:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <da10b4b9-b950-4021-8737-d12cbccef8c9@roeck-us.net>
Date: Thu, 15 Feb 2024 09:00:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] The datasheet URL has been changed.
Content-Language: en-US
To: Okan Akyuz <okanakyuz@okanakyuz.com>, jdelvare@suse.com, corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240215151957.20855-1-okanakyuz@okanakyuz.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240215151957.20855-1-okanakyuz@okanakyuz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 07:19, Okan Akyuz wrote:
> The URL for the datasheet was not functional. It has been replaced
> with the active one from the manufacturer's website.
> 
> Signed-off-by: Okan Akyuz <okanakyuz@okanakyuz.com>
> ---
>   Documentation/hwmon/max6620.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/max6620.rst b/Documentation/hwmon/max6620.rst
> index 84c1c44d3de4..d70173bf0242 100644
> --- a/Documentation/hwmon/max6620.rst
> +++ b/Documentation/hwmon/max6620.rst
> @@ -11,7 +11,7 @@ Supported chips:
>   
>       Addresses scanned: none
>   
> -    Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6620.pdf
> +    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max6620.pdf
>   
>   Authors:
>       - L\. Grunenberg <contact@lgrunenberg.de>

Is this supposed to be v2 ? If so, please provide change logs.

Neither "The datasheet URL has been changed" now the original
"The URL of the datasheet seems to have changed" describes
the patch.

Please read and follow Documentation/process/submitting-patches.rst.

Thanks,
Guenter


