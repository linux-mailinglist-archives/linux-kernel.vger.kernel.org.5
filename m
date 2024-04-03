Return-Path: <linux-kernel+bounces-129056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593E38963FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F471F21730
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9724F487A9;
	Wed,  3 Apr 2024 05:28:00 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4246425;
	Wed,  3 Apr 2024 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122080; cv=none; b=OZhPv4KidiiCCb5Zuny9iV71Yp8Zq/BlroTGU32ed2FNdRplZqqLruz/M73YL6R1rsfqzf6N9+PXxBC+tHNv2+Q4zAXxb/KnTRqWBF6vVTnS7Io885vTD/fC6FE72YNDziI3xb/bvxJeHvpejxxGUUohMXHjduJpcrelMD5x3oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122080; c=relaxed/simple;
	bh=nQ1AADJtSUrelDGKIEVmDJob3+HQS5CIkO5KdKa2Y6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7JdEtXcLZJBYXjInPFiLnyBiFZCYZd/rpDc7edkhZhe9SalEI0uAHEkWEEyybMng78kuOgk18Uk177P8pDcgPZkjwkB/nuJ9FxDOjr8mSf/k4izLrp9mPGZYnNYCjeB4O0D3dy9ceWF/yirxcsBUpneJNUwBjzuVSf8DdsKSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-515a68d45faso6729814e87.3;
        Tue, 02 Apr 2024 22:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712122077; x=1712726877;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e61jTEyzLr/0dQ2X4DGlvWfgoJOocw130xaEPJzMOg=;
        b=Uy955x2OKmlCSGIXTqwnI7VDJW3pH7Wru9fgmoKl1Fb/2U4YiH4rzXRXB+Kh00xkBe
         SiUOMAD5uflVJBuYSJ8IOQCs98G5HK9hKWM8aXGKSYu5T7Mnvo2WWUUJvdnNe//32JPN
         8bbvXNXOwAU2v307RjEtyD0pOzJ6ejtwqzSDCQl0DTt52sx1VK2Ojw0SpDDHhrxbK/jo
         GoMGQh5aTHr8ZcywnsZo0biYZVuL/O2ZO8LehpLPV6eW3JBadw2xHrkK9ZJ7XD5CrwpW
         kCW2z87bsR2j6Bxz/dVZbfO3i0xXQvBxw/F59jn0ffTP80fdykGufy2ugBpuHPGruu9O
         pZag==
X-Forwarded-Encrypted: i=1; AJvYcCXnU5DBPDrwQtmgA9VuxjOTUrMGmr3I6aiX6JKZT+BBPIC/btZfKdd7Bldi5cK9BSjiibRnXHF5z5+JUA8dHFk7XSkTSAYmGhTEnNSEJxQDg5RbpLWNfOZTCoJ9Dt0i4daTApog3HE3T9ziam3K5N7kOixX132BTg7OFqDdG57khOkxMwnMB9ejjmHvtFiIaYXOBilNf1V/u6QIdA+U9vxQBjs=
X-Gm-Message-State: AOJu0YytvDIO+aOc6Ub/mv+mInK0Zlu0wzkZgZ1qv7qp2gc2HirYeckn
	1KIcF5PvnzMYZngmAJ+7qjsqBFDasVvTN1QOj5UPECbQTOf25qSg
X-Google-Smtp-Source: AGHT+IErwZY+85fAkT8g4r68ExVUmiUc+8PVg7MkDKyZQ5FBQE/f1myNVL3Vw902yQKzsTH9GdsjCA==
X-Received: by 2002:a05:6512:acc:b0:515:9ae1:9a6e with SMTP id n12-20020a0565120acc00b005159ae19a6emr10439127lfu.67.1712122076369;
        Tue, 02 Apr 2024 22:27:56 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0041469869d11sm23278276wmq.47.2024.04.02.22.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 22:27:56 -0700 (PDT)
Message-ID: <6bb4f4fb-573c-4f63-967c-2cb08514fc91@kernel.org>
Date: Wed, 3 Apr 2024 07:27:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 1/2] VT: Add KDFONTINFO ioctl
To: Alexey Gladkov <legion@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
 linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-serial@vger.kernel.org, Helge Deller <deller@gmx.de>
References: <cover.1710252966.git.legion@kernel.org>
 <cover.1712053848.git.legion@kernel.org>
 <ed056326540f04b72c97a276fbcc316e1b2f6371.1712053848.git.legion@kernel.org>
 <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org>
 <ZgwF72yHH_0-A4FW@example.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <ZgwF72yHH_0-A4FW@example.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02. 04. 24, 15:19, Alexey Gladkov wrote:
>>> --- a/include/uapi/linux/kd.h
>>> +++ b/include/uapi/linux/kd.h
..
>>> +struct console_font_info {
>>> +	unsigned int min_width, min_height;	/* minimal font size */
>>> +	unsigned int max_width, max_height;	/* maximum font size */
>>> +	unsigned int flags;			/* KD_FONT_INFO_FLAG_* */
>>
>> This does not look like a well-defined™ and extendable uapi structure.
>> While it won't change anything here, still use fixed-length __u32.
>>
>> And you should perhaps add some reserved fields. Do not repeat the same
>> mistakes as your predecessors with the current kd uapi.
> 
> I thought about it, but I thought it would be overengineering.

It would not. UAPI structs are set in stone once released.

And in this case, it's likely you would want to know more info about 
fonts in the future.

> Can you suggest how best to do this?

Given you have flags in there already (to state that the structure 
contains more), just add an array of u32 reserved[] space. 3 or 5, I 
would say (to align the struct to 64bit).

thanks,
-- 
js
suse labs


