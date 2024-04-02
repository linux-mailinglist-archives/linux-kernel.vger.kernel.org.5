Return-Path: <linux-kernel+bounces-128012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC588954F3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03471F21ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297C8005C;
	Tue,  2 Apr 2024 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLzsVhBA"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3882C60
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063585; cv=none; b=VBIqL6pNPN5u9uCw5cKSjVMMm7hnz2IMU/O5CAHbSeQTaPLWRK5r7CTvsGIevD5OJmgIK/AoI3/ODzbF+9BX56aqe3+8jIkLKAfveQQapWeoBJNa0rpw8utBfuXtoWhAhHutxiDnb1bInWxC3n1e+j3dpwK+K+O7ZHnW650aYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063585; c=relaxed/simple;
	bh=MV0r7ILmqAUm1eYeve1JXDNmFirGUnWGhaKakrIQcwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyESvyibfr+Cw3u3W5UvP43CXuUB3jIvFEkrdzeKMpnQj2JgAZ3G6wmNPNuO0oh0ILebKj3SFlXiTNHONkqzTgsLC0/beB1JrcivuejZYCGfFoPCRJcmVlFFIi14VOfAKo0VZXEf6/U5v/8u86swoNiuWXrHOT0TyULeAh55s3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OLzsVhBA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-515a81928a1so8432047e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712063581; x=1712668381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4TuUOYGeggWez/zZEepEiH4AWH+6tWQFqi0JCmkSot4=;
        b=OLzsVhBAvbs/8tGtfJLuIftROxTGru1+0dXrCi0e/aLtaljAL5GD3ip+paIeo20r/B
         6uMDuKR//Goy3OnaHQS6PYf+FAlMzIkU74Xh85/ClvBdsQoStRKujR/4a2qmjBX1Y07C
         ko4BId824zlqwXrRNSVunELaB8uu1zR+jti5F0DbXWuUqBvI5iMdMmsvvCNRo5cvyZD8
         wcpijRuNlEoyN3OJMn6Xv9rAuv1FZDICrA21ImL7+pO9M/kB4VDpqUN1mxbQ0OrJTDId
         G6w8LpLysxQVL2FvEPm9RqYCB7x1zrGvOkqHDiyJfsasYAg1IPeyMtLNHuRPGoem8eIo
         KjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063581; x=1712668381;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TuUOYGeggWez/zZEepEiH4AWH+6tWQFqi0JCmkSot4=;
        b=JnCffwvhQm00hS8hB6xWxoUiCDxbsqjPQyDHowvN3wiSAf+TZIgxuQwLn3OsxPmVSQ
         +YorHoRgyXk5OEwrriHhgyzx5GdYz1RvSMT5h+iM+0k/57IqbJV2MCUZ1tandAiB90WN
         mmNzfs7SchFBOElA1J7GGZreYVTDhZdd4XEYUOS3mcv/JimjFDK35TZW4RVC3NhJxGXV
         DvxH9yO7Y+APJbZ/s9gLg/oSQD42e7OQezZkO7h7BkIybOLzyxi0qzylxh3jIfBLogt0
         /aS8HMoA3HWI9Z3P3mg+ia+qydbugyz8CSuZ/TAUaWaIezr0YB2b6p7W02Q0OWgGezLF
         Qkzg==
X-Forwarded-Encrypted: i=1; AJvYcCXKXUnfg98F/ckjATbrGHyw8oGER7yLMNg1TjQur3DA5UdY4y5zgQMv8nMfcmwbf0X0OEMOBGdDryquZNzPGfpIL4KpTFR8o5YKTIOf
X-Gm-Message-State: AOJu0Yx9sTVJsv88DgCC+rNaHMUETIm5AvFWymHM+tusi1URLor7IL/Z
	j0yJE/p8VJg6XifkU+bgYDE/+pHcI1F/Ss/4msLlxnpLJOYNnwQvsln+MCJiysE=
X-Google-Smtp-Source: AGHT+IFKlTk2XRclxhgsDY1CUmNeZ4uoCxsXT/ODV6gX2FKP5vliivh4SQM7A1MelSuyn/0lwfhtUw==
X-Received: by 2002:a19:e053:0:b0:516:9fab:75de with SMTP id g19-20020a19e053000000b005169fab75demr1544583lfj.5.1712063581322;
        Tue, 02 Apr 2024 06:13:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id dp14-20020a170906c14e00b00a4734125fd2sm6452990ejc.31.2024.04.02.06.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 06:13:00 -0700 (PDT)
Message-ID: <f52f3d30-4ddd-4338-b4f7-c316633b7c4b@linaro.org>
Date: Tue, 2 Apr 2024 15:12:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] spi: dt-bindings: add Siflower Quad SPI
 controller
To: Mark Brown <broonie@kernel.org>
Cc: Qingfang Deng <dqfext@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Qingfang Deng <qingfang.deng@siflower.com.cn>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329015147.1481349-1-dqfext@gmail.com>
 <261f2995-b279-48bc-b9d4-023a8a705857@linaro.org>
 <c4df0a94-be48-464f-892a-7157cb30f034@sirena.org.uk>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c4df0a94-be48-464f-892a-7157cb30f034@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2024 14:22, Mark Brown wrote:
> On Sat, Mar 30, 2024 at 06:42:11PM +0100, Krzysztof Kozlowski wrote:
>> On 29/03/2024 02:51, Qingfang Deng wrote:
> 
>>> Add YAML devicetree bindings for Siflower Quad SPI controller.
> 
>> Describe the hardware. What is this Siflower?
> 
> That seems like a perfectly adequate description - ${VENDOR} ${FUNCTION}
> is normal enough and Quad SPI is a well known standard.  We don't need a
> marketing spiel for whatever IP version is currently supported.

What we are missing here is the final product, so for example the SoC.
Is the company making exactly one and only one Quad SPI? I provided more
explanation what is missing further in the quoted email and in follow up
email/discussion.

Best regards,
Krzysztof


