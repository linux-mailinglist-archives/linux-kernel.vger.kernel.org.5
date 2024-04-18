Return-Path: <linux-kernel+bounces-150648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2198AA242
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBF71F218D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA2517AD6E;
	Thu, 18 Apr 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX7WSruz"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30417A93E;
	Thu, 18 Apr 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465975; cv=none; b=lrbJoQODEjv04sr4Xr7rC0unpB6pk5fqRSEINKFwHIC15FOkd3M2FQf3x5mHRJfRkWxFmOH+/RSV37pyxDd286e5W9vwIveGxnogSMFu0SzOI5kovGkZLo7hwLhQMMme78ZabFCsFk6CBvGX7B4QXRPtX+ykNo3EQg/exOdbg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465975; c=relaxed/simple;
	bh=/fdg4WcslGD2kTmzgo7KgN+CMEoLed2hGFc1G6l34mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSU2d1/UK39DrXXpd+8M+3c3cMTnK2Us9o3xhFrTIs2oii8KhbH+8h+M6VUwe2KTLfWxuwoz4TBexpSUwgGpWa4TP8PPsYE4z1fT28m7oicKLOjVUrZEiqo3FhwSF1cSeU7nzF18BPvKI8iq6nGSXfsJKvEpK7dsCAfE47k8iXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX7WSruz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-346b96f1483so723299f8f.1;
        Thu, 18 Apr 2024 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713465972; x=1714070772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMLCBbRwZzxsZCaPASD1MZbUpbynSGkJx7RFB3cvo6s=;
        b=VX7WSruzxaMrtn7Fj+sMKKdc/WOovMq14rnw9MD1ShjY+RY5JR6+BEKoJ+6+qyRYhd
         n4Wc8XQRZA1arSVQiHa3c8DRALBlto1WHEk5DMtbwZnNM+P3v9g6uxZcfICBnqieoUnO
         fNnYOAM/6pGbpr2WDQOCGodzqqK5ozKyyEfna1jdjmmRX/3S9coKYmLiI6f/gwe1r3J3
         JeWuBBcHQv4ANWG0JtWk4WJeSX4lOr/P5w1wrVl4JBDIRx24N1fGF2vBxHdlcVDXRMRC
         HnMa9vE0PuDwy4+4PyvXgmuAUP06ekRDaJyB/r/kTJDii0q318HS1/clxV7CSXuVCZY+
         QVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465972; x=1714070772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMLCBbRwZzxsZCaPASD1MZbUpbynSGkJx7RFB3cvo6s=;
        b=cjoppoUx77A8AGSB49WhaqnG9TGHU/NnnMjnunUzC4YyGbkvTFaO/nVnLsFR1xL6gc
         x0+kvtP3eyseBBQFbIAyOsXKxxH7Pyj22dRVTTmxLRbItn+zH1N+GnVBQkvCDHJxKS6I
         l83mnDGzmul9q9eNrb2dHXltm2lsel+IlKYEEdduXBDLMsFZRvLcb9x7zXgPR3ocILeC
         bq8+i+OfjLQaxSa+HcB15awsc3LqBE7wlDbPjfljccd1BM/g3vmM51f3gLcvbLq36sGE
         4Z7n7f52xEFwjc5mjHVh8XHvscg4LO5LIeQ0ZLpeBUpslcIbDKZKpAwPfelYZ9SslD0h
         xO5A==
X-Forwarded-Encrypted: i=1; AJvYcCWlkyimq+ebo1Kq2QxlUeJ6DwaaCki7CPPG5/TB4NqSF8yaTNs8rIXLE1bn/i1jzLthll2U1tzs56x8ciMA3rBvfOwo1VZ/p8BuKOsv
X-Gm-Message-State: AOJu0YzuD8ziTUksOQ+86p4lhbHs9V6wPDgpl15i7SN8nk9I3Zo+1/V6
	RtexrWHPW3t43fqTpZx0yMVsCC4m0GFw6SmW7zrCEaaGw7VkSgJHAzo7EFTH
X-Google-Smtp-Source: AGHT+IEcfZuciCzIqTP32bcd0EzGSNa5Vp3S6Ki+iJ4uzSrArdACLDDLe0IZkNR0/0qENRmN8oJImQ==
X-Received: by 2002:a5d:6e86:0:b0:348:870:bbe4 with SMTP id k6-20020a5d6e86000000b003480870bbe4mr2575291wrz.7.1713465971486;
        Thu, 18 Apr 2024 11:46:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:6d3f:e873:3f2f:a87f:452e:78c0? ([2a02:810d:6d3f:e873:3f2f:a87f:452e:78c0])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d6acb000000b00348b46a134bsm2501658wrw.1.2024.04.18.11.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 11:46:10 -0700 (PDT)
Message-ID: <d26436f0-b85e-4102-a3b3-a31816f0452d@gmail.com>
Date: Thu, 18 Apr 2024 20:46:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: uclogic: Remove useless loop
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401004757.22708-1-stefanberzl@gmail.com>
 <nycvar.YFH.7.76.2404121751250.5680@cbobk.fhfr.pm>
 <4ae4be2f-4edd-4d1e-87e9-df5687627d00@gmail.com>
 <f2429c78-9189-410d-9c6a-644ae8a4d12c@gmail.com>
Content-Language: en-US
From: Stefan Berzl <stefanberzl@gmail.com>
In-Reply-To: <f2429c78-9189-410d-9c6a-644ae8a4d12c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

On 18/04/2024 19:04, Nikolai Kondrashov wrote:
> Hi Jiri, Stefan,
> 
> On 4/18/24 4:31 PM, Stefan Berzl wrote:
>>
>> On 12/04/2024 17:52, Jiri Kosina wrote:
>>> On Mon, 1 Apr 2024, Stefan Berzl wrote:
>>>
>>>> The while in question does nothing except provide the possibility
>>>> to have an infinite loop in case the subreport id is actually the same
>>>> as the pen id.
>>>>
>>>> Signed-off-by: Stefan Berzl <stefanberzl@gmail.com>
>>>
>>> Let me CC Nicolai, the author of the code of question (8b013098be2c9).
>>
>> I agree that Nicolai's opinion would be invaluable, but even without it,
>> the patch is trivially correct. If we have a subreport that matches the
>> packet, we change the report_id accordingly. If we then loop back to the
>> beginning, either the report_id is different or we are caught in an
>> infinite loop. None of these are hardware registers where the access
>> itself would matter.
> 
> Yes, Stefan is right. I was trying to implement general rewrite logic, and if
> we really had that, then the fix would need to be checking that the new ID is
> different. As such there's really no need, and Stefan's fix is fine.
> 
> Only perhaps amend that comment to something like
> 
>     /* Change to the (non-pen) subreport ID, and continue */
> 
> Or at least remove ", and restart".
> 

Will do! I'll send a v2 with the comment updated.

Regards

