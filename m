Return-Path: <linux-kernel+bounces-151150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F078AA9C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AEC2844B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B14EB44;
	Fri, 19 Apr 2024 08:09:17 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CFF405EC;
	Fri, 19 Apr 2024 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514156; cv=none; b=LMsQY2LHTd6HwqYR+QJMeq3h9bB7nhPB5U4RHADcNLyfxHNaEidhAlSjZVni1aUxXva0jnIQ1mBg7jia1aulCC+D3YTIyCky02FwdKi1pT5MMX5gHoSwy5y0yN9pGo37oIP8QOD61p2Ca7lgzIzNA4PCAuuHjUUGsmX3zfmSHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514156; c=relaxed/simple;
	bh=0FeIyAl5J+f6MhxHikfAvdWtKm6sUtgx5AhVM0OAZm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9fZ6xV8IlYbUjP89lRtvaEv6oF9VPcbuYfydu3USZkXcI14xMXXNHHcVSwWwpzOxZp3TIjdzjtRujETGB3MtLRkxGl3YsfSOzhLiAXKhuuCRzD4zpHeNDfdv72AU3SBVKb9yleG5hjFZEhySQ3iJRWaKxb63hGSy2aseosGoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d6e23253so2045341e87.1;
        Fri, 19 Apr 2024 01:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514153; x=1714118953;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYKfC0KCIs1kuXetvqewFSEH/qY4fmwUu3v54HoMOz8=;
        b=S88/JiEZapqwtfhgTVQbw0QSFPR3+qqSJkdANtDqFlh+LXhuM1VwLm7eDOc3JM9FYA
         wK9cRld9z53dW/tAc2Z8LaV+hb9JTrY27eAtI8BEzoXq6aeooBxOIrWZpClo4T1mKH3n
         mfl9slpBnlPK5BiGZ2R01WOH/AvlsW0xNx2PIxcqVXWUkTXyb4WI30rC0TloQrh1eRC4
         IB8MhSSKLDyJ/3T1ro2k8PZXXBOybuNJjK+Cr0hHG1+XOIiXo6T01WAdVAkHCliw1Du1
         9fOcYmJ27R4DqRH1b9vYYkeiDWBl025iVYdFvRfgeC8jE9bwX2EmocxqPOpUPEeApzLA
         L2zw==
X-Forwarded-Encrypted: i=1; AJvYcCXtdz0Tu+XqJhCuLgaQhk2hWfiTJZKmOB91Ycj+Pv43rd2ELslLyd+jPen30uh0kV5JIgq3+0wJT1zlUgVv+vb9B9vqWoqZQ77T7Fw7wNDgc45er8VqgL/g8TJOTBlIPNs4W9g9DhOVxa8eKQ==
X-Gm-Message-State: AOJu0YzVhW8YJwegpyMCC1uL0TJ15q5liRUsBb+rQC3JJJe3BoHlYSmU
	hUv16AEddJ1og8Ni/E3v+EKOolWhISY8vhWkGpgxPoyBaCyfaIZtTorT53NX
X-Google-Smtp-Source: AGHT+IH/q/7de2ceMPrwn9e0gAEKOdVqmd7DaOIp9JdejswMIkXfjo1HLvOqoGrDiWXrgikox1sj+A==
X-Received: by 2002:ac2:47f9:0:b0:515:a8c9:6e99 with SMTP id b25-20020ac247f9000000b00515a8c96e99mr1129368lfp.5.1713514153014;
        Fri, 19 Apr 2024 01:09:13 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id et3-20020a056402378300b00571d8da8d09sm87749edb.68.2024.04.19.01.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 01:09:09 -0700 (PDT)
Message-ID: <ac79cc6f-9da2-4c09-b1d3-daa6f9baeea2@kernel.org>
Date: Fri, 19 Apr 2024 10:09:08 +0200
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
 <8947962f-e39e-4e96-9d1e-691e40d49349@kernel.org>
 <cbf6d34a-663c-440d-84e2-86054c605c8e@kernel.org>
 <cbf77a8b-b37c-41d8-a7b5-a1c935571a1d@samsung.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <cbf77a8b-b37c-41d8-a7b5-a1c935571a1d@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19. 04. 24, 10:00, Marek Szyprowski wrote:
> On 19.04.2024 09:53, Jiri Slaby wrote:
>> On 19. 04. 24, 9:43, Jiri Slaby wrote:
>>> On 17. 04. 24, 14:45, Marek Szyprowski wrote:
>>>> I alse tried to change the "if (dma->mapped)" check in
>>>> msm_start_tx() to:
>>>>
>>>> 1. if (dma->tx_sg.length)
>>>>
>>>> 2. if (dma->tx_sg.page_link & ~SG_PAGE_LINK_MASK)
>>>>
>>>> but none of the above worked what is really strange and
>>>> incomprehensible
>>>> for me.
>>>>
>>>
>>> Aaaah, nevermind, what about this?
>>>
>>> Two bugs:
>>> 1) dma_map_sg() returns the number of mapped entries. Not zero!
>>> 2) And I forgot to zero tx_sg in case of error.
>>>
>>> --- a/drivers/tty/serial/msm_serial.c
>>> +++ b/drivers/tty/serial/msm_serial.c
>>> @@ -506,8 +506,8 @@ static int msm_handle_tx_dma(struct msm_port
>>> *msm_port, unsigned int count)
>>>           kfifo_dma_out_prepare(&tport->xmit_fifo, &dma->tx_sg, 1,
>>> count);
>>>
>>>           ret = dma_map_sg(port->dev, &dma->tx_sg, 1, dma->dir);
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!ret)
>>
>> Still wrong, ret = -EIO missing in here.
> 
> "if (ret <= 0)" seems to be better here.

It returns unsigned, so I have a better patch. Will send in a second.

> Indeed this fixed the issue. I checked the code many times, but I missed
> this dma_map_sg() return value issue.

Perfect!

> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Could you test that one too :)?

thanks,
-- 
js
suse labs


