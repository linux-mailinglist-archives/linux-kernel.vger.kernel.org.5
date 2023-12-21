Return-Path: <linux-kernel+bounces-9122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845DD81C0DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13ECFB24EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276A77F12;
	Thu, 21 Dec 2023 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4y5MOoC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4977B5A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703196901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bVdjQS4hLyLV+bdFjcapcMlWx8N/dAAt7JmCOF2+wJI=;
	b=J4y5MOoCErisEwTL15bc3ziZdbXwesbL0HgklqTJ0nmxwzo+k6O6EfcvyoWNGrFC0Pq7LI
	H3/lP7SgDWQlLZiAdY7tPBEYSr+U1BRjUOCQvYO0Vi3uTN2akzEOL63kwVpuNR5d9nqOD2
	WMjV/rJ3zaSs4/LVtTKiGdlR6l5F9HA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-JZrw_nlNO5Ce6nAZg9vuWw-1; Thu, 21 Dec 2023 17:14:59 -0500
X-MC-Unique: JZrw_nlNO5Ce6nAZg9vuWw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c348e529fso10769795e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:14:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703196898; x=1703801698;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVdjQS4hLyLV+bdFjcapcMlWx8N/dAAt7JmCOF2+wJI=;
        b=NgQ20q8SWlQPWX1BYIPp/Qm0KjIUX6izYSeeb5K3gPLT6UnNVj2bb2xfMYDsZN26u2
         qj31R1ljSs9WBhNesJBiiuiFabwqS2JOCyRgAVKL++pPLXWjEo80mug9Z0qpPgKkMhNH
         DqwKRI+W6UkpYWs+6yzbcHwZazmjPQrI1kp2X218Ofeo9+JLlUk/hWF/DvxX9P4KCh0M
         GlJ3g4v06pBYeyIh/wD0fTGy8j+BV5G0qLffZAjYfFjmkDCv7LjWbTsgU28HIG8609gK
         8LDZJPFNl7limqy0tv9u799wj43RUzl+mtdv2DBcSBbSP3M50kPfS49UIu0G6V+8ckm7
         9g1w==
X-Gm-Message-State: AOJu0YzgQYZDkM6Eb2T91ndHYPukoPvrvPotSJxIB8VcBS/ByOGzrjIc
	B/Rql4jXQORR4jjH8ZFN5mTwYmpwXR2t0UQjiY2VqmtBYgHZ7qWEQJyQmGviv1OizouXTnaR8IX
	gjXeqdnNOmnOxhfLpKmFy6QDfJUeOh1oS
X-Received: by 2002:a05:600c:3b94:b0:40d:3718:79fe with SMTP id n20-20020a05600c3b9400b0040d371879femr208213wms.85.1703196898511;
        Thu, 21 Dec 2023 14:14:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEgxlArx406uMjJRHdfCb+7mpOwN6AmGIPkZmYui89A/XWkJqS6YVfIdTBX9XmfLW0txGKXA==
X-Received: by 2002:a05:600c:3b94:b0:40d:3718:79fe with SMTP id n20-20020a05600c3b9400b0040d371879femr208208wms.85.1703196898099;
        Thu, 21 Dec 2023 14:14:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c743:7b00:745e:8663:4f85:318a? (p200300cbc7437b00745e86634f85318a.dip0.t-ipconnect.de. [2003:cb:c743:7b00:745e:8663:4f85:318a])
        by smtp.gmail.com with ESMTPSA id u4-20020a05600c138400b0040c03c3289bsm4750029wmf.37.2023.12.21.14.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 14:14:57 -0800 (PST)
Message-ID: <c6bb4890-48cc-436f-94d7-6a9ac9fe7611@redhat.com>
Date: Thu, 21 Dec 2023 23:14:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] bbcbf2a3f0: kernel_BUG_at_mm/memory.c
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
References: <202312192319.fa8f5709-oliver.sang@intel.com>
 <20231220141135.cb4241442b657104f0aeae34@linux-foundation.org>
 <ZYQgGmYNfF8j4JqL@xsang-OptiPlex-9020>
 <e0e7d631-0af4-46fc-b606-78de07ebb88a@redhat.com>
 <20231221135833.92b8b2a97b28ad0545977f6c@linux-foundation.org>
 <6a8f2110-fa91-4c10-9eae-88315309a6e3@redhat.com>
 <ZYS4kKr5gyszanRv@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZYS4kKr5gyszanRv@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.12.23 23:13, Matthew Wilcox wrote:
> On Thu, Dec 21, 2023 at 11:07:21PM +0100, David Hildenbrand wrote:
>> Subject: [PATCH] Fixup: mm: convert ksm_might_need_to_copy() to work on folios
>>
>> We must only adjust the page if the folio changed. Otherwise, if we
>> had a large folio in the swapcache and the folio didn't change, we'd
>> suddenly change the page to-be-mapped.
> 
> Heh, I was expecting you to be done for the day ;-)

I was expecting that myself, but here I am ... :)

-- 
Cheers,

David / dhildenb


