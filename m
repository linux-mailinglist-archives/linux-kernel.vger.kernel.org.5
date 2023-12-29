Return-Path: <linux-kernel+bounces-13167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F182009F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7581728481E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEB212B71;
	Fri, 29 Dec 2023 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kUlbguWY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD25B12B60
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3b84173feso14636715ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 08:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703868770; x=1704473570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSNSWnuaXWoD96pZfJRvHlzqw6OfFPh5yR+M67iO49I=;
        b=kUlbguWY7v2RnOcvb+MFg5wRvScaqr2iM03/jLZEbjgvZUaKLThvjZxUJVc2tn4p0p
         yOmeayFWrHFI1lXFExP44SIkYBvGc4TtYQ30GAAyq7ZPNAffa76JqBh2EO00jWoCEj6E
         95O7ML3RFmVvlT02OY+S6GYYiN6hsXbOtkUsAwCp/3A0TvV/u9P3FYD9UDZNGKf+yEJX
         a69KEMd+kP6Wg9SQYr1XwjKDttPC5YlvR0BtWk1OM+BxqE3cYlr3mJluNpbkawIrGOcf
         TTSj+AFzbpSnusYVdqPS8AUrjalwm7DwQgxq1XACcq2hM6rL2sPZyAtPSogeuHU/8bBb
         o0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703868770; x=1704473570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSNSWnuaXWoD96pZfJRvHlzqw6OfFPh5yR+M67iO49I=;
        b=p+lt0ChaYmS/g081AW2TLlYjhdvvCey5b96fylzTPW1Fqnv9lbf814KSoynvGBWF4p
         wWCfMz4zW5qPHg3l8ucAnTN2oesgiBTIImfcTixo07TKMr3qJA3eWk/iksd4WGvK/K2e
         Wzdw2wCHJ/NpISI2v+BzJTmeMMKYAwdMXZimi4D5CQi6wJ39TqfIDq9qLtn67xo5fUaf
         AJSABy5Lr1YLz9S2ql4Tzb2mlvyfjIRE0TlvD/QbXpo9N2a71/O16f/W5cSD12hW++p5
         3nSDTV0WhGzgFb01ZIiyYG6owvKSVekpQcUKCA81bb0dya9xy7ZsTUaJV0IlAVF4O6Wr
         hmiw==
X-Gm-Message-State: AOJu0YwzLferbI2mTd2gsELMTjFcQDEY76A2MiD5ByrLVHGKgHQn26Ys
	Yo4oL6FhHSARoEbvp+sIlIWBLNCI4uZHNg==
X-Google-Smtp-Source: AGHT+IGiSo6gfL6F95WOAnfesLOgRyGsedXwl+rlko3RNnUsSMwbXGkaPtrt/okfz5sK3yB1/MkqyQ==
X-Received: by 2002:a17:902:ea06:b0:1d3:f36a:9d21 with SMTP id s6-20020a170902ea0600b001d3f36a9d21mr25302192plg.4.1703868770057;
        Fri, 29 Dec 2023 08:52:50 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d3cb4e3302sm15220806plb.214.2023.12.29.08.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 08:52:49 -0800 (PST)
Message-ID: <f1f002e9-8010-4b74-9da8-2551be97fa6f@kernel.dk>
Date: Fri, 29 Dec 2023 09:52:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/block/null_blk: Switch from radix tree api to
 xarrays
Content-Language: en-US
To: Gautam Menghani <gautam@linux.ibm.com>, kch@nvidia.com,
 ming.lei@redhat.com, damien.lemoal@opensource.wdc.com,
 zhouchengming@bytedance.com, nj.shetty@samsung.com, akinobu.mita@gmail.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 riteshh@linux.ibm.com
References: <20231229164155.73541-1-gautam@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231229164155.73541-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/23 9:41 AM, Gautam Menghani wrote:
> Convert the null_blk driver to use the xarray API instead of radix tree 
> API.
> 
> Testing:
> Used blktests test suite (block and zbd suites) to test the current 
> null_blk driver and null_blk driver with this patch applied. The tests 
> results in both the instances were the same.

What's the purpose of the change?

One thing that always annoys me slightly with xarray is the implied
locking. So now you're grabbing two locks rather than just utilizing the
lock that was already held. I think a better transformation would be to
first change the locking to be closer to the lookup and deletion, and
then convert to xarray and now being able to drop that other lock. Just
doing a blind conversion like this without potentially understanding the
details of it is not a good idea, imho.

-- 
Jens Axboe


