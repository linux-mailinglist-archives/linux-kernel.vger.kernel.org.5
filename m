Return-Path: <linux-kernel+bounces-89600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278E386F283
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 22:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC61B20EEB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C5B4120B;
	Sat,  2 Mar 2024 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k1kfqMBg"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69D40C09
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709414084; cv=none; b=LKr+gdRfUWL/NL9//FvS/Hjqn3h5xy0XK1IInC7ueNkVdjgalr0+b1dfGQFViNv1uG5k9CD/qt7VNDg8nQx3WPx1ZUfqxW/EhLFnIQXE2twMGHz6nxwEFBMbHOFRFnw4k4to2HJhC7DLg15xRopXlzplzwM0WIRbAj89sAKP5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709414084; c=relaxed/simple;
	bh=cARRLoeHAGL46ZFhIfYilnE6+Rl38Ax3+uFCRY6oWaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhehN3hlzCw6wPFPMnZq//S+MUkccJ6oT0hTjclVpCYM4h7rcjSXw8nRcD6MsY/YdqmlEsyhNjo9vJGhCv1TtAF/dZwIi79h6uU3FIIvGbaptxwZkDvptBQCmiQIwK6o0K7TXuBaZUj32rB6DjB8PQzTHaObZGiBTQ9iqLkqjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k1kfqMBg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LSmHTC1U1BZnToEb2yjxqrWe+nbp3iaTFfFkGyOQTrU=; b=k1kfqMBgyxXuRBl8zvvmEI7SIE
	AvKRFRXZHeRraxo5kn9FLgpNRbhw4peX3XNrn9x5E5v8hFmRCtPMqo2dQUtVBhckt7imMs1R9F1T9
	ehZJV7HHGiFZC0e2fjfG7lxaO5fWRARXavZFbzjtjVUDsPAJASLD99jLM9BhIaMU4Ivdy+ftdFpnT
	ojZGtdqcJF070zpSUTzEdLLhHFmm5DZEczNxWnGsfz0TAV85Nkqa+Af125o71dGyCAqFYGbwnIjbb
	5aSoQ07kCL0WQM9mqooiJD+mM55qWSnfKi/GIN7ntqnU/bx+rU2PqGNZv9xVYHVptQ87ddhwUfJeZ
	YtRszkOg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgWgq-00000004R13-18BI;
	Sat, 02 Mar 2024 21:14:40 +0000
Message-ID: <f825a8ee-ecc2-4de6-b743-1b8a9e3c09f8@infradead.org>
Date: Sat, 2 Mar 2024 13:14:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mul_u64_u64_div_u64: Increase precision by conditionally
 swapping a and b
Content-Language: en-US
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Biju Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20240302205426.639205-2-u.kleine-koenig@pengutronix.de>
 <20240302-deed-greyhound-f0c6c831e4c7-mkl@pengutronix.de>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240302-deed-greyhound-f0c6c831e4c7-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/2/24 13:05, Marc Kleine-Budde wrote:
> On 02.03.2024 21:54:27, Uwe Kleine-König wrote:
>> As indicated in the added comment, the algorithm works better if b is
>> big. As multiplication is commutative, a and b can be swapped. Do this
>> If a is bigger than b.
>>
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> ---
>>  lib/math/div64.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/lib/math/div64.c b/lib/math/div64.c
>> index 55a81782e271..baf6f8681907 100644
>> --- a/lib/math/div64.c
>> +++ b/lib/math/div64.c
>> @@ -190,6 +190,23 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
>>  
>>  	/* can a * b overflow ? */
>>  	if (ilog2(a) + ilog2(b) > 62) {
>> +		/*
>> +		 * Note that the algorithm after the if block below might loose

	s/loose/lose/

>> +		 * some precision and the result is more exact for b > a. So
>> +		 * exchange a and b if a is bigger than b.
>> +		 *
>> +		 * For example with a = 43980465100800, b = 100000000, c = 1000000000
>> +		 * the below calculation doesn't modify b at all because div == 0
>> +		 * and then shift becomes 45 + 26 - 62 = 9 and so the result
>> +		 * becomes 4398035251080. However with a and b swapped the exact
>> +		 * result is calculated (i.e. 4398046510080).
>> +		 */
>> +		if (a > b) {
>> +			u64 tmp = a;
>> +			a = b;
>> +			b = tmp;
> 
> You can use swap() from linux/minmax.h here.
> 
> Marc
> 
>> +		}
>> +
>>  		/*
>>  		 * (b * a) / c is equal to
>>  		 *
>>
>> base-commit: 1870cdc0e8dee32e3c221704a2977898ba4c10e8
>> -- 
>> 2.43.0
>>
>>
>>
> 

-- 
#Randy

