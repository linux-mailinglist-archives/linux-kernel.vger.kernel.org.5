Return-Path: <linux-kernel+bounces-53235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BFB84A26E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07229B24C78
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4984748CC8;
	Mon,  5 Feb 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLSnhzqX"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1327487A2;
	Mon,  5 Feb 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157995; cv=none; b=diK57f+i7lUUqKZ+GGmN0WEaaQJH1XVVQF2O0ELFYzZH3qrYB23GjgwgivqN8pn3BkfaO3AKpdXbYbctu65Ma6oM6txk923tOZSYJzRmXdnsN1WxzSXQdjS1JYyir8w3lGJgQ7aSdr+4MyAM7s1PpmjzsYNu9Mu5X5x5qoz+hqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157995; c=relaxed/simple;
	bh=RCxySxYxrYNTLxdDaYK1Z366jVaDJvt1L3n28NMaqQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYjT3obUDdBYDVenee6sIsuOzkXZ2nNcgBmUbvjA3Yp3cSgvu5+fKEmeDmqEGbxhUoNWSg78rsyspqOwBgzAlH3bN09D6+tRXeUjJK4Pn27fYGpZMek/mu+v/2eml7tQhFNk8ncibRNiKS1KXXQhuGjS5HFDBHyvRJfDu4ZwVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLSnhzqX; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so3627838a12.3;
        Mon, 05 Feb 2024 10:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707157993; x=1707762793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6UL9kumaqJEuvG1tjx2AGW83PsM8S5M3JMNjEFhz+Sg=;
        b=gLSnhzqXIb7fBgmEB+Y5FVH4iu1CKXTS9Oab7EWo/3pcJkvJ6YssnHKtfVsDpnj3dd
         Mai6rhayrc3/ZcE3UcZpxNtmOU5FpvDvpmkZd1S/XXLOMUfHnFkkEQkIrJcOX8OJBYek
         LsT2JYF+RrIHCHMyvSi7WscNuJl8GN6PR5ksSLEugi63y1cwipEaJPOgCLcLYghJAtOV
         /UOeNBzA745eU1AhRQONIPLjlIf0klHmUPTzMyYc4JMhVVS75nf8h8bOf2kJjVHu3V6q
         Kyc6hOzO7fgd8KX9X72SnlB46OLpP4Ux4W88siHxAxnY+0SVL8CpUR962TiIlTrssM7f
         StYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157993; x=1707762793;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UL9kumaqJEuvG1tjx2AGW83PsM8S5M3JMNjEFhz+Sg=;
        b=Lk7zNr56WeWjcrgOEhfHoossrorCW90JoaKnyAobA/JpcxC7Zc46gU+iYC/gt7MGTZ
         ZHdCfFzBNhmXkmtkes39nTc7IulUG0zLVEEnPHCxxtkAtujzeGqrA+/vpUM3P9VCYrU+
         Fmt84xQxh80nbv8V/Vaw1mk9AELB0fmmElewVdhAGIDGmyxjh71aXRDhgbh98XTXcOh+
         u0GusagVo66caxs5O54wqFmHnv2jGJZsHRwwLH+ACQJdCGM9mY/W+spBwJRgGqpUF2n4
         1jNtxwUqw/vGX7WjfqQFpDrZSM0rQMdnDPgaI17VkCdvERukUUdjjDGSm0M43hyPp7IQ
         ISOQ==
X-Gm-Message-State: AOJu0YzIW3iFzKW3OfpK3o4fb8uQWdgiuB/ugxAAqclcjnJvIVpsLPwi
	FoUKZRaU22vwnDMWtsyefQ5KZ2irr/78VSKeModSDC3xDScwdkLMygxEnRXu
X-Google-Smtp-Source: AGHT+IHTXjumbBlkydlu/A66Q4d/OtFWJrgRNnH3S0jYeHa6OkYrQYRc7ksn5+FP43NRs6tibM6gjw==
X-Received: by 2002:a05:6a20:5d81:b0:19c:8d73:7212 with SMTP id km1-20020a056a205d8100b0019c8d737212mr302626pzb.13.1707157993057;
        Mon, 05 Feb 2024 10:33:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXhGZ9QRMDziTU+SCt4li3nInDc2ogpiuubQbZ/fRf4fij7uXO9YIxrRv2WmtnYNRCBV1ArlwwUfgq/PwfaZASDiAPRDigiGtwKe6la/I0yMgmbdiq6FWoDBVSzTss6UWlt1YyYDUC21BHFbIFZHbm/hBjMStYwI5snKFJr6vqqjOfWzxYsFZ3V3/8V/PvDPoPUICMF+vzBPtf12HlNMa8fPq8e7GTi/orIt3IWqgo7d6qfPVgw32kPLeN/4gMxwZ2gWaQUhA6kt79xt+q3SyGJp3T+iJY=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fk1-20020a056a003a8100b006dbdb5946d7sm170458pfb.6.2024.02.05.10.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:33:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3fede514-ab5e-4b03-87be-ac85337a4529@roeck-us.net>
Date: Mon, 5 Feb 2024 10:33:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: trivial-devices: sort entries
 alphanumerically
Content-Language: en-US
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-hwmon@vger.kernel.org, Charles Hsu <ythsu0511@gmail.com>,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20240201075805.7492-1-krzysztof.kozlowski@linaro.org>
 <170715359536.3640223.5160945915604305923.robh@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <170715359536.3640223.5160945915604305923.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rob,

On 2/5/24 09:20, Rob Herring wrote:
> 
> On Thu, 01 Feb 2024 08:58:05 +0100, Krzysztof Kozlowski wrote:
>> Sort entries alphanumerically.  This was a semi manual job with help of:
>>
>>    cat Documentation/devicetree/bindings/trivial-devices.yaml | grep '    - ' > old
>>    cat old | sort -n > new
>>    diff -ubB old new
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Cc: Charles Hsu <ythsu0511@gmail.com>
>> Cc: linux-hwmon@vger.kernel.org
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   .../devicetree/bindings/trivial-devices.yaml  | 73 ++++++++++---------
>>   1 file changed, 37 insertions(+), 36 deletions(-)
>>
> 
> Applied, thanks!
> 
> I'll try and pick up all the trivial-devices.yaml changes this cycle to
> minimize any conflicts.
> 

I currently carry the following patches in hwmon-next:

  dt-bindings: trivial-devices: add Astera Labs PT5161L
  dt-bindings: Add MPQ8785 voltage regulator device

I'll drop them after I get a notification from Stephen that they are
queued in both trees. Please let me know if I should drop them now.

Thanks,
Guenter


