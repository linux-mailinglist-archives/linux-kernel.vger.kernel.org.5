Return-Path: <linux-kernel+bounces-66275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7D385599A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839881F284EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4272379DD;
	Thu, 15 Feb 2024 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZYs0/pYw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B73FC7;
	Thu, 15 Feb 2024 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707969859; cv=none; b=geKuyBaP0xQQrT5GpOJe/MeXiev4+WXA/oPu4pT19tSSDtW6yxDzpwRZUmZGs01sbjPhsT/kaVGK0ylGYrMfgjrxei77KgRVeflP11UFV9cchYatTiN6WRK2UG1qdm5kK5UROt2MYTvgM5Nim5ysA1r7HsQ/IvXa6Txs1+BsFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707969859; c=relaxed/simple;
	bh=+UkB74KnQ+CPKtYsHqYIdrZogH/5dsaFX79eK8yEAHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H5QJ5vaCIUx92MgssWYlfTWwpZ4wzdpIsT61wqbi59ufll9CI/aDI8ahKTe6NVwI98ReeJW9jtbKr42S1FNt5bc911akVTVWpWzAvmBf/9dBQ/BeaXVcCsgM4bbaDoI8xk7mSjrT4nc8n1wH0k1e4WzdgvRqfVv20AKR+5iyDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZYs0/pYw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F3wlU0019253;
	Thu, 15 Feb 2024 04:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=f7k56waSwZU1/raGuiM6+PWOOQ15l5pdc9NJUhAc9Kk=; b=ZY
	s0/pYwUXeDRjUzRROZjim2DFkFrplE0x0J3T6S6KhmeKkoUJAIISzZE6TXvAHJYf
	qIvZIwkOtBgKHvDOWJJ/XRlWxUdHjwP2YeGYvl1Nr5a4EyIBnUVOjAatZx7HFjQc
	0QjYR6RP0aPldi1eW//eqSj0ltdOXuAK3o9G0DSOyrszu6mIMrXQqSwcmFUWuvwV
	BogpQv/oh43ZgU6BsTJTRv24XT6wdupctB0v3qpYzXmXbsS3sgQsVEX95RdwaPaR
	wkR01xcus9aYAPPVx4Zw8dby4Je3a6d3l7BnWgJgZqVtEa/5k4vwdsu/32GlFiR+
	lHyuUlX28UdfZEvw7dpA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9435rqm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 04:04:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41F44D3Y031042
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 04:04:13 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 20:04:10 -0800
Message-ID: <ee8a3a1f-413d-48f1-8267-3edfbb00273e@quicinc.com>
Date: Thu, 15 Feb 2024 09:34:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] soc: qcom: rpmh-rsc: Enhance check for VRM in-flight
 request
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_collinsd@quicinc.com>, <quic_lsrao@quicinc.com>,
        <stable@vger.kernel.org>
References: <20240212-rpmh-rsc-fixes-v3-1-1be0d705dbb5@quicinc.com>
 <sizizst7xkexl3dd26sssgxtjhk7mcrawswbs76vdutsxsm6qh@mvilvzwydjpm>
 <20240214105605460-0800.eberman@hu-eberman-lv.qualcomm.com>
From: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <20240214105605460-0800.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qt-S78wifUcsIkfI_b55f_P2g-n0psS5
X-Proofpoint-ORIG-GUID: Qt-S78wifUcsIkfI_b55f_P2g-n0psS5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_03,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 phishscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150029

Hi,

On 2/15/2024 12:29 AM, Elliot Berman wrote:
> On Wed, Feb 14, 2024 at 12:08:43AM -0600, Bjorn Andersson wrote:
>> On Mon, Feb 12, 2024 at 10:18:08AM +0530, Maulik Shah wrote:
>>> Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte aligned
>>> addresses associated with it. These control voltage, enable state, mode,
>>> and in legacy targets, voltage headroom. The current in-flight request
>>> checking logic looks for exact address matches. Requests for different
>>> addresses of the same RPMh resource as thus not detected as in-flight.
>>>
>>> Add new cmd-db API cmd_db_match_resource_addr() to enhance the in-flight
>>> request check for VRM requests by ignoring the address offset.
>>>
>>> This ensures that only one request is allowed to be in-flight for a given
>>> VRM resource. This is needed to avoid scenarios where request commands are
>>> carried out by RPMh hardware out-of-order leading to LDO regulator
>>> over-current protection triggering.
>>>
>>> Fixes: 658628e7ef78 ("drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs")
>>> cc: stable@vger.kernel.org
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
>>
>> This says, "Elliot first certified the origin of the patch, then Maulik
>> took and certified the origin of the patch". But according to the From:
>> the author of the patch is you, Maulik.
>>
>> How was Elliot able to certify the patch's origin before you, when
>> you're the author?
>>
>> If the two of you collaborated, also add Co-developed-by: Elliot above
>> his s-o-b.
>>
> 
> Even my Co-developed-by is being generous :-) All I had done was copy
> the commit and resolve couple merge conflicts.
> 
> Maulik, you can swap my S-o-B for a:
> 
> Tested-by: Elliot Berman <quic_eberman@quicinc.com> # sm8650-qrd
> 

Addressed in v4 to change to tested-by.

Thanks,
Maulik

