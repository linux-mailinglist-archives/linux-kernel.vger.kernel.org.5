Return-Path: <linux-kernel+bounces-141803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3C48A23A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F20B23768
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9861DDD3;
	Fri, 12 Apr 2024 02:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyGtoZ8t"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3571D2EE;
	Fri, 12 Apr 2024 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887630; cv=none; b=rSbh4AG/nwadUMssYqIakgPByy5oxqd6aFQzKl6drDTD8/ukkZcVRTjutOdXNbQnUxzj4abujlHLF5RmauJSlkjDx5lB3UZw5mt4F96h+K4BQ90WvyFUsGV3NUHDto4FmO2fEMo212Ci9kGYsafWsKxVzauEUprdyuIZwUfDvx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887630; c=relaxed/simple;
	bh=60BZzF8BNgSsUgTTshvUxN8bG3W4By4BvdyfWmqvgOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b+HnRHXOLwtFg6zhOYQSW5oLSLaCOSvZC0ZaIchlqL0RlCEMYq5ACMYZUSwbm46JxhAEYAQC7bX0G5YWwD5ZLV6gn5yH2panuNPFCvgLsscUP99YztcrHEIBI1BhljuwwItVaiZ9+tTW4sqJOUB/hfF6IiGVyboKWfMq/qWWOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyGtoZ8t; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ea0db2727bso288707a34.2;
        Thu, 11 Apr 2024 19:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712887628; x=1713492428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BI/E4xZpsZgGvOK+0fbls7pB8r+Eacn0LRNQzVubPRc=;
        b=JyGtoZ8tzMgcZ/c1/p3IL09+AucJjzExFIQySIwGPeZbvX8ZIWUqX8oR+pupBCEpaM
         BG8Cmx71V68pwMrGJqysTqeXOn9IBnfhYrL5FZqhpUv9laG25LIO9U3GpV9PMD9DOj9o
         h+CtW7LUR74nNDCYukmYyO8o/vvl22rkZfOeWDpn7Gm7b09zijq5oi8C97Z9n7VF4JEy
         ELnT46BTL+VbB7sOjAG/CbtOGMFuHvKbbwvgW+K4y8gucE1fSaLSRBYcGPPTiV9fQatq
         SwcOuNP02BPEEAhK0g8VkDd5JqsaAf6WhLi+zsGRHSOBLM/5z1jF2oL0GAfV7qhrmZn/
         ASsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712887628; x=1713492428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BI/E4xZpsZgGvOK+0fbls7pB8r+Eacn0LRNQzVubPRc=;
        b=h1p8cR9csLQMfgK+91sHAV7ksxx/cc5Cid7JMAZmTsV86OIHGGXoEBbXizmP4p4Odx
         iF8hA+PVtYUfZp50RklQPCpHtt9cKsYuwRzqshMi3Z6LVQecHS+NE+wTbHCyQXj7wpK0
         Lg0PywqSm9mBTaJHe2QqiklJ7pgDob/KA0Ifc7NSPpEDmJdYujMUqxhyO/frSJNDUtVQ
         f7Efsl7VyzT/IG5xJhapxNXuu7tLI7j28GkabNYYBNbEXezD8tuoKDsLyFVkgVbDIcEo
         MRd+bZoRxSj0lkfoCv8jaklINeb8Si4yefPIPZfNnmp+87LdrTr7I1tHEol9xhkUjRNp
         xIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpi7yeLeUOLm/DgHhq9xxtbUq13N8gaIN6WE6cVR8mqBS/h9hW/RCZJTocc5vZznPGL+8VBY04iZJU3eRvoiZx0MZDCD8vV3leZfJPO56KQ8tj0abos+LvJWR+52VHpYXCb7FtAZGbsw==
X-Gm-Message-State: AOJu0Ywtwoe2kvo5XsTeP/37F9kh5x9pFFK44BmQ2GqQp/KWX/bi8Alu
	1OvAn6jd7stU9qCtGBUZkv2XOLhp2q4OJXaGEctZE8n8fWnW+uPRRTcUL2M+8fk=
X-Google-Smtp-Source: AGHT+IGD1Sj1bKaeH5/O/xGy5IGnCY8RQ9f3vi5uEHbe/PSg7XznxaGVbElrhYXXN8TP1t5MUScWIw==
X-Received: by 2002:a05:6830:1311:b0:6eb:5c07:5098 with SMTP id p17-20020a056830131100b006eb5c075098mr587399otq.4.1712887627713;
        Thu, 11 Apr 2024 19:07:07 -0700 (PDT)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id bx33-20020a056a02052100b005f0bc6d04adsm1492781pgb.46.2024.04.11.19.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 19:07:07 -0700 (PDT)
Message-ID: <2c1a070d-7595-4a7b-a234-99e2c56d801f@gmail.com>
Date: Fri, 12 Apr 2024 10:07:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] SCSI: Fix issues between removing device and error
 handle
To: Wenchao Hao <haowenchao2@huawei.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240307144311.73735-1-haowenchao2@huawei.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <20240307144311.73735-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/3/7 22:43, Wenchao Hao wrote:
> I am testing SCSI error handle with my previous scsi_debug error
> injection patches, and found some issues when removing device and
> error handler happened together.
> 
> These issues are triggered because devices in removing would be skipped
> when calling shost_for_each_device().
> 

Friendly ping...


> The issues are found:
> 1. statistic info printed at beginning of scsi_error_handler is wrong
> 2. device reset is not triggered
> 
> V4:
>  - Remove the forth patch which fix IO hang when device removing
>    becaust the issue is fixed by commit '6df0e077d76bd (scsi: core:
>    Kick the requeue list after inserting when flushing)'
> 
> V3:
>   - Update patch description
>   - Update comments of functions added
> 
> V2:
>   - Fix IO hang by run all devices' queue after error handler
>   - Do not modify shost_for_each_device() directly but add a new
>     helper to iterate devices but do not skip devices in removing
> 
> Wenchao Hao (3):
>   scsi: core: Add new helper to iterate all devices of host
>   scsi: scsi_error: Fix wrong statistic when print error info
>   scsi: scsi_error: Fix device reset is not triggered
> 
>  drivers/scsi/scsi.c        | 46 ++++++++++++++++++++++++++------------
>  drivers/scsi/scsi_error.c  |  4 ++--
>  include/scsi/scsi_device.h | 25 ++++++++++++++++++---
>  3 files changed, 56 insertions(+), 19 deletions(-)
> 


