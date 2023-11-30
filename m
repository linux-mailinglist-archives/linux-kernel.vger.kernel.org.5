Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04C47FFAFE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376312AbjK3TQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjK3TQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:16:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D961D48;
        Thu, 30 Nov 2023 11:16:40 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUCG3kZ027577;
        Thu, 30 Nov 2023 19:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Jlh8cq9Fw455GXkNRT/oFo0GJSLgxHYBs3ZA/MkaLqI=;
 b=fBtaEI51Tf9ex4H7fM4Pg69KZ7VpKG91Q7WYtC1JdSCMpxSdw89kOuIRmclSMSZTI4Mf
 uJ5Tmi4zPSqwBjy5KQxXTciEM8ziYu7IYHpA1ibrgEKS2GY4sO/ARVGZwXXXUqHzDiI3
 fMFsGOnh7mr3UZYXD+QG2MzNu/4k5lXj1nyYNJVTZNj6+k5pr0ZTgz73S1CAwbqhXehR
 TeUjlZsMqllYdVCYJrg9++ajVHJt47rcJGPhGGAHYvRdNQq7b1mEpBWMmAShihRjyUUL
 /R1yhfndHRd6TmwG0YEVavZPuj35x9CNuVLGQjU+wm4mJL0ChYAUKuo3EJZfWg4t8Cd8 cw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up4cfcj5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 19:16:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AUJGVoI023739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 19:16:31 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 30 Nov
 2023 11:16:26 -0800
Message-ID: <c5b46d5f-8a8c-f949-43da-943c86c0634a@quicinc.com>
Date:   Fri, 1 Dec 2023 00:46:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] firmware: arm_scmi: Increase the maximum opp count
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <sudeep.holla@arm.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>, <quic_asartor@quicinc.com>,
        <quic_lingutla@quicinc.com>
References: <20231129065748.19871-1-quic_sibis@quicinc.com>
 <20231129065748.19871-4-quic_sibis@quicinc.com> <ZWiHUt-N8GvG5z_O@pluto>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZWiHUt-N8GvG5z_O@pluto>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MjeD5TXSAfh5I3zEYhriRtfzwoI1ptRf
X-Proofpoint-ORIG-GUID: MjeD5TXSAfh5I3zEYhriRtfzwoI1ptRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_19,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0 mlxlogscore=786
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300141
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/23 18:30, Cristian Marussi wrote:
> On Wed, Nov 29, 2023 at 12:27:48PM +0530, Sibi Sankar wrote:
>> The number of opps on certain variants of the X1E80100 SoC are greater
>> than current maximum, so increase the MAX_OPP count to the next log level
>> to accommodate that.
>>
> 
> Hi,

Hey Cristian,
Thanks for taking time to review the series.

> 
> 
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   drivers/firmware/arm_scmi/perf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
>> index 3344ce3a2026..edf34a3c4d6a 100644
>> --- a/drivers/firmware/arm_scmi/perf.c
>> +++ b/drivers/firmware/arm_scmi/perf.c
>> @@ -24,7 +24,7 @@
>>   #include "protocols.h"
>>   #include "notify.h"
>>   
>> -#define MAX_OPPS		16
>> +#define MAX_OPPS		24
>>
> 
> There is an hashtable, opps_by_freq, sized by an ilog2()....
> 
> ....so, can we stick to a power-of-2 like 32 instead ?
> (and be more future proof too...)

Thanks, will get this changed in the next re-spin.

> 
> Other than this, LGTM
> 
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Thanks,
> Cristian
