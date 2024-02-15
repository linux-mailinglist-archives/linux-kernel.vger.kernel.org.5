Return-Path: <linux-kernel+bounces-66971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E322856438
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0741F28463
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A182130ACA;
	Thu, 15 Feb 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjE6WuUj"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AE12FF83;
	Thu, 15 Feb 2024 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003357; cv=none; b=qOCH4KstC4x5NtYl6d+L69GQ5ATe9mUzr6Ug/np7W4z0VTbo91EwWGzDO+nToQOHCMGbPlOJqvcjeEfZonkFbtDO/uttjx8VXEDv0CBZHJ/fCFfO2xrZrW2yZVrz16/gQ9jgiT+51FCCLzkDdb/qQBoWKxSexWsZ6rF3mNc59K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003357; c=relaxed/simple;
	bh=4aF+qj6JSTQ0807KgJV1vNLS92lk0xJGwBxRA6HChtI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PvfWy2S+bggjHxtuGdtfYgqRzcB3dA/jz4OczOuog1C4IE0F6bCvvD4N1N+Fo0Tz3eonblitd6ITzolElX2ezT83mi1LQjvKLEpqW/Q7FCqY2H6y79yXG/tdXVjds9/QSRtT75Ya3J8mbgeULH2GuBWIv8LI3grEjD0eihWOo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjE6WuUj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41211acfcfcso5778165e9.1;
        Thu, 15 Feb 2024 05:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708003354; x=1708608154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zk4/fN/6poQrSuP6ysDcE8oSR2rKxth24YP3yLSKdz8=;
        b=AjE6WuUjX4IxGPClPwgosRsg+LnKz7UBBgmcLODk+CgOib4uFC0lfkhGiWS+M3GK5M
         KlE8CmoCRqToOCk2LQpFhk8nDTQaEBMk/i3JxqYQbldYUUdQTfBo1vme54QlR9XV9n+3
         J+uO7NxpkcQuNl66zLP0BoHgmptahcbFNEBx4N7awetGhyOV159DNPhBCx3lu1nc8TI2
         jmdeF8HaQwaP6Qt19kN2C8eC/gojRDRa0FuVAX3rjmkwNr+Uvu8BiZB8fMlhgzj8/S5q
         zAJYlN5gov/KxQ2SIjrk729MRvOPygQ+t6zRezeWZLKjcemc9UK8zIa9bXYMYZKpWwSv
         mAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003354; x=1708608154;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zk4/fN/6poQrSuP6ysDcE8oSR2rKxth24YP3yLSKdz8=;
        b=SDJcm1oC3hNnjO4/LNVcxljrjbAL7roiD++xHQl//Fhs+NqH88oLmltX7TH/gXmZJq
         wd0D80UltXohnjv5qV+55CEdXFc0WuMGPf+8vFkRL7wmx0+QLCsA2WV7yJbezQWaYWBz
         6txPhusVbS240Wox/vxQO8a/0x0Qsss4umcQFpFfSIfSnCqcTjv2NLIeZCSXgca94C9I
         Elr8y7JqZG9UxSdz7r1rb4WFubkAHTr/AzknEXgSVNU749qX4WV4csx792jW+lgUjoZ7
         H5xbYR7k3myUvLF7gd08VQv23G5UMLKoNbRQ9FjNrdmyMVXtYpR66ltGDdoRNQQszZhM
         LTTg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Zxb5fbaKhbByHuGVPtcNYZeS82XL1ZHhnzARmwgaExxi91S/JPxcIyJ+MvhSxsWJK7ytoazrIGelJ3atSiGl5N3mNHMt60D6N53GSmlW+KcybjV2jIaxgUY1waFrMiY9D9k8FhxW
X-Gm-Message-State: AOJu0YzcTQK1HnmYNsWj4sFG0OOfTg5sGu/A2NM8/2ecrIVNUulEj1bO
	RvmwnUG+WdWhvbcxazLJDsi6zAEQLtsuEbjsZyq0te6kQfcoICpM
X-Google-Smtp-Source: AGHT+IFv3TPbz2dzqI8Cf8haH/DIkONUn8XWdSWuk1zHERmPAgW15QXkWNpUn5ANuU8S+PYkty6ubw==
X-Received: by 2002:a5d:474b:0:b0:33d:52f:a2a8 with SMTP id o11-20020a5d474b000000b0033d052fa2a8mr1031244wrs.61.1708003354173;
        Thu, 15 Feb 2024 05:22:34 -0800 (PST)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id bx23-20020a5d5b17000000b0033cfbe7343asm1866651wrb.8.2024.02.15.05.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:22:33 -0800 (PST)
Message-ID: <b2b1b20f-31f7-4c15-9d05-4421d890c6fe@gmail.com>
Date: Thu, 15 Feb 2024 13:22:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] spi: dw: remove redundant assignment to variable
 len
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240215131603.2062332-1-colin.i.king@gmail.com>
Content-Language: en-US
In-Reply-To: <20240215131603.2062332-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/02/2024 13:16, Colin Ian King wrote:
> The variable id len being initialized with a value that is never read,

should be "len is being.."

> it is being re-assigned later on in a for-loop. The initialization is
> redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/spi/spi-dw-dma.c:580:17: warning: Although the value stored
> to 'len' is used in the enclosing expression, the value is never
> actually read from 'len' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/spi/spi-dw-dma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index 0ecbb6c36e23..f4c209e5f52b 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -577,7 +577,7 @@ static int dw_spi_dma_transfer_one(struct dw_spi *dws,
>   	sg_init_table(&tx_tmp, 1);
>   	sg_init_table(&rx_tmp, 1);
>   
> -	for (base = 0, len = 0; base < xfer->len; base += len) {
> +	for (base = 0; base < xfer->len; base += len) {
>   		/* Fetch next Tx DMA data chunk */
>   		if (!tx_len) {
>   			tx_sg = !tx_sg ? &xfer->tx_sg.sgl[0] : sg_next(tx_sg);


