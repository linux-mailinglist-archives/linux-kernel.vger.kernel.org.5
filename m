Return-Path: <linux-kernel+bounces-166155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6DB8B96E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA09B2327C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E48B4F88C;
	Thu,  2 May 2024 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9qnWCa2"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25C3A1A2
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639898; cv=none; b=gdbfE93gzvIPk2qBCBeRTM0oDsiz3Gxq6io3U9VxHZFJ+aO+1C/+bWtWxqtsI2MzPMH7yVZ5qiI3pd6EeTONfiUEfr7uCJVKE3IlXIDGSbBOo7RxGS30gSx/67yskJrQLMAkRdO0rO61bB9l11C/zThw3IDMMonztbV4a/AHzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639898; c=relaxed/simple;
	bh=eo+3NUMxM2jwT1dw4HDbrVXtIRxpRTga71y+Fj/DEjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FO0RsBoM4KTyyokDpAdxFuKOtH3VqK1gPt6sA4en+iWzG19XomNNAp5xiJpyItLvYEava8nCFCnZerEG/o9F+OsE3MJUAFxTpqr4tpzgP7z1pg8v75E3QYq3rfs+Nmt4MhTqIstm84LNBGKszuYw5ypJnZk3NlMEuLdvzhMFSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9qnWCa2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b782405bbso45933595e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639895; x=1715244695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLLjzZnv4Z0/yLvYvsBEsvnw8lYsK6i6fPPd17AXon8=;
        b=b9qnWCa2FXzhcQLuMAt5JLzKncLI+jQVam7WMoUH1NpmcVysrzW4rIWF4k74kVWv9+
         JpGXT79/H10sJzAZes81yYoEu6FcDxOMuuPYK/xAFjjj1PbfRg7k+yw9hB6tnWyMtnNl
         OsT0L0xe60riGoBGNMnA6+HEJIKVc6xNeLPIXcbrRv1lwP5KfxwT5b8LiZrjlfnYAByE
         wulRJ6XexG6+TIooZh4tdsS3HmA7ccsPrvD14l2g+zA3nQq1fgrl4curiVZNL5T3pieo
         S9JDGnoI1rPMX499SdrU3DvCDYQSMN0aehCaW373Dt8D1s2lT/l58IgOhjhEBmZ2N0ml
         EtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639895; x=1715244695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLLjzZnv4Z0/yLvYvsBEsvnw8lYsK6i6fPPd17AXon8=;
        b=RU79vZsDUYAkak+S93PiFgfIBrrwusxO+jmkQf+KvwU2hNtSd4Cvpm0JZwT/kHZRQd
         Wx6OeUZs1CqlCIPpCQ9UOyoF68KleFhYt8hxxBMN2garqNBymvfsbt4JAu4uBrdrlKub
         v91HcYucOVdBKswvEBABjHY5Duhuo1X1s1TX8inBxQFARU7aEju8FnwiM16v6JBaMU26
         o7hSsOHZbeBijmQTMVOOEmsOgMPVtsr64yKeXlnDEaHW9BBExD0fU8Y2NTGAFduOKKhY
         ojBO99PFPUxYW/iaJpFAL9fg2gn7zkz0UFoOTtuWQAIuGWT3btskGEjbG46REoFLBlTt
         EzlA==
X-Forwarded-Encrypted: i=1; AJvYcCVCrB+qVge14P477ChMDKFem1KjRh5MUJdvLT8OGpnfhfzQj8jcW98UBh2g5QcJg1mMDCB5sVBNcucNk2nQNTdyTYQ8e1bHtDflFqcs
X-Gm-Message-State: AOJu0YzLdaF9DD7yP+hika5cZDX0I/PSLDFlJWqzC98Z13sYRzj9yeWs
	9o+k/sjdAGITldIaCZ3Q2FUcXzFEOpELPg29henwLs0mo+dWedsI
X-Google-Smtp-Source: AGHT+IHg1TRsUmwzWfbbGWlDaGt5SXUjJQMhVaOHCQTAnZ8ouQQ2/fxEkCt5liCywQBohpEhFZF5gA==
X-Received: by 2002:a05:600c:1d8e:b0:41b:dafe:ff78 with SMTP id p14-20020a05600c1d8e00b0041bdafeff78mr1165549wms.20.1714639895570;
        Thu, 02 May 2024 01:51:35 -0700 (PDT)
Received: from ?IPV6:2a06:c701:737b:ef00:c50a:d96c:6c34:ec52? ([2a06:c701:737b:ef00:c50a:d96c:6c34:ec52])
        by smtp.gmail.com with ESMTPSA id w6-20020a05600c474600b004182b87aaacsm1195572wmo.14.2024.05.02.01.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 01:51:35 -0700 (PDT)
Message-ID: <9efb9bdf-6f79-486b-ac18-3cf501aeef82@gmail.com>
Date: Thu, 2 May 2024 11:51:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] staging: pi433: Use class_create instead of
 class_register.
To: Greg KH <gregkh@linuxfoundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: hverkuil-cisco@xs4all.nl, andriy.shevchenko@linux.intel.com,
 robh@kernel.org, felixkimbu1@gmail.com, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240501055820.603272-1-ikobh7@gmail.com>
 <20240501055820.603272-2-ikobh7@gmail.com>
 <cc00ea68-0ec9-40af-a147-e8f67f7f29d0@moroto.mountain>
 <2024050158-mutilated-zero-13b0@gregkh>
Content-Language: en-US
From: Shahar Avidar <ikobh7@gmail.com>
In-Reply-To: <2024050158-mutilated-zero-13b0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2024 17:14, Greg KH wrote:
> On Wed, May 01, 2024 at 05:00:44PM +0300, Dan Carpenter wrote:
>> On Wed, May 01, 2024 at 08:58:19AM +0300, Shahar Avidar wrote:
>>> Make use of a higher level API.
>>> Reduce global memory allocation from struct class to pointer size.
>>
>> Doesn't this move the memory in the opposite direction from what we
>> want?  Originally, it's static const.  Isn't that the simplest best
>> kind of memory?
> 
> Our reviews just crossed...  This is just a revert (in 2 steps oddly),
> of a previous commit that changed this api call, and for that reason
> alone we can't take it :)
> 
Thank you for your input.
I replied to Greg's review on another thread.
I won't pursue this change.

-- 
Regards,

Shahar


