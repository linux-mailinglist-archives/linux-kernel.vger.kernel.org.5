Return-Path: <linux-kernel+bounces-148351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EEE8A814B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48904B203A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C525E13C699;
	Wed, 17 Apr 2024 10:50:54 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF7132803;
	Wed, 17 Apr 2024 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351054; cv=none; b=tpr/6OidHDxw2gY+wyaBFawtGLZhBkgAklUh9RzVZ6KN8xMqPqHutWXqUMI/LOAu6e3bwA//6J6uWS5JoirqSTU0ADAUYZwqpOLKwfW778t2NMpnbYHr3OR+o2PA+VYwtcx+o4+lwCDdHz/Fg8AMj1I/TSYj0I50opztUGm240A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351054; c=relaxed/simple;
	bh=XaAcT67M5RaPBWHbB+wNAlaIJeNyW5NuSWZzU/URrJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9oPobLrX7b7HJJX1BcEWLBXLl4HPPb4L2CbuMeKzcM7fURUWywDiJ5Fk50GbZXn7C/dhgA0QOVHf0MaHgvWMFTKFFLr4mpHt4fewtnfEO1App83xcWhZ6Taxmb8tFVO3PkHd4zh/kmpY+J9yiEGwJ1414zGEGAhF0GgnmIY4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so8414409a12.2;
        Wed, 17 Apr 2024 03:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713351051; x=1713955851;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vft5t+sb+qnt9u/cVXjqa7VMdCg/vVTNy1ZfkRM3NrY=;
        b=Psacht6kvNsOHExGmrf2s7qxDg4GfiLOP7HxOVcg5UCxdHHrziVRPmstgEy6FssOJl
         f8k3bXlyDOcvAG5cXkuEkglMJKvlGMOaRhWYf4X4cYXxCw+lP7jQY+AlHwWI4xn4ubId
         zhWykE2c3NZT6f3mdpRkp7vRIeDWMv62/o6jub73Y4h3EHT3Kd1S+sM1B1zotEQo2y8d
         plmNHlvQcrPPdMiSYRZaGRKyTkEcECV6CVnFfQY2NIsPS/2tC0mfMOD/MsL1XLD0yhb5
         m/YqbAlYXljGm4twuZDYSNA8dbJMc5XRQgtns6Xvj7TfFexOS1HNgYiLmFbOh9qA2IR9
         D/6g==
X-Forwarded-Encrypted: i=1; AJvYcCVgJSgk1HQskxkET83pAwLX3e61JmLzkgk5jkIMF3fAvoGF1mPnWBtozP/Gk6ZWJ5K3usRUzi9JXw+d+Qm+HOzcVkL7d9ZtEGb798K9Q77ijYbJVn5rx9GAr6OUVpQM2lQv90jnkYVOsyIw3A==
X-Gm-Message-State: AOJu0YwE6jXHqHEMKnIcuggxWXKFxEkhU/5DhaW7IT2BlxZSTIR+sQf2
	fyfOeTaDmnR+D6a16a//m8z0C8sjFiRgVtKu8ufZ6Cgp0aI5FHxf6zOflVhA
X-Google-Smtp-Source: AGHT+IGN9LcNvwblZ6ViBwpqt946fLccgyIeSYEbOBmB8loD7XnPuLo2PCB4MQwzI8484uEC8NEGsA==
X-Received: by 2002:a17:906:eece:b0:a52:6eb7:7654 with SMTP id wu14-20020a170906eece00b00a526eb77654mr8049679ejb.46.1713351050667;
        Wed, 17 Apr 2024 03:50:50 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id bv21-20020a170906b1d500b00a520b294d9dsm7978733ejb.150.2024.04.17.03.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 03:50:49 -0700 (PDT)
Message-ID: <783c05cd-0cd2-4b0e-9dce-2a9fdfee7c74@kernel.org>
Date: Wed, 17 Apr 2024 12:50:48 +0200
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
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <0335b679-da36-42c1-a1ba-8affb7a98d44@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17. 04. 24, 12:15, Marek Szyprowski wrote:
> Hi Jiri,
> 
> On 16.04.2024 12:23, Jiri Slaby wrote:
>> On 15. 04. 24, 23:17, Marek Szyprowski wrote:
>>> On 05.04.2024 08:08, Jiri Slaby (SUSE) wrote:
>>>> This is a preparatory for the serial-to-kfifo switch. kfifo understands
>>>> only scatter-gatter approach, so switch to that.
>>>>
>>>> No functional change intended, it's just dmaengine_prep_slave_single()
>>>> inline expanded.
>>>>
>>>> And in this case, switch from dma_map_single() to dma_map_sg() too.
>>>> This
>>>> needs struct msm_dma changes. I split the rx and tx parts into an
>>>> union.
>>>> TX is now struct scatterlist, RX remains the old good phys-virt-count
>>>> triple.
>>>>
>>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>>> Cc: Bjorn Andersson <andersson@kernel.org>
>>>> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> Cc: linux-arm-msm@vger.kernel.org
>>>
>>> I've just found that this patch broke UART operation on DragonBoard
>>> 410c. I briefly checked and didn't notice anything obviously wrong here,
>>> but the board stops transmitting any data from its serial port after the
>>> first message. I will try to analyze this issue a bit more tomorrow.
>>
>> I double checked, but I see no immediate issues in the patch too. So
>> please, if you can analyze this more…
> 
> I've spent some time digging into this issue and frankly speaking I
> still have no idea WHY it doesn't work (or I seriously mixed something
> in the scatterlist principles). However I found a workaround to make it
> working. Maybe it will help a bit guessing what happens there.
..
> @@ -434,7 +436,7 @@ static void msm_start_tx(struct uart_port *port)
>           struct msm_dma *dma = &msm_port->tx_dma;
> 
>           /* Already started in DMA mode */
> -       if (sg_dma_len(&dma->tx_sg))
> +       if (dma->mapped)

Thanks for looking into this.

I was hesitant if I should use a flag. I should have, apparently.

Quick question:
What's value of CONFIG_NEED_SG_DMA_LENGTH in your .config?

thanks,
-- 
js
suse labs


