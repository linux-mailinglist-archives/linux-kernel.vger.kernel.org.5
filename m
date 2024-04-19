Return-Path: <linux-kernel+bounces-151135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E45438AA98D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493B7B20E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440064AEDE;
	Fri, 19 Apr 2024 07:53:11 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377972AF16;
	Fri, 19 Apr 2024 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513190; cv=none; b=c7cHG49EHJkvTKpYGoMJ8QfKulqx/hJmame0vfIjmsOQ4VfkLyV4pY9CAy0uCEGfHOoroOrMBv6SApUrFnSLHob4YU3Dt7GWQsnRtzgKayQeVlsG5Dop5uSguv8/S84hDkB8CnQ/bnBS3vwPjsKBLtHoTAlMbXCmqpfq31qwZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513190; c=relaxed/simple;
	bh=q/5APZuZ3d+HFuI6lhPu++jsp67VUOCrWPJcpMnETSM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WZAjA9jAdPr1Q4fmANPsU4huKXAyevvlfGBn23goKxO2c5CMplZoPlE+69mMprEmo2RGi9mLrf7QIMwZ4XjsgGibj3oB844mKpLPJyz92sc3n8D4bue1wEmFLYD4khfFUDgWYTHUk4PNetLIzvfvxNQCtHYLgENx2oGRD4tVjMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e6affdd21so769438a12.3;
        Fri, 19 Apr 2024 00:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713513187; x=1714117987;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkg2PsPWwQuUQlT1wRqaFRT1C3anmOX1PDdZQuQBq4k=;
        b=VX5Xg5RfSMuZk+rVZS8oi4KmxS1dpTGUgIltPyYUWU4NrVty/QwaPqczM/XLHLDHTp
         yljF2RCytpZw5IjKLmY40h+/Yl+1Xn/L0MlTO44H2g/SL9D3jNNKhmRi4WYARgzaSz8H
         Kz0VCTaU5WQVwU1baTc186avUxZ0S22MWgB/nNDu9AF+c7taVIMzMCt0ycV0Vo+4Y9yg
         4AZqpbR0a9jPS3fAyXLPgVMPnS953NbHKdZ5sGQq3VKRaMcAL2VxldgDfj5n2s1ikUcD
         9R/8xShn9uymRHQBRVhK7xCzcuidW886FUf98069n2Ve88TCdO8ixCFO/AYLcVXGl+9y
         p7vA==
X-Forwarded-Encrypted: i=1; AJvYcCXiGg0lcqZ5a8J8y0kGjhSy8iA4PtiZo+hVsl1T4ATaNoSEOa0w56xKLh+S5WeXdE9enkcA9uptmO/1Luvl3Ldq4k684UiX8N30A9ZCf0oo2OizXkkZJqCQ/7MWombTATIQRGo31I188InrgQ==
X-Gm-Message-State: AOJu0Yy06X9m6TE+wALunlkTrjCvjQ0645JrksPrBT+XsfkmaOMziwV+
	0rzBoGSZDxiey9GqUE6aXi5P60EnO6OF2NATqDmB08N+O4hP6NGx
X-Google-Smtp-Source: AGHT+IEgBOUgLIkEJ6kCFr/WsQTpsuLhwjRJ0h00DqJHqbr/vz6eCdlY6WS9+se8yPxp3p6D1AZerQ==
X-Received: by 2002:a50:8e17:0:b0:56e:57f9:8c83 with SMTP id 23-20020a508e17000000b0056e57f98c83mr961424edw.19.1713513187398;
        Fri, 19 Apr 2024 00:53:07 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id e22-20020a50ec96000000b0056e2b351956sm1812134edr.22.2024.04.19.00.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 00:53:07 -0700 (PDT)
Message-ID: <cbf6d34a-663c-440d-84e2-86054c605c8e@kernel.org>
Date: Fri, 19 Apr 2024 09:53:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] tty: msm_serial: use dmaengine_prep_slave_sg()
From: Jiri Slaby <jirislaby@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 Anders Roxell <anders.roxell@linaro.org>
References: <20240405060826.2521-1-jirislaby@kernel.org>
 <20240405060826.2521-12-jirislaby@kernel.org>
 <CGME20240415211716eucas1p10050cc8d4024707dd6f6331111cd3ce1@eucas1p1.samsung.com>
 <d3eb9f21-f3e1-43ec-bf41-984c6aa5cfc8@samsung.com>
 <54679d54-3957-489d-a8b5-b98ea1c8a93c@kernel.org>
 <0335b679-da36-42c1-a1ba-8affb7a98d44@samsung.com>
 <783c05cd-0cd2-4b0e-9dce-2a9fdfee7c74@kernel.org>
 <c26a049c-07ef-4837-9c1f-ac19b1251c3b@samsung.com>
 <8947962f-e39e-4e96-9d1e-691e40d49349@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <8947962f-e39e-4e96-9d1e-691e40d49349@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19. 04. 24, 9:43, Jiri Slaby wrote:
> On 17. 04. 24, 14:45, Marek Szyprowski wrote:
>> I alse tried to change the "if (dma->mapped)" check in msm_start_tx() to:
>>
>> 1. if (dma->tx_sg.length)
>>
>> 2. if (dma->tx_sg.page_link & ~SG_PAGE_LINK_MASK)
>>
>> but none of the above worked what is really strange and incomprehensible
>> for me.
>>
> 
> Aaaah, nevermind, what about this?
> 
> Two bugs:
> 1) dma_map_sg() returns the number of mapped entries. Not zero!
> 2) And I forgot to zero tx_sg in case of error.
> 
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -506,8 +506,8 @@ static int msm_handle_tx_dma(struct msm_port 
> *msm_port, unsigned int count)
>          kfifo_dma_out_prepare(&tport->xmit_fifo, &dma->tx_sg, 1, count);
> 
>          ret = dma_map_sg(port->dev, &dma->tx_sg, 1, dma->dir);
> -       if (ret)
> -               return ret;
> +       if (!ret)

Still wrong, ret = -EIO missing in here.

> +               goto zero_out;
> 
>          dma->desc = dmaengine_prep_slave_sg(dma->chan, &dma->tx_sg, 1,
>                                                  DMA_MEM_TO_DEV,
> @@ -548,6 +548,7 @@ static int msm_handle_tx_dma(struct msm_port 
> *msm_port, unsigned int count)
>          return 0;
>   unmap:
>          dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
> +zero_out:
>          sg_init_table(&dma->tx_sg, 1);
>          return ret;
>   }
> 
> 
> thanks,

-- 
js
suse labs


