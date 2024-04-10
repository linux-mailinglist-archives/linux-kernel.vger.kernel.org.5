Return-Path: <linux-kernel+bounces-137829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D84489E813
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5373A1F256A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FE6539A;
	Wed, 10 Apr 2024 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljTJW/Y0"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F18F5B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715182; cv=none; b=di+4gij0d2F3JGOPy8wCeyefPxOOt5VQYM6LwcJZ+GnDHldcO7MA4uiqUDnvQask2AidRGOBUEAaVLrAVAM3sli/HSclrl63XmR6Tg1KdvzcAHUeGpsWaKil8N6tsvuCWhnzUsldvKXgSTPN9NgTtxm7UMqa4JOILfcUQhzMoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715182; c=relaxed/simple;
	bh=lK4P4UCMjiw2ZyFxCplRxGsdI2xx+6Y6j1/D98mAre8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SI1EKCjyWo1wgdw3hVl7veWwqq41Gpw7oe47pK+1K1hvQtSYjlJjyEnNMtgiwwFv4Hwa/66AKWa0N3wNz8OW/C0RwY8joC3uiMOr0S5SXqKhy5TdGHzc0ZJjJV9BxLPdUvfvPYEbdhIZysX0iRgRkPfcrDa+XtUZscXjDSqpdhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljTJW/Y0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecec796323so5885733b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 19:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712715180; x=1713319980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfrQs+4JrCPHQuxPOBXPCCTtuoY+nVtkPvrmH/Y0bqU=;
        b=ljTJW/Y0nL4mbXmGJxpce9S0uVts67YPZhjgPfE9wS6HLM8E9VGvLQCuADx1CR0jx/
         CTioeXIMqITGy+qn5Ugyve6Z7PV4NeX0OHimDqgQfAtXn/sKGrYGfagE+SuxmUN4QhhJ
         CISXAAmO2wKteghlwhg5RczV4zGcO/EB7+HtsPyfKEppg3bM7hkw6jAZJ/gIXnEYcgCs
         AxqQf5ib0v/HmZ83eQ3+HlYayNtw4QM9yQOXCi0oS3FefnunoLCBr1W375b+TLi2VkI+
         ggw6USdMFo0tl1T4DWukxZhpoc+JeJxKbFnARpx0047G2VQRPDhuFBZ7Ov/05sBXvxJo
         2gHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712715180; x=1713319980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfrQs+4JrCPHQuxPOBXPCCTtuoY+nVtkPvrmH/Y0bqU=;
        b=rKEdwPfLhbz/m8Di2CVpKheaietU0WTS2dT4l7YOcSHMxHBboKQefmpT9MliOx20so
         Doy/Lo850UVS2pT5OYt9khQ5zaur+RC5c6KpkmwqLw/ZPP1J420gkEmmXSKMv7J1PdvQ
         yFNh+qEf1rlnIOwcBUi9VQnhTh7+P5HPbMhOUfas+GD/soKirnb2yk2LyigsN/qQ0vcp
         BASgADrsZ3Uxds7x5F9gmfMI80DmTAqLwUBvOT5T7wREcSZYeuj3bYQCf7eSywyMFXLm
         5VS6ySgCLCdRevc0xbGZBCTr5ZFVbLPZ48QZ73zc82+bDhkxrEgC3KDN4Px8J+ZVGhvP
         az7A==
X-Forwarded-Encrypted: i=1; AJvYcCVu/03sLrSHZN/QnQD0fO/nd95yQxDveYZS2MrYVigi/LKb4b0lXWV04MAR86PoK2ZKHP/3Cj8XmLhCT1rZ0A8zzTOZuhGjQGXmTkG4
X-Gm-Message-State: AOJu0Yw+XM1cD2so0AZF0GUhxEXXLmYuEciKVONDKvnCCW3jHTi9c/8y
	cRtLf34JHEM7LV+l3HvkcBHk4VHxoGY9lqjKAIpkKNzNDNJYDqaL
X-Google-Smtp-Source: AGHT+IFouD389XE/szQrJCFNEso8tE9jSmplHrRziy+SDkM2J+XStefDaKGhx/vrhu5RS4Nw4yM38w==
X-Received: by 2002:a05:6a00:1ad2:b0:6ea:dfbf:13d4 with SMTP id f18-20020a056a001ad200b006eadfbf13d4mr1545511pfv.18.1712715180364;
        Tue, 09 Apr 2024 19:13:00 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id le8-20020a056a004fc800b006ed2709ada6sm5199846pfb.65.2024.04.09.19.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 19:12:59 -0700 (PDT)
Message-ID: <8836b1e2-f231-486e-9caf-757250e7a005@gmail.com>
Date: Wed, 10 Apr 2024 10:12:56 +0800
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
 <5b90db38-75fe-44fc-b4ca-55dd1b15724d@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <5b90db38-75fe-44fc-b4ca-55dd1b15724d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/24 6:50 PM, David Hildenbrand wrote:
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
> 
> Note that the more common way is to have RBs ets fist. Further, I haven't really seen "To:" that often :)

Hi David, 

Thanks a lot for notice, will change it in next version. 
> 

