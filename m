Return-Path: <linux-kernel+bounces-123398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 340DD8907F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91290B24EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4CF132484;
	Thu, 28 Mar 2024 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2KvGZJC"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C751130AF3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649138; cv=none; b=nZ6eg6GXaoAbCnbRsMBEz1ZjeELC398GDcgHSKnax5Hn6scV5xNd+kKvrl/cc2q0LKQrO5pqmuHHJR4FA6fVaRnhF9UaBhqQuqDGzqqwpUJySxiWt0YCQUg5jhPID7/idSWb4qc4+JyDPHZ7vrcDn2WhMWJZuPUPJU4mo7x/kCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649138; c=relaxed/simple;
	bh=Rsol9BDp8dlaiqtmDuhM1CJ5JCNt+b7kSC7SgrqAv/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6/FzqXfrXFloDJYVS2cDNwL89p1fY8PtBp0xXylSASzE5A0Ej2XILvTuUS6+I1xmvpbrXDcSNhPQb53IzFGVZRxRfOIpDRXaXlfkI9Mm1VaeASn47tvT0Y7tjAC5kMwN2CqaUsAqucJn2baqaLWEDZ+ii013dT1xIdI7X+kRm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f2KvGZJC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4154471fb81so6471995e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711649134; x=1712253934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7i78qsEKk8suQqaQrq70K7F/HR/B+wBGy1GBI/Kse4k=;
        b=f2KvGZJC+SgUyHHNZi2V0CJo2JH8Lxd2u0PLp/LlMQSKxgqUAFTcIZt5fsA3skmw+o
         MFo32YC8NX9uKBB+irO4cJb56zEQ5yS1yp2HoY3wsi0v/Ohd5CH+3nVECg1Tn39COR6W
         qfW3nq1EvoQfomzM1U8eqqQCAh65qctNM61TE1TYuvxWXSM9sHq5qBGcEMl9dVZe7AW3
         6aQN55pRAbtleuT6G7oDq3tZq3wFNmH0X9PEdaUX39F4j1uzuXHRzqMSThjgjHo33SIS
         d7uGkhDc4he2DkY+Ylo+12FBXjdOkY1LUlJc3mF/LSVSDx1G5chUri2NV9fCIKI8mcJI
         X9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711649134; x=1712253934;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i78qsEKk8suQqaQrq70K7F/HR/B+wBGy1GBI/Kse4k=;
        b=GDDrCHQSY1GUSI/tdBQruHcsDssFxtUQoabjsTwBIDQ5BhH/zL02UfB8bmoZGsYZqe
         cICOyW82UNtVCT31+iiQPQoAaNzPi2ckdueBdzgSkCTBwoIIImlHpd79yLv/mgj0WliO
         5l3u35ArpCuZ13XfpS7QWil9iFaTJybkDBSq+xgVZW3NPevrUv/twHZeI/DfiJ1Fn/vg
         sKEW2+gbc4vyIMb9CVINB5Yp+iOnyiTtcujArE4oJRfiLUxM7/mWOep2MeEfmSDlLyAd
         yXU/ssHXtzUrPeKJNQDM+gYYluCDAsYZe0DcOpogulq4JPl5NqZxuDL9iWUun5h3S1QX
         frnw==
X-Forwarded-Encrypted: i=1; AJvYcCWT/JkvRuz2GE8qF0Sd5fiCjO9x1ZkTnh/BC1IpC2Sw1mi1+A9dRcJxGaHm7UYv5nU3/y78UbG67BFYLEmcQrXqFitkq8Vku/yun9nk
X-Gm-Message-State: AOJu0YyWGMRZPxySxs9fSg4FIHJEhywb2Pa++/aIsplIeKv0crzkoo0H
	baH23ds6ciREiLFqyFCcfKTupz3L3VMij9tf3gr/ZEQlp+yVibM1/Q/I69d3jlI=
X-Google-Smtp-Source: AGHT+IEdXx3Cehjpn14ddXZgvUVFhvlEiMMUGmQefg2rIDCI7iGvCADTWekq/9h9GL8Gz7ppAdtmXw==
X-Received: by 2002:a5d:514e:0:b0:341:d7b5:27 with SMTP id u14-20020a5d514e000000b00341d7b50027mr2876740wrt.6.1711649133789;
        Thu, 28 Mar 2024 11:05:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id d8-20020adfef88000000b0033ed7181fd1sm2307467wro.62.2024.03.28.11.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 11:05:33 -0700 (PDT)
Message-ID: <a13b2870-c1d5-4744-8da1-2fbf384b9c5a@linaro.org>
Date: Thu, 28 Mar 2024 19:05:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for
 SM8475
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240327180642.20146-1-danila@jiaxyga.com>
 <20240327180642.20146-2-danila@jiaxyga.com>
 <b73034c3-a512-46b6-a9e8-4d43fd3b39e6@linaro.org>
 <d09c9486-d2ac-48d7-b5d3-49b9e1a8cc0a@jiaxyga.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d09c9486-d2ac-48d7-b5d3-49b9e1a8cc0a@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 19:02, Danila Tikhonov wrote:
>>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> (not reviewed, please provide link to DTS)
>>
>> Best regards,
>> Krzysztof
>>
> Yes, sure.
> SM8475 and Nothing Phone 2 (nothing-pong) on which I tested:
> https://github.com/mainlining/linux/blob/danila/sm8475-test/arch/arm64/boot/dts/qcom/sm8475.dtsi
> https://github.com/mainlining/linux/blob/danila/sm8475-test/arch/arm64/boot/dts/qcom/sm8475-nothing-pong.dts
> 

Thanks, looks good and in match with the binding, so let's make it:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


