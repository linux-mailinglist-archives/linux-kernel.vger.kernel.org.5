Return-Path: <linux-kernel+bounces-53876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B392A84A786
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2020228E926
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D71E8563F;
	Mon,  5 Feb 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ijLy/JR1"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962B84A21
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162803; cv=none; b=G4AZLGe7C7+B/Xzb6DXk/tJjNcqsFNH3h5tLrM/fdo67hissq/MoSBDD3Tq6poHQpGOPhZkDnpb4WKzlN+I4qM3B9pOGvcpZszaQquxJZJl/K8u9ID1wgpW5pN39xdUeGXnKwhzCYoa2FgAT804Rzd8VMK3Oks5Wz3xUL9a8tKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162803; c=relaxed/simple;
	bh=PeP4sixBKNSBpoqkCU3ELEXc4bd5Oez+Mk1RBiTxP8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBJ00YadzLNi6sl5+N1Z57ajxnUhdfcBH67T6fF2K8Yu1eJ+ooBCszQ32HTym45ZdtTTaBaVjAU0vvNYnfCCEYtiEZfjvH3X+Hx2sh9K2EKSYzQd87bzN9YXbN8U3CGc68ZyKYUJE41PmtZFHdEU9Mrak0lOElVCNQnbMrWkK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ijLy/JR1; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id X3CGrl9KkCF6GX51nrZQsB; Mon, 05 Feb 2024 19:53:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id X51mrIFEfqdhAX51mrTW76; Mon, 05 Feb 2024 19:53:14 +0000
X-Authority-Analysis: v=2.4 cv=M/LuKDws c=1 sm=1 tr=0 ts=65c13caa
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=Joi0DycZFvEH7ol7e8wA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=59uLfb3lKxxRh7YBGlA2QYgE5k4m1MCKRhCgmEryVLA=; b=ijLy/JR19EFY5A5GpYOwiM4bfD
	wD3c+fVwLPcxX13GLQAZAhhmEdTWTqodr+XtB1m8IGowFAtXX+OoW7WpglQfA/PW3cRUxsow+QVjw
	YNs/M8TmSJAYtUUU7yPrryJ0g+v6Cn3hnZrKzgHhBNXem9UqVJUQOGNGgF041lYUMbuowDUR13YtY
	wyRmEmisaSUNN6igRLT0q8i5oXvgj3ud6YShyXEobTbGDKEfr2x6OlZwpFHIHBqxRre3bkSd31xg6
	YRDv2EcB/4DpLcRfm5e2W1crwn0Ol9DOyDRZxLWvUWA8VRosg9G4qV43flfww1J4z3rIvDgB5+3pb
	kVQevRRA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:53618 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rX51m-001HCd-07;
	Mon, 05 Feb 2024 13:53:14 -0600
Message-ID: <07d3cf61-d3dc-4312-ae39-ad2ba5e0d39a@embeddedor.com>
Date: Mon, 5 Feb 2024 13:53:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and
 mul_wrap()
Content-Language: en-US
To: Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Mark Rutland <mark.rutland@arm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
References: <20240205090854.make.507-kees@kernel.org>
 <20240205091233.1357377-2-keescook@chromium.org>
 <CANpmjNNExn8DX2+Cnz3GDWXNZv-jZcpFSedCYx+y6HEemFoHRw@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CANpmjNNExn8DX2+Cnz3GDWXNZv-jZcpFSedCYx+y6HEemFoHRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rX51m-001HCd-07
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:53618
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLBmQ8ft5eQLIeHPEXNxA8HC0vVWRWqKH1Zyj8Be9eGeX6PdNwYvQeSIJ7+ph/qgZyTDfEVwuCgbQscFZfg+CVTqdqfVsJYEfXKA2nxk38mUKA9G7wpM
 3kExogUx/S7BkhZ+qVPjwq7mlehS+jVVbcWpjeNWpUZgbgAWnEfHAVVl21h9sWDVdie29bUFnVhmWhZCchK9XcIP7aEkfwl0Keil153X2L0OwFnoDMXHgTJT



On 2/5/24 07:31, Marco Elver wrote:
> On Mon, 5 Feb 2024 at 10:12, Kees Cook <keescook@chromium.org> wrote:
>>
>> Provide helpers that will perform wrapping addition, subtraction, or
>> multiplication without tripping the arithmetic wrap-around sanitizers. The
>> first argument is the type under which the wrap-around should happen
>> with. In other words, these two calls will get very different results:
>>
>>          mul_wrap(int, 50, 50) == 2500
>>          mul_wrap(u8,  50, 50) ==  196
>>
>> Add to the selftests to validate behavior and lack of side-effects.
>>
>> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>   include/linux/overflow.h | 54 ++++++++++++++++++++++++++++++++++++++++
>>   lib/overflow_kunit.c     | 23 ++++++++++++++---
>>   2 files changed, 73 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>> index 4e741ebb8005..9b8c05bdb788 100644
>> --- a/include/linux/overflow.h
>> +++ b/include/linux/overflow.h
>> @@ -64,6 +64,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>>   #define check_add_overflow(a, b, d)    \
>>          __must_check_overflow(__builtin_add_overflow(a, b, d))
>>
>> +/**
>> + * add_wrap() - Intentionally perform a wrapping addition
>> + * @type: type for result of calculation
>> + * @a: first addend
>> + * @b: second addend
>> + *
>> + * Return the potentially wrapped-around addition without
>> + * tripping any wrap-around sanitizers that may be enabled.
>> + */
>> +#define add_wrap(type, a, b)                           \
>> +       ({                                              \
>> +               type __val;                             \
>> +               if (check_add_overflow(a, b, &__val)) { \
>> +                       /* do nothing */                \
> 
> The whole reason check_*_overflow() exists is to wrap the builtin in a
> function with __must_check. Here the result is explicitly ignored, so
> do we have to go through the check_add_overflow indirection? Why not
> just use the builtin directly? It might make sense to make the
> compiler's job a little easier, because I predict that
> __must_check_overflow will be outlined with enough instrumentation
> (maybe it should have been __always_inline).

Yeah; I think that directly calling __builtin_*_overflow() is a bit
cleaner.

I wonder if there is any particular reason for not doing that.

In any case, this version of the add_wrap() helper with the `type` as
parameter looks much better than the v1 that relied on `typeof(a)`. :)

So,

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo



