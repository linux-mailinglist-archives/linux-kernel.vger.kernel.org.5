Return-Path: <linux-kernel+bounces-158089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9875F8B1B51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A9DB21825
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9FA66B5E;
	Thu, 25 Apr 2024 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xr4NYuYx"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489B5A116
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714028217; cv=none; b=uPEtI8EA5VgthqjbdqtfvLfPPKSZkIwipPVQZqx0TzRKuioGVtvWuxvI4xURtxhfYMz263pgGc3kHc5OtKzOSun0+qqH2hHSQ3XfUuygwX+2aUKkVbrAazXdYudGJzh0sSsiDp/foDu3jLOVpzn7bSBZ1i06x1ngWmNHnIZgmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714028217; c=relaxed/simple;
	bh=gutV/l3zNwt39H6PkS3oMjEZAnVl5VIlC/aAXWw6L1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ks2xGst/Pn5ZqqvUdhCyX/7ya5jKnDSaIb1qdsm4DfIau+8N0UFbXmNVTiTHU3j3Aey3ADecDl6TdAUrF/6Z0xg1aNrp9Bjy3L3ZouzWWvVSzimiV+a4iMSRhg/GbkLMncPDV1R/d3WjWFHJ5pwsf2sSADwX7w434Ejc2WaaGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xr4NYuYx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so694323a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714028215; x=1714633015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4kDeA/DdCP44UQEEZZWDJudGGyAKphhBXeK2Po9a8ow=;
        b=xr4NYuYxsW+Wnz/4JZ9G/s7/8+bCqeywM3lAGGmGxprMnzNJ0p9u5cAOj9qsLVBCnB
         3m+T5lDk1yxuRzFLD5Lfmbreb/nvJeXxfE0EeDFETNbY6YE+i0xCGGcGPn5hMXNQK+iY
         rBbKt436tJ02pd/9ve5GrKVCfzWbJFWbJdenZND+mT4BGOFe/hBpvm6JTNOWf7amL+Vo
         Mkq/Bc2L6TI/BbtQShhm89an5u8Qm25rm3K+YNTNJR0wYWUGAVU7rXwbtk9UBbL6Ht1K
         afp2Zce00CiN4Qv2K8oPPVHwgGf7GuhyGEjENcKmdiPbnMF47onWY6u12WvGFkc653Yn
         EVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714028215; x=1714633015;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kDeA/DdCP44UQEEZZWDJudGGyAKphhBXeK2Po9a8ow=;
        b=g8STkGJ388Nd+8lbni/DqUkTl2zBC8o44+WO1VSkixymRqRdIdRYp2QYqivj0QGU9g
         Gb+Vfwunji9lNEUZCp+PyunJuBfjSnF4Hp8khIMpie4MoPbG2TitU8TjH4vKJ48Omavx
         nAQOt2/uKGrxVTaH9BLB94CPce7nCdRzsDU5y5YODolaD4LuTiGCfz0y5/Hz7bYTuWIR
         n23Q6c58QXoFYFxOlX/BvD7xAxlTi/C4JZFy2Vq05ALl2o4hfAK0M68zyN1adVtZGjMj
         O4fd9tFt0fk4dXyw7/QJ0hb0JREdEOA6O2c2O5kiingw51Kz2n3Px5OBmUib9n1tjPBO
         /ANg==
X-Forwarded-Encrypted: i=1; AJvYcCUwcJFbF8JQRhiWoZwCRcdR8Kft27O0nZAF0RedXzeUDVbT/KVyBOfdPxqVHBMnafOdN7ivNA852FImSvpZ3xrXYhYV2Ph/0TiCm5W0
X-Gm-Message-State: AOJu0Yw3HBZvjNuVZw2cG9TeA+4sijioFypKOuH6ylVcU1LexSx7nBv7
	8VZbloPQYxgfRSIS6jRxdpJ/jP2p6zUqujaXO8ulwWFQbk1fuiwdcR4/aKNoEyY=
X-Google-Smtp-Source: AGHT+IEb+mDFzxt8WPf8QMuzryOz1XEZwoFaFKxpdKbvv3biGHTvP4YoubTjU+2b4haqab6XVhpoLg==
X-Received: by 2002:a50:a445:0:b0:570:1ea8:c50a with SMTP id v5-20020a50a445000000b005701ea8c50amr3528815edb.6.1714028214573;
        Wed, 24 Apr 2024 23:56:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id q10-20020a056402248a00b0056fe7c5475bsm8666953eda.10.2024.04.24.23.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 23:56:54 -0700 (PDT)
Message-ID: <b9b3ccaf-7ad1-485a-9ee8-9a9922936e79@linaro.org>
Date: Thu, 25 Apr 2024 08:56:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] dt-bindings: clock: Add binding constants for
 BLZP1600
To: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: James Cowgill <james.cowgill@blaize.com>,
 Matt Redfearn <matthew.redfearn@blaize.com>,
 Neil Jones <neil.jones@blaize.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240424133241.19210-1-nikolaos.pasaloukos@blaize.com>
 <fd4072dc-7cd3-4d13-a15b-d63c675a5994@linaro.org>
 <c11194fb-0449-4b36-adf1-c15d7a66344d@blaize.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c11194fb-0449-4b36-adf1-c15d7a66344d@blaize.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 18:14, Nikolaos Pasaloukos wrote:
>> No, they cannot be invalid. IDs start from 0 and are incremented by one.
>> If you have holes, it is not a binding.
>>
>> Drop the header or use it properly, so as virtual IDs.
>>
>> Best regards,
>> Krzysztof
>>
> My intention was to avoid using magic numbers on the DeviceTree. That's why I added them here.
> Also, we have some custom drivers which we plan to upload and their schemas need those files.
> The alternative would be to use magic numbers for our clocks and resets.
> 
> In the commit message and on the header file I have mentioned that these are numbers matching
> the hardware specification (1 to 1) of the chip not just enums.
> Some IDs are invalid because of a hardware gap, some others are invalid because the SCMI
> service will return an error that the number is invalid.
> 
> Is there another way to prevent the magic numbers in the schemas and device-tree.
> 
> Thank you very much for your fast and detailed review.

Bindings describe the interface between DTS and drivers (OS or some sort
of other software). The purpose of binding headers is to document the
constants which are used by both, because they are part of that
interface. Therefore constants are pure abstraction.

Let me rephrase the question: Why you do not have headers for interrupt
numbers? All addresses? GPIO pin numbers?

Best regards,
Krzysztof


