Return-Path: <linux-kernel+bounces-112021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2E6887442
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BB92841F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952527F7ED;
	Fri, 22 Mar 2024 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAU+Yiox"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3345356B78
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711140796; cv=none; b=ghGojgDWMuCs/8+touPC5Lv8CLXoIv80JXU4wmqbKISoeIIdzpspMNDo3AxFwz2zgoO/8B9i5ICDkJzkWbd3rq3dMnZa8PU5dztNf7DNXkrtlYUd6ZLV5NT64Oqt3XUyV/kkSzBgZyuWh5DtWWi6Huu0XQfSxdqOvF+jQmvHYaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711140796; c=relaxed/simple;
	bh=yD4GxiI8BItI/TqD/6wjK/ShBvThgA8NijIdOlE+Xkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FiVWmYQB28PWWSdqbH1+nw145DjucV2IlRz1nx6moQZZVbigD5gS+DQP+utgjVmReP7zaWNRnngjtZ3LQPPkYKRZw6PmBbLp/UgxpavU93zqW4s+mNVYQOO73qhTNzo0gSwRL9wafWwMuU9PeLJWgSYuRrsHiIeMlclGIyF8TVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAU+Yiox; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso1646004b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711140794; x=1711745594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ci1T0W7hck2YDPEEoQkTjQlEo6sqEjsMAhRmZZatUaA=;
        b=eAU+YioxdTJPgZU5Vsq+EVSGvhcjwTQYIzfpdW/uTquqwNFz556sQLmFG5xq7ZFoHK
         UQPwUM4Isv97wXjilR1Q+TwXf3Nz/TGtfcFTWYyEtTuJhASWMWikr7R6JJlz+1PuqSgz
         HGeUP2bfUNRK3EzxL/tCdsLBtg5kuDp+DCHVny431J1e5/raGWSJ4gM/H8v97z08Ngsj
         9kvwjOQ9xLnR1dwx0GYyTByfdpfTkcHm3K1yGtpVPyfgVCZPrVd4OvJkzSMF/DzjDSCc
         5aHXN622vgQsjJNnSM/K+Jh/WuacRvzUGv327Qgj8UiJ2oIFnCHnXXsoZYjxHoPseRWr
         sFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711140794; x=1711745594;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci1T0W7hck2YDPEEoQkTjQlEo6sqEjsMAhRmZZatUaA=;
        b=jD85ciYaWFN+ruPQyBIjaeZn7TSXp180mszBWLLm5iJRAKVhoX2kn9NPCDS/8bsjze
         HcvK+8dV8KBxw0HUz0IlmuZ1Ie5Vtl5oZMpN8vNanxvMe6boOf21Z4BhePzeOT0eqE9Q
         7fwpgpkKGb2SQnIAS4CZuLZrIbWFPIUShCFa3h9O7oHwJYmS7RgSK1IQ9ZsimBta+1Af
         YDnBJFOBE/9NbHjeQksMwa8WVse/KIoSLyT3PsApTbhCzZRnpnYvS7M1iplg8pjwCwjw
         BVNWVPL//OvuVZprnSRN8i+NiuvdwQqNNfk29AdGqWPLi2vxoxb3Pp5H650tSw45qceW
         lWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMIqKOCr23VFQWahxFIGMg/e1944fk8UhC6W0Vs3G3L1Ml6ZW1O0FxcmWSmj2+7X5AXQr3pWnpYeb+wiEpOATRA7vnzTUz6VmIzoos
X-Gm-Message-State: AOJu0YzVtx5Fpd+8sZmwTOGLY0RSmBGqQ3DKt6xMO92+SNk893I7OPhP
	PYr4PRvbDXjIaWqrLwjyX/loQj9RLX8uGES6/il7lh6/0Dr86RL2
X-Google-Smtp-Source: AGHT+IGzbb6BRlw+sy6n6iVQGjf4HspvTMOXed5T9+PIxurbwnlMY4FuWkEujFZh8WI/7vMrZjvdqA==
X-Received: by 2002:a05:6a00:2d04:b0:6e7:6bc4:ef8c with SMTP id fa4-20020a056a002d0400b006e76bc4ef8cmr147113pfb.3.1711140794414;
        Fri, 22 Mar 2024 13:53:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a19-20020a056a0011d300b006e740d23674sm194098pfu.140.2024.03.22.13.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 13:53:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8d0b5818-b3dc-4211-8cdf-92e7b76e0fe5@roeck-us.net>
Date: Fri, 22 Mar 2024 13:53:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Content-Language: en-US
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Dave Chinner <david@fromorbit.com>, "Paul E . McKenney"
 <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
 <bbc242d5-3ab0-410f-a3b1-54a68e3e375f@roeck-us.net> <Zf3V6B9f5o0H1LnE@pc636>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zf3V6B9f5o0H1LnE@pc636>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 12:03, Uladzislau Rezki wrote:
[ ... ]

> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..0d77d171b5d9 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2343,6 +2343,9 @@ struct vmap_area *find_vmap_area(unsigned long addr)
>          struct vmap_area *va;
>          int i, j;
> 
> +       if (unlikely(!vmap_initialized))
> +               return NULL;
> +
>          /*
>           * An addr_to_node_id(addr) converts an address to a node index
>           * where a VA is located. If VA spans several zones and passed
> <snip>
> 
> Could you please test it?
> 

That fixes the problem.

Thanks,
Guenter


