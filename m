Return-Path: <linux-kernel+bounces-150174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1B48A9B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7351C22DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07FD15FD11;
	Thu, 18 Apr 2024 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ46UO5o"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1B13247D;
	Thu, 18 Apr 2024 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447128; cv=none; b=cYrCmkI0j7gXqN6m+boEKHYftGrO+H7I7zn0HaZB5gb5DS8OkRfoT7LcEV3QIm3rc3GoJGWRDPfy6MClL0ZBt/2Qb3XQM8zhI/GqdMps4BHH5hrfmfSoxFf7dn4EjD7bjxeKSvmEaadk0jEgbnsJm6VVPbKEa2DOzllQfj7/EOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447128; c=relaxed/simple;
	bh=LSGIQxyjWaoQbkFih8PYwxF1WOXPzlUfmE71TCh83Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sC4VJos5l3mQ0tirjuk2RdzZMc5djdlUE1DVpfVSu3f6vGlwLnbMvJEMq3IH+pHdYJuR0V6yc5qxkk1h6FSt9Nx6ySBPcLf5iauJvIpkvlHVbHnhAclXOtYb/797FRRpACLJtl9WZmLGcwz1kdnEC0s8VQ4fXTez51CrYh/PFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQ46UO5o; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-346f4266e59so573231f8f.3;
        Thu, 18 Apr 2024 06:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447125; x=1714051925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBrKPWdTMW9CAPsRQ3Dci4rO75QpqJILBEyvPcJID6w=;
        b=DQ46UO5o1JDCmPysuvOlBe8Bas5TJBqp+q4Hy7x9qS/TylcLt5ByNRiOizgE7rpDVY
         h3rylMdcZ1Z2dV15qsWUtAUXbilKbC668saJsHMdHDA1sH7fjzyj2681npdGVl415652
         M4mN755JJC/qeEGy0xy7jxXLrvlBPYDphsb5ClrdeP0Y1rF5y4DRYoMakX2wPtpoqG1Q
         JAxZEkjDiNZrVl6RaXdPMNCjuWbwrvLMQUq4iPuEcoj6/ev5hoLf5zIcW8gPo7vd5HXR
         0xnDiQwYyVYjwaJoMb5wSr9DcQTlFPPzBQRe7u0QaucQUjChcg9vHPrXlbAUD34zNuIl
         1Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447125; x=1714051925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBrKPWdTMW9CAPsRQ3Dci4rO75QpqJILBEyvPcJID6w=;
        b=s09H0GbFm/cDS1VBbmfkSQMBW3tqC++EuE9/8agNpp0SYQmcjqnZXWZg9JiQWIKGyO
         Aur9Y7a9/lnEWXGkLcBsPuQuo5RR0/bgdEm27DvbcC7BeH7mTc75Tfu51C2V9lC04QkQ
         lh5kZNxbg0oy9BBt0cQhuZjYjpA4fHicD6kv8MgD/rVYFK9iVQMuvRrlvzLrkxSC+Cbi
         q+46vkeJwQJkhf3k/qVUaKwWNccqqJnV7fPs1eB6mpywADcYbSxAXLL9mprQPqcQmZci
         auFkBnU75NfN4mI+QriK3T2GgBVr3HH455NXCg+9Ql/D2WEp5rfVyJN9vh9cc2IUWGyM
         szxg==
X-Forwarded-Encrypted: i=1; AJvYcCVMKPghl4ERowvzn13+bTL8AWYwT+GoYeu1GGkkwrVc1SRNMIHgPpTfLNpWDmEmkSkUg7FKydkhDq/76qw/D4lX4B9YiiRRVe261SuX
X-Gm-Message-State: AOJu0Yxkrfz35flnYXainLNlX32xJZpPkfKeEHWacTnCUdvM25bTboqu
	TyT+kvKmV6q9Jg9+tXHMaJpHA6TcGZcDBY7EVoNV3Xmv+WpnTl93
X-Google-Smtp-Source: AGHT+IEOZ04IAf6iJFVcxPNeRusLj2LszHSOwC9mKTIp0I+Yi20LnnDTztkjvEerJ0h25eSQ4lCjHQ==
X-Received: by 2002:adf:a44d:0:b0:33e:be35:d449 with SMTP id e13-20020adfa44d000000b0033ebe35d449mr1636693wra.44.1713447124485;
        Thu, 18 Apr 2024 06:32:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:6d3f:e873:5a16:baae:4269:c8f3? ([2a02:810d:6d3f:e873:5a16:baae:4269:c8f3])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d6da6000000b00346ab3c372bsm1882390wrs.73.2024.04.18.06.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 06:32:03 -0700 (PDT)
Message-ID: <4ae4be2f-4edd-4d1e-87e9-df5687627d00@gmail.com>
Date: Thu, 18 Apr 2024 15:31:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] HID: uclogic: Remove useless loop
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nikolai Kondrashov <spbnick@gmail.com>
References: <20240401004757.22708-1-stefanberzl@gmail.com>
 <nycvar.YFH.7.76.2404121751250.5680@cbobk.fhfr.pm>
Content-Language: en-US
From: Stefan Berzl <stefanberzl@gmail.com>
In-Reply-To: <nycvar.YFH.7.76.2404121751250.5680@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/04/2024 17:52, Jiri Kosina wrote:
> On Mon, 1 Apr 2024, Stefan Berzl wrote:
> 
>> The while in question does nothing except provide the possibility
>> to have an infinite loop in case the subreport id is actually the same
>> as the pen id.
>>
>> Signed-off-by: Stefan Berzl <stefanberzl@gmail.com>
> 
> Let me CC Nicolai, the author of the code of question (8b013098be2c9).

I agree that Nicolai's opinion would be invaluable, but even without it,
the patch is trivially correct. If we have a subreport that matches the
packet, we change the report_id accordingly. If we then loop back to the
beginning, either the report_id is different or we are caught in an
infinite loop. None of these are hardware registers where the access
itself would matter.

>> ---
>>  drivers/hid/hid-uclogic-core.c | 55 ++++++++++++++++------------------
>>  1 file changed, 25 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
>> index ad74cbc9a0aa..a56f4de216de 100644
>> --- a/drivers/hid/hid-uclogic-core.c
>> +++ b/drivers/hid/hid-uclogic-core.c
>> @@ -431,40 +431,35 @@ static int uclogic_raw_event(struct hid_device *hdev,
>>  	if (uclogic_exec_event_hook(params, data, size))
>>  		return 0;
>>  
>> -	while (true) {
>> -		/* Tweak pen reports, if necessary */
>> -		if ((report_id == params->pen.id) && (size >= 2)) {
>> -			subreport_list_end =
>> -				params->pen.subreport_list +
>> -				ARRAY_SIZE(params->pen.subreport_list);
>> -			/* Try to match a subreport */
>> -			for (subreport = params->pen.subreport_list;
>> -			     subreport < subreport_list_end; subreport++) {
>> -				if (subreport->value != 0 &&
>> -				    subreport->value == data[1]) {
>> -					break;
>> -				}
>> -			}
>> -			/* If a subreport matched */
>> -			if (subreport < subreport_list_end) {
>> -				/* Change to subreport ID, and restart */
>> -				report_id = data[0] = subreport->id;
>> -				continue;
>> -			} else {
>> -				return uclogic_raw_event_pen(drvdata, data, size);
>> +	/* Tweak pen reports, if necessary */
>> +	if ((report_id == params->pen.id) && (size >= 2)) {
>> +		subreport_list_end =
>> +			params->pen.subreport_list +
>> +			ARRAY_SIZE(params->pen.subreport_list);
>> +		/* Try to match a subreport */
>> +		for (subreport = params->pen.subreport_list;
>> +		     subreport < subreport_list_end; subreport++) {
>> +			if (subreport->value != 0 &&
>> +			    subreport->value == data[1]) {
>> +				break;
>>  			}
>>  		}
>> -
>> -		/* Tweak frame control reports, if necessary */
>> -		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
>> -			if (report_id == params->frame_list[i].id) {
>> -				return uclogic_raw_event_frame(
>> -					drvdata, &params->frame_list[i],
>> -					data, size);
>> -			}
>> +		/* If a subreport matched */
>> +		if (subreport < subreport_list_end) {
>> +			/* Change to subreport ID, and restart */
>> +			report_id = data[0] = subreport->id;
>> +		} else {
>> +			return uclogic_raw_event_pen(drvdata, data, size);
>>  		}
>> +	}
>>  
>> -		break;
>> +	/* Tweak frame control reports, if necessary */
>> +	for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
>> +		if (report_id == params->frame_list[i].id) {
>> +			return uclogic_raw_event_frame(
>> +				drvdata, &params->frame_list[i],
>> +				data, size);
>> +		}
>>  	}
>>  
>>  	return 0;
>> -- 
>> 2.43.0
>>
> 

