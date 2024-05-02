Return-Path: <linux-kernel+bounces-166751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD488B9EF6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE641C215D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B3B16F908;
	Thu,  2 May 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzRLyXgc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430D15E80E;
	Thu,  2 May 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668845; cv=none; b=lG83rJzkONZQz0/Mpykkzr2xwwaiKbsToShcHRddP1EWB1/rYPrUY8HdA9984ZNqWRIjnxexaWqkXOYCWtORBoq4i19vhPKdOvgi+9E16eyDQiKVXoRaXNPFe4kJ1XSA1bfz6wt7i8hI1bPkKqfb4PJoRwzhJl+tjWhnMEjSVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668845; c=relaxed/simple;
	bh=OLGfIPy7WzXr5vPGBKNPCXFEJl7Vq520a+RMhrYvuO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZFPUYsJpQIJoipIXUDHXxxjw5F8O3NmKcaBUeHk2jqP66MWQvdVOmSGYOPFloCC7Us8VAN36IbtzysfsV23HkIoM5se8RQ53EEeTLzY5FWGeOjoq0OU5gYDBuEaiwLfksCckIZHmsZQydBtgU8PMlB9Ttyfxlmx0PkdUxJAqT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzRLyXgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA938C116B1;
	Thu,  2 May 2024 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714668844;
	bh=OLGfIPy7WzXr5vPGBKNPCXFEJl7Vq520a+RMhrYvuO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GzRLyXgcaxa8KUf1gzDxi1g9pS3L7O2CBA0GR0/B02Xd/v5fw0790sP7bma6wJej7
	 srExDQkAByoIChhIH4GJM29CDBpoERkPNfBz4UaE8Bo+9pbgmwKb/X3vj69wHw2cAe
	 DofeWNyOWo+u8mRHAGY9wzt9PszhIlXK0wG/vkbLqBUxzezNSiyvKckHFDyyZtVIYP
	 lTtmLwCzvcvRLvIHj0XiCmrmi34F6kMD86sJrz4n3UYH2jvnl89TyVLylxxSdnChB+
	 O5awecR8RqlykXDWZH7WbfxedHmfhR7hAuY65qTnMrd8ZLppBvixHWmZmU9FI7jS1/
	 QXOJwitZWsq3w==
Message-ID: <963a1006-a68f-448d-807f-40c9e85e1c2a@kernel.org>
Date: Thu, 2 May 2024 19:53:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] iommu/arm-smmu-qcom-debug: Add support for TBUs
Content-Language: en-US
To: Will Deacon <will@kernel.org>, Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 robdclark@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com, quic_pdaly@quicinc.com,
 quic_sudaraja@quicinc.com
References: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com>
 <20240417133731.2055383-3-quic_c_gdjako@quicinc.com>
 <20240501143400.GA15503@willie-the-truck>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240501143400.GA15503@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Will,

On 1.05.24 17:34, Will Deacon wrote:
> Hi Georgi,
> 
> On Wed, Apr 17, 2024 at 06:37:26AM -0700, Georgi Djakov wrote:
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
>> index bb89d49adf8d..eff7ca94ec8d 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> 
> ...
> 
>> +static const struct of_device_id qcom_tbu_of_match[] = {
>> +	{ .compatible = "qcom,sc7280-tbu" },
>> +	{ .compatible = "qcom,sdm845-tbu" },
>> +	{ }
>> +};
>> +
>> +static struct platform_driver qcom_tbu_driver = {
>> +	.driver = {
>> +		.name           = "qcom_tbu",
>> +		.of_match_table = qcom_tbu_of_match,
>> +	},
>> +	.probe = qcom_tbu_probe,
>> +};
>> +builtin_platform_driver(qcom_tbu_driver);
> 
> I just noticed that this breaks a modular build of the arm-smmu driver
> because we now have two init functions for the module:
> 
>    ld.lld: error: duplicate symbol: init_module
>    >>> defined at arm-smmu.c
>    >>>            drivers/iommu/arm/arm-smmu/arm-smmu.o:(init_module)
>    >>> defined at arm-smmu-qcom-debug.c
>    >>>            drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.o:(.init.text+0x4)
> 
> I think you should initialise the TBU debug feature by calling into it
> manually from qcom_smmu_impl_init().
> 
> Please can you send a patch to fix that? For now, I'll bodge it so that
> the qcom debug stuff doesn't build as a module (see below).

Тhanks for sorting that out and apologies for missing it. We are at rc6 now and
i am afraid that i won't be able to validate my patch until next week (Easter
holidays here). I'll definitely send the rework when I get back.

BR,
Georgi

> 
> Cheers,
> 
> Will
> 
> --->8
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 032bfd681307..66325210c8c9 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -376,7 +376,7 @@ config ARM_SMMU_QCOM
> 
>   config ARM_SMMU_QCOM_DEBUG
>          bool "ARM SMMU QCOM implementation defined debug support"
> -       depends on ARM_SMMU_QCOM
> +       depends on ARM_SMMU_QCOM=y
>          help
>            Support for implementation specific debug features in ARM SMMU
>            hardware found in QTI platforms. This include support for
> 


