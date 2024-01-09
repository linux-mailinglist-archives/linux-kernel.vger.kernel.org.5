Return-Path: <linux-kernel+bounces-21004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB8828859
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734121C244E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B268739ADB;
	Tue,  9 Jan 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fttFU+Tf"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896A381B7;
	Tue,  9 Jan 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cce6c719caso33569291fa.2;
        Tue, 09 Jan 2024 06:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704811241; x=1705416041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E46ffdSTwzbY+6umSst1fjPfzul5twLbKlCIUc25YrQ=;
        b=fttFU+Tfn8Y5+6ydmlOaB5YgZl+Vjcy9awns45y1H6jN7yMMVHi0UFu/BYSY4Mr2Nq
         M/W2s8S0GwESo1dBQV+S2+XpkljVfT2lbwPiZQ6+avjtGE+oywm54jiL8B4P+X5SUHMC
         LP/WGB0sycoguH7gt2GVAk7X9vZZwyUEraVLiDFi/nS5zWz1eQgxzPmOyJHmfw0VlS2q
         jBgz4L+6UfkF9NMi7UcNeIOmXMBxbv6OMLSkiNQQ2JvPjmaQcE9GIQeq8hUC3H1gTE9K
         zrevCWKuatY7y94mhfrmPfWZ2HXYZCKeDDLG+9XUUqnS1aKC5sFEZrC2ZYdR5ZVwhuzd
         cHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704811241; x=1705416041;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E46ffdSTwzbY+6umSst1fjPfzul5twLbKlCIUc25YrQ=;
        b=QxttmTEqHNoZnIyyetRPSBF8oUKH8CGJ8Wy0j7q51ZTzFAFnefLjdl2KPOn385GYzG
         gJ1FsN80D4tta5HFYbuG6xrC8E7bF9vH78Rr7KzTQ4mAt/7iemrm8HBPCs29RiX/0IbW
         xT0x0iq3PkcL/afPDGCEISh8//ZsaYKaiXBiE9htmQLj6RCGP17mGcrQI7b+BErMBIM2
         fyvmw7x6hlOiqzuAXYm4XZ3MPHl18Ucg8HGVoB+CpTjpzP7Zi/kLQBGD85zD63Oe/wqr
         WJwcZ0Aetke3FCX9Gqrtn7s0vm9BHvkAZYpiFOq6FLNCAJEWyqy0B37RCUSilmkx/9eL
         BRnQ==
X-Gm-Message-State: AOJu0YzxkTD+2UiDLOeypwVW0IKGfbGzBmAYPOWbjQWIVG6LhWC4Rpu/
	I7qaJBcOp3oTVY2QAFtP4w8rmaypnyE=
X-Google-Smtp-Source: AGHT+IFDak7HV6NgVIoiI5794nqAhe5PHlhEWroOdtPk/p5HA6Z/9KMsGWcyi18tdF67W6jcgNEN/Q==
X-Received: by 2002:a2e:9b52:0:b0:2cc:cbc3:9def with SMTP id o18-20020a2e9b52000000b002cccbc39defmr2196554ljj.95.1704811240843;
        Tue, 09 Jan 2024 06:40:40 -0800 (PST)
Received: from [192.168.1.105] ([31.173.83.101])
        by smtp.gmail.com with ESMTPSA id v7-20020a2e2f07000000b002ccbc1f97c1sm435496ljv.52.2024.01.09.06.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 06:40:39 -0800 (PST)
Subject: Re: [PATCH v3] usb: core: Prevent null pointer dereference in
 update_port_device_state
To: Udipto Goswami <quic_ugoswami@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240109061708.26288-1-quic_ugoswami@quicinc.com>
 <3bb51617-81e1-7d19-598d-2b57164320e1@gmail.com>
 <5ef9db3d-1e60-4f42-8a5b-52a9800e4707@quicinc.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <3c2b2183-b1ee-6226-be5b-f2f9fc39e247@gmail.com>
Date: Tue, 9 Jan 2024 17:40:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5ef9db3d-1e60-4f42-8a5b-52a9800e4707@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 1/9/24 2:57 PM, Udipto Goswami wrote:
[...]

>>> Currently,the function update_port_device_state gets the usb_hub from
>>> udev->parent by calling usb_hub_to_struct_hub.
>>> However, in case the actconfig or the maxchild is 0, the usb_hub would
>>> be NULL and upon further accessing to get port_dev would result in null
>>> pointer dereference.
>>>
>>> Fix this by introducing an if check after the usb_hub is populated.
>>>
>>> Fixes: 83cb2604f641 ("usb: core: add sysfs entry for usb device state")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
>>> ---
>>> v3: Re-wrote the comment for better context.
>>> v2: Introduced comment for the if check & CC'ed stable.
>>>
>>>   drivers/usb/core/hub.c | 20 +++++++++++++++++---
>>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>>> index ffd7c99e24a3..6b514546e59b 100644
>>> --- a/drivers/usb/core/hub.c
>>> +++ b/drivers/usb/core/hub.c
>>> @@ -2053,9 +2053,23 @@ static void update_port_device_state(struct usb_device *udev)
>>>         if (udev->parent) {
>>>           hub = usb_hub_to_struct_hub(udev->parent);
>>> -        port_dev = hub->ports[udev->portnum - 1];
>>> -        WRITE_ONCE(port_dev->state, udev->state);
>>> -        sysfs_notify_dirent(port_dev->state_kn);
>>> +
>>> +        /*
>>> +         * The Link Layer Validation System Driver (lvstest)
>>> +         * has procedure of unbinding the hub before running
>>> +         * the rest of the procedure. This triggers
>>> +         * hub_disconnect will set the hub's maxchild to 0.
>>
>>     I can't parse this sentence, s/th is missing...
> Thanks for the review.
> Maybe this would sound better?
> 
> "This triggers hub_disconnect which will set hub's maxchild to 0"

   That seems parsable. :-)

>>> +         * This would result usb_hub_to_struct_hub in this
>>> +         * function to return NULL.
>>
>>     "This would result in usb_hub_to_struct_hub in this function
>> returning NULL", perhaps?
> 
> yah sound better. Will take care of it in next version.

   Probably "in this function" should be dropped altogether...

> Thanks,
> -Udipto

MBR, Sergey

