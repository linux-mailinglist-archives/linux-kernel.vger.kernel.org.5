Return-Path: <linux-kernel+bounces-9688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1247D81C9A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D849B24CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB01802F;
	Fri, 22 Dec 2023 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ouvi/6BW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28F17985;
	Fri, 22 Dec 2023 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3f3ee00a2so10542985ad.3;
        Fri, 22 Dec 2023 04:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703246589; x=1703851389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/gHMy7YQ8gXVWBz8QGxCgV9ba52/G2s9ntxQbTBuYw=;
        b=Ouvi/6BWqbEhQXSSpPnQvri9KsxtjNAkLUMetC0RtY9m5yW8OyTjyUB2Qreho+29JR
         GPNIwcp+1R0wZTvVlOCHnX/DM0sCkUtmctVOgZ2NH5ESC3Ucn0Ab60HPawyTEmSDwDSS
         o9SHxeAfxtiQ48aMpXTgSkhE+H702P6LbXNmVBNqo2mSzifqzjxwMzof9DAQYv7IvXAS
         vsfdmU2NugG7R+VyogoTtp/SqAQkifFtfhgtkVYV4e3vfK73DbqfMbJObSC21EvpRU8D
         fytRNkOCd8T3jcy2TQPoS6Ha4faJZR3RJd94hbpVE9I8eJWGoR3NjUA9h5fUT23B4QkT
         drWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703246589; x=1703851389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7/gHMy7YQ8gXVWBz8QGxCgV9ba52/G2s9ntxQbTBuYw=;
        b=nmzJLCJ0Bf73BqXwuZSt8IcrWl2x0hugI/tyIWmqmcTgmtR5757vUxiNMS6mt+cuZT
         +TFCHR83DFyrpYF5SMu+gOqBnGBV1JAueEYQQBHlXSOQpliOLBqxsNbmtBTkIlRbogyl
         /IfKIEH8n4F5jkrJSXs7HbZkM8ThYf1e56mqRFuXd9ICPi1NXqY/kD34+Fvj8Erleehz
         RGLnZW+CRFxGBjLGpOcu4vYVr1SXLlTigcSarY+0I511i1jiyNqJHAnuu8ls+QbwfMSe
         t+rx3B72IXnpHGL3YdcsOTvzrq7OzlfnVfobWRVLQrkgvdjjZmVbMGizolE3J57Vptzj
         l4Vw==
X-Gm-Message-State: AOJu0Yyhw16k4v/ri5Pg6KI32E1UDAXeE4vGm2RV6lR/tvZFVIQ9SRz5
	0L+LJycaeqKsk8um4p/v5mnOkiy6SAUJ8mQR
X-Google-Smtp-Source: AGHT+IHwGUg3hjbop+4OaznMozqll3IoEpL8FoXxNc1IdzY4+cNf9vlG4YTXhqWyCdQHIZoQwkgMJQ==
X-Received: by 2002:a17:902:6548:b0:1d3:ec6f:3c47 with SMTP id d8-20020a170902654800b001d3ec6f3c47mr889101pln.71.1703246589220;
        Fri, 22 Dec 2023 04:03:09 -0800 (PST)
Received: from [10.193.226.49] ([106.39.42.235])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090264c900b001d3b258e036sm3378838pli.176.2023.12.22.04.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 04:03:08 -0800 (PST)
Message-ID: <5988463e-8ba1-40a1-9bdf-fc345dbdcc32@gmail.com>
Date: Fri, 22 Dec 2023 20:03:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: Fix atomicity violation in
 {conn,adv}_{min,max}_interval_set
To: David Laight <David.Laight@ACULAB.COM>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
 "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "baijiaju1990@outlook.com" <baijiaju1990@outlook.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 BassCheck <bass@buaa.edu.cn>
References: <20231222105526.9208-1-2045gemini@gmail.com>
 <0565eabbd25141fab9f3206db4e86196@AcuMS.aculab.com>
From: Gui-Dong Han <2045gemini@gmail.com>
In-Reply-To: <0565eabbd25141fab9f3206db4e86196@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Thanks for your feedback. Let me clarify the potential issue with 
concurrent execution of setmax and setmin functions. Consider a scenario 
where setmin writes a new, valid 'min' value, and concurrently, setmax 
writes a value that is greater than the old 'min' but smaller than the 
new 'min'. In this case, setmax might check against the old 'min' value 
(before acquiring the lock) but write its value after the 'min' has been 
updated by setmin. This leads to a situation where the 'max' value ends 
up being smaller than the 'min' value, which is an inconsistency.

Regarding the lock sequence you mentioned, it's indeed from the original 
code. My patch aims to include the validity checks within the 
lock/unlock sequence to prevent the described race condition.

Thanks,
Han

On 22/12/2023 下午7:41, David Laight wrote:
> From: Gui-Dong Han
>> Sent: 22 December 2023 10:55
>>
>> In {conn,adv}_min_interval_set():
>> 	if (val < ... || val > ... || val > hdev->le_{conn,adv}_max_interval)
>> 		return -EINVAL;
>> 	hci_dev_lock(hdev);
>> 	hdev->le_{conn,adv}_min_interval = val;
>> 	hci_dev_unlock(hdev);
>>
>> In {conn,adv}_max_interval_set():
>> 	if (val < ... || val > ... || val < hdev->le_{conn,adv}_min_interval)
>> 		return -EINVAL;
>> 	hci_dev_lock(hdev);
>> 	hdev->le_{conn,adv}_max_interval
>> 	hci_dev_unlock(hdev);
>>
>> The atomicity violation occurs due to concurrent execution of set_min and
>> set_max funcs which may lead to inconsistent reads and writes of the min
>> value and the max value. The checks for value validity are ineffective as
>> the min/max values could change immediately after being checked, raising
>> the risk of the min value being greater than the max value and causing
>> invalid settings.
>>
>> This possible bug is found by an experimental static analysis tool
>> developed by our team, BassCheck[1]. This tool analyzes the locking APIs
>> to extract function pairs that can be concurrently executed, and then
>> analyzes the instructions in the paired functions to identify possible
>> concurrency bugs including data races and atomicity violations. The above
>> possible bug is reported when our tool analyzes the source code of
>> Linux 5.17.
> Your static analysis tool is basically broken.
>
> The only possible issues are if the accesses aren't atomic.
> In practise they always will be but using READ_ONCE() and
> WRITE_ONCE() would make that certain.
>
> The lock sequence:
>> 	hci_dev_lock(hdev);
>>   	hdev->le_conn_min_interval = val;
>>   	hci_dev_unlock(hdev);
> is pretty pointless - is doesn't 'lock' two+ things together.
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>

