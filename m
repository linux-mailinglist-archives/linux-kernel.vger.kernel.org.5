Return-Path: <linux-kernel+bounces-67454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4E4856BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A537B237B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30923138495;
	Thu, 15 Feb 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OaG8V6z8"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E11369AC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019876; cv=none; b=hdTVqlHHsTgZO3IMwmKvCTrFrFK2DGHfR1q+VfnDwkh3xCj2bE2JQh//xjdPN7JpsiUpKCQpl86rKbuErFwkWOi7NLD+4pBvrQE4u6qhbN3fxpVMVw2JnU70Dpihxe3480WIayTg9/32YURHLkiYek64c4TTnumZ+NdgK+/o8V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019876; c=relaxed/simple;
	bh=yIhtn16WTN1U1iPhbljv/BOXJNAevBuCMj+cdaPl2/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJJVydn3GGkPMCO0BZucvYAWdhvjRJSGyxEV2aEehb70B1+nz3wdQfAbsmOOkPE/NJ1AQmesuUQ6IjX0jXLBP0c+dXeKAQtCIblvJDoWL8woTKHN9liG3u+fD9CeJhoSMSQh3Vy+Zau+rlfitlq5RNnczfX2dmtSCxdcK6oci18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OaG8V6z8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51182ece518so1380327e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708019873; x=1708624673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bzg0JZnBuG9xbxYGq7b3vA4VfEtQYoIHH8VKH+YR0eo=;
        b=OaG8V6z8gAkPvycNB+GziPke3q5fnucfEWhKcEhUteEcNyyXV4bIyo16Ew54KICYOf
         37JsEm6hjXDm/3IflNjgAgxGCMZqu6qy+eEqe5/9toRAWkMpV5XCmfMFyx8A1hCwk66y
         hUn3qP0WQ+rDuny8TBdpyHgzZ7+eXvyNMQms0NrgNL3zTj3m2qjV5QomckAR6rTUSThm
         rmYQPevNOKT4IwAqEtuyUgwisVNko19kCOBL+T11h8ZB0IKZfR8MiiIAhRcUn87nQ62E
         mYg0O+wob/b674qnPLTo62DiJuepXK29e7NJXMcJIsr7nxv+8iEPLFSqPfuDGCVZsgOs
         FrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019873; x=1708624673;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzg0JZnBuG9xbxYGq7b3vA4VfEtQYoIHH8VKH+YR0eo=;
        b=cFmcCyEg635WMwVgvvw0P5SEMbmyFz3+xuKu0MEQQ/dhah8tC2tuHHeYCbZkIKWKE6
         2dvCitEhtoqaD/N+bwB2F/tfqNekOT110tjJ60AMGMrvifSrGANUq9eMH/51zTD/lV59
         qoyKy60n0HlE0sqsuTwy3npPe0mpwHhIQ47cT6wcc6lPy1vG98wD4Gz6Wpaxr2k471vg
         hQvN2krD7jzbHFa62EUb0jGjuoeMjbNQ4BkUhdtrs0hHW43svxJxTr8FRPvCdVQI8O9v
         YboswOmnkorg3p6Dm9IF+p1jqt2CG5eEK2RfJeIZMtMHcjnIdDPfV6NJp8B+d7+wE0Hh
         k0CA==
X-Forwarded-Encrypted: i=1; AJvYcCULxuO499qBdLpm8s9o+p/FWSGFiUa585dY1KZBvmZmNoulKiNPjf1D1q0PA1PU9XLxdMzwEkZl7yaEQd9VMGq6MBcsXjm06fBATirr
X-Gm-Message-State: AOJu0YwHLYEd0f/pGplsNZF9qFn9Yhpr3R4m6CWqLcXiCvzFNPR9xmo2
	03TKVR3s1gYDJ9YpGqbClXc4+huA8aawayEITmlthglSPyi77DIrPQG3mnwU9Rg=
X-Google-Smtp-Source: AGHT+IEgWc7gk7Qw+cWxS3tvYJs5tD8dCPuz++09dvf4RN6mi1qt5Xjy9cWFXxSDHU3kPh4Gu11FvQ==
X-Received: by 2002:a05:6512:3f06:b0:512:8d30:6dce with SMTP id y6-20020a0565123f0600b005128d306dcemr879333lfa.52.1708019872670;
        Thu, 15 Feb 2024 09:57:52 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id h32-20020a0564020ea000b00561e675a3casm749438eda.68.2024.02.15.09.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 09:57:52 -0800 (PST)
Message-ID: <d1c80d3f-3b70-4630-8f7d-b00983b487dd@linaro.org>
Date: Thu, 15 Feb 2024 18:57:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] spi: spi-qpic: Add qpic spi nand driver support
Content-Language: en-US
To: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
 broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-4-quic_mdalam@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240215134856.1313239-4-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 14:48, Md Sadre Alam wrote:
> Add qpic spi nand driver support. The spi nand
> driver currently supported the below commands.
> 
> -- RESET
> -- READ ID
> -- SET FEATURE
> -- GET FEATURE
> -- READ PAGE
> -- WRITE PAGE
> -- ERASE PAGE
> 
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

[...]

> +void snandc_set_reg(struct qcom_nand_controller *snandc, int offset, u32 val)
> +{
> +	struct nandc_regs *regs = snandc->regs;
> +	__le32 *reg;
> +
> +	reg = offset_to_nandc_reg(regs, offset);
> +
> +	if (reg)
> +		*reg = cpu_to_le32(val);

if (WARN_ON(!reg))
	return;

instead?

This would be tragic..

[...]

> +
> +	ecc_cfg->cfg0 = (cwperpage - 1) << CW_PER_PAGE
> +				| ecc_cfg->cw_data << UD_SIZE_BYTES
> +				| 1 << DISABLE_STATUS_AFTER_WRITE
> +				| 3 << NUM_ADDR_CYCLES
> +				| ecc_cfg->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_RS
> +				| 0 << STATUS_BFR_READ
> +				| 1 << SET_RD_MODE_AFTER_STATUS
> +				| ecc_cfg->spare_bytes << SPARE_SIZE_BYTES;

Let me introduce you to FIELD_PREP/GET and GENMASK().. Many assignments
in this file could use these.

Konrad

