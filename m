Return-Path: <linux-kernel+bounces-72991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F199C85BB99
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A880B214B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FED67C6A;
	Tue, 20 Feb 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iTTDfv84"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3541C66;
	Tue, 20 Feb 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431313; cv=none; b=MYdG/bv8ApdPhgVKSXDNPDDXtjJ/+CHMIYihDlalMCaUsmc8Za0nuqn90rPFqiJgWf4/r+cQ+/eT//2t2XSUnZTdbaXxssR/sjeONocipy4GNgeuxmmPz9fADX5Jhe4eo3c2d/hwAx4p04DF1KaEOnZ8eA9Spx+J0mjmAWBT9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431313; c=relaxed/simple;
	bh=r6nqoS7kMM7ci+2ReiSu0VCg0rHZGr/oGH/w6nlGJpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bA/lW39Gn+pD7Sl5F4Fe8tHF4tClZ+s5dcFcf0NqvRYdFtfmq8Vpv8b4xUTbZiBvIbXZRTKjrX3wr6q3w8gcQI+87ugDpiqMt55QqH/wg+/g5aewfWPbgc/bqJmoSk7EQ6ZkbvWSJ9JM87fW3zVHT/eSqfxAesYRZdM8E+oZzSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iTTDfv84; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KAZO5l001507;
	Tue, 20 Feb 2024 12:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cxFS81RMJtemynwSdZqrwfVjkZcRgXLWimSCapEpgBY=; b=iT
	TDfv84WiSCPv56CT16vjGvt5oApl3jIHhXTwjZ069BpDjozpjCWkhDfAetJ3ZdPs
	FsXaxstZfUmvd6ryoJCmeuqZi6lK3MAd+YzBkjfeEG1c+djSY3QhszCWwpU5YHqn
	Yhsd0U+RMrTEsVTB86rAcjvfXHcTIp6Xnd6HSKSFBbJ4z4hf5z86I7dPsdvJJrGc
	iqGG/XduTmP5KU7eX7Ltj82deoCiSkyrWW/2ZLN+QgMGn82aKMtxyGFQil3M4yDQ
	f/pNpNPjpW5CiTVU4hj6jAo2rLwMGEN9tbDjM2Sh2OqnveABJLvP7luyacyPgEvU
	IovxTYriR+x3pdgtoD4Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wct3eg7k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:14:57 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KCEuFV020391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:14:56 GMT
Received: from [10.216.16.129] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 04:14:50 -0800
Message-ID: <f5177fad-214f-1b60-46ba-1dc0a4fb059e@quicinc.com>
Date: Tue, 20 Feb 2024 17:44:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/5] spi: spi-qpic: Add qpic spi nand driver support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-4-quic_mdalam@quicinc.com>
 <d1c80d3f-3b70-4630-8f7d-b00983b487dd@linaro.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <d1c80d3f-3b70-4630-8f7d-b00983b487dd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L8yq_Uekkjs14WXkjphCaEBvZ_r7yuA5
X-Proofpoint-GUID: L8yq_Uekkjs14WXkjphCaEBvZ_r7yuA5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200087



On 2/15/2024 11:27 PM, Konrad Dybcio wrote:
> On 15.02.2024 14:48, Md Sadre Alam wrote:
>> Add qpic spi nand driver support. The spi nand
>> driver currently supported the below commands.
>>
>> -- RESET
>> -- READ ID
>> -- SET FEATURE
>> -- GET FEATURE
>> -- READ PAGE
>> -- WRITE PAGE
>> -- ERASE PAGE
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> [...]
> 
>> +void snandc_set_reg(struct qcom_nand_controller *snandc, int offset, u32 val)
>> +{
>> +	struct nandc_regs *regs = snandc->regs;
>> +	__le32 *reg;
>> +
>> +	reg = offset_to_nandc_reg(regs, offset);
>> +
>> +	if (reg)
>> +		*reg = cpu_to_le32(val);
> 
> if (WARN_ON(!reg))
> 	return;
> 
> instead?
> 
> This would be tragic..

  will fix this in next patch.

> 
> [...]
> 
>> +
>> +	ecc_cfg->cfg0 = (cwperpage - 1) << CW_PER_PAGE
>> +				| ecc_cfg->cw_data << UD_SIZE_BYTES
>> +				| 1 << DISABLE_STATUS_AFTER_WRITE
>> +				| 3 << NUM_ADDR_CYCLES
>> +				| ecc_cfg->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_RS
>> +				| 0 << STATUS_BFR_READ
>> +				| 1 << SET_RD_MODE_AFTER_STATUS
>> +				| ecc_cfg->spare_bytes << SPARE_SIZE_BYTES;
> 
> Let me introduce you to FIELD_PREP/GET and GENMASK().. Many assignments
> in this file could use these.

  Ok
> 
> Konrad

Thanks for reviewing, will fix all the comments in next patch.

Regards,
Alam.

