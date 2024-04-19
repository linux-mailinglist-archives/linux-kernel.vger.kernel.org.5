Return-Path: <linux-kernel+bounces-151093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923CD8AA8FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9389C1C20D95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434953F8FF;
	Fri, 19 Apr 2024 07:17:30 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19892F5A;
	Fri, 19 Apr 2024 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511049; cv=none; b=bdxDysr3UCpSLhhSrVCSRiTbj3kpYidUn/5RRxv4WyH0PKBoDrANZ47EABIODEEuOhuGPubCrn1xC/quBshC5sxnJ19J8WvNAn9+SmSdYQG4mryPHAR1Y0yf4GrrujNVnKu80PnXbsVHaJH4o3nD+McXHuOUULtsM0Omm8eFAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511049; c=relaxed/simple;
	bh=iR4nmw/6bUlVqFo/LNyfyzNbJzhn7sOcg1mg45WUPJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTheCQe3vGKP2dLfw91DYt6iD8U6F9QzPUUvXqM9DAon0KUjas630QuQZlH0nQxcEBZLvV4wqVa7AwbMTLHEkjKXiWi1NEBKIhKZsDU9LtsyC169YPeLClJqXNbIvaVtYzDbBuTFDVA5sfnjyIfwr9YfDEElttAXao/EcvT7QMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51addddbd4so165451566b.0;
        Fri, 19 Apr 2024 00:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713511046; x=1714115846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A524ROUYg+D99/aUsZkq31+BQWgTFmO+3cgBz9aHMfU=;
        b=sv+BVcZHzo5LEjJUzf/r7ZYEH62aL6kTq41edp65OGdswZnz76Xzhe/1Vp5YaAMnYs
         p94fwXh7Lc6M4hFQSQyBHRnMY1aF4uuW2hvni87OSV7CLk8CfacT7LzbZD3/VZrulwqa
         LPsleA1LLxuwDYC3n0reIzT8UINwkGsxsj3jA6Lx1tKy3bYrarWF+JWVR06nlcqFcAEm
         zgng6kffZ409LazPl8ZPYpE211xl0Tx08ik5adwahyk5IAeUvAtY7tr2EJMtPOHBmCKP
         rM+OUUWCHv7zMj9H6LzkhTE6cYLQ2eb+6lvaIcgtXJKQx6hZ3r+LwE78b0zPIBVtkaNE
         8udQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3ioFX9roDoku/QvXLMg3WCEst1Xwk9hyuxw64K4GKRlXnojm4sxReojKw33FkZGdDucyte1Qtt+70vaI7/e9lEJ6Oh0uwg6UP9bEQO04eTyCLheoCJ/tDmhOUQfosqfzZD9iNcmTmOenxGw==
X-Gm-Message-State: AOJu0Yz9GW8xdTU/r1OumHu2zMEURAlryARWs8ufLjlXc9tH3y6XZPKO
	MQ8gtsmAJn7hTe8YW31BFmB5Ys0isbMxk89H9T41CX2cuI6gtnop
X-Google-Smtp-Source: AGHT+IH6Rw5ZsvhPP/J/GHbZ9QM80koi5jn9dly00SMBv2qplA8ruDRBPANavyhZf8wwthFPWzN08Q==
X-Received: by 2002:a17:906:6d05:b0:a55:653b:3981 with SMTP id m5-20020a1709066d0500b00a55653b3981mr841423ejr.50.1713511046069;
        Fri, 19 Apr 2024 00:17:26 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id gx28-20020a1709068a5c00b00a5237093bd2sm1824804ejc.36.2024.04.19.00.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 00:17:25 -0700 (PDT)
Message-ID: <c6d22274-b433-4757-a36b-40211bbe5c84@kernel.org>
Date: Fri, 19 Apr 2024 09:17:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] tty: msm_serial: use dmaengine_prep_slave_sg()
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
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <c26a049c-07ef-4837-9c1f-ac19b1251c3b@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17. 04. 24, 14:45, Marek Szyprowski wrote:
> On 17.04.2024 12:50, Jiri Slaby wrote:
>> On 17. 04. 24, 12:15, Marek Szyprowski wrote:
>>> On 16.04.2024 12:23, Jiri Slaby wrote:
>>>> On 15. 04. 24, 23:17, Marek Szyprowski wrote:
>>>>> On 05.04.2024 08:08, Jiri Slaby (SUSE) wrote:
>>>>>> This is a preparatory for the serial-to-kfifo switch. kfifo
>>>>>> understands
>>>>>> only scatter-gatter approach, so switch to that.
>>>>>>
>>>>>> No functional change intended, it's just
>>>>>> dmaengine_prep_slave_single()
>>>>>> inline expanded.
>>>>>>
>>>>>> And in this case, switch from dma_map_single() to dma_map_sg() too.
>>>>>> This
>>>>>> needs struct msm_dma changes. I split the rx and tx parts into an
>>>>>> union.
>>>>>> TX is now struct scatterlist, RX remains the old good phys-virt-count
>>>>>> triple.
>>>>>>
>>>>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>>>>> Cc: Bjorn Andersson <andersson@kernel.org>
>>>>>> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>> Cc: linux-arm-msm@vger.kernel.org
>>>>>
>>>>> I've just found that this patch broke UART operation on DragonBoard
>>>>> 410c. I briefly checked and didn't notice anything obviously wrong
>>>>> here,
>>>>> but the board stops transmitting any data from its serial port
>>>>> after the
>>>>> first message. I will try to analyze this issue a bit more tomorrow.
>>>>
>>>> I double checked, but I see no immediate issues in the patch too. So
>>>> please, if you can analyze this more…
>>>
>>> I've spent some time digging into this issue and frankly speaking I
>>> still have no idea WHY it doesn't work (or I seriously mixed something
>>> in the scatterlist principles). However I found a workaround to make it
>>> working. Maybe it will help a bit guessing what happens there.
>> ...
>>> @@ -434,7 +436,7 @@ static void msm_start_tx(struct uart_port *port)
>>>            struct msm_dma *dma = &msm_port->tx_dma;
>>>
>>>            /* Already started in DMA mode */
>>> -       if (sg_dma_len(&dma->tx_sg))
>>> +       if (dma->mapped)
>>
>> Thanks for looking into this.
>>
>> I was hesitant if I should use a flag. I should have, apparently.
>>
>> Quick question:
>> What's value of CONFIG_NEED_SG_DMA_LENGTH in your .config?
> 
> 
> CONFIG_NEED_SG_DMA_LENGTH=y
> 
> 
> I alse tried to change the "if (dma->mapped)" check in msm_start_tx() to:
> 
> 1. if (dma->tx_sg.length)
> 
> 2. if (dma->tx_sg.page_link & ~SG_PAGE_LINK_MASK)
> 
> but none of the above worked what is really strange and incomprehensible
> for me.

Thanks. Neither for me. Could you add:
         {
                 static DEFINE_RATELIMIT_STATE(rs, 
DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
                 if (dma->mapped != !!sg_dma_len(&dma->tx_sg) && 
__ratelimit(&rs))
                         printk_deferred(KERN_DEBUG "%s (%d): mapped=%u 
dma_len=%u\n",
                                         __func__, __LINE__, 
dma->mapped, sg_dma_len(&dma->tx_sg));
         }

before each of your 'if (dma->mapped)' to see where sg_dma_len() is 
wrong and what is its value in the bad case. I hope I did the logic right.

thanks,
-- 
js
suse labs


