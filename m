Return-Path: <linux-kernel+bounces-148436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D88A8288
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4B81C2192D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDC013D52E;
	Wed, 17 Apr 2024 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a7hTmswP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5313CFA9;
	Wed, 17 Apr 2024 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354748; cv=none; b=onPQaDyMa2SFXqXJ4DDIbMq61ksZbZah5m908qfcCUQXsrS+ddC3aW1fZ6SDemYxvmHVMcK1jSn15vXlnf6tCFMghUUAyp84Gy4pqZpqy66Epe/EoF14TWMyr9Cx7nGmJYzfssZ16wK3AZfAGi31WAAiGWxWpB2Z+VLO9X8GdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354748; c=relaxed/simple;
	bh=WJYLTSMncG30C1Qdma9riPDzQCo3qV5L+dsiSeYEsro=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MUdYaY6Wlgl2GbVVzrVp+bf+JvPMOBdEHbvxekPKMSq9FFLuPLRRvrAujJ+MV7gZfDSyWSXJosxFicJfkqZV6OSojtC54fTdLX/Z4LuySqVTFBCAVwUqhRbD0EmSI/Dfhx8LaeNx2gNKbV74mqr7+bJKvQdtLajDq275m1asCwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a7hTmswP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H8Md5S019698;
	Wed, 17 Apr 2024 11:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JQGJEXRoiCs58vN7/w53lPUG2CI/bXZ1y3a6g0kfLzU=; b=a7
	hTmswPMhDE+63l4U0BippBLYRUnt0YYj/+6nWkqMkNB207n7wLeCcwnxgM9spcZT
	YDmUN6PdF/WjBHuPlS13JjQ7lZeSvAvAL2j/Pqd3zoc1OIPeHSKkqUjSZQSipNRF
	g7vR6WpJW5+pTuwikQj3Xf6IreG7jb6p6J3bbfet5r9smrUl4h44qXWXIe9/Au9o
	yv44JBMOdruuWCuUJ9EqWppPqn7Gqdeu4LZ7/e6pdjrHMsvmkB2aXeCKelD/FaV+
	k43AkbjIrpDzI5JzSKITJZf0Tvpb1DwRedmg0jwQseRynOTjvxLzS9b6DXYbJDaG
	qZaVAAvx28fkGjHrapIQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjauprepv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 11:52:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HBqI5B020734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 11:52:18 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 04:52:13 -0700
Message-ID: <999116f9-47f8-b307-1251-06c26b7c3138@quicinc.com>
Date: Wed, 17 Apr 2024 17:22:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] arm64: dts: qcom: x1e80100: Add cpucp mailbox and
 sram nodes
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>,
        <quic_gkohli@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_psodagud@quicinc.com>
References: <20240328095044.2926125-1-quic_sibis@quicinc.com>
 <20240328095044.2926125-5-quic_sibis@quicinc.com>
 <CAA8EJprccauto=oMFbXcNg6Yg9P+Ph7C1EMPaQ5sXarf-3Kxkw@mail.gmail.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <CAA8EJprccauto=oMFbXcNg6Yg9P+Ph7C1EMPaQ5sXarf-3Kxkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cpXZguHz7I2cyrOgG5UxgncI2sTRgxON
X-Proofpoint-ORIG-GUID: cpXZguHz7I2cyrOgG5UxgncI2sTRgxON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_09,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=970 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170082



On 4/16/24 22:00, Dmitry Baryshkov wrote:
> On Thu, 28 Mar 2024 at 11:52, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>>
>> Add the cpucp mailbox and sram nodes required by SCMI perf protocol
>> on X1E80100 SoCs.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index 28f65296781d..4e0ec859ed61 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -4974,6 +4974,13 @@ gic_its: msi-controller@17040000 {
>>                          };
>>                  };
>>
>> +               cpucp_mbox: mailbox@17430000 {
>> +                       compatible = "qcom,x1e80100-cpucp-mbox";
>> +                       reg = <0 0x17430000 0 0x10000>, <0 0x18830000 0 0x10000>;
>> +                       interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>> +                       #mbox-cells = <1>;
>> +               };
>> +
>>                  apps_rsc: rsc@17500000 {
>>                          compatible = "qcom,rpmh-rsc";
>>                          reg = <0 0x17500000 0 0x10000>,
>> @@ -5157,6 +5164,25 @@ frame@1780d000 {
>>                          };
>>                  };
>>
>> +               sram: sram@18b4e000 {
>> +                       compatible = "mmio-sram";
>> +                       reg = <0x0 0x18b4e000 0x0 0x400>;
>> +                       ranges = <0x0 0x0 0x18b4e000 0x400>;
>> +
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +
>> +                       cpu_scp_lpri0: scmi-shmem@0 {
> 
> This doesn't seem to follow the schema.

ack, will rename the nodes in the next re-spin.

-Sibi

> 
>> +                               compatible = "arm,scmi-shmem";
>> +                               reg = <0x0 0x200>;
>> +                       };
>> +
>> +                       cpu_scp_lpri1: scmi-shmem@200 {
>> +                               compatible = "arm,scmi-shmem";
>> +                               reg = <0x200 0x200>;
>> +                       };
>> +               };
>> +
>>                  system-cache-controller@25000000 {
>>                          compatible = "qcom,x1e80100-llcc";
>>                          reg = <0 0x25000000 0 0x200000>,
>> --
>> 2.34.1
>>
>>
> 
> 

