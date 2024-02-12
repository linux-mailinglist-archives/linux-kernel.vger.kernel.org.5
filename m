Return-Path: <linux-kernel+bounces-62172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D233D851CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440AA1F237C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8E23FB35;
	Mon, 12 Feb 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0gse1X6"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5743FB30
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762341; cv=none; b=gvSDQvLdFGaYdkX8jPUNid6rxS4W1V4qn357I3ivr/Cp680v07B14c/V3G2rXhd9ndv3RFMJ+WMxv40IPRZVKWMGYrQ3BGi5zEPhJv5FVcjCVMSNtFgLG09qoESydT5y3hKwZaWoKMg4lhGgXZtFfU0/1gQqYz6ivfDIJNTCtXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762341; c=relaxed/simple;
	bh=QCAdiSixOOAfTV1OL+MhLQmlhBjr4llZChybdPe8JKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bXOq3QSgT6/xV83dNKb4fRqBrJGaPp8PAjUXGgnKiTq2hWFRuvakC+AIQNEeNwRtAPf2XYrYPYEqsZjGqKcU7XUAUPrcLjoNT8nWpKMKRjWOVI6KxecfTS8Y44QakSUf9hhPJ9kLcGdpb9+gw8XMSu7q5zbNijPW/KCYTkJEUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p0gse1X6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33aeb088324so2285104f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707762337; x=1708367137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l6GRYGgHR/F8CWf9D6N6HBpJsxEZ9YDwSZEX5rV9iIU=;
        b=p0gse1X6OVwvs70rZz0PPInaxAuIrj+MlsleVhC/gPNWTNW1f5kwlL0R+dnHnI8Nfr
         2gon2H7TG4gMbj2cMHnE7JxjEtXDrXIGp21oNEL7YlppNf7VWIrSpbfOFknkf0ar1k+G
         wJgIX/IuXpRo2upaCChOxyyo2Vv2PcIZOKeoYb2xX9L9RRrbCDxJYDDhXwAq5e5asym2
         8PcfGBd1Bw8zx7cDpbJLtuTvMbACs5fHRo2SgG1DRL7OsALtY5fZP9/gzuFYW0Mikqhl
         6AXTVS9Mk2HUq+QeYwj53OdHaxk0UoTOQZhlmNYzPeJe3YXlV3aplK3qDBWf4Nlo3kbH
         KUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707762337; x=1708367137;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l6GRYGgHR/F8CWf9D6N6HBpJsxEZ9YDwSZEX5rV9iIU=;
        b=KJFGPFv6nNlwDEPz8tDzbEzmViMygJnOyWKohepzphkTQfDAMrwviq9Fn7FEmBB5/m
         lJW0/IcsGkPrPje3OhgxoD2RSLMytUJWKQuw54vWl4WTGqWUq0HTbYr+y/I23ihJK8XH
         30tmhxQcaOro5HCUn0eRbSFO1uZAtQZOLFaDfWAgPCTm1Zx8o3A1whgnQShYeYSrYRqT
         QFskTJkDNTPCUQCi6qv/ecYiJB3RhSzbj8D3HpF6Gt+JeYuWScpqyvWcsg+bbNE/khAq
         OaoFtLnSJWb4dDQ/kcxEvF17Ow2NFkxEFESlEYdSfrQLGZREWOlDMi62UiGJuKcUx0pW
         gh8w==
X-Forwarded-Encrypted: i=1; AJvYcCVQloJEX52nADJRXbrbFLvBGWhj3XFfAkg1uXE+i9ZTaModw7dwEn8i2u29bfCI8u+0kVEjqtNyCPNVKWrrWq7dHuINUhTRafp9h9/b
X-Gm-Message-State: AOJu0YxTuQgZOygcdYDvBoba86IXlaffIp10RWztJk7nBnARMiFKjZTW
	zKKa9RfZZVVevC3xFhRtOFy2BFH1dZ0LMFTkg7M1kIV04Q8UGYqsQM8LGShxcDw=
X-Google-Smtp-Source: AGHT+IGFep+eHR6QtfJDvvDfeSHaUH1yvtmJCeV9pK5e4nMMYJZObzzpihqYx9RQK/LNclGU4fMBzg==
X-Received: by 2002:a05:6000:1a88:b0:33b:74a3:db94 with SMTP id f8-20020a0560001a8800b0033b74a3db94mr7349571wry.2.1707762337683;
        Mon, 12 Feb 2024 10:25:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWci51KCqwBP5hE4mrR+zkOWQs1zKBwyGxzvMYPtWNcRvtgvitTEnxeiFruW+R5TVqVtsyxYD2ufnxvxF5rXxxQpjbfQhxp9udE6tTqzfSwCrPP5koSSxpINk79M2f1WmEl+6jb5kiiJBeweqjb5tx+fTI+6fBsMGKBSlQWZtwMmiGeW/vGoX/fcrMDdZShBkFSmYrgFvGL0wncVnOQHdyVajdtsYS7aQAu5shA2HGpZQjF1quL/9twPelruey9BgKkuYT4R2OeUPcK6tu319VYPHBqMkykrwEfuGNBXciiAq6+v7w8OA==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id e9-20020a056000120900b0033ae54cdd97sm7422735wrx.100.2024.02.12.10.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 10:25:37 -0800 (PST)
Message-ID: <b8c52d6e-2e02-4c53-9ec0-e06460a098e7@linaro.org>
Date: Mon, 12 Feb 2024 19:25:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-crd: add sound card
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207085615.27187-1-krzysztof.kozlowski@linaro.org>
 <46785ff5-2cac-4d77-be8a-c005d85b5947@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <46785ff5-2cac-4d77-be8a-c005d85b5947@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 22:26, Konrad Dybcio wrote:
> On 7.02.2024 09:56, Krzysztof Kozlowski wrote:
>> Add sound card to X1E80100-CRD board and update DMIC supply.
>> Full schematics are not available and the limited available parts
>> suggest that DMIC0-1 use BIAS3 and DMIC2-3 use BIAS1.  The DMIC supply
>> is unknown except one remark for VREG_L1B that it is "used for DMIC if
>> no WCD".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
> 
> I have little idea how these things are connected, but brain compiler
> says it looks sane..
> 

I managed to get DMICs working (to my surprise!), so I will send v2 with
Rb tag and updates.

Best regards,
Krzysztof


