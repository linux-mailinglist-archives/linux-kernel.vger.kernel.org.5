Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477897DEA76
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348221AbjKBBx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBBxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:53:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2856311B;
        Wed,  1 Nov 2023 18:53:49 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A21D2qD025153;
        Thu, 2 Nov 2023 01:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9ANE3tFi/dfKW4H8ZBjSQq5eHTSVmT6YEmJD1/CxvdE=;
 b=gvNSJxYKEcAe/srU9+b7hIoZhInsG1KdwASHfz6TCInTjW+eyiRRbv+TLrEdZLfrbU8V
 k91vEDuMIFWK50lHpau9e3z3KZdewNTjfbPFIWa2nNtSfzDOnDbzL6BzJtKeajeIw/z3
 IZy7h/4g+YYCrMX/uitBz5drssbGcIoDqZB68IfSXv+Ms3mmLay9cXYEEUzLsPYclATN
 8qrJHx2n5wqTOcr0x+0ICxtyJCWajRbls/JdEn+y1H6T4u/iF1UDj72++uW6Rin2xVt0
 vezB8Bpf4RVu8GTeF/xLkOLc7bWGZEn0f4IsZae8nK3Z5lk2v3Af3IxUlVA4WXRZq7g3 +g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3kactaer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 01:50:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A21nwJj023142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Nov 2023 01:49:58 GMT
Received: from [10.253.74.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 1 Nov
 2023 18:49:55 -0700
Message-ID: <862aab51-5a71-d8f8-17d8-cb5bff8115a4@quicinc.com>
Date:   Thu, 2 Nov 2023 09:49:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] scsi: ufs: ufs-sysfs: Expose UFS power info
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <bvanassche@acm.org>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1698811243-5024-1-git-send-email-quic_cang@quicinc.com>
 <20231101051204.GC2897@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231101051204.GC2897@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MyNRLrTNpEU1sbr5zpW-dJ8Ax5Dg3n4E
X-Proofpoint-GUID: MyNRLrTNpEU1sbr5zpW-dJ8Ax5Dg3n4E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020013
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 11/1/2023 1:12 PM, Manivannan Sadhasivam wrote:
> On Tue, Oct 31, 2023 at 09:00:34PM -0700, Can Guo wrote:
>> Having UFS power info available in sysfs makes it easier to tell the state
>> of the link during runtime considering we have a bunch of power saving
>> features and various combinations for backward compatibility.
>>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Just a nitpick below. With that addressed,
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
>> ---
>>
>> v2 -> v3:
>> 1. For mode/gear/rate/dev_pm/link_status, print texts instead of numbers
>> 2. Removed number<->text explanations for mode/rate/gear/dev_pm/link_status in Documentation/ABI/testing/sysfs-driver-ufs
>>
>> v1 -> v2:
>> 1. Incorporated comments from Bart, Nitin and Mani.
>> 2. Added explanations for lane/mode/rate/gear/dev_pm/link_status in Documentation/ABI/testing/sysfs-driver-ufs
>>
>> ---
>>   Documentation/ABI/testing/sysfs-driver-ufs |  49 ++++++++++++
>>   drivers/ufs/core/ufs-sysfs.c               | 120 +++++++++++++++++++++++++++++
>>   include/ufs/unipro.h                       |   4 +-
>>   3 files changed, 171 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
>> index 0c7efaf..b73067b 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-ufs
>> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
>> @@ -1223,6 +1223,55 @@ Description:	This file shows the total latency (in micro seconds) of write
>>   
>>   		The file is read only.
>>   
>> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/lane
>> +What:		/sys/bus/platform/devices/*.ufs/power_info/lane
>> +Date:		September 2023
>> +Contact:	Can Guo <quic_cang@quicinc.com>
>> +Description:	This file shows how many lanes are enabled on the UFS link,
>> +		i.e., an output 2 means UFS link is operating with 2 lanes.
>> +
>> +		The file is read only.
>> +
>> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/mode
>> +What:		/sys/bus/platform/devices/*.ufs/power_info/mode
>> +Date:		September 2023
>> +Contact:	Can Guo <quic_cang@quicinc.com>
>> +Description:	This file shows the PA power mode of UFS.
>> +
>> +		The file is read only.
>> +
>> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/rate
>> +What:		/sys/bus/platform/devices/*.ufs/power_info/rate
>> +Date:		September 2023
>> +Contact:	Can Guo <quic_cang@quicinc.com>
>> +Description:	This file shows the speed rate of UFS link.
>> +
>> +		The file is read only.
>> +
>> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/gear
>> +What:		/sys/bus/platform/devices/*.ufs/power_info/gear
>> +Date:		September 2023
>> +Contact:	Can Guo <quic_cang@quicinc.com>
>> +Description:	This file shows the gear of UFS link.
>> +
>> +		The file is read only.
>> +
>> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/dev_pm
>> +What:		/sys/bus/platform/devices/*.ufs/power_info/dev_pm
>> +Date:		September 2023
>> +Contact:	Can Guo <quic_cang@quicinc.com>
>> +Description:	This file shows the UFS device power mode.
>> +
>> +		The file is read only.
>> +
>> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/link_state
>> +What:		/sys/bus/platform/devices/*.ufs/power_info/link_state
>> +Date:		September 2023
>> +Contact:	Can Guo <quic_cang@quicinc.com>
>> +Description:	This file shows the state of UFS link.
>> +
>> +		The file is read only.
>> +
>>   What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_presv_us_en
>>   What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_presv_us_en
>>   Date:		June 2020
>> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
>> index c959064..b8b5dd1 100644
>> --- a/drivers/ufs/core/ufs-sysfs.c
>> +++ b/drivers/ufs/core/ufs-sysfs.c
>> @@ -7,9 +7,56 @@
>>   #include <asm/unaligned.h>
>>   
>>   #include <ufs/ufs.h>
>> +#include <ufs/unipro.h>
>>   #include "ufs-sysfs.h"
>>   #include "ufshcd-priv.h"
>>   
>> +static const char *ufshcd_ufs_pa_pwr_mode_to_string(enum ufs_pa_pwr_mode mode)
> I don't think it is necessary to have the ufshcd_ prefix.

Done


Thanks,

Can Guo.

