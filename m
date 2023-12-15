Return-Path: <linux-kernel+bounces-1127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F142814AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A4C2868EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5024036AE3;
	Fri, 15 Dec 2023 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YszneM0I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B136AE9;
	Fri, 15 Dec 2023 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFCWNg6016704;
	Fri, 15 Dec 2023 14:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tO1B3XpYtxcwM9eXmTzeGrDkk113ZhQQlZKUmP51M40=; b=Ys
	zneM0IrQNkc8pGMGZokS/jcHSYzU1MYx9o5vQSTz5bpZBZKhwYysE8sVlrFH39UQ
	lVvuB1/20mCx4pBjhIFtDVbludTa35Do3bo/6Z37rML86gG/aWMYeichSEUECYMK
	eZ3NOnLWfMbLZ9JFf9uB5j+jBnHUP6iwdqnLXCCY9nViENIbrV6S+WhEJxOPXM9V
	BtY9HsZyF4AvOJr6olfEcjoyEqAVsHajgq+pAFfNghBGPnTXkvfCJnYS/cLOY15D
	UszYdeRkAzSSE/fceD+uWYq0X9JpkuotSS/hnTVMNf2aQ2X4l5HDBJV1wtO6qKAi
	yPmYGunW1vqEpbJr1ITg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hqch6n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 14:44:15 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFEiFWg004516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 14:44:15 GMT
Received: from [10.216.43.184] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 06:44:12 -0800
Message-ID: <f9231017-0c4c-6ddc-91e8-92dcc0ea5b9e@quicinc.com>
Date: Fri, 15 Dec 2023 20:14:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 0/4] Misc SCM driver changes
Content-Language: en-US
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1698945247-16033-1-git-send-email-quic_mojha@quicinc.com>
 <653abe51-cc6a-7bb0-6a10-6dc33389cb68@quicinc.com>
In-Reply-To: <653abe51-cc6a-7bb0-6a10-6dc33389cb68@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RQqkOauX4Ue_JGBgtyyLzPZjIKzjFJ0Y
X-Proofpoint-GUID: RQqkOauX4Ue_JGBgtyyLzPZjIKzjFJ0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150101



On 11/28/2023 1:20 AM, Mukesh Ojha wrote:
> Bjorn,
> 
> Any comments on these patches?

Just a reminder., in case it got missed.

-Mukesh

> 
> -Mukesh
> 
> On 11/2/2023 10:44 PM, Mukesh Ojha wrote:
>> First two changes changes are needed to enable download mode on
>> chipset like IPQ9574 and IPQ5332 SoCs as for these targets others
>> bits in download mode registers are used for different purpose
>> and earlier kernel code was mistakenly overwrite the other bits.
>>
>> First three changes(1/4-3/4) are SCM driver specific while 4/4 from
>> pinctrl try to use the introduced API(1/3).
>>
>> Changes from v9: 
>> https://lore.kernel.org/lkml/1698648967-974-1-git-send-email-quic_mojha@quicinc.com/
>>   - Added 3/4 new patch.
>>   - commit subject modification.
>>
>> Change from v8: 
>> https://lore.kernel.org/lkml/1698235506-16993-1-git-send-email-quic_mojha@quicinc.com/
>>   - Introduce enum for dload mode constants as per suggestion from 
>> [Elliot].
>>   - Rebased on linux-next.
>>
>> Changes from v7: 
>> https://lore.kernel.org/lkml/1696440338-12561-1-git-send-email-quic_mojha@quicinc.com/
>>   - Rebased it on next-20231025.
>>   - Added reviewed-by tag and take care of comment made about
>>     commit text should be in imperative mode.
>>   - Modified the name of the API to qcom_scm_io_rmw() as per suggestion
>>     made by [Dmitry]
>>   - Moved spinlock inside qcom_scm structure.
>>   - Corrected the patch order as per subsystem SCM first then pinctrl.
>>
>> Change from 
>> minidump-v5(13/17-15/17):https://lore.kernel.org/lkml/1694429639-21484-1-git-send-email-quic_mojha@quicinc.com/ - Removed mistakenly added macros.
>>     
>> https://lore.kernel.org/lkml/9da888dc-401a-4cbb-b616-b4654fa79e35@quicinc.com/
>>   - Added Acked-by tag from Linus.w to 2/3.
>> Change from 
>> minidump-v5(13/17-15/17):https://lore.kernel.org/lkml/1694429639-21484-1-git-send-email-quic_mojha@quicinc.com/
>>   - Removed mistakenly added macros.
>>     
>> https://lore.kernel.org/lkml/9da888dc-401a-4cbb-b616-b4654fa79e35@quicinc.com/
>>   - Added Acked-by tag from Linus.w to 2/3.
>>
>> Changes in v6: 
>> https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/
>>   - Rebased it on latest tag available on linux-next
>>   - Added missed Poovendhan sign-off on 15/17 and tested-by tag from
>>     Kathiravan. Thanks to him for testing and reminding me of missing 
>> sign-off.
>>   - Addressed comments made on dload mode patch v6 version
>>
>> Changes in v5: 
>> https://lore.kernel.org/lkml/1680017869-22421-1-git-send-email-quic_mojha@quicinc.com/
>>    - Tried to fix the issue reported by kernel test robot
>>      https://lore.kernel.org/lkml/202303280535.acb66sQT-lkp@intel.com/
>>
>>    - Applied some of the improvement suggested by [Bjorn.andersson]
>>
>>      . Dropped 'both' instead support full,mini or mini,full for 
>> setting download
>>      mode to collect both minidump and full dump.
>>
>>      . logging improvement.
>>
>> Changes in v4: 
>> https://lore.kernel.org/lkml/1679935281-18445-1-git-send-email-quic_mojha@quicinc.com/
>>    - val should be shifted within the function [srinivas.kandagatla]
>>      i.e new = (old & ~mask) | (val << ffs(mask) - 1);
>>    - Added Acked-by [linus.walleij] on pinctrl change.
>>
>> Changes in v3 : 
>> https://lore.kernel.org/lkml/1679070482-8391-1-git-send-email-quic_mojha@quicinc.com/
>>   - Removed [1] from the series and sent as a separate patch[2], 
>> although this series
>>     should be applied on top [2].
>>    [1] 
>> https://lore.kernel.org/lkml/1677664555-30191-2-git-send-email-quic_mojha@quicinc.com/
>>    [2] 
>> https://lore.kernel.org/lkml/1678979666-551-1-git-send-email-quic_mojha@quicinc.com/
>>   - Introduce new exported symbol on suggestion from 
>> [srinivas.kandagatla]
>>   - Use the symbol from drivers/pinctrl/qcom/pinctrl-msm.c.
>>   - Addressed comment given by [dmitry.baryshkov]
>>   - Converted non-standard Originally-by to Signed-off-by.
>>
>> Changes in v2: 
>> https://lore.kernel.org/lkml/1677664555-30191-1-git-send-email-quic_mojha@quicinc.com/
>>   - Addressed comment made by [bjorn]
>>   - Added download mask.
>>   - Passed download mode as parameter
>>   - Accept human accepatable download mode string.
>>   - enable = !!dload_mode
>>   - Shifted module param callback to somewhere down in
>>     the file so that it no longer need to know the
>>     prototype of qcom_scm_set_download_mode()
>>   - updated commit text.
>>
>>
>> Mukesh Ojha (4):
>>    firmware: qcom: scm: provide a read-modify-write function
>>    firmware: qcom: scm: Modify only the download bits in TCSR register
>>    firmware: qcom: scm: Rework dload mode availability check
>>    pinctrl: qcom: Use qcom_scm_io_rmw() function
>>
>>   drivers/firmware/qcom/qcom_scm.c       | 50 
>> ++++++++++++++++++++++++++++------
>>   drivers/pinctrl/qcom/pinctrl-msm.c     | 10 +++----
>>   include/linux/firmware/qcom/qcom_scm.h |  1 +
>>   3 files changed, 47 insertions(+), 14 deletions(-)
>>

