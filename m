Return-Path: <linux-kernel+bounces-48752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DC58460CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377481F289F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A9A8527C;
	Thu,  1 Feb 2024 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OCVtvoZY"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB412FB12
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815042; cv=none; b=mD41F9kzFTIEznc54Is9CiTSNbN80SBDm3euk+cIQJrlfL3Z31OD7VmvWkz1UmAeLOSwm00kI7JSSCfFfi0uPKQye0OdNbuj2HF8zx95JFBprGiFvQ0L17fTaVE3bslBsJXwJd652+DayKBlYQntK07UTIwwchqMW2kLZqGLKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815042; c=relaxed/simple;
	bh=P0pE0C82v6nTvD+gheJr1kkCSVXnyW6BCIguoCmLAi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJaopqs0PCHEL5TNUAuK7wluWokr/V3ciTDiWKtLsJc6Q0lKXyttymaaMJGttBfSIwHRRSyiuzQNS9+aZbgn1sPHLpjELboC36d+fc92FqFoYfajza0jqZMN3Zr6WeG8XTO9NV8HoRf/xjTpE36RKM3cewwaMutcLyVMD6z7Mis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OCVtvoZY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a35385da5bbso235617366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706815039; x=1707419839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CsZcImjF2+pH1KCbHt00XrVx5lcTjvCoapJtuOEFeA=;
        b=OCVtvoZY6rZwAANbtlSyGegC3hKkZ01x534S9xJmYQcaV91KheYozcjA3E8MvsHh/v
         gzv2sxfpnEIFy8Cf25NhAYcWMWMJfoYNeU0WdSaSZg7T2oIoGS9KKIcEWMbXQnzp5zgu
         slJDcbyrNnX+6dxRWOqUK5lM3v7zGeSWTRo3o7BhgOtfKNp2u/PmlpUxEav80MDzgeow
         ESi6b2T9Rc0hnbRXJ4Hq1Lvws3jbnMYRjlyv0wvZwxeoFC4L16CeINeG06PxQ0eNEmr6
         RjplDSSH81E3/hRxsRgy6v8QzAYqq8YJYlA7Hzmr7SQRXxf05KmPt6q0swO1MH/qqpj2
         meEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706815039; x=1707419839;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CsZcImjF2+pH1KCbHt00XrVx5lcTjvCoapJtuOEFeA=;
        b=CXoA/z1SQeHLgEr7d8jlL894UvwNGgutycUvrgwvlgiAV5YvYH0ovIirvqviWx99ju
         0HkAvJzmYGjgB1B6cl8x62VzkU9gFA9VBnrkgf1T0rboreTaCN0jaO06DEDNxvFD2ljg
         gh1bnOa/MW0f0YsJpdlTHS+WTxupsnCdactg+/jqTQKgVcEky54BdZ8HFgebtRsxrq5z
         kXoqeERueY3W68U5lzZNRFxtOahu0XzWiklXfrx6NDWGeXIvqTxGi1h+ZFZoAjh0imiL
         ZkDrGCdj58Azu9pjpe2lPox01qB6+do8ap0EaPfD/5ABW/BMjwgTQhuc8CDco68Vpdif
         vY+Q==
X-Gm-Message-State: AOJu0YzKByoqhqQCjXj3OnHjmakCRlSXmpGkKIFcaUWzXuFAkGsuCfvC
	oUp3Frv2h4/pG2nQ+mgqWkUOZDLkjozmxqSORH53wl5ZGlAewdNf+kRX4pRXgnU=
X-Google-Smtp-Source: AGHT+IFiE9QQ8QoMvyd0AOwB6JqvdAO3IwQsUgYLuTbdqDH/hXq1n/RSDh8NACUJ2wkaCdAePeBoSg==
X-Received: by 2002:a17:907:36b:b0:a36:696f:3e20 with SMTP id rs11-20020a170907036b00b00a36696f3e20mr35819ejb.66.1706815039017;
        Thu, 01 Feb 2024 11:17:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVdEOF4uC2AlRgIAOqNIxc7ER6QvNRDB9SRk+rYaB5VFOACQEP/kc7mhEUQxhRcyf1hPVZwH8mSigXgvRbXCMhzFkqPoV81wlIDM/apPqQoO4ZqLHtWgSFgsSZXlqfNFYZsUky9s+vMchkKW77yAOzpq06/ID/tOlKfisrv9Vo7KfDvZRWOWSWzHehabau+d5j9HmsU1upjrYOsvM5y9y2R/de7WePblAYlbGWlVIP3KwNAMPENtgZIzZF4uxHVcSMsazt4ZQ7lE/eLVM4AghES7iG43LC1+tEEi1V5zxlBZU6qywvHvCWuk3WkrXB3gwuhI+SSoWGy+71KjdDGT7/VYm3UiC+0qxk4/g6O8R06y+UnGnTj5iEhf78PLVUD4yP7alyODrgbBbNOGBPofRxnbsxEo7aAMNBHgKZi+rFguZqzv4IButdv0qcfGitKH6OY2JBg8LDH7EyTzARdismyoOIas4zM+ZiT+JdpgOqdQpSGCzgYrxg3QNHo7Apv
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id vk8-20020a170907cbc800b00a36f8fdeb98sm23088ejc.59.2024.02.01.11.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 11:17:18 -0800 (PST)
Message-ID: <edee0b14-abef-41fd-a88c-3ca125b384d2@linaro.org>
Date: Thu, 1 Feb 2024 20:17:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] arm64: dts: qcom: sm8650: Fix UFS PHY clocks
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, quic_cang@quicinc.com
References: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org>
 <20240131-ufs-phy-clock-v3-17-58a49d2f4605@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240131-ufs-phy-clock-v3-17-58a49d2f4605@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31.01.2024 08:07, Manivannan Sadhasivam wrote:
> QMP PHY used in SM8650 requires 3 clocks:
> 
> * ref - 19.2MHz reference clock from RPMh
> * ref_aux - Auxiliary reference clock from GCC
> * qref - QREF clock from TCSR
> 
> Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

