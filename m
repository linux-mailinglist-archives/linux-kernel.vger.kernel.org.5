Return-Path: <linux-kernel+bounces-87407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9031486D408
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E6F1F244B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618821428E2;
	Thu, 29 Feb 2024 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKhXyWtX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14F13F45D;
	Thu, 29 Feb 2024 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237852; cv=none; b=Mc/yA8ExdmL6yU4uGzSXHVzTlWJkgxgc9PANhjiG63UqrveK32wMsp2jbg1aIRrSNOubsU0I/fPIucWRDuVJwBmZ4BQt7K7BzYr1f1a+5yFrD2ckdIrxBoNekJdWv3/Tc6L1Qr54RWt0ws5AGgtcVVRmzLS5mt5MyF+vVrIkscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237852; c=relaxed/simple;
	bh=8n5E2LNXBRgRqn3a4H2ui7bU8RY9UINwxZyuyW3QsfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4QFYWfgk6+Ok9M1YifpXfQrnMoOPIQXEjOSI3yK6/205aadchRqfUy60jwgEBq/37UlkWovoOSFbfz/muBE8TAf4LXxd8CcC/EuBaPGHN9357eRvUX449kF5OYjoP1fQzAH9U2ZwkmnfF0L3ULdjAtsfXNAGaeZndbpkJgn7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKhXyWtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA15C433C7;
	Thu, 29 Feb 2024 20:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709237850;
	bh=8n5E2LNXBRgRqn3a4H2ui7bU8RY9UINwxZyuyW3QsfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KKhXyWtXJL9AeWBjmkp+BjnZVMoeL7I7O6cKVu75Omefa3kkRKKkP1B6mcxvyt0I8
	 Hyb9ZwsVKu/K12QbKYij6JMIOnn1XJXBQ3yrUqPWSGDCmumQjMEuKxxwjHqm6Fu9H6
	 7VOtYGFfwbhhM8XaxEpcfiv27VgfPyAi+9drfZPP7Trsie2y2i0+XLZWSWg9DyjqWL
	 p1MPUJWGNbKAgA9UZSt/R0NvlrktC0pDfAo18+F7gbtyfBolL//rk+DJKxgQ+wXZRF
	 KBKrhWJpG/O5b+6/6KC9w+KLLrOAMr8kpyKLOpWItuGTPxfvHp2/V/SXQszNgD36U+
	 b6KMRbw0ZHnow==
Message-ID: <ac88ea82-d541-4016-95ce-58388b1f86e7@kernel.org>
Date: Thu, 29 Feb 2024 22:17:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] dt-bindings: iommu: Add Qualcomm TBU bindings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Georgi Djakov <quic_c_gdjako@quicinc.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev
Cc: devicetree@vger.kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, robdclark@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com,
 quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com
References: <20240226172218.69486-1-quic_c_gdjako@quicinc.com>
 <20240226172218.69486-2-quic_c_gdjako@quicinc.com>
 <1239b980-da57-4cb1-bde0-47550dcf1065@linaro.org>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <1239b980-da57-4cb1-bde0-47550dcf1065@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 29.02.24 19:59, Krzysztof Kozlowski wrote:
> On 26/02/2024 18:22, Georgi Djakov wrote:
>> The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
>> of the SMMU-500, that consists of a single TCU (Translation Control
>> Unit) and multiple TBUs (Translation Buffer Units). These TBUs have
>> hardware debugging features that are specific and only present on
>> Qualcomm hardware. Represent them as independent DT nodes. List all
>> the resources that are needed to operate them (such as registers,
>> clocks, power domains and interconnects).
>>
>> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
>> ---
>>   .../devicetree/bindings/iommu/qcom,tbu.yaml   | 65 +++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
> 
> Heh, I wonder how did you solve Robin's comments. I don't see you
> responding to Robin. Just v5 sent...

Yeah, i didn't respond because his response was clear to me. He responded
to the fundamental question whether to model the TBUs as child DT nodes of
the SMMU or as standalone nodes. So in the first versions of this patchset
we tried to explore the path with "child" nodes and search if there are any
other implementation than the Qualcomm one and try to find some common
binding... and Robin's objection was exactly to that. It seems that adding
more functionalities in TBUs (which requires resource management) is only
a Qualcomm thing and common binding does not make sense, so now we are
going with standalone DT nodes as he suggested.

Thanks,
Georgi

