Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB827DC58D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjJaExz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjJaExx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:53:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F225C9;
        Mon, 30 Oct 2023 21:53:51 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V43Lc5004191;
        Tue, 31 Oct 2023 04:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lO+MYintezktq3tY481g/O/zsk5Mk7M6YweYnpOYHkQ=;
 b=nGtpwhGRnZcp4tG1NcTB/1LKb7JzvWyVIIFkyzEsjbBTwQoS5mThpzQCB/mVmmItn+5h
 1bDVIdDQW73cAmPP00ZhUfMnObbzPSOYcJk6aks6kjCYhOyyHxYAWZdd0RCGNncxXtwl
 fFmmq1K2fRZNgec+A42fbE1Dtb704tD4dHNQ6eKr5zr0hVKPS1LBUTxM+I/QG/U3c0kq
 W7IK+X9QfZds7kUdSaVVmfdKIUZzMoQMVUtEIibm8CKNwZPL5wJuwJ4SLx7EzZtM9nXr
 2lP17Wsa3cjaYNanFgAVa0CJ9qkHNyUiKwSYR9lDZv8kItg9IEATKX/n7Zj6RQQ9/u5U 8Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u280jth9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 04:53:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V4rhjn000447
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 04:53:44 GMT
Received: from [10.253.74.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 21:53:41 -0700
Message-ID: <c035a67e-d0f2-f235-ea75-36cb31dc7e75@quicinc.com>
Date:   Tue, 31 Oct 2023 12:53:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/6] scsi: ufs: ufs-sysfs: Introduce UFS power info sysfs
 nodes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <mani@kernel.org>,
        <quic_nguyenb@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, Bean Huo <beanhuo@micron.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-7-git-send-email-quic_cang@quicinc.com>
 <de7e76f8-5ed6-4de0-8084-24e220deb4b3@acm.org>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <de7e76f8-5ed6-4de0-8084-24e220deb4b3@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: os9br75BmD1fCnsB0TtfR1fOFueiQpNf
X-Proofpoint-ORIG-GUID: os9br75BmD1fCnsB0TtfR1fOFueiQpNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=430
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310036
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 9/18/2023 11:36 PM, Bart Van Assche wrote:
> On 9/10/23 22:59, Can Guo wrote:
>> Having UFS power info available in sysfs makes it easier to tell the 
>> state
>> of the link during runtime considering we have a bounch of power saving
>> features and various combinations for backward compatiblity.
>
> bounch -> bunch
> compatiblity -> compatibility
>
> Additionally, please combine this patch with patch 5/6 into a single 
> patch.

Sure

>
>> -What: /sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_sum
>> -What: /sys/bus/platform/devices/*.ufs/monitor/write_req_latency_sum
>> -Date:        January 2021
>
> Has the above information perhaps been removed by accident?
Yes, my bad, good catch.
>
>> +What: /sys/bus/platform/drivers/ufshcd/*/power_info/gear
>> +What:        /sys/bus/platform/devices/*.ufs/power_info/gear
>> +Date:        September 2023
>>   Contact:    Can Guo <quic_cang@quicinc.com>
>> -Description:    This file shows the total latency (in micro seconds) 
>> of write
>> -        requests after monitor gets started.
>> +Description:    This file shows the gear of UFS link.
>> +
>> +        The file is read only.
>
> Please explain what "gear" means and also what the unit is of the 
> numbers reported via this sysfs attribute.
Sure
>
>> +What: /sys/bus/platform/drivers/ufshcd/*/power_info/mode
>> +What:        /sys/bus/platform/devices/*.ufs/power_info/mode
>> +Date:        September 2023
>> +Contact:    Can Guo <quic_cang@quicinc.com>
>> +Description:    This file shows the power mode of UFS link.
>> +
>> +        The file is read only.
>
> Please document the meaning of the numbers reported via this sysfs 
> attribute.
Sure
>
>> +What: /sys/bus/platform/drivers/ufshcd/*/power_info/rate
>> +What:        /sys/bus/platform/devices/*.ufs/power_info/rate
>> +Date:        September 2023
>> +Contact:    Can Guo <quic_cang@quicinc.com>
>> +Description:    This file shows the high speed rate of UFS link.
>> +
>> +        The file is read only.
>
> Please document the unit of the numbers reported via this sysfs 
> attribute.
Sure
>
>> +What: /sys/bus/platform/drivers/ufshcd/*/power_info/dev_pm
>> +What:        /sys/bus/platform/devices/*.ufs/power_info/dev_pm
>> +Date:        September 2023
>> +Contact:    Can Guo <quic_cang@quicinc.com>
>> +Description:    This file shows the UFS device power mode, i.e., the 
>> power mode
>> +        set to UFS device via the Start Stop Unit command.
>
> Please document the meaning of the numbers reported through this sysfs 
> attribute.
Sure
>
>> +What: /sys/bus/platform/drivers/ufshcd/*/power_info/link_state
>> +What: /sys/bus/platform/devices/*.ufs/power_info/link_state
>> +Date:        September 2023
>> +Contact:    Can Guo <quic_cang@quicinc.com>
>> +Description:    This file shows the the state of the UFS link.
>
> Please document the meaning of the numbers reported through this sysfs 
> attribute.

Sure


Thanks,

Can Guo.

>
> Thanks,
>
> Bart.
