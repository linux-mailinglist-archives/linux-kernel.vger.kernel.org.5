Return-Path: <linux-kernel+bounces-141504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD858A1F20
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163BE1F2619C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72741401B;
	Thu, 11 Apr 2024 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yvCl9qFG"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB25134A6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862508; cv=none; b=BiA+kRY+ibpjAmJ1qlsQOpJCvKakMU0jG7T+TyadsGdrEq5LpJ0jMHiBtFQq/5F3unctla8vYwmURny/uSQ8pbqUNxejhp4ESFa2YH8juFOtY/PVkVrxOGCV/aLbwWSW1A3jZ1LE9VRsCQW0Y/8/6goOJ7aqp0ZxIYXBcaxmuw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862508; c=relaxed/simple;
	bh=YMl+eHE6Bap7RKpxpPl6kT425zpI1WjFyNHWeCnNbuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qe44GSowhAMuD1y5bz1kItNpoWhkjeoEw1Z0G4Jdv/Z8/dovdgiAeTwQCHyD1XjtkaKQ/fzkzorLGdWEDxBpLXi3XT/9WPOAGhewsDceRyRiDfv3UU3lY6ycogeSz5b/YBk6M0V6yVXZkT9dR797fMFdUOKjhyTLed+Y9kD+YFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yvCl9qFG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-345b857d7adso49719f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712862506; x=1713467306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nZqGKgYdFhI66UInfG3Uym6Md4Vlbqtbclc9MKboUic=;
        b=yvCl9qFGynhwHhqTmsPGuGOdusoEyC+mzvdigJGudvUTRbwMtd6ZKZV/K8dzmlJc+d
         PY3nTjnbD2euPf7G20MDFjjZBfAhFUfALlwrICj9inDJWFknGrti6q4zwDpXDl01ugS2
         lCR2AaM1t9n+PzEgQN/PJC+v9PoTyw7NBo00i9wYFHkybRpY0iT2SsMj4oFJJGo8iiMr
         DoVtwhWMY4Bf1o/KZZBQmFz6KVG25Kx+7ZFn++vMYrvDCs5EuHTTVPFEX8e/1QAzsi2k
         NoSu5M7DYwoVRxwtF4Qu+91mjC9IrvjiMSbfGTsjiRB4vcocq5KLSlX8eF5AYOmKdmRb
         qYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712862506; x=1713467306;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZqGKgYdFhI66UInfG3Uym6Md4Vlbqtbclc9MKboUic=;
        b=AfRZwljgJtLQxiI+bJppq3nD/3DdjR+eNK0qTE6sWNvpRfclqzKFaBhlfM8Jyy3W5x
         iS56D/b5qtEemnNu4ESMhXmWXsjZmRxyXrYedRmmSri8M7/tbaZq9mEaSMAlG5OvwlAN
         kkv29WgrINPOUoo7pNtSEQQnVSc4BKSmgHIYsG1z8Wzyx+53JteCK4JYxMVfHpId1oNh
         abHbDSooWww+NVDM3XX3V/M0tA9qLCzk/XGal3U9ZUm/wSbE/r/+fogLupx0++8egyi1
         /xHnTfOq+NRMf9DQUtliy7qZR2nNDVFztL/xVKpYRwsW7ilyEHdVxCvT4nKaUaO8cvre
         IpCA==
X-Forwarded-Encrypted: i=1; AJvYcCWpDhT/KlGRmz64vUJZXOn7Ka5/bUMjshCW3Tzjnmg0PPYAThPfz8rSykHATCZWZlrmKgmVzNPMEJVeWP8JpuzeTSntcBQRcYu/E4EU
X-Gm-Message-State: AOJu0YzhsfbkXdqN71J0rBN0wKuv1AaKABbs33pqxsOwjV6V/yyVXyFH
	nHjvqK6nZcLWJqu4oJXgguAxgd8XcubNq85hoffvrDTFhvwDhwCXqAzZ/3TC+J0=
X-Google-Smtp-Source: AGHT+IG3CQDH1rHHIpoE3HtzDUDUfXji/jnA7RooZBeqG/9SVs1GFWagiP9uiaZ3pD73noX9DSMBuQ==
X-Received: by 2002:a5d:470b:0:b0:343:dcbc:62df with SMTP id y11-20020a5d470b000000b00343dcbc62dfmr320833wrq.50.1712862505651;
        Thu, 11 Apr 2024 12:08:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d16-20020adff2d0000000b003418364032asm2403036wrp.112.2024.04.11.12.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 12:08:25 -0700 (PDT)
Message-ID: <70bedeed-f49b-49bb-bbc4-03fb530bd988@linaro.org>
Date: Thu, 11 Apr 2024 21:08:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add
 ipq9574 gen3x2 PHY
To: mr.nuke.me@gmail.com, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
 <20240409190833.3485824-6-mr.nuke.me@gmail.com>
 <019180df-67b9-438b-a10d-f92fd4ddec03@linaro.org>
 <33461c22-21a3-023b-4750-c69304471ea8@gmail.com>
 <2379377e-ca1c-453f-bb74-186ab738ce39@linaro.org>
 <a23adb9c-6377-467b-ac3c-0ec51fc97253@linaro.org>
 <d827ec3c-84fd-9352-b321-79bdc4bdcd40@gmail.com>
 <27b4b37b-c736-4d6b-98f0-0856e09ec5b6@linaro.org>
 <144398ae-42ae-b816-62d6-a90738544ca4@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <144398ae-42ae-b816-62d6-a90738544ca4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 19:24, mr.nuke.me@gmail.com wrote:
> 
> I am now able to repro the errors, and the below changes appear to work. 
> Is that sufficient?
> 
>     clocks:
>       minItems: 3
>       maxItems: 5
> 
>     clock-names:
>       minItems: 3
>       items:
>         - ... (5 clock names here)
> 
> For ipq6018/ipq8074:
> 
>        properties:
>          clocks:
>            maxItems: 3
>          clock-names:
>            maxItems: 3
> 
> For ipq9574:
> 
>        properties:
>          clocks:
>            minItems: 5
>          clock-names:
>            minItems: 5


Yes, looks good.

Best regards,
Krzysztof


