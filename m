Return-Path: <linux-kernel+bounces-28886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D344830436
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351921C21D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FC31DDE0;
	Wed, 17 Jan 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFpKRV9H"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277D19BA5;
	Wed, 17 Jan 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489805; cv=none; b=YEQshHdD9EmiB+WY+jcQP33cRfNqyNKANxspTY7QN7iuCOf8M8trtlDD+M373yBdkm/mGdcasmXvYnxht40MZ2hrX6FNOWw/F2r+PzfUqBDijqxeNL9vZff5lafr8Jbd4duRnTrWIwzzWwhXwLaJ9uWLf7h6hmLSQc/7RqzW0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489805; c=relaxed/simple;
	bh=xagCtJI/UE9cEscEpZYujLCzcWiSxiPwe3VnzQ6LeyA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=EyqHKJUa17nu5XLpu9hq/O5IBpC8ehmGFMh9hMx8TvotxhX+TECMJpLL2eRyracdfXp9cOFP7geAPSc8OCeEHa/QMc0OuFMgB45d1BoblRkkJd8z74d70qlZ84jh6tZEcbEBZxOS8G7OEMMh1V+T4TQsa2yeYBaVuQFbg0Sr7Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFpKRV9H; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e8cc3b738so1869475e9.2;
        Wed, 17 Jan 2024 03:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705489802; x=1706094602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mv/nrXIESsSJYBNAu5Sl6HoVMbP+O5FSONc3E6eB9NY=;
        b=jFpKRV9HxyQYzbfMEf8sZ1GS5zyp/Zdl2sNYibCKRDWlg/3MSMiIXVMroXO8EwF8qs
         zoDftKT7aJtIfwRdRyCnRyU64hy1x+v4pewEYpv4ERPkwpBfnC8eOc8N6TwlSsEiIjdu
         HhON8mcV09jrQDwTMebgk+OvLrrIvMBZi9GC5wAHuAVeAp5gUlF5FuMMYmHIOApTpNLS
         xkVnhSvlKSj9fnMEftkvP73GFVNFWP1lsvGk5wFu70nkqatb+duS+8QGq2MhFlXOzRjl
         NKd5Bpj+hS3PXqk54TqGRQycm3llKYwToneMwVLwpkjyuMJZR/p4YysJGJcph3FpGjHe
         PwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705489802; x=1706094602;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv/nrXIESsSJYBNAu5Sl6HoVMbP+O5FSONc3E6eB9NY=;
        b=GU0CvEAfE+fABxbIbEkeU3WMWW0alBk6LKIwT7PQ06ezecuZe+PU4oylvFvXPOfBGO
         gCpHWe2u/YO+R8n/2DMGATTzlO18nVz9gAliTdc2QsJEhJiXeu+HyXo+UkXHI36V4ACf
         zueUi1Kg/9Ms7wDFkuCON5Ce2pom0woIQVMOo2NFVHg6VmKSlaMy4+ByQqRpUHWzQGdG
         AtAeypkhL+y4lPaUXlum5DI+b0iDc5EbSSwQyOmBW0MtYNsxYJivLMv4yEczMivJbkJe
         FVp26XxJvHKlt03soXRk+5jU7cylUZCppW/ErUjpTwE2NDj5uKaXaccGpQaIdanhQ91I
         1PIg==
X-Gm-Message-State: AOJu0YyUK70Dzr1KhvV0KJBFbsxh2HYtYqEe3PXGqIY3Vdg/g8yZ4Z8R
	eoFQYEULRhaCaL07zqoEsUw=
X-Google-Smtp-Source: AGHT+IFJh0Tmf+H9LI0Wey4DKpKCyICZUAR+AN9VgVspgEArHptuoE7Dc7GqpMgSvJ1/VS37gIkdeQ==
X-Received: by 2002:a05:600c:1c05:b0:40e:52f4:81bb with SMTP id j5-20020a05600c1c0500b0040e52f481bbmr4830425wms.146.1705489801650;
        Wed, 17 Jan 2024 03:10:01 -0800 (PST)
Received: from ?IPV6:2a01:c22:7370:4500:28da:a7c3:29bb:d21e? (dynamic-2a01-0c22-7370-4500-28da-a7c3-29bb-d21e.c22.pool.telefonica.de. [2a01:c22:7370:4500:28da:a7c3:29bb:d21e])
        by smtp.googlemail.com with ESMTPSA id p1-20020a05600c1d8100b0040e8d913629sm10743wms.17.2024.01.17.03.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 03:10:01 -0800 (PST)
Message-ID: <8c83c826-e8a3-4057-88c6-4a7813ed6497@gmail.com>
Date: Wed, 17 Jan 2024 12:10:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.7 021/108] r8169: improve RTL8411b phy-down
 fixup
To: Mirsad Todorovac <mirsad.todorovac@alu.hr>,
 Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
 Simon Horman <horms@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 nic_swsd@realtek.com, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20240116194225.250921-1-sashal@kernel.org>
 <20240116194225.250921-21-sashal@kernel.org>
 <20240116174315.2629f21c@kernel.org>
 <4523ad21-d06a-4ba2-9b46-974a6093b189@alu.unizg.hr>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <4523ad21-d06a-4ba2-9b46-974a6093b189@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17.01.2024 11:30, Mirsad Todorovac wrote:
> On 1/17/24 02:43, Jakub Kicinski wrote:
>> On Tue, 16 Jan 2024 14:38:47 -0500 Sasha Levin wrote:
>>> Mirsad proposed a patch to reduce the number of spinlock lock/unlock
>>> operations and the function code size. This can be further improved
>>> because the function sets a consecutive register block.
>>
>> Clearly a noop and a lot of LoC changed. I vote to drop this from
>> the backport.
> 
> Dear Jakub,
> 
> I will not argue with a senior developer, but please let me plead for the
> cause.
> 
> There are a couple of issues here:
> 
> 1. Heiner's patch generates smaller and faster code, with 100+
> spin_lock_irqsave()/spin_unlock_restore() pairs less.
> 
> According to this table:
> 
> [1] https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook-1c.2023.06.11a.pdf#table.3.1
> 
> The cost of single lock can be 15.4 - 101.9 ns (for the example CPU),
> so total savings would be 1709 - 11310 ns. But as the event of PHY power
> down is not frequent, this might be a insignificant saving indeed.
> 
> 2. Why I had advertised atomic programming of RTL registers in the first
> place?
> 
> The mac_ocp_lock was introduced recently:
> 
> commit 91c8643578a21e435c412ffbe902bb4b4773e262
> Author: Heiner Kallweit <hkallweit1@gmail.com>
> Date:   Mon Mar 6 22:23:15 2023 +0100
> 
>     r8169: use spinlock to protect mac ocp register access
> 
>     For disabling ASPM during NAPI poll we'll have to access mac ocp
>     registers in atomic context. This could result in races because
>     a mac ocp read consists of a write to register OCPDR, followed
>     by a read from the same register. Therefore add a spinlock to
>     protect access to mac ocp registers.
> 
>     Reviewed-by: Simon Horman <simon.horman@corigine.com>
>     Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>     Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
>     Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> Well, the answer is in the question - the very need for protecting the access
> to RTL_W(8|16|32) with locks comes from the fact that something was accessing
> the RTL card asynchronously.
> 
> Forgive me if this is a stupid question ...
> 
> Now - do we have a guarantee that the card will not be used asynchronously
> half-programmed from something else in that case, leading to another spurious
> lockup?
> 
> IMHO, shouldn't the entire reprogramming of PHY down recovery of the RTL 8411b
> be done atomically, under a single spin_lock_irqsave()/spin_unlock_irqrestore()
> pair?
> 

There's no actual issue that requires fixing. It's an improvement.

> Best regards,
> Mirsad Todorovac
> 


