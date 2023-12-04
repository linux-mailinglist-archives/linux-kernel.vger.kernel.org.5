Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03AD803C10
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjLDRv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjLDRv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:51:57 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBBE116;
        Mon,  4 Dec 2023 09:52:01 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4EAeJo013526;
        Mon, 4 Dec 2023 17:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rrC/JHJHrbAxQwJiT2+uK2DxsUMd+VQmbv8KvsLwxIM=;
 b=LXD1xi5OODT9HzciMWyV8YWcM3kHtXlsAiw7VYyiEPzXYUx98wnTZ/Xl+HZ6+dJyi/1F
 9sBtLQdWvGXdpMQIVv0pM0li8T6/RoNpAzdYbAZfN168GUVBWp/Wh6jFGvDKJgSF4Is/
 xwHURhhsH8bkD267qaXX98+vHuug8CaODGVdR3yXQyHIyw8iTujbRFZ+ikCmkfZ6DXYy
 Uc3RRp7aHSuzF52OCtz5pKRzDU2jTDgG0mFosuHqGMgd6r0jUvp5gh3rQHCpVJHZw5mv
 swpIjsSFihRbUtCB6qFpxj+Mre3jBqM5IBH/dm6wgMsM/N7E6THgyd+cZoR4AzneXJsR NA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usektrxua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 17:51:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4HpPMT008291
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 17:51:25 GMT
Received: from [10.110.73.134] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 09:51:24 -0800
Message-ID: <44a3fbd4-44fb-0a39-65be-e680e03b1b6e@quicinc.com>
Date:   Mon, 4 Dec 2023 09:51:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: (subset) [PATCH RFC v7 00/10] Support for Solid Fill Planes
Content-Language: en-US
To:     Simon Ser <contact@emersion.fr>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        <ppaalanen@gmail.com>, <laurent.pinchart@ideasonboard.com>,
        <sebastian.wick@redhat.com>, <ville.syrjala@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <wayland-devel@lists.freedesktop.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sebastian Wick <sebastian@sebastianwick.net>
References: <20231027-solid-fill-v7-0-780188bfa7b2@quicinc.com>
 <170155324921.2215646.4829699354481827834.b4-ty@linaro.org>
 <OiX1EToyQ0JBECS-Vs6IOw1vqLTt42PYkTlTCBhsPUi-VXC2UoLjkRfEW-OFucxsTqz93Q3IIXZZ3Lw_Lqs1dFt4YbuFSUGrKfDPnnKDCbw=@emersion.fr>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <OiX1EToyQ0JBECS-Vs6IOw1vqLTt42PYkTlTCBhsPUi-VXC2UoLjkRfEW-OFucxsTqz93Q3IIXZZ3Lw_Lqs1dFt4YbuFSUGrKfDPnnKDCbw=@emersion.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z6vgWQwTVtpt83bTDVFYrfNANLbkn73Z
X-Proofpoint-ORIG-GUID: Z6vgWQwTVtpt83bTDVFYrfNANLbkn73Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_17,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040137
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon

On 12/3/2023 4:15 AM, Simon Ser wrote:
> On Saturday, December 2nd, 2023 at 22:41, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> 
>> On Fri, 27 Oct 2023 15:32:50 -0700, Jessica Zhang wrote:
>>
>>> Some drivers support hardware that have optimizations for solid fill
>>> planes. This series aims to expose these capabilities to userspace as
>>> some compositors have a solid fill flag (ex. SOLID_COLOR in the Android
>>> hardware composer HAL) that can be set by apps like the Android Gears
>>> test app.
>>>
>>> In order to expose this capability to userspace, this series will:
>>>
>>> [...]
>>
>>
>> Applied to drm-misc-next, thanks!
> 
> Where are the IGT and userspace for this uAPI addition?

Yes, we made IGT changes to test and validate this. We will post them on 
the IGT dev list shortly and CC you.

We do not have a compositor change yet for this as we primarily used IGT 
to validate this.

Can we re-try to land this once IGT changes are accepted?

Thanks

Abhinav
