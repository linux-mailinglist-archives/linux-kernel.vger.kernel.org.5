Return-Path: <linux-kernel+bounces-166833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D494B8BA03B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50101C22CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C73917333C;
	Thu,  2 May 2024 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEIYCLjg"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B37171068;
	Thu,  2 May 2024 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674165; cv=none; b=ohX7ftqWA4dEPeWm2UoO9XYrfL4ZGyv3xdxNpsQgdqny0htgXqkx4+XDJMEDoIldp73M5ugL7UO0l3OVhNUc396Tg1NrQ6b/RFMp63DsPwn+puTJZHPq2Kf2CE/RSWNyydlUprxwPDSYOg5SXFfYNteC1bzuOzg8bNORsuNuZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674165; c=relaxed/simple;
	bh=My+0Rd5lz0MXO7wxfA9MZxTeduLaR5NO1sttRqiTYzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X82fyPfsspspwJyhtc0bLxHrp8VRHZmrfxrIeozh/7BHtIBx46pnzjot4Db+8v91tI+IWJePFV8XuJUm+Qlf0Sj/5ezM0vmkpvpQuDPmeou0/NMWTO6poNfN/2fHu9BLM2jxT4lqT/d1+V2W0Bc0B6hUBLlJyut7FC3kb6Jz9fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEIYCLjg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e3c3aa8938so55164125ad.1;
        Thu, 02 May 2024 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714674163; x=1715278963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=U+RaPVn6HkrrIM33dEK9K9ChnzChCLl6eDfX1JTLZWM=;
        b=PEIYCLjgAhsimedo1aZw9swqsbWG1nxkfk0bSj19MDYdxy1gAoic9yYiTAt26npddZ
         K/qrDurCWi8eUVbnuC4pfePYmH1f0kHxT05HchQwoVr/ZiYyGSHQw9ILZyE2ArOfUxDi
         dIja5+clEZCvRUq/+oPucqSSzMwEO/NEFeTnB7uSBbaOgvbZkubaxofh7G94WGhAI1lE
         7wokZyx/NEes54b7Qrt8O315NStWnuoQkul9+BNE865BmGCXiN6LLUrakUqnR1G9pqzH
         tGSP2JCydn+SGlG9b1ONzV03v733XnKU3geBshE0JI40eAFi5Agdg7QO+sFljA6s7IOu
         9AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714674163; x=1715278963;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+RaPVn6HkrrIM33dEK9K9ChnzChCLl6eDfX1JTLZWM=;
        b=PFLLTLfCbwwcwJYTlwsiM5pAJOQsa0uUW4VaBS1wMb5KR9XFf9KWB3E7pveloZdVjQ
         Ij3fTeldWhgou33IBnQpb5tz+Nuz1yvTRerU0VrSDe1bfystn3WP4eie/Sxcju+163qz
         kAqeZkEEbgoL+u+VFI54GPm52EJvws8k3DepF+mSgHlRWm/S/zuwUQ6nHQXu1itFxW1/
         ZTMk+KPypVFiZ+AeBb8KBGvn7CcYOHqZF1/fIYBMG4K33bKsOSzjnzxzyMTCPbUeyvG5
         EMW0TAj17ymmsZsia/tscuMDlg6y5Rh58K7o7VDR9P5y1/nR8wRBjg9pAMUmMrR6c/pF
         sV0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8/HcAy4svEL+LQxglgJfp4w+mzi7lQmirSP5L+JY/MonPu+W5AacdDQQZ8TUYBlZZMg00ZPhcmfGdRfrZt3xns+N5+hhD0drbX3erOVRjtUOw3vVQqSEYTxBXLrmKJAPTGgya3JBI3OU=
X-Gm-Message-State: AOJu0YxZDdKUsbVx+NdFhjQaHf6p75Uw8RmpCs2HWjA6jpSYeWIPHV8o
	1oqXUcwH4CP5ilau30TdE+rztO8qowodIMWp6GU4pzxj3lhr3t7pPgaUQA==
X-Google-Smtp-Source: AGHT+IFfqb3THQh8Im6TLVtP4hVs4geUtGUfk8YK7QvsOXscWObcm8rPGUYDPgUYRFInB6K5l23K5Q==
X-Received: by 2002:a17:903:18b:b0:1ec:c6d1:8950 with SMTP id z11-20020a170903018b00b001ecc6d18950mr478825plg.63.1714674163207;
        Thu, 02 May 2024 11:22:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709026f0900b001e2a7ed52d0sm1651881plk.239.2024.05.02.11.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 11:22:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <af66ac87-32ff-48a6-bf1c-d7ac578ceb4c@roeck-us.net>
Date: Thu, 2 May 2024 11:22:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon (max6639): Use regmap
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240430210539.935040-1-naresh.solanki@9elements.com>
 <52e7692c-abaa-4201-8248-3f42bb250335@roeck-us.net>
 <CABqG17j2kMEK98T90eudb_ZWftaV2L4_MdA8ML+v_cm3MHFs1w@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABqG17j2kMEK98T90eudb_ZWftaV2L4_MdA8ML+v_cm3MHFs1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/24 10:25, Naresh Solanki wrote:
[ ... ]

>>> +     u8 pwm[MAX6639_NDEV];           /* Register value: Duty cycle 0..120 */
>>
>> pwm caching needs to be dropped as well. It is no longer initialized in
>> max6639_init_client(), but updated and later used in pwm_store() and
>> pwm_show(). Looking at the datasheet, the pwm registers are volatile
>> and should not be cached in the first place.
> Yes. I did that but found that the register is write only. i.e.,

Odd. The datasheet says that it is r/w or, rather, that reading it returns
the _current_ pwm value and writing it sets the target pwm value in pwm mode.

What happens when the register is read ?

Thanks,
Guenter


