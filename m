Return-Path: <linux-kernel+bounces-165249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBF98B8A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24FD1C2150A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC6B1DFFB;
	Wed,  1 May 2024 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQMY5ME6"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333615BB
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566824; cv=none; b=ZwqVZi/l9PxuMeQ9LCv47iY5U9dqMvvSOFYWyYfXlH7r27JrDgwiv1xuNlfUNX1gY7HcrJl6TIDq5XTPh784vo81qYdJErKp8TcTU0iUEA9sKeycsZ0EiPTC/GUD+z/LHIXh7VKM3oll0yqg/b3cPZh3CcKPSIZpfJ2MD8CMg2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566824; c=relaxed/simple;
	bh=ddBN2orugqoiowft7YD0OMJ2aXR+sVrgAy753dZnVUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2AcWnbWELSSVLxE3eLOlMzc6N10eWJtDv5OrrwwH8slRNSLnJZ4K9yL78AE77RPx7L4+/+Lkdr48DvpAN/UbbaoOt/ZOdm5yvYvcsoCzNXzHms1vh0gcV0TbEcGtIcIUB7+fYHSnomqyWMvXHeEA5XS6FD3Ykgy4Lm1LERM1n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQMY5ME6; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572b37afd73so106284a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 05:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714566821; x=1715171621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGEbZ1WUGdzfiORp9nU6j7TK+5tnxv91/DAAb17aZJ8=;
        b=ZQMY5ME6UClZRfgEzbi0MOPDCv957XiOm4ZDzHgSCTF6/pqD0plH9tEw1H3wdCQC8s
         UFVwg73m4a/a5jbKbdi+quOpa3jOm+5fNUCYqep31u86MOJGDYrFTqEvCTQbiW9EAu1r
         mZGoYIFeDS7o8/WoeEvPNPe+vC/SLdP5K4Y/IfpZV56jSf22yb4vlMeAUogNHokTptPn
         vzILVeGws9r0koGkT5b7PFm+QOxGj4r5nvZBKn7shwrbGWpcRgFAbyBnd1nwRU6BifKT
         32nrkKALGB/5LDTcgIUWHbLNjwYdPy/hYiKRG1K+eDUhoeHbLAGeL5McMuaQLBKG+fMF
         NrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714566821; x=1715171621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGEbZ1WUGdzfiORp9nU6j7TK+5tnxv91/DAAb17aZJ8=;
        b=PH/pfshMIXLdhKm+5RphNwsomi9qDhAHxKrV+26ABdDDGxCRIVqnGa+IvIUxAOIcSy
         seXr6QyU0kgV7LBfeTn2eTRIObphK2sExfFoMFgBPBh2K4UOAVCILP+fsGenYE7SYr+p
         tJbmSyf7yzkTacRhR8f5ZszyZJ7HwSUow25no6GvV1A9WWAaA7YMTeUb9Vj4wv5oOS4R
         uXdrNdfA0aMZszSVywhwXFZKDSVxaK20k3UosH01NMwGRp1mST6+PO5ZKXUbFNnlAnPS
         PEUjlBCV++KAGz2uVkNGxdDzWpQOc6rXLxexrf4Tf0Z8Kmyxh2kMuZpscHAU3j3mx561
         n1ag==
X-Forwarded-Encrypted: i=1; AJvYcCWZpZRWzJDtNfmAgmE1xyuruvMWHmVjpgJuFsE1UcJPYYJ/d3OIiX1zjdRqGCtvInC/Iho3zLIlHr/S+RustqhOZRj5eIdL7YEYTALR
X-Gm-Message-State: AOJu0YzuTpGoM9/EaWeqvtxQ3K3att50Y7Q4nxV23OJwBtbrLP3cDFj8
	fnun1J6qv0kHRcZME+81xNMa/fsOwh5xDSaTtR4atQ8/e468ydF3s5kNhqTGT/U=
X-Google-Smtp-Source: AGHT+IEbS4Yt7JE6UnULi+kv3McDKyL6NU7sOqpVoGcTR0IebdP3MQLFT1ItKle7H/CZfdAztzuWtw==
X-Received: by 2002:a50:8d52:0:b0:568:d5e7:37a1 with SMTP id t18-20020a508d52000000b00568d5e737a1mr1807623edt.36.1714566821261;
        Wed, 01 May 2024 05:33:41 -0700 (PDT)
Received: from [192.168.1.20] (net-37-182-167-227.cust.vodafonedsl.it. [37.182.167.227])
        by smtp.gmail.com with ESMTPSA id h25-20020a0564020e9900b0056bc0c44f02sm15161609eda.96.2024.05.01.05.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 05:33:40 -0700 (PDT)
Message-ID: <673df61a-e0f5-450b-8fb4-746bc950e3d1@gmail.com>
Date: Wed, 1 May 2024 14:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v3] drivers: use __free attribute instead of
 of_node_put()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudeep.holla@arm.com, javier.carrasco.cruz@gmail.com,
 julia.lawall@inria.fr, linux-kernel@vger.kernel.org, rafael@kernel.org,
 skhan@linuxfoundation.org
References: <20240424125401.oxvt5n64d7a57ge3@bogus>
 <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
 <20240501094313.407820-3-vincenzo.mezzela@gmail.com>
 <2024050102-reshuffle-licking-f84e@gregkh>
Content-Language: en-US
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
In-Reply-To: <2024050102-reshuffle-licking-f84e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/24 12:48, Greg KH wrote:
> On Wed, May 01, 2024 at 11:43:13AM +0200, Vincenzo Mezzela wrote:
>> Introduce the __free attribute for scope-based resource management.
>> Resources allocated with __free are automatically released at the end of
>> the scope. This enhancement aims to mitigate memory management issues
>> associated with forgetting to release resources by utilizing __free
>> instead of of_node_put().
>>
>> The declaration of the device_node used within the do-while loops is
>> moved directly within the loop so that the resource is automatically
>> freed at the end of each iteration.
>>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
>> ---
>>   drivers/base/arch_topology.c | 51 +++++++++++++++---------------------
>>   1 file changed, 21 insertions(+), 30 deletions(-)
> How was all of this tested?
>
> thanks,
>
> greg k-h

Hi,

I just cross-compiled it for RISC-V to enable the config 
GENERIC_ARCH_TOPOLOGY
and include arch_topology.c as well.

Do you have any suggestion to trigger the affected code and perform some 
testing?

Thanks,

Vincenzo


