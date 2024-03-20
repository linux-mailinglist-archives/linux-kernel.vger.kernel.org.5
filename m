Return-Path: <linux-kernel+bounces-108531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B687880BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E74E281825
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7985F21100;
	Wed, 20 Mar 2024 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knxTLmxe"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE11EEE0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918947; cv=none; b=UOHS0Lfd3riVd5WMuf+w/i7kz9KbG59LHin2LdTvoipCQcYLthFloF+cmEU8bVEgqHpieVpp2v90bjW9RPEFty82MKMedOOKbDDCkqCePNOydFbJcBjEna1TjjTflye68GtglGShASsNdUKwJq2LhwZt62jmqzT5P9eaQANXt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918947; c=relaxed/simple;
	bh=uAiOL5GdoR6kEhRwJz3jX8EsnRj9M2m+Ll9g7jlCZ44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kz6HWhz5DPqTslEb3dvP+OA8W9W04Apwjc5nFUuaJrPM6FC7UmjKJdtXtno5RfGalHtCVh+5StmgeyT3iesgCRhbQq+vvGO0pGBSiB/cDaJutIp97NQ0Bg0vR8ZEVsThx9aGhUeOkWPx7prcD/769mpXu6UOaZCNZYD2OoQe1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=knxTLmxe; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46f79f60afso24803966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710918944; x=1711523744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=olh1x6wED1wlUWfy3fPcoEKZFeL0ZQi1R+KL4fAIutY=;
        b=knxTLmxeVD9VFmFhwQPO2ZJRM1WCabdlp8IewU33LTjCmlGEhV/dwYzWvnlLlVHLG+
         xoKKmKmXv4W9UO3W6JfZx0vmxh1+kwQWifvdGPBIwty55gZtgii9RffMPnygFNG51VFi
         aGJewFitEovW467BscVsLrGjN0I6Jnbfn1r7I8ar10VI7fCzQDryuT1S+VpVpAVjT5gy
         rx7sjNUBZc1wirmKl4duSd0/vzvn77xucdFPgHi6rJ2d2kfNAwHD/tzH90JFhG7kaQu9
         k9hPEPZPlXtDZB49A3pqXDyxPcpHnuOYpb+w8AfiNwyuu+Gi1TgosmJqVMCkqkNFY5rw
         LJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710918944; x=1711523744;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olh1x6wED1wlUWfy3fPcoEKZFeL0ZQi1R+KL4fAIutY=;
        b=Dh72qtbBelImFpl2MeD/1wep62By9rx1BbbLreEnGrDTyQiRS9WExMORoxVbu+JkPf
         ItOyhoWLwBa6LhU9fi8T0bwL3YVScy19kkeo4GhbnTKWivw9wmKw4gZ+f8vVd2KJT8hY
         ky1JH81vTufTuqgKcw50T5PKlyie9wXxywxkEDouZqAs5X1tyZrvWiaTBHntvdgY0G2u
         Cr9VI9IsxTk3IH8tAIugJWA3uUIyxtHJK4fym6bJmN5UJDjmZX+e6M0SWoZ/DadLp1DT
         Y7g5iRoRaZysHYJb3EmyXyg8sdZC2VypGd734DhzoO09SxrJ3sBsvo/LChwfquvRQQk8
         bPfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUslAfIbbGPiXrcdrUGe3UWbDpm3XDwdSTHwqzQ01xbKnatq1lJWw/rTizZnBmmwEuCfVer+BJff1bFjzggjmy2eWV2rRN9OxckWtG
X-Gm-Message-State: AOJu0YySqk659Ig2ZaQCHU7V4y8pr63JU4NuTyykfRjjnS29ne828Zwg
	uZ1xh5J2HEm+1e6/QXasAXZSSEONWRmMi61m151e5hDboaxj0gxz+lXsdUIl7nM=
X-Google-Smtp-Source: AGHT+IGy4pHyrGgiDEtdIBqpgQzGrmuTcbZzIkFUCPPzqcWHeAqI5EV5Mv+IuXtIUiJAwLJqcvp+Jw==
X-Received: by 2002:a17:906:4554:b0:a46:b8ed:8a9 with SMTP id s20-20020a170906455400b00a46b8ed08a9mr6443836ejq.55.1710918943919;
        Wed, 20 Mar 2024 00:15:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id gy4-20020a170906f24400b00a45f39b2d16sm6818936ejb.200.2024.03.20.00.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 00:15:43 -0700 (PDT)
Message-ID: <70846fbb-9c17-440a-911d-456b0444dd94@linaro.org>
Date: Wed, 20 Mar 2024 08:15:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: exynos: gs101: add poweroff node
To: Alexey Klimov <alexey.klimov@linaro.org>, sre@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 peter.griffin@linaro.org, robh+dt@kernel.org
Cc: conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
 semen.protsenko@linaro.org, linux-kernel@vger.kernel.org,
 klimov.linux@gmail.com, kernel-team@android.com, tudor.ambarus@linaro.org,
 andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com,
 alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
 elder@linaro.org
References: <20240320020549.71810-1-alexey.klimov@linaro.org>
 <20240320020549.71810-2-alexey.klimov@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240320020549.71810-2-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 03:05, Alexey Klimov wrote:
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> index 55e6bcb3689e..9def28393274 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -509,6 +509,13 @@ sysreg_apm: syscon@174204e0 {
>  		pmu_system_controller: system-controller@17460000 {
>  			compatible = "google,gs101-pmu", "syscon";
>  			reg = <0x17460000 0x10000>;
> +
> +			poweroff {
> +				compatible = "google,gs101-poweroff";
> +				samsung,syscon-phandle = <&pmu_system_controller>;

This is just senseless... you are the child of pmu, as seen in this DTS.
You do not need to reference yourself (so the PMU)!



Best regards,
Krzysztof


