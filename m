Return-Path: <linux-kernel+bounces-77975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255BE860D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 748A3B21FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F391B7E7;
	Fri, 23 Feb 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TmSlXdOb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E91A28C;
	Fri, 23 Feb 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679422; cv=none; b=coJxoJeOLpT9oQMTxaKWo1rM6G6UL8V/v81dqyl6m8hqwQo0jO9wJJlvareWJ9INQdrkkK73WxxEcW/RDBQykSacb1kS88ylVpMyzv/Ij8ybl3K6hTBikjmFR1/H19iV3QKyKarz19fWcQpHMADfVVVWih4kwfvVjGjW0M0G+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679422; c=relaxed/simple;
	bh=ssEc8t0+IhBHuXNtmcwc8pXJbrvtaRWRW4PKV7YG/cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DstzdfEZMMZvXcVjsmCxOPIBOXhxVNiZJZo4hxjsw37jGHRZ+5uGSkVz07El4DMAEll8/hP3R1NpB68zKfJZaQgKKDzMPvwmUFQVklgus4nQqDCsKcD6lmqnXwU9IqHzTz2pqsgb0XUxSyiN5mR4Pvw8fLsnruUp8HQHmuj6llU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TmSlXdOb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N8WOgx018006;
	Fri, 23 Feb 2024 09:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bMxRd0nWqQgBl7Wv52j71fg2VVlNTmpwHHkRom113Zk=; b=Tm
	SlXdObH2U4CtShX82MfWTp6QpqK06ppK3Btwc624XA1EBVD4lcEamrdo0ZVjlzSx
	Lthz2BFRaan7glbJR2jzNtfDmpl6dL4Ztb+p3NlISggSy1rPpEPOpn+p22f2XtqP
	7mvc3NnTF+SzWgUEecGvKTltXPRoibeNbK2rc3BWj6FTXRph5YOsvKyRU7Bv6ic3
	0yRIica94prDZ9Jc093hAeDAjVy8o4hWJkE0ozhhUPn+nc0hbQNlKnd4NM0vd8xm
	7A2PV3qkJsGColRXuuM0R2ZG1qca9YZTtEyB8MGBmY03GQjrEwt+Q3h9Gd+GVipg
	NQcm4iaV6EQpOYKh6VBQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weqxd0279-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 09:10:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41N9AD1E014666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 09:10:13 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 01:10:06 -0800
Message-ID: <b09c737d-9ee4-4b6e-a895-684d82559691@quicinc.com>
Date: Fri, 23 Feb 2024 17:10:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] arm64: dts: qcom: sm8650p: introduce sm8650p dtsi
Content-Language: en-US
To: <neil.armstrong@linaro.org>, Jingyi Wang <quic_jingyw@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@quicinc.com>
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-5-quic_jingyw@quicinc.com>
 <665f37e9-eda4-4d82-8d94-a1238514dbff@linaro.org>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <665f37e9-eda4-4d82-8d94-a1238514dbff@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6R4IJn79AYHkcnYpXqUoCiw6ljgCywqk
X-Proofpoint-ORIG-GUID: 6R4IJn79AYHkcnYpXqUoCiw6ljgCywqk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230063



On 2/22/2024 9:21 PM, neil.armstrong@linaro.org wrote:
> On 05/02/2024 12:57, Jingyi Wang wrote:
>> Introduce sm8650p dtsi, sm8650p has same base functions
>> as sm8650 with different memory regions.
>>
>> There are 3 types of reserved memory regions here:
>> 1. Firmware related regions.
>>      This will be described as: reserved-region@address. Current
>> reserved-region may have reserved area which was not yet used, release
>> note of the firmware can have such kind of information.
>> 2. Firmware related which shared with kernel access.
>>      Each region will have a specific node with specific label name for
>> later phandle reference from other driver dt node. May overlapping with
>> above type regions.
>> 3. PIL regions.
>>      PIL regions are allocated by kernel and assigned to subsystem
>> firmware later.
>> Here is a map for this platform:
>> 0x100000000 +------------------+
>>              |                  |
>>              | Firmware Related |
>>              |                  |
>>   0xd8000000 +------------------+
>>              |                  |
>>              | Kernel Available |
>>              |                  |
>>   0xA7000000 +------------------+
>>              |                  |
>>              |    PIL Region    |
>>              |                  |
>>   0x8BC00000 +------------------+
>>              |                  |
>>              | Firmware Related |
>>              |                  |
>>   0x80000000 +------------------+
>> Note that:
>> 1. 0xA7000000 to 0xA8000000 was used by bootloader as well, not suggest
>> for other usage.
>> 2. Kernel start address was start at 0xA8000000.
>>
>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8650p.dtsi | 180 ++++++++++++++++++++++++++
>>   1 file changed, 180 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sm8650p.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650p.dtsi 
>> b/arch/arm64/boot/dts/qcom/sm8650p.dtsi
>> new file mode 100644
>> index 000000000000..26dfe315b49d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm8650p.dtsi
>> @@ -0,0 +1,180 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include "sm8650.dtsi"
>> +
>> +/delete-node/ &reserved_memory;
>> +
>> +/ {
>> +    reserved_memory: reserved-memory {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges;
>> +
>> +        /*
>> +         * There are 3 types of reserved memory regions here:
>> +         * 1. Firmware related regions.
>> +         *     This will be described as: reserved-region@address. 
>> Current
>> +         * reserved-region may have reserved area which was not yet 
>> used,
>> +         * release note of the firmware can have such kind of 
>> information.
>> +         * 2. Firmware related which shared with kernel access.
>> +         *     Each region will have a specific node with specific label
>> +         * name for later phandle reference from other driver dt 
>> node. May
>> +         * overlapping with above type regions.
>> +         * 3. PIL regions.
>> +         *     PIL regions are allocated by kernel and assigned to 
>> subsystem
>> +         * firmware later.
>> +         * Here is a map for this platform:
>> +         * 0x100000000 +------------------+
>> +         *             |                  |
>> +         *             | Firmware Related |
>> +         *             |                  |
>> +         *  0xd8000000 +------------------+
>> +         *             |                  |
>> +         *             | Kernel Available |
>> +         *             |                  |
>> +         *  0xA7000000 +------------------+
>> +         *             |                  |
>> +         *             |    PIL Region    |
>> +         *             |                  |
>> +         *  0x8BC00000 +------------------+
>> +         *             |                  |
>> +         *             | Firmware Related |
>> +         *             |                  |
>> +         *  0x80000000 +------------------+
>> +         * Note that:
>> +         * 1. 0xA7000000 to 0xA8000000 was used by bootloader as 
>> well, not
>> +         * suggest for other usage.
>> +         * 2. Kernel start address was start at 0xA8000000.
>> +         */
>> +
>> +        /* Firmware related regions */
>> +        reserved-region@80000000 {
>> +            reg = <0x0 0x80000000 0x0 0xbc00000>;
>> +            no-map;
>> +        };
> 
> Ok this region goes up to 0x8BC00000 and so overlaps with the next regions:
The idea here is to reserve more needed ddr regions for different 
version of firmware compatibility. While inside this region which shared 
device memory from firmware to kernel, it is still needed to have node 
information in the device tree.

More clear reference here for the firmware needed no-map reserved region 
diagram, take the smem_mem here to be exposed shared read to kernel:
*  0x8BC00000 +------------------+
*             |                  |
*             | reserved_region2 |
*  0x81c60000 +------------------+
*             |    smem_mem      |
*  0x81c00000 +------------------+
*             |  reserved_region1|
*  0x80000000 +------------------+

what's the suggestion here for this requirement?:
option 1: have a big region_reserved, and then have smem_mem overlap 
reserved region node information inside the dt.
option 2: Have each separate "reserved_region1 node + smem_mem node + 
reserved_region2 node".
other options?

> 
>> +
>> +        aop_image_mem: aop-image-region@81c00000 {
>> +            reg = <0x0 0x81c00000 0x0 0x60000>;
>> +            no-map;
>> +        };
>> +
>> +        aop_cmd_db_mem: aop-cmd-db-region@81c60000 {
>> +            compatible = "qcom,cmd-db";
>> +            reg = <0x0 0x81c60000 0x0 0x20000>;
>> +            no-map;
>> +        };
>> +
>> +        aop_config_mem: aop-config-region@81c80000 {
>> +            no-map;
>> +            reg = <0x0 0x81c80000 0x0 0x20000>;
>> +        };
>> +
>> +        smem_mem: smem-region@81d00000 {
>> +            compatible = "qcom,smem";
>> +            reg = <0x0 0x81d00000 0x0 0x200000>;
>> +            hwlocks = <&tcsr_mutex 3>;
>> +            no-map;
>> +        };
>> +
>> +        adsp_mhi_mem: adsp-mhi-region@81f00000 {
>> +            reg = <0x0 0x81f00000 0x0 0x20000>;
>> +            no-map;
>> +        };
>> +
>> +        global_sync_mem: global-sync@82600000 {
>> +            reg = <0 0x82600000 0 0x100000>;
>> +            no-map;
>> +        };
>> +
>> +        mpss_dsm_mem: mpss-dsm@86b00000 {
>> +            reg = <0 0x86b00000 0 0x4900000>;
>> +            no-map;
>> +        };
>> +
>> +        mpss_dsm_mem_2: mpss-dsm-2@8b400000 {
>> +            reg = <0 0x8b400000 0 0x800000>;
>> +            no-map;
>> +        };
> 
> up to here
> 
> Please fix this,
> 
> I just checked against plain sm8650.dtsi and actually the memory 
> adresses are the same.
> 
> So what's the _real_ difference here ? Just drop the superfluous memory 
> zones and redefine them if needed.
With big reserved regions agreed, I think the memory map can be modified 
directly in sm8650.dtsi. It will be a memory map support different 
derived soc firmware release as well.
> 
> Thanks,
> Neil
> 
>> +
>> +        /* PIL region */
>> +        mpss_mem: mpss-region@8bc00000 {
>> +            reg = <0x0 0x8bc00000 0x0 0xf400000>;
>> +            no-map;
>> +        };
>> +
>> +        q6_mpss_dtb_mem: q6-mpss-dtb-region@9b000000 {
>> +            reg = <0x0 0x9b000000 0x0 0x80000>;
>> +            no-map;
>> +        };
>> +
>> +        ipa_fw_mem: ipa-fw-region@9b080000 {
>> +            reg = <0x0 0x9b080000 0x0 0x10000>;
>> +            no-map;
>> +        };
>> +
>> +        ipa_gsi_mem: ipa-gsi-region@9b090000 {
>> +            reg = <0x0 0x9b090000 0x0 0xa000>;
>> +            no-map;
>> +        };
>> +
>> +        gpu_micro_code_mem: gpu-micro-code-region@9b09a000 {
>> +            reg = <0x0 0x9b09a000 0x0 0x2000>;
>> +            no-map;
>> +        };
>> +
>> +        spss_region_mem: spss-region@9b0a0000 {
>> +            reg = <0x0 0x9b0a0000 0x0 0x1e0000>;
>> +            no-map;
>> +        };
>> +
>> +        spu_secure_shared_memory_mem: 
>> spu-secure-shared-memory-region@9b280000 {
>> +            reg = <0x0 0x9b280000 0x0 0x80000>;
>> +            no-map;
>> +        };
>> +
>> +        camera_mem: camera-region@9b300000 {
>> +            reg = <0x0 0x9b300000 0x0 0x800000>;
>> +            no-map;
>> +        };
>> +
>> +        video_mem: video-region@9bb00000 {
>> +            reg = <0x0 0x9bb00000 0x0 0x800000>;
>> +            no-map;
>> +        };
>> +
>> +        cvp_mem: cvp-region@9c300000 {
>> +            reg = <0x0 0x9c300000 0x0 0x700000>;
>> +            no-map;
>> +        };
>> +
>> +        cdsp_mem: cdsp-region@9ca00000 {
>> +            reg = <0x0 0x9ca00000 0x0 0x1400000>;
>> +            no-map;
>> +        };
>> +
>> +        q6_cdsp_dtb_mem: q6-cdsp-dtb-region@9de00000 {
>> +            reg = <0x0 0x9de00000 0x0 0x80000>;
>> +            no-map;
>> +        };
>> +
>> +        q6_adsp_dtb_mem: q6-adsp-dtb-region@9de80000 {
>> +            reg = <0x0 0x9de80000 0x0 0x80000>;
>> +            no-map;
>> +        };
>> +
>> +        adspslpi_mem: adspslpi-region@9df00000 {
>> +            reg = <0x0 0x9df00000 0x0 0x4080000>;
>> +            no-map;
>> +        };
>> +
>> +        /* Firmware related regions */
>> +        reserved-region@d8000000 {
>> +            reg = <0x0 0xd8000000 0x0 0x28000000>;
>> +            no-map;
>> +        };
>> +
>> +    };
>> +};
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

