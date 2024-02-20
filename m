Return-Path: <linux-kernel+bounces-72978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32CE85BB60
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D941F224FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AE767C68;
	Tue, 20 Feb 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R4Hc1qUh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52E67C45;
	Tue, 20 Feb 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430749; cv=none; b=KL25dQLxrK9kfa+zyeJOBccPJgcNc4yINBJa5f6c2LhwdnLMs2n235HEJYuwqGxf8NpPY8/Q8/t/sb0lxWL9XxWC0HUc6YblXPAUvjUoeCWRvfDHeHlWJsWI7QDRhUE1m5m1nwkMFKjNjw14PVtJ/jEoRuoEVot5y7Iq80OcOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430749; c=relaxed/simple;
	bh=wdIDmsU+dJoSVKx5I1I9cfvLupOEZXA4trMgoJ34j0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bTBJKng690S4gnlPHfk2WqC5TIRKkzDBgxI+kCWxsOiGNiqXHuhxYK+BfL/lGL8O4e5Oz0GRefVcLrDKZCey6e0pvojjxZJy3INDabG7hZB5CAblFsNy4NA51kigC1O1gykiS4CVikrhCb4HkhJgbaxYUD2SNCS+nq3eagFYQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R4Hc1qUh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K89mOx014360;
	Tue, 20 Feb 2024 12:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uaotM+TMfu6Ag+7mzcFHA7Okom4KyPPm/SNRIsJyHi4=; b=R4
	Hc1qUhB0HCQSah9EPrtfDxHShgjeAKd2s+RqqKer31LFnurj7HG5PwhP6AT9ZtNd
	pGkI1piGPOc8MO/mgjQEUxL6dAh5EJ8SuLqmrriNTJ2l+pIDSgXSe79NYeP4Wzfg
	asGJOxFqoOVET7xNBMI/SpS9JmCR/vnQEYPQuvmLoyDEjVyzcEUeVrMKSFIDA+wC
	ElzCHcHodMqS/XlCE/FZRuprDkTfsmSQ5RSuuzqESIiMmpIwfoPu0eU/lPx81fVo
	5ZFJH7mpvobQPWVg23aDN8PkE2qx4KHlTQtFXxtnxZdM3m4T/kLuaLP3lS1TBNvG
	08GHCTEUEFwWdewmvqPQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcravgfdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:05:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KC5Xxo002018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:05:33 GMT
Received: from [10.216.16.129] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 04:05:27 -0800
Message-ID: <48ab25f4-fc8e-f420-924d-bbae797048b2@quicinc.com>
Date: Tue, 20 Feb 2024 17:35:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/5] spi: dt-bindings: add binding doc for spi-qpic-snand
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
 <20240215134856.1313239-2-quic_mdalam@quicinc.com>
 <ab55fcde-f3ee-426c-ae24-2e76ffb20a2b@sirena.org.uk>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <ab55fcde-f3ee-426c-ae24-2e76ffb20a2b@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7K83zaQ7nw6AGb3krlCnT41vnav1Acx3
X-Proofpoint-ORIG-GUID: 7K83zaQ7nw6AGb3krlCnT41vnav1Acx3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=781 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200087



On 2/15/2024 7:52 PM, Mark Brown wrote:
> On Thu, Feb 15, 2024 at 07:18:52PM +0530, Md Sadre Alam wrote:
> 
>> +  clocks:
>> +    minItems: 2
>> +    maxItems: 3
>> +
>> +  clock-names:
>> +    minItems: 2
>> +    maxItems: 3
> 
> The driver requests the clocks by name but this does not document the
> expected set of names.  The driver also unconditionally requests all
> three clocks so won't work with only two clocks.

Thanks for reviewing, Will document the clock name in next patch.
By mistake i have given minItems = 2 and maxItems = 3 , will fix
this in next patch.

