Return-Path: <linux-kernel+bounces-140349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFDB8A1327
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447521F21423
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434D4148855;
	Thu, 11 Apr 2024 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3n9JEHE"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E113D258
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835521; cv=none; b=s9WJgPzzv5RsnQgkmslQS4/Ww89kaJCMaX3aFEeD8F+vvblfc9KgpWcWk+DaOvBwwRlHer5mhDJCij5UuANVFcPOHMYl5d4ny7pxergms95M/1PVhEnba4E/Ztv49gt1Laji15QhWrotwDnRIWnUs3vm6YU5pZ2EnC72eYR6oKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835521; c=relaxed/simple;
	bh=ZxHp8ITrIEiX0F6r4/e1KAWdoBX/J1qTpB0vXYOSEa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpUKMt4fV9fdpeUEpzNK3o8QQBk1JIZ7rS8F17A2pVzjsJUXCX3tlntYeKXtoSb+HRa2pZCnWKvwmRDMRfBAXTWi901MSc3RHDRiJwoCyb+IpkJxrIkO4BgmwXeRET3CJehGpxU13QZ0VAr4okL5RMtvQO+2Im76HyS7seVNec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3n9JEHE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so1330257b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712835519; x=1713440319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdp3UwWTNvXvK/PdbOB2Hm4+HGKrxllwvhZL9gBURvY=;
        b=S3n9JEHExRMUIf8SS94eRi9Rdn0YKEY+2bX21ku6dDq3AWYw4KdtcqAG7zrxEUW03l
         +nYyrv8n7lGOtmWMn61+7yJpfe9lGcCIyCqu2KrsKYLOG3G2zoSnYW4Zk/+UR3la1c2h
         FMzCs6QEHJQyYybBJ0H2nttkFGvLLph0kOqZFsIdqDFAH29Mhq6J3ZHyFxw+eeBPrSNL
         hBMnHX2DfUtoBtXBqMk0BplCDVK1CW/+MVKa6iYEh9appBwCDlpCr++t9ueiktIRM7S1
         meuRNlzyxvWxDZ8cHE8Ed4JvHT0njCnxz56Zsp4DiGlZ89C1NTMXSrHPNj91TcESY+B9
         3pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712835519; x=1713440319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdp3UwWTNvXvK/PdbOB2Hm4+HGKrxllwvhZL9gBURvY=;
        b=wRjp36GHCatUK3F4PKW1wxIlYhqEGsjEuGFrIoK2eZ1oGg19E72Oty7s+584KP3mb1
         PvAwkHf/qIqfcTD73dYIrDAohzjGRWROzW5U+8UefY1zxwifANeunK0rXtzeYwDyedb5
         c5+pWpv9d1rlY9sVan54bk/rQS3lljfuO4F8+jpRs7HNFZW2k7y/3579AVZAykUgxx1C
         ZCGrHEKVQrr5rwAe9qOBsjq0by5JYz4wvFpQJ040wDyaH2t9NpUWXF5xTyr5GMPds9su
         EN3svcza7DWfXxS9xAgSVC7EoRHe8/uU7of7U+rEDdthqrNqIbk7+KzSPlVWyXXIF+xo
         4OSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXYosQtuq/lc24sxuk9HnZRDhj2FICvd+MxEqIeXxM6CGePXwpIz2x+InR9jllzqVrQxY+pHmY6QujftE/PnKBFfeyiqRq+X2F08T6
X-Gm-Message-State: AOJu0YynkA+UbAr0rNSPaHiuNGsJ5ZPt/7V81GNPWnEE/cYzlsOnHweU
	4VZ+S1QC70iyfF/dGBSOcOAeSdbmA8KQpzX+pENkyZI5WwOTddBePXJthiyj
X-Google-Smtp-Source: AGHT+IFt65DFPrigbB2JOQONrUhjQ97LaZepLdA1cRZkT1Zbi2Gc5OMsJI+lmSwU+Ud2lFs0D+3Lfg==
X-Received: by 2002:aa7:888f:0:b0:6ed:1c7:8c65 with SMTP id z15-20020aa7888f000000b006ed01c78c65mr5975004pfe.10.1712835519444;
        Thu, 11 Apr 2024 04:38:39 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id gj4-20020a056a00840400b006ed92b011desm999510pfb.169.2024.04.11.04.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 04:38:38 -0700 (PDT)
Message-ID: <5101e32f-cf22-4ecf-843a-47ee5d6fc45d@gmail.com>
Date: Thu, 11 Apr 2024 19:38:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] mm/ksm: Convert chain series funcs and replace
 get_ksm_page
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, zik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, hughd@google.com,
 chrisw@sous-sol.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
References: <20240411061713.1847574-1-alexs@kernel.org>
 <20240411061713.1847574-9-alexs@kernel.org>
 <8a79bfbd-b01d-4425-8fd9-de2d3e6cd1af@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <8a79bfbd-b01d-4425-8fd9-de2d3e6cd1af@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/11/24 3:53 PM, David Hildenbrand wrote:
>>
>>       if (folio_test_swapcache(folio))
>>           folio_clear_swapcache(folio);
> 
> I'd have moved these 3 into a separate patch, but fine with me
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>


Thanks a lot!
Alex

