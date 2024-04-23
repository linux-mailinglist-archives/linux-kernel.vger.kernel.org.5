Return-Path: <linux-kernel+bounces-155764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48988AF6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B199AB25F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A313E8AA;
	Tue, 23 Apr 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Py4WITlL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5F1CD39;
	Tue, 23 Apr 2024 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897914; cv=none; b=hLXgaFkq9Jpk+orE2fecwVTaBxbPh77z6x5WDIHwDaoQ7Rk++F/8rcdHUOXAkFrBa8bV5lxL88UUBktjyCvEyB5KM0wFCCX8KIHJVHWNNiSTPd8oHdRFOGXD5jnKTpLBDR/uO5cb3kUz1X4LMtYA5M4zOrJEgfW2bSxsNclCaVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897914; c=relaxed/simple;
	bh=FVmo2qUeCFAK7JGM525GXTwOt66sExGefL9a3q+HSsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KS95DdGyEO6EVZw5ObrwRVY6IeT2xzD+tWqwKcBwHM0yHWnQirwHQUVHH4u6pgiXP12AGxS7DJu43ekfmO6P8vDxTyv4E/YFAnb7FTtmBFTf8ldnX9TOmwx1HMNKBSB5Ros0J8v/rnkU4uBJZzzFcUYp/EC+euRbXyW5Jw3josA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Py4WITlL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NBTles002064;
	Tue, 23 Apr 2024 18:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1xuRdsc5E4JkoyPybqYXAta3WzudMMp2B+z34cEsg30=; b=Py
	4WITlLZbKNlVN3Z/ZSEnXPWcH7dcbmKf9ivi43MP8B+NPxLUrJhYnWhcHWNVmGBG
	FOWOYa7I224Er6+JGviEfNsULYqw8HLLd6zCJbODLZqGKkSAduEQv0ZvQo60DHXs
	Dx0Q/1lIuBRi1CMOTQ96GDoGmpukg5BMcANrs1ww6FtSBOoJ/yLGQ/IFPQm6OWl3
	qgO/AggpKAZuWWjNgz+orHpzYmkLiiZl8JOZ7IFYSDTj7mDUm6sIXEZTWrqIIq2B
	gifnRHuNczbw9jareruPuv7CB/2tl9O7IevOreQIDModOWVRzUJfAISCIQyMJ29e
	elq618z92dcAGcgIZX/w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp91fhusf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:45:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NIj80U027419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:45:08 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 11:45:07 -0700
Message-ID: <88074e78-1dae-eebb-4e74-55644e1f3330@quicinc.com>
Date: Tue, 23 Apr 2024 12:45:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 2/3] bus: mhi: host: Add a new API for getting channel
 doorbell address
Content-Language: en-US
To: Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
 <1713868417-37856-3-git-send-email-quic_qianyu@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1713868417-37856-3-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _vGLPflRVeDPEx-JSCvGzkohwjndsoBR
X-Proofpoint-ORIG-GUID: _vGLPflRVeDPEx-JSCvGzkohwjndsoBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_15,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404230043

On 4/23/2024 4:33 AM, Qiang Yu wrote:
> Some controllers may want to know the address of a certain doorbell. Hence
> add a new API where we read CHDBOFF register to get the base address of
> doorbell, so that the controller can calculate the address of the doorbell
> it wants by adding additional offset.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index d968e1a..cb3b676 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -816,4 +816,10 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>    */
>   bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir);
>   
> +/**
> + * mhi_get_channel_doorbell_offset - Get the channel doorbell offset
> + * @mhi_cntrl: MHI controller
> + * @chdb_offset: Channel doorbell offset
> + */
> +int mhi_get_channel_doorbell_offset(struct mhi_controller *mhi_cntrl, u32 *chdb_offset);

Should have a blank line here before the #endif just like how the file 
was before this change

>   #endif /* _MHI_H_ */

With the above
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

