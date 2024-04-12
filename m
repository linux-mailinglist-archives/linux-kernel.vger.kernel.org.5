Return-Path: <linux-kernel+bounces-142419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A1F8A2B51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE151F221F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E680C50A88;
	Fri, 12 Apr 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Sp+mMu+O"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577A4F5E6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914493; cv=none; b=PR4q4XMHPvKMNe82ndCwdQ80Wq8k2NlcWxmkYfG1Ba2UhX0M2Q1AvypKZ3KSX1JoBE7PhWXOZl1eBh270COYWWdVoeelLDOoUQu3xy5+/T5aDb93rL0iztRDJsl6YGm3kUngpcKUO+9V8Cbij3/qnDtoLivdoktfqry1zJor4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914493; c=relaxed/simple;
	bh=r1vlm5I3dJb4rLd0qiEylbWV6UbcofC9YAdLEzuHRpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4y0We7fMsJDb1eCGsacXiuC3pDy6LNM0vNNnmmVaMhPkl6fhzS4G/wS/WcH9pDw6qy6TBXa8ucuGdConGdh8InjE76sZPRu0pXqDMQm1M4YoNXNL8AJLyTDJ6EiRcs9WuIcuQ1ZeV6OrpVJfodKBa8tofYvgJP5bh+bdpU9Suo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Sp+mMu+O; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5aa22ebd048so518187eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1712914491; x=1713519291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLAyHld4nBwM9U/oMij3cJEhNh4cYcKp+0eslEaQ9w0=;
        b=Sp+mMu+O6lwkr/4SUzed11sCDsHe3PxlW2cYUjHHU7et9G5gXgH+dx+iVnHZPedQEg
         sWoHgRgQbuf/0t8hcqxU954i3ENC0qLobnTh/Qrm5SQ9iyTuX8mcCOEn6/ne2NW8bG7b
         qo6OeIuG29uj3/nSGx8Y9Ik2M2TVs+Orb+LvfXbYpY3thVNhhEHET8bbVSN5zNMWtdPK
         6niLxtSmpwzB3H58PWN0W/qUg9KosVs3IYTZE7fxo5aKajLuLH2N6z3evrAIQfC6Gyg1
         Jkgf+DwG5ZU/TF5lSKZ0NV08BeD004lBZGa+6iOjrmkNgB8viS6MeCma2aNpLeS6lDMp
         a1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712914491; x=1713519291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aLAyHld4nBwM9U/oMij3cJEhNh4cYcKp+0eslEaQ9w0=;
        b=Iv4XMU8xp6fe8DKYtZlI2rcuIyTFJIuVjpnF4E5UX+eXz+SnY5tnNB0Eg1lSxoUzY1
         XzUTYrbHeEZyniTFsBrgoeV1TQ5N8w/9uUmLprPf0UUgKE6xxxYh+8IAmNdtgT81iTK6
         vWCbHojmQwYwimmd7vT4US1914b9NHgtX+ulb/1m7sRYq12B0fb8Se+4k57nbD0WjTRa
         mt2dxfWWv3AWnHvMmcdSB7HEx74WK+ioCvNK2x1NQ7QrMtqB2uuXtT5YpTMeb6yWWHZ8
         0sW+PZyQ43C1PiW1DontADgMLy1fC95vnXYOCov+7Z+FexssZQWY5BhnncpIqLzpMlVX
         2cLw==
X-Forwarded-Encrypted: i=1; AJvYcCUUJFU4UTgkBRF4+u5BI+tAEj+vffoIhK85iuRzJqx2/p+TqZpCsrtxY+LWCBel3xYMjfvqyegFRNv3+vrtuB+3vCea1zicEhjgmozy
X-Gm-Message-State: AOJu0Yy8TFzVphQ22iSrCQsAKORUOfchoPS70WK6QLH6C4J1kork489C
	INZ3Yx2Y9bg+2aahuxBW5bHiVfk4JTffCzRADvJ6DLoZUnEJ4N+Xiio9AzZiQi0=
X-Google-Smtp-Source: AGHT+IFxWq6gMeU26lsyPmW/F+OpjvVPv25ng9NXVlr4+HWtyZekf7KEkyBbJWD1v/q8JUEBPWxFlw==
X-Received: by 2002:a05:6358:7d0c:b0:186:1152:d741 with SMTP id i12-20020a0563587d0c00b001861152d741mr1873872rwg.6.1712914490701;
        Fri, 12 Apr 2024 02:34:50 -0700 (PDT)
Received: from [10.54.24.115] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id q4-20020a656244000000b005dc4fc80b21sm2047884pgv.70.2024.04.12.02.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 02:34:50 -0700 (PDT)
Message-ID: <4d0f2910-8fc5-4b08-b70d-5a5531d4ee2c@shopee.com>
Date: Fri, 12 Apr 2024 17:34:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: Clear __GFP_COMP flag when allocating 0 order page
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: vbabka@suse.cz, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240411091832.608280-1-haifeng.xu@shopee.com>
 <5482360c-0a0b-e5f5-b88e-4a6ec4d43f7d@linux.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <5482360c-0a0b-e5f5-b88e-4a6ec4d43f7d@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/4/12 00:51, Christoph Lameter (Ampere) wrote:
> On Thu, 11 Apr 2024, Haifeng Xu wrote:
> 
>> @@ -1875,6 +1875,13 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
>>     struct slab *slab;
>>     unsigned int order = oo_order(oo);
>>
>> +    /*
>> +     * If fallback to the minimum order allocation and the order is 0,
>> +     * clear the __GFP_COMP flag.
>> +     */
>> +    if (order == 0)
>> +        flags = flags & ~__GFP_COMP;
> 
> 
> This would be better placed in allocate_slab() when the need for a
> fallback to a lower order is detected after the first call to alloc_slab_page().

Yes. Thanks for your suggestion.

