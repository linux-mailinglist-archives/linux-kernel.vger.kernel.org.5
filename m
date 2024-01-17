Return-Path: <linux-kernel+bounces-29317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F141C830CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFF5B21777
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC832374F;
	Wed, 17 Jan 2024 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZqaHSnPG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0B23740;
	Wed, 17 Jan 2024 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516166; cv=none; b=IBR3uob+G/pyOOmtjnwrjifMJbMk+nTaDP1iVZ6DV+6OPYPNCRC9aP3DjbxAiJKcIC9UZ9iTZajp4gjmPd35GIk/yc9GabvOQ1QCa8SMXY+3SdoW9z0u5c/yAxdWgdYQrecPfJSUT8kDNuoxBA4QlMyCa2oUTxuOJn6nzM5QmWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516166; c=relaxed/simple;
	bh=XvpCTCdj+Y+6JV36I6C5nb3iuArYkwYCN3YenBtkbpo=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-QCInternal:X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=CMk6MJf8npIPppsJPjNCkwbxhcb9jppiUtow1Emd2/kwMHArcRuRaWAvs/lwItmFPNp9Y5lSWMU96TMnCWGLMHUSfD0dYG4PybB6caCgTAXiN2r87MlAWTL4mebFEMUFao0yr0pXfZW+NsHu+QEQr6mC48ZS+cKWfTTYLeGjAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZqaHSnPG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HHjFiV020918;
	Wed, 17 Jan 2024 18:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zkRc/3bS0GJjom2pOE2NLNuRb8ghNJ8znGLS0L0OTVI=; b=Zq
	aHSnPGPY6ZatimUXfNUy9bCt9JhAUj07iwGlffSF4IWsj2lJBvNypvycNGLPJDXj
	g/HXvHWW9w23iZ7UAPu0fVmj9TzoEN5kwS3wfN4z+IVB2hpGSYn6voOa4FPvXNBe
	iKfztsCS78BYOibU5lPYEyw3SbjkjdLkcu+Nj56fuGzFwT6FrIZgvQsVbhOlQGML
	nvIaqAmYHz0/vvSB28+RAqdsS2emrobJJo4V9t5M02folaRMRGTzVxDaOlOm3nCy
	TCXjSxUy8wO3Jq0hkpdEKp2nN16vBCzPnHg30y49lHEchwMaf5BlXNfzoAQL4bgr
	bpR3VI5uRltW9skHkeOA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpkjrg42s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 18:29:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HITCxq014230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 18:29:12 GMT
Received: from [10.110.28.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 10:29:11 -0800
Message-ID: <33f9d97d-f0fb-96d7-eea9-c43c3a5a162e@quicinc.com>
Date: Wed, 17 Jan 2024 10:29:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/msm/dp: correct configure Colorimetry Indicator
 Field at MISC0
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1705514068-22394-1-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJpqO+SWYcCtH1hOVow18ZTbJ=qh0D68CEP1sGObdd3=ciA@mail.gmail.com>
Content-Language: en-US
From: Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAA8EJpqO+SWYcCtH1hOVow18ZTbJ=qh0D68CEP1sGObdd3=ciA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F45rYthc62rDZDqtmrz9pt7AuM6YpLCD
X-Proofpoint-GUID: F45rYthc62rDZDqtmrz9pt7AuM6YpLCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_11,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170133


On 1/17/2024 10:12 AM, Dmitry Baryshkov wrote:
> On Wed, 17 Jan 2024 at 19:54, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>> MSA MISC0 bit 1 to 7 contains Colorimetry Indicator Field. At
>> current implementation, at DP_TEST_DYNAMIC_RANGE_CEA case the
> In the current implementation, in the ... case
>
>> Colorimetry Indicator Field is mistakenly left shifted one extra
>> bit.
> This doesn't make sense. You say that the value is mistakenly shifted,
> but the shift is still in place in dp_catalog_ctrl_config_misc().

The problem is at

  link->dp_link.test_video.test_dyn_range =   (bp & 
DP_TEST_DYNAMIC_RANGE_CEA);   <== this from reading dpcd directly where 
==> DP_TEST_DYNAMIC_RANGE_CEA  is   (1 << 3)

within dp_catalog_ctrl_config_misc(), cc will be left shift one more bit.
so that cc is totally is left shifted 4 bits (bit 4).

at misc0, it should be bit 3 set only for CEA_RGB.

>
>> This patch return correct value of colorimetry at
>> dp_link_get_colorimetry_config() to fix this problem.
> See Documentation/process/submitting-patches.rst#_describe_changes
>
>> Changes in V2:
>> -- drop retrieving colorimetry from colorspace
>> -- drop dr = link->dp_link.test_video.test_dyn_range assignment
>>
>> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_link.c | 11 ++++++-----
>>   drivers/gpu/drm/msm/dp/dp_link.h |  3 +++
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
>> index 98427d4..2e1bdaf 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_link.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
>> @@ -1082,7 +1082,7 @@ int dp_link_process_request(struct dp_link *dp_link)
>>
>>   int dp_link_get_colorimetry_config(struct dp_link *dp_link)
>>   {
>> -       u32 cc;
>> +       u32 cc = DP_MISC0_LEGACY_RGB;
>>          struct dp_link_private *link;
>>
>>          if (!dp_link) {
>> @@ -1096,10 +1096,11 @@ int dp_link_get_colorimetry_config(struct dp_link *dp_link)
>>           * Unless a video pattern CTS test is ongoing, use RGB_VESA
>>           * Only RGB_VESA and RGB_CEA supported for now
>>           */
>> -       if (dp_link_is_video_pattern_requested(link))
>> -               cc = link->dp_link.test_video.test_dyn_range;
>> -       else
>> -               cc = DP_TEST_DYNAMIC_RANGE_VESA;
>> +       if (dp_link_is_video_pattern_requested(link)) {
>> +               if (link->dp_link.test_video.test_dyn_range &
>> +                                       DP_TEST_DYNAMIC_RANGE_CEA)
>> +                       cc = DP_MISC0_CEA_RGB;
>> +       }
>>
>>          return cc;
>>   }
>> diff --git a/drivers/gpu/drm/msm/dp/dp_link.h b/drivers/gpu/drm/msm/dp/dp_link.h
>> index 9dd4dd9..fe8f716 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_link.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_link.h
>> @@ -12,6 +12,9 @@
>>   #define DP_TEST_BIT_DEPTH_UNKNOWN 0xFFFFFFFF
>>   #define DP_LINK_CAP_ENHANCED_FRAMING (1 << 0)
>>
>> +#define DP_MISC0_LEGACY_RGB            0
>> +#define DP_MISC0_CEA_RGB               0x04
> These should go to dp_reg.h and should start with DP_MISC0_COLORIMETRY_CFG
>
>> +
>>   struct dp_link_info {
>>          unsigned char revision;
>>          unsigned int rate;
>> --
>> 2.7.4
>>
>

