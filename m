Return-Path: <linux-kernel+bounces-128171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7B895727
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5AA284BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2518E13698A;
	Tue,  2 Apr 2024 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IayVXx/Q"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C261327ED
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068762; cv=none; b=X/waqyAkBcj84gAfHSWTCsyFpgmGtAzQY5FY+/GTo/+aYu7O+Yx9OfjOO5oTfjyQ8I+S82nxMD0PVG7zLXpUP/5atjEhpMk3Q7I7C49Wo8tlkXE84PXg/D6cmyaHvGWSo2nIn0cVn4sPwk+KbyZSfYKWShK8RoDQ+tom+z/t3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068762; c=relaxed/simple;
	bh=L3E27xlgmamC9dlXuP8DB1YC9l+WBAE+Nc7ITNRl914=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9R2UwEMOQbVbFFuiWLVux10ooV2m3hYa/LlVzOhB+7lhegBNOANdqZuBF7lRSZw9AM99/BQeBWggua0VcvBS4HxYa6yOTE7vSkxssh8FTz+c+UULrpPmUUkqwXNC2hfP9o1bF69G3YwXzAxsZvli6Xe+w4dSWiFIkyoKn+izks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IayVXx/Q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516b80252c5so923878e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712068758; x=1712673558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UAHKO3whDJ7nORP0AC33oI93Q7LTz6UUZANbBJWebfY=;
        b=IayVXx/QwEJ+3kIF0pVEm5SeM08V+lnATmZc/NCrVlB/H1BxKCMw2fOcS5mQ2fJz+o
         fN2yGRnUXiYFnQKwlFMttbOpJwRqgBdEFVlZ0CU2JCfHFwt1Z4NutvMoFtqWi8zG3xgl
         fBvo5f2AUw1JwIOPxT+LpA75OYsKVrCfC6mejvid4ptOlZDNy3JFyopNKS+WUNbbXP93
         uCy+h3M7l52K8KrKJFEbMNLRgpvyIWoEOBY0BH5/phqAw2zA5/qI7vITsVVSdwgX3oUB
         5f7o151SmROHjaFAU5SIwYCB2yRr4hQF/XjwUrFNyySGTIcUMMvcW0me2qhX2m8+jyKh
         fgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068758; x=1712673558;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAHKO3whDJ7nORP0AC33oI93Q7LTz6UUZANbBJWebfY=;
        b=MGo/X0CY50bbbg8ulZfxZAzy92YAR3RWSEngyjYTVXFt9UPVryDGTk1WAFLPLrJDYZ
         Zd+WdSKkiViRl+XuJSgTnF4U6QV7W4ZmOcE7BEyXcKmfRKwHwbEmr2vLJlRENnxJVlxe
         ARO64x/quERlj1wF615rE1HfBHgxwCH2psYJUuv9uDhmsDdXwrfyjHmYcqsQsI/FL7U9
         OwhhShWb2zbceRGAT7ZLQ6F0tYdCjcHDkoVH/Xc+PS7ACR6j9Fy325QHTD2zoWUJLnCB
         c6tfDaJLtqjH80ROP2G3P49RYqOU9zycHVo7qYgvqwU1QGiM0IlhvC6VGAZvMCHZY1cL
         KsCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeofk3ad84pM4+yEGOZz8bctHaxUPglcBA+XwrQdw9RTgF1Pd/n6LnfeDy9kXGCk23uz9zQ4bq00amBznr3smg2sJoCCcCkLMxQDkB
X-Gm-Message-State: AOJu0Yx2VHRJFdNJScX8jKoVuFEnuWtj1nVbs4hL33G/1+mMSwN7ZBmx
	rQO6faaZPyDugUuJdCpZYfdE+vYNJI8Gs/DhTVdKGhuRsuuDZ1dClvjSHUV7N38=
X-Google-Smtp-Source: AGHT+IEB3s2Qe6CDTjHmulCLNFuOiOAWKO43nxErW6Jk42N/4sDEhw2kEhgtwduItgBwI9fx5Y1dKQ==
X-Received: by 2002:a05:6512:1588:b0:515:d1f9:983b with SMTP id bp8-20020a056512158800b00515d1f9983bmr12935588lfb.1.1712068758363;
        Tue, 02 Apr 2024 07:39:18 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id u14-20020a170906780e00b00a46c8dbd5e4sm6562842ejm.7.2024.04.02.07.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 07:39:17 -0700 (PDT)
Message-ID: <ca7120da-56e9-4fe1-81c0-42d4bb81975f@linaro.org>
Date: Tue, 2 Apr 2024 16:39:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] arm64: dts: qcom: sm8250: describe HS signals
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
References: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
 <20240401-typec-fix-sm8250-v3-3-604dce3ad103@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240401-typec-fix-sm8250-v3-3-604dce3ad103@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1.04.2024 10:33 PM, Dmitry Baryshkov wrote:
> The OF graph should describe physical signals. There is no 'role switch'
> signal between Type-C connector and the DWC3 USB controller. Instead
> there is a HighSpeed signal lane between DWC3 controller and the USB-C
> connector. Rename endpoints in accordance to that (this follows the
> example lead by other plaforms, including QRB2210 RB1, QRB4210 RB2 and
> all PMIC GLINK platforms).
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Hot discussions aside, this is consistent with bindings, so:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

