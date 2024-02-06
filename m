Return-Path: <linux-kernel+bounces-55342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6024884BB73
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AB91F24607
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EA9C15D;
	Tue,  6 Feb 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ZtG1jzlQ"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536EBA37
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238457; cv=none; b=PWR3p04eZZ4nyrAVxt7nowUkv9RzqYye7MPUZzknJ5CpDCzgs2FATV+Ky+EXatrai9TrZ1Ug3qRVJqn4WqTcPG0nZaBzokPp9WAKiskEjktPv+LClTk3qwOWcVd4HSszWozwa9eh4+RN69cqmZmHc5E6pSHms8cMaGXSw9Dw3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238457; c=relaxed/simple;
	bh=qtsEqJJzUy+Olwx/XQm8yqhZSbPc1Y5DjvZrKNlVnIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrIOh/djlE4Yz63ErgKeQW8OHQnKO5N+zByievtIFMnm76Lf97nczlZXpTytND0cx6qAJzrjo+e1CeoZuZAKvhW/MwKk2XHDEpkex9AfDOAG34s5NQyppu7YtNF5/uTBgA3h0S4L1O279HkJlqWP2SBjf1xaAZceydwwgGUqqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ZtG1jzlQ; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id XKpore1NipUFLXOi2r70Kq; Tue, 06 Feb 2024 16:54:10 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id XOi1ruCISR2g0XOi1r6wBS; Tue, 06 Feb 2024 16:54:09 +0000
X-Authority-Analysis: v=2.4 cv=WvOIMsfv c=1 sm=1 tr=0 ts=65c26432
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=cm27Pg_UAAAA:8 a=mv_botl0e71s4ZI3RmYA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=694IBjBGjM3a3HAgb7gRub3b16bitfxqqHI5UQvfdA8=; b=ZtG1jzlQTv5kfLeA8DHmM4VSew
	asuSanJCBw/g+gaP2GAIQyETBhAX2Qfwc5ksqbSQ0qA7D/4w1NjjsGkf18KBgqiwB3TvfUxxbxYo5
	wAsNcEKGJgedq0CyG77TxncnAYtlnDYj59BpPmm8k4t9XItI1qKTVggcPwFk8W1INyUq1/YTR41hd
	vf5xSUIdCqAHbKaNu6mV8nBb5eZ+gdbcBk8vSdfPsjKRWPyyyl4OTluko5j3sFXnR7y13B4/KcsrQ
	ogP6mFTV0plFPNzpUAUC+K7x4Vwu5VOJmkyAs0n7/vAo6R2nqAjmTXG2osxejq7bJ4BivLlRtFaxe
	gImTSmbA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:44908 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rXOi0-003RHh-2u;
	Tue, 06 Feb 2024 10:54:08 -0600
Message-ID: <4bde6e72-c7f6-434d-9489-3a0de7804b18@embeddedor.com>
Date: Tue, 6 Feb 2024 10:54:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] overflow: Introduce wrapping_add(),
 wrapping_sub(), and wrapping_mul()
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20240206102354.make.081-kees@kernel.org>
 <20240206103201.2013060-2-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240206103201.2013060-2-keescook@chromium.org>
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
X-Exim-ID: 1rXOi0-003RHh-2u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:44908
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMMyW5fpoTBGhOBt20rDEB4Q6DDnyj8PhmrbSSPB+gS2zucTWyAOMgWs413dxjTqJ3v1EdTDzaenQuDF6026wmMINngC2kbPZ0W2d0TlC6VhtkHhZLEN
 5vfvtC+FRtqwilfc541IltZQph+Q73q0bgdhec4Vj/PGh8jOrKELdYyfvL3skIwffmAr8GBgogGML8h28eMm8OdKcTCBRuhzifZmwZqE+jH8lNOcKng1p2Me



On 2/6/24 04:31, Kees Cook wrote:
> Provide helpers that will perform wrapping addition, subtraction, or
> multiplication without tripping the arithmetic wrap-around sanitizers. The
> first argument is the type under which the wrap-around should happen
> with. In other words, these two calls will get very different results:
> 
> 	wrapping_mul(int, 50, 50) == 2500
> 	wrapping_mul(u8,  50, 50) ==  196
> 
> Add to the selftests to validate behavior and lack of side-effects.
> 
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Marco Elver <elver@google.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-hardening@vger.kernel.org
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   include/linux/overflow.h | 54 ++++++++++++++++++++++++++++++++++++++++
>   lib/overflow_kunit.c     | 24 +++++++++++++++---
>   2 files changed, 74 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 4e741ebb8005..429c4d61a940 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -64,6 +64,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   #define check_add_overflow(a, b, d)	\
>   	__must_check_overflow(__builtin_add_overflow(a, b, d))
>   
> +/**
> + * wrapping_add() - Intentionally perform a wrapping addition
> + * @type: type for result of calculation
> + * @a: first addend
> + * @b: second addend
> + *
> + * Return the potentially wrapped-around addition without
> + * tripping any wrap-around sanitizers that may be enabled.
> + */
> +#define wrapping_add(type, a, b)				\
> +	({							\
> +		type __val;					\
> +		if (__builtin_add_overflow(a, b, &__val)) {	\
> +			/* do nothing */			\
> +		}						\
> +		__val;						\

mmh... now that __builtin_*_overflow() is directly used, I guess
we don't need to _check_ for overflow anymore.

Thanks
--
Gustavo


