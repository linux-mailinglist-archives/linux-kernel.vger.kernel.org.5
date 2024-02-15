Return-Path: <linux-kernel+bounces-66274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D131855997
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D054FB27B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A1179DD;
	Thu, 15 Feb 2024 04:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zt2VBDe5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572117C8;
	Thu, 15 Feb 2024 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707969789; cv=none; b=QRW/m2RsB2r75gmnfLBKD6xeM61XRupvv1fOBEoxNkxR0yIRa78JG6/SZI/u5qgEpNnR3hnrFCv2KZIT9zCq00KyJJPGX+MqAsSBCqbQ6+diT2qw2LHG3DvgMTaC6SBK/FN++BNC+RyHpJ/dsEeBdkKmXPfjI4yfR3wW44oI6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707969789; c=relaxed/simple;
	bh=MGglnvUd/SuNbAYCf1wguQOLx8bENqb8nTjheu/5ydM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uKPU1szX6kDnB0eEoVB5Mdr9eBLGmhkRuSAPBS8hBH+7eglLQVIn736nyzJPwUElIcFwjwGbu37IMjiMgtJhNKNGzmeS9+Ws8e2ee8euZ8jd9IA+Au/OeJV3rXzt6SZQVal6QeJRg/FkVNKNENG0ywH9SaslysMwmGDngkWHR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zt2VBDe5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F3nYTc021545;
	Thu, 15 Feb 2024 04:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=W0Vt3m+Ksh0m2AB6cV96cVUC+NmOcmOOOc2dmPezte8=; b=Zt
	2VBDe5jl73OeTOOaGzM+le/5hEc5e9K+Xz7yY3rsLg9uvGQkLJdQakIEUiEn4LOM
	rsmwLPTYYDAQjX6qDop59kTZh0bhN0oUOIopDfHCY/yIxcOVTMFkUwHBtUfIMEcS
	igtySolMwQUP41dTEfMPNf3U0JzflFwxpS73H6U2KO0QnkpKm+21gIq+C6xHV/jC
	fwyBSBehqVVIUwh3OyQyrgudF4i51mHeX+RBNdwHf05bgzYOhFe2dL1+jE3SNSgi
	zEuLakhbc1xB42Wm4Ai/yXD6EopVPJm2iD4sbf+0mbdC6Mw/zT9uoU076lIJwA67
	gfyenGjOQ3s3XTIug3Qw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8kkrjvkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 04:03:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41F432BI027453
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 04:03:02 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 20:02:59 -0800
Message-ID: <80a21609-d4a0-473d-96ac-f49ed9d4198f@quicinc.com>
Date: Thu, 15 Feb 2024 09:32:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] soc: qcom: rpmh-rsc: Enhance check for VRM in-flight
 request
To: Bjorn Andersson <andersson@kernel.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_eberman@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_lsrao@quicinc.com>,
        <stable@vger.kernel.org>
References: <20240212-rpmh-rsc-fixes-v3-1-1be0d705dbb5@quicinc.com>
 <sizizst7xkexl3dd26sssgxtjhk7mcrawswbs76vdutsxsm6qh@mvilvzwydjpm>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <sizizst7xkexl3dd26sssgxtjhk7mcrawswbs76vdutsxsm6qh@mvilvzwydjpm>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CZwzUWw9P9FfGYzVTofDjmN-cEW0Hvd7
X-Proofpoint-ORIG-GUID: CZwzUWw9P9FfGYzVTofDjmN-cEW0Hvd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_03,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150029

Hi,

On 2/14/2024 11:38 AM, Bjorn Andersson wrote:

>>   /**
>> - * cmd_db_read_slave_id - Get the slave ID for a given resource address
>> + * cmd_db_match_resource_addr - Compare if both Resource addresses are same
> 
> () after the function name, please.
> 

Thanks for the review, Addressed in v4.

>> + *
>> + * @addr1: Resource address to compare
>> + * @addr2: Resource address to compare
>> + *
>> + * Return: true on matching addresses, false otherwise
> 
> "Return: true if the two addresses refer to the same resource"
> 

Addressed in v4.

>> + */
>> +bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
>> +{
>> +	/*
>> +	 * Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte
>> +	 * aligned addresses associated with it. Ignore the offset to check
>> +	 * for VRM requests.
>> +	 */
>> +	if (SLAVE_ID(addr1) == CMD_DB_HW_VRM
>> +	    && VRM_ADDR(addr1) == VRM_ADDR(addr2))
> 
> One line please, it's just 83 characters.

Addressed in v4.

>> +		return true;
>> +	else if (addr1 == addr2)
>> +		return true;
>> +	else
>> +		return false;
>> +}
>> +EXPORT_SYMBOL_GPL(cmd_db_match_resource_addr);
>> +
>> +/**
>> + * cmd_db_read_slave_id - Get the slave ID for a given resource name
>>    *
>> - * @id: Resource id to query the DB for version
>> + * @id: Resource id to query the DB for slave id
> 
> Although trivial, it's unrelated to the newly introduced logic. Please
> submit a separate patch. Please also then add the () after the function
> name.
> 
> Regards,
> Bjorn

Sure, i will send out separate patch for other comments to update.

Thanks,
Maulik

