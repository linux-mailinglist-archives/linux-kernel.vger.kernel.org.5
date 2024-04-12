Return-Path: <linux-kernel+bounces-141876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EFA8A247F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEE5B217D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E7917BDD;
	Fri, 12 Apr 2024 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvDtC67u"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE6125CC;
	Fri, 12 Apr 2024 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712893683; cv=none; b=RtSPJKsYs5LV9sOgJTNNJymFsCDPNuZFLc9lIMxsOqKkb9cxYtEm8UfSIRSeyx+Sek0lR4Y3D0Os6r2N3+kWz9Gp+fSGUE1knZ9cpnD8cLvTynPizSNO3TNjVgX+Ev4i7n10/u/98eJxaVFa68/gjgLQ23tpPxEJ/qDyvpKfFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712893683; c=relaxed/simple;
	bh=/rHLC/R4rfN502F/b9F/DI/sJIeNeNKUawb8/J1/9lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKYL2fmaQ5ERyVf2fevZav3UPp1GD6d3jDlmFNl0kf/CpFifj2cnvZXo0LGMzxLDu7CYx+XvJKFCgiaHP9ooDCjnW/uCTqLl5muZ9EooRL37Pq23pVZ3RxSpwMGrxYClwoo7tCKiAzfkYiHnmjMvlvWZzz3gLQuYEWk/CM0pzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvDtC67u; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6eb358d8a58so296893a34.1;
        Thu, 11 Apr 2024 20:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712893681; x=1713498481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTEo3Ir/LcEQwAwbgkuCoRg+Pp7ew9j08XlIRINI/x4=;
        b=YvDtC67uDUM6Qw0xjSX7u8kgNMB5nR3SKx70exSUG8fMN3nzpjFLd6V3ntYJrXmoJY
         f1uiN7QkXkNM6iqNBU2XAxu0AnfiQ/yjGHwBt2w6D+KDdItj6UWMZQP/H+W+w5Sfx03K
         TLpHqLhR58PLGHzYiijlmdygrXe7Yjod8LenadwjTjA5vFWrU1mm290l8x0T9FznvpAT
         vT4kGWjf7o829BBU7lYY6Kg8m34Y8eNfk4wJZ5PfP7gKG3BHojZVdscwt05yaMctB+K1
         GLhCKpMjtH0AEtVcJX6/6oPzasZUuSYACRdIDvCEbpoDmcLMwjGSQDV8tpLqKwfRpONy
         VC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712893681; x=1713498481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTEo3Ir/LcEQwAwbgkuCoRg+Pp7ew9j08XlIRINI/x4=;
        b=TE51Nmc9Mxn7Is26H6wL1tzvjbKOicn3N2JLPqU9MBydCPQXEdFgRCNHhc69m6hiZG
         zGXRhEK5CDooVxNMO1meSoRmi4DWZBHqxl3+R0RtM8o1iCUTLTM4JG5FqAEiYhdAZWwN
         kLFtRn0gfsyYZuhrVOoeebMVzKsxhIZu68WUXs0tq/ifTed/Pw8wonJoi4YOod9xHYfw
         YcXKBYYjiY05BWhCUAFB8YPkyEwjrtkdWV/c+k8ykidlpaWem/9X0LVy6OVMPdco8q2L
         7hic3C3FDJuM/7TO2l5h49lwzvcRbzB3TVZ2qCGtHvNRXGPCe6f+xqg22/5O/QSou7mK
         V+eg==
X-Forwarded-Encrypted: i=1; AJvYcCVRsj/5Vk2oqeY2/oDLxDFXVEc5vxOkf9S/yry4r24cKGl4wO+2rjiSExmlnaLsQHW73ynPA9ZI1XkDWIb1CAMWBZ7MHarxUAyImsU8Ruxomo4X2k0aEEkLhy3BR5qOSWRAEp+/N8gK
X-Gm-Message-State: AOJu0Yw+OO18UgNkhfazeSEvbxQX7bLXaI819KpjrJwlwdiU7JJzTu4O
	bPJlOVuSy17zfhlbj5GfxZxfxPfSzX8MEXHAnn2Z8Qc9kzEAJTaS
X-Google-Smtp-Source: AGHT+IG8VNh400XZR5PgXexjn/0m3GrTYv5Fa64sd9F/M/bu3INDRryNUHK5SkXwPRVvFVmZL5yeKw==
X-Received: by 2002:a05:6808:bcf:b0:3c6:f3a0:39ad with SMTP id o15-20020a0568080bcf00b003c6f3a039admr982527oik.13.1712893681448;
        Thu, 11 Apr 2024 20:48:01 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:5d38:4ef:72ea:d357? ([2402:e280:214c:86:5d38:4ef:72ea:d357])
        by smtp.gmail.com with ESMTPSA id f9-20020a056a001ac900b006ece7286c68sm1922753pfv.41.2024.04.11.20.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 20:48:00 -0700 (PDT)
Message-ID: <6fbdbdd3-965f-44e7-bd25-0b0c3e9f53f9@gmail.com>
Date: Fri, 12 Apr 2024 09:17:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: mux: replace of_node_put() with __free
 [linux-next]
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, dmitry.baryshkov@linaro.org,
 neil.armstrong@linaro.org, christophe.jaillet@wanadoo.fr,
 u.kleine-koenig@pengutronix.de, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>
References: <20240410165222.5192-1-prosunofficial@gmail.com>
 <2024041103-doornail-professor-7c1e@gregkh>
Content-Language: en-US
From: "sundar.R" <prosunofficial@gmail.com>
In-Reply-To: <2024041103-doornail-professor-7c1e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi greg k-h,

Thanks for comments provided.

On 11/04/24 17:47, Greg KH wrote:
> On Wed, Apr 10, 2024 at 10:22:22PM +0530, R SUNDAR wrote:
>> use the new cleanup magic to replace of_node_put() with
>> __free(device_node) marking to auto release and to simplify the error
>> paths.
>>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
> 
> All CAPS for your name?  Is that how it is written on documents (for
> some countries this is normal, but usually not, so I have to ask.)

In documents it was like that.I also thought to change to small letters 
in git user name.
will change to small letter.

>> -
>> -	ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
>> +	struct device_node *ep __free(device_node) =
> 
> And if so, why this random USB driver being the first one?  Have you
> tested this?

I haven't tested it.I picked this usb driver to get cleanup module 
changes with __free.
I believe since of_node_put() is scope based here,we can use cleanup to 
remove the goto label uses in case of error.
> >
>> +		of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
>>   
>>   	if (ep) {
> 
>  the "common" path should not be indented, but only the exception (i.e. bail
> if ep is not allocated properly.)
I Tried in same line initialization, it exceeds column limit.
so indented in next line.


> 
> thanks,
> 
> greg k-h

Regards,
Sundar


