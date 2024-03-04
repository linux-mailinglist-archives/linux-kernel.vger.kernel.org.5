Return-Path: <linux-kernel+bounces-91059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1047870917
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86D7284145
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F383261699;
	Mon,  4 Mar 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J+U8NvWH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791CD26293;
	Mon,  4 Mar 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575643; cv=none; b=KIoJxOTIPhS7KrI+4Q6Q9pfl4LNnqyjc5mPs6ywcbSF6/GbbGyH1XiInQc/dThDci5JZpY6EqQv0gvm6lZ+wTwf0g3eR0FatuWorEEmKof36x4ROOFTQLTYKk1fioKjC8CSJ2PnwlVhCQjRp6+J7RaRAjbH+vcEevQzHRqZX4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575643; c=relaxed/simple;
	bh=+kPI4W1KcqjMAyWnSSkBYohj4nbHxaxkRJKPvMeuDzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VgVaKSAnVxgxbhRoSRdTSPlfY9oaMOFxHnrhpoMAxGEyCB7N17UJbQwb5/sGrfjw9dDY4cflUNOIWLrBKFU8pxIMk7rCz74yT0s2w5TyyFaM9N+8j7JcOsGmbHW0NZSYzuFBL7bnzYgoBqVLPI9+KUlCVpUNTb+93yoXhnC0klg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J+U8NvWH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424HEpom021186;
	Mon, 4 Mar 2024 18:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wI+mV9FCzojgbVbc75aDMows1874ZeqGHy6X59A75Rs=; b=J+
	U8NvWHO0/L21e7otqZKiJSNOZYv6DjXliqBeUrDJEpJ3ID4BqD6f6kRdkVfY8pyT
	Qcoa3/dfN0QS2LLOfzpoxJraminuFDXmETNkFrNINoWU2CNWi8sNXMUPM3e01+n0
	B1ZVwl6rNd5PMYGXDx4v9qDqj31jJYJKEEpVtuS49bDNYFyOsyLCPWjPARusJd9d
	E/CUkMhIIcBzJcTtamNjCaEdJyiw0XOpYwEedOd6ng6EGjQ058FKaoIrlDOTfKQv
	rgUc80Z3Q3rCmvUZw9TzX2FibmLjSNpEE+D7+S96T55YHCJBn8pMZg1p9Kbg8T0U
	f1Oqmi75WOPoQl2DAUZQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnjh7g3f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 18:07:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424I76E0010835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 18:07:06 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 10:07:05 -0800
Message-ID: <8a079ca6-8476-134d-966a-831348895349@quicinc.com>
Date: Mon, 4 Mar 2024 10:07:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] drm/msm/dpu: drop unused dpu_kms from interface
 initialization
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        "Sean
 Paul" <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David Airlie" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <quic_parellan@quicinc.com>,
        <quic_jesszhan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240228194730.619204-1-quic_abhinavk@quicinc.com>
 <CAA8EJppf0ebg+qnw7Z4P_6W4pgf0E4+KLGLEhU138f4k8+QxOw@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJppf0ebg+qnw7Z4P_6W4pgf0E4+KLGLEhU138f4k8+QxOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _n4rljtjrpDRDWyvbj8qXjA4v2UkLE9A
X-Proofpoint-ORIG-GUID: _n4rljtjrpDRDWyvbj8qXjA4v2UkLE9A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_13,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403040138



On 3/4/2024 5:06 AM, Dmitry Baryshkov wrote:
> On Wed, 28 Feb 2024 at 21:47, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>> dpu_kms seems unused while initializing DSI, HDMI and DP through
>> their respective _dpu_kms_initialize_* functions.
>>
>> Hence lets drop the parameter altogether.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> index 2af62d8fa9a7..ab924ac78c9b 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> @@ -494,8 +494,7 @@ static void dpu_kms_wait_flush(struct msm_kms *kms, unsigned crtc_mask)
>>   }
>>
>>   static int _dpu_kms_initialize_dsi(struct drm_device *dev,
>> -                                   struct msm_drm_private *priv,
>> -                                   struct dpu_kms *dpu_kms)
>> +                                  struct msm_drm_private *priv)
>>   {
>>          struct drm_encoder *encoder = NULL;
>>          struct msm_display_info info;
>> @@ -558,8 +557,7 @@ static int _dpu_kms_initialize_dsi(struct drm_device *dev,
>>   }
>>
>>   static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>> -                                           struct msm_drm_private *priv,
>> -                                           struct dpu_kms *dpu_kms)
>> +                                          struct msm_drm_private *priv)
> 
> This breaks now on top of YUV patchset:
> 
> drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c: In function
> '_dpu_kms_initialize_displayport':
> drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:583:35: error: 'dpu_kms'
> undeclared (first use in this function)
> 583 | yuv_supported = !!dpu_kms->catalog->cdm;
> 
> As this requires adding of the yuv_supported argument, let's consider
> moving it backwards: for  _dpu_kms_initialize_writeback() we can get
> format_list and n_formats from the dpu_kms.
> 

Yes, my bad, I realized after sending this that my branch did not have 
CDM changes yet.

Let me rework and post this on top of the latest tree.

> 
>>   {
>>          struct drm_encoder *encoder = NULL;
>>          struct msm_display_info info;
>> @@ -592,8 +590,7 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>>   }
>>
>>   static int _dpu_kms_initialize_hdmi(struct drm_device *dev,
>> -                                   struct msm_drm_private *priv,
>> -                                   struct dpu_kms *dpu_kms)
>> +                                   struct msm_drm_private *priv)
>>   {
>>          struct drm_encoder *encoder = NULL;
>>          struct msm_display_info info;
>> @@ -671,19 +668,19 @@ static int _dpu_kms_setup_displays(struct drm_device *dev,
>>          int rc = 0;
>>          int i;
>>
>> -       rc = _dpu_kms_initialize_dsi(dev, priv, dpu_kms);
>> +       rc = _dpu_kms_initialize_dsi(dev, priv);
>>          if (rc) {
>>                  DPU_ERROR("initialize_dsi failed, rc = %d\n", rc);
>>                  return rc;
>>          }
>>
>> -       rc = _dpu_kms_initialize_displayport(dev, priv, dpu_kms);
>> +       rc = _dpu_kms_initialize_displayport(dev, priv);
>>          if (rc) {
>>                  DPU_ERROR("initialize_DP failed, rc = %d\n", rc);
>>                  return rc;
>>          }
>>
>> -       rc = _dpu_kms_initialize_hdmi(dev, priv, dpu_kms);
>> +       rc = _dpu_kms_initialize_hdmi(dev, priv);
>>          if (rc) {
>>                  DPU_ERROR("initialize HDMI failed, rc = %d\n", rc);
>>                  return rc;
>> --
>> 2.34.1
>>
> 
> 
> --
> With best wishes
> Dmitry

