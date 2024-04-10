Return-Path: <linux-kernel+bounces-138682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FA789F8FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8223C2822A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E1D16EC0E;
	Wed, 10 Apr 2024 13:50:56 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822316EBEF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757056; cv=none; b=gjA0bEL8nbM4H5RWWCf79CoC2PRYyGLpzWy4gIt/KK/ECyJzzEKr18elgYcwFcorxEc6BZKQizzKD7cdldQvtrNQID2T7pfWmtND5q2m6mH8nJGq0VX2nxOCb8aMPEQbff1hhLF2m/MDrJ1Q0NR04IbnGhTOD2hFwwmCGBTE1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757056; c=relaxed/simple;
	bh=INT4Opd/0WLUScHXBxY32HEgALY2P/YbnCaf36THAfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFvlZMkt/FZ4w2MhUWs0GR2uhY0x4x10kUkLkmzlJxrdyNJ4ao+zbGTJLJJEgu3I2Qq+BmHU42siWGyr5hiY7hWU9F/eTBZ4oUWfMZCl2Mnt8gJR/8givigxntTDK8Ql/p63+doQZeW4TMwcO1A3TqGhZh73o2D7WbN25oqtzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d8d4deeb8dso857391fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757053; x=1713361853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTEBIEhSXX8ZuBnnW5p6JPC5VNWikcq932CQjXQrBDw=;
        b=T9FNkHRldNTY+YZNiIStBz3CvoJLNUrYgQ28Ju3G1x0q9Uimnui4adQ6whfy+GSUH5
         gGZoD5qzaw8jXtCUEhyDrbUbHTmTWv3rcjBTLXhds00BlOYF+tMVt2dJ6NMkjKHV9Mno
         tDbePOpB4WxXJCpYnBKkFJ3vaQW1hVNOjRzyyYLhfncN8G2/Gan3XQFd9W74lU+90gBx
         1F0nRGB6I2qv6oyJs7+L3b13gmQkOV/C//Qy1kyRukETTgxQuh7Wbh5bCtBQkLhjxpXa
         XJiCmLR2pGpWbVZhguiKri7NJkEKkmNmUBnbm05xx2X3uPHxIsq3gYrgtYaT1V+/u807
         zV5g==
X-Forwarded-Encrypted: i=1; AJvYcCWzXG0cJFxflV1nzZ6rDrjaHeO/IhfBjp/gRCtOlq+hCEXnlF7Hv11uBlHguQuvb5nlqVciHoaVK20/KMSwI3EetEpYgkShgqtU3CBB
X-Gm-Message-State: AOJu0YwqWTg3LvXzXL/Z4nsUwuKAvQtHuG88Th3AowQgOtMyUvNC1+N5
	5Ondw1cyR/1FC2a/iul44rdSJf03FFZZ2KqPXX0OrBZlyj0HM0Tr
X-Google-Smtp-Source: AGHT+IF3xGSIeEmgYEaI1UcHgqM9OP35oZaWJvE7XyA+Mkgth+mf7yQjmxPUXCcXdsr/KO9uedr9FA==
X-Received: by 2002:a2e:3c05:0:b0:2d4:7458:b65 with SMTP id j5-20020a2e3c05000000b002d474580b65mr2092025lja.2.1712757052461;
        Wed, 10 Apr 2024 06:50:52 -0700 (PDT)
Received: from [10.50.4.160] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d6752000000b00343a3e62997sm13714144wrw.50.2024.04.10.06.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:50:52 -0700 (PDT)
Message-ID: <959e5458-4c4d-4ab4-b9c2-8740156005cc@grimberg.me>
Date: Wed, 10 Apr 2024 16:50:50 +0300
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
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <03370383-d8d1-4b43-89f4-e9a3985c96e9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/04/2024 15:05, Hannes Reinecke wrote:
> On 4/10/24 12:21, Sagi Grimberg wrote:
>>
>>
>> On 10/04/2024 9:52, Daniel Wagner wrote:
>>> On Tue, Apr 09, 2024 at 11:26:00PM +0300, Sagi Grimberg wrote:
>>>>
>>>> On 09/04/2024 12:35, Daniel Wagner wrote:
>>>>> From: Hannes Reinecke <hare@suse.de>
>>>>>
>>>>> Any authentication errors which are generated internally are always
>>>>> non-retryable, so use negative error codes to ensure they are not
>>>>> retried.
>>>> The patch title says that any authentication error is not 
>>>> retryable, and
>>>> the patch body says "authentication errors which are generated locally
>>>> are non-retryable" so which one is it?
>>> Forgot to update the commit message. What about:
>>>
>>>    All authentication errors are non-retryable, so use negative error
>>>    codes to ensure they are not retried.
>>>
>>> ?
>>
>> I have a question, what happens if nvmet updated its credentials (by 
>> the admin) and in the period until the host got his credentials 
>> updated, it
>> happens to disconnect/reconnect. It will see an authentication
>> error, so it will not retry and remove the controller altogether?
>>
>> Sounds like an issue to me.
>
> Usual thing: we cannot differentiate (on the host side) whether the
> current PSK is _about_ to be replaced; how should the kernel
> know that the admin will replace the PSK in the next minutes?
>
> But that really is an issue with the standard. Currently there is no
> way how a target could inform the initiator that the credentials have
> been updated.

I'd say that the sane thing for the host to do in this case is to reconnect
until giving up with hope that it may work. This seems like a better 
approach
than to abruptly remove the controller no?

>
> We would need to define a new status code for this.
> In the meantime the safe operations model is to set a lifetime
> for each PSK, and ensure that the PSK is updated on both sides
> during the lifetime. With that there is a timeframe during which
> both PSKs are available (on the target), and the older will expire
> automatically once the lifetime limit is reached.

That is a good solution, and will also prevent a loss of service until
the host credentials are updated as well.

But regardless I have a feeling that simply removing the controller upon
an authentication error is not the right thing to do here.

