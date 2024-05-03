Return-Path: <linux-kernel+bounces-167381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8470A8BA8B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40901C21EBF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3691148FE2;
	Fri,  3 May 2024 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WYOdN8YM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE204148855;
	Fri,  3 May 2024 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724863; cv=none; b=rlmCHoO6yFgyRzMhBEUyEO8jLCz/gMQ+HAfkfxQSN+mIrJ1qkm/KfHlcY+/k8qxWdn4eT2GQM3TshofnkaI/bcwn3YAlX5cp33KBvuHCJQ1A7PJSA8DiFhTxvuCig98Enn6hxVyV1FGRx5inyEgB0MNa73/FE6tu7GWyxeu9e/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724863; c=relaxed/simple;
	bh=hpXw+JDhyJ8KA6VXCSkM1PllCVjuc41BdT8/PaWBXrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qNSX8RNYWL5igvhcnLbnq6ZtKSvFfp4zHLf48Eq8/CrYsd4XlGrSeb2kGi+98efJdx42J2y1LjfXLASE7lBVm04Mr897dcg6GRCD4W0AVRIrlPx8gL6QeJ2bUQrPTGygDGgn7mzfcX6EMWGOcC/8+RMpuxcZ7scjcE4ncJheT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WYOdN8YM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4437QIY5014558;
	Fri, 3 May 2024 08:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=AWC8U9sGRekOaFvp6EhFFk8tv5bErTGxtGrzxXaaxQ8=; b=WY
	OdN8YMUAwk9sdSFvXRRG087IIfXlHz8QAmPej3TbUTNkBEl+OtDZVpKQfOZcw8LD
	A4oyK8Op3qlS7fn85SHAwWx23aV3uJGPDuN9KEdrdEqnozORw/XT5ucDJkxHG6Ss
	JxL1cSJ2/cQmenseqmZavydZawVw8mHOP2qTmcPANPN+WdzU7u/Rabxr7Tv1Dc5h
	WZDkmKsOUyVpIVa6cpUJ3yr02XSXf1JMluQaI5A5C1PkQ6cUvPL8uKCaFUFahf1Y
	Zv+R89AVVQySC0L8wCRZ/IVFNUfg9F3VuloMWvi7lu+dAr7DplpaRoAonotWFzka
	n7CmnwknccxcZCmTDN7A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvrt4gc6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 08:27:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4438RZoY013426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 08:27:35 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 01:27:32 -0700
Message-ID: <d8b7717c-1448-7f79-ea05-3dc9cc9bb90e@quicinc.com>
Date: Fri, 3 May 2024 13:57:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 1/3] soc: qcom: Add qcom_rproc_minidump module
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <1711462394-21540-1-git-send-email-quic_mojha@quicinc.com>
 <ZjD0Yr72qv0ul3jK@hu-bjorande-lv.qualcomm.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ZjD0Yr72qv0ul3jK@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BploNm2cebPIENlZibYLiGfp3qBEFwSX
X-Proofpoint-ORIG-GUID: BploNm2cebPIENlZibYLiGfp3qBEFwSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_05,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030059



On 4/30/2024 7:08 PM, Bjorn Andersson wrote:
> On Tue, Mar 26, 2024 at 07:43:12PM +0530, Mukesh Ojha wrote:
>> Add qcom_rproc_minidump module in a preparation to remove
>> minidump specific code from driver/remoteproc/qcom_common.c
>> and provide needed exported API, this as well helps to
>> abstract minidump specific data layout from qualcomm's
>> remoteproc driver.
>>
>> It is just a copying of qcom_minidump() functionality from
>> driver/remoteproc/qcom_common.c into a separate file under
>> qcom_rproc_minidump().
>>
> 
> I'd prefer to see this enter the git history as one patch, extracting
> this logic from the remoteproc into its own driver - rather than as
> presented here give a sense that it's a new thing added. (I'll take care
> of the maintainer sync...)
> 
> I also would prefer for this to include a problem description,
> documenting why this is done.
> 
> 
> I've not compared patch 1 and 3, but I'd also like a statement in the
> commit message telling if there are any changes, or if the functions are
> cleanly moved from one place to another.


Thanks for the review, addressed the comments here in v10.

https://lore.kernel.org/lkml/1714724287-12518-1-git-send-email-quic_mojha@quicinc.com/

-Mukesh

