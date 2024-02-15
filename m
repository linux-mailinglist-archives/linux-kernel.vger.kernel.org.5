Return-Path: <linux-kernel+bounces-67126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D648566B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AB81C229DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190A31353F0;
	Thu, 15 Feb 2024 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqR1VJGS"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1001350D8;
	Thu, 15 Feb 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008991; cv=none; b=evYHqDqn6GDLpdN5zWEGa1BbpIrQcIVDwt2FqP7HYf6/x1VnObRv33oPDMMlKNgSxqg67e6v/g1uE0o6YdbQ31XLPr99bVw3VEFnpIfi4M7CTyRQ8jJiruhe0CasXB3raMhw1Ig+SJxh9PGO67Da8bF4wIaBMRFYfVEfvkrXL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008991; c=relaxed/simple;
	bh=wHvhjq+DADKOma6GYpH33QtWj93FdrxmMVgqe5CC6ZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiClD3exsKNHRGTTnZucEJ5wD24ADjormG/bfpdCYqwjlXllgQeVn9ICMYTO8k5W7/Xv5lO3T+xt3ta8UMCUNkvFaunZogAL/7sXXNczZT1OzjRD4dNX7Xt2+dkTdL7Agx+4din04s5B+D0zJEpJxEsulTWZUw0K8d/Vgeub3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqR1VJGS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d780a392fdso8263765ad.3;
        Thu, 15 Feb 2024 06:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708008989; x=1708613789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9lqbpYH7gl5/+htoD/a8at6dHdqPe1LYKotzwXb1fBs=;
        b=kqR1VJGSDmThtFA7zFDYg9SAh1xKdrs+DRdGtUd+TeNQc2DVANMYEkGHRRLr/G3R+G
         rWl0j/lJypamCLc4QU3YJlw+JwJS2v0eV+k7lBB4oSleLr8lyDqyGM7pmmdQ7X8fu8bq
         JPE5rXbxMgvUEQhs6Yvba1FxjEwIvUweF0jwCMmhxr37FGiHyFUr4Jg3Fa+6XkdmyYbD
         kC7rlLWZ1iPelNk2Pagaoj+dwvZvCn67HQicss/4So/KqWfFn6HK9D/AsoyPLV3m6/yH
         oSs3bv4bfXg80Uh9Bzk/PxLHlqv5RAd2ZZkNdhM3DguhsmrU+UOdfY+JaKdqn+a30v43
         iE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008989; x=1708613789;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lqbpYH7gl5/+htoD/a8at6dHdqPe1LYKotzwXb1fBs=;
        b=r1XRK+3I6Z3hefyfnjwSSzMpPeMLW73iJBGZmSk8CRT3d+Yb+C/VXHhUgvyOJkrO16
         871pKTt8PBE2pNiLAXSt4Atv7tncc20BKGt51lopoKGaCq69Dr+kqvWnnXOJ9uZajqzE
         5a1YJGlZSnWmRV57I9+5Xq7f1a9HsSxPPleLQJiFaPkcQlqTv7gfIXR9qkiL7+ew10SF
         vv3RewVFilByLuapnXXPUawFal4kdPOa3VMq4HChLJftbzJZaaSmOLkC94ybOcMzUhw7
         b6XQk4eW7ER2AVnP9tg7Nf55KxchkMHnScYMN92hvPWAJL6OP1hXFZ1hmT6qx8k4uVFN
         R3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWkxYK24ChIA6pc2oczcWhLyVJ7qxJ1H5A5JWhK4Ybx7n6hXVhwoipRzBWIjBFit8LkuR20yr7QIAwvEnYQrLUnPM6ck4FpJb67ibLDFe/ubjPrLE4GxaTCBF+z4nGzrBIrK6cPildp
X-Gm-Message-State: AOJu0YwtnwHt2NyIRKhKXusVad7GrvsYV4gG4NRmjf1jU3tTgg3kPTqW
	XJV3rvGmfVH/lTe/I+3RSF8wP9Sxyjtv28dO8ub5q75N7COppkV5COkcpOYR
X-Google-Smtp-Source: AGHT+IG7h7glu3h8c69izLTocGowAfwyTbIz4XJWTFCFZbh2+E5Lorpy3sNZcK/eyPpspEGOTEiDIQ==
X-Received: by 2002:a17:902:db06:b0:1da:2a0d:feb9 with SMTP id m6-20020a170902db0600b001da2a0dfeb9mr2449656plx.60.1708008988615;
        Thu, 15 Feb 2024 06:56:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902f25100b001d93ba1120dsm1361045plc.200.2024.02.15.06.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 06:56:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <82d6c4d4-f3e8-499b-9640-127785073d51@roeck-us.net>
Date: Thu, 15 Feb 2024 06:56:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] The URL of the datasheet seems to have changed.
Content-Language: en-US
To: Okan Akyuz <okanakyuz@okanakyuz.com>, jdelvare@suse.com, corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240215143429.18069-1-okanakyuz@okanakyuz.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240215143429.18069-1-okanakyuz@okanakyuz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 06:34, Okan Akyuz wrote:
> The datasheet is not reachable. Therefore, I replaced it with another
> one from the manufacturer's website.
> 
> Signed-off-by: Okan Akyuz <okanakyuz@okanakyuz.com>

Subject should describe the fix, not the problem.

Guenter

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


