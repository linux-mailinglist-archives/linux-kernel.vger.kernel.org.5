Return-Path: <linux-kernel+bounces-79623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8138624D0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D8828364A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6383A8EE;
	Sat, 24 Feb 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muaqQGco"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D7D3EA76
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776223; cv=none; b=N308kHNrx2+Ja5qZtEFVHo4jHxLHwndJAdJgDtDoDXGRzuvkl+XBAy5OAM51EVQiEGzWQygAWoW0zZSsDqw1STW+AtaVhqCB33blk0FOAQXq6zYmRVQ7PKVivj5AZWavkoNt+36EnAELdJcorbMv94/pmPsrKO4slNe0CtS558Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776223; c=relaxed/simple;
	bh=jO10embex+Bf6xbn4BYsBQ98ND2hoQf48Xh3mKPX8u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmrW/wgOoP7iKY5WX+XiqeSQATs290urplrReJgqzkbzzAatdEUSQA0gJdJU4e4IhrYt2YTih4VHLXbLcIiB+P+eGOPefyb99Q+pMh76TjKMiXE9bgqyjfIvB//11SDDe8yUFklqgzojgPrYI19NCIcKxtIEHIQQu3HoDJWpMFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=muaqQGco; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so2312195a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 04:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708776220; x=1709381020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90ZyZHQLm2RnMA+ooYi+b8gBaaM7WoUXSiz8JPfr7Gg=;
        b=muaqQGco6qRw8Kh0qM/tNRWWZ20qzhVQE99roqvkuWaGr3UO+FiPDkUFA6/aDKYGZ2
         NA0gglcG3rgg3d1AzlyJSRq9nE15imcBrXZP2XF60KjwuI832RkFq/bphp6+dSSfZJoy
         7bWsO1tkeS11ku1Zd3hSrH+bxGdtUBJIAVqnR2BlsZ14y3WBmqVRYgNs0fJOuVEgNbUY
         D+V0x7Fl5pLPgRq3MdaDV85UwrqG6VDbr0wY1JniZp0nwon4w1jB8Lx7FCHt/lg1jq5q
         Egtkji5BxNGZucGx3pjD/1cDP/D4NZ1NBqtn3teYY7ko3Db97CUKEP0SY5ZzrVQSrela
         A1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708776220; x=1709381020;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90ZyZHQLm2RnMA+ooYi+b8gBaaM7WoUXSiz8JPfr7Gg=;
        b=W37Wqdcg9O4kIHKhSRF6cBoq6PaCWnQrnRoE8EFHVLVH/Ip6ByjIBeqcfwuTYKamdM
         imH6+n6LlInpqTizaHS/PYuvvBpqFDRrlCISUq6qNKSWb535Q5Qz7aGTWljbupSVuc9U
         mCnmQ+8YKpdhaLSVA+izar/jxfp+ogowONCrozrRzVvmbjJ1jbnea6baMec+mknMJjjw
         hgTpymYLwtsa47e6p9Tz9jxE5XS4XJRuXNM9QHZvJ0Ovo6vl/lsqn+Tr4tgPvfskJfGj
         YBMr9o/bJ2+EGul6RNBd3lMRcbYoCvyn62ABgXb25Lqn09SKJ3a22Mw4JwHkX/VlJgzD
         hhjw==
X-Forwarded-Encrypted: i=1; AJvYcCWiJcolOILRO5ipL0Cexwx9KZyCjyBgW7Rzioy0RzazT4afs9RYYdGcUBedRzFRjVhbYdVt4rOHzHyE2O4L7DutEqbPLVU8GZl577SH
X-Gm-Message-State: AOJu0Yy3oNvGYJfNcS14CJyHFKArszX1lH/QE2pveyPUEAwShQCIkLeB
	V3t9mjinXKcGkSyA9qN3QLvA3j1LOOaJKbn/r1/Kz/appOT2FsX8Zx6kOVNT8yg=
X-Google-Smtp-Source: AGHT+IFv3ZOQ9f5V17OJHEohJ8/Yg2yOCJL25pTzdTAvcWjkJiIUWzuVHQx9ObyV/A+AJYbuoTEq2g==
X-Received: by 2002:aa7:d649:0:b0:565:9fc8:ec8a with SMTP id v9-20020aa7d649000000b005659fc8ec8amr918955edr.20.1708776220376;
        Sat, 24 Feb 2024 04:03:40 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id g2-20020a50ee02000000b00560c6ff443esm475397eds.66.2024.02.24.04.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 04:03:39 -0800 (PST)
Message-ID: <ed34a1a5-de7d-4e5c-bd75-e99af764c782@linaro.org>
Date: Sat, 24 Feb 2024 13:03:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v6 5/9] dt-bindings: usb: ci-hdrc-usb2-imx: add
 restrictions for reg, interrupts, clock and clock-names properties
Content-Language: en-US
To: Xu Yang <xu.yang_2@nxp.com>, gregkh@linuxfoundation.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
 conor+dt@kernel.org
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, peter.chen@kernel.org, jun.li@nxp.com,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240221080238.1615536-1-xu.yang_2@nxp.com>
 <20240221080238.1615536-5-xu.yang_2@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240221080238.1615536-5-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 09:02, Xu Yang wrote:
> Add restrictions for reg, interrupts, clock and clock-names properties
> for imx Socs.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v4:
>  - new patch since v3's discussion
>  - split the reg, interrupts, clock and clock-names properties into

Duplicated patchset, discussion is in other thread. To make it explicit
that it should not be applied:

NAK

Best regards,
Krzysztof


