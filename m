Return-Path: <linux-kernel+bounces-141794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0618A2382
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106F6287DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00833CA6B;
	Fri, 12 Apr 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzLzxPp3"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1F53A9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887051; cv=none; b=D84u9G/DWWLBTzCj7VUufSP2e6/YDzY94+qnpGhOayn2ok+X4TMgIMeu8hMdBI3zymDukR0ob2q9dmh7jAscxNik39QXmJFRQExDQCcY+R2eOUG3W3sLr3+UxgEN6yU244cy7txZXSvKFuWz2oAwLJXHzN6Cqu3zdZlJecUeRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887051; c=relaxed/simple;
	bh=8FLNt/eL0lQ5TGQ6jv6ZtiyKufKQF5dAqaJkNC9lWAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVxORRqAbch/qbLJA2wD1ZAWrvlCOadCgzCVPKvh3LhXnkhXDF/OMoz9c9caqTOb0oE+sAX4ph1/V+qGcPWLmBaLQIY67HVWN10E/evJi46cD9IWgIypai+9/lVF89KF7FMzikGV5c4kkxzC/cVZGi2/H+GDYENxLjuYHF0IIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzLzxPp3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so4207135ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712887049; x=1713491849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RscDpb9G0I8cBHb7bwf0ABPoa7f16JNqm4+SxgWIQ40=;
        b=GzLzxPp3xtRi+N61sJ62tY9MMW5bZwo+LsNVDb9tWXQyoNAKFUCTrjeDADfWC/wy9D
         o6dYL8ZScVDWc5iJZopPUCE2cu7aTuQBcZ/I4gI8QsuglI72LvNgHwOZmhH/WO2VRLlP
         uvBdF1p24U1jp2FeuxVJZ7La4GjPmK3elLfXHUborC/po3jpJF3MTLAfrNpsk42J5sFW
         j7erxz0s8liPRvT2Dyysc1Q2efB484KlldvYyJ35lrQRGuiHtJfn1gY9cGbSW4TV/ii9
         pvG5rhYFZWUast7BYN6uph+yVv0clly8DfukbBN/FrWmtSXWJXVG5G3VZI9C7rqKxX3d
         NDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712887049; x=1713491849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RscDpb9G0I8cBHb7bwf0ABPoa7f16JNqm4+SxgWIQ40=;
        b=ltPQCBnmU77KRgyZzH5hhXVbP28G1+GEP07h0n+bX+2SWPTh7RK8JOfBhq73LbRiSo
         7BHj5TkrdI/t+ORd64ROeh+2ahZtJRvbh9s2p3/SQ/TyHwMabpNxnM84g1Tr5kcF5LZs
         /+r/2izlNc3LP1EysWeX3BSQdGmAVDiHk7E80vM6Cirp3R4LWjuLMidOEH7OkA/nhQe4
         g8sbi5HF23OkIHrCla6Prn59VAVbY1qLoEIWl4z/90iiu2dod9x7xjFjfSqajhealQix
         qduOHIKxkPwzUDaxIaa3r5kPbXCK2wxEcDYvomRrGHPZEpNDbG5deg+XCkqcXtqMr8bY
         vxuA==
X-Forwarded-Encrypted: i=1; AJvYcCXq6QSwH7Vg+YMyvRuZPlLZyczD8Q4oBHU02hngU/XgKvUmrFnzprl1pRiYcI51UTlAQn3A/AuSEwpmExq4JhfCogZykDgkYWAo+fqn
X-Gm-Message-State: AOJu0YzEcl5XPmEkNA/oqNEpQ/BYI5Y5RDq2GZTQq8EnOpX7ZrFs88DC
	eu/QNceeT8XtjltPcGq8xaPhh7UKy0wa0NEiDfdsh/guAsEDzLlssCTH4A==
X-Google-Smtp-Source: AGHT+IG/cVTcc5g/V1H4LJGCGotQD85d3VOuYVl+tn9EKYJaot57YCU98/euIfC/qnEI89Kins33LA==
X-Received: by 2002:a17:902:6503:b0:1e5:8175:4968 with SMTP id b3-20020a170902650300b001e581754968mr1271474plk.9.1712887049369;
        Thu, 11 Apr 2024 18:57:29 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001e4458831afsm1833075plh.227.2024.04.11.18.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 18:57:28 -0700 (PDT)
Message-ID: <188e492e-343e-4205-b768-132ddc5229e7@gmail.com>
Date: Fri, 12 Apr 2024 09:57:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] mm/ksm: rename get_ksm_page_flags() to
 ksm_get_folio_flags
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>
Cc: alexs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zik.eidus@ravellosystems.com, willy@infradead.org, aarcange@redhat.com,
 hughd@google.com, chrisw@sous-sol.org
References: <20240411061713.1847574-1-alexs@kernel.org>
 <20240411061713.1847574-10-alexs@kernel.org>
 <192aaa5c-3ff3-40c1-b12a-b674518bf5de@redhat.com>
 <add08bec-f474-476e-a985-9017dbb33a88@gmail.com>
 <47686d5e-efd3-4431-b72c-620f749faeaa@redhat.com>
 <20240411134234.09920cdb641b3aa001526284@linux-foundation.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240411134234.09920cdb641b3aa001526284@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/24 4:42 AM, Andrew Morton wrote:
> On Thu, 11 Apr 2024 13:46:23 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 11.04.24 13:42, Alex Shi wrote:
>>>
>>>
>>> On 4/11/24 3:51 PM, David Hildenbrand wrote:
>>>> On 11.04.24 08:17, alexs@kernel.org wrote:
>>>>> From: David Hildenbrand <david@redhat.com>
>>>>>
>>>>> As we are removing get_ksm_page_flags(), make the flags match the new
>>>>> function name.
>>>>>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> Reviewed-by: Alex Shi <alexs@kernel.org>
>>>>> ---
>>>>
>>>> s/get_ksm_page_flags()/get_ksm_page_flags/ in title, otherwise LGTM.
>>>>
>>>
>>> Uh, for this trivial issue, do I need to sent a new version? or left to maintainer for a quick fix?
>>
>> I'm sure Andrew can fix that up :)
> 
> He indeed can.  Although he prefers foo() to foo.  Those two characters
> have a good information-per-byte ratio.
> 
> Also I added Alex's Signed-off-by to this.
> 
>         (c) The contribution was provided directly to me by some other
>             person who certified (a), (b) or (c) and I have not modified
>             it.
> 

Thanks a lot for you and all the info!

Best regards!

