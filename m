Return-Path: <linux-kernel+bounces-104853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3907787D48B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D22B1C22C39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848C550A75;
	Fri, 15 Mar 2024 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXF9z5oT"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9891C53383
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531672; cv=none; b=cWQcLPcP/e13T/Ajr120HsOt1Lvrx26LSyry8VHWaoB5niFgoJVc2QW+aojDtel5nmyPXqWfVjLJxM9ZcXOBFKNIVeHliHJ2Mm5VGb2jB9WlOjoBTPy+X/znnqv7l4uh4g+qGpAqr/NRbn6he+PJx3Hp67ZxoWKyI7ipTMgOSyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531672; c=relaxed/simple;
	bh=GbYotQmMgtQybIND8prbE3WwO9krdH1I+QYEaEGp084=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ie+iCE6rtJmMDwTYVlSCXeoa1B5LePCcka5hS1isVx2nPiARtcnMKWGUVzgjcHJ6aC4i6vVLJlkchp76+Z/oOEfvU0+/cN1CRH7hQIeNyjlBN6/MJYnfY8abfK3zCLWg43KBlRhCBTU/2pzREFwRxQRdZQwhNNVvbqq6nALQ71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sXF9z5oT; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512e4f4e463so2866010e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710531668; x=1711136468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Op3WUS+HnQ1MSTuo6IlmQI7jlDL7WBXudDOfV1bwFw=;
        b=sXF9z5oTUKoA1KXFTxJhV/idf46lK+oZ9uuVEOguSBHckG7/rJtC4EatX6VcZpomew
         sWQTqmmWB0FGFiVLF1WDqeSbHdk8RTnblXZQPsuwJ7O0CrqEWC5F7ii0N5FB9AiR7vj9
         Od89eiDtSe2U2WYaKyFxLFWqPcMTUpepL0LQGFmUSYyPN/+rxq9af85XgffEOqoi2ftt
         i5r4DfhNGkCNcztmBTvzjkKtpnnpThc54dX+tbvYgsnvzC1uyVk3XtLc/Fmb9w1nFAXa
         /IY8x8rTfAYFax52T3ERzk8NWqpJNj5A54D6xOR1PUaR9UiZhoHaAIzXG7KWsFqq9qdi
         4x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710531668; x=1711136468;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Op3WUS+HnQ1MSTuo6IlmQI7jlDL7WBXudDOfV1bwFw=;
        b=daF4qcOrVunxojC2X2FhSylOA9k7XwChOyjELh9WHPuhCJGB1hy3ZbwKx2S7pTk30Z
         aZRBu6yoCbxjBGbM4Em2hAti+V5aOIE1Swo2/Jo2jtHF7wty38YDusxxHaEzWiWmioQ5
         ioL9H8YARta0TmjIYXraWDCI+LfPqKjnTQ6FK2fsJ/PrOOPiA8lIPcRgD/KtG89RCV1n
         VPmG5qsrquf93iYv9Rq6LpVTRgQKGMmqT7t3OpUC0rBW36i9ZApMsKqLRzl5Y6UF7vlS
         Hi9rgV+055xcSlM4eJ7KW9S4vWzLhbudB4OLhVkMHzAlbtNip+RRgEX65ITSKPc+xGJI
         bV3w==
X-Forwarded-Encrypted: i=1; AJvYcCUzC/qqyjgLa+ss3NA8lkaJynzkWN+n7chjo1v0+Km6LBfDMrRl3XpyKh3DxweF8CtHCQX0ZVU7hX4qNqLTs7oJUsbXtifLkAURzKMz
X-Gm-Message-State: AOJu0YxtT7y77S2bgU60z/jg8dTV/Hte8SfZKUYVDyYqGWqf+Ztcy6+D
	rWKNUk3ZbgYOUw1+CeaPyLWHU6U0LVQij3eLg+T/7xHcXb7kmyXPaZdRCWh/n9g=
X-Google-Smtp-Source: AGHT+IG8F5j08AHnY1FsONK9wX0FrYuPZ7XzzUiVzJWITW1cZIO2jaPr7G7Bp//tKasb0z3bjvuh0w==
X-Received: by 2002:a19:2d4b:0:b0:513:ca4c:db6 with SMTP id t11-20020a192d4b000000b00513ca4c0db6mr948245lft.9.1710531667853;
        Fri, 15 Mar 2024 12:41:07 -0700 (PDT)
Received: from [192.168.223.169] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id v9-20020a197409000000b00513d021afd1sm723212lfe.103.2024.03.15.12.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 12:41:07 -0700 (PDT)
Message-ID: <306e44cc-1b44-47d8-a475-b34cfcc7e8c9@linaro.org>
Date: Fri, 15 Mar 2024 20:41:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ARM: dts: qcom: msm8974: Add Samsung Galaxy Note 3
Content-Language: en-US
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Adam Honse <calcprogrammer1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240314-samsung-hlte-v2-0-84094b41c033@z3ntu.xyz>
 <20240314-samsung-hlte-v2-2-84094b41c033@z3ntu.xyz>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240314-samsung-hlte-v2-2-84094b41c033@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.03.2024 20:00, Luca Weiss wrote:
> From: Adam Honse <calcprogrammer1@gmail.com>
> 
> Add the devicetree for this "phablet" using the Snapdragon 800 SoC.
> 
> Signed-off-by: Adam Honse <calcprogrammer1@gmail.com>
> [luca@z3ntu.xyz: clean up, prepare for upstream]
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

