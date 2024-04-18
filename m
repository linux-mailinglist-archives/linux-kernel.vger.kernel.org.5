Return-Path: <linux-kernel+bounces-149965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7F88A9881
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471CB283D33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7E815E7E4;
	Thu, 18 Apr 2024 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekqcJ5F3"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941315DBD6;
	Thu, 18 Apr 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439651; cv=none; b=YwpAFuB63x5oncbE1OnXNMvHGhNAxIFISUxqe96gCNof8oAi+cxisRG9uZUd3k8mnxfDm2yduy3b1wqdOcmcs+BwL5aNqV0+XzQzs2Pz/uyUNNLPqAuzDOBa+LWhUVVi/NRyYyeMLsTba+tYYZt8KbCYvIXTiQvF8S2hWtTlMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439651; c=relaxed/simple;
	bh=zYiLdrEVejpU8szBAhDTQgAKOfNea1cTA7YCvvFRdlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQnlZzVFefWPml8BZTu/nyLbUPLLU+sELu//sJl1XANjHsbjSp3sFVCoZUQULyf3MEfMXyKmmyGCvYQm1VtuKOpd3YexZ9sSwzRsFKO7l6/Vw0len7lKd6yiXBggDcKnQiVwSEvZPpd8zTcCue/rVpp+Dl+BRvpMhxToh3otv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekqcJ5F3; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6eb7d1a5d39so414685a34.2;
        Thu, 18 Apr 2024 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713439649; x=1714044449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=554fH9Cd7MwhrlcujjseGkWqSlH0FyRp9PRDR7JpJZ4=;
        b=ekqcJ5F3Ubg3gx+Y8Na7uDX6TSGlQ1SHM+DLncB6J+TbuD8ZDvu461Ak/mp438e58A
         ObaOyb+d8o1HgeLycfgeZbsiLniVb0Dht9/uxNp49WwcTCpjASZUVHWdCIN51cGsPe8t
         m57aCX2yPSFTv7TK7kD9heT/YPq9wftf4AGRl8K7UY3v4WdmL0axG8R877Mi/m4dTDfh
         r1Lq9rFx60yvxbnnM67waj7ZBjyrj5aC4NJCYLy8YN2qWgB1GhNkhoHm2wDdj89wa/H0
         9zwAxbI8Sj3m1+tLLaMgA/8VvJXrli+6sy0GCTCKPmAVYMcHMAvJPdKG1A7Z+tB+I2dH
         b7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713439649; x=1714044449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=554fH9Cd7MwhrlcujjseGkWqSlH0FyRp9PRDR7JpJZ4=;
        b=MoFVak/DGQCAup/TK2mOjvvWXfvWc+krXZqEDhThMTBxMcfHpXPvO2xrKxRu+KYOOn
         L5b9fvEzcaGdxH/avKG/SX2NHJ2cwExaRs9/UBZP9bPRjQ7iDC8liZt1KGdfrpN8jljS
         4yJsbBkMmHg7f1iz/zGp/p6KJTYWMFcCmoic60Raq5AMOp1t4TlA4copjfJScYPVWLa6
         uGE8X7hFcqZURwhWRbgBVcSE+sNKVVpN4CbRDP0mjTsykaLjuojdYDtZdQIUSBEFlVhM
         +DhXBLZQFIuZxy5C0gXI/vTjoR/bkIN1HzfkHVnwYQRbO+xQszyqBktUCjFUa5vpK0sV
         66Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUqGqY3Xfh+vRLpJsZiTQLKu7xLSJEg9RJAIwAup/LpeWUYwFG4dHaD4NmXp63JbC25vh2Tx36uHSWmDLmbRiKbN/QmSPOItylWtuHiVotOAgtpu7CyMO5/iBDm4YSIhntsu4nVOqetGRlgowrFKJD8zw==
X-Gm-Message-State: AOJu0Yzh31mPQZUdCn22MxhV3Wqey1mQyGgpJiHNAUmVmJYMPptZGoTU
	VNt6nLVyAGh2SIyc+EXsglmCav8Bp9p1PkC3SckdoxQzhLVwDDco
X-Google-Smtp-Source: AGHT+IEH413XYHfbdvqk0bZhern4tn8FikGz5ZML2LlZc9rEH/V5ftZAw36OLSRN1EAw1xhuE5mp8w==
X-Received: by 2002:a05:6830:928:b0:6eb:7a4b:a56e with SMTP id v40-20020a056830092800b006eb7a4ba56emr3253986ott.23.1713439649108;
        Thu, 18 Apr 2024 04:27:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:70:f702:9c77:c230:a0ba:a1a1? ([2600:1700:70:f702:9c77:c230:a0ba:a1a1])
        by smtp.gmail.com with ESMTPSA id v3-20020a05683011c300b006ebab994655sm303698otq.43.2024.04.18.04.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 04:27:28 -0700 (PDT)
Message-ID: <1071ea83-7919-469a-ac5b-3209fe9e018c@gmail.com>
Date: Thu, 18 Apr 2024 06:27:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86/amd: Don't allow HSMP to be loaded on
 non-server hardware
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 Carlos Bilbao <carlos.bilbao@amd.com>,
 "open list:AMD HSMP DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240416182057.8230-1-superm1@gmail.com>
 <ca6e0dc7-f5ea-4c0a-b9fe-0667fadc78a6@redhat.com>
From: Mario Limonciello <superm1@gmail.com>
In-Reply-To: <ca6e0dc7-f5ea-4c0a-b9fe-0667fadc78a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/18/24 04:04, Hans de Goede wrote:
> Hi,
> 
> On 4/16/24 8:20 PM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> If the HSMP driver is compiled into the kernel or a module manually loaded
>> on client hardware it can cause problems with the functionality of the PMC
>> module since it probes a mailbox with a different definition on servers.
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2414
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3285
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * use pm preferred profile instead
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Mario, should this go in as a fix for the 6.9 cylce, or is
> this for-next material ?  (I'm not sure what to do myself)
The main risk with this patch is if there are servers that previously 
loaded amd-hsmp no longer working because of a BIOS bug to exporting the 
incorrect profile.  I think this is quite unlikely but not non-zero.

To at least give some time for anything like that to be raised I feel 
this should go to for-next.

Ideally I do want to see it go to stable kernels after we're all 
sufficiently happy though.  Random bug reports to me like the ones I 
added to the commit message get raised mostly by people who compile 
their own (stable) kernels and enable all the AMD stuff because they 
have AMD hardware.

So how about we target for-next, but also add a stable tag for when it 
gets merged in the 6.10 cycle?

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
>> ---
>>   drivers/platform/x86/amd/hsmp.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
>> index 1927be901108..102a49c3e945 100644
>> --- a/drivers/platform/x86/amd/hsmp.c
>> +++ b/drivers/platform/x86/amd/hsmp.c
>> @@ -907,6 +907,17 @@ static int hsmp_plat_dev_register(void)
>>   	return ret;
>>   }
>>   
>> +static bool hsmp_supported_profile(void)
>> +{
>> +	switch (acpi_gbl_FADT.preferred_profile) {
>> +	case PM_ENTERPRISE_SERVER:
>> +	case PM_SOHO_SERVER:
>> +	case PM_PERFORMANCE_SERVER:
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>>   static int __init hsmp_plt_init(void)
>>   {
>>   	int ret = -ENODEV;
>> @@ -917,6 +928,11 @@ static int __init hsmp_plt_init(void)
>>   		return ret;
>>   	}
>>   
>> +	if (!hsmp_supported_profile()) {
>> +		pr_err("HSMP is only supported on servers");
>> +		return ret;
>> +	}
>> +
>>   	/*
>>   	 * amd_nb_num() returns number of SMN/DF interfaces present in the system
>>   	 * if we have N SMN/DF interfaces that ideally means N sockets
> 

