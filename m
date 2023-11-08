Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157447E51EA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343793AbjKHIYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjKHIYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:24:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23731170A;
        Wed,  8 Nov 2023 00:24:19 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88O3dR017572;
        Wed, 8 Nov 2023 08:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=63wL2OLhSylIIhNNHXSlq/q1YxF1HwJ3SnILw67DNdM=;
 b=UUssv799G/qwsS7tPKn1BftXZmJ2uiJaWeJIePC57YPR/yRIDCyUpt85AlhWXCw7v6Q2
 0d93W/G22TozVCC2ALaLnR4CsriMZT1b9HoqtHtkyukF5tN4rCz0+8XfOxjbHUSynI1l
 6fcemYGaeIELAv236+ZDu5x69JCn2ukfjX2Sx/L8QSR3G1u1vrJEAdjYNgV0YQ+KXsuB
 jb/K2y6xWXl0Dp0sx1B/YjlFmkREb0ul3x5SOF4CY10j47of/zsM6wDfWUz/JgQGdCmd
 z066Abe+wbhBFC2L0WI+WCIEiGrfLGcHnLHamXY8kqhJxIccgKqAHEEbh/EdYSMz+Zas gQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7wt28yt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 08:24:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A88O1VO023310
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 08:24:01 GMT
Received: from [10.253.34.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 00:23:58 -0800
Message-ID: <f3bb9cf7-e57d-af5d-6516-9773ccb5dd1c@quicinc.com>
Date:   Wed, 8 Nov 2023 16:23:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/7] scsi: ufs: ufs-qcom: Allow the first init start
 with the maximum supported gear
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <cang@qti.qualcomm.com>
CC:     <bvanassche@acm.org>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-4-git-send-email-cang@qti.qualcomm.com>
 <20231108052310.GC3296@thinkpad>
 <49b331dc-37eb-6e26-f701-c83187a30788@quicinc.com>
In-Reply-To: <49b331dc-37eb-6e26-f701-c83187a30788@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: R1EaAxz5sd2FwdBNje6BGRwTGfsS8Wfb
X-Proofpoint-GUID: R1EaAxz5sd2FwdBNje6BGRwTGfsS8Wfb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 11/8/2023 4:21 PM, Can Guo wrote:
> Hi Mani,
> 
> On 11/8/2023 1:23 PM, Manivannan Sadhasivam wrote:
>> On Mon, Nov 06, 2023 at 08:46:09PM -0800, Can Guo wrote:
>>> From: Can Guo <quic_cang@quicinc.com>
>>>
>>> During host driver init, the phy_gear is set to the minimum supported 
>>> gear
>>> (HS_G2). Then, during the first power mode change, the negotiated 
>>> gear, say
>>> HS-G4, is updated to the phy_gear variable so that in the second init 
>>> the
>>> updated phy_gear can be used to program the PHY.
>>>
>>> But the current code only allows update the phy_gear to a higher 
>>> value. If
>>> one wants to start the first init with the maximum support gear, say 
>>> HS-G4,
>>> the phy_gear is not updated to HS-G3 if the device only supports HS-G3.
>>>
>>
>> Can you elaborate when this can happen? AFAICS, there are 3 
>> possibilities of
>> initial phy gear with this series:
>>
>> 1. If ufshc is < 5.0, then G2 will be used.
>> 2. If ufshc is >= 5.0 and if the version is populated in register, 
>> then that
>> gear will be used. Most likely that gear can be G4/G5 depending on the 
>> device
>> connected.
>> 3. If ufshc is >=5.0 and version is not populated, then G4 will be used.
I think this made you confused, in case #3, HS-G5 is used as initial PHY 
gear, not G4 (in the last patch in this series).

Thanks,
Can Guo.
>>
>> In all the above cases, I do not see any necessity to switch the phy gear
>> setting to lower one while scaling. Since the gears are backwards 
>> compatible,
>> we always use one phy gear sequence. Moreover, we only have 2 init 
>> sequences.
>>
>> Please correct me if I'm missing anything.
>>
>> - Mani
> In the next patch, I am setting the initial PHY gear to max HS gear read
> from UFS host cap register, so that we don't need to keep updating the 
> initial value for host->phy_gear for different HW versions in future. 
> FYI, for HW ver 5 and 6, it is HS-G5. In future, the max gear might 
> become HS-G6 or higher on newer HW verions.
> 
> I the case #3, if HS-G5 is set to host->phy_gear, the first init uses 
> HS-G5, then after negotiation if the agreed gear is HS-G4, we need to 
> update host->phy_gear to HS-G4 (a lower value) such that we use a power 
> saving PHY gear settings during the 2nd init.
> 
> If the commit message is making you confused, I can update it in next 
> version. Please let me if I made any mistakes here.
> 
> Thanks,
> Can Guo.
