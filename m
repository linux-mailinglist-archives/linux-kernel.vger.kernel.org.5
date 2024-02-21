Return-Path: <linux-kernel+bounces-74542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB5585D5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EC81F22E35
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D61EB5E;
	Wed, 21 Feb 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZraD7TuH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBCF5394;
	Wed, 21 Feb 2024 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511810; cv=none; b=lRupBmim94NlsmRJzpQjpnMzogOPDdrR7HLrmQWecw/Vflbkr7dyECQEZbr/IUPoDOBTMnaVbRa53QJvqn1sUH5VqrO3ofE9d3ynKsMLuVoexGmu+NVlqJ5Lm0NnPwjFViUOscbe5pH9nJCTU/UpUtRFXhDPxTuF7FeVqe4CRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511810; c=relaxed/simple;
	bh=98hIhXJKdtBELA+AEq68uvyXi+RVu2cF8GKvstgGWzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RFIfQ4478IP3x0yZjoq/Jl5UiA16mc8CiZ11fSzPusCIIorXApSdAiv4UcGkgXv70SbPskNPoOwhRE1knEEaqNSGK+dCDlJciEg/kqGUVmDDLjNnvpQWgHNQrfRKi87BhNdqFV1O7Py4ue76sMr+WvNxIb2/LsVqF2rng+Nw5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZraD7TuH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L8CWCX016491;
	Wed, 21 Feb 2024 10:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2tfnXEaH1+rYdVexdUMIWkSw3lJ/qZ/7127EFCDGXMI=; b=Zr
	aD7TuH7bF/s2yRCxZl+y7AAHxPRhMCpOa1a7Q7Ta66ZpNsNQkg7L+0CFrtkCJuks
	+EkSB4v/iQAiay4Sxfkg/0WGYVeuYrYlxqtngbTvuQgZrzdkoxih6CQhhjkgLLtS
	GisoLrrgOkHXXWVX7r7/4RwesGXupR8QVDdlwdCKg1eMt6mjpD72G0tLxriuy9XU
	rnKDQfPJdCBNNUNQTEDSj0OnsdqIwzDVisyGN0qbGEafHynIryeszoy5P7LcwC9M
	tqsdE+05Z064tZDS1LQsAaKXAxwAAgL5rgWj9b80BvqPPiizaXEvSU3vS287tfVG
	wBphV7Wx2DvOFbZcE4OA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdddg0b0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 10:36:37 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LAaaaD004597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 10:36:36 GMT
Received: from [10.216.62.93] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 02:36:31 -0800
Message-ID: <04d68be4-e053-4fea-d50a-217d423bd0e0@quicinc.com>
Date: Wed, 21 Feb 2024 16:06:28 +0530
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
To: Mark Brown <broonie@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-4-quic_mdalam@quicinc.com>
 <21dde665-54b4-48e4-b963-1008ac890df3@sirena.org.uk>
 <4a0e51cf-d29a-5843-9c61-1d31a9721a3d@quicinc.com>
 <8422fb6a-edd4-4911-89b7-2974c197981b@sirena.org.uk>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <8422fb6a-edd4-4911-89b7-2974c197981b@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b-gdpO-FePoSmpYlSk2OJV-uswyjPuRH
X-Proofpoint-ORIG-GUID: b-gdpO-FePoSmpYlSk2OJV-uswyjPuRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=731
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210081



On 2/20/2024 9:34 PM, Mark Brown wrote:
> On Tue, Feb 20, 2024 at 05:24:43PM +0530, Md Sadre Alam wrote:
>> On 2/15/2024 7:44 PM, Mark Brown wrote:
>>> On Thu, Feb 15, 2024 at 07:18:54PM +0530, Md Sadre Alam wrote:
> 
>>>> +	if (op->cmd.opcode == SPINAND_READID) {
>>>> +		snandc->buf_count = 4;
>>>> +		read_reg_dma(snandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
>>>> +
>>>> +		ret = submit_descs(snandc);
>>>> +		if (ret)
>>>> +			dev_err(snandc->dev, "failure in submitting descriptor for readid\n");
>>>> +
>>>> +		nandc_read_buffer_sync(snandc, true);
>>>> +		memcpy(op->data.buf.in, snandc->reg_read_buf, snandc->buf_count);
> 
>>> These memcpy()s don't seem great, why aren't we just reading directly
>>> into the output buffer?
> 
>>    This reg_read_buf is being used in common API so that it will be used by both
>>    serial nand as well raw nand, so I can't directly use the output buffer since
>>    internally CW mechanism I have to maintain in common API.
> 
> We have control over all the source code in the kernel so if there's
> problems with the internal interfaces we can improve them.

Ok , will try to maintain CW mechanism uniform and remove from common API
and move to corresponding driver. Will try to fix in next patch.

