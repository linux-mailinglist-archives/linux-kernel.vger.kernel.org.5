Return-Path: <linux-kernel+bounces-79194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E6B861EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31CA1F24668
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE2F149386;
	Fri, 23 Feb 2024 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXd84D1E"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8383C149391
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723154; cv=none; b=PshV0QjgVOje7O0cpEBGORo02jZ15PBWXaSytnyKRD/62f1yMfVHAxWBBjrZrhMnkPbw1AAK3TVpqT3Fv75yNbhxMczLKh39seXh3y/hpUlTfsPunsHBiTJQ+DAqZiEG/0Ianrx+6zJqgY9B6GLiUWeUYJLRTLfopBssaCD2v1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723154; c=relaxed/simple;
	bh=272NrUo3mumvi07dCk+j67Rdf5c8bpyCl3Ye1TD/L60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfvLEtBxl/6EuMCMsVPkV3JAwHSg4kg0m3s3Bx5rqFj07Uo6NtQ8hc+Z5eWnh1fGlI4KAtMFKRvgmthJ0sO3W79/ns/J6t4pTl5eX1EbV6oC6QUn0sZeLSpqgcy69WpQlPl+muxPXqWOidt6CzpAautpPmrwZ/zJMCeSjQ13YLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jXd84D1E; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3d484a58f6so185812366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723151; x=1709327951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANUC1UxsLZd4LKf6dSfaiD16hzgSZI8H6O5PPlG6DVk=;
        b=jXd84D1Evjga8ldSiEHjoVrnsUlbZrM2d5NkcrChycbxtJXLvzgg46s4mIX/7ccOSO
         OMqWqRNTD/56a5u4uLIaJw0++r5H8GiWW4zNCC/U1/V7L9WKaR74nLAZOWp5esmPSUf8
         lgIbjFQC+isCKj83o0VS11r2gBwW17ojdA67dUBsVqmvrcs7maB369XdM9QTbEOFZbuO
         RkXgepou1GFe0ByWFVAHyNFUnO5ctQ6HYquVVFM2GbMapRrXyVx6ZliQTxXMzj40NGSM
         7fDQcUGKdrcW3OPlXY4/z6be3lYuQ+k0gEvO/Eb/Yqo/X7BvndXDMR5I8rCdfDI4Gc2E
         pvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723151; x=1709327951;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANUC1UxsLZd4LKf6dSfaiD16hzgSZI8H6O5PPlG6DVk=;
        b=aTMy7zS5t2xKzKV6PaYApw+ANogI1AKRJJs8nPnASgfmaXHKpMnyLTC60/bEJWa+6s
         Zql5mqsbrzV5/bjccIM5zi7W6xBBe2lOV34w3hASm/fwuYJcXYWt2jpwbKciyImyWMcz
         2jpEDk/KHMAYSnCxcCPueW3aTS1Lp+KEBEdG2ware7alcTpn5MdQi4Khx5ruWG3V1BLN
         qrVxPp8XFYK2VKgz5P+8RmutGID7eKwaVBd+IgRmOfuIIqSak89q+AIeOiPgU6N9iYeD
         rHxq1TKWkj5f/oZj1Vd7moZaUnfvvsEmBvyfk2VAfWaOUbYoHOQmzXHXlLCATrLJMVbF
         wM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtoCVls7cbMsCamK76xoKHjeCC1FRlCfS6VAGD+pHB4Hm8YSPeJtI9bqC0wPoKavbgzHl9wRtXfHj96ak1lAaQ8XC2ZXEMlp8ctyoN
X-Gm-Message-State: AOJu0YyjQ2nTmVH6/TIuKjFU3JC5lXycdVnC5zfJRY/4Lvi2yMxw36xR
	OmMtoBISz8n+LfWNkXQqDcXneC2GGh/raoy/vLeCAZPD7NbLqvoiBMrysH/CHhg=
X-Google-Smtp-Source: AGHT+IEP0nMpkP0PlQhT/Mmck7ycCP+HSO72hWBJVUKTirmrz6cJO75oCqWHj/KuPC7PFllZoW813w==
X-Received: by 2002:a17:906:3b84:b0:a3f:9d6a:65ec with SMTP id u4-20020a1709063b8400b00a3f9d6a65ecmr624649ejf.28.1708723150813;
        Fri, 23 Feb 2024 13:19:10 -0800 (PST)
Received: from [192.168.179.2] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id js20-20020a170906ca9400b00a3f947c55besm1660040ejb.92.2024.02.23.13.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 13:19:10 -0800 (PST)
Message-ID: <a1ea56d2-e04d-489e-b80f-6f6810374080@linaro.org>
Date: Fri, 23 Feb 2024 22:19:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] soc: qcom: socinfo: Add SMB2360 PMIC
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223-x1e80100-socinfo-v1-0-be581ca60f27@linaro.org>
 <20240223-x1e80100-socinfo-v1-3-be581ca60f27@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240223-x1e80100-socinfo-v1-3-be581ca60f27@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.02.2024 15:37, Abel Vesa wrote:
> The SMB2360 PMIC is used on boards with X1E80100.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

