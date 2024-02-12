Return-Path: <linux-kernel+bounces-61320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351008510FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2121C218BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7869920DCF;
	Mon, 12 Feb 2024 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GdsGQ2eH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD9179B7;
	Mon, 12 Feb 2024 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734006; cv=none; b=gb3Y+Qg5OWB7MRWP/RUSx7fKtl3uFtBLBEuygFv9zdWhCaM8fbRi8Op3OQ08Jes7gA8WLEsKtQCYSf1D1sJ1fljxm1+fszygetKzX5OhKBrM/txREndhtHLPXxugpaiCECwttBgNHhli577LNrXKZ5QHXwXMglcbs7bFfzVUP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734006; c=relaxed/simple;
	bh=P/y0up7SGLgK5F7RzQvdVZehJ1i9DsWj//tCjIRH2Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pzplozczv+YUM0WwKtfJ/8p8DybIO5pO3VqH1iKrRQ38A9660zL07dXtLjxeP1d21petuW3Uq4IF5s3Ufmsh6jlDKGvoPX41UATLvTmjJ20t/bwqrMSvIWFr5Ua28W0PDbcb76/13QLIaU8JxCnGzP0xregNGtpSK53lRAO0XM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GdsGQ2eH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C9gItH019557;
	Mon, 12 Feb 2024 10:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+16d7oYWLNV2SUg7+HumgOXtzadS2OTfaBlJ0iT53ZE=; b=Gd
	sGQ2eH0vxnPpsaLDY3nLToAiqxvFUXa8o/xfyjFC6bkLNF0t/AA82Ef2e9sKlhgq
	l+bxErY74e/aYrw6Y6uzDBaHP029Jo5W4utUHPt8qjD4JoKOiFsvG2nNU1rqULDp
	hFHgEbJPlpKLcg/LMdlxarNGZC7899ArvVnjmMyoPfW6RH4ZthqhWUsBbrzBXqi+
	GmMeeFq8W9fv3MiReSA3aBhk3laQoDGhm+Ymran09mVkjuboc9/2YXbog5WHsMFm
	whaRJfwN8X/N5KrqNKRq4Gu+tsEfpCwlLCQRKrp6qfUqdCPsXk1I/x9opwsZQqch
	6CBbHbJDhy8NdrOeQE+g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62q2u0qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:33:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CAXGpf013422
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:33:16 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 02:33:11 -0800
Message-ID: <d24a3372-8ee5-528d-09ac-86c64f0896e5@quicinc.com>
Date: Mon, 12 Feb 2024 16:03:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 4/7] soc: qcom: Utilize qcom scmi vendor protocol for bus
 dvfs
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>,
        Amir Vajid
	<avajid@quicinc.com>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-5-quic_sibis@quicinc.com>
 <7e48e51e-e16a-41b9-800d-960c627b8da6@linaro.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <7e48e51e-e16a-41b9-800d-960c627b8da6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qRpvPqz-8WjAJ1iFa5cV35SJEcOyjWGA
X-Proofpoint-GUID: qRpvPqz-8WjAJ1iFa5cV35SJEcOyjWGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_07,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120079



On 1/18/24 01:58, Konrad Dybcio wrote:
> 
> 
> On 1/17/24 18:34, Sibi Sankar wrote:
>> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>
>> This patch introduces a client driver that interacts with the SCMI QCOM
>> vendor protocol and passes on the required tuneables to start various
>> features running on the SCMI controller.
>>
>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>> Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>> Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>> Co-developed-by: Amir Vajid <avajid@quicinc.com>
>> Signed-off-by: Amir Vajid <avajid@quicinc.com>
>> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
> 
> [...]
> 
> 
>> +
>> +struct cpufreq_memfreq_map {
>> +    unsigned int            cpufreq_mhz;
>> +    unsigned int            memfreq_khz;
>> +};
> 
> Weird use of tabs

will fix it in the next re-spin.

> 
> [...]
> 
>> +static int get_mask(struct device_node *np, u32 *mask)
>> +{
>> +    struct device_node *dev_phandle;
>> +    struct device *cpu_dev;
>> +    int cpu, i = 0;
>> +    int ret = -ENODEV;
> 
> Don't initialize ret here, return 0 instead of breaking and return
> enodev otherwise.

ack

> 
>> +
>> +    dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
>> +    while (dev_phandle) {
>> +        for_each_possible_cpu(cpu) {
>> +            cpu_dev = get_cpu_device(cpu);
>> +            if (cpu_dev && cpu_dev->of_node == dev_phandle) {
>> +                *mask |= BIT(cpu);
>> +                ret = 0;
>> +                break;
>> +            }
>> +        }
> 
> of_cpu_node_to_id()

ack

> 
>> +        dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
>> +    }
>> +
>> +    return ret;
>> +}
> 
> 
>> +
>> +static struct cpufreq_memfreq_map *init_cpufreq_memfreq_map(struct 
>> device *dev,
>> +                                struct device_node *of_node,
>> +                                u32 *cnt)
> 
> I really feel like this is trying to reinvent OPP..
> 
> if you structure your entries like so:
> 
> opp-0 {
>      opp-hz = /bits/ 64 <12341234 43214321>;
> };
> 
> you'll be able to use all the fantastic APIs that have been
> created over the years!

I didn't know listing multiple frequencies in a opp was allowed. We can
probably get away with it here since we just parse the data here and not
populate data in the opp core.

> 
> [...]
> 
>> +            monitor->mon_type = (of_property_read_bool(monitor_np, 
>> "qcom,compute-mon")) ? 1 : 0;
>> +            monitor->ipm_ceil = (of_property_read_bool(monitor_np, 
>> "qcom,compute-mon")) ? 0 : 20000000;
> 
> What does it even mean for a monitor to be a compute mon?
> 

When a monitor is marked compute-mon it means that the table is
followed religiously irrespective whether the instruction per miss
count threshold (ipm) is exceeded or not. Equivalent to having
a cpufreq map -> l3/DDR bw mapping upstream.

> There seem to be no dt-bindings for properties referenced in this
> driver, neither in the series nor in the dependencies. This is
> strictly required.

Ack

Thanks again for reviewing the series. :)

-Sibi

> 
> Konrad

