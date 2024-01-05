Return-Path: <linux-kernel+bounces-17837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A180782536C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F421F23DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22512D610;
	Fri,  5 Jan 2024 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fexVHH7I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604F2D043;
	Fri,  5 Jan 2024 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55559e26ccfso1881484a12.3;
        Fri, 05 Jan 2024 04:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704458570; x=1705063370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Z/sbdKKt/wzLF4s9/xA3JvplJTqpdOGJ3HlSdybqII=;
        b=fexVHH7IGBSYbV4lVwL8IbLqHOece2LUqKkLgg0Chzilr5AGKZ9eQamatfwBvXbrus
         8n8wacln57aMue3ywhKbENOZFRPdrEpqZFC16LMzuJyMXPAn+NCpFGu00UsQEGD2O835
         B99TbMDo4rMBAFrlACmZYCGYvidafOY5M+sjAwzA0zVUQe+55hnpnm+YbX4UAVtwPmle
         5O2Mom55byRs4XazJcdUoOQFk7hfZBvo8ifmFjS7lrrs5iox/gVa41nqM+issjnDqv07
         euPL5k/McKI1cwRLA+yMeaf4h14D7ehvhxTQNHBeUQckknk739z00X8Ft2mJyu0r3le1
         9cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704458570; x=1705063370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z/sbdKKt/wzLF4s9/xA3JvplJTqpdOGJ3HlSdybqII=;
        b=iRJ505e5/m1MH3pTFpXfzTdUlUbubuw/o8Ka9sRDKbEabSQhg3C6jngTT+oTDHO0dT
         qzo31ssztmYApBoztDfkuVDOtlVcvAu76F3FwGt9weEJgA5QvGW8yGAWG8RdjoMCumZx
         vmfZAY9SLQ8sAYH8y+26I4+/jC0GZ06jLo+H7ojC4HDaStwO6U7aIRUT2xNl/SAkjMnT
         SKpGrUN/UJ9PDIn2vtU22a0TxQEXgTXPpk0ALX0kBtWM1m/kdE0ish1x911JrdK+2FnT
         Lf5SK9bZuCn+0YMqLFchgt6Uz3w76g/15zckua235i8/yFtPvlbZ71XnFsi5JlXDMGvg
         Fn+Q==
X-Gm-Message-State: AOJu0YxH92qZ++VttV0hgkpOAbjFuIcOy1xxr8ZBGL3BMqy4GrhJmz/0
	WZ9a6GElemPownz/Oq8OSCQ=
X-Google-Smtp-Source: AGHT+IGbfX1w0N1pem4IEfrQ3cQn6z6SoqBmdwTlzBDIsENtwVd4ZQekXNKiB19iA+prjtO3rEK/Uw==
X-Received: by 2002:a50:cd15:0:b0:557:1cfd:6efa with SMTP id z21-20020a50cd15000000b005571cfd6efamr432236edi.112.1704458569397;
        Fri, 05 Jan 2024 04:42:49 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:19ad:2fc2:9145:71e5? (2a02-8389-41cf-e200-19ad-2fc2-9145-71e5.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:19ad:2fc2:9145:71e5])
        by smtp.gmail.com with ESMTPSA id fd5-20020a056402388500b0055743d6e9ebsm71122edb.41.2024.01.05.04.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 04:42:48 -0800 (PST)
Message-ID: <56a15164-dbce-4740-b59e-b566f613f878@gmail.com>
Date: Fri, 5 Jan 2024 13:42:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: tipd: fix use of device-specific init
 function
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Roger Quadros <rogerq@kernel.org>,
 Javier Carrasco <javier.carrasco@wolfvision.net>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240104-dev_spec_init-v1-1-1a57e7fd8cc8@gmail.com>
 <ZZf2lhtRdmIHmlBq@kuha.fi.intel.com>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <ZZf2lhtRdmIHmlBq@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05.01.24 13:36, Heikki Krogerus wrote:
> On Thu, Jan 04, 2024 at 06:07:12PM +0100, Javier Carrasco wrote:
>> The current implementation supports device-pecific callbacks for the
>> init function with a function pointer. The patch that introduced this
>> feature did not update one call to the tps25750 init function to turn it
>> into a call with the new pointer in the resume function.
>>
>> Fixes: d49f90822015 ("usb: typec: tipd: add init and reset functions to tipd_data")
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> This was suggested by Roger, no?
> 

Yes, it was. Thanks for the reminder.

Could the following trailer be added before applying?

Suggested-by: Roger Quadros <rogerq@kernel.org>

Otherwise I will resend the patch with that addition.

> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
>> ---
>>  drivers/usb/typec/tipd/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index a956eb976906..8a7cdfee27a1 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -1495,7 +1495,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
>>  		return ret;
>>  
>>  	if (ret == TPS_MODE_PTCH) {
>> -		ret = tps25750_init(tps);
>> +		ret = tps->data->init(tps);
>>  		if (ret)
>>  			return ret;
>>  	}
> 
> thans,
> 

