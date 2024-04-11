Return-Path: <linux-kernel+bounces-140100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B5D8A0B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE752285ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217B713FD85;
	Thu, 11 Apr 2024 08:38:06 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51C913CF91
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824685; cv=none; b=VBIxaTHObB6JuPy+/SFmA4ayOrejx+tbiBJHGiXJw6jkejk9oqQLcIW7A42yxJBjscWA0cBGRQG+tpwbsU4WmSsior0SwxW77q2r62DDw4UA0R46h9QU2hQYaZyqhIru9FXfKCPf68c0DmaOrQxJbfA+hSyNorwjnXtfl8zS6bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824685; c=relaxed/simple;
	bh=laA130yrwEguuAhoKvRDBYkw1ABegIvHvgso1mUrLoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+rNP7/pZhAz1Y6z1RfEX/oOYDp4uYIpdHfpZgfK/GsM5CJfTyopJiTrSiZuj+ZDSzU8/7DN3Y8nS1ENdYHpWY+OtOVh5PbntOiKu4VG9nfF/q33ZN8LMrf4QFX1YIO1iRi99LPr9q6M0dMEDhdv3r3Vk8yDY4bkicHuEWGxKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a52231daf92so9497366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712824682; x=1713429482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlTxrc8UGeYsYju69cSCDIVBGjrkM+HpaU154MNsK+c=;
        b=kNSpdqG5mgsonTrezxqcigVxxxFSRrN3jeVCtcMt75GbhlYPAYWMH6GbNDNfY+hzyo
         oqR8GXNIpYXVLKLb+OhUcsIdGcAPL4dzGnhiOOqpZ0EFy0ewGA91qC21ORWG+Gd8WS+s
         Ry2GqESPCi8SZ9j3ppeleIuWm4blcX4ej69TT4pconX2S4jM8YuaFMtFyBIgVFEAFLe4
         bcxIwHiNt0erFaU6FaNwmNFncf9DgNvbzfe3SOxR6a3MDqGEKvhxD51zWUtwizo3nlP5
         3qVEWQ7VX7ALsIPtENMnWUqKymkttc0zkWpu5O78sjU37KFRwwHVAJ+sl83tNfZ633Cx
         vsRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUixYdnoj4iIqi2hy0uUBV2a6coCBAxTerXhcNNURPOvN8cZ4p9nTUY8IkMCy6Fy00b/jDExAnIn9CN9CCgjf19eco1Q47XIA7+CZ98
X-Gm-Message-State: AOJu0YxM5grO1hPc3Gvay1DqzuIWqLFl2cPmQsi0yW/D874kIdznpjqt
	xMsQ1qi5GqJZkrxuamlxVpUhlW+nYX3UkGeWWD5K7HADdau5pQnZ
X-Google-Smtp-Source: AGHT+IExhgCxrfw7ZhllSpKTX8uANrAEqjLHXMCdVPydNm8bg8RDAc9UCSptADWK4A4vVBXV/AZJKw==
X-Received: by 2002:a17:906:6a29:b0:a51:d463:335a with SMTP id qw41-20020a1709066a2900b00a51d463335amr3545971ejc.3.1712824681808;
        Thu, 11 Apr 2024 01:38:01 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id bg25-20020a05600c3c9900b004162d06768bsm4861841wmb.21.2024.04.11.01.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 01:38:01 -0700 (PDT)
Message-ID: <7dbdce29-621a-4286-a832-2918ec1794e4@grimberg.me>
Date: Thu, 11 Apr 2024 11:37:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
 <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
 <7jqbhmskuzfvpjlavk7oqefmc72m5j2wj7525c7y2vlsfnaajx@57pfbmfvf4kt>
 <8c9a980f-4885-479c-9078-7f87dc92175c@grimberg.me>
 <03370383-d8d1-4b43-89f4-e9a3985c96e9@suse.de>
 <959e5458-4c4d-4ab4-b9c2-8740156005cc@grimberg.me>
 <88684d2f-8b36-40c4-99c8-ea07f42dd805@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <88684d2f-8b36-40c4-99c8-ea07f42dd805@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/04/2024 10:11, Hannes Reinecke wrote:
> On 4/10/24 15:50, Sagi Grimberg wrote:
>>
>>
>> On 10/04/2024 15:05, Hannes Reinecke wrote:
>>> On 4/10/24 12:21, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 10/04/2024 9:52, Daniel Wagner wrote:
>>>>> On Tue, Apr 09, 2024 at 11:26:00PM +0300, Sagi Grimberg wrote:
>>>>>>
>>>>>> On 09/04/2024 12:35, Daniel Wagner wrote:
>>>>>>> From: Hannes Reinecke <hare@suse.de>
>>>>>>>
>>>>>>> Any authentication errors which are generated internally are always
>>>>>>> non-retryable, so use negative error codes to ensure they are not
>>>>>>> retried.
>>>>>> The patch title says that any authentication error is not 
>>>>>> retryable, and
>>>>>> the patch body says "authentication errors which are generated 
>>>>>> locally
>>>>>> are non-retryable" so which one is it?
>>>>> Forgot to update the commit message. What about:
>>>>>
>>>>>    All authentication errors are non-retryable, so use negative error
>>>>>    codes to ensure they are not retried.
>>>>>
>>>>> ?
>>>>
>>>> I have a question, what happens if nvmet updated its credentials 
>>>> (by the admin) and in the period until the host got his credentials 
>>>> updated, it
>>>> happens to disconnect/reconnect. It will see an authentication
>>>> error, so it will not retry and remove the controller altogether?
>>>>
>>>> Sounds like an issue to me.
>>>
>>> Usual thing: we cannot differentiate (on the host side) whether the
>>> current PSK is _about_ to be replaced; how should the kernel
>>> know that the admin will replace the PSK in the next minutes?
>>>
>>> But that really is an issue with the standard. Currently there is no
>>> way how a target could inform the initiator that the credentials have
>>> been updated.
>>
>> I'd say that the sane thing for the host to do in this case is to 
>> reconnect
>> until giving up with hope that it may work. This seems like a better 
>> approach
>> than to abruptly remove the controller no?
>>
>>>
>>> We would need to define a new status code for this.
>>> In the meantime the safe operations model is to set a lifetime
>>> for each PSK, and ensure that the PSK is updated on both sides
>>> during the lifetime. With that there is a timeframe during which
>>> both PSKs are available (on the target), and the older will expire
>>> automatically once the lifetime limit is reached.
>>
>> That is a good solution, and will also prevent a loss of service until
>> the host credentials are updated as well.
>>
>> But regardless I have a feeling that simply removing the controller upon
>> an authentication error is not the right thing to do here.
>
> Guess what; that's what I tried to do initially. But then Christoph 
> objected that we shouldn't generate NVMe status codes internally.
> But if we can't do that then we'll have to invent yet another way to 
> return a retryable error, leading to even more band-aid.
> So I am not quite sure how we could achieve that, short of making 
> _every_ error retryable...

So this whole thing is that you want to make the host to not reconnect 
if the controller
sent a DNR and reconnect otherwise?

What are you returning today if the authentication failed? Am I reading 
it right that you are
returning -ECONNREFUSED? I think that for the specific case of 
credentials mismatch (that and only
that) you may want to return -EKEYREJECTED. That according to the 
documentation (/* Key was rejected by service */)
is specific enough that perhaps we can treat it specially when asking 
"should I reconnect?"

Thoughts?

