Return-Path: <linux-kernel+bounces-68754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B8F857F92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAB528D0C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B18112FF6C;
	Fri, 16 Feb 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ntvq6ix2"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296F12FB37;
	Fri, 16 Feb 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094449; cv=none; b=UNz3B6mj3TH8eGyoeCtr00SCmEydyXt8xV6pxArcbunCPz/agI9PfTB4aqSCSSvAGLwFbKD6vxV2eb9eYBtVvvDLk/KxKyPblmvwf57U6CIRlGdy5zcy9xchro+aVLVmeic/rEcMIQGoQMUJfrAdjrb5/uV6vhMos7unD9vdEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094449; c=relaxed/simple;
	bh=5NGq9FrcNBMYKZLlkEAx/UyXGvS55+Fgr5VvhNVrM6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpnVRdgD/J335ICUygKx2lHRBKwQHEv9H4YX5ozOWI3Rs1AD4sr2AkQ7bWhJiZGDAqkvKKmTwFx6knR02A+WG0LCsay0HLwORbbR45J2z1lFP1nv/RIaJP+yMQ5UGWAuUSJ0o3A6H+hF1soLOgpEeJQrUgqYbXmMqrCRbZR08m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ntvq6ix2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d911c2103aso13983725ad.0;
        Fri, 16 Feb 2024 06:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708094447; x=1708699247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qIAK96YU7zLYgGvVOp0/LEyHOxuG7q3thhgl5y+afpk=;
        b=Ntvq6ix2VLBaf9swuw6tRT3aM+eYaX30wNhIfs5q3pKcZIyQR3dNN1IVafbKmo3fU7
         F2hA/DMw7zfxdvL5DpwZzp4irXgpmWOhEWbDAHaGmCvwaVBG+A909vw+pLo5SHYwYRpb
         RAZkZS69Z8GL7kUCLsY4oLSQ+NV0GOcuPaQr9muGKBjEpyXmwEOrWL8oyRfk2AgwMAZj
         kMjWw9Uly7T08k/sjGBTtEmJ+w19fGWaNU+y+caYrlVOgay6ijbA8Pw/QDaMRqvcqywZ
         qFycqZy6x+CPTsG9azOCXp39/xb0HgxLUm1zi/AqH3KubO675iL0sWmLAlKV6lEYE6Be
         yRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708094447; x=1708699247;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIAK96YU7zLYgGvVOp0/LEyHOxuG7q3thhgl5y+afpk=;
        b=iMVvuOkFei42VGy9p4a3lJNt2wU2YziliB+H9A1q7EmGUi5ul4AQLnoqI0FcECwZfh
         UdyWrB2bJE7AIMoRKdZUWyDnP98xa8WYMZFSOoPjJizXIqfCzbQgtA7hE782X4vsaeit
         ZQgUvZ0Jz42kYbKGqnXwngXX0tzIb2F1Bg63+PzA7/pAOWqFl/wro55KDuBFLwNQZ1cp
         kv7i7GiCuzWCP+9D8Qa6Ny6YCUgq5I5Zp+9npl0O9bXIXzJll/ahT4nChguxRd96hPYt
         uBX6NPt9kS2l9s/C8oso60zjUXeRAB8MhlePOjShPTAbxRrbVtoZaj6Y5Cr2uat5XzcZ
         DLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7lHTMX8BzJ7vud3bZCgFeT81+40iMLTH0jlgugyJk8UzLBxMB8+B2rnnT/WL3EmgQBFSs9mAQ4EyW0P7vcOOs7XzCE7BO/eL8UO1WX6mavjWeEr7M/SEiPseqVKEppBs6h5Rb8Z/R
X-Gm-Message-State: AOJu0YxjiuJ+4S/WmE4pBbxmQfQPDGUvYOVG22ydnZZM2QitfrngjBah
	SanJsdmroQICfct8ktJ7KWC/NeorCDFKuR6lV9fxPA0rBYHytcAGtV+8Dv1j
X-Google-Smtp-Source: AGHT+IFwcMOTosjdD+7J7N0xCsPSKy/maZjf7KpN5DSvK6kE9Y8hnToG4zBNMGt58nwjBKXMKsm+1w==
X-Received: by 2002:a17:903:950:b0:1db:b6d3:adec with SMTP id ma16-20020a170903095000b001dbb6d3adecmr821263plb.17.1708094446893;
        Fri, 16 Feb 2024 06:40:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jz7-20020a170903430700b001dbb385cfdesm696702plb.105.2024.02.16.06.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:40:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c5ca9869-330c-42ae-a0a7-8367d2de0c50@roeck-us.net>
Date: Fri, 16 Feb 2024 06:40:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update broken Datasheet URL
Content-Language: en-US
To: Okan Akyuz <okanakyuz@okanakyuz.com>, jdelvare@suse.com, corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240216075212.69118-1-okanakyuz@okanakyuz.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240216075212.69118-1-okanakyuz@okanakyuz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 23:52, Okan Akyuz wrote:
> The URL for the document in version 19-4039 Rev1 has changed. Updated

Update

> the URL reflect the conrect location of the datasheet for the same

correct

> version.
> 
> Signed-off-by: Okan Akyuz <okanakyuz@okanakyuz.com>

This is the third version of your patch, and the subject should include the
subsystem and affected driver, such as

[PATCH v3] hwmon: (max6620) Update broken Datasheet URL in driver documentation

You should also provide change logs.

I'll fix up subject and the spelling errors, but please keep that in mind
for future submissions. Please also note that the subject prefix is subsystem
specific. It always helps to look into other patches affecting the same file(s)
to determine the most appropriate prefix.

Thanks,
Guenter


