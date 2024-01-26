Return-Path: <linux-kernel+bounces-39952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AED383D7C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8711C2F7E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995656DD1C;
	Fri, 26 Jan 2024 09:41:55 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBB29CFD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262115; cv=none; b=B55idaU/77Wn2mPECqIraW5YVPpkRvdipaF0g+6W3z+E8nMvJatHSocyfDEs01C1J5BEdmxUYB31JrqvJv/X2JtRce3QeB6pPZq1Cu2CkIOAUV2H2nJa4eYxkB1QNBR+dAW8eryLHco0kAqgt+6TD9MZK8xmJW6unv4UsfZ/4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262115; c=relaxed/simple;
	bh=U2KRMisioCc1e2iHi9FzOUiBvCACERMR+bwijZX2bnc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V9gulBUUxDC/MX/vEqdEX4gx490Z/Y+GR2dHhv2eRQHxpxUkMN2MgPKrnvZNqWhLROPAmMRyUouKMc9w3q9sfG8g5cVtJF7yeggBIs7QlQwgx/BkG9PkIX2u2qQXShuHr7WuikrawpbqX7LDHgJOWIs/CJglgSSJE6GISeJS+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55cdaa96f34so3082880a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706262112; x=1706866912;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YzzmD/zSUVKR8z+zYD1/Hh2OhOIaQby83Sn0quY0TU=;
        b=HGEyezejMbOif6pQrtPbdrUHH1Ytz8W/xJislY6jKTF6GVYLO0gWIzgIT+DKXu6owv
         5WSdu+WYEqIgX1Jyg4IETOe3cK4sL4w9nzipwhP2dGEk4yql3QVFYzt9vN5ZjyvAek5D
         A5lIikWRbckReNftgIjLRse119Rro14j/848aQOKDun1fPtBJiaQrmItdULPvDXDmrMV
         /Xv3tyD35zh4wiItmv+9R6ZYNnGI6kCTq3+r4n7T3mgFBApf+f8KCfEGCGnjfZhf4Rrt
         xcY6h0kze7zsJmMIgjS6qhpDYnJHLR+VA0fC0TZTPHHA7GBwl+wBE964zw5HGUE7ZG3q
         KKew==
X-Gm-Message-State: AOJu0YypqRNaHVkdlhM2AgoHskXbJw4LPXKrdcay0wrDGl4SwUJU9lC3
	Td1FUM80aR+0TiTJfun/p7DZIPgOv8OBVmvwfMlwJB5Cca0eaRke
X-Google-Smtp-Source: AGHT+IHsbiDe5EEckDL3MSORIWfVdvqB33J3OrMlcOqnBs6nFqmVk7zjTk+MRhVS8q7h2GhzRSz7Yw==
X-Received: by 2002:a17:906:ad4:b0:a31:8944:2cf6 with SMTP id z20-20020a1709060ad400b00a3189442cf6mr551837ejf.8.1706262111426;
        Fri, 26 Jan 2024 01:41:51 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id gx3-20020a170906f1c300b00a19b7362dcfsm427085ejb.139.2024.01.26.01.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 01:41:51 -0800 (PST)
Message-ID: <de249ba0-6efa-416a-a1a9-59c47d71cbc9@kernel.org>
Date: Fri, 26 Jan 2024 10:41:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
To: akpm@linux-foundation.org
Cc: surenb@google.com, riel@surriel.com, willy@infradead.org, cl@linux.com,
 yang@os.amperecomputing.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Bernhard M. Wiedemann" <bwiedemann@suse.de>,
 Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>
References: <20240118133504.2910955-1-shy828301@gmail.com>
 <ZbIhoj2PzD5jIdSn@tiehlicka>
 <2afa54e6-90db-4ae0-a21c-78e5051aa83c@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <2afa54e6-90db-4ae0-a21c-78e5051aa83c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26. 01. 24, 10:36, Jiri Slaby wrote:
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -37,6 +37,7 @@
>>>   #include <linux/page_owner.h>
>>>   #include <linux/sched/sysctl.h>
>>>   #include <linux/memory-tiers.h>
>>> +#include <linux/compat.h>
>>>   #include <asm/tlb.h>
>>>   #include <asm/pgalloc.h>
>>> @@ -811,6 +812,14 @@ static unsigned long 
>>> __thp_get_unmapped_area(struct file *filp,
>>>       loff_t off_align = round_up(off, size);
>>>       unsigned long len_pad, ret;
>>> +    /*
>>> +     * It doesn't make too much sense to froce huge page alignment on
>>> +     * 32 bit system or compat userspace due to the contrained virtual
>>> +     * address space and address entropy.
>>> +     */
> 
> FWIW,
> Bernhard noticed that "froce" and "contrained", could you fix that 
> before applying the patch?

No, you can't:

1) it was merged to mm-stable already, and
2) the comment is not in that version at all [1]

[1] https://lore.kernel.org/all/20240126075612.87780C433F1@smtp.kernel.org/

> thanks,

-- 
js
suse labs


