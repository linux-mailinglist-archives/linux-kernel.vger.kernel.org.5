Return-Path: <linux-kernel+bounces-87405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C6F86D400
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105FF2878F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A5B1428EA;
	Thu, 29 Feb 2024 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnLha4aA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A513C9FE;
	Thu, 29 Feb 2024 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237658; cv=none; b=uppaZpDF6KM3PmCBrqfkFE0HermanbVUzCeqUD/eXqtslcRUpiWn8bZqQpTc8Res6E9cYrG/3dQGf/D6cBW1/Zd6M1vYref0Gr30KwhKErV4uli3YrbHN6JKn1ICAvZrW5YpMrFTmo9Gr3kFgMm6rL+Az7zATQTk9AvdhsVQpM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237658; c=relaxed/simple;
	bh=AC6JkL6Q3RfazJY9jLwBl0iSvQYlKRfNSvpZ3ZQFQXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIay2jq/TJKbi3/A7kjGM7OofoABtwORzCMRoeoDElmti91JSO/pUynE4gPSS5Bl0tCaW01PGt0py7M/F1uq2ddC2Fk+9huoLluzBaBUyqitO5x4bi607RKVdYmfR/AmzJhjcgSxrtgLeubECuMQ7uPTqrvQdqIqlZ6ooi5eOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnLha4aA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B42C433F1;
	Thu, 29 Feb 2024 20:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709237658;
	bh=AC6JkL6Q3RfazJY9jLwBl0iSvQYlKRfNSvpZ3ZQFQXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cnLha4aAslvhNHCRCYM9UXosEbo3T1rVat/CpcVKTxcpiZ+77N4I2sbNZ/Avswoy3
	 FtiGA9KpmDDA4mAZubxqwHkTKVohFUE9A4fe1OB25VG9KpjguS0sdBs3S51Bct8lLI
	 8aaz/Jkl8qK9LmC4Z4vRLJOjvvQOxpUOH60asal0TYbeOnZVlijOByvGQgnxdXm0gt
	 jpdBcuLsKnkc6RilJ0Tf0+lg+GEfM19UoS1Zlv/Iqxewd3uMknnRFFdF5ebwmy5urp
	 PTwGfBErrj6kEbl5Zt8wXyNFvQjE2VdYrMuJFPfe9oVzYcz6ZF9lGzsjIdDgWGYnuB
	 BaYHF0lLJt4RQ==
Message-ID: <4fc15eda-07e1-4e8d-b5d7-bcc66c69f310@kernel.org>
Date: Thu, 29 Feb 2024 22:14:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] arm64: dts: qcom: sc7280: Add DT nodes for the
 TBUs
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
 <20240226172218.69486-8-quic_c_gdjako@quicinc.com>
 <926bde97-64ac-4cb4-8821-9dc828052e8d@linaro.org>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <926bde97-64ac-4cb4-8821-9dc828052e8d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 29.02.24 19:55, Krzysztof Kozlowski wrote:
> On 26/02/2024 18:22, Georgi Djakov wrote:
>> Add the device-tree nodes for the TBUs (translation buffer units) that
>> are present on the sc7280 platforms. The TBUs can be used debug the
>> kernel and provide additional information when a context faults occur.
>>
>> Describe the all registers, clocks, interconnects and power-domain
>> resources that are needed for each of the TBUs.
>>
>> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 89 ++++++++++++++++++++++++++++
>>   1 file changed, 89 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 83b5b76ba179..cc42560f63ad 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2905,6 +2905,18 @@ adreno_smmu: iommu@3da0000 {
>>   			dma-coherent;
>>   		};
>>   
>> +		gfx_0_tbu: tbu@3dd9000 {
>> +			compatible = "qcom,qsmmuv500-tbu";
>> +			reg = <0x0 0x3dd9000 0x0 0x1000>;
>> +			qcom,stream-id-range = <&adreno_smmu 0x0 0x400>;
> 
> Where are the clocks/interconnects/power-domains? Your binding said it
> is exactly (100%) the same as SDM845, so either binding is missing
> compatibles or this is incomplete.

The clocks/interconnects/power-domains are optional and each of them could
be present or not. And that's why none of these properties are listed as
"required".

BR,
Georgi

