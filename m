Return-Path: <linux-kernel+bounces-25917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30982D82B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E02B21524
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6D12C68E;
	Mon, 15 Jan 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWOLz7Ul"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211D12E70
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2dda9d67ceso73483166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 03:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705317355; x=1705922155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7PJr0uX6OU62EfIq4eQREzXkmMw6Rq4LEQoL9dytGE=;
        b=UWOLz7Ullz6ICa4YYiYE7rDZEVPRj3DAeKSwuQLJ9Wi99aEAlISLRq42vvYAbXNryR
         BX4Vqs5dqxusfM4xM/vxGfmrB8Y3kS7V23WaZoDebQn56qSskaWH5CID4ndt3vVl/5qo
         mfCc10v4p27FRx/T2M9Alo4YDxKvaiZQhtdmCA1DUdXE2lghVUSdzGkGEvAHJj2jFZED
         L1X2njzS1yB/kNh5QNgIt9ylGgl34z8gkFEZG2eWo4C7+21mZdlN0CFCArIaxIUh+VI1
         vW4T0X64KgsfdlsFdNTMyKxUhFq8MY+xkCGplBf4j4+ZmgmY73IeQXntk5dQNfCLWHQB
         v+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705317355; x=1705922155;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7PJr0uX6OU62EfIq4eQREzXkmMw6Rq4LEQoL9dytGE=;
        b=HeToJLXwyDDG0G4nBJhE9EEuk9YuZL2hXxmSVxDgQCahHzGhoEXlWB963zUhlEyYhb
         L1q5FxcEeKLskdsSZzBQ98pB6VNtVpGnQ5z+MjoYNQ4rWDJ49sNlwevS+ndZ7Fir+a9S
         TLKwL9Q89n9zNreNUIFS1HFrlwOWuWOQCF4YTiBWBHjqlRkOQgCfaeNe+6lrwEBHhJQn
         BHu4wfhKB7wYLpatUDCuZfT6tiw+GFbzu+iP3L1watxpPlrIJMiwznLNa8orlEjdLVnv
         TEO3TMeSuGFZO2LvLNGFLJmEUdqYC9jBfMr+BxWS89+nv2F80SMP1RW/AGGQgIsCquf4
         E+mQ==
X-Gm-Message-State: AOJu0YxjgCkSqmwxcUhNwKM9mI2IngjVSlaXD5rOCwcfkX7FnJoE38nt
	IFbVqjpoDd38kKTys3z0xFcsRKad4Cv/EQ==
X-Google-Smtp-Source: AGHT+IF4qgaEl5bxVtsYbR2fa7IWqqLUYtPYZZweFtOAn4wZut4h5/QazK5NVr2L76U4dkFPi42YcA==
X-Received: by 2002:a17:906:a250:b0:a2a:1835:70df with SMTP id bi16-20020a170906a25000b00a2a183570dfmr2094603ejb.140.1705317355141;
        Mon, 15 Jan 2024 03:15:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id um7-20020a170906cf8700b00a26ac6d55dasm5147607ejb.46.2024.01.15.03.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 03:15:54 -0800 (PST)
Message-ID: <ddb92cce-911b-48d9-a780-7b319f7491eb@linaro.org>
Date: Mon, 15 Jan 2024 12:15:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc/nci: fix task hung in nfc_targets_found
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Edward Adam Davis <eadavis@qq.com>,
 syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org,
 hdanton@sina.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stern@rowland.harvard.edu,
 syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
References: <000000000000a041b0060eb045ec@google.com>
 <tencent_E44436084AA874977705670A3CDD37BE9609@qq.com>
 <10fa514a-7fa0-449f-a7fd-cd3bfb0180d7@linaro.org>
 <199a52ed-59d0-4651-b361-3b3d0692a2bf@I-love.SAKURA.ne.jp>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <199a52ed-59d0-4651-b361-3b3d0692a2bf@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2024 12:08, Tetsuo Handa wrote:
> On 2024/01/15 18:36, Krzysztof Kozlowski wrote:
>>> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
>>> index 6c9592d05120..9a277228a875 100644
>>> --- a/net/nfc/nci/core.c
>>> +++ b/net/nfc/nci/core.c
>>> @@ -145,6 +145,8 @@ inline int nci_request(struct nci_dev *ndev,
>>>  {
>>>  	int rc;
>>>  
>>> +	if (test_bit(NCI_UNREG, &ndev->flags))
>>> +		return -ENODEV;
>>
>> nci_close_device() clears the NCI_UP, which is tested here, just after
>> acquiring mutex. And there is explicit comment about it just below your
>> code. Why it is not relevant?
> 
> Because the deadlock happens at mutex_lock(&ndev->req_lock), which is
> before test_bit(NCI_UP, &ndev->flags) is called. Please see
> https://lkml.kernel.org/r/d314e471-0251-461e-988d-70add0c6ebf6@I-love.SAKURA.ne.jp .

I see, yet still this code looks like moving or copying existing
test_bit(NCI_UP) outside of mutex, which is usually not the correct
solution for deadlocks. First of all, flags are supposed to be
manipulated under lock, so the code here can be quite re-ordered. What
stops the CPU to test negative in above (so: !NCI_UNREG) and then
execute nci_close_device before waiting on mutex here? Nothing.

The problem seems to be locking and solution is not to add one if()
outside of locking.

Best regards,
Krzysztof


