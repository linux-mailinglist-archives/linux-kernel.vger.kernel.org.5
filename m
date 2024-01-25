Return-Path: <linux-kernel+bounces-38897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE2F83C80C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37591F27B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87B41DA5F;
	Thu, 25 Jan 2024 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hELJsJsC"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C924129A86
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200215; cv=none; b=P2VlYTBqGULo0S5V9QK0wXkaHfqFWjKAiEO4bGz4i+CusbQRdluRBbBeBK8KdCnL0OnrwXn5LR/2ZcrePATV1v5aq8X0eH5EQJRVIPe5CmyAT/Smce3zDpsnJM4mXU32Tx9d2GWPYCpVTc7DjAoNzKGEfj7J1omHSwWzqixjYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200215; c=relaxed/simple;
	bh=TR6aGTPM9t5wwOjuYIaOf09pZ339d/Sdvarehyw+RI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qI4P5axNzPJkdml6XWJpVK4ucF21zwJBNeEt26p+TBRJQnDKNd3oLrotCFEfM9pWADdtVmQ0Yc8+iqshyRvw9Wm4HfjEGtiTNsM1nA/6MBGHFiam/x++Dxr6QIQ6PA5Rs/Nfv055vako7ETXg9JMuL5WP2ytpwT72mW/v9HEpD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hELJsJsC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso8760133e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706200211; x=1706805011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9ORfXvOUXdfPDPAdOO8WW7EHE91PZVtFj2Y6hJfxfM=;
        b=hELJsJsC4b2TK7Ce2bWZTJ59anlKiW4dm8aRfyASmVbDHvs1g4WrdzRGo5UYrdTMTg
         9wbSAIxiaqAGoxtm5NL5vmFvMEedMAsVmv70go6vgU/W7+EPtpkxU4xC/A0mGCCYHXIy
         cZVpPy4QzAqHlpdm3DhOC57j2DW6JEcqz94bpjYH43M8Ms4Luzel4dLKzKcwAaAFRs6Z
         IBdYdTxcBIptdGWnIOJ6+cmiZ/cQBKnpnR9IyCGXh4NHNpZk5zHdjHw/cVXr4U3eSi+B
         aBhC/8Cbyu2VZnvM6tB+riRyplmIaTw7qgRgNnC3QKjrpFH7Fmd0AutixRMwz3uTlcPg
         RpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200211; x=1706805011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9ORfXvOUXdfPDPAdOO8WW7EHE91PZVtFj2Y6hJfxfM=;
        b=JO4t0g2lJ801chrLyP8eqSWTwLKLjVmAFftsDl6yB6IN8pBtN5WIghheYczHlo8pKt
         P9HMpiAlaBuLlyjeEQbpjDshwl1zXHYXFPbylMUn6J1IPJ30CdC3Waz9w/6hrXM5D2LW
         DMsz7agPpHN6kca+nlSjNCdxlOIikZb85hn61jrSiHNYNGdayvNVqNMGNbii7HtwBX/v
         cZOuokOeGcmNOLvDkny0hLEsdBdu3d/xwHeYN9WUVi4kGRbWFFmArF5xlqUZlf/JJOHS
         TCMxojUYecwIKfNpcGIbWEYagiDesJxXEC3o2bJFc79/QWb1b3TnksHLNiosRF5VZWZq
         ALhA==
X-Gm-Message-State: AOJu0YyHfpMxoWK0xyNF6mJivJHlT/0gUN5PDAiBkLRLsejSY5SjMxDr
	h2+4nbRewd5sMu9mh6dGzByIGQDHT5a+XZhpHmGNSP+6kUQxJFVTpX5lLqzFj5M=
X-Google-Smtp-Source: AGHT+IGab5rWCzYSyVXGFlz/nGkyGkJHUkwn1MhWbiuyzkrOOqOp2GzA20uUEh9GMufP45z0IUFQ9A==
X-Received: by 2002:ac2:428a:0:b0:510:c8a:d496 with SMTP id m10-20020ac2428a000000b005100c8ad496mr18520lfh.41.1706200210713;
        Thu, 25 Jan 2024 08:30:10 -0800 (PST)
Received: from [172.30.205.155] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512350400b0050eebe0b7d2sm2931938lfs.183.2024.01.25.08.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:30:10 -0800 (PST)
Message-ID: <da281c50-9dcb-46d6-8cb1-ef4662e24a9e@linaro.org>
Date: Thu, 25 Jan 2024 17:30:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm6350: Add tsens thermal zones
Content-Language: en-US
To: Luca Weiss <luca.weiss@fairphone.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240124-sm6350-tsens-v1-1-d37ec82140af@fairphone.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240124-sm6350-tsens-v1-1-d37ec82140af@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/24/24 16:31, Luca Weiss wrote:
> Add the definitions for the various thermal zones found on the SM6350
> SoC. Hooking up GPU and CPU cooling can limit the clock speeds there to
> reduce the temperature again to good levels.
> 
> Most thermal zones only have one critical temperature configured at
> 125°C which can be mostly considered a placeholder until those zones can
> be hooked up to cooling.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

[...]

> +		cpuss0-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&tsens0 7>;

cpuss0-thermal and cpuss1-thermal are very likely the sensors for
cluster0/1, can you test that out, perhaps with corepinning+stress?

You can then assign multiple cpu cooling devices.

LGTM otherwise!


Konrad

