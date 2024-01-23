Return-Path: <linux-kernel+bounces-35515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E8183923F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DD1295BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FB95FDC8;
	Tue, 23 Jan 2024 15:13:17 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200D5F858;
	Tue, 23 Jan 2024 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022797; cv=none; b=uo5g7DvdUALsht1Eu4WTty/c5AgUycBGd20t56f10w94dLfpeV8tHM+/RWqXUvGYyC8Lq4B6k323G0+onQE8umA2EOuYzDe/p6B0wQmFXqtS9TOtARnK3mx6v7yqN85q0hA2x7TWMHQ1pdl3XCbXgcpLitppL1izJRZX/XBmRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022797; c=relaxed/simple;
	bh=u0Leg9PiHF+SJm46VLNcoF7rGsCiIovBve84jf6JUr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bRAmcLe/JTvmR3SX5m6H9EPuV+oLM7RDBOm9kAaEJBCNnGa+sxPJ7IFVG4/Jbx4gWRJ4qLVT9gB6uI98zRXJc1rIfJg3Rgox8GevKZW0fL1oH1GDaKzgy1qaJceJosmvHH9IkmnesrgQ9MEPOCSftT1ayvlljG1C7lf3SFs0cHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d75c97ea6aso13690285ad.1;
        Tue, 23 Jan 2024 07:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022795; x=1706627595;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pR/WckuwdSJfMEWLdLn8merKply6UNVDy0QMROF2vEQ=;
        b=hj/8efLUIfnnQdJVAQ5ru7DyDZqm1N7zSFByLZ2F9UNwo8mrDh2l01KWf7Vk1mbJgN
         9UJQEKbkCaODE3fCJdmy816e1bzXQXYQCzm0vqUtpNfjSGN6B2Of4D733GljA63Ve+ZH
         GpmCgpxjVgFTpFt6BID8K58LKr29PXYIShRj/rm+I2mDsQF2KR07AYJJVueq9vgl0GfO
         mFXAGSOO/k0vNB7Q49ZnPGfa++g0Zc1Qr9PKuuXCiiEZYYl069oxYg9+7VXJgEeM5GNB
         s/gkh3DLffJLB5lBN4n1Toot+gI130vqfv39aHCXTZFu5cpCnXnDy9WmggIGJnh+eUA7
         K0bw==
X-Gm-Message-State: AOJu0YxeFdUvqhyY7IVyu/9Ss+vliZQxDxYUdhdbzs/iV5Kiyq2ADduE
	k3gSlFMknM6C/16cvsrzyNDXpBPqhwjYWyNLiAzROQ9S6zWPgI2c
X-Google-Smtp-Source: AGHT+IEmEm4Jm4p8GuqiECjJQQGO4iygUAnaH/jUt4l6k7Ix25qX6in2iCpCqMI/CuSw6xK9rrgLPA==
X-Received: by 2002:a17:902:fe0c:b0:1d3:8bf1:9add with SMTP id g12-20020a170902fe0c00b001d38bf19addmr7820844plj.36.1706022795040;
        Tue, 23 Jan 2024 07:13:15 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902bd4500b001d74c170f2dsm3853359plx.90.2024.01.23.07.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:13:14 -0800 (PST)
Message-ID: <9154bfb7-851d-4144-a69e-1aa25b72e8ad@acm.org>
Date: Tue, 23 Jan 2024 07:13:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: introduce content activity based ioprio
Content-Language: en-US
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>,
 steve.kang@unisoc.com
References: <20240123093352.3007660-1-zhaoyang.huang@unisoc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240123093352.3007660-1-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 01:33, zhaoyang.huang wrote:
> +	activity += (bio->bi_vcnt <= IOPRIO_NR_ACTIVITY && PageWorkingset(page)) ? 1 : 0;
> +	bio->bi_ioprio = IOPRIO_PRIO_VALUE_ACTIVITY(class, level, hint, activity);

Shouldn't any code that is related to the page cache occur in filesystem code
(fs/) instead of in the block layer (block/)?

Thanks,

Bart.


