Return-Path: <linux-kernel+bounces-19118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9FF826845
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62D2281FD2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BFDB647;
	Mon,  8 Jan 2024 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="OwqMnmlY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8ACB665
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9344f30caso953881b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 22:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1704696577; x=1705301377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt7PGUQ5L43nYUE94yk4XF4aImWy48h5RdG3yYl8t6c=;
        b=OwqMnmlYLvURIl9QtFMLrHVdWZfv9XnlkyehWqik1btaZ+kdwaaIHtR0PT523qsQxt
         /tsFJ5LaGEWThxXBUqz9fGt9N06/eCuTCUnsUpJifaOszEuUbBsMMQJ+eRWn5Ioct5b3
         puTdZclYm5hPmtz2joAt9P34Udb3VvfMIKJKOcMHRIefz/6oXTYdeAjNLzq3bpdn77xV
         i5ITT+KY3SY0MEgBDzasfeZVjvGO2c39TWauaT92nhYs6yPbxSwalHRtEE74jR16IMyl
         y7mAW+ElfOTI7oXCDr7LIeI1FKTQCXnZBAkmE5fUPA7bUCxDTE6+Sq2rW/W21Xu6b0t8
         kjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704696577; x=1705301377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tt7PGUQ5L43nYUE94yk4XF4aImWy48h5RdG3yYl8t6c=;
        b=DCqDhMqo9N2GrPrshAvP1Onvsvs+ohLIgLiBJ/ONzsEJ7pPJnJrCuocu7fj1ff2BhO
         FnNHmS4JeRZUblTNzCS7Nlq52qpHL6brKKuatmjwXDM95Slty6t7/yjE8SToNi1s0khY
         hg4x31tvNzTHcVRVIhSGMbhj834xEOxpo1IbtK6og364NEinCbkPKMAHO++wdEj4BtYe
         Jz5UNrs/7EfkzMkoV+0MBXgZ+lvILVHt93qoLeztX4hbcuO88CSzbK+btOYIDOzsUHJg
         J7/QB8GnuO30LpzPKIj57QQYrxl0ZnxbEA/JCsFFx6/elzA7T8VdWYGRAySz8jE4Q+aU
         MJig==
X-Gm-Message-State: AOJu0Yx8zscFAPAwmnk+rtpTX9Vtcob2okJossFINlugJgjyf9YepgcB
	9vZymHMGQOS7MLrS208LYjXSIjMIFtOZ/0Ow4TLN2NiGoCASol2N
X-Google-Smtp-Source: AGHT+IHAvFu60wzgJRTtJBBjAUwjzK1rkytjoKsxQqjLOp60SbdqSYBofXcZZZ9ecUspoWLvn9S/jw==
X-Received: by 2002:a05:6a00:731:b0:6da:ca4b:8632 with SMTP id 17-20020a056a00073100b006daca4b8632mr5746697pfm.5.1704696576864;
        Sun, 07 Jan 2024 22:49:36 -0800 (PST)
Received: from [10.54.24.52] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b006d9b30b33b0sm5235704pfh.196.2024.01.07.22.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 22:49:36 -0800 (PST)
Message-ID: <70448afd-cb53-478c-83fc-831c712e9a82@shopee.com>
Date: Mon, 8 Jan 2024 14:49:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: list_lru: disable memcg_aware when cgroup.memory
 is set to "nokmem"
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 shakeelb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20231228062715.338672-1-haifeng.xu@shopee.com>
 <ZZS-IFA6TScotocU@P9FQF9L96D>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZZS-IFA6TScotocU@P9FQF9L96D>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/1/3 09:53, Roman Gushchin wrote:
> On Thu, Dec 28, 2023 at 06:27:14AM +0000, Haifeng Xu wrote:
>> Actually, when using a boot time kernel option "cgroup.memory=nokmem",
>> all lru items are inserted to list_lru_node. But for those users who
>> invoke list_lru_init_memcg() to initialize list_lru, list_lru_memcg_aware()
>> returns true. And this brings unneeded operations related to memcg.
>>
>> To make things more convenient, let's disable memcg_aware when
>> cgroup.memory is set to "nokmem".
> 
> I guess it's not only more convenient, but also should save a bit of memory.
> But _probably_ not enough to justify messing up with stable backports.
> Do you have any data on memory savings?

Do you mean that it will remove the allocation of 'list_lru_memcg' in memcg_init_list_lru_one()?

In fact, even without this patch, if we set cgroup.memory set to "nokmem", all memcg's kmemcg_id is -1, so
memcg_list_lru_allocated() always returns true and we won't invoke memcg_init_list_lru_one().


> 
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> 
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Thanks!

