Return-Path: <linux-kernel+bounces-155761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0CE8AF6C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFBE1F28970
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE0413FD78;
	Tue, 23 Apr 2024 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kxAoW/EL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D86413FD61;
	Tue, 23 Apr 2024 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897770; cv=none; b=FxAMI2B63n4hC5k73qAu9KF4We4pT5GUToD17mqPOVNjFBXQT1kiJIdxvLNQWLN9AKRn6rZfeMfYKjEC9+3i60SpN3/Ww8mMtDlxs2RewXxlD9Ggf+EJDgFvFE3AJVLw04LHD3a8uTjxwc13XQJC09EdRSJwzD+OJdOWMVRf/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897770; c=relaxed/simple;
	bh=g0Vv83DG4sqEBlU4WnqAEhu+6e0HEs/ZvIVf8KIJAzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k3RafVu25jPQca2rMkuyoadA7u3A00jLHARytU7s9clsRwiVwcuGCxNJJjX3v9Nb90O5BxBKWgzM6FZfVsXTEFjuSyDFd4qD1qS7MzWmNZmJHsJKGV+QQGHne8vIDQGP8Muo3pmb62zI88B5L1+URlAATTZ5nqLaF7kF+/Yi76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kxAoW/EL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N9pqQs009943;
	Tue, 23 Apr 2024 18:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fi+Yeyjbs3lHGzE5VRRS5LlzgImkm2F7nnTS/uUtKaU=; b=kx
	AoW/EL/jbcXACnypdoEvCrf7BIid6wG7T/eQIEwJImlKXeqP/YjljVHheaa/VKUC
	jgSyDllLKtEX0XX3L5kKkRs0hTc7XkoQw33cPYHjSPVNBeWEnWbiMpfmDZ4fTExI
	V0fVeOgsnNuWrRl/+BelHTdnv7ZaGEdTrkwql1IQt2gWTdPuXyO9LxoHejCiLxry
	BcZN+PjmLyp0srAJsGhWWH0MzaXiiPcLd2ofxUwgxKl5NzlqsPwduht9OZFybt+h
	ZaObPQqR7yBsOCsdYvPHIHfhz+YI//VL03i2EPJUHxNUGGo48gvhgaikizp3N8XN
	ClHjK/Fas34RvQeZ3r+Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpapmhhmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:40:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NIeVV4022523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:40:31 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 11:40:30 -0700
Message-ID: <15f18424-834a-65dc-9c39-8c744abce0a6@quicinc.com>
Date: Tue, 23 Apr 2024 11:40:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/7] drm/msm/dpu: Always flush the slave INTF on the CTL
Content-Language: en-US
To: Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark
	<robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean
 Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter
	<daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Chandan Uddaraju
	<chandanu@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sravanthi
 Kollukuduru <skolluku@codeaurora.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jordan
 Crouse <jordan@cosmicpenguin.net>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami
 Kettunen <jami.kettunen@somainline.org>
References: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
 <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-3-78ae3ee9a697@somainline.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-3-78ae3ee9a697@somainline.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Vb2Pp9EBEyMwbxjyfOZsQQHuPjcOv84F
X-Proofpoint-GUID: Vb2Pp9EBEyMwbxjyfOZsQQHuPjcOv84F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_15,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1011 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230043



On 4/16/2024 4:57 PM, Marijn Suijten wrote:
> As we can clearly see in a downstream kernel [1], flushing the slave INTF
> is skipped /only if/ the PPSPLIT topology is active.
> 
> However, when DPU was originally submitted to mainline PPSPLIT was no
> longer part of it (seems to have been ripped out before submission), but
> this clause was incorrectly ported from the original SDE driver.  Given
> that there is no support for PPSPLIT (currently), flushing the slave
> INTF should /never/ be skipped (as the `if (ppsplit && !master) goto
> skip;` clause downstream never becomes true).
> 
> [1]: https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/-/blob/display-kernel.lnx.5.4.r1-rel/msm/sde/sde_encoder_phys_cmd.c?ref_type=heads#L1131-1139
> 
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 3 ---
>   1 file changed, 3 deletions(-)
> 

Yes, I agree with this, even though I did think earlier that intf master 
flush was sufficient , I cross-checked the docs and this is the right way.


Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>


