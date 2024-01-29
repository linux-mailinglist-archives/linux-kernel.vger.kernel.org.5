Return-Path: <linux-kernel+bounces-42572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF884033E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C02283723
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D565A799;
	Mon, 29 Jan 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcQDfkYr"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148EC5A0FE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525674; cv=none; b=XVSx3P8Gy45NbCZY0GDcF52XdAshUw/gzkpEm9nJb1AWmFHjbnF4qUtEuK1dmp6EfdXlnrjORuGCgghryJUKKKBBvw/188h0nnz0qD/gB/+OdsZcRc25ZQL+RMSI2E9gkY9S4wNZJxtuB4ciKRplsPCYdORmcxt6sScstwzKncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525674; c=relaxed/simple;
	bh=pmYCeHvnx4VaiExqcBWEO6e0a64iMl8rwNzANq8/yjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIpOio/HqT3KdKHu3xD1WNfASKLXtfI1nUhFRXO2uc1WTNhnYgYJCpt/ywdELMMykStIQ3JOjeVOp6XIa4sBD6Wjc8bGXGwZJPrepnszno3ZrphSpa1pzfShxsYFkyThYwaLnbO7SO+gbR1vthLAD5OCJ9EQJPn8Cd0Od8CMyTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xcQDfkYr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a358ec50b7cso174062166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706525671; x=1707130471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/oSSDICCHbrdP4BH59WaW/TlR2fru4lRGyTtk+4aYs=;
        b=xcQDfkYrBGblf+kQeUU/3LH1QuI6v0Hl8nu1hIk5BVKWsETGf8bWxuTVYzwqG/EcSh
         dxVCl/ibgJIxb5N7ga0Vvbqpvc4XAzB/qlBh1g2Zq8aaL9Xv1SHZG8Hl+/TpyLSBPF66
         x6kTPHqxsa5OMWNYGONI9EYVSHosDojoJB0EsDuCz/DBTTraBjZsYmN/GSB+DElUzefh
         XKrgLnqO9uOsT6J3eGBqqqzGNsOPkd2qbxENEVGzIrJf2tIF1RD+1ef45n5jBoDKRZD9
         sotbTtWfrdkCf518AfbfWHEPft/5F1mQxCC+LXE4Db6Ru2IbldX/vddyZbf2IhOEdjRt
         R5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706525671; x=1707130471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/oSSDICCHbrdP4BH59WaW/TlR2fru4lRGyTtk+4aYs=;
        b=B6narRgCRuFW2Z+y0rk55FWJOvoRSliFlkCq/Y1byMUXeCihwtnqPkwbusMo3MUFrm
         wOrn4xYHbdzDqPUK3oa0Wh9SOsJhVzfhSBPvf2w9/A6bM8asoy5CFtBT41mxVCsiAhpw
         FQhysiIVhuUKP2QNCH6cPDDAaUx8UuvRsSYGvHIDygFkwrs7B3R+FoGan0eDfITcUW1c
         RkDpIN4bdgrowPyBs7EHV59ZjD+TkkVDnWNUa3BnhsCHyy+QzGctqQDjEJ9dG4QOZs/U
         4IFmGcHHtm0Z54D3YqmGKMbWq78f16F5OKHSN8EjHsap9c9e8IE4+N5IS1gPfEe83aRb
         xUXA==
X-Gm-Message-State: AOJu0YxT/N/Gyj8jwv58muCt6c/nz9AGzp6V6B+gtaZg3xVooOvUyMs7
	gQ6BqK0nrL0fMhccB7juaqx5YlN6xWmtgxQ4ReZTRDfHFMoJBt1Fn59nWs8baXM=
X-Google-Smtp-Source: AGHT+IGYJNC7edW5Scg3uDqbgjo1SqWrpwkLVxKzftNyn2dt9ODUd83gW+enc/Joa5DPoyRrJaHk+A==
X-Received: by 2002:a17:906:4eca:b0:a28:c04e:315b with SMTP id i10-20020a1709064eca00b00a28c04e315bmr5994406ejv.13.1706525671246;
        Mon, 29 Jan 2024 02:54:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id hd10-20020a170907968a00b00a35cd148c7esm636039ejc.212.2024.01.29.02.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 02:54:30 -0800 (PST)
Message-ID: <83b4315c-f2d8-419d-9b16-36341764b797@linaro.org>
Date: Mon, 29 Jan 2024 11:54:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Fix
 the usage of aux clk
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
 <20240124-pcie-aux-clk-fix-v1-4-d8a4852b6ba6@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240124-pcie-aux-clk-fix-v1-4-d8a4852b6ba6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2024 08:36, Manivannan Sadhasivam wrote:
> On some platforms, PHY block requires PCIE_PHY_AUX_CLK to be used when the
> PCIe link enters L1SS state. On those platforms, a dedicated
> PCIE_PHY_AUX_CLK is available from GCC. Other than this, the PHY block
> doesn't require any other "aux" clock, including PCIE_AUX_CLK which only
> required by the PCIe controller.
> 
> Historically, the DTs of the platforms requiring "aux" clock passed
> PCIE_PHY_AUX_CLK as "aux" clock. But over the period of time, platforms
> that do not require this dedicated "aux" clock mistakenly started passing
> the PCIE_AUX_CLK as the "aux" clock. More recently, SA8775P platform passed
> both "aux" (PCIE_AUX_CLK) and "phy_aux" (PCIE_PHY_AUX_CLK) clocks.
> 
> So to clean up this mess, let's remove the newly introduced "phy_aux" clock
> and just use "aux" clock to supply PCIE_PHY_AUX_CLK for platforms that
> require it. For the platforms that do not require a dedicated "aux" clock,
> the clock is removed from DT.
> 
> While at it, let's also define "qcom,sc7280-qmp-pcie-phy" compatible for
> SC7280 SoC which was earlier using the compatible
> "qcom,sm8250-qmp-gen3x2-pcie-phy" as the clock requirement has changed and
> also restructure the "clock-names" property for the affected platforms.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


