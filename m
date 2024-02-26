Return-Path: <linux-kernel+bounces-81381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CDF867522
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D311F246A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E097F498;
	Mon, 26 Feb 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KYiXEiK6"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069B7EEE6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951031; cv=none; b=XVDVrxm8WbmOl06A5vxsDYRd+Kxc1BRbnl4r9iBC4Dug7HACDH7QDBKy03vHUQFY/PxFpPDVTw+parNfW1/fPKDLOfJyLeDPom23miKAjqJhWWkQ+xcC8JWgYXsK/gPz5I3DxA1MdknQGtcsziygJQUww1mriskLptst2fmEHZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951031; c=relaxed/simple;
	bh=aVrg05gFN6gF07jSoKxNFCBAr9F4xnKSDzKrqxIrgsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VM36dcgQA024lgLx1q54fKrK8vZstULk+sGoa0RNkG5wxPvCdA0vAKOaoTQ5z86pxfg85kuDyFyPyQGe2tIOBwZO+mqVh3DZ45XRkIq2BHrIGuWjTr8TqrDckiweSqYV8n9XMsxQkkP4hOidHBcP+PnWJGHSCwza0prxuTrzMDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KYiXEiK6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso411005066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708951028; x=1709555828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gx91zwBp6J4wIkJmb7feqxWb+xcR8MZvWqQyfTznWt4=;
        b=KYiXEiK6ukyjLKNHuxj1k4pgtdpUE3lzyDqSDaGKLkjhvz29/Vp/w3EzRDUOXSHxVg
         caLbAz99Ox3YRFchCW6vy5NRyBkjrB/Jn1tVXrbfWS5cIU+i9R2093t8+coyoHC3mdcl
         hXlvzM9znvY6LbQMM6h0BloFJw77uzFHWG057WGmiqsJmtFxeo73MMqhAb6bFGSJHGVp
         6qXrWqd7hgCu66O8mRor82SnC08eDwTqwS24cLt+Htl/LFNIvLkLrBjXSzbec0SS1g74
         mT76r/03xYKinB0t3b6AtMvH1yxydHlUj0QvIPW3sQikKh+KNYhOZOmZ8brjPxQZP+I9
         QZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708951028; x=1709555828;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gx91zwBp6J4wIkJmb7feqxWb+xcR8MZvWqQyfTznWt4=;
        b=X0KA0DfchJgoGBGhYYRz0xHk7FEyhlezD+3LoB2V9MRVEvz35xvVNlRUgu7Y+tdOsP
         9pa3saNj8Ck3rGIuBDS8tM3esWsjbKuAWpxKib8kw2qh3IvNQkYZWbvf5ZTM4CXE2hxR
         5Rlzo8E9GjuM/KqDDXpYcDTM3aoz7uEg0D4J8SxXGjVXSoNRl1c4p8jwsGxEudc6eTgv
         mE6ndgJz+La68PqHnKkhY/UG8vUwo7hWi7Ar/AjWa4d7kuhXo2uhY5rFEJSIaKtzD0YR
         TeBv4S0Q2q5PpAUVe6ZfNxKm9lX0yI2Q/00v1HKiF5uo/Hjqm41XhFSvZUssLW2Lo/nk
         6qwA==
X-Forwarded-Encrypted: i=1; AJvYcCWjBcfQg8Hkkq/PhwkzKY7feINly1PVhjMJl7qBEB9WriZ6kSc5NhfSsR3Omsxt24w6AnT4GlYYbu0V5l2pBPaXhJLR8qltpFGAVr/I
X-Gm-Message-State: AOJu0Yy9T/Jkjp9Zt8cbBYHMlKzq3TuNXICpWjFWe7rCMOiHBASYzkX6
	hwTcSKrAN2JtYRnmdw5LQMjBCZvEDRjwjaAfQX+KFgvlhzSh1IbWUvS0up+iGSU=
X-Google-Smtp-Source: AGHT+IEJl0RX8TJrnTEYd08ZRUB6pO66avu+jKYtkWS36jLGhyDAyYuJkLLKi6SS9HUeWvveqilK3g==
X-Received: by 2002:a17:906:384f:b0:a3f:2d9c:c66b with SMTP id w15-20020a170906384f00b00a3f2d9cc66bmr4545865ejc.22.1708951028256;
        Mon, 26 Feb 2024 04:37:08 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id hw21-20020a170907a0d500b00a432f3bc3a5sm1350060ejc.76.2024.02.26.04.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 04:37:07 -0800 (PST)
Message-ID: <44025481-f001-4247-8b7a-f8c0f105f489@linaro.org>
Date: Mon, 26 Feb 2024 13:37:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: leds: leds-qcom-lpg: Add support for
 PMI8950 PWM
Content-Language: en-US
To: Gianluca Boiano <morf3089@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <d17121a0-ca14-41fd-9802-bb4118629e34@linaro.org>
 <20240226105747.3547856-1-morf3089@gmail.com>
 <20240226105747.3547856-3-morf3089@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240226105747.3547856-3-morf3089@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2024 11:57, Gianluca Boiano wrote:
> Update leds-qcom-lpg binding to support PMI8950 PWM.
> 
> Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
> ---
> Changes:

Three different patchsets, two with random versioning, all attached to
one thread.

Sorry, that's just confusing.
1. Version your patchsets.
2. Send them as separate thread.

Just use b4 and avoid half of review complains...

Best regards,
Krzysztof


