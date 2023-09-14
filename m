Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9137A02C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjINLfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjINLfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:35:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717C3CC3;
        Thu, 14 Sep 2023 04:35:44 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EAoVTL026571;
        Thu, 14 Sep 2023 11:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RjZZyJ/Se3E0TQ3jLCr+da6k3IlxB/LfHfaGLcvsi7I=;
 b=B9+4TZrto6zNGoK7VetoALXrY2WytvaNYfmSUgd4J4vT/wCoitGPSg/AhLPT0pyudrGR
 YtCOG3M6HX3Npq/eL9K8I6Otk+B65X+Lr1YUmoL/Pnb6QF0Ec+ZDD1hVnW1hc9yLZgSB
 QBxukN0VMIl4O2tYu18d5Q6KzzY2nfE9MtkXiHJaxVrhagsjg1QMtUgF4QJ/K0g7RH0D
 37Pb69Pk+OErmnynrmTH7Da0ZTPjRdxCLtFs66F2NxfwFiVxgYGC0oTJiCDcqppidVY9
 OwNFmfGW0CpvQ6IhEYEClvHJTQWl24EOtUY2xFOi42YH1ux5slte8TUa9Wad/UyTuf2C Jw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3h0dj9bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 11:35:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EBZabK032324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 11:35:36 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 04:35:32 -0700
Message-ID: <8d95d169-452f-e426-938f-ccadf26de9ca@quicinc.com>
Date:   Thu, 14 Sep 2023 17:05:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 6/6] scsi: ufs: ufs-sysfs: Introduce UFS power info sysfs
 nodes
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, <mani@kernel.org>,
        <quic_nguyenb@quicinc.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        "Bean Huo" <beanhuo@micron.com>, Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-7-git-send-email-quic_cang@quicinc.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <1694411968-14413-7-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I3NxTihUEE4BksUB7IsrAuudxKQSsCyP
X-Proofpoint-GUID: I3NxTihUEE4BksUB7IsrAuudxKQSsCyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=967 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 11:29 AM, Can Guo wrote:
> Having UFS power info available in sysfs makes it easier to tell the state
> of the link during runtime considering we have a bounch of power saving
> features and various combinations for backward compatiblity.

Please fix spelling mistake *bounch -> bunch
> 
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>   Documentation/ABI/testing/sysfs-driver-ufs | 48 ++++++++++++++++++++++++++----
>   1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
> index 0c7efaf..25169f2 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -1214,12 +1214,50 @@ Description:	This file shows the average latency (in micro seconds) of write
>   
>   		The file is read only.
>   
> -What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_sum
> -What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_sum
> -Date:		January 2021
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/gear
> +What:		/sys/bus/platform/devices/*.ufs/power_info/gear
> +Date:		September 2023
>   Contact:	Can Guo <quic_cang@quicinc.com>
> -Description:	This file shows the total latency (in micro seconds) of write
> -		requests after monitor gets started.
> +Description:	This file shows the gear of UFS link.
> +
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/lane
> +What:		/sys/bus/platform/devices/*.ufs/power_info/lane
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows how many lanes are enabled on the UFS link.
> +
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/mode
> +What:		/sys/bus/platform/devices/*.ufs/power_info/mode
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the power mode of UFS link.
> +
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/rate
> +What:		/sys/bus/platform/devices/*.ufs/power_info/rate
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the high speed rate of UFS link.
> +
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/dev_pm
> +What:		/sys/bus/platform/devices/*.ufs/power_info/dev_pm
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the UFS device power mode, i.e., the power mode
> +		set to UFS device via the Start Stop Unit command.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/link_state
> +What:		/sys/bus/platform/devices/*.ufs/power_info/link_state
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the the state of the UFS link.
>   
>   		The file is read only.
>   

Thanks,
nitin
