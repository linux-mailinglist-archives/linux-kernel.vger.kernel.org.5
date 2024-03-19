Return-Path: <linux-kernel+bounces-107895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005FE880332
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323EE281CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0551CD24;
	Tue, 19 Mar 2024 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OOlc0kH1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87E1804A;
	Tue, 19 Mar 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868418; cv=none; b=XnzxLo8HJYOUT7biQ8ZcNTW/ZAUsjhLXawDD85Smt8WBiYHOlZTRbpw7KxuQFq0VGhMxJN2aDMBcwASM/5qYnpx8zINlv9eCuS3nbNXgzeZVAJPhkg4lIrra3TM0MeF/dhlcgbM50o/KqbyBUBFo4DyhNpi8o0JZyQDxdaOHA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868418; c=relaxed/simple;
	bh=bt5t14NGx2mSplWgWpZv1cueQRqQUSBXxp5QztEDJys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AEmloiqCgb9X5PamaCLYQdiIvYOx230CfjZX5jag5QwumfC83RCzkSPmzTu/CFsF3RfqjpOFkZwp+JPI0gyTPPH0MulpuEWPHsD1g5EURc1+Ud52hf64oTy378yT08noj3IzA09cYjGnubj43MRpZBi+c7slvi8GXcVQqBJdyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OOlc0kH1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JEOK5W026370;
	Tue, 19 Mar 2024 17:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DVajDL0mMFuMGHUmQAUTr/9jd7cy2E/up+JlJE4GOkA=; b=OO
	lc0kH1E9DL8oASPjTxZohT2BSroqPBzZBKs756wwdgTGoBI4YHkt7AkfvqS+5937
	WEaZZLXZFlHQ/AzjGckMTuMXxBFeFF/ttKUhCQckfC8jjIXEV+LXDSW+e/3Sgl6Q
	MSW37FMt4Nr9kW3QWiylYRHmTq3TGi4L6FF5QhuK+OXIQgrmFIsUo62D6P/8X3oI
	KC7cbGq4UlyHaBDwS4hqQkl1kpq9ioOej+Yhg9CUcQNIyjVDXhIazwfVXNMUicPp
	dbYXvBAPhQCnXkyL8d9GT3c1tpuiKl7zUiz/NkCSZ5F2nP78s/WQzdiLIcqhWjWW
	6eUDdzxvGFgKJ33t40Ag==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy553hjaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 17:13:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JHDOmY019681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 17:13:24 GMT
Received: from [10.110.10.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 10:13:20 -0700
Message-ID: <d04711c1-6df0-f988-9227-2161f4109dd1@quicinc.com>
Date: Tue, 19 Mar 2024 10:13:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] drm/msm/dp: Delete the old 500 ms wait for eDP HPD
 in aux transfer
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Douglas Anderson <dianders@chromium.org>, Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        "Kuogee
 Hsieh" <quic_khsieh@quicinc.com>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>,
        Johan Hovold <johan@kernel.org>
References: <20240315213717.1411017-1-dianders@chromium.org>
 <20240315143621.v2.3.I535606f6d4f7e3e5588bb75c55996f61980183cd@changeid>
 <e2319b19-d999-24e7-48fa-bbc19bbfbeea@quicinc.com>
 <CAA8EJppau--vt3RLkH96K0SF2x-QGWz+5U8tErvLFDvz-GQN4Q@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJppau--vt3RLkH96K0SF2x-QGWz+5U8tErvLFDvz-GQN4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y40WFAlzZ4LzRLejn4_UZWtNJ39gUD7F
X-Proofpoint-ORIG-GUID: y40WFAlzZ4LzRLejn4_UZWtNJ39gUD7F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190128



On 3/18/2024 5:55 PM, Dmitry Baryshkov wrote:
> On Tue, 19 Mar 2024 at 02:19, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>> +bjorn, johan as fyi for sc8280xp
>>
>> On 3/15/2024 2:36 PM, Douglas Anderson wrote:
>>> Before the introduction of the wait_hpd_asserted() callback in commit
>>> 841d742f094e ("drm/dp: Add wait_hpd_asserted() callback to struct
>>> drm_dp_aux") the API between panel drivers and DP AUX bus drivers was
>>> that it was up to the AUX bus driver to wait for HPD in the transfer()
>>> function.
>>>
>>> Now wait_hpd_asserted() has been added. The two panel drivers that are
>>> DP AUX endpoints use it. See commit 2327b13d6c47 ("drm/panel-edp: Take
>>> advantage of wait_hpd_asserted() in struct drm_dp_aux") and commit
>>> 3b5765df375c ("drm/panel: atna33xc20: Take advantage of
>>> wait_hpd_asserted() in struct drm_dp_aux"). We've implemented
>>> wait_hpd_asserted() in the MSM DP driver as of commit e2969ee30252
>>> ("drm/msm/dp: move of_dp_aux_populate_bus() to eDP probe()"). There is
>>> no longer any reason for long wait in the AUX transfer() function.
>>> Remove it.
>>>
>>> NOTE: the wait_hpd_asserted() is listed as "optional". That means it's
>>> optional for the DP AUX bus to implement. In the case of the MSM DP
>>> driver we implement it so we can assume it will be called.
>>>
>>
>> How do we enforce that for any new edp panels to be used with MSM, the
>> panels should atleast invoke wait_hpd_asserted()?
>>
>> I agree that since MSM implements it, even though its listed as
>> optional, we can drop this additional wait. So nothing wrong with this
>> patch for current users including sc8280xp, sc7280 and sc7180.
>>
>> But, does there need to be some documentation that the edp panels not
>> using the panel-edp framework should still invoke wait_hpd_asserted()?
>>
>> Since its marked as optional, what happens if the edp panel driver,
>> skips calling wait_hpd_asserted()?
> 
> It is optional for the DP AUX implementations, not for the panel to be called.
> 

Yes, I understood that part, but is there anything from the panel side 
which mandates calling wait_hpd_asserted()?

Is this documented somewhere for all edp panels to do:

if (aux->wait_hpd_asserted)
	aux->wait_hpd_asserted(aux, wait_us);

>>
>> Now, since the wait from MSM is removed, it has a potential to fail.
>>
>>> ALSO NOTE: the wait wasn't actually _hurting_ anything and wasn't even
>>> causing long timeouts, but it's still nice to get rid of unneeded
>>> code. Specificaly it's not truly needed because to handle other DP
>>> drivers that can't power on as quickly (specifically parade-ps8640) we
>>> already avoid DP AUX transfers for eDP panels that aren't powered
>>> on. See commit 8df1ddb5bf11 ("drm/dp: Don't attempt AUX transfers when
>>> eDP panels are not powered").
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>    drivers/gpu/drm/msm/dp/dp_aux.c | 17 -----------------
>>>    1 file changed, 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
>>> index 75c51f3ee106..ecefd1922d6d 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
>>> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
>>> @@ -313,23 +313,6 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
>>>                goto exit;
>>>        }
>>>
>>> -     /*
>>> -      * For eDP it's important to give a reasonably long wait here for HPD
>>> -      * to be asserted. This is because the panel driver may have _just_
>>> -      * turned on the panel and then tried to do an AUX transfer. The panel
>>> -      * driver has no way of knowing when the panel is ready, so it's up
>>> -      * to us to wait. For DP we never get into this situation so let's
>>> -      * avoid ever doing the extra long wait for DP.
>>> -      */
>>> -     if (aux->is_edp) {
>>> -             ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog,
>>> -                                                             500000);
>>> -             if (ret) {
>>> -                     DRM_DEBUG_DP("Panel not ready for aux transactions\n");
>>> -                     goto exit;
>>> -             }
>>> -     }
>>> -
>>>        dp_aux_update_offset_and_segment(aux, msg);
>>>        dp_aux_transfer_helper(aux, msg, true);
>>>
> 
> 
> 

