Return-Path: <linux-kernel+bounces-48872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372BE846293
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CEAB23B91
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E463D0A6;
	Thu,  1 Feb 2024 21:24:52 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD63CF5B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822692; cv=none; b=bx96G9AA5S4TxgfPAYev2VhNkCfH3wzXn4sh+nghBRBFZt9t18lnspJ8n0WmtWHmK62R8F96xLMLvaBky6y21swFVKkVHJwyX7Z+jXqNRLH4M2/mRWCxmQTJARNf87gbu//ahP5TxBwIkcmD9GVe6FdwfG2W3etHm/GVW3Zg5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822692; c=relaxed/simple;
	bh=D3ieI5eypbMKCesfhR5+rcxs0f229+5nQ83JMronJuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZghigOea4b8LTU0CDbYOG0sBIbcogyclFvDyRQTPzrAJJrEvZrKe/liR5LIiqgr96/S73pHSs7pp1XdNSL7H8sSB2D1FH13fmty2j0pugydxTBiK/zmTu4okapWFTaY/nbCBi6aNBk8UT2M5kcg27MWgxcD2foBrBB7vrAGR7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso1242599a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706822690; x=1707427490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uUJXhA0Mx1FtW0QJpxwfhhn/2x3T3FnROkEbGKlTmE=;
        b=D9ayIOoJnhwh0ePcaSc26d7MpmDXEZAG8QxqYzD3hCiRybEMAzqxiNSIafm91cDvAg
         RAfPBxvfUHQsgDyk+aXTxouG6xj8Yp5kHzmV12JxltGz0TtJSTkFI79RookUNm4SpOFM
         pLsSQoUVBjB+27WKF0y48zUTnH/wE6oBMZRncD4gFZsy82IkF31yCza3vdUnOAPbIP5m
         42JITj/16jXo7x1mJBMNRvu+sY9roPpWCD6+vBhxnM4M5FKoiMXAcWfjbonlTAEh9qC+
         idazlYlCH6DStfPgGmBblemIxYPhromDSabI2K7XRr1LetLtJDM4OB4NBL2uFPJu45ZX
         +hEQ==
X-Gm-Message-State: AOJu0Yyky7ep58ZJKmYQKmGQAtgeuslmY83USBo+ZbFjzjxtK0PLtPMq
	nvsCVp1ndxHrdCT1lR9BCbMPThuTG2GWH9bv2mO8ZVp9LsSgu+vWSQRbCeo4
X-Google-Smtp-Source: AGHT+IHerINdctMKITTvt88+68k1KY5iqP4zy/sJG2dp1w1MtLL70FPMRweISXyaC91mg1jDKjGK6A==
X-Received: by 2002:a05:6a21:6215:b0:19c:a00c:f1f8 with SMTP id wm21-20020a056a21621500b0019ca00cf1f8mr84650pzb.23.1706822690268;
        Thu, 01 Feb 2024 13:24:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUr530zBV7HXGGzTmLYi6wuhRrbZ/E3+vPHB4Fi//CL2Qs81/IcYc+njkWRtN0lGoBt7WmvV4ttase9mtP6c0zkYWVWLUANnScQAPFPrWyBHgzG0WVwyk7b0Lk8KhjcgWb5Vk8hHtJBcZfj4r8a4w0iFDvCQH25+BQ8lp/SedLBBTNACSEvBjJwz4YyEUrwyorNXExojjcgIgo77vbOxHkpGOwG9XGrp5JbTF/txG0xwtgoN0ew0vHi9ei1/W8Y1qtaWVvCTKNwQtaZCn+UW8ppdwml1hi2aUIAsRXHH+oo9/S0GkUh5cwBCeY+cveVv/InIg2zTyi5vX4MSTpBQu1hdPO4Euf0YjQSIwD/
Received: from ?IPV6:2620:0:1000:8411:170e:a1a5:1887:adb2? ([2620:0:1000:8411:170e:a1a5:1887:adb2])
        by smtp.gmail.com with ESMTPSA id lc22-20020a056a004f5600b006dae568baedsm205548pfb.24.2024.02.01.13.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 13:24:49 -0800 (PST)
Message-ID: <1f1691cd-fcc8-4a0b-9d63-bff15c5a52ad@acm.org>
Date: Thu, 1 Feb 2024 13:24:48 -0800
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
 xuewen.yan@unisoc.com, Carlos Llamas <cmllamas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
 <cc828212-9a90-430e-8719-e6b19bdab600@acm.org>
 <CAL0jBu-2jrhBzTo+ZneFMpsTsqUMLVQCYCAQKqd6BHjv3-kxhQ@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAL0jBu-2jrhBzTo+ZneFMpsTsqUMLVQCYCAQKqd6BHjv3-kxhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/24 11:48, Boqun Feng wrote:
> raw_spin_lock_irqsave():
>    lock_acquire():
>      __lock_acquire():
>        validate_chain():
>          lookup_chain_cache_add():
>            graph_lock();
> 
> Basically, every lock acquisition may lock the lockdep graph because
> of dependency checking.

Wouldn't it be simpler to make __lock_acquire() return early if
this_cpu_read(lockdep_recursion) indicates that the graph lock is held?

Thanks,

Bart.

