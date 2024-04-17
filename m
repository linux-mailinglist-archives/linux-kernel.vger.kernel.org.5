Return-Path: <linux-kernel+bounces-148779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F148A874A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530FB1C21438
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01531146D5E;
	Wed, 17 Apr 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPeZr1oH"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115EC146A88;
	Wed, 17 Apr 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367113; cv=none; b=LZQjsmuRYgFl44YsII90MEaJyOob8NCd6fUTaY6RBrO/1mD7guj7ckWnNAPXTSNpxGnpaldDrngSWB4PtEh8acqy9agy0xxuhxa4K5vpic1lXFNyiB2NXR/t5rwzHay0Ksa83sQ4LgXYlyaNaaH0IsEA8QBi9NjImrIVI6CkLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367113; c=relaxed/simple;
	bh=8dGXf0wYcoHnqoxRukrTZ+kAcHgbVzlWtiKzjsskiQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDmRKFSI3CC3TqWb7KubPhJMmRi4tcx2C4F65P2DzboeWlwnsC8uy9YeQjD4U38VL4zuR3NIC6aQpkv5SgbHw/DOMNn7w311biaQNx6RJcHDWlCUkE6ZKHFljuBg2npw+vM9pwgKbWFf1JnMuwl74y6fHmi8YJwqM/HU4nPn8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPeZr1oH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so5179149b3a.0;
        Wed, 17 Apr 2024 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713367110; x=1713971910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIgFFZLecsePVrnq+R5s2r3jNwlP/UK/gaG+Jcsiuig=;
        b=IPeZr1oHJePkeZ24cTUZp+DhpiQepCIJJTeIWi09DmMRgN0wuKDs+cbVaZywQq8Ggx
         eykUsciNUDmZm+qDusAVRnRoOu2VuiTH07nLA+JfNIaNB3y5Rk6Mop+5JF94yevrAjLB
         owNmrb2gVeWwBpM74DBWTOio+F2ZPfg0N00V+pJniBfajvn6qFkAE/14HOak5Ugtj0Fy
         4CHMSNAERo6pvATqXHb9aC01GVtKvtyUpPXE68zIv1GnobUj6A8wzVzz6cS735FkF+xr
         3T7vM5ewepGst0FLOd0kRtcD6ez/dsw3WcLRnYI1Yrh4V1sRgCRJEBmCGs8S8vXJFEYN
         jPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713367110; x=1713971910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIgFFZLecsePVrnq+R5s2r3jNwlP/UK/gaG+Jcsiuig=;
        b=S0GXfLyXKtC5JoafJypaCl3g3PknCNZVZIClxTR88ngrnfI4A7hpPlJb38GMhaN8Y3
         bo80hS8lPKpKT47jZ6kvu6kyUGmO18jwF+75pRddKayGlTE0QpK1mHVuc8CTMpFt2eet
         rdWqnOVEFF2r9garbCzBkoVEKdqLQT7SBWgBgs2vJ5LyV9GZ2GoBTwdF9hyXhm+8L9fJ
         qi+TOi9sg6z6hr9XndyDNxC8qq39pSF2zPK9BcfO2YB3pdLzgK1FcdkKCNTTvZZdMJAK
         XLJ6t2t5k3vGktFZsJ/FIxjEbgfZ4Y4C4EQTqjAf+DVWRNz4KcccqSS51CzoChXU0/QO
         EFpA==
X-Forwarded-Encrypted: i=1; AJvYcCXq1Lhvg3+3kEQ9MKCJLuqlqlS1Rac/pNDAhAsdjyTrnZsw9FfBJOhaeZrcA+D4UvzofFQAwGTFnyGr2HjHTCYR/1NxFWGNXlKjEC9Bc9M6vHOSl0pHsnexjzu+50feYHDfkYjnmzobSTx2aPyGIWs01n7I48E9UBRgz0Vzgc0t7/xrqFta2MJtBg==
X-Gm-Message-State: AOJu0YzJ1eL1bUVmSSR1ZQr+PxfsCtmp9MMbbIR3DPz4fg1r8H2zxqDz
	1haNQ4DuF/lV/MJXQIjHk/zaSFOPjeVRmQTKCUoEicge5Ttvp/eD
X-Google-Smtp-Source: AGHT+IGCkof/gEUUMQases2g9Oi5H1uf3PPSLWp/woJwDEzngUgmhG0OR+y82bcnr1Z1TJNhvbc8sg==
X-Received: by 2002:a05:6a00:1782:b0:6ec:fdcc:40b9 with SMTP id s2-20020a056a00178200b006ecfdcc40b9mr21742938pfg.9.1713367110234;
        Wed, 17 Apr 2024 08:18:30 -0700 (PDT)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id fh39-20020a056a00392700b006e69a142458sm10676701pfb.213.2024.04.17.08.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 08:18:29 -0700 (PDT)
Message-ID: <d5e682e6-30e4-410c-972c-998fbcd12ddd@gmail.com>
Date: Wed, 17 Apr 2024 23:18:26 +0800
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

Thank you, I would add this tag in my next post.

> julia
> 
>>
>>> Regards,
>>> Markus
>>>
>>
>>
>>


