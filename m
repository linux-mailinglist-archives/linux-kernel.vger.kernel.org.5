Return-Path: <linux-kernel+bounces-134868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1AE89B80D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C18281BA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28C820319;
	Mon,  8 Apr 2024 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErgarYKi"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FD1BC39
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559652; cv=none; b=C3cNypXbQBNMKfgRF+jn6GiJoSHIt+3Da5YzAibvhV3Gh4Q3qr+r75HwbHvNdh/ujrCx/Rrd71pvEX4hGIefOk9CVlhRLM4/twFLWcQg0LaQXaIYsk2wYulWHbXak8m9omCXh8jia35HdtfYunKWcqqaW9WhQe0ul70Ha5x753M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559652; c=relaxed/simple;
	bh=R86mcNW+LI7N1+akwgJlATMGmJk41D1KML7co6XT7ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwa6tJ92msfNJteAEp6hoDkJZSE2V1xz2JKAYLQPM4ph+0Uylf9oPG1Es+s7vJIsTpcCCo7l/ibsWyXNir4X9i6Bd/O44K6VhMVul/VZzyOe/nNo0gx8n6xlnnFqm7H/++ar2ufBZyGzbVOMm3S0xsrACWz8Tb4dZdEOPvJOoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErgarYKi; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecf1bb7f38so2703330b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712559650; x=1713164450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CY9C66wsjL0ewJNgfMPGlt1GE5TAeprjU8e3L87Pn+Q=;
        b=ErgarYKiSJM4grpPlnY3DLQSRzTcOeVL0zZpPajieBoKsbukf/N+i5x/bwQUmOIFcq
         GisdLr42/fYifcsF3UbsDvPDIluux3gN6olFJazKeGMkmh09hjr4z7atVwSLl1bqn5BW
         o/jk3VjQyTsr7t/8huCm4frmhOZt6W+ez7cligiNS9x5a3IL3VXXzVxZxE9aQASpE/Aw
         boh4K8SYYSSYWhyEG7+7Z9q8rQu3wSyVL4jvH03UL974isHCQ5rVCNZ0Ba7tQoCHfpjf
         jsxTObVR/WfImhD9wHwE9F2jm+XbVWnQ+jXROlfRiGmiJeXOQ3Q4QeYZinAlhyAqxhGV
         ZMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712559650; x=1713164450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CY9C66wsjL0ewJNgfMPGlt1GE5TAeprjU8e3L87Pn+Q=;
        b=b36eMdyYUWamn/loMSH++EErQ3Kl4MshRg63tf79AL1mfymMw3L5VMSORa6pTk3anI
         3tQS95lmY2sauZD86UCuf8by2rr3rklldLLK61vH1AQmsGlheV6FFUI9ATHEpD8AmMvo
         BJVNGbSaEZArXbkbYXuFEAsprbMVIIGfLW/nw2NTNjkcoYb5VJQ3przaxnzGCHeHBoMW
         itbQPNfdazoo+EzfZDajeFXRQofKnZJLwczBtPoaT6CvZuSuVlCo0gKgrvXGWqPDKyn5
         k3qTl7kUozHHVFThARstRSp0WAds7Kt7uqCsHjc/ufqXCjguNIvKjGMeBwZ9TuE2AvCe
         EA4A==
X-Forwarded-Encrypted: i=1; AJvYcCWbN5X1qBPOH7rLM30mrkIQAY5Gthv22Xnw2HF1/YiB8oW92ZgfwlT99Piif2mfvTthmo69asymfXRdXXAFJz8z6K2oG0e07ClIEgtk
X-Gm-Message-State: AOJu0YxZ1OplElRA9iuwVpB1nnymXeNSwWgfxz3InlCjldWNvPS6O6ZX
	NbKluVZ3R4ywUUIvC/gF0dx12JlAQfMjx8jR7N9DEL+xbKPlw9fS
X-Google-Smtp-Source: AGHT+IGHtcVp3ZqgHgUkHIxLmpZXlLwJJR0ZD28k7oSjCn8LRXSmxh9c5z8PqU0+47vfMmunNyeVjA==
X-Received: by 2002:a05:6a21:3e05:b0:1a6:fced:424f with SMTP id bk5-20020a056a213e0500b001a6fced424fmr6264155pzc.62.1712559650057;
        Mon, 08 Apr 2024 00:00:50 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001e4565a2596sm475190plh.92.2024.04.08.00.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 00:00:49 -0700 (PDT)
Message-ID: <6f8ab03f-7755-4044-81a1-6269aa9a62ed@gmail.com>
Date: Mon, 8 Apr 2024 15:00:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] mm/ksm: remove set_page_stable_node
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Matthew Wilcox <willy@infradead.org>, Andrea Arcangeli
 <aarcange@redhat.com>, Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryncsn@gmail.com
Cc: Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>
References: <20240325124904.398913-1-alexs@kernel.org>
 <20240325124904.398913-15-alexs@kernel.org>
 <ad50bc5d-d2be-4017-83e7-6fdc45ac1659@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <ad50bc5d-d2be-4017-83e7-6fdc45ac1659@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/5/24 3:32 PM, David Hildenbrand wrote:
> On 25.03.24 13:49, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> Remove the func since all caller are gone. Also remove the
>> VM_BUG_ON_PAGE() because it's not applicable for a folio.
> 
> Ehm, it is for small folios that we are working with here.
> 
> Please keep that check and convert it into a warn.
> 
> VM_WARN_ON_FOLIO(folio_test_anon(folio) && PageAnonExclusive(&folio->page), folio);

will take it. Thanks!

> 
>> -    page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
>> -}
>> -
>>   static inline void folio_set_stable_node(struct folio *folio,
>>                        struct ksm_stable_node *stable_node)
>>   {
>> -    set_page_stable_node(&folio->page, stable_node);
>> +    folio->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
>>   }
>>     #ifdef CONFIG_SYSFS
> 
> 

