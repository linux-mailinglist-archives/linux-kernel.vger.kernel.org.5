Return-Path: <linux-kernel+bounces-155395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481848AE9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37537B21512
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD1513B590;
	Tue, 23 Apr 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWbbKtvH"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC108F5E;
	Tue, 23 Apr 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883610; cv=none; b=dEZeWkMq2nsCZJ/nUKUbv3x65aeXG+GofpfnWtw8iOckCpcsX9D9xe3M3nYaEFIMPZhjAaEAOkfz7bD9B8ran+DV4+c8BdIn06vFAH36yOGzklmVLyH+2CFQgoqqPZTXXYv4Q/hybucWEPJ6WRYWhZegIrtsZE8hzn/ws+lW+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883610; c=relaxed/simple;
	bh=ToGncwj89AClxloq2GR3iiMSNF1CUJnuDODivUGYRAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mA7QD4hK2Hj1Ng+BY3LoPVFeWioVIPD3uMOZnuaiUtFD/uSJ2HFAiHrLN0/cMtqb55HTYtvUgeqTaVHC6yatAK7hZB59zc6RYUWseWHM+TpNd9vwrUoE9j0p2/KGyB/KD0OUrD3obY1zMvdEt800b7lDqvenBt5cI1XjClW0vRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWbbKtvH; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f103b541aeso2862068b3a.3;
        Tue, 23 Apr 2024 07:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713883608; x=1714488408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vb/jtEQiqMYQ/ISAQh9mg0MTb6zQnFx3hOrCArI3w1E=;
        b=DWbbKtvHDAMwRw51MQT/rsxrsRjCAkZaOczYUrHsiLHWSnc+6qxwEdTC0m1THnAbcs
         3vrCdNWRkhImjZz2HbxRg0+2ddHQNoQUCLbExcy0baU4PpTZvnZ8Q/WeSY9TeQjkFyRg
         xebZuErcwDN8h2O4GcIQHHUYPBgzapZJ+yTHTx5BPc7hsB5H5ZeXxv1OgwFNBuSRqdDD
         vYKHfE7rTz0trpu+m49fUQXPAddmOsK01hnT+UEbygM3KMG/Ini1bmApMbBdnoRX3Ucs
         YQnvw7frWjb2uaPFQq7jGTmOnDhuRdriHYNEnadW60flv3rJkxaNdekV9JK6Kj7kx7UU
         889A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713883608; x=1714488408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb/jtEQiqMYQ/ISAQh9mg0MTb6zQnFx3hOrCArI3w1E=;
        b=Yj22KoMIMbgR3Qt4ons/OSTtL79sRiKf30ppw4o+hxnJ3LzI37aZdhgZFJKaoPGNCz
         HaRoN7h/noRo3Bf3bfaJWIHAcY6GZZSTK5aSMBeHnyZ6TzfEDxRGdELqikZ01xFZQfy6
         Ip2l2BBmg/gLzYHdRI9CSbyaF8AmUXE9fSjRodiSgdVjOojiOHY7OaYitABq2k86giUE
         mVDGoBiS+5GdRU9cH0dVW34srmS90fpo3LOQZTo1MG/lcVh8n6Cu//PMydchTmTAdVlH
         P2wExGYCvu7wLm57t4qLpC14dk56syTsSEgy9XmuYnNi6/nDjnv9bkMIVS2NWBnFFHUK
         zOUw==
X-Forwarded-Encrypted: i=1; AJvYcCVRzvOIiYB6u8nwICMC6ZzZUji5PAbn+LrzPcm6x8WGnD6VwXCWLto2OIZQ85c5SSv4Y6WkZBnNA2a2vz8tUC4aq7PfKBbO9olXFmMTJ/4fCQsaebRYowM7S54AAi4GrZEqf0Cm4KMHzIMmqwqwGO29rETmmSoyQlimwz636I7LHJQ4okMpfhfQy0d9D9xQqnbv122rcC3Fq7fCIUI=
X-Gm-Message-State: AOJu0YwsAvAFBdyeplJDKZfEUMnuEjpWKO7d94MQDWZXpcqQioLBROef
	uBdvNym3121+/kUAnQYqdid2a1rB/H6C+I1wMMeeSa3ed0yYK/Of
X-Google-Smtp-Source: AGHT+IE1b3OGo1AOOyHI2O/gtQLNNZdbLcFXucTipISHaNiAukcRoQ6PFKyPGYCIilU3YAqWXr+loQ==
X-Received: by 2002:a05:6a21:2792:b0:1aa:6a28:cf6e with SMTP id rn18-20020a056a21279200b001aa6a28cf6emr12043604pzb.48.1713883607972;
        Tue, 23 Apr 2024 07:46:47 -0700 (PDT)
Received: from ?IPV6:2001:ee0:50f5:5d0:b2f6:b23d:3030:9638? ([2001:ee0:50f5:5d0:b2f6:b23d:3030:9638])
        by smtp.gmail.com with ESMTPSA id l185-20020a6391c2000000b005ffd8019f01sm3689182pge.20.2024.04.23.07.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 07:46:47 -0700 (PDT)
Message-ID: <e4f5cbd0-c803-4c3c-9703-f52e56864106@gmail.com>
Date: Tue, 23 Apr 2024 21:46:35 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drivers/s390/cio: ensure the copied buf is NULL
 terminated
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
 Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Krishna Gudipati <kgudipat@brocade.com>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Fabian Frederick <fabf@skynet.be>, Saurav Kashyap <skashyap@marvell.com>,
 Javed Hasan <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 Nilesh Javali <nilesh.javali@cavium.com>, Arun Easi <arun.easi@cavium.com>,
 Manish Rangankar <manish.rangankar@cavium.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, Saurav Kashyap <saurav.kashyap@cavium.com>,
 linux-s390@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20240422-fix-oob-read-v1-0-e02854c30174@gmail.com>
 <20240422-fix-oob-read-v1-5-e02854c30174@gmail.com>
 <20240423065052.10211-C-hca@linux.ibm.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20240423065052.10211-C-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 13:50, Heiko Carstens wrote:
> On Mon, Apr 22, 2024 at 11:41:40PM +0700, Bui Quang Minh wrote:
>> Currently, we allocate a lbuf-sized kernel buffer and copy lbuf from
>> userspace to that buffer. Later, we use scanf on this buffer but we don't
>> ensure that the string is terminated inside the buffer, this can lead to
>> OOB read when using scanf. Fix this issue by allocating 1 more byte to at
>> the end of buffer and write NULL terminator to the end of buffer after
>> userspace copying.
>>
>> Fixes: a4f17cc72671 ("s390/cio: add CRW inject functionality")
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/s390/cio/cio_inject.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/cio/cio_inject.c b/drivers/s390/cio/cio_inject.c
>> index 8613fa937237..9b69fbf49f60 100644
>> --- a/drivers/s390/cio/cio_inject.c
>> +++ b/drivers/s390/cio/cio_inject.c
>> @@ -95,10 +95,11 @@ static ssize_t crw_inject_write(struct file *file, const char __user *buf,
>>   		return -EINVAL;
>>   	}
>>   
>> -	buffer = vmemdup_user(buf, lbuf);
>> +	buffer = vmemdup_user(buf, lbuf + 1);
>>   	if (IS_ERR(buffer))
>>   		return -ENOMEM;
>>   
>> +	buffer[lbuf] = '\0';
> 
> This would read one byte too much from user space, and could potentially
> fault.
> 
> Why isn't this simply memdup_user_nul() like all others, which would do the
> right thing?

Thanks for your review. It's my mistake, I blindly follow the pattern in 
rvu_debugfs

static ssize_t rvu_dbg_qsize_write(struct file *filp,
				   const char __user *buffer, size_t count,
				   loff_t *ppos, int blktype)
{
	cmd_buf = memdup_user(buffer, count + 1);
	if (IS_ERR(cmd_buf))
		return -ENOMEM;

	cmd_buf[count] = '\0';
}

I will send a patch to fix this too.

For this case, as the original code uses vmemdup_user, which internally 
uses kvmalloc not kmalloc, so I try to keep the original behavior. And 
vmemdup_user does not have the counterpart vmemdup_user_nul. I can 
kvmalloc(lbuf + 1), then copy_to_user(lbuf) and set buffer[lbuf] = '\0' 
or do you think I should create vmemdup_user_nul?

Thanks,
Quang Minh.

