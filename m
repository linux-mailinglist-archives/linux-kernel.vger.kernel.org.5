Return-Path: <linux-kernel+bounces-9123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3BE81C0E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770C5B21BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0268C77B5A;
	Thu, 21 Dec 2023 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="H272Hf02"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C777635;
	Thu, 21 Dec 2023 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [10.0.0.200] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 5591D16370D;
	Thu, 21 Dec 2023 23:18:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1703197134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Oyn0x9j7Q/evOuVYf/pwa9Zz2tqlf6BV4LqW1vk5c/4=;
	b=H272Hf020r9S6wemNcdO/WSAqYtbQHYjV+7S54Hsf9jiOO+Hwvi3VfCnmmWiMvihzkBp0w
	y1qyFb7HeKa7W4BX23jA5n1bEBuWNbJUpXDgssg+L0x8U/+JgRsLaBGYn9PCsU7N9GZ3Dx
	EWTMzsD8ZlAJ+Zr3ckbLpuFweCFCS/g=
Message-ID: <2945c7f7-a847-4a7f-b075-70c1b4e6e7dc@ixit.cz>
Date: Thu, 21 Dec 2023 23:18:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v6] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
To: Rob Herring <robh@kernel.org>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20231219202907.186381-1-david@ixit.cz>
 <20231221134121.GA3660857-robh@kernel.org>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20231221134121.GA3660857-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/12/2023 14:41, Rob Herring wrote:
> On Tue, Dec 19, 2023 at 09:28:27PM +0100, David Heidelberg wrote:
>> Convert Qualcomm IOMMU v0 implementation to yaml format.
>>
>> iommus part being ommited for the other bindings, as mdp4 one.
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>> v6:
>>   - clean iommu-cells description (thx @Robin)
>> v5:
>>   - updated example (thx @Konrad)
>>   - ordering of requirements + dropped > and | and reformatted (thx @Konrad)
>> v4:
>>   - renamed to qcom,apq8064-iommu as Rob requested
>>   - changed title to Qualcomm APQ8064 IOMMU
>>   - dropped quotes around URLs
>>   - dropped mdp node
>>   - dropped unused mdp_port0 label
>>
>> v3:
>>   - I kept the name as -v0, since we have other binding -v1 and it look
>>     good, I can change thou in v4 if requested.
>>   - dropped non-existent smmu_clk part (and adjusted example, which was
>>     using it)
>>   - dropped iommu description
>>   - moved iommu-cells description to the property #iommu-cells
>>
>> v2:
>>   - fix wrong path in binding $id
>>   - comment qcom,mdp4 node example (we don't want to validate it yet)
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>
>>   .../bindings/iommu/msm,iommu-v0.txt           | 64 ----------------
>>   .../bindings/iommu/qcom,apq8064-iommu.yaml    | 76 +++++++++++++++++++
>>   2 files changed, 76 insertions(+), 64 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>>   create mode 100644 Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>> deleted file mode 100644
>> index 20236385f26e..000000000000
>> --- a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>> +++ /dev/null
>> @@ -1,64 +0,0 @@
>> -* QCOM IOMMU
>> -
>> -The MSM IOMMU is an implementation compatible with the ARM VMSA short
>> -descriptor page tables. It provides address translation for bus masters outside
>> -of the CPU, each connected to the IOMMU through a port called micro-TLB.
>> -
>> -Required Properties:
>> -
>> -  - compatible: Must contain "qcom,apq8064-iommu".
>> -  - reg: Base address and size of the IOMMU registers.
>> -  - interrupts: Specifiers for the MMU fault interrupts. For instances that
>> -    support secure mode two interrupts must be specified, for non-secure and
>> -    secure mode, in that order. For instances that don't support secure mode a
>> -    single interrupt must be specified.
>> -  - #iommu-cells: The number of cells needed to specify the stream id. This
>> -		  is always 1.
>> -  - qcom,ncb:	  The total number of context banks in the IOMMU.
>> -  - clocks	: List of clocks to be used during SMMU register access. See
>> -		  Documentation/devicetree/bindings/clock/clock-bindings.txt
>> -		  for information about the format. For each clock specified
>> -		  here, there must be a corresponding entry in clock-names
>> -		  (see below).
>> -
>> -  - clock-names	: List of clock names corresponding to the clocks specified in
>> -		  the "clocks" property (above).
>> -		  Should be "smmu_pclk" for specifying the interface clock
>> -		  required for iommu's register accesses.
>> -		  Should be "smmu_clk" for specifying the functional clock
>> -		  required by iommu for bus accesses.
>> -
>> -Each bus master connected to an IOMMU must reference the IOMMU in its device
>> -node with the following property:
>> -
>> -  - iommus: A reference to the IOMMU in multiple cells. The first cell is a
>> -	    phandle to the IOMMU and the second cell is the stream id.
>> -	    A single master device can be connected to more than one iommu
>> -	    and multiple contexts in each of the iommu. So multiple entries
>> -	    are required to list all the iommus and the stream ids that the
>> -	    master is connected to.
>> -
>> -Example: mdp iommu and its bus master
>> -
>> -                mdp_port0: iommu@7500000 {
>> -			compatible = "qcom,apq8064-iommu";
>> -			#iommu-cells = <1>;
>> -			clock-names =
>> -			    "smmu_pclk",
>> -			    "smmu_clk";
>> -			clocks =
>> -			    <&mmcc SMMU_AHB_CLK>,
>> -			    <&mmcc MDP_AXI_CLK>;
>> -			reg = <0x07500000 0x100000>;
>> -			interrupts =
>> -			    <GIC_SPI 63 0>,
>> -			    <GIC_SPI 64 0>;
>> -			qcom,ncb = <2>;
>> -		};
>> -
>> -		mdp: qcom,mdp@5100000 {
>> -			compatible = "qcom,mdp";
>> -			...
>> -			iommus = <&mdp_port0 0
>> -				  &mdp_port0 2>;
>> -		};
>> diff --git a/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml
>> new file mode 100644
>> index 000000000000..b9a2d02ed2e6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml
>> @@ -0,0 +1,76 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +
>> +$id: http://devicetree.org/schemas/iommu/qcom,apq8064-iommu.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm APQ8064 IOMMU
>> +
>> +maintainers:
>> +  - Will Deacon <will@kernel.org>
> This should be someone from QCom or that otherwise cares about this
> device.
Can I put Sricharan Ramabadhran <quic_srichara@quicinc.com> here (CCed)?
>
>> +
>> +description:
>> +  The MSM IOMMU is an implementation compatible with the ARM VMSA short
>> +  descriptor page tables. It provides address translation for bus masters
>> +  outside of the CPU, each connected to the IOMMU through a port called micro-TLB.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,apq8064-iommu
>> +
>> +  clocks:
>> +    items:
>> +      - description: interface clock for register accesses
>> +      - description: functional clock for bus accesses
>> +
>> +  clock-names:
>> +    items:
>> +      - const: smmu_pclk
>> +      - const: iommu_clk
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    description: Specifiers for the MMU fault interrupts.
>> +    minItems: 1
>> +    items:
>> +      - description: non-secure mode interrupt
>> +      - description: secure mode interrupt (for instances which supports it)
>> +
>> +  "#iommu-cells":
>> +    const: 1
>> +    description: Each IOMMU specifier describes a single Stream ID.
>> +
>> +  qcom,ncb:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: The total number of context banks in the IOMMU.
> Is there a maximum? I assume it is not 2^32.

It's signed 32-bit int (because of armv7), haven't seen any limit in the 
code . In dts there are only values 2 or 3.

Should I set min to 1 and max to (2^31)-1?

>
>> +
>> +required:
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - qcom,ncb
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    iommu@7500000 {
>> +            compatible = "qcom,apq8064-iommu";
>> +            reg = <0x07500000 0x100000>;
>> +            interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&clk SMMU_AHB_CLK>,
>> +                     <&clk MDP_AXI_CLK>;
>> +            clock-names = "smmu_pclk",
>> +                          "iommu_clk";
>> +            #iommu-cells = <1>;
>> +            qcom,ncb = <2>;
>> +    };
>> -- 
>> 2.43.0
>>
-- 
David Heidelberg


