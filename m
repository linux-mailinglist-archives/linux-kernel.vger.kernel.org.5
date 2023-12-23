Return-Path: <linux-kernel+bounces-10378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 378B981D383
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2D01F22698
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378FDCA5F;
	Sat, 23 Dec 2023 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyLXQcmu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A8CA48
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703327150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoKXir54x/dEEkfvtrxnT2ENR9sxqwMkgds0ZkJeGss=;
	b=WyLXQcmuTzI1dFF62jzoUhJ+Jebx5dW9UB6wWkGhRwWZcWKAYhuRafT5DWiXi1WVcL/DRm
	VgYcRawodkKb4I49zmQyr+SRZEXbO6jLYVyjt5v57kjNZ5fKkW9dOst+yOiGK9crY1kb9F
	vgIaFv89NSYJhdXvn2FmSPkmzGJE+TY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-Q2UZvw7FNkO4pTUz2Audew-1; Sat, 23 Dec 2023 05:25:49 -0500
X-MC-Unique: Q2UZvw7FNkO4pTUz2Audew-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a23365478e5so124335866b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703327147; x=1703931947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoKXir54x/dEEkfvtrxnT2ENR9sxqwMkgds0ZkJeGss=;
        b=ZidfPu/Aa+p1EjWxmC1iKbMaPO0HWOXijF22aJl8m5tZl07e4lVE0ad17EAcmV77p2
         Hd3FFcuabVlCE46DC765p7P5cmAenBh0KmC9PhOyiGkSEPXeUyV+RT/AWvhwO4DwXuO/
         FpNlRvA1iDpS4fp+QNmgzO1PQcVZi3B8FeDrMAZMQPBuc+ezyJz1Lk5FULNJAVp2wAOE
         5yUsFoBu7MoqwPEjW41SdWZFb+omhgZ4cpNe7jJmqdWXOIL60Ue9RRG7yJk7MqtfHrIg
         +vi7sxuMRQ5x/sKgesCC2mq0UN1YSLgkPHed9LxZYSaQlzuHAnsi6SjrFRQysNhvbCPd
         i0kQ==
X-Gm-Message-State: AOJu0YyN56jcIuRl1Bv2/a6AxGkQ23f7CcroRZZp4BASJPD5ZnzOXMjV
	7XAsUiTihHguiqcLRcq97FkErsKN4KjhBpHUc8D8HgCMkYm9mWCK7jpuhUy/yUFT5IfrLUIj1MP
	IcasGvCqy5iaWZEc6LB2srzG3jo4an1h8pgAnT02g
X-Received: by 2002:a17:906:48:b0:a26:9734:d074 with SMTP id 8-20020a170906004800b00a269734d074mr1256583ejg.21.1703327147465;
        Sat, 23 Dec 2023 02:25:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfYBntxU/LEH18ZD4tGgJi1jr2AFoUSUHqm44HH3HbItCx3zDGERqgnKjQD0P1rx5/Ye1TzA==
X-Received: by 2002:a17:906:48:b0:a26:9734:d074 with SMTP id 8-20020a170906004800b00a269734d074mr1256569ejg.21.1703327146994;
        Sat, 23 Dec 2023 02:25:46 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ex17-20020a170907955100b00a269fa0d305sm2923466ejc.8.2023.12.23.02.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 02:25:46 -0800 (PST)
Message-ID: <e7a46035-9c5e-495d-8f20-73dca4fec068@redhat.com>
Date: Sat, 23 Dec 2023 11:25:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: media: atomisp: pci: Fix spelling mistake in
 ia_css_acc_types.h
To: Randy Dunlap <rdunlap@infradead.org>,
 Dipendra Khadka <kdipendra88@gmail.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org, hpa@redhat.com
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231223051108.74711-1-kdipendra88@gmail.com>
 <d1c18155-9c8e-4164-a2bf-5eab3d42995d@infradead.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d1c18155-9c8e-4164-a2bf-5eab3d42995d@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/23/23 06:18, Randy Dunlap wrote:
> Hi Dipendra,
> 
> On 12/22/23 21:11, Dipendra Khadka wrote:
>> codespell reported spelling mistakes in
>> ia_css_acc_types.h as below:
>>
>> '''
>> ia_css_acc_types.h:87: cummulative ==> cumulative
>> ia_css_acc_types.h:411: descibes ==> describes
>> '''
>>
>> This patch fixes these spelling mistakes.
>>
>> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> 
> This patch is an improvement so it could be merged as is IMO.
> But...
> 
>> ---
>> v2:
>>  - Previously only corrected spelling  mistake reported by checkpatch.pl.
>>  - All spelling mistakes reported by codespell are fixed.
>> v1: https://lore.kernel.org/lkml/20231222200350.2024-1-kdipendra88@gmail.com/
>>
>>  drivers/staging/media/atomisp/pci/ia_css_acc_types.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
>> index d6e52b4971d6..1dc2085ecd61 100644
>> --- a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
>> +++ b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
>> @@ -84,7 +84,7 @@ struct ia_css_blob_info {
>>  		memory_offsets;  /** offset wrt hdr in bytes */
>>  	u32 prog_name_offset;  /** offset wrt hdr in bytes */
>>  	u32 size;			/** Size of blob */
>> -	u32 padding_size;	/** total cummulative of bytes added due to section alignment */
>> +	u32 padding_size;	/** total cumulative of bytes added due to section alignment */
> 
> I apologize for not looking at your v1 patch carefully.
> The comment above would be much better as
> 
> 				/** total accumulation of bytes added due to section alignment */

I agree that that is better. Dipendra can you please send a v3
using the new text suggested by Randy ?

Regards,

Hans



>>  	u32 icache_source;	/** Position of icache in blob */
>>  	u32 icache_size;	/** Size of icache section */
>>  	u32 icache_padding;/** bytes added due to icache section alignment */
>> @@ -408,7 +408,7 @@ struct ia_css_acc_sp {
>>  };
>>  
>>  /* Acceleration firmware descriptor.
>> -  * This descriptor descibes either SP code (stand-alone), or
>> +  * This descriptor describes either SP code (stand-alone), or
>>    * ISP code (a separate pipeline stage).
>>    */
>>  struct ia_css_acc_fw_hdr {
> 


