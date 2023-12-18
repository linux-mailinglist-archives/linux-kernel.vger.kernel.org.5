Return-Path: <linux-kernel+bounces-3988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4F881765B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED00B241C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153103D540;
	Mon, 18 Dec 2023 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AMYpCpTJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC015485
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ce3281a307so354202b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702914807; x=1703519607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRJXPN9O4/CpOZnMeEgtK0YlDCygbQS02k98b3ChV80=;
        b=AMYpCpTJkw8WVXUIJq3RIuo1aMIT9bztZhcL/Wirf1bIMZ19koM88XRc990Kh9XXSo
         AAQ9cFJluAjUKtAQh5rha6s9DxMme7M5m3M8chFVHU8S3DdHag3zi7AIukh6JI6qD2Jb
         OatoPXCZq+o/ET464Z+HeAzBBzkvZ3sWZe27rUWuhJEXqktAZysQP1cmW82xAcVJdYgL
         oLyHanouUUlZn2x5Re4t7iRz2HhImDEKRS5n/ZfsgB2G4q/mWtfKdD8vVmuHo6r7FXgw
         PWiMf1hBojZOwMNm4IAdP5G+KEDGtyAnI/9OBxh0RQpuyw7hFjROLTBHEIh2cMWzcEXF
         U+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914807; x=1703519607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRJXPN9O4/CpOZnMeEgtK0YlDCygbQS02k98b3ChV80=;
        b=tyFNr9OgIdIFWpkROVf1/4Qyju1kI9Gl78wvtRaG2ONrkNDrBwpSmQR1j33caKF3v1
         L+vaqUWMmYaukUoPr6wRzUHYneGRj0hnk84ZS6My0L3NtT1/rOeL/WCNKHWWLurVHMyB
         D5t0qLBxOYRbnX9b96ZY9S7SLpkpImiKV+rmrtdST5MXEcAl28gv89aNN5r3HUoQ0Au2
         YkklaWW05V3nlNHrOp7h4sUizeeaUnqEMkWAjangonz/l51KVDh8QKCZnACJnwijFYS+
         WvH3dspjePqk2yaaQWVZMcOynMd9u2NxRIQg/AD5/6DKpJhXyfPGYLyvCCRNkkT0vUlM
         MBPw==
X-Gm-Message-State: AOJu0Yy261Z6Kq53hTffQUDJAfKLZE2swqdKs6LWxl2XdtI2yTuWRqV/
	F8s26yICmyJpAnHvGPWNkISoDQ==
X-Google-Smtp-Source: AGHT+IHOPzlKZzfjcHLPIAKjSKNL5VE8URtgM0ualokd4xuKT1TvslSddBgUr2EJ03QC/sxqKxV1Lw==
X-Received: by 2002:a05:6a00:6816:b0:6d7:e74b:a517 with SMTP id hq22-20020a056a00681600b006d7e74ba517mr2837965pfb.3.1702914807323;
        Mon, 18 Dec 2023 07:53:27 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id o20-20020a056a001b5400b006cea17d08ebsm1107914pfv.120.2023.12.18.07.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 07:53:26 -0800 (PST)
Message-ID: <c3995796-8aab-45e1-ad59-d970373a4fab@kernel.dk>
Date: Mon, 18 Dec 2023 08:53:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] io_uring: Statistics of the true utilization of sq
 threads.
Content-Language: en-US
To: Xiaobing Li <xiaobing.li@samsung.com>, asml.silence@gmail.com
Cc: linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 kun.dou@samsung.com, peiwei.li@samsung.com, joshi.k@samsung.com,
 kundan.kumar@samsung.com, wenwen.chen@samsung.com, ruyi.zhang@samsung.com,
 cliang01.li@samsung.com, xue01.he@samsung.com
References: <CGME20231218085950epcas5p4171efba84d8c14bf1307aa16c48414ca@epcas5p4.samsung.com>
 <20231218085152.14720-1-xiaobing.li@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231218085152.14720-1-xiaobing.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/23 1:51 AM, Xiaobing Li wrote:
> The running time of the sq thread and the actual IO processing time are
> counted, and the proportion of time actually used to process IO is
> output as a percentage.
> 
> Variable description:
> "work_time" in the code represents the sum of the jiffies of the sq
> thread actually processing IO, that is, how many milliseconds it
> actually takes to process IO. "total_time" represents the total time
> that the sq thread has elapsed from the beginning of the loop to the
> current time point, that is, how many milliseconds it has spent in
> total.
> The output "SqBusy" represents the percentage of time utilization that
> the sq thread actually uses to process IO.> 
> The test results are as follows:
> Every 0.5s: cat /proc/23112/fdinfo/6 | grep Sq
> SqMask: 0x3
> SqHead: 1168417
> SqTail: 1168418
> CachedSqHead:   1168418
> SqThread:       23112
> SqThreadCpu:    55
> SqBusy: 97%

I think I'm convinced that the effectiveness of the chosen SQPOLL
settings being exposed is useful, I'm just not sure fdinfo is the right
place to do it. Is it going to be a problem that these are just
perpetual stats, with no way to reset them? This means there's no way to
monitor it for a period of time and get effectiveness for something
specific, it'll always just count from when the ring was created.

We could of course have the act of reading the stat also reset it, but
maybe that'd be a bit odd?

Alternatively, it could be exported differently, eg as a register opcode
perhaps.

Open to suggestions...

-- 
Jens Axboe


