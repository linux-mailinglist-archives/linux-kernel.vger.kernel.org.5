Return-Path: <linux-kernel+bounces-37596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC1483B250
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFDE1C22187
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15FB132C28;
	Wed, 24 Jan 2024 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i34wH1Gf"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE793132C20
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124772; cv=none; b=MJJlMAhtWn5ruQsv530TniQtyPD6dghqvtFexfSqvzvxgk0kj48KxZ43+DN7j90y1Jr6Tos49DuymgetEbNUHll/fDXFMqpNiyu7MHaC9AoIedKKY4ND4Ex8D79NFx+xSpF0zLy64OTR3RSB/craqnsfGjWdnlkg1dtJJAeft24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124772; c=relaxed/simple;
	bh=5+VYaSrdLMi/4ObDO+2+rZ4JJbis6pkPuahPWmIZBR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRuEnCXF9U+iLP/64bYrQyEM8/q/B+lFUM+jIgGmapKCp6MF09uD68jL/JfMZJZ8AI2sl9sQOmM2xKG0bVarc+ndOT8S/796mN1lzW7x8FcMgWETzO+WpdlZSKxQ8wq795Gi5vlFSQnaOrxb5l1XxitdqWNzrkJzOOV3q5e/y74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i34wH1Gf; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21486144069so1128697fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706124770; x=1706729570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6WIWhJATA1SsppEYdczg5RfpFlWPa9HCZcE6BQQX/A=;
        b=i34wH1GfFY51F9RWDlc8sEJEZ8soGOflfUdF8UgnymMgKvnwFKDLx4zhBXmr/wm1Ky
         Y4W4njieCHIF4IZ/sgxd51tsNK1ocPxTNAIuni/XnjGp6FOJC8nqmBKgm3tZ+OEM7WXg
         P8tVEMXNNG+HpxE4chZVBdRhOIAGjJEVhRR9eJtZ4Z6m+5gaAImlSGmZ9DyBnKQP0Mhn
         c8phgYctvr7PJnWwaztbntdgS6kr5sCGyQPvsHaJCH3S9SXZVQEP18iMK3vXdw1hh7E9
         E/X5s/fct8/SMQqCcGhTsmUu/Zmh4CHUXKnUJPrUOTEVknYgnDZhW5Hs/7uwb3oUm3vs
         P3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706124770; x=1706729570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6WIWhJATA1SsppEYdczg5RfpFlWPa9HCZcE6BQQX/A=;
        b=OcHabNHF0+fC+ZbZmwC+QB43aleQqE4Ia7J/VWR/Jo2LzryHaIFt1gUNxr5hl3dh7F
         /SIjQOyvKfp05TElyVowBJLmYs897Vchh4rHUrWquIL1c+uebnLyjdE7JCRsyfDu8r84
         qHSU1aih/tx8U6gZDCC9JLCTma6kuvyZmP9V6Op9MU7z1WqNOT2ZbXFA8U7tJhctJwab
         QsX47dz8nRh4E+6JK5NaTnZMAnuuIwIBhZZuNcn90alR2/1s9pf8yZ7Lb3CcROcTXBzf
         p/UOAzMB1QvvubON7hIfuCBSlgWg2nynUDTEum1wp0xKqaQcAmd5fhnzKdxiaKnJf3I+
         SvfA==
X-Gm-Message-State: AOJu0YzSPMX7m3QCywgK4pfT20P7uno/VdzoAtW8zirbGeQkj34eNdrd
	TWrkSOUP9EDs1uTSiuBMaBaoebXA/hqs0POcnoQh0hqYgX/QOUcW
X-Google-Smtp-Source: AGHT+IE0HlVZMXTmSNHVek8JV9LSgIpm+uPZZTsUTtJ7fN1qL7ohm+sLpbuUiJ2/05syQL3PUSz32w==
X-Received: by 2002:a05:6870:5d91:b0:214:c782:8acb with SMTP id fu17-20020a0568705d9100b00214c7828acbmr279168oab.27.1706124769764;
        Wed, 24 Jan 2024 11:32:49 -0800 (PST)
Received: from [192.168.1.224] (067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id o42-20020a0568301c6a00b006dc092ece16sm2671939otg.67.2024.01.24.11.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 11:32:49 -0800 (PST)
Message-ID: <87f86921-373d-436e-93d8-4616a57e0697@gmail.com>
Date: Wed, 24 Jan 2024 13:32:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme_core: scan namespaces asynchronously
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240118210303.10484-1-stuart.w.hayes@gmail.com>
 <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
 <Za_rVS-0MEr2U731@kbusch-mbp.dhcp.thefacebook.com>
 <c05add9f-d375-44a4-a859-2757b19c70dc@nvidia.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <c05add9f-d375-44a4-a859-2757b19c70dc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/2024 2:21 PM, Chaitanya Kulkarni wrote:
> On 1/23/2024 8:37 AM, Keith Busch wrote:
>> On Mon, Jan 22, 2024 at 11:13:15AM +0200, Sagi Grimberg wrote:
>>> On 1/18/24 23:03, Stuart Hayes wrote:
>>>> @@ -3901,19 +3932,25 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>>>     			goto free;
>>>>     		}
>>>> +		/*
>>>> +		 * scan list starting at list offset 0
>>>> +		 */
>>>> +		atomic_set(&scan_state.count, 0);
>>>>     		for (i = 0; i < nr_entries; i++) {
>>>>     			u32 nsid = le32_to_cpu(ns_list[i]);
>>>>     			if (!nsid)	/* end of the list? */
>>>>     				goto out;
>>>> -			nvme_scan_ns(ctrl, nsid);
>>>> +			async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
>>>>     			while (++prev < nsid)
>>>>     				nvme_ns_remove_by_nsid(ctrl, prev);
>>>>     		}
>>>> +		async_synchronize_full_domain(&domain);
>>
>> You mentioned async scanning was an improvement if you have 1000
>> namespaces, but wouldn't this be worse if you have very few namespaces?
>> IOW, the decision to use the async schedule should be based on
>> nr_entries, right?
>>
> 
> Perhaps it's also helpful to documents the data for small number of
> namespaces, we can think of collecting data something like this:-
> 
> NR Namespaces        Seq Scan        Async Scan
> 2
> 4
> 8
> 16
> 32
> 64
> 128
> 256
> 512
> 1024
> 
> If we find that difference is not that much then we can go ahead with
> this patch, if it the difference is not acceptable to the point that it
> will regress for common setups then we can make it configurable ?
> 
> -ck
> 
> 
I believe the only reason the async scanning should take any longer than
sync scanning is that nvme_scan_ns() has to wait on the workqueue until it
is scheduled.

Testing on my system (with pcie nvme devices with a single namespace), it
looks like it only takes a fraction of a ms (100us or less typically) for
that to happen.  Then it takes 6-10ms or more for the actual namesapce scan.

So scanning asynchronously, even using a local pcie device with a single
namespace, doesn't take significantly longer.  Of course I guess it might
take a bit longer on a busy system, but I wouldn't think that scanning
namespaces is a critical path where a few milliseconds would make much
difference (?).  It wouldn't be too hard to make it scan synchronously if
there aren't more than, say, a couple namespaces, but my opinion is that
the minimal benefit wouldn't be worth the extra code.


