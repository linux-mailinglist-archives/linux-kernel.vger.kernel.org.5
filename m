Return-Path: <linux-kernel+bounces-48835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92286846233
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEBB28137A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247193F8DB;
	Thu,  1 Feb 2024 20:56:41 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E33F8CC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821000; cv=none; b=fJGvbMx002cJvzibaHTO+Bai3nTSBAHmFo7BdRfq3Oa7rHcPdfpOU5DxTxQc7+3ZfidoqOC+kdbvRv7MBUIT66Dr9UDosQpXy9uwL06tQKduhkzmiIXYZjPwXVZj64aG20SJIHcF9iqio5QZksu5Lna4QQAKcRHlJji3vzuNOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821000; c=relaxed/simple;
	bh=BfG5LbFqIJNFLtIFJevV6JP66mOxWEe5j6NZgrNC/Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BA/+U7vikvhB8Fv+Rjit8nx87Rt50w6RUXhzSeQClslVOBieffd/oDQVdDoEONbAiZzm3fLNU/LUvEqOYAigFqRlCJmXT+vsZ5A6xEwLq074LQn+zcRk5G//o+rzLtk6picTWLtA5//TGql/ymAa91e70FJwAhIklLuqmt+hjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d928a8dee8so17627795ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 12:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706820998; x=1707425798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FFXbp+1HAqiP5p0rle86MEwsAGG8Lke6vnUeB5b9fc=;
        b=cPAGgIbycfXoLKNIYP6ndpzq4XArWW4wgSLNAhELYaYrh6fPFESx07d+XEbXSqmKZ5
         MO/qnFzlDZU4/VZToAgyag1g+OFHMm29U1PRQhX57YejeqmJQJYiwclebyOxFUeEAB74
         X0hA5WwNqXsomwcXul1A8Y73spODaJe4RT3/4VYUegdUdwzgTOFJ0q2l5n+6TmQFP8oW
         zZKsDdlaP2+19QtJ0NZ6t63Nhoy31mF1v9D/In9LfjTGzE0tzDCaIn69PTmwNnhp06F9
         WvqMFJ1cJFc26RY8RGIpjcVPt9H/KvytOnytTX16MQcf2Hdd3Wc/OTUdAjZhsWTo9R3e
         uKPg==
X-Gm-Message-State: AOJu0Yxvt1XWyxQtZ3ZbyAzc+PaIsg6P4ZNEt1DlPbcTHznD+nceEGit
	7IqD4lnUqZmwIlpeiwTpXPj6EUlv9qkpPDCYcrFfAs6hObw+UTnL
X-Google-Smtp-Source: AGHT+IGW8RKGAYeb8vqRtV5ZWfkRArkZlT7H9G1ilESdzAPe7Vjn5NJlk82DUdzJebapCr8a4pzCuA==
X-Received: by 2002:a17:903:22d0:b0:1d7:1a90:65ba with SMTP id y16-20020a17090322d000b001d71a9065bamr293063plg.25.1706820998244;
        Thu, 01 Feb 2024 12:56:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUoniBvy1+ZujmmdDIIP10uEKowxeXFc8sHlTOvkushYAILIWjPBsidp9YbnAT6blpn3e/Vv6ezRGtMGbKlFHBZoGO5Uc1QdZb1MaRfdRXjQ5IL6dmgwSkaZVQQNOaBQ2bhk5Q26wpuWXwSdqJbNhGqBsbfeSO6Ohcj8nzBfta+58ch5b4NKie0yF7rxU2HxKEH2ndTjv8wkBNNRSd46WrTUDL2Mjv8ug3H7mzRe+tWh8uE0qSqScsVj/oBQKRF8HZuyoSWQQb+SU93C0aGQRYPwrtC2UZGqbtBkoJVDTTWHs0OaMnTWvxYXnTQaJTWTWU=
Received: from ?IPV6:2620:0:1000:8411:170e:a1a5:1887:adb2? ([2620:0:1000:8411:170e:a1a5:1887:adb2])
        by smtp.gmail.com with ESMTPSA id mm4-20020a1709030a0400b001d8dbb867b1sm237967plb.179.2024.02.01.12.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 12:56:37 -0800 (PST)
Message-ID: <c485e96c-6aed-4c4c-bbba-de5c8784be69@acm.org>
Date: Thu, 1 Feb 2024 12:56:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] lockdep: fix deadlock issue between lockdep and rcu
Content-Language: en-US
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, longman@redhat.com,
 linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 xuewen.yan@unisoc.com, Carlos Llamas <cmllamas@google.com>
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
 <2d1f4f16-6d66-4449-a7b7-5e2b2a4eaeb3@acm.org>
 <Zbv31aq6aZuSXpY1@boqun-archlinux>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Zbv31aq6aZuSXpY1@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/24 11:58, Boqun Feng wrote:
> On Thu, Feb 01, 2024 at 09:22:20AM -0800, Bart Van Assche wrote:
>> On 1/16/24 23:48, Zhiguo Niu wrote:
>>>    	/*
>>> -	 * If there's anything on the open list, close and start a new callback.
>>> -	 */
>>> -	call_rcu_zapped(delayed_free.pf + delayed_free.index);
>>> +	* If there's anything on the open list, close and start a new callback.
>>> +	*/
>>> +	if (need_callback)
>>> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>>
>> The comment above the if-statement refers to the call_rcu_zapped() function
>> while call_rcu_zapped() has been changed into call_rcu(). So the comment is
>> now incorrect.
>>
>> Additionally, what guarantees that the above code won't be triggered
>> concurrently from two different threads? As you may know calling call_rcu()
>> twice before the callback has been started is not allowed. I think that can
>> happen with the above code.
> 
> No, it's synchronized by the delayed_free.schedule. Only one thread/CPU
> can schedule at a time. Or am I missing something subtle?

Only call_rcu_zapped() reads and modifies delayed_free.scheduled. Direct
call_rcu() calls do neither read nor modify delayed_free.scheduled.

Bart.


