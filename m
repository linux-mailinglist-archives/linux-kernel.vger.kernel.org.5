Return-Path: <linux-kernel+bounces-48579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C32845E66
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244DA1F233CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553A5B058;
	Thu,  1 Feb 2024 17:22:27 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92C5B046
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808146; cv=none; b=jz7OJwtNHALFVBzG/QHHz9LPXocKL/RAs4Z6OgTJCQtkL2/72vKCX1D6/eybZ47TRn67pBXtQ3oVgUU9ia1ZCoFtZpbCbpV8eMD9bb9JPzCew4PjrT10f1YnJmh9QtZVDnw7Mf5EyX/Ah3Eawygwhym2iGy3FrWSA1J43HluZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808146; c=relaxed/simple;
	bh=rHZbjNL8tRxKipsBLSqjYxs8COfcgDSsNiRrJZJBiFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Icnpjmw+GaY1fVnD7D9tW8iS1H6foC/HatnSNgsfDpedl2EM2teYRHs0s4jSX8lmTuYQFFNgjJBpHM3LOeiceDHWrSHHHdKIYuWiTuUGW35f1y67A2N/I5ICv4bpj6QUgNXw9NQZOVtgyWV1/2TX5eA5uQMZCJsKn5fFeUphZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1017715a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706808143; x=1707412943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZtAaumIvU3IAWyjvvbYXJr6tn3IceIszOO9KSScbmk=;
        b=AEvRRM+xTYySNG1QROtEZTpu57tZcZ7NapUXrRBrEjrUBVhtOCasWL2m5n0Ife4M1z
         oAyWf7cPvPs2eBsqmUxP1UqYqRbXkvPqiyiM3zkBpUjji4dpTJnGv9JHj6xNM1H1QKun
         LVfMr3tuVNLgni83NUuJ9CI6ZeGPJ3dvZcY22tQSl13KagVuCaxM90JUsqAF5prnwEJZ
         HQyBUHbdd65oaw9JcvAlIAGxVXBllt2DqzUcKiUV0wUHUqkmf1VRvvwWBI3DgLBArHuk
         sJ1JGea3sjCMrbU5wQZDFdmVDrNK94Drq9IAUX6v0ZO/eckKM6/7AmHD/jfM83PRwqdC
         +Tnw==
X-Gm-Message-State: AOJu0YxfJswUSmLl0lYmkM1iFLMHtMr/S4nfzHcD/b8R8avvI7822Q5l
	LCBL6A3LBlCj9GVVmnT9Ywy6Pfb+CG+tDqcIfBMYaECdmBFQike2Ohl0y0Xu
X-Google-Smtp-Source: AGHT+IGxifk4iveoBRmwTjYQ06upWNmNzxZw/szV4Bov7vw6rxSIlqMjtU+h01kkSVVWtsgm4hROEg==
X-Received: by 2002:a05:6a20:b3a9:b0:19c:a7e2:c1d6 with SMTP id eg41-20020a056a20b3a900b0019ca7e2c1d6mr4971130pzb.25.1706808143369;
        Thu, 01 Feb 2024 09:22:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVFQrXyxOIpQOPuCQCiME6pADWOWifdCiqBlBAdNJ+VYjaEnr2CaZ5MnUI6rKgYI54KL0kQMGXubBd5+o9y7H+bDbGsPHisFtM/sYfNi5nSgsTzC96ckjVREz/cDWd8fj7g55H5twtVAkOuRVThcXJCc+O8TVFAfy3pbUc4imCfRMcTikQ76pMi3SL6NklLUINxoZG1BSGTOIBCe8tUbVPKaa36mjTy4H1mo99vGVGRw2yaBSqYwT+VbCvnnTpVPZP0bnQLxrki0HhwwNix69Pj41fdKA43hXZzbPJJiGk3ACp3LMNJtoH5
Received: from ?IPV6:2620:0:1000:8411:170e:a1a5:1887:adb2? ([2620:0:1000:8411:170e:a1a5:1887:adb2])
        by smtp.gmail.com with ESMTPSA id n13-20020a056a000d4d00b006dddd5cc47csm12098253pfv.157.2024.02.01.09.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 09:22:22 -0800 (PST)
Message-ID: <2d1f4f16-6d66-4449-a7b7-5e2b2a4eaeb3@acm.org>
Date: Thu, 1 Feb 2024 09:22:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] lockdep: fix deadlock issue between lockdep and rcu
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, longman@redhat.com, boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 xuewen.yan@unisoc.com, Carlos Llamas <cmllamas@google.com>
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/24 23:48, Zhiguo Niu wrote:
> There is a deadlock scenario between lockdep and rcu when
> rcu nocb feature is enabled, just as following call stack:

Is it necessary to support lockdep for this kernel configuration or should we
rather forbid this combination by changing lib/Kconfig.debug?

>   /*
> - * Schedule an RCU callback if no RCU callback is pending. Must be called with
> - * the graph lock held.
> - */
> -static void call_rcu_zapped(struct pending_free *pf)
> +* See if we need to queue an RCU callback, must called with
> +* the lockdep lock held, returns false if either we don't have
> +* any pending free or the callback is already scheduled.
> +* Otherwise, a call_rcu() must follow this function call.
> +*/

Why has the name been changed from "graph lock" into "lockdep lock"? I think
elsewhere in this source file it is called the "graph lock".

>   	/*
> -	 * If there's anything on the open list, close and start a new callback.
> -	 */
> -	call_rcu_zapped(delayed_free.pf + delayed_free.index);
> +	* If there's anything on the open list, close and start a new callback.
> +	*/
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);

The comment above the if-statement refers to the call_rcu_zapped() function
while call_rcu_zapped() has been changed into call_rcu(). So the comment is
now incorrect.

Additionally, what guarantees that the above code won't be triggered
concurrently from two different threads? As you may know calling call_rcu()
twice before the callback has been started is not allowed. I think that can
happen with the above code.

Bart.

