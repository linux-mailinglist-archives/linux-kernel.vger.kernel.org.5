Return-Path: <linux-kernel+bounces-131135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A19898379
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFE81F23D85
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FE671B4E;
	Thu,  4 Apr 2024 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NSse4M6n"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E113ADA;
	Thu,  4 Apr 2024 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220662; cv=none; b=ogRBmwLC4t+Jy3oPhajRxRUn9vXNDQ5TyBworJ8NiIb6JBgwbYmOMW+qBq+sJ6PwON2zng0qsteSfYp9i/3feuTQwtA0r2qOXf4KQEAHJWPoD2fw3fNrbJjr4Cx9VqQIBnS/276zpxLGH4NXBTMrSkEo3INi0ELNma7E3v5nXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220662; c=relaxed/simple;
	bh=RnV2XWrFzuPbTdYwdjhB8w1PdzG3lR941MZUKMz/d2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbb18zbg+d87J24kz/QoX86ifPmDecWQDK/v809F1mnRhB0ok7y3XoHtnY3MZ/a0f3QgRsBjF/eUiKH0YM1ts4TmEdOs12vDkeYL2HFuf0+vprZFikyQZZ+T6N73LUO6gITTbHbSgxvHRd+CqNqAodwf3x5+vMHcIsWkltqpHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NSse4M6n; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A89A6C0003;
	Thu,  4 Apr 2024 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712220658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcl+blTYVb8UlfBhe34P71DucCEgZ+SnoyrFlukGhYg=;
	b=NSse4M6n2yUdP7WfgUO9kn7FSff0z7MUhr9TapI4X8ASXHDcP4bYNzpz/S600fqqnNNlgI
	tK/9Rzjfg/1VXFaab3A8IrizKEN6YzauDnVrUK5kBDFmrEJMb4NgudTvo8iIA8FXQqUqtJ
	W2wHLDCn6l7OBIowSZ7NWoF2urbKV7rgkxm3KUI9hfrgvzdhfvxP4GLsK4QGpYkC/ST9IR
	PS1wmiSwOe7RwbUdu1bNGe48ySJVZS0YwzWLUwYsTJuVEiBsGa3s9VzVePE4PX8JanhqSd
	2xyTtGybTa/piQAwCKZsbLz6i7HYLe9RnMM1dW9RuGDzIj5rT0x9WfZranwK/Q==
Message-ID: <d74836a8-9e5d-4a2f-900c-90ceb66bed7b@bootlin.com>
Date: Thu, 4 Apr 2024 10:50:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] serial: 8250_of: Add clock_notifier
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240404074450.42708-1-bastien.curutchet@bootlin.com>
 <2024040455-bungee-subsidy-f5aa@gregkh>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <2024040455-bungee-subsidy-f5aa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Greg,

On 4/4/24 09:50, Greg Kroah-Hartman wrote:
> On Thu, Apr 04, 2024 at 09:44:50AM +0200, Bastien Curutchet wrote:
>> The UART's input clock rate can change at runtime but this is not
>> handled by the driver.
>>
>> Add a clock_notifier callback that updates the divisors when the input
>> clock is updated. The serial8250_update_uartclk() is used to do so.
>> PRE_RATE_CHANGE and ABORT_RATE_CHANGE notifications are ignored, only
>> the POST_RATE_CHANGE is used.
> 
> Why just this one notification?  You say they are ignored but do not say
> why.
> 

I don't need to react to PRE_RATE_CHANGE in my use case. A few bytes may
be corrupted during the rate change but it is not a problem for my
application (and I assumed that it would also be ok in many other use
cases).

>>
>> Reorder the #include to match alphabetic order.
> 
> That is not needed here, why do that now?  And "alphabetic order" is not
> an issue for tty drivers, no need to do that, but if you really want to,
> a separate patch series is good for that.

Ok sorry, I thought it was needed, I'll remove this in next iteration.


Best regards,
Bastien

