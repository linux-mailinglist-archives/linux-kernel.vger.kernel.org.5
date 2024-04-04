Return-Path: <linux-kernel+bounces-131984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E518A898E41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C771C22394
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A73131BDB;
	Thu,  4 Apr 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjuiwI8a"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092711D6A5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256627; cv=none; b=i+Rys30slw74VOSS9NHBGEpviGf59aWAQHCapfSs501tZU04c9+/HBqqPEY20MwpvrHFCqCEaSt+zmskiPGVwp0Ed0yZ7blqc5WEStpXn3sGwVxtbJ/JGEWcBKPYns7VuiFL/0lS2lxIldcM8MXC6A2t5hP80LBvHObRwGM07Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256627; c=relaxed/simple;
	bh=5cmsmRL01LTBUVCbLB8WWxi3wj11c03zAP00q6S2RBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6HEqph32u64bEQsvQLdCnrG9exhLhnNk1t4EV/vBfqHuuVHogDI+SH2ABCFSjHBjSE8AFnYYn4DkLeTc09rSt5TxCOCkuuw5jf3ImhRKJkoRdKCPp8cDkrFRELe5aEg1Y6DDct7401akelCdZF6UBj800wMpnP0lV3pOh8b+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tjuiwI8a; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d475b6609eso17194531fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 11:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712256623; x=1712861423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svY/ur10Om8A4vKixrJGUkmbDeJnaZ18d0XmchhqHMg=;
        b=tjuiwI8a2dnkSdut3BBo6fK/I5B8Ga1LE9dm1tO/LdJ7jgtKlXW9ynHXl4vkIlP0Tk
         FxP2DnwwnHtId37nn91b7a2nmSqWEJ/eWjVxl70Ba+AHyfpeqRogqKOWf3eNOJIkU85e
         pMZg1cbkKZumtyl8rh2QovZydyi/MZjPKXewJL8uS0Sc5Y13twxOgjIGY0HhNo7KXsns
         yqe4Y0z8+03GNIRP2P0zyuwwWsSmaYlamuZAmuEQLMbdVBVIdvDlM0M5UJXHghILorOk
         +iYCy3zY16Qq5iUej6YQZOfFDLXQhQy/8BYBWTmMQ+UEnc911jAfqPAAxnLusUgdzHok
         6IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712256623; x=1712861423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svY/ur10Om8A4vKixrJGUkmbDeJnaZ18d0XmchhqHMg=;
        b=epDOctCvmr/KTVNOvBix+t78LMhM8MUi7+C2AqjXxaSjVjlB28Cl1wdVc/FfJw1nUu
         gT4vU+8yvHZ4y2IS4n4kxHMExuGv29hE2uxu98MuhhbDMcsWAEHRwQGqLxFBh8CMfg74
         Q+pQ+GMyLMIAiW++oDu/lEgmyJpF5S0ekHHnON+wwWFqkZJgUBhlUD7yTJiXdvsDznGN
         xsSZlGqhlj3TW+ELnS6448dh9xy0TQ07pnHL/NTPxS6UeMU2iOGd31MmpdBY0N0w+L3M
         qmsgaTCgnm6JDk5lLiKWT3mloEF4sBKT18BJK3bxZJYqykcXmDJLaSHJ0kL6ntrAnQz2
         SS0w==
X-Forwarded-Encrypted: i=1; AJvYcCXvQWljS1frVVd0Hihcd6MboLU8/LDeuavxIudCDGrEHxpH+f+FSJ3gz9YR+rlzGJzzc0qFh1Iyg4MVPFnrEVrjSsFS+s5eknCMwg2w
X-Gm-Message-State: AOJu0Yx/s7My96XB9dbMTtaRl2JcNTEsIJH2wSS76FFT8AsTtGPY0Y1g
	ArYYJBwX+C+l8shacj9RfFPbRdXmEZSyibBQaA74P+XaYaLugbXqVBj0zN9A4pI=
X-Google-Smtp-Source: AGHT+IG34qkZMKnGNuAqnox03mol06Zt0+bAZ8cMyAv5xgBeP5KdYLBMAqt1TO82O+vhyaB1qJlo/Q==
X-Received: by 2002:a05:6512:469:b0:516:b07a:5b62 with SMTP id x9-20020a056512046900b00516b07a5b62mr216286lfd.54.1712256623061;
        Thu, 04 Apr 2024 11:50:23 -0700 (PDT)
Received: from [172.30.205.19] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id r10-20020a19ac4a000000b00516cdfb1b9bsm207192lfc.228.2024.04.04.11.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:50:22 -0700 (PDT)
Message-ID: <3fddd0aa-313b-436e-bd2c-d239da6873db@linaro.org>
Date: Thu, 4 Apr 2024 20:50:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: qcs6490-rb3gen2: Enable UFS
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240327-rb3gen2-ufs-v2-1-3de6b5dd78dd@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240327-rb3gen2-ufs-v2-1-3de6b5dd78dd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/28/24 03:01, Bjorn Andersson wrote:
> The rb3gen2 has UFS memory, adjust the necessary supply voltage and add
> the controller and phy nodes to enable this.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

