Return-Path: <linux-kernel+bounces-95098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CFB87492F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB83B22B6B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A4963128;
	Thu,  7 Mar 2024 08:01:24 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECA79CD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798483; cv=none; b=eOxEe06xNIDf/kEY05SSwMs1cHr10sdfhmYYJlugext9QYALrMPrBRgU0qyY49wdkbVxbPxUDgwnQ3dm6cYgNLN+V42eaH1ckbJhwadRV9jwV2+WXtAjcnM7BjsjF9A/7WZRXKV6HhUlPHZj3DHostomFRtQQz5RvdQMBre/emU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798483; c=relaxed/simple;
	bh=nsL5erAyMH927QE8l2r/dMb7kWuwxNCxNP3HYuwXGpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfwXSDt3fxnMH8vJmeMgScZVC0GeqgXfiGXpqEAGbVEmr0CFDheSXmwJjtX+Y0AJ8vInb2ptN8DU5XuHNkiHIqiA9dBORVAjs+LNvHHZqGx8cyM/lAX05+2dJ3dnH2lvh4LVE28BFVLB+OoLKGfI+sAmKTLfyNdph8PmWRVwPlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d855caf7dso142080f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798480; x=1710403280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97WwwVRWtYQ8/aWJm0Z79+FFPyBo55ZYv9K0xumzQh8=;
        b=je5ptaKH0GUdO6+FnDACuPZ0RQGbtqV72XEJOqWfl3Xh1j514zqUmqOZInzibV48fb
         x3wNawFfSMH7T48uyOfFa6176ETfhNdq1Rx+b/LY1S7kuG89aMcJ1cG7CY+hAPVoMwQ4
         Yi1PkxioK5e57eh3qnG9uwrVCn9NMJFIwFXnYV11pIlBkfw/GoPYHaIV8jXQWhlAjPaX
         ot9uxAv9Uz/gT3+u+ezjUoXJc8T7lgWNZ3hQjaqK1WNhDPfzHUcaXSCSU2qx8gRsWTWe
         n0l1uM/LiP3hO2QvQPGwJoyDiwr/s9N7jazmMxgC2JEMCQBG7NHxkuBnJiS1bg1z/BDR
         rF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXK4+jOIs9s3j0U8wqZyuFrVEq1bS0ovv928warjQbNc8rNd1/XhVz7JbyjOLeD08gF2xNHmzOlN+/t5jTMeWuJhfQprqxTNrNPVgzu
X-Gm-Message-State: AOJu0Yyxa72sU0ZhCUS0uGFRgi0TDTMfohMwhB7PrkBwr/dylTPvBWMk
	4B+vIslyKpuKFYr5mckhNuOHUV6qT6sSjePTcagrEEqi+DR2AlJL
X-Google-Smtp-Source: AGHT+IEQKV+TqPHbdgnDGZitM4yLSDvWalrVT0e2s/AG4lzy/hat2pJCQd77C97fYqVc7qTS/VBm/Q==
X-Received: by 2002:a05:600c:1c1b:b0:412:b2af:2632 with SMTP id j27-20020a05600c1c1b00b00412b2af2632mr880562wms.0.1709798480257;
        Thu, 07 Mar 2024 00:01:20 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id bj25-20020a0560001e1900b0033e49aebafasm6592114wrb.3.2024.03.07.00.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:01:19 -0800 (PST)
Message-ID: <b4a7d773-4963-412c-b9ad-fbfd5c461313@grimberg.me>
Date: Thu, 7 Mar 2024 10:01:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme: constify struct class usage
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
 <20240305135125.GA2802@lst.de>
 <ZedCG81IUxid_KzX@kbusch-mbp.dhcp.thefacebook.com>
 <bri7abpenndub2ejegge667wnrgqpxhyh2zjozotr6qn4xuv2t@dcibklqxgxcn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bri7abpenndub2ejegge667wnrgqpxhyh2zjozotr6qn4xuv2t@dcibklqxgxcn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 05/03/2024 18:25, Ricardo B. Marliere wrote:
> Hi Keith,
>
> On  5 Mar 09:02, Keith Busch wrote:
>> Thanks, applied to nvme-6.9.
>>
>> For some reason this series didn't arrive to my inbox. I got the patches
>> from lore, but I probably wouldn't have noticed this series if Christoph
>> hadn't replied.
> This is weird, I use gmail for sending. Thanks for letting me know,
> anyway,

Same here...


