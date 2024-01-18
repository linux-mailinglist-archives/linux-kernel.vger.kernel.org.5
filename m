Return-Path: <linux-kernel+bounces-30554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD19832064
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF941F27B59
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572942E655;
	Thu, 18 Jan 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPVojCRK"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AE029CED;
	Thu, 18 Jan 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609152; cv=none; b=dH1owG3JFep/MWHuyetPTiMyDsk0Z9KLi9DrOBUpUxUrka1KSfVXI/x1SVw+5AgzpzVtMBaAG5N4g+ms5DaFp03IWY5ySrCSGzRfrNSsc/Ly2vKeHb39R+4gBqT1O/90gAoZPYGRabxE+EeuazenxszL9mD6DAqI2HBfoShy3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609152; c=relaxed/simple;
	bh=qOyfcY8+N2GbqPmNyR8KCsqKlMiz/33m0/NfqqMf8fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSKZYhodqmkapHE5LfMbJw4MbEDqwF/RPOQZwPY7cyJAJmm1Ji+vYE5bVX+2YRpucPa8RuITRHvAAoGqPwClFOvnfxpS5sxP/OLo2rf36urAaet+MiTra9xcwfjMsYEbv0gdcEkY6ZzIaL+FE4KuleZMe7PUIcZmWOQPWw0PRNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPVojCRK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cf6d5117f9so49320a12.2;
        Thu, 18 Jan 2024 12:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705609150; x=1706213950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSp4LijXK8czV2YlnwfwApZRO+PHOzGdXK5fdCdR75M=;
        b=GPVojCRKfV+AyAg6rdPud8dgVJ+JhkCHmnTJNHjSr8lutfvgBbBSkOT2MPHhG4l06a
         cIkwm+OxOnaHSNvHDRYWw4aWXNNn4GMvCLFC4OB70JaqQw7zovccyAiqOhf3aib/HQKq
         LyRMcXnOFX0bY2QCDB2pH4VYrYlfCIR23SGwCUxA7U+zKR7COqiIO5qLybWMJ8ZZkMxI
         9RuQK2TklGOqEP5wreZKbcL8mUchkdR+JaW8QyI94tSChcMu0QUVPgyOZfkronX/PABP
         91ZcQulNYClQUqLTXIXatSSWcIgI/LkUvyZdYE7xd/8+xc+Nk3SdV6CfkqifW4Sel1ZW
         +32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705609150; x=1706213950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSp4LijXK8czV2YlnwfwApZRO+PHOzGdXK5fdCdR75M=;
        b=oLxK3Zl0248yhwn4GNPw6aL5q6cc14EknYmT66xBYTOIDZLKhteCUtJph+dy3anHtP
         RCtc+ClbC0GXqden+yL9TdO8zoGE2kuzzE9TT7NMIswX+nWEzcIdNcu0IfVeZpqqiqBG
         VN3KwjMzCKoR7naWM5cDADllUlBcpRvBJ8JBo8c0+G7xKO4ihCiiN8BSbq2FzLRcftNp
         NTVhTKFiEyGRm933GK+zBmQvsUJv5X107J/VetGSxbdjr9qlxHPtrsxrWBuLBWFeAc2m
         EJkODzSWEd47F5XJVqXf/qY5CKpC3meh6UXOs2wM9WqA9ifBzXNKGdnfSWffoCxJKABH
         5+hA==
X-Gm-Message-State: AOJu0YzZaIheOyaizrOipKRUsbPR7zEarn3qncITKQ4cX9FJKhzWSwyo
	qxn+lMTgufodqJVbc3QAy8hCAzt4+MyRBEvE/4uB6M/WwLENEE7j
X-Google-Smtp-Source: AGHT+IEUSO3kM4FvQZ01TNYzRtRpIG/nW46bdm3gKsc1P9hpMcQbQplOiA9zvr2duZoex7h0eWTw3g==
X-Received: by 2002:a17:902:cecb:b0:1d4:53cf:fb99 with SMTP id d11-20020a170902cecb00b001d453cffb99mr1789461plg.24.1705609150521;
        Thu, 18 Jan 2024 12:19:10 -0800 (PST)
Received: from [192.168.0.228] (c-24-20-51-242.hsd1.or.comcast.net. [24.20.51.242])
        by smtp.gmail.com with ESMTPSA id mi7-20020a170902fcc700b001d5f387aa6esm1768633plb.240.2024.01.18.12.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 12:19:10 -0800 (PST)
Message-ID: <40483b3e-d820-4a9c-823d-76d6f24edfd6@gmail.com>
Date: Thu, 18 Jan 2024 12:19:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ibmvscsi_tgt: replace deprecated strncpy with
 strscpy
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
Cc: Michael Cyr <mikecyr@linux.ibm.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231030-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v1-1-859b5ce257fd@google.com>
 <202311301315.BAB096926@keescook>
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
In-Reply-To: <202311301315.BAB096926@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/23 13:25, Kees Cook wrote:
> On Mon, Oct 30, 2023 at 09:43:20PM +0000, Justin Stitt wrote:
>> strncpy() is deprecated for use on NUL-terminated destination strings
>> [1] and as such we should prefer more robust and less ambiguous string
>> interfaces.
>>
>> We don't need the NUL-padding behavior that strncpy() provides as vscsi
>> is NUL-allocated in ibmvscsis_probe() which proceeds to call
>> ibmvscsis_adapter_info():
>> |       vscsi = kzalloc(sizeof(*vscsi), GFP_KERNEL);
>>
>> ibmvscsis_probe() -> ibmvscsis_handle_crq() -> ibmvscsis_parse_command()
>> -> ibmvscsis_mad() -> ibmvscsis_process_mad() -> ibmvscsis_adapter_info()
>>
>> Following the same idea, `partition_name` is defiend as:
>> |       static char partition_name[PARTITION_NAMELEN] = "UNKNOWN";
>>
>> ... which is NUL-padded already, meaning strscpy() is the best option.
>>
>> Considering the above, a suitable replacement is `strscpy` [2] due to
>> the fact that it guarantees NUL-termination on the destination buffer
>> without unnecessarily NUL-padding.
> 
> My only worry here is that I don't see if %NUL termination is _required_
> for these variables. (i.e. do we run the risk of truncating these by 1
> byte if they're right at the limit?) Are they __nonstring?
> 
> I *think* they're %NUL terminated since they follow the same sizing as
> the global "partition_name", but I'm not sure.
> 
> Can any of the SCSI authors comment on this?

Sorry, for a delayed response. I've just taken over the maintainer role as it
had been left unaccounted for sometime.

These are meant to be handled as C strings and nul termination is expected.

-Tyrel

> 
>>
>> However, for cap->name let's use strscpy_pad as cap is allocated via
>> dma_alloc_coherent():
>> |       cap = dma_alloc_coherent(&vscsi->dma_dev->dev, olen, &token,
>> |                                GFP_ATOMIC);
> 
> This is also true for the "info" allocation (it comes out of DMA).
> 
>>
>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>> ---
>> Note: build-tested only.
>>
>> Found with: $ rg "strncpy\("
>> ---
>>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> index 385f812b8793..cd223ef696e5 100644
>> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> @@ -1551,17 +1551,17 @@ static long ibmvscsis_adapter_info(struct scsi_info *vscsi,
>>  	if (vscsi->client_data.partition_number == 0)
>>  		vscsi->client_data.partition_number =
>>  			be32_to_cpu(info->partition_number);
>> -	strncpy(vscsi->client_data.srp_version, info->srp_version,
>> +	strscpy(vscsi->client_data.srp_version, info->srp_version,
>>  		sizeof(vscsi->client_data.srp_version));
>> -	strncpy(vscsi->client_data.partition_name, info->partition_name,
>> +	strscpy(vscsi->client_data.partition_name, info->partition_name,
>>  		sizeof(vscsi->client_data.partition_name));
>>  	vscsi->client_data.mad_version = be32_to_cpu(info->mad_version);
>>  	vscsi->client_data.os_type = be32_to_cpu(info->os_type);
>>  
>>  	/* Copy our info */
>> -	strncpy(info->srp_version, SRP_VERSION,
>> +	strscpy(info->srp_version, SRP_VERSION,
>>  		sizeof(info->srp_version));
>> -	strncpy(info->partition_name, vscsi->dds.partition_name,
>> +	strscpy(info->partition_name, vscsi->dds.partition_name,
>>  		sizeof(info->partition_name));
> 
> Since "info" is from DMA, let's use the _pad variant here just to be
> safe.
> 
>>  	info->partition_number = cpu_to_be32(vscsi->dds.partition_num);
>>  	info->mad_version = cpu_to_be32(MAD_VERSION_1);
>> @@ -1645,8 +1645,8 @@ static int ibmvscsis_cap_mad(struct scsi_info *vscsi, struct iu_entry *iue)
>>  			 be64_to_cpu(mad->buffer),
>>  			 vscsi->dds.window[LOCAL].liobn, token);
>>  	if (rc == H_SUCCESS) {
>> -		strncpy(cap->name, dev_name(&vscsi->dma_dev->dev),
>> -			SRP_MAX_LOC_LEN);
>> +		strscpy_pad(cap->name, dev_name(&vscsi->dma_dev->dev),
>> +			sizeof(cap->name));
> 
> And this is a safe conversion to sizeof():
> 
> struct capabilities {
> 	...
>         char name[SRP_MAX_LOC_LEN];
> 
> 
> If we can convince ourselves that non of these are __nonstring types,
> then I think with the "info" change above, this should be good.
> 
> -Kees
> 


