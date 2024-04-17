Return-Path: <linux-kernel+bounces-148800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CD08A8793
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559241C21B65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273C8147C73;
	Wed, 17 Apr 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxpkMzWI"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149C140E29;
	Wed, 17 Apr 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367762; cv=none; b=DGtUsNcNBtLrbvI6uViNcdxR9xFhw/sq1Z6vNuK+lt6xsJsz0/yIlomnZVE1YcJhlP2ND0PPjnU2gPbvBsWbavAB3Z6AK646s0MJXWa4Bg47ab3NbSH9lyqoqqT/V1wmyqIfuxMNu5X8KoOFQJZ3UUQtR2X05Jb4L2fDPNXTxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367762; c=relaxed/simple;
	bh=JJKZdCegfysQDUJDhmEa1HfDa5Mld4/NHwyvW6mvxh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5rSOJuePJWaVu5pAbhxwor7r1WjLuU4lYdy8SbvXRWWslAzPAsi4F8b3bavX4qCkxYI/7pZU5BKkepGLufqbjSFupAEQYfcsAzmDzmpXzY6oyxPeqgy223vl7ZbbhTQuTxqOg5lyS012Vfkqm/vJ3H7fijxdEkyiAoofpNu3aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxpkMzWI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f074520c8cso484380b3a.0;
        Wed, 17 Apr 2024 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713367760; x=1713972560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iurkqvs8sKKn4Q2YtZJNLHutAewVDfUM7mbbRZhIB/w=;
        b=dxpkMzWIsYceRKNjkYIMEr522gxGAcEq7a9+Yu7Sey3gsIiw0CclK2m8kch/CGvid6
         zo2EqeWqZANehOy6LMxKzExhqRjqKl6KX/5/YGTOPi1Bl/5P/TrI2wW74e0ckiIRi3nl
         v/E3SlmGBazb2fhR9JJ5Kg0xl+wy1/mfTWMWjwFDdddNPXTDywcItTqRRPPjwl+Iw8Ub
         2Wa/iT/JaE1LltEYdTBsj1IVecW8DyfIDpv3skRuBBjOkcKtMW5KJVQgaBFl884Fh129
         JZg/PSs5op8q/27NzLWxttdJQ/2hQQd68/0NTdEN8ECjI3UW2POCmt83n1qX+ykQ+lqy
         x+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713367760; x=1713972560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iurkqvs8sKKn4Q2YtZJNLHutAewVDfUM7mbbRZhIB/w=;
        b=GrTKK3/CAOfTc7Twg0W6iP6gHb3KaLH5WgHOJBDUoVuxOu2owVH1qToRe4DFtxpzZj
         1kOa7xgFJqhTzQBT8zKuAEEC4yMhch5LrhgLnEOpFqB2CKHtj9Nj96oDD70NJ0fOfoQi
         MUaWp/1JHVUibLSfSyZ+ZCpQuQorSYv8Ef0v1e90dQIxTDExQU6rqS8wwYX8ZmdFGwoN
         uqW8ZOfe87w676RCttQmF53V++DnGZS/7MHf7WT1ZEqmrNTQyUc/zF7Bi3tqFKGMjBB7
         2sciBe9bzLhN4uMlAJkZIAqUcTb+nneyQMo0vQrj0DQxB9B3L9z6OKgFtTf0HW3jTP2d
         D3wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWh2mvR61ln22ufAkSPf7J67QUgCFELfAZj0lQpLbDRze3pZWrWGPAP2t5RVCQom+TTNtRUZZj/eawN8xQc9W0sngjcBU6vFS0rSpWpca2EM119KgDPckigshu3unsaOp1tH5h3/Pqd7pnfytD3wD+zaSG6sNHZczFOpojd6vt2O7PIxsTZN6Lkg==
X-Gm-Message-State: AOJu0YxQjgG4mjbHRgo/lWzqH1TMOjy04fnme7x8MT3oE4KOM+9VPS7/
	f+5mw7cAHg/go0wJiZXAz7wQtT5OWf4j575BaLPabF6jORZGk1I/
X-Google-Smtp-Source: AGHT+IGmYPRURmWR+ziu5qBnkjRFlT0LocAqF3OQvw2Fn6wCykVDUJMHCfSpCkVo670MFilU1AExYg==
X-Received: by 2002:a05:6a00:1a8d:b0:6ed:5655:a02a with SMTP id e13-20020a056a001a8d00b006ed5655a02amr16071220pfv.30.1713367760295;
        Wed, 17 Apr 2024 08:29:20 -0700 (PDT)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id g12-20020aa79dcc000000b006f01fbc63basm3591048pfq.89.2024.04.17.08.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 08:29:20 -0700 (PDT)
Message-ID: <799944de-dcee-46a8-b43b-8876177c61a2@gmail.com>
Date: Wed, 17 Apr 2024 23:29:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] SCSI: Fix issues between removing device and error
 handle
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>,
 Wenchao Hao <haowenchao2@huawei.com>, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "James E. J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240307144311.73735-1-haowenchao2@huawei.com>
 <99598b98-8550-4dca-beea-4c2d61d46f78@web.de>
 <b55da065-dbbb-4d8e-8baf-50807b507cc4@gmail.com>
 <173b55ca-cde-ab3-be92-d9c8b4b6b5c@inria.fr>
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <173b55ca-cde-ab3-be92-d9c8b4b6b5c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/17/24 11:06 PM, Julia Lawall wrote:
> 
> 
> On Wed, 17 Apr 2024, Wenchao Hao wrote:
> 
>> On 4/15/24 11:07 PM, Markus Elfring wrote:
>>> …
>>>> These issues are triggered because devices in removing would be skipped
>>>> when calling shost_for_each_device().
>>> …
>>>
>>> How do you think about to add the tag “Fixes” to any of your patches?
>>>
>>
>> Thanks for your suggestion, but I don't know how to add this tag. Could you
>> please tell me how to do?
>>
>> I just added "fix" in my cover letter and some patch's subject.
> 
> Search in the git history for other patches that contain Fixes:
> 
> Search in process/submitting-patches.rst for Fixes:
> 

These issues are introduced at first version of git record, which is
1da177e4c3f4 ("Linux-2.6.12-rc2"). I think "Fixes" tag should not added
for this commit.

> julia
> 
>>
>>> Regards,
>>> Markus
>>>
>>
>>
>>


