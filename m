Return-Path: <linux-kernel+bounces-140356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F908A1348
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E921C20F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046BD149C7C;
	Thu, 11 Apr 2024 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4TVqH7X"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD69147C9D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835779; cv=none; b=bd3UiVWTRnQOP0mK1xKdwrxoUmiZd7KNvzZJ7I9npv9lNhJ58AiVm5UjNYkQbZmc7U1aG6u3j+baSTL47WKM5KNH3OI1JzJIb6XZDsR9yf/TrQsyNixJWMqogiC+3+ekJZSgnFWWJDfZ2YhYfRRSrfUAo5ugb2BGe27/fdh2vh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835779; c=relaxed/simple;
	bh=ZYjfr8vSJfgtkk0nxlBYHs/zHAElYFLXCl8Xsw/iVgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aXROfTQadr8a5wkSIuLmvnnkLWCl0L8+rdznnw6qAOi7NtzbarNyoi1RBHw8zxRYtIEbJ4FJOd4be5ACIWSI2srARtYHqfJIhEcZO9M6SOwPFbyVe/kMLRQtMNDBkTWrIIUOqT0x3fzO7XLg0r1tuJMUenS6SoEY1PDVeMx+xMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4TVqH7X; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0bec01232so62663055ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712835777; x=1713440577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yAbLwjokjxdd5BNSzipuHZHQoJZV0t/MjoYnx5AOvWs=;
        b=e4TVqH7XsPGbf0JTmK3F14Vogy8D3zleK6UAdU1GPnuNeCV6M/HfWiOSD2XXxMqtMm
         kb6z2rvT+XTn87dDf6E2oJjPHnKPTyLOEMW/Q4+HLyXfZgYR3ZoL/KVVuf3Z/xXMF+Py
         uHU9TsU9d5rp70zdMLL72vfzWeBsJx2TF+jRgOqKAjdK+dj5mt60iFf/SW4MhBCQzMV7
         n48ObLYXWQs22nBEJI7nNP4iPkNnpt39uIJ4WaSE28tRNlNtazPqTBZK1JxdSl6ENuYP
         feyd76mMDv0xefS9ZwrW0W1kTRFTiuUPV167XSM/BL7lktbcXJfMVcUMpoHTQAvJ0y05
         iWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712835777; x=1713440577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAbLwjokjxdd5BNSzipuHZHQoJZV0t/MjoYnx5AOvWs=;
        b=shjxNj6G+GdrUpXtprytu3HV7+MID+mumzubIq4+WF5TUh6ScJaqt1lgp5ZzIFV7s2
         CieP9m6oECr/8ZtYixUgjkSv+LogP/MXpHNoB2+R320U+9xFQORSGLkCRo3tiMkoauQZ
         Zr74N4b5gAOabQHGV4p952UWgACUQyUAQCdSpK6DfxWCaOYh+fHP5jxF5BWvzpl49BDP
         IO1kxKdfWIp6s23h/jYziSknJkW9cTejq35YnR61YdTvgSmcGvHo4dmXXBRIHsxM4Lj/
         oANKyaNNeKt+/pKKjYXfIn9zLKMr0Rga+kSFMxIz7IBOGTCgQhzX/rwkc9CiMjIUHIXy
         gWiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjipN1UH7/NC9tRa5rHBRugjtsKYyXJWYg/Kp14/YAAxli9jXO17vzD2illgI0ooj0yT3o+yveHBC13rCtR/U3q4h6YciPVsO9XmvT
X-Gm-Message-State: AOJu0YzGZds12xGTzkL9zoLlHdT1P/TEw4/MhXuGABPNdPOugzGZRt3B
	pCLspDhJ6wBpgA6xM8/Qjdw/TRoJSZ+mjrNQXsH2QIBzDNQFxYHK
X-Google-Smtp-Source: AGHT+IFmsxC2FK54ROVvYBOwvDu7+bDSMp6SKdgV4WY/Po2x2ggQ57HHTS0bQO/V3Dz+88BsJ+63MA==
X-Received: by 2002:a17:902:a718:b0:1e5:28cd:4ef9 with SMTP id w24-20020a170902a71800b001e528cd4ef9mr2592295plq.30.1712835777008;
        Thu, 11 Apr 2024 04:42:57 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001e3fe207a15sm982224plg.138.2024.04.11.04.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 04:42:56 -0700 (PDT)
Message-ID: <add08bec-f474-476e-a985-9017dbb33a88@gmail.com>
Date: Thu, 11 Apr 2024 19:42:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] mm/ksm: rename get_ksm_page_flags() to
 ksm_get_folio_flags
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, zik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, hughd@google.com,
 chrisw@sous-sol.org
References: <20240411061713.1847574-1-alexs@kernel.org>
 <20240411061713.1847574-10-alexs@kernel.org>
 <192aaa5c-3ff3-40c1-b12a-b674518bf5de@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <192aaa5c-3ff3-40c1-b12a-b674518bf5de@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/11/24 3:51 PM, David Hildenbrand wrote:
> On 11.04.24 08:17, alexs@kernel.org wrote:
>> From: David Hildenbrand <david@redhat.com>
>>
>> As we are removing get_ksm_page_flags(), make the flags match the new
>> function name.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Alex Shi <alexs@kernel.org>
>> ---
> 
> s/get_ksm_page_flags()/get_ksm_page_flags/ in title, otherwise LGTM.
> 

Uh, for this trivial issue, do I need to sent a new version? or left to maintainer for a quick fix?

Thanks!

