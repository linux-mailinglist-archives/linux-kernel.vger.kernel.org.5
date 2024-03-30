Return-Path: <linux-kernel+bounces-125676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C206B892A91
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C251C20CD9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CEA28E0F;
	Sat, 30 Mar 2024 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xq4K/zNs"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6365847B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711795737; cv=none; b=Kt1iXRuR7z3lmfY9EEAx4sIf6EA8HxVoigwVvIk2UkkAufyxHuNx5whQ5d20yDUcOneOm3XKtZP02KY4kgz4nOypOFGybwsTVrxF3Yq4pO4dHUPR3l9RRhHykp7esVA3RDb8pX+637xf/TFGbae5dzSqMr0D9crP6HCTr3GbBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711795737; c=relaxed/simple;
	bh=e1rhHx/VVWySgCwzUYoUjQar5LzVn6bPg6jpMXHgZ18=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nsgkiCplFPX1vfZO7P+Y2UPMPQMs2AkIBkZKVPQF3blk4nOUFdo6eUC9u7n3faPZ9+TIJQ+fLToh1CsYXv+Y5GrbAZNYNOMRXaCKunD22zGU7JgC2CtdTferEl9z4cGSNT1c+ruOUmbV5kbMGABb0zW/mSeLtYIu932HHWsxhPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xq4K/zNs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so3612706a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 03:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711795734; x=1712400534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L+avA79tiT9LiSh4Sq3jlaYlOXGHHkYNP3Wtg+oLyz0=;
        b=xq4K/zNsjOe9j4i3szh1+z5/imD8t+c9SByKNUAo08PFSqQIWkZFEwK0kgyW6Epwbw
         X7kGOo23WJyo+zAREhhTRB/nJsdrnCpBsECpDPJLaR39CkbB37IIUIaEBM5fOvN44Cyv
         8m6rEhFPrYnZ/XjragIMo4boTDBGCFxm6TA+/ZaSnEO47a3Z+akU+2v9c5a6U9A3Vfqq
         zso9rbTtGPupozJ2tm0dHidDfChRmKg5BjRW2ss211SqKd661YpSdhOdWg4loGARpFdh
         tZ1Zzgj+EBvaVuUCtBgLsEvuwd1Zkw0k5ZD9idasgyAszTExTq/HO/fGQ7NqAfXJfG0D
         /m7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711795734; x=1712400534;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+avA79tiT9LiSh4Sq3jlaYlOXGHHkYNP3Wtg+oLyz0=;
        b=mApWS90VDZBTnESDzhritK77KeZS2HSBYhe2/neKruGFDCoVBGRq5p0P3lwriJ3mW0
         ro1IcP9HHMefaH+K/vSXcNp/deRBN7lkr/2LFqSK0WUCs2rOkQDRgf/nKLBoL5y3ag0z
         R9UtW1CCForRMB/43cv3OUinX5Br3hobWf1AIjllAATZE+H9w7zP4X2aBbS55dwVsYk+
         fLubTcrj22G/veq1/9PfZbqo449YNlblpdGAsLtaB7T6DvGhltG1Ef4aE0Q38z04musd
         HSEtWZ0cjKEUnyzyjodPUg+8aJoB6SyhGSZxvWjLxWoXDahqjZQg+SJ2LEx3py7Hd9Hz
         o2Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVugXkC8g5AagidBuHVERyYbZ0Vt5XXz3RLLBA2ePM55MQ0EnPzcRshlmEtu49kdm6Mr3YLIkcBvl1rZ4XGA3WiC7eCe3wTFn4bMTcc
X-Gm-Message-State: AOJu0Ywo3my67t2lD8kRFHjh8E8vDHtFUhab7nHT1czXNuJAsOQqD1OE
	FmjJAUmTUnOV4gQxBTy4mZLbps1aEa/j2xK3ELfZSItYmyLCFrKqPkeM0UxJC9g=
X-Google-Smtp-Source: AGHT+IEQlJoM4qzF5/EL6E1otZh112mYMvK+cTQCIyNe/xIDUnaYIrXXmOSpjfFMQMCFEk/cThqPuA==
X-Received: by 2002:a17:907:601:b0:a4e:26a:6558 with SMTP id wp1-20020a170907060100b00a4e026a6558mr3408296ejb.24.1711795734288;
        Sat, 30 Mar 2024 03:48:54 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id m21-20020a170906235500b00a4e46da50e0sm828502eja.45.2024.03.30.03.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 03:48:53 -0700 (PDT)
Message-ID: <3c78cbd5-db7a-4465-9441-4deb98969b3e@linaro.org>
Date: Sat, 30 Mar 2024 11:48:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: pm6150: correct Type-C
 compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danila Tikhonov <danila@jiaxyga.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240330091311.6224-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240330091311.6224-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.03.2024 10:13 AM, Krzysztof Kozlowski wrote:
> The first part of the compatible of Type-C node misses ending quote,
> thus we have one long compatible consisting of two compatible strings
> leading to dtbs_check warnings:
> 
>   sc7180-acer-aspire1.dtb: pmic@0: typec@1500:compatible: 'oneOf' conditional failed, one must be fixed
>   sc7180-acer-aspire1.dtb: typec@1500: compatible:0: 'qcom,pm6150-typec,\n qcom,pm8150b-typec' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: f81c2f01cad6 ("arm64: dts: qcom: pm6150: define USB-C related blocks")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

LOL!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

