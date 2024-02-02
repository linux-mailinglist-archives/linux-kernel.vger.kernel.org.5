Return-Path: <linux-kernel+bounces-49409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A3B846A1F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4F81F2ABED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA84182AE;
	Fri,  2 Feb 2024 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YyVcB4IH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31636182AB;
	Fri,  2 Feb 2024 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861107; cv=none; b=rfweHxi2MfJPFQ560UbMk876sUZHjSGfSBan79yM0Dj9CQcR3uiNlghAbq9J+mIPRjC1olHUM2pvgAluencT59icY4GskcCEw8YJtzLmGEy7VHL32rDuiYvfX35VQTLU+k76mHEvVPoGVdroE9/IRjRvLFDRDt8B4DNqIEdXJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861107; c=relaxed/simple;
	bh=7mI6NlFwieNOHDQjAZw0IK3HCmfxxR/i9TASPTBpMNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I0F3MwYS75H+UIIQlTbfo35mVyaMxDEUc+RruRPqFAMy4W1g0HByfte7pqczA2a9Z3lYPNK+9hmoZfDG571XhD6x3B7eW/ot/2mcbHtsAgvO9YiAd7PY7pC0uyKdv8oVx2UipF0y87MEOTZWi5vmy1tPLNWZdyLHz7imAg1CNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YyVcB4IH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4127Fgh2019667;
	Fri, 2 Feb 2024 08:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ty+Qj9A+Kq0SxNjkhWAFPF3gpCT1JtB+qJfAJBgIQHQ=; b=Yy
	VcB4IHlabDk0xIPnMovROen01itCpzC6qqTtX/wh1rXSBNV5uc13I0dowGpyFg7r
	LymJ/P+DM9mnfpL3KX86UJ1KSywKw5LoL03hh78VyBAiHG+01K0NFG/OJ6qPMitc
	HtSQ6X+En/dalQoRokcJ0XFXsCtfURUlyO0WzSJ4HmpLQALoj4iRkOPfs2vU0J8x
	OaX9JZUyq/TUZCwNVxNKU2fH9jqu5BsiNzcKt7PowuByRvREBXQrFW69V1kl11hK
	wDYDE7611g05wS06gtoB1lBrFqiGIqDGmMtq/n6Ozc2UHHhSFhcZkQonsUs8VNjw
	RxSj5+ffyn/DGZ6VxuYA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu4gtcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 08:05:00 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41284x2W022320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 08:04:59 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 00:04:57 -0800
Message-ID: <9773d189-c896-d5c5-804c-e086c24987b4@quicinc.com>
Date: Fri, 2 Feb 2024 13:34:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] soc: qcom: mdt_loader: Add Upperbounds check for
 program header access
Content-Language: en-US
To: Auditya Bhattaram <quic_audityab@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240202063919.23780-1-quic_audityab@quicinc.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240202063919.23780-1-quic_audityab@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yjVRKeSGM5qYyVmq9XFV6vA_8F2o4Beo
X-Proofpoint-ORIG-GUID: yjVRKeSGM5qYyVmq9XFV6vA_8F2o4Beo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020057


This should be v2., first time patches is always counted as v1

On 2/2/2024 12:09 PM, Auditya Bhattaram wrote:
> hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
> is found. Add an upperbound check to phdrs to access within elf size.
> 
> Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com> > ---
> Added error prints for Invalid access.
> Link for previous discussion https://lore.kernel.org/linux-arm-msm/5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org/T/#t

Would be better if you take reference from other patches,

Like above can be done as,

Changes in v2:
   -  ...
   -  ,,,
> ---
>   drivers/soc/qcom/mdt_loader.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 6f177e46fa0f..61e2377cc5c3 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -145,6 +145,11 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
>   	if (phdrs[0].p_type == PT_LOAD)
>   		return ERR_PTR(-EINVAL);
> 
> +	if (((size_t)(phdrs + ehdr->e_phnum)) > ((size_t)ehdr + fw->size)) {
> +		dev_err(dev, "Invalid phdrs access: %s\n", fw_name);
> +		return ERR_PTR(-EINVAL);
> +	}
> +

Should this not be marked for stable kernel ? as without this it could 
be accessing beyond fw_size for uncertain scenario.

-Mukesh

>   	for (i = 1; i < ehdr->e_phnum; i++) {
>   		if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH) {
>   			hash_segment = i;
> --
> 2.17.1
> 
> 

