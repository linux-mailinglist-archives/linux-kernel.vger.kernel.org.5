Return-Path: <linux-kernel+bounces-137854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F12CE89E84A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F031F26224
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE2944E;
	Wed, 10 Apr 2024 02:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRKCYsLl"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EAC8464;
	Wed, 10 Apr 2024 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712717376; cv=none; b=DX3vdcdH9VBAaxtH6Wd8hrFrzfTjMprd1GemLXGXxTUs0eFLF93bx+uWeHLYswMlWawxqcequK8ABilJNvt/+7ECrMACDRw8RWAAP+6HFmNv6BWQBjJM8a/uJBQKGbssA1g64fJ4mvcXq5HT5qWTT1RZIqfjDxDvfjVPsR3kFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712717376; c=relaxed/simple;
	bh=vqxOi0QTxedbvwYGD+HYW5L2o0KZGcG/0tL626Tvz1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9vLDKBHwQDa0ieqFabtxxyPPwRS+s2M1o2x1WAqawpShALc1H14kmRQNNCrSOdS6VPUc2sw8nVWD5HGH1QqG1/KjIyovsO5dbGrIVkSc4YcWxdkEgOnT11tjDTc50K2vXwU2L6z53/mFKvlL8eRmQvicSc+Flavuz89vd5v1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRKCYsLl; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso2005010b3a.1;
        Tue, 09 Apr 2024 19:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712717374; x=1713322174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG6xWQ0yCGVJl/MNKg4FH9ZwsPiElj7Y50UBk8VG6lg=;
        b=XRKCYsLlCRc3lSZNyfbBcP1/AlNCIup44ySs8kAfzPlHiv6V+7/aXgiaDwDleXC9ns
         oQgAks3fvjOxcTOhv5RdL7o2SwLbatvkThZkSxq/I0aT6MBObIHxL5Izok1pHnVdEObe
         x763gqtshQICyHpT6nk/g2esOvxSQTSVCaCvT4O1UEt+/LpAMMA4A/8r6VaeNAzP/uAj
         ffm1iL53CzXkowoX2lwo7rWkWkkqy/tnhMdz3z49s6bF6WUILcu0uUOlGlq88LEw5Hpa
         vb0jnGedD4z0U8jlLYFF49qt7rSWGCadKC/1vCKW1hytiDU2mCCqZBHFNppYyobdFKj6
         al4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712717374; x=1713322174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kG6xWQ0yCGVJl/MNKg4FH9ZwsPiElj7Y50UBk8VG6lg=;
        b=jYP4xgRvqJRb3NDaVYaAejUjgETHOnCPvf5r0Rh0Hk5lE8qWEuk/rXVnPlk2Rkd4Gj
         Q71+xAJORLqn+Cm7Homo6AnQOXYCQ6VT7akgptpEyKdFZNbxDWdhZcUyR3ZCa5PGDkGw
         a/C5WooUDsQ1FOic1BQDZ1ye2eUDcD9RK1cpkvquuXFZSOiQwo5g/PJOs2OIWRvyTP5n
         nutk4Urm26HK7UBMUJTVZU/DCyhPZ/bTrBwcFLQHuDFbAV3fTWdZl/CvP2MKEft7rjhY
         6WbWM6H/02eDPz//3VZ139WBmYLwSXQJoLc0txic5BKztkxf1jsKGagapCLfG4NF8hp1
         wyZg==
X-Forwarded-Encrypted: i=1; AJvYcCWGmcJ1ygIPQNdfDMN4sh2NfQKWsEI3MrXG2vCJ5zrf380ldL7pS/y7zDkWfvLsoSQsbreDu/C7C4+trgp3TF1Z+w30DcbP54pbgGq22SoPYEiAfx9uYSkM5PoIzBFTMQNVNGxHAVah9n8qj/qbXauAIQFTUokwpcUs/GdhUD7gUMFYVtp1hA==
X-Gm-Message-State: AOJu0YzIQ2BBkYfUjgUZpOatj3Z8uWugfN9wFixG9f0RPu5dTO00fkxM
	ARi041WyP+G+DqxSQMcTc7tNSP9xOKA6aAbnu2N6SA8DclZNXTdY
X-Google-Smtp-Source: AGHT+IF0GlULpUAxxK4GQn2bft3LURYvb6qaqhircdJMse1NfkNnqKFaq7ajDd0+kVBJHMc+a/oANw==
X-Received: by 2002:a05:6a20:2591:b0:1a7:53c1:ad8d with SMTP id k17-20020a056a20259100b001a753c1ad8dmr2308422pzd.24.1712717374183;
        Tue, 09 Apr 2024 19:49:34 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.16])
        by smtp.gmail.com with ESMTPSA id e9-20020aa79809000000b006edbcfe7005sm483193pfl.144.2024.04.09.19.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 19:49:33 -0700 (PDT)
Message-ID: <4f0950f8-e0e1-4b26-85b9-385c97c39cf6@gmail.com>
Date: Wed, 10 Apr 2024 10:49:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] serial: 8250_pnp: Support configurable reg shift
 property
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-acpi@vger.kernel.org, tony@atomide.com, john.ogness@linutronix.de,
 yangyicong@hisilicon.com, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 lvjianmin@loongson.cn, albanhuang@tencent.com, tombinfan@tencent.com
References: <cover.1712646750.git.albanhuang@tencent.com>
 <ZhU6Or3hTziarHZo@smile.fi.intel.com>
From: albanhuang <albanhuang0@gmail.com>
In-Reply-To: <ZhU6Or3hTziarHZo@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/4/9 20:53, Andy Shevchenko 写道:
> On Tue, Apr 09, 2024 at 03:43:20PM +0800, Guanbing Huang wrote:
>> From: Guanbing Huang <albanhuang@tencent.com>
>>
>> The 16550a serial port based on the ACPI table requires obtaining the
>> reg-shift attribute. In the ACPI scenario, If the reg-shift property
>> is not configured like in DTS, the 16550a serial driver cannot read or
>> write controller registers properly during initialization.
>>
>> To address the issue of configuring the reg-shift property, the
>> __uart_read_properties() universal interface is called to implement it.
>> Adaptation of PNP devices is done in the __uart_read_properties() function.
> You either forgot or deliberately not added my tag. Can you elaborate?

I'm very sorry, this is my first time submitting a kernel patch. My 
understanding

of the submission specification is not comprehensive and profound enough,

and I didn't intentionally not add tags. I hope you can forgive my 
operational mistake.

Should I just add a "Reviewed-by tag", or do I need any other tags? Thanks.


With Best Regards.

>

