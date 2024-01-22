Return-Path: <linux-kernel+bounces-33115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E49738364E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A871C22121
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22143D3A1;
	Mon, 22 Jan 2024 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PQcImdyj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDF3D0BC;
	Mon, 22 Jan 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931787; cv=none; b=bhj2+rrQnDCLGGFhnCihF8na4WArTLN7/prWPX1LAEJvqRs0bINIF+x24pGhY5W1V9NJXXQzFngSSwsEPELs5p17kQb3HOZFYIs6kFjwfPPJXbjYZnYccLNfLz1o4cH9yrPw30rFVlTv48snd7OS2yOJQVwLWOjUuKO7rWBgB4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931787; c=relaxed/simple;
	bh=9Ptx+A83euIyL8WhZekoOPIjvyyV1H/kK/XJo7K/kxk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=iNZLc1PUjg+BiEuND8S/GTfwyYHT7djLjFAh+pcSj+WYOe5XMWS91jAgHD7++Vf99DVFmzeiiDEJ33Urj2/hLMP+lyEt2g+8OJp+brkWk5MVwI6IsV4HrXNXUoLR2XBQ9gWVyw8NkQHmp1XdzKcTzLcyKsbwaC+qyPQcwh0z/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PQcImdyj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MAc2L1006066;
	Mon, 22 Jan 2024 13:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=86w3yguDEs33I+HmwkQtPGS6YqsmWAvpHxI5zEtuqrk=; b=PQ
	cImdyjslOMvGccRMde4QcVFcghWNRPRgFlhHB3c934v82deiFNHkv7v8/hqnEgb8
	ji+ghdtJWB01ptHWhPObW5l7eQKXjuvvmFlo2q4Gsm7zf/lvQszs6/rHXdcifg3q
	hvn/EZ772p6uMUAjqgBUmfn1G8EsCdypPtEsptIVEQpyeEkezCvdYp9AzA2bRVRL
	Fs6TPmwMlU0QeCf3n3/U1V1tLTj40Y72RYFZpW16WNCaEM58PgOP4EqNDKmePi6V
	Vp5KGteS8bQ+85pcdYF1DO85aac1iQvuOVMzT6+uNDSmaFuP3rHi13mhEoKUeH6m
	2dTBm3xHY7OyRL7kUIFA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr7bqm290-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 13:55:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MDtTMA022218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 13:55:29 GMT
Received: from [10.253.14.163] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 05:55:18 -0800
Message-ID: <749136bc-3db9-4b2d-a9ca-e5fb5985f639@quicinc.com>
Date: Mon, 22 Jan 2024 21:55:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jie Luo <quic_luoj@quicinc.com>
Subject: Re: [PATCH net-next 02/20] dt-bindings: net: qcom,ppe: Add bindings
 yaml file
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <linux@armlinux.org.uk>,
        <shannon.nelson@amd.com>, <anthony.l.nguyen@intel.com>,
        <jasowang@redhat.com>, <brett.creeley@amd.com>,
        <rrameshbabu@nvidia.com>, <joshua.a.hay@intel.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>,
        <jacob.e.keller@intel.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <ryazanov.s.a@gmail.com>, <ansuelsmth@gmail.com>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
 <20240110114033.32575-3-quic_luoj@quicinc.com>
 <1d1116da-9af3-49e4-a180-cff721df5df5@linaro.org>
Content-Language: en-US
In-Reply-To: <1d1116da-9af3-49e4-a180-cff721df5df5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: chDJtnwMoK9Acncpdo2EZLaSICOENM7b
X-Proofpoint-ORIG-GUID: chDJtnwMoK9Acncpdo2EZLaSICOENM7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1011 spamscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220095



On 1/10/2024 8:22 PM, Krzysztof Kozlowski wrote:
> On 10/01/2024 12:40, Luo Jie wrote:
>> Qualcomm PPE(packet process engine) is supported on
>> IPQ SOC platform.
>>
> 
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> Basically your subject has only prefix and nothing else useful.
> 
> Limited review follows, I am not wasting my time much on this.

Will remove the redundant words, and follow up the guidance
mentioned in the link. Will correct the subject as well.

> 
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   .../devicetree/bindings/net/qcom,ppe.yaml     | 1330 +++++++++++++++++
>>   1 file changed, 1330 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/qcom,ppe.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/qcom,ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ppe.yaml
>> new file mode 100644
>> index 000000000000..6afb2ad62707
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/qcom,ppe.yaml
>> @@ -0,0 +1,1330 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/qcom,ppe.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Packet Process Engine Ethernet controller
> 
> Where is the ref to ethernet controllers schema?
Sorry, the title above is not describing the device for this dtbindings
correctly.  It should say "Qualcomm Packet Process Engine". The
reference to the schema for PPE is mentioned above.

> 
>> +
>> +maintainers:
>> +  - Luo Jie <quic_luoj@quicinc.com>
>> +
>> +description:
>> +  The PPE(packet process engine) is comprised of three componets, Ethernet
>> +  DMA, Switch core and Port wrapper, Ethernet DMA is used to transmit and
>> +  receive packets between Ethernet subsytem and host. The Switch core has
>> +  maximum 8 ports(maximum 6 front panel ports and two FIFO interfaces),
>> +  among which there are GMAC/XGMACs used as external interfaces and FIFO
>> +  interfaces connected the EDMA/EIP, The port wrapper provides connections
>> +  from the GMAC/XGMACS to SGMII/QSGMII/PSGMII/USXGMII/10G-BASER etc, there
>> +  are maximu 3 UNIPHY(PCS) instances supported by PPE.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq5332-ppe
>> +      - qcom,ipq9574-ppe
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  ranges: true
>> +
>> +  clocks: true
> 
> These cannot be true, we expect here widest constraints.

Got it, will update to add the right constraints for the properties.

> 
>> +
>> +  clock-names: true
>> +
>> +  resets: true
>> +
>> +  reset-names: true
>> +
>> +  tdm-config:
>> +    type: object
>> +    additionalProperties: false
>> +    description: |
>> +      PPE TDM(time-division multiplexing) config includes buffer management
>> +      and port scheduler.
>> +
>> +    properties:
>> +      qcom,tdm-bm-config:
>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        description:
>> +          The TDM buffer scheduler configs of PPE, there are multiple
>> +          entries supported, each entry includes valid, direction
>> +          (ingress or egress), port, second port valid, second port.
>> +
>> +      qcom,tdm-port-scheduler-config:
>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        description:
>> +          The TDM port scheduler management configs of PPE, there
>> +          are multiple entries supported each entry includes ingress
>> +          scheduler port bitmap, ingress scheduler port, egress
>> +          scheduler port, second egress scheduler port valid and
>> +          second egress scheduler port.
>> +
>> +    required:
>> +      - qcom,tdm-bm-config
>> +      - qcom,tdm-port-scheduler-config
>> +
>> +  buffer-management-config:
>> +    type: object
>> +    additionalProperties: false
>> +    description: |
>> +      PPE buffer management config, which supports configuring group
>> +      buffer and per port buffer, which decides the threshold of the
>> +      flow control frame generated.
>> +
> 
> I don't understand this sentence. Rephrase it to proper sentence and
> proper hardware, not driver, description.

Ok, I  will edit the description to make it more clear. This information 
determines the number of hardware buffers configured per port in the 
PPE. This configuration influences flow control behavior of the port.

> 
>> +    properties:
>> +      qcom,group-config:
>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        description:
>> +          The PPE buffer support 4 groups, the entry includes
>> +          the group ID and group buffer numbers, each buffer
>> +          has 256 bytes.
> 
> Missing constraints, like min/max and number of items.

Ok, will add these constraints.

> 
>> +
>> +      qcom,port-config:
>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        description:
>> +          The PPE buffer number is also assigned per BM port ID,
>> +          there are 10 BM ports supported on ipq5332, and 15 BM
>> +          ports supported on ipq9574. Each entry includs group
>> +          ID, BM port ID, dedicated buffer, the buffer numbers
>> +          for receiving packet after pause frame sent, the
>> +          threshold for pause frame, weight, restore ceil and
>> +          dynamic buffer or static buffer management.
>> +
>> +    required:
>> +      - qcom,group-config
>> +      - qcom,port-config
>> +
>> +  queue-management-config:
>> +    type: object
>> +    additionalProperties: false
>> +    description: |
>> +      PPE queue management config, which supports configuring group
>> +      and per queue buffer limitation, which decides the threshold
>> +      to drop the packet on the egress port.
>> +
>> +    properties:
>> +      qcom,group-config:
>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        description:
>> +          The PPE queue management support 4 groups, the entry
>> +          includes the group ID, group buffer number, dedicated
>> +          buffer number, threshold to drop packet and restore
>> +          ceil.
>> +
>> +      qcom,queue-config:
>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        description:
>> +          PPE has 256 unicast queues and 44 multicast queues, the
>> +          entry includes queue base, queue number, group ID,
>> +          dedicated buffer, the threshold to drop packet, weight,
>> +          restore ceil and dynamic or static queue management.
>> +
>> +    required:
>> +      - qcom,group-config
>> +      - qcom,queue-config
>> +
>> +  port-scheduler-resource:
>> +    type: object
>> +    additionalProperties: false
>> +    description: The scheduler resource available in PPE.
>> +    patternProperties:
>> +      "^port[0-7]$":
> 
> port-

Ok. will do.

> 
>> +        description: Each subnode represents the scheduler resource per port.
>> +        type: object
>> +        properties:
>> +          port-id:
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            description: |
> 
> Do not need '|' unless you need to preserve formatting. This applies
> everywhere.

Got it, will remove it everywhere applicable.

> 
>> +              The PPE port ID, there are maximum 6 physical port,
>> +              EIP port and CPU port.
> 
> Your node  name suffix says 8 ports. Anyway, missing min/max.

will add the constraints.

> 
> All these nodes (before, here and further) looks like dump of vendor code.
> 
> I expect some good explanation why we should accept this. Commit msg you
> wrote is meaningless. It literally brings zero information about hardware.
> 
> You have been asked to provide accurate hardware description yet you
> keep ignoring people's feedback.

We are reviewing the current DTS to include only relevant information 
which varies per board, and move rest of the configuration to driver. We 
will update the commit message and the descriptions in dtbindings about 
the details of the hardware information for the updated DTS/dtbindings
when this patch series resumes.


> ...
> 
>> +
>> +patternProperties:
> 
> 
> phy@
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Got it, thanks. Will refer the link and update accordingly.

> 
> 
>> +  "^qcom-uniphy@[0-9a-f]+$":
>> +    type: object
>> +    additionalProperties: false
>> +    description: uniphy configuration and clock provider
>> +    properties:
>> +      reg:
>> +        minItems: 2
>> +        items:
>> +          - description: The first uniphy register range
>> +          - description: The second uniphy register range
>> +          - description: The third uniphy register range
> 
> first, second and third are really useless descriptions. We expect
> something useful.
> 

I will rephrase the descriptions here to clarify. Depending on the SoC 
type (IPQ5332 or IPQ9574) there can be two or three UNIPHY(PCS) in the 
PPE. This property defines the address ranges for the register space of 
these UNIPHY(PCS) of PPE.


>> +
>> +      "#clock-cells":
>> +        const: 1
>> +
>> +      clock-output-names:
>> +        minItems: 4
>> +        maxItems: 6
>> +
>> +    required:
>> +      - reg
>> +      - "#clock-cells"
>> +      - clock-output-names
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,ipq5332-ppe
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: Display common AHB clock from gcc
>> +            - description: Display common system clock from gcc
>> +            - description: Display uniphy0 AHB clock from gcc
>> +            - description: Display uniphy1 AHB clock from gcc
>> +            - description: Display uniphy0 system clock from gcc
>> +            - description: Display uniphy1 system clock from gcc
>> +            - description: Display nss clock from gcc
>> +            - description: Display nss noc snoc clock from gcc
>> +            - description: Display nss noc snoc_1 clock from gcc
>> +            - description: Display sleep clock from gcc
>> +            - description: Display PPE clock from nsscc
>> +            - description: Display PPE config clock from nsscc
>> +            - description: Display NSSNOC PPE clock from nsscc
>> +            - description: Display NSSNOC PPE config clock from nsscc
>> +            - description: Display EDMA clock from nsscc
>> +            - description: Display EDMA config clock from nsscc
>> +            - description: Display PPE IPE clock from nsscc
>> +            - description: Display PPE BTQ clock from nsscc
>> +            - description: Display port1 MAC clock from nsscc
>> +            - description: Display port2 MAC clock from nsscc
>> +            - description: Display port1 RX clock from nsscc
>> +            - description: Display port1 TX clock from nsscc
>> +            - description: Display port2 RX clock from nsscc
>> +            - description: Display port2 TX clock from nsscc
>> +            - description: Display UNIPHY port1 RX clock from nsscc
>> +            - description: Display UNIPHY port1 TX clock from nsscc
>> +            - description: Display UNIPHY port2 RX clock from nsscc
>> +            - description: Display UNIPHY port2 TX clock from nsscc
>> +        clock-names:
>> +          items:
>> +            - const: cmn_ahb
>> +            - const: cmn_sys
>> +            - const: uniphy0_ahb
>> +            - const: uniphy1_ahb
>> +            - const: uniphy0_sys
>> +            - const: uniphy1_sys
>> +            - const: gcc_nsscc
>> +            - const: gcc_nssnoc_snoc
>> +            - const: gcc_nssnoc_snoc_1
>> +            - const: gcc_im_sleep
>> +            - const: nss_ppe
>> +            - const: nss_ppe_cfg
>> +            - const: nssnoc_ppe
>> +            - const: nssnoc_ppe_cfg
>> +            - const: nss_edma
>> +            - const: nss_edma_cfg
>> +            - const: nss_ppe_ipe
>> +            - const: nss_ppe_btq
>> +            - const: port1_mac
>> +            - const: port2_mac
>> +            - const: nss_port1_rx
>> +            - const: nss_port1_tx
>> +            - const: nss_port2_rx
>> +            - const: nss_port2_tx
>> +            - const: uniphy_port1_rx
>> +            - const: uniphy_port1_tx
>> +            - const: uniphy_port2_rx
>> +            - const: uniphy_port2_tx
>> +
>> +        resets:
>> +          items:
>> +            - description: Reset PPE
>> +            - description: Reset uniphy0 software config
>> +            - description: Reset uniphy1 software config
>> +            - description: Reset uniphy0 AHB
>> +            - description: Reset uniphy1 AHB
>> +            - description: Reset uniphy0 system
>> +            - description: Reset uniphy1 system
>> +            - description: Reset uniphy0 XPCS
>> +            - description: Reset uniphy1 SPCS
>> +            - description: Reset uniphy port1 RX
>> +            - description: Reset uniphy port1 TX
>> +            - description: Reset uniphy port2 RX
>> +            - description: Reset uniphy port2 TX
>> +            - description: Reset PPE port1 RX
>> +            - description: Reset PPE port1 TX
>> +            - description: Reset PPE port2 RX
>> +            - description: Reset PPE port2 TX
>> +            - description: Reset PPE port1 MAC
>> +            - description: Reset PPE port2 MAC
>> +
>> +        reset-names:
>> +          items:
>> +            - const: ppe
>> +            - const: uniphy0_soft
>> +            - const: uniphy1_soft
>> +            - const: uniphy0_ahb
>> +            - const: uniphy1_ahb
>> +            - const: uniphy0_sys
>> +            - const: uniphy1_sys
>> +            - const: uniphy0_xpcs
>> +            - const: uniphy1_xpcs
>> +            - const: uniphy_port1_rx
>> +            - const: uniphy_port1_tx
>> +            - const: uniphy_port2_rx
>> +            - const: uniphy_port2_tx
>> +            - const: nss_port1_rx
>> +            - const: nss_port1_tx
>> +            - const: nss_port2_rx
>> +            - const: nss_port2_tx
>> +            - const: nss_port1_mac
>> +            - const: nss_port2_mac
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,ipq9574-ppe
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: Display common AHB clock from gcc
>> +            - description: Display common system clock from gcc
>> +            - description: Display uniphy0 AHB clock from gcc
>> +            - description: Display uniphy1 AHB clock from gcc
>> +            - description: Display uniphy2 AHB clock from gcc
>> +            - description: Display uniphy0 system clock from gcc
>> +            - description: Display uniphy1 system clock from gcc
>> +            - description: Display uniphy2 system clock from gcc
>> +            - description: Display nss clock from gcc
>> +            - description: Display nss noc clock from gcc
>> +            - description: Display nss noc snoc clock from gcc
>> +            - description: Display nss noc snoc_1 clock from gcc
>> +            - description: Display PPE clock from nsscc
>> +            - description: Display PPE config clock from nsscc
>> +            - description: Display NSSNOC PPE clock from nsscc
>> +            - description: Display NSSNOC PPE config clock from nsscc
>> +            - description: Display EDMA clock from nsscc
>> +            - description: Display EDMA config clock from nsscc
>> +            - description: Display PPE IPE clock from nsscc
>> +            - description: Display PPE BTQ clock from nsscc
>> +            - description: Display port1 MAC clock from nsscc
>> +            - description: Display port2 MAC clock from nsscc
>> +            - description: Display port3 MAC clock from nsscc
>> +            - description: Display port4 MAC clock from nsscc
>> +            - description: Display port5 MAC clock from nsscc
>> +            - description: Display port6 MAC clock from nsscc
>> +            - description: Display port1 RX clock from nsscc
>> +            - description: Display port1 TX clock from nsscc
>> +            - description: Display port2 RX clock from nsscc
>> +            - description: Display port2 TX clock from nsscc
>> +            - description: Display port3 RX clock from nsscc
>> +            - description: Display port3 TX clock from nsscc
>> +            - description: Display port4 RX clock from nsscc
>> +            - description: Display port4 TX clock from nsscc
>> +            - description: Display port5 RX clock from nsscc
>> +            - description: Display port5 TX clock from nsscc
>> +            - description: Display port6 RX clock from nsscc
>> +            - description: Display port6 TX clock from nsscc
>> +            - description: Display UNIPHY port1 RX clock from nsscc
>> +            - description: Display UNIPHY port1 TX clock from nsscc
>> +            - description: Display UNIPHY port2 RX clock from nsscc
>> +            - description: Display UNIPHY port2 TX clock from nsscc
>> +            - description: Display UNIPHY port3 RX clock from nsscc
>> +            - description: Display UNIPHY port3 TX clock from nsscc
>> +            - description: Display UNIPHY port4 RX clock from nsscc
>> +            - description: Display UNIPHY port4 TX clock from nsscc
>> +            - description: Display UNIPHY port5 RX clock from nsscc
>> +            - description: Display UNIPHY port5 TX clock from nsscc
>> +            - description: Display UNIPHY port6 RX clock from nsscc
>> +            - description: Display UNIPHY port6 TX clock from nsscc
>> +            - description: Display port5 RX clock source from nsscc
>> +            - description: Display port5 TX clock source from nsscc
>> +        clock-names:
>> +          items:
>> +            - const: cmn_ahb
>> +            - const: cmn_sys
>> +            - const: uniphy0_ahb
>> +            - const: uniphy1_ahb
>> +            - const: uniphy2_ahb
>> +            - const: uniphy0_sys
>> +            - const: uniphy1_sys
>> +            - const: uniphy2_sys
>> +            - const: gcc_nsscc
>> +            - const: gcc_nssnoc_nsscc
>> +            - const: gcc_nssnoc_snoc
>> +            - const: gcc_nssnoc_snoc_1
>> +            - const: nss_ppe
>> +            - const: nss_ppe_cfg
>> +            - const: nssnoc_ppe
>> +            - const: nssnoc_ppe_cfg
>> +            - const: nss_edma
>> +            - const: nss_edma_cfg
>> +            - const: nss_ppe_ipe
>> +            - const: nss_ppe_btq
>> +            - const: port1_mac
>> +            - const: port2_mac
>> +            - const: port3_mac
>> +            - const: port4_mac
>> +            - const: port5_mac
>> +            - const: port6_mac
>> +            - const: nss_port1_rx
>> +            - const: nss_port1_tx
>> +            - const: nss_port2_rx
>> +            - const: nss_port2_tx
>> +            - const: nss_port3_rx
>> +            - const: nss_port3_tx
>> +            - const: nss_port4_rx
>> +            - const: nss_port4_tx
>> +            - const: nss_port5_rx
>> +            - const: nss_port5_tx
>> +            - const: nss_port6_rx
>> +            - const: nss_port6_tx
>> +            - const: uniphy_port1_rx
>> +            - const: uniphy_port1_tx
>> +            - const: uniphy_port2_rx
>> +            - const: uniphy_port2_tx
>> +            - const: uniphy_port3_rx
>> +            - const: uniphy_port3_tx
>> +            - const: uniphy_port4_rx
>> +            - const: uniphy_port4_tx
>> +            - const: uniphy_port5_rx
>> +            - const: uniphy_port5_tx
>> +            - const: uniphy_port6_rx
>> +            - const: uniphy_port6_tx
>> +            - const: nss_port5_rx_clk_src
>> +            - const: nss_port5_tx_clk_src
>> +
>> +        resets:
>> +          items:
>> +            - description: Reset PPE
>> +            - description: Reset uniphy0 software config
>> +            - description: Reset uniphy1 software config
>> +            - description: Reset uniphy2 software config
>> +            - description: Reset uniphy0 AHB
>> +            - description: Reset uniphy1 AHB
>> +            - description: Reset uniphy2 AHB
>> +            - description: Reset uniphy0 system
>> +            - description: Reset uniphy1 system
>> +            - description: Reset uniphy2 system
>> +            - description: Reset uniphy0 XPCS
>> +            - description: Reset uniphy1 XPCS
>> +            - description: Reset uniphy2 XPCS
>> +            - description: Assert uniphy port1
>> +            - description: Assert uniphy port2
>> +            - description: Assert uniphy port3
>> +            - description: Assert uniphy port4
>> +            - description: Reset PPE port1
>> +            - description: Reset PPE port2
>> +            - description: Reset PPE port3
>> +            - description: Reset PPE port4
>> +            - description: Reset PPE port5
>> +            - description: Reset PPE port6
>> +            - description: Reset PPE port1 MAC
>> +            - description: Reset PPE port2 MAC
>> +            - description: Reset PPE port3 MAC
>> +            - description: Reset PPE port4 MAC
>> +            - description: Reset PPE port5 MAC
>> +            - description: Reset PPE port6 MAC
>> +
>> +        reset-names:
>> +          items:
>> +            - const: ppe
>> +            - const: uniphy0_soft
>> +            - const: uniphy1_soft
>> +            - const: uniphy2_soft
>> +            - const: uniphy0_ahb
>> +            - const: uniphy1_ahb
>> +            - const: uniphy2_ahb
>> +            - const: uniphy0_sys
>> +            - const: uniphy1_sys
>> +            - const: uniphy2_sys
>> +            - const: uniphy0_xpcs
>> +            - const: uniphy1_xpcs
>> +            - const: uniphy2_xpcs
>> +            - const: uniphy0_port1_dis
>> +            - const: uniphy0_port2_dis
>> +            - const: uniphy0_port3_dis
>> +            - const: uniphy0_port4_dis
>> +            - const: nss_port1
>> +            - const: nss_port2
>> +            - const: nss_port3
>> +            - const: nss_port4
>> +            - const: nss_port5
>> +            - const: nss_port6
>> +            - const: nss_port1_mac
>> +            - const: nss_port2_mac
>> +            - const: nss_port3_mac
>> +            - const: nss_port4_mac
>> +            - const: nss_port5_mac
>> +            - const: nss_port6_mac
>> +
>> +required:
> 
> allOf: goes after required:

Ok.

> 
>> +  - compatible
>> +  - reg
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - ranges
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - tdm-config
>> +  - buffer-management-config
>> +  - queue-management-config
>> +  - port-scheduler-resource
>> +  - port-scheduler-config
>> +
>> +additionalProperties: false
> 
> 
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>> +    #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>> +    #include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
>> +    #include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
>> +
>> +    soc {
>> +      #address-cells = <1>;
>> +      #size-cells = <1>;
>> +      qcom_ppe: qcom-ppe@3a000000 {
> 
> Drop label, Generic node names.

Ok. We are trying to identify an appropriate generic name for the PPE 
from the device tree documentation, since it comprises of many hardware 
functions such as ethernet MAC and other packet processing blocks. We 
are planning to update the node name to a generic name 'ethernet'.

> 
>> +              compatible = "qcom,ipq9574-ppe";
> 
> Entire indentation of example is broken. Use one described in the
> bindings coding style.

will correct it, thanks for pointing out.

> 
> Best regards,
> Krzysztof
> 

