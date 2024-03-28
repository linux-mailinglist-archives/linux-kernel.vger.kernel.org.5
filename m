Return-Path: <linux-kernel+bounces-123682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A68A890CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D465C1F2445B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E7A13A875;
	Thu, 28 Mar 2024 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaU6WNUW"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6640859;
	Thu, 28 Mar 2024 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662285; cv=none; b=f+75KOCx6mlsue9HCl3RPi2jubNRsmlHroK5YDuPoNUQmcgQjWyTj7MLnVSB3Hj6lB6nsZp7iPfj8Y0Cb+jAG4PyylczTwb05SjGphFZ2TdclyVmina53fAXh+FEcCtECyhbauOyMzDyjJ8eXdfE10vG3HFZEVjadUYjSkr7J6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662285; c=relaxed/simple;
	bh=vgncJ12bPOEKNn+P6UNocQm/1RyRBEr539fqesou12g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHfmM9vJuK8ix6bJUFLLYTbNhUKvbLTgScf718ZyisRfwkmzm9xF7fbL6q7eaf/XIO9pe3NIlnsJRDe83MORvHQQn3kUU+XeJ8+hMFnFqOvnu3LtCcfXbYwVEJPRCJ3AHzbFgYUiS7KnlcdTYkh4I+Uklqp9W2aCdaB1pSnyg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaU6WNUW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51581c51ee6so459436e87.0;
        Thu, 28 Mar 2024 14:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711662282; x=1712267082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00zSfVR5n/E7ASw56UXmOmJHpf1s4deJDOOGHOzNx/A=;
        b=DaU6WNUWknMlvG99sHGLOi7wVp+wjvH16w1OPjpP3fb/uyIHfz9Nqzo34PtJ42jpVI
         6Ri8WrG5cur3K+ngacHYVwBAqOzklltA4yLJj7uTFuO9GbnMhrZrWwXmRaqvGm0s+dWA
         idFC4kHc+nw9RAsRN1MM/QfhX9JJeY92LsOn2/Hs7hoL5JUUUR2HGbbKGWTTqnJ5n/Uj
         npLn6aeK3/igqRvClP5E0D/hV35Qjuu6gYiBjCMZZTiJzLjSyQAxNOiZPliFw7ypIabR
         errF8Nz8SH8Hh/Cec91h362PE2YcAbyU0n7BLRxjI76qyH0T2nGPnnrwjnw5cJ1jbnlS
         tZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711662282; x=1712267082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00zSfVR5n/E7ASw56UXmOmJHpf1s4deJDOOGHOzNx/A=;
        b=N+ZSD6TfZehuqElWHe8HIO0EuHVdOWXrzI7cPWsjOwSmyrwfl7k35SCrQa4AkOAFJA
         BH/PXkGyhU5baHP2f5WuOippH7/HI+avC/qnuJwp374DpnXdCYwXqAaoU5ga9bhYLGrk
         7zHZZvwZDEnA9S6XfiTcAQjJ8iets0W6h4507ElERDljt4Lpkvq6/njy1UBZnPm8bkA3
         g9BFNESRpefs77VINMkzc4vIuZVTI+5eNIXQ+htkvTIZ5euDxB6hDWhOXmxMmQTS5q4P
         55bQdljbS5qkI8CRfV3JPEbJ2lHHdBOhpazUfI6+gmxZRpMuZY9tLEml1hXOjynpfq+g
         p7bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNQajE8FY8L0uUcESADvtMdap82xqg4FAu5TQGNnfSqo85NyItlr9KwTdo3jmIeSC+SWB31zFhHXK5l1+YmUH7Qmw2NsCkqwIHM2vY
X-Gm-Message-State: AOJu0YzGVa6/C6Z/egatF/LffOzG+n9KxvVdq42cLod/Odh+SKxYmOKR
	A2twc6IRpdobkmJ4iZxq/7tA9jJie+iefeOdV86ZHPoh+QDuCPkQ
X-Google-Smtp-Source: AGHT+IGsA3Mym1ynkHCg1Jmo+MF6x3uqCVPaWZwhuEPdX18nfgIQrGLpfb4vb/+0JjdZUIssKVIlDg==
X-Received: by 2002:a2e:9bc2:0:b0:2d6:b698:968 with SMTP id w2-20020a2e9bc2000000b002d6b6980968mr241372ljj.1.1711662281405;
        Thu, 28 Mar 2024 14:44:41 -0700 (PDT)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id q14-20020a056402248e00b0056c5515c183sm959340eda.13.2024.03.28.14.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 14:44:41 -0700 (PDT)
Message-ID: <b3b033ac-0fe7-4a89-a7f5-ee96d5c806d7@gmail.com>
Date: Thu, 28 Mar 2024 22:44:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] staging: vt6655: remove redundant assignment to
 variable byData
To: Colin Ian King <colin.i.king@gmail.com>,
 Forest Bond <forest@alittletooquiet.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328111557.761380-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240328111557.761380-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 12:15, Colin Ian King wrote:
> Variable byData is being assigned a value that is never read, it is
> being re-assigned later on. The assignment is redundant and can be
> removed.
> 
> Cleans up clang scan build warning:
> drivers/staging/vt6655/srom.c:67:2: warning: Value stored to 'byData'
> is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/staging/vt6655/srom.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
> index 1b89d401a7eb..e80556509c58 100644
> --- a/drivers/staging/vt6655/srom.c
> +++ b/drivers/staging/vt6655/srom.c
> @@ -64,7 +64,6 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
>   	unsigned char byData;
>   	unsigned char byOrg;
>   
> -	byData = 0xFF;
>   	byOrg = ioread8(iobase + MAC_REG_I2MCFG);
>   	/* turn off hardware retry for getting NACK */
>   	iowrite8(byOrg & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

