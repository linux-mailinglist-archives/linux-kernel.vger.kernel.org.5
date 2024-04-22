Return-Path: <linux-kernel+bounces-152768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BFC8AC3FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503A6282903
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B986E18654;
	Mon, 22 Apr 2024 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mr3ow0V6"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56A1B952
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713766020; cv=none; b=tZQa9VjhgMgwr4UMPDww/wnbQ9vEAdpyMazwhuqFJfQifmCi63kSfNJ8lhDXTE7s7Qrrpl2UHGh+1J+aq73eki/4+cQ6jLv+/aMo5UFVHGHFd13XKMBeInGwHLZELN6oVBWYnDVZZx6PkRJsGY40CfYMb+RPNGDtmohbf2GMz3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713766020; c=relaxed/simple;
	bh=g/dC3aqszW4WBRqrIUZqM6bgnMZxMjwSBSzDUmPYeq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQEo6JAUwd5HHEYnFcclz0BKxA2U9ywXOKRRJd7HITYDq6b/6BX2PtWRZObLUxxSdJ8ptrzIUxIMxi+DQKj8LX1daecRpblNFWXl4RzOrKRhQI+gCmruo4NyhTiyeZzJ9yP98t5eEWLnY0vimkmBecIfVspkTUSooigw6+FNDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mr3ow0V6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5544fd07easo439561466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713766017; x=1714370817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/dC3aqszW4WBRqrIUZqM6bgnMZxMjwSBSzDUmPYeq8=;
        b=Mr3ow0V6cYlQoijPmWYluRRw7LnNfL0ph0xw1Im6wbujgFMvNFoe2ofE9AJfG7bmFT
         fDoVU5HHcprSFfAfLh/qPSqkw32X1Gqv2qz8+0CK+PADhUnQ+v7T7CtHrPihBezDJFEu
         DSbqZ2E5D4N9M0HPqJeNc/NHycRSd7FspX1pn4tM0dme21wh27VCRkv8SH77Z07U2xAJ
         98pEVRMx7s15ngolGZSBxaCqOts9TVi6iOEs97QcvqJaYn4XoaLAO5f8NkQi4SPdKs66
         Sjs5+PaBZqitVpHCiJ0FEXnjT040qVay8hPmLBCfZjW3unsE7lujaK18ayd0s5qaXVjK
         sNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713766017; x=1714370817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/dC3aqszW4WBRqrIUZqM6bgnMZxMjwSBSzDUmPYeq8=;
        b=HYRERg6WG5ZCGkhmrO9jktCL+56KW8fhFxVoZpwvQbHJ7hcqOfIjRvo67K98an5VrN
         lkwDK6TyTCjI+qSkPXy03cxqPk5VWLR0zOO/7r+mXewUQTR4bd/9xQJCJY8RTWIELCW5
         FIQcI9BzbZE1I1orSBrNymgl+vUMLYygcrIyap2a1H1V3GT7F6QJod69qkpYQhEF30tw
         mSsaf1jYftkH2f1qj92iYFUzTzhyliXyqaXbDP0OMhyBX4UEFUMIBCT3ekYiELyKMTIm
         q+/zsQwbju4fkN9NrrLpFpGnfhkh+vxbd22OvTUtrtbE7iVK7zN/Nv3+3/7/2A5kLdnN
         9PaA==
X-Forwarded-Encrypted: i=1; AJvYcCVGwzl1Qno8/2dYqK6Ftcr9qKs1skyMDi61jTRn4tbEn83SqUwtRUiNx3j8rXgp7J2X6Q45okzRV4/qERvdOGdz9E5rtvXS/PDatQGZ
X-Gm-Message-State: AOJu0YzgZBE69o5KmWecFuxUhDkL9zM20JfN3rTAHLc61delqanjTY7Y
	RBC+F8CfqIN8jK+tAaxCO5f4is3YMhW6kCO5vSE94Fiq9qCuu1hrckI8AUYWctVw5JbWptAdDvC
	7
X-Google-Smtp-Source: AGHT+IHSmA22k8/6J8gpztZttq8B3EuHe5yI/0R1vw1tNMB4yAnqjGAza5P9adcpQYd0ijVbD6FkJQ==
X-Received: by 2002:a17:907:9715:b0:a55:b42d:e499 with SMTP id jg21-20020a170907971500b00a55b42de499mr1614968ejc.45.1713766016645;
        Sun, 21 Apr 2024 23:06:56 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
        by smtp.gmail.com with ESMTPSA id qu20-20020a170907111400b00a5242ec4573sm5294075ejb.29.2024.04.21.23.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 23:06:56 -0700 (PDT)
Message-ID: <33e23cbb-4e52-471c-929f-65316e668ae9@linaro.org>
Date: Mon, 22 Apr 2024 07:06:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] mtd: spi-nor: introduce support for displaying
 deprecation message
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20240419141249.609534-1-mwalle@kernel.org>
 <20240419141249.609534-7-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240419141249.609534-7-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/19/24 15:12, Michael Walle wrote:
> SPI-NOR will automatically detect the attached flash device most of the

SPI NOR. Looks good. Please follow up with a patch in the same patch set
to use deprecation_version, otherwise we introduce code that's not used
and we risk to get patches removing it.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

