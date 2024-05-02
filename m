Return-Path: <linux-kernel+bounces-166020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F588B94DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158C02813B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294B51B947;
	Thu,  2 May 2024 06:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAowNa07"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFCCC8D7
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632606; cv=none; b=BD9kX+V7Jp3QXwPite1fxQ7twxXBX1fSx9vQCA3TEnY0vhpDahfks3tu8LEVIH93gzA1NL5PqtugvoOQFEziciTXVADj1I0u0yohMBZ9o2yzafokRIIGpuJtwM+Eh8P3b5YFjcy2vzEAM6lM5iGQ950tpcICs3al46DF60u8ugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632606; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMpSCyUpQ6KbZXgOfMrf76kk+yQsXy9NTrWmfyFg/wN0Rmz4zcO7aSaLdpKENua7/6/G404oJoWdsVv8fGBOX3lP+BU3fo7pDJWEfe6760Jjiv93L2COidwT4c3R8VSaFw5tSxdVNgfzc228EBDwQYFcSbFk8NhrXoejCrf60oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iAowNa07; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a58ebdd8b64so564508466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 23:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714632603; x=1715237403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=iAowNa07+HpskSrVjTCyABhl1DXSvKvdwyPpjV8cpypXGoUmI5lR5Ymy4vEGWi65kw
         RNfq0SRGbVNJ/Da8rDbYf/OOLoQiPuUF1x6LW9Hi2isHw8bBj4FPz/dBeexPLk+cNjSt
         Z4bZRMIdjaOyRj9cxlqaz925i209Oi1ufRhYetxcX1xKMJN00rY4B/r4AGvnvSwe4TkQ
         AKIsMr4TeDLLfLbwX2rTIkSmxVjPlD5Uo8M5GQx7Ac9S62JCqg/lv9WoLGmvmq/JcfzX
         0oCKahJCegBTKCpBEcqZqvYxJ5lhtgKUMj26+vXiWWNEOUuzOLNr/9r4MkQAWpUoCYyP
         EWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714632603; x=1715237403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=o+LCXolS+C6Dfoszg4mn67qNVAa4DKzsPaLD+0bcwUfz1S8IIDpNkXh1+9NwD+3ha8
         lgbyuq31vsQiuvjJGzwwBiz1WDvX3pVDUgIlHPdAGwhgyygcYZO0jRSuIWuCo+nvbE1y
         E8H5fEsZ3JKTSEfIkPau0arTB6aqhs4YYoK+g5iYnImxk+cgDIt3gq3R19MX96+7r98A
         3gIbVOfLodInKntBjl/uY326O5tTc9+kxZzOw48Y70Da4Oxl3vQ7ZW/a/2Dk9tWzLwAu
         8IsbzLKZGitJLQODEsaVBZ2qQcYJJ6vESqo8+H78lB+Wu8ysPpFTkLbFS96eU+UOBYEo
         8/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUocOvSSoa9rMdQ8MS7Tur+rNFMOGQZW+EZzepcaH2j32MP+nhFNIawchFTHxbJ5I8neZSLPmsj0JtA2nrBRhyme8ZGuoDy2hisbWjS
X-Gm-Message-State: AOJu0YwDpna+ZyQjCcleeT6ZD7Ip5Co8Gp4za45rcoLWjOJsXTp9wqi4
	/jXW7tQ2N/JgAuSMcCUpz+nIVu9dxN4zQd18s5EvNLfIwXbe2pmQHsTQUm9yhNM=
X-Google-Smtp-Source: AGHT+IHPu2YWe3SsjrNJRVR4woDt4+tlOEKYS2Ep/eEIN0qqFEN0Dr1+URLpzG6JuPmVW/4sCrEdmg==
X-Received: by 2002:a17:906:381a:b0:a58:7aab:96bf with SMTP id v26-20020a170906381a00b00a587aab96bfmr3143994ejc.18.1714632603154;
        Wed, 01 May 2024 23:50:03 -0700 (PDT)
Received: from [172.20.10.10] ([213.233.85.172])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090612cc00b00a5534758ef7sm184709ejb.148.2024.05.01.23.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 23:50:02 -0700 (PDT)
Message-ID: <3327a63c-7b7c-4f44-ba48-89a833d211d4@linaro.org>
Date: Thu, 2 May 2024 07:49:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: exynos: gs101: specify bus clock for
 pinctrl_peric[01]
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240430-samsung-pinctrl-busclock-dts-v2-0-14fc988139dd@linaro.org>
 <20240430-samsung-pinctrl-busclock-dts-v2-2-14fc988139dd@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240430-samsung-pinctrl-busclock-dts-v2-2-14fc988139dd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

