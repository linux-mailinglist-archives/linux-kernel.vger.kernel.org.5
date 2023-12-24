Return-Path: <linux-kernel+bounces-10622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3C681D783
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 02:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66EF1F21D76
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 01:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBFA1858;
	Sun, 24 Dec 2023 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Hs9MGMBA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A056915C2
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d410fce119so6946285ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 17:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703381935; x=1703986735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8o58fg24j79Vn01YA7a95D9+0/2AQpw8VoS8XNe4N/s=;
        b=Hs9MGMBAh0niB2VV45B5rLBuMqFTRmDsboBu9nEjEWP1H9ZM45O4KV4U+H10pN98lB
         vaK2kfMxR2iv8FX19uLVp6zf8gTmKtOVDVvAihRDiSMGhUhtW+1UTb8dqJsHNczonTib
         h9Ck1ndDC9Fb3pE1/z3TuyqE9dHPLb70+Lb6IXt17USn8eJ+Gbi9WWtApVb02jhlAqwS
         3V1TCePK3nUWrQYcY7M1Jm5A4rnfMU+l8JSHL+65jIpoTgLrL4Z2HR2InU/5YeWPBNjJ
         9dlqqjA2NX7tQziEVXTW3kajr7Q39eblWrbRWKV6ovdLJsI/mV5wPebY2PywA5wElV8q
         ZQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703381935; x=1703986735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8o58fg24j79Vn01YA7a95D9+0/2AQpw8VoS8XNe4N/s=;
        b=sFzn5iy3YMJAzji0WsiGQV6YvyjBPdH/oqi35yULxw4yMtqMH8ITGGaxlISKWrf6+7
         NH6lebBTgTZTfcBG2RX85/Clp1cwma4KvjnxrHWESkSf7WA//FZlywSP/Po6ay1H+43A
         i0/rMBUFT0nHYBqUnla9m1JowUfE/WA3ENz8lSVpgsXi5gtDcWFM6KnWvTyJ1zrDTE+s
         aiPL5I8vgljAaD+QXZZ+tAVXglzFd+T8GdsprEAYZoQUKzpxFWK66vV5y0N+TDYd051M
         bfJmfvvP+tCGmrxMx/uPF5nedNJq/7UoO7xMO06ofHNSDKkUodAxInDiA7S8cIAhZKr3
         o6HA==
X-Gm-Message-State: AOJu0Yyv9LecoMFgGhSIzicPMWpvEP9EcDVzwuTXfs9uBAtZHLQ1nvuc
	lZSQPnDZtikShfxxEIkdds5nPAkoIZiUbQ==
X-Google-Smtp-Source: AGHT+IGcBRlYvOUeEkZB1lDf1c0cqfAzC1SnR/inTNftXSxRSnKcqY2F7byFuFTF/1FSSlhhHAbEeg==
X-Received: by 2002:a17:902:f68e:b0:1d3:e001:5953 with SMTP id l14-20020a170902f68e00b001d3e0015953mr6700658plg.5.1703381934994;
        Sat, 23 Dec 2023 17:38:54 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902dad100b001d3eff0728asm5683196plx.78.2023.12.23.17.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 17:38:54 -0800 (PST)
Message-ID: <0eef6feb-4775-4249-af74-9fccb093b6bc@kernel.dk>
Date: Sat, 23 Dec 2023 18:38:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] badblocks: avoid checking invalid range in
 badblocks_check()
Content-Language: en-US
To: Coly Li <colyli@suse.de>
Cc: nvdimm@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Block Devices <linux-block@vger.kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Geliang Tang <geliang.tang@suse.com>, Hannes Reinecke <hare@suse.de>,
 NeilBrown <neilb@suse.de>, Vishal L Verma <vishal.l.verma@intel.com>,
 Xiao Ni <xni@redhat.com>
References: <20231224002820.20234-1-colyli@suse.de>
 <A110805F-3448-4A87-AE70-F94A394EA826@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <A110805F-3448-4A87-AE70-F94A394EA826@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/23 5:32 PM, Coly Li wrote:
>> 2023?12?24? 08:28?Coly Li <colyli@suse.de> ???
>>
>> If prev_badblocks() returns '-1', it means no valid badblocks record
>> before the checking range. It doesn't make sense to check whether
>> the input checking range is overlapped with the non-existed invalid
>> front range.
>>
>> This patch checkes whether 'prev >= 0' is true before calling
>> overlap_front(), to void such invalid operations.
>>
>> Fixes: 3ea3354cb9f0 ("badblocks: improve badblocks_check() for multiple ranges handling")
>> Reported-and-tested-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Link: https://lore.kernel.org/nvdimm/3035e75a-9be0-4bc3-8d4a-6e52c207f277@leemhuis.info/
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Geliang Tang <geliang.tang@suse.com>
>> Cc: Hannes Reinecke <hare@suse.de>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Cc: NeilBrown <neilb@suse.de>
>> Cc: Vishal L Verma <vishal.l.verma@intel.com>
>> Cc: Xiao Ni <xni@redhat.com>
>> ---
>> block/badblocks.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Hi Jens,
> 
> Is it possible to take this fix into 6.7 still? Thanks in advance.

Yep, we're still a few weeks out, so not a problem.

-- 
Jens Axboe


