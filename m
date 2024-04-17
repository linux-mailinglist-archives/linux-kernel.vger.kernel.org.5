Return-Path: <linux-kernel+bounces-148743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACFB8A86D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE8A1F22365
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46F0146A91;
	Wed, 17 Apr 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvVOWshW"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C713D53B;
	Wed, 17 Apr 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366041; cv=none; b=Uj4SdeTOXqG7BBLcoDXVNETvbUqoWfurl4zLenF6i/5tw/hBWs9Q0YZ+4aDiODU2ZqzAZMkc8jv4xq5GqJ9lKiSzQhrmTdpDgS9qvzfy4DYLxGbBLqR7aoEoeSNzwX1Cjhg6Av26/BbHu+bBQ7dhq76NyRO4UB31HLnL99V5SIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366041; c=relaxed/simple;
	bh=Pv78IXl2bm3ydbqouKwtK2I52ubPtfTaX+pdXQRsF2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQUroZ1/EFvjyIzKKFMjwrDZ3n0hjJEeX+VkBVe/gYlYJqUvrgqPQidDEkXXiUoBRncZ8DC7c2scfWNPJn6/2SHyPuISONrcJ4ohSF11Pnxe24AlEYdFbSeHzUemTXk+Cdgm4FlIKBFerbBXsjTTEjYjjYAa6P3ousJ8ycKHuTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvVOWshW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2b1cd446fso44828725ad.3;
        Wed, 17 Apr 2024 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713366039; x=1713970839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYi5omCU0CqbGR+gKfb5Qb9cGGSWmx8tQH128JVUBmA=;
        b=jvVOWshWlbsGrggBWmKvUPD8frLvuEmNHeTDaiKoWKd7+usuS6zQfRLjI9+t28fViy
         Lfzz8hOrbIqyD2A7snhXumyqU9SOrfZlYjuCgzF9+CmFwQSOp/aDg/RPp21tgZGLadeV
         2zA2THH6YEWYw/6L8GgQni5NeOu/ZEJ+auJ06euck9LpP6NfI8C2kh8f+4npLxd0H6Z5
         b3g0JLD8KT1EWtRkBbIPr07MIftCyKV1mjnW6MkWHV3wu6I1hYTDxIXq6DvqMpJRJ5+m
         Xii08P0vVO8U2q/mzWjAp+BKfHxMDDGXC2xNffB4tTTuygPjPUVB2MlCG1pFX4aHguBy
         f9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713366039; x=1713970839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYi5omCU0CqbGR+gKfb5Qb9cGGSWmx8tQH128JVUBmA=;
        b=AIqhYYweW57ymh+y11encHL777HdhC/xzNleaxQHja+c0h1xV4BWrAJHbKaddZLLP4
         QrFYfl1rZu2ETqKIHA09xhHGhDpNIUgL1J8TneFUa99itjz5WeryE/1jANPUhJxcnDmx
         DnMdajrczURtDkNb4rcC9GfKq1cVFGyI/Xw29gQa5LkwqT+td5HloWNUGMKZxa7hpGxO
         mf7gzuma3gdDbPCvj3MAcojpzW9jvuo59fr+jqxeo+5nykq84VXzE8hs83I98Uu6nugf
         32KaNnBNKHqZ9LVI9YqmnIFKoklYLaWxemXRjf1TVqpOloy2PNPBJNucRYFruVjdAudG
         S9cw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8YF67Ckm4R8jAiixhk5uBIaaphZ73J8aaiTjbH4HbYe3KfIpWTLU2iWb6MfG91ZJwfXqUmnUu/tADSSEr+m0qrrFUNMNdNK7pet36gXlotVS7CHNL806enzkDTivIOZlsShVUUL4+SdLQA==
X-Gm-Message-State: AOJu0YyKGjcowx+YzcXjBlL5ow0Y6AY7+Dx+dbdzNyNJqWuQtkEZypnb
	22JlmLVk1pkZVM3Evx0zd132Z1RkvNdykr0QZeZEu0SR82F3Qr54
X-Google-Smtp-Source: AGHT+IGKHGoqJBTGlLXEa5s5LD5WPlcrDRocTZk6DX3GRddccj1QsCqehTaCMIFCAYMU5ZRao9KTmw==
X-Received: by 2002:a17:902:ecc6:b0:1e2:be4b:dd9f with SMTP id a6-20020a170902ecc600b001e2be4bdd9fmr19454003plh.15.1713366039214;
        Wed, 17 Apr 2024 08:00:39 -0700 (PDT)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001e223b9eb25sm11666844plf.153.2024.04.17.08.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 08:00:38 -0700 (PDT)
Message-ID: <b55da065-dbbb-4d8e-8baf-50807b507cc4@gmail.com>
Date: Wed, 17 Apr 2024 23:00:34 +0800
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
To: Markus Elfring <Markus.Elfring@web.de>,
 Wenchao Hao <haowenchao2@huawei.com>, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "James E. J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240307144311.73735-1-haowenchao2@huawei.com>
 <99598b98-8550-4dca-beea-4c2d61d46f78@web.de>
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <99598b98-8550-4dca-beea-4c2d61d46f78@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/15/24 11:07 PM, Markus Elfring wrote:
> …
>> These issues are triggered because devices in removing would be skipped
>> when calling shost_for_each_device().
> …
> 
> How do you think about to add the tag “Fixes” to any of your patches?
> 

Thanks for your suggestion, but I don't know how to add this tag. Could you
please tell me how to do? 

I just added "fix" in my cover letter and some patch's subject.

> Regards,
> Markus
> 


