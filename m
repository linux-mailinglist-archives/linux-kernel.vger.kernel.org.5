Return-Path: <linux-kernel+bounces-47587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2152844FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D428400C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932D93B182;
	Thu,  1 Feb 2024 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kFJfbRzr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381AB282EB;
	Thu,  1 Feb 2024 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758611; cv=none; b=jkmayETDnVDnLTFPIfhVXV+GrJNX9kox+sNhlqFt1SICprJyXlep+gUJZj9VfBlpY5HCxVH9xj1rXROYr5Qd34Ivl4G50oq3HoLLRvGAW4PphVcEy89XowhTy78oWWKsYIR3QBUXe9dW7Ld6wkvR2jjbzXVmuLYMtbc5YVPDiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758611; c=relaxed/simple;
	bh=Bq55cvGNwwVVpOCiQwwFt8k52ct0mUs6l4Q52OlVgMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k6Yv33hvoZxuMz0mfPcf5oGGKUHyai4opeVefjFl6fNFtC067ttNSsz0MakwYWMKHP/JGXphIptloHkkN5ksjxzDjJZOlRVzBNYb45ZY/DJxulpuo9z9CJhyXGxpt3WDRzBN0R6M4BJIIXpNPh9H77uDB57bOpqExm+Nscoh0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kFJfbRzr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4112wc09022667;
	Thu, 1 Feb 2024 03:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hDXm8bbfVsYkdRMP++yi7/3ByrToweDaaBP8GUMHS3k=; b=kF
	JfbRzr01oH+ZjmJLWhvMGJV5pXCXkipsCpme+rgALTu5UGrrZoPmqzQzNiurOCH6
	b/OBAefJvi7M2DloXxZOXJGpQ93iXz9GeS6FqHCoPb4iuorEgu2x7kyVBMe+FbO4
	/dtC+FBDVrwiXwqMtAExsLHBk2CmrSxoHiMY2kj7rQO83N97eXhwNZltOnEgvgAL
	SjJr2lfLnwJ/pXkH902mG4ENs36DyIc2dnYMFYh96D/hlsTuamXlp5aldaXuUtnB
	aS9U+lhmKA0slFmQohjqsOI9S+Y0vsX340lHb3uM7z4l/Z/iPGZi/mPRy6PNLYV+
	mdFSFpoWXIwArA5Ng3hQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyx6drmw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 03:36:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4113aclN030218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 03:36:38 GMT
Received: from [10.253.15.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 19:36:34 -0800
Message-ID: <fd3d7ea4-b1f8-429b-ba0d-588c2bbe25a3@quicinc.com>
Date: Thu, 1 Feb 2024 11:36:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] scsi: ufs: core: Remove the ufshcd_release in
 ufshcd_err_handling_prepare
To: Bart Van Assche <bvanassche@acm.org>, SEO HOYOUNG <hy50.seo@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <kwangwon.min@samsung.com>, <kwmad.kim@samsung.com>,
        <sh425.lee@samsung.com>, <sc.suh@samsung.com>,
        <quic_nguyenb@quicinc.com>, <cpgs@samsung.com>,
        <grant.jung@samsung.com>, <junwoo80.lee@samsung.com>
References: <CGME20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52@epcas2p2.samsung.com>
 <20240122083324.11797-1-hy50.seo@samsung.com>
 <0ae6c12e-3b55-4d90-b042-e8c2b3a2c4a7@acm.org>
Content-Language: en-US
From: Can Guo <quic_cang@quicinc.com>
In-Reply-To: <0ae6c12e-3b55-4d90-b042-e8c2b3a2c4a7@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: awebamET4vpZBG3GKjS_OsFbmEaHInGD
X-Proofpoint-GUID: awebamET4vpZBG3GKjS_OsFbmEaHInGD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2402010027



On 2/1/2024 1:44 AM, Bart Van Assche wrote:
> On 1/22/24 00:33, SEO HOYOUNG wrote:
>> This is because ufshcd_errhandling_prepare() and
>> ufshcd_err_handling_unprepare() repeatedly release calls.
> 
> It would have been much more clear if it would have been mentioned that
> ufshcd_err_handling_prepare() should call ufshcd_hold() once and
> also that ufshcd_err_handling_unprepare() should call ufshcd_release()
> once.
> 
> Additionally, a Fixes: tag is missing. Is this patch perhaps a fix for 
> commit
> c72e79c0ad2b ("scsi: ufs: Recover HBA runtime PM error in error handler")?
> Can Guo, since you wrote that patch, can you please take a look at this 
> patch?
> 
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index 7c59d7a02243..423e83074a20 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -6351,7 +6351,6 @@ static void ufshcd_err_handling_prepare(struct 
>> ufs_hba *hba)
>>           ufshcd_hold(hba);
>>           if (!ufshcd_is_clkgating_allowed(hba))
>>               ufshcd_setup_clocks(hba, true);
>> -        ufshcd_release(hba);

When we are here, it means runtime resume has failed.

When I wrote the code (in older kernel), ufshcd_runtime_resume(), if 
fails, bails without calling ufshcd_release(), eventually 
ufshcd_err_handling_unprepare() would call ufshcd_release() to balance.

But now, I see that if __ufshcd_wl_resume() fails, ufshcd_release() is 
called anyways, so ufshcd_release() is not required here. Hence,

Reviewed-by: Can Guo <quic_cang@quicinc.com>

>>           pm_op = hba->is_sys_suspended ? UFS_SYSTEM_PM : UFS_RUNTIME_PM;
>>           ufshcd_vops_resume(hba, pm_op);
>>       } else {
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

