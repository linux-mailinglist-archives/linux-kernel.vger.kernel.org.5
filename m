Return-Path: <linux-kernel+bounces-77792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FA2860A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9C0287A11
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607311CBC;
	Fri, 23 Feb 2024 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axldeQhc"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546811CAE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708666642; cv=none; b=J6egkJ5eOj888cv85xEt797YMddF7A/nweD3z6PyLIt+yfogS/zrHcVY6g16GLKYFy4aRA5u2v82KPxZ0oDjTHENWrzhCPwZ4Srta2pJKMfuekTEihbse+PxBk06nou8/cpRw0sfntUPX8i+L1o5Rnn8d4tIubWpyBZmU7+pz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708666642; c=relaxed/simple;
	bh=pwC8vXe2BEi1HayfXlFAjE1clRdM+GtLEtZzzi5L3ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FV0D6eWGfONttISQiTJMKeR30d8AKc4C/0A3z8Bhkehe8eNS9Hlb7WlStpFHW1IjcsigUKV5/+qE8PPgjUdWH3nfna9h4JRevj1HoVaj+q0quR7CGm/6M2IPEOtFh8WXP+2HuCt833vHY05deHz3HbOnuCm+rHYs/qnAx2+syhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=axldeQhc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e706f50beso54793566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708666639; x=1709271439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIjIrdX9a/D0bdP757W9xJG0ACMGs6E8sBOLS8lO3g0=;
        b=axldeQhcVjNNYQBYR9nxXZrGYuLtATUJBaiJsVwdK4zH3b0jisD0gJ0iEPzdIs7ELD
         XT9PaEhQxYxdeiR6plOThQPskBCHtkIy3z8jqbBc/NoKtkvAcA3Xth/GH++3nospiL/y
         CNhthpe8+m2Uw0VIsu9F6dx0176hsLg4gQcKSThLZ6+b24mxqd98dveWkllWdff7GgXP
         ucpnHyKahUotliUFcQREpEzYqgNJMkW6e0e1obluq+eBixdBDQsTfKkodKeOSXFQpBWq
         IMWoRdyheaW6P9xqxYe98FjFTW+kDUT2+IgzjSrc1rM2ALaK6HXqi9LnDdTxF/ulCFf3
         i5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708666639; x=1709271439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIjIrdX9a/D0bdP757W9xJG0ACMGs6E8sBOLS8lO3g0=;
        b=N4YB+O8THdO+qu/VKGWP6K/9ajOZoHw9jx/z5eMLh4A+XSyuvQikQt6fK/VozzCbuh
         F2pbAdVE099mkipjNRDQuvoHxzrQVYbDLW+75J3fyuGHqMvuheLZcKvGHKmZvAfolcxx
         /U4JT0GZS48kKUQ0TnEWAfeTSUKwHK07nHZ9dH+RkWJogXIsGbL7zsaX6uw9Evkzgcwd
         wQHmp3FR+zHWUcIUlOVp/gR4kypwyOCfWYeeuiRrnA0qGjH/8NqBJPP0+EIIILJwrsvF
         hI1PRcbmE1rNM0NTGjlST/KK8vIHtbYM51Jn11QrU8e+xqcTEqyIuxEWP14z5X4L1ThS
         hYCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5LMzYEn9e/Ha43C7NbRfObUZQE5zsCbvQQgpwxxY4WFI+2J/KPa0r0IM4ibWBR50UagMXWlhSOYCFDZyNB65X6MlZtpDR+ylFfZz
X-Gm-Message-State: AOJu0YyEkdoAxR3YLlZLxHWAr7xggT1XkDwB6QhPiGyUuTK/0hD2VMU+
	Z+VaeaIUED6/LraPLOv78fsgaRSxpGMc7q/A7rAnGx3Jq0IIaSStPGzNseyaiNo=
X-Google-Smtp-Source: AGHT+IHp9u8FcNkO7Rs60RgvxCzXLWbsMKeEEJK3FbSEtsuAsk96erfXlX+cVzs0qQgntOe2IKaKhw==
X-Received: by 2002:a17:906:e0c:b0:a3f:9df3:2a4f with SMTP id l12-20020a1709060e0c00b00a3f9df32a4fmr469558eji.9.1708666638805;
        Thu, 22 Feb 2024 21:37:18 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id li14-20020a170907198e00b00a3fc82c49afsm203202ejc.215.2024.02.22.21.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 21:37:18 -0800 (PST)
Message-ID: <115e1e9f-2067-41f4-8642-43e9d6819798@linaro.org>
Date: Fri, 23 Feb 2024 05:37:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] ARM: dts: samsung: specify the SPI FIFO depth
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, conor+dt@kernel.org,
 Mark Brown <broonie@kernel.org>
Cc: alim.akhtar@samsung.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, andi.shyti@kernel.org,
 semen.protsenko@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, andre.draszik@linaro.org, peter.griffin@linaro.org
References: <20240216140449.2564625-1-tudor.ambarus@linaro.org>
 <be85edb1-4f65-4b5e-a137-76e4e92d8fe4@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <be85edb1-4f65-4b5e-a137-76e4e92d8fe4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/22/24 08:49, Krzysztof Kozlowski wrote:
> On 16/02/2024 15:04, Tudor Ambarus wrote:
>> Bindings patch sent but not yet integrated:
>> https://lore.kernel.org/linux-spi/20240216070555.2483977-2-tudor.ambarus@linaro.org/
> 
> I still wait for bindings to be applied. This means it might be too late
> to apply it for this cycle. Just letting you know, that I did not forget
> about this patchset.
> 

Thanks, Krzysztof, no worries. I'll reply here once Mark queues the
bindings.

Cheers,
ta

