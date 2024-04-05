Return-Path: <linux-kernel+bounces-133260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9367489A14E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D62D285E56
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A197D16FF28;
	Fri,  5 Apr 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EpRaYp6S"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4BE16F8FF;
	Fri,  5 Apr 2024 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331211; cv=none; b=D/5YP1SCeQpQqFajJogNjnfb1FJt/VtuSp2idgSAFi4uedJFKWodiDnsIarUefS7x1KPhidlpyLUL+h+q0SXlrPg6udePA30Q2XSuheZbjRwUh1k98nQ3yekn8rigfeFKqXQFfTS8OauVpp2uOn6THveqwaeT5HtSFd23rhpkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331211; c=relaxed/simple;
	bh=ZrbWj9EN3TK4UuY7PSkDwNziw1p2AfN13v4rd9SWQZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JijgzX6AXa+03JeEiBhdUFd/Z37bsLpHvb8fZQVXGxUrXzktGyuA/ofaQhmZddMhFSwIy45xVfm0HPNGeogMAwwuwUs0H0OP7Fpq8Nksy6R0myu9/Y+DXcdi3/XCu9zvWEVvhfUdkGvssz4Mtk0/kEU7fmY1kVOFme6UApzT0Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EpRaYp6S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=oVzv/OVSRdzkb+bu3ATK5q/JI6lBBGQalVfyBJPvj/Q=; b=EpRaYp6SROg18LP4Ob2mhaZsN8
	BXSRzG4crIWKb68uueY3Lv21bllbg8mO9siLMOnG+IYW8djxdmyPxMT2ewOBozgTo41jBZkTzfPPW
	v7GZY7J6mZ9uFoz+4zJWiwmfB6HmBJcgp58pXbwPSjiBwr+Jnr0zbK9w0K1/R+Awg2sR/jCm7djh2
	/P7mkuiznZA41eFMCtcUtdLHz0lbG2XkSXJXM+en9ZDQR/qwHt3hvbm+dYpH5YOtPwWLR5MQ/Mj3B
	b8nBpI3b0I4Y2LaAuDCE4xOzCYjR3FNxOfIIcGHyauRw2qdam2Rj3ly7oonYJcrTj9hr6US6P+qCP
	p8Ky1sHw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rslZI-00000007mAx-4BW6;
	Fri, 05 Apr 2024 15:33:29 +0000
Message-ID: <47955de8-dfe5-48c0-bc9b-4e930b8f943e@infradead.org>
Date: Fri, 5 Apr 2024 08:33:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] gpiolib: Update the kernel documentation - add
 Return sections
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
References: <20240404212706.3587456-1-andriy.shevchenko@linux.intel.com>
 <2df0e132-5599-4cb5-93f8-4ed664a5d1cc@infradead.org>
 <ZhAYeMNzHg0x97gN@smile.fi.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZhAYeMNzHg0x97gN@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/5/24 8:27 AM, Andy Shevchenko wrote:
> On Thu, Apr 04, 2024 at 09:10:09PM -0700, Randy Dunlap wrote:
>> On 4/4/24 2:27 PM, Andy Shevchenko wrote:
>>> $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
>>> 67
>>>
>>> Fix these by adding Return sections. While at it, make sure all of
>>> Return sections use the same style.
> 
> ...
> 
>> I would use %true, %false, %NULL, %0, and %1 in a few places.
> 
> Why? I specifically removed % from all of them, it's not so useful.
> Do we have, btw, generated HTML with these % as an example to see
> the difference. Maybe that helps to understand this better?
> 

The leading '%' just changes the font style of constants.
I don't know of any HTML that compares them.

>> s/error-code/error code/
>> or
>> s/error-code/errno/
>>
>> I would s/active-low/active low/
>>
>> or it can just be merged as is. It's a nice improvement.
> 
> That's what I prefer as any of your comments may touch other parts of the
> documentation and need to be aligned across all comments, which is out scope of
> this patch.

My comments just refer to your patched lines.

> 
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thank you!
> 

-- 
#Randy

