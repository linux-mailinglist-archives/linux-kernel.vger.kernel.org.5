Return-Path: <linux-kernel+bounces-108048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB9880537
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236501F24225
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC8A39FD1;
	Tue, 19 Mar 2024 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e3b+/0f0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD942B9CF;
	Tue, 19 Mar 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874951; cv=none; b=AAEv66llt6RAWpMiFnaDfRvegNwN8bAH5POXYYIq3wc0MXR9jFfPTnvO7/wXr0F8MR5thju5O/NyJRE11a3AA2aqroH1vvsDARj3GzC5jqdLGnBAfkw8UGAdHjTSXUxt4Y4QloTHXImwIqmBDfaO4dSlwWi1+01dXFHrpl9eVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874951; c=relaxed/simple;
	bh=xhTBM1ype8leo2fNoMrinBhzHLV6MNlmhVPmBxtLa5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l1Iqn19AgoEy+jQQSII1q7NqhpLdD5KymBDI7ANbP8Dj1SUjtE3kgMjn7dpUp3p/VOK9GwJHPuP9B+C/HT238WlA4EZoQI75csJJ4XbTfgN8SSGbbJOH04VvU7W9xqJ1bjCUa68n7RDBK4FZIRJd5TOSsYifCAwV+JnC/Ro7nns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e3b+/0f0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JHH1Zt021200;
	Tue, 19 Mar 2024 19:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=G2fmueehjhCwLS/hDvr7oz47odVkbmYslG1ZuIcCUWY=; b=e3
	b+/0f0vnkIn1qgiPbaEjPK18/08PLUmQax5LKZ3VqIKxboY5gXX58Um27M/L3cF3
	f8hGqd2BqrqEPdakhCadauzc5lJTIyQgYve2myeuyOJ0Bj3hZQ5uA2Hq9J/HsBPp
	EvC9p66uEpp/UuaRx9wE1tw4MM7jqQ4fPNzrWMYxSOaN54GDNjK7fC9OUHnMb3eC
	wI8Ub6NNEQSnujuB4H4PsFAlAyxkCPjVUp4rBj5Oa5yNAYx+Ppd2ws8mfV2yINxv
	3nEneFCK217FJR20tOOYPjEoo/zE8CGAWp5kYMdy4xGBTMce6lQ1M4mbbFL2Mn7X
	eZfdO2at4UrYYOdbH3Kw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2ea251q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 19:02:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JJ2HK9000577
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 19:02:17 GMT
Received: from [10.110.10.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 12:02:14 -0700
Message-ID: <2fa9a262-de60-2c1e-9ac3-1e478ec65bb8@quicinc.com>
Date: Tue, 19 Mar 2024 12:02:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/dp: Clarify that wait_hpd_asserted() is not optional
 for panels
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson
	<dianders@chromium.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        Mikko
 Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ankit Nautiyal
	<ankit.k.nautiyal@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, David Airlie
	<airlied@gmail.com>,
        Imre Deak <imre.deak@intel.com>, Jani Nikula
	<jani.nikula@intel.com>,
        Maxime Ripard <mripard@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240319111432.1.I521dad0693cc24fe4dd14cba0c7048d94f5b6b41@changeid>
 <CAA8EJpq-NjmYkWHAVsuP5jA_Z7Xx0jCiqEDgU-0ni9BCg7Opuw@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJpq-NjmYkWHAVsuP5jA_Z7Xx0jCiqEDgU-0ni9BCg7Opuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -tVAJIW7Oc6ZEn_8xtyzaDPHEbKWtYIq
X-Proofpoint-GUID: -tVAJIW7Oc6ZEn_8xtyzaDPHEbKWtYIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190145



On 3/19/2024 11:35 AM, Dmitry Baryshkov wrote:
> On Tue, 19 Mar 2024 at 20:15, Douglas Anderson <dianders@chromium.org> wrote:
>>
>> In response to my patch removing the "wait for HPD" logic at the
>> beginning of the MSM DP transfer() callback [1], we had some debate
>> about what the "This is an optional function" meant in the
>> documentation of the wait_hpd_asserted() callback. Let's clarify.
>>
>> As talked about in the MSM DP patch [1], before wait_hpd_asserted()
>> was introduced there was no great way for panel drivers to wait for
>> HPD in the case that the "built-in" HPD signal was used. Panel drivers
>> could only wait for HPD if a GPIO was used. At the time, we ended up
>> just saying that if we were using the "built-in" HPD signal that DP
>> AUX controllers needed to wait for HPD themselves at the beginning of
>> their transfer() callback. The fact that the wait for HPD at the
>> beginning of transfer() was awkward/problematic was the whole reason
>> wait_hpd_asserted() was added.
>>
>> Let's make it obvious that if a DP AUX controller implements
>> wait_hpd_asserted() that they don't need a loop waiting for HPD at the
>> start of their transfer() function. We'll still allow DP controllers
>> to work the old way but mark it as deprecated.
>>
>> [1] https://lore.kernel.org/r/20240315143621.v2.3.I535606f6d4f7e3e5588bb75c55996f61980183cd@changeid
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>> I would consider changing the docs to say that implementing
>> wait_hpd_asserted() is actually _required_ for any DP controllers that
>> want to support eDP panels parented on the DP AUX bus. The issue is
>> that one DP controller (tegra/dpaux.c, found by looking for those that
>> include display/drm_dp_aux_bus.h) does populate the DP AUX bus but
>> doesn't implement wait_hpd_asserted(). I'm actually not sure how/if
>> this work on tegra since I also don't see any delay loop for HPD in
>> tegra's transfer() callback. For now, I've left wait_hpd_asserted() as
>> optional and described the old/deprecated way things used to work
>> before wait_hpd_asserted().
>>
>>   include/drm/display/drm_dp_helper.h | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
>> index a62fcd051d4d..b170efa1f5d2 100644
>> --- a/include/drm/display/drm_dp_helper.h
>> +++ b/include/drm/display/drm_dp_helper.h
>> @@ -422,7 +422,13 @@ struct drm_dp_aux {
>>           * @wait_hpd_asserted: wait for HPD to be asserted
>>           *
>>           * This is mainly useful for eDP panels drivers to wait for an eDP
>> -        * panel to finish powering on. This is an optional function.
>> +        * panel to finish powering on. It is optional for DP AUX controllers
>> +        * to implement this function but required for DP AUX endpoints (panel
>> +        * drivers) to call it after powering up but before doing AUX transfers.
>> +        * If a DP AUX controller does not implement this function then it
>> +        * may still support eDP panels that use the AUX controller's built-in
>> +        * HPD signal by implementing a long wait for HPD in the transfer()
>> +        * callback, though this is deprecated.
> 
> It doesn't cover a valid case when the panel driver handles HPD signal
> on its own.
> 

This doc is only for wait_for_hpd_asserted(). If panel driver handles 
HPD signal on its own, this will not be called. Do we need a doc for that?

>>           *
>>           * This function will efficiently wait for the HPD signal to be
>>           * asserted. The `wait_us` parameter that is passed in says that we
>> --
>> 2.44.0.291.gc1ea87d7ee-goog
>>
> 
> 

