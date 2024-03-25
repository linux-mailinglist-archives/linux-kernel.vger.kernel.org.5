Return-Path: <linux-kernel+bounces-117274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E8D88B376
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFE3C400FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE716E886;
	Mon, 25 Mar 2024 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixkd5ROS"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640958135;
	Mon, 25 Mar 2024 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377607; cv=none; b=qm/cqhS60YkSqm84p827G7Eyg7oq/FwPY/CVccGTTFiZ5RJwZul9mMIVxcIggy9rRoZQX94HxupuQPLajUlryYYW0dLgSANvxKPcvr56X9tiGSqpoWvRP64kG3GPaMY2lsdwEBlCsMCHHuvoW7Jiepao5L2IARm0XS2cqH4A2Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377607; c=relaxed/simple;
	bh=5KajiC+osgJB4I3bVGEuiXbOl9RztfBbyQcYRS3ZOGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuxxDeDeUpWmfQgMl68fHL/J6CbtfxiXPf60P1P8NtoDhuehvWNmTiPpcDCSRJxJM1HWTGrfD4QctaclTOuBDJV8zvedmdHbZbvyDxLfxMb0ZA3Ei7yIY2YClvx6Buu4lQMDIIMpkI1Av6J00UCDIPDa9Xx1yFAuabT1o6F9z34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixkd5ROS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e740fff1d8so3026199b3a.1;
        Mon, 25 Mar 2024 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711377605; x=1711982405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nHUz7ERnER6qEaRZS7LT8dYbIk6qkEmxqClzj66d21Y=;
        b=ixkd5ROS2suj6Fa46TRbwLsIejv4+v+gjirA4bL04iH6vlj7M1/Uz/Tb54wjKi/WvK
         n1Epyh+N6PFwmtR94JMIFgbEQiPv97a1jgeAE5Eq3WDrE3SJJoYM0iAAlzY+V1OCE3MS
         9jnPr6mlI8p0ApmtaSn4rOp5aYqrJLFQmUaN2D6u9gzOJEIyQitOMRDQYxt+Xxi876wV
         yKBJIxMmSYAGht/zzxK60Nc6gL/Q1O05bfBjCWhaj05plDuhqPGiEzM4Svtlj3/shAxm
         VLrudLQhhCQ/AbdxJnoXU9ytU7ZZwGO3f1sRUPyKUCQ3hOaZsXvpir74qG+OZJIrZldl
         uyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711377605; x=1711982405;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHUz7ERnER6qEaRZS7LT8dYbIk6qkEmxqClzj66d21Y=;
        b=SlnNAQfsUUod8VTA7ewXr9wB3RTp2AzKFd3UhlUccnGTjw6RUlbprHm68/5FIrXnB6
         ioTyn2DrMkY2VziQHnzEQGcXSisQ2IDcxcLGEr2EIDWqEtHebMAm0rx/iX6KVnSAzPRH
         CgltyNe3azZ8s0NYs+cXrFN/WGZyRfYgfH0VurheDFdbZxACcsQX2tEuNEQ2nU2fJDLF
         fxsYhPT3wiw22wPXUJ8qRNmcnn4G1f1eJ/zsiTAHK9X/KJIvVavSe6Vkh0oWRUz5UAx6
         Q6DQ3jfYYpwa6CLMrc1fqUNfyp9cCid1ZEZjVYLnxVmm5WNixM5fXZPOqOLTkFj7Ks29
         oBgA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Oa9HseK0F5sgd51XnLKbW62CgcCXa88/VXa8ITvS4RpmShR70/KQfFzphhSeJlKNTA6cHO7H1fie9YioXAQQRJU1Y6geFFeMZWp1ZNpOw/NAdqrpkBhgdUzYpds34wbKYw52xIgmq8xgBrHrP13hMHoQxA+oIWwRWPOo9D2snd42SaeA
X-Gm-Message-State: AOJu0YyPJxPcDXv7NQGF9yrByJvbe1IbOfvdJ/Ev1PqaS7H6dEDi4Tw9
	+vBb1tFpMv6C2DOluePfs6//uBDhtV5ibo+I11K4y6F7Jl4Cd3RP
X-Google-Smtp-Source: AGHT+IFWo2GkUXJyzZ7L1+gDoUWEBuoJTbu+tdbudCIopEmOO9e2o+n2Frek215C1rwfHinDZ9dJOw==
X-Received: by 2002:a05:6a20:1994:b0:1a1:8899:a2b0 with SMTP id bz20-20020a056a20199400b001a18899a2b0mr5577979pzb.52.1711377604778;
        Mon, 25 Mar 2024 07:40:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q9-20020aa79829000000b006ea75a0e223sm4117349pfl.110.2024.03.25.07.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 07:40:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4ac8a198-b0c9-418e-bcf8-1ee1a9660dad@roeck-us.net>
Date: Mon, 25 Mar 2024 07:40:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] hwmon: (acpi_power_meter) Ensure IPMI space
 handler is ready on Dell systems
Content-Language: en-US
To: Andy Shevchenko <andy@black.fi.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
 robert.moore@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20240320084317.366853-1-kai.heng.feng@canonical.com>
 <20240320084317.366853-2-kai.heng.feng@canonical.com>
 <ZgFwLXzNG2aTL_BQ@black.fi.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZgFwLXzNG2aTL_BQ@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 05:38, Andy Shevchenko wrote:
> On Wed, Mar 20, 2024 at 04:43:17PM +0800, Kai-Heng Feng wrote:
>> The following error can be observed at boot:
>> [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62c5) [IPMI] (20230628/evregion-130)
>> [    3.717928] ACPI Error: Region IPMI (ID=7) has no handler (20230628/exfldio-261)
>>
>> [    3.717936] No Local Variables are initialized for Method [_GHL]
>>
>> [    3.717938] No Arguments are initialized for method [_GHL]
>>
>> [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
>> [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
>> [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
>>
>> On Dell systems several methods of acpi_power_meter access variables in
>> IPMI region [0], so wait until IPMI space handler is installed by
>> acpi_ipmi and also wait until SMI is selected to make the space handler
>> fully functional.
>>
>> Since the dependency is inside BIOS's ASL code and it's not
>> discoverable, so use this fixup is a hack to workaround BIOS issue.
> 
> ...
> 
>> +	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.")) {
>> +		ipi_device = acpi_dev_get_first_match_dev("IPI0001", NULL, -1);
>> +
>> +		if (ipi_device) {
>> +			if (acpi_wait_for_acpi_ipmi())
>> +				dev_warn(&device->dev, "Waiting for ACPI IPMI timeout");
>> +			acpi_dev_put(ipi_device);
>> +		}
> 
> Can be written as
> 
> 	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.")) {
> 		ipi_device = acpi_dev_get_first_match_dev("IPI0001", NULL, -1);
> 		if (ipi_device && acpi_wait_for_acpi_ipmi())
> 			dev_warn(&device->dev, "Waiting for ACPI IPMI timeout");
> 		acpi_dev_put(ipi_device);
> 
>> +	}
> 

Ah yes, acpi_dev_put() checks if the parameter is NULL. Good point.
I'll make that change, no need to resend.

Thanks,
Guenter


