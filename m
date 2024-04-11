Return-Path: <linux-kernel+bounces-139816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A968A080F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E7F1F23586
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B913CA8A;
	Thu, 11 Apr 2024 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv3f7mk1"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322C13C3ED
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815690; cv=none; b=gVO4JfOsua8Hh2i3zKhpKrXZL05W1PDOGvl1vzs6yDI/IupkkyPcgWi7MevriMOX3FVKaAITTEzT0bl1OlzgEoemLiCZxlBl5dtsHasPuSmuaGdab0dJwAUp9EVig4DOrgE7JNOfEoj+7T8TdpWWJigCJDBLeh6cJFTP6og3HnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815690; c=relaxed/simple;
	bh=58UvdS8ZfA6eWD25sHs7xxDVreHwP8mfoOfe+ZM66Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihdioSyM4k4nH12kHNeNaE82PG9Da8OY+BzgOQKrRBF4qtjP0Y3ejVuJq0alRoH+h1q0xCSBoenuPSe97JdkzBb6/Uk7cMXj7tRyxxTKLUCrZLZ66mKtoM/0eRg6WXN/dZk5mRaPj1nHYy0O+BPmJE3qCUawaQqtM+XQ31Y3IJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qv3f7mk1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e411e339b8so31740335ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712815688; x=1713420488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/iT9IlAymUCb2pC4/RBQKOmj3d7dpo0oLb02XVtYzR4=;
        b=Qv3f7mk1hUIoX1zPUs4xwOoZQADW+Tek1qArgx0KpZMwr6iObjYa2Z2J0oGGNgQ+mR
         RmArN6L6BiR9TGLWvdw1KZyy4GN6ZhPCOsXeXddu+oxqwt0uoSTeEi/4uOIHQ6pCISz6
         T1rpaWJxmEhk61TtkOsdB+R/60xxMxmb0pIfma+HSpOcwTPbf/xR+wtlY/bteMZdlL/k
         4hBatvuSp21ZsairAAiJ3hVBOaZrpymRyvixOxbA9tt8dcWhoLP7IL2hVX8zbjksbGkq
         nOe1uZcS0cqDVm40iHiauOCq7rky/M8WIvUEYN2Tfj4ymbq1ynxv18sJAjubB29042By
         m/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712815688; x=1713420488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iT9IlAymUCb2pC4/RBQKOmj3d7dpo0oLb02XVtYzR4=;
        b=IHdLcZcCCR0olYGOYagsnQSrKedzkjZLWbTxDW/mKZp6xgL+P35ACO/I01Uf6Wsrrh
         KP9Cho3PXSrnFrvzSTy9EQfVx0bDhAbSmCfl4g4UlrEms9/okv3ERaFa+n5uwObQIok7
         USzH9/BKrqW6TG//SzgfsggbMP9tPRdTBmb8IOaWfYQ6jHMATJ4pKLa47pueD1DfwCgS
         YByz6Htjq7SkGtjfGvIMjp+FLCNjoU8IDKAzUy4QsiiidoYRth4iC26sKL0kclaZeMV9
         z16ZCJprkcbwHusUuaXj7Jz4kMxCkrsPYTzzZecGnJdmcwD2j22wCX5VibXa8OepAU3V
         IXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0mXJTCRWvvmneQuVSeiroM7lAy9Lex+KJoBdo+bvfblJMBw4gMdEsag99UfKv0blpfqQtDFqE/j/ibC82Cq9xXS83Gdz+lfKHz5/C
X-Gm-Message-State: AOJu0YwAG4uA/J/pG4L+8ACkqliPA7KOV0N3TonpwknweS365MPZl74b
	k50IHwZomLsHz+VEyeB3zyMRzIChOhna6I8nyxBOPA8RHRR7a7bK
X-Google-Smtp-Source: AGHT+IHhyXMkprGe5UZ5k53JV62tzPnOnN38w9YWio7VO/KdjYqBp3xBsOxs0SgEFfosVBZYJBcxlA==
X-Received: by 2002:a17:903:98b:b0:1e2:817b:460a with SMTP id mb11-20020a170903098b00b001e2817b460amr5668725plb.34.1712815688354;
        Wed, 10 Apr 2024 23:08:08 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902e88e00b001e0af9928casm510549plg.55.2024.04.10.23.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 23:08:07 -0700 (PDT)
Message-ID: <235b35c2-159c-48b1-a522-654f5ccc2faf@gmail.com>
Date: Thu, 11 Apr 2024 14:08:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] mm/ksm: add ksm_get_folio
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>,
 Matthew Wilcox <willy@infradead.org>, Andrea Arcangeli
 <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>,
 Chris Wright <chrisw@sous-sol.org>
References: <20240409092826.1733637-1-alexs@kernel.org>
 <20240409092826.1733637-2-alexs@kernel.org>
 <81c1de48-1e31-449d-8f5a-9342634cea27@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <81c1de48-1e31-449d-8f5a-9342634cea27@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/10/24 4:34 PM, David Hildenbrand wrote:
> On 09.04.24 11:28, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> The ksm only contains single pages, so we could add a new func
>> ksm_get_folio for get_ksm_page to use folio instead of pages to save a
>> couple of compound_head calls.
>>
>> After all caller replaced, get_ksm_page will be removed.
>>
>> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
>> To: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Chris Wright <chrisw@sous-sol.org>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/ksm.c | 40 ++++++++++++++++++++++++----------------
>>   1 file changed, 24 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 8c001819cf10..ac080235b002 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -915,10 +915,10 @@ enum get_ksm_page_flags {
>>    * a page to put something that might look like our key in page->mapping.
>>    * is on its way to being freed; but it is an anomaly to bear in mind.
>>    */
>> -static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
>> +static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
> 
> Just realized that you should adjust the function name in the comment above this function in this patch.
> 

Right, will resend with your suggestion.


