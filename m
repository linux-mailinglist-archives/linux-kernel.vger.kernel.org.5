Return-Path: <linux-kernel+bounces-132809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE587899A87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8326B2822A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C5161B46;
	Fri,  5 Apr 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c9mANT52"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6D4161908;
	Fri,  5 Apr 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312193; cv=none; b=Ol5sc0swujUSp3+tYosYgXKPs8TepyGVj+SFDd6jDa7oeTHvhbgkTW/O/9YKagBH7qDvZpCRUzrp/Pue7UZx4PrvoDcK1aCPPYYmPUFL3fzK9nRSzQ9SLP4Ffa5VaVv10apICgXsZEhlwx/wwLBwluCy+6obAGfd8ayNP1FC0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312193; c=relaxed/simple;
	bh=IicMOvK28H3EnncVC3yjaeAGnYaW03ovhlG7vCImlgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sWtS+h9uwTMnkB8EnOQftdDxGmsPVAC2ZsaaO0gz09E7F235Ca/mqXnHe9p0ItTWYg2R4F9FulYlx3Krkjz6Aid9CIAlYZmsNfgz/dhAYB+LaYiy0DY2T6BRLdQslfUC87VNHncLW8PB9hmzAb0J+BFnCe1zRNKxkt32Mb9H85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c9mANT52; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4359ptL8003900;
	Fri, 5 Apr 2024 10:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XoKf4c/Zf9/PmnCv6NFmNqJ8E0n9nXZfLg8KjCiDALE=; b=c9
	mANT52is76j10P9oMSmn42gYfx4YhJda+q/pYO6hgqCTPBj51WORBXrtD5MdA5NM
	Q/H0Y7U9Na+Yv3Q79HH/7AdCbt86CdnKOorI4n1wtx41Vu7ya18d0A2slSkkcj1Y
	Jqukms0EJ/GlpdNiFfMTsKW1MefGpQ3jKPx0WfqTXKA0ynUgrF/EKoqCFUbvApgo
	WsN9s8vZpKprst6W5mmDESGHM+/JxNStfunXptsMRrKXOO10M3SqcOdJLFKlWa0A
	+0p/vwl0+KbQhXzL6NIMn/SteXSZEy8BESML2FCWMKFw1iPXMyicSpduMIDdkw7L
	Oj1HW43bbcBwap74nIkQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa7m5gwun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:16:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435AGJaf010862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 10:16:19 GMT
Received: from [10.216.8.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 03:16:11 -0700
Message-ID: <190caeb1-3f47-d0b0-bf98-f1022b8f3a90@quicinc.com>
Date: Fri, 5 Apr 2024 15:46:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v8 3/7] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney
	<bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
 <20240302-opp_support-v8-3-158285b86b10@quicinc.com>
 <20240304174111.GB31079@thinkpad>
 <9d878f69-c9d1-1ee4-f80e-1d8f16c6920e@quicinc.com>
 <20240405082944.GE2953@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240405082944.GE2953@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V-jYCDRiPY5Fgq6Gpizpd63QNyzx8axk
X-Proofpoint-GUID: V-jYCDRiPY5Fgq6Gpizpd63QNyzx8axk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_09,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050076



On 4/5/2024 1:59 PM, Manivannan Sadhasivam wrote:
> On Tue, Mar 05, 2024 at 04:23:21PM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 3/4/2024 11:11 PM, Manivannan Sadhasivam wrote:
>>> On Sat, Mar 02, 2024 at 09:29:57AM +0530, Krishna chaitanya chundru wrote:
>>>> To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
>>>> ICC (interconnect consumers) path should be voted otherwise it may
>>>> lead to NoC (Network on chip) timeout. We are surviving because of
>>>> other driver vote for this path.
>>>>
>>>> As there is less access on this path compared to PCIe to mem path
>>>> add minimum vote i.e 1KBps bandwidth always.
>>>
>>> Please add the info that 1KBps is what shared by the HW team.
>>>
>> Ack to all the comments
>>>>
>>>> When suspending, disable this path after register space access
>>>> is done.
>>>>
>>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 36 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> index 10f2d0bb86be..a0266bfe71f1 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> 
> [...]
> 
>>>> +	ret = icc_disable(pcie->icc_cpu);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "failed to disable icc path of cpu-pcie: %d\n", ret);
>>>
>>> "CPU-PCIe"
>>>
>>>> +		if (pcie->suspended) {
>>>> +			qcom_pcie_host_init(&pcie->pci->pp);
>>>
>>> Interesting. So if icc_disable() fails, can the IP continue to function?
>>>
>> As the ICC already enable before icc_disable() fails, the IP should work.
> 
> If icc_disable() fails, then most likely something is wrong with RPMh. How can
> the IP continue to work in that case?
>
Ok then I will log the error and return here

- Krishna Chaitanya.

> - Mani
> 

