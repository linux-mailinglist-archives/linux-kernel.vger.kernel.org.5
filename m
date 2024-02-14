Return-Path: <linux-kernel+bounces-65996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A66B8554FD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC3B1F26C25
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B9513F004;
	Wed, 14 Feb 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2MT92pm"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DE613EFFA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946753; cv=none; b=mUrFiJzpZQ0UbfcqM/cchUiGhq+6q6FtyyFTHvOsnBhR8PhYBDS7leZP2tZfcYQbGoZ6/+8wQJBucMqSAzNx4KNA131sXpTxbhO29ViEhKIG6FVeFZl2P7FWas1d7JBa6IKR6w13A5rW9b39MbaUnJyNiHT0+l9Cpub+ClPowRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946753; c=relaxed/simple;
	bh=0GYlJoN+p5AWTKM/Sq0N1jrjpd290A1o594HNmM8YsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4NCJj34L4QVKDrhUkb5BM40IZRlyt7BDPl/ArjFbyS4jV5DbFpDuJs+bFOeQxQKoQwHw0yTqH2HUpYUKETJl7V2iVmrSuDGDO58+Oafgzoi5VCqUD0QuGQhHau1huKmgr5pyTatwyyqEuUkjkA6llqxIax8LzKQtG0M6lr5fSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V2MT92pm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-410e820a4feso7403945e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707946750; x=1708551550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6XyaYLv576AAqdDqT+wygwkSbvLemN8uKFmjCHfzro=;
        b=V2MT92pm0z2JMGeiCtc19cOtUPwLJjpAlFgDdUR7EDTDm/mNoJaKotogYG1+h2cW3U
         sTTUpv0uPmhilJ4oEsNSSwRzdtGSHqszlWDJA1uKfjRaJ9tEevJfslJqbVEmQjQ/TMks
         0yrKcXOHbbeib6SlrhSRAeUbPOJmMbC4REXpFfSeLculfv8EXsrKLt6+yf2GtwcD8kn1
         JchGx6MOdAR0sJoGsGBdB7/lfNVluMHK3nZ2LK08iJg8z/I0rFPT2Xqr29d0nWGCnFXS
         rMQ3/LvG7hKKAmu0KVGkBjZusJQMLxcwYPtQjhL26Oiq9byaFKB/Ovy3YSralH9oW1tf
         uncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946750; x=1708551550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6XyaYLv576AAqdDqT+wygwkSbvLemN8uKFmjCHfzro=;
        b=Qbjog42mTeNWX2qbU1Y60AHXcyEJ7216bpfRWHw4peJrPNfExhvsozlGHivlUgOX0X
         3xTBcFUcLbXbScOh2ssQB8LGshjBdHAsK8aknPjRusZSuJ4BW8rXJNgPhCrxuF2EEOEK
         8Zl7ODRg+SUJu5dbE1PSlJwfc81DTm+llEJisH4iLztgnZLu67O6U0nVRTlvOU3OFZEV
         /vNaVAAulVbxhrmBg51rFZxi/IFlyU3lO/u7cmUZTsoaLcnDnvKnIhPT/MrYFmE6E/fz
         dtXaFx72a52XmH8dBBGx2aomdNLVUcjrI8GH4UKJVxXNN12LFbi82LdEtNcDztshItyV
         SaYg==
X-Gm-Message-State: AOJu0YypYNcfezV30l/uCC0oiKs0lFNk1+UxZJcANpxGAIWxUYWUKxxc
	chNHdzqYRgP5L+kqdBAuTVsMIYSV+VtqSsrmVm4ilws4dzsy6fC8dpxgq5ZK3po=
X-Google-Smtp-Source: AGHT+IHYiztyX+JBCbmzPmpnFaj0O8/KdsXJ4QmojzfLAwwb6PhbFep1kOxLLlBsJRe+s3SqXYYq7A==
X-Received: by 2002:a5d:522d:0:b0:33a:f503:30b3 with SMTP id i13-20020a5d522d000000b0033af50330b3mr3171908wra.24.1707946749926;
        Wed, 14 Feb 2024 13:39:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1lzDGnCk7wtHyip//YjoCzbN9kiZI2hjn0ajTvyU4LnkRzPdZGTksZbplOz+P9TrCruFqnPtcdsrr3H/wCmEwJNORXrXZuAxzL6EVBZh2knvCyzdwOLXVZR0=
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bw28-20020a0560001f9c00b0033b66ce7ae9sm13597553wrb.84.2024.02.14.13.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 13:39:09 -0800 (PST)
Message-ID: <79fadb9b-c4c8-4727-b812-7e519556cce1@linaro.org>
Date: Wed, 14 Feb 2024 22:39:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFD] Remove irq_timings
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Daniel Bristot de Oliveira <bristot@redhat.com>
References: <875xyqg2yr.ffs@tglx>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <875xyqg2yr.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Thomas,


On 14/02/2024 22:17, Thomas Gleixner wrote:
> Daniel!
> 
> It's 7 years now that we merged irq timings into the kernel, but we
> still have zero users for this.
> 
> I'm tempted to declare this experiment failed and remove the whole thing
> for good.
> 
> Comments?

I worked on an irq cpuidle governor which had better results than the 
menu governor and equal than the teo governor. But I never succeed to 
have better results without putting some arbitrary when computing the 
next event.

At one moment, Daniel Bristot de Oliveira (Cc'ed) was thinking to may be 
use it for the deadline scheduler.

Ulf (Cc'ed) may be has a plan for the next event for the CPU cluster.

But if no one has plan to use it, there is no good reason to keep it and 
I'm fine if we remove it.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


