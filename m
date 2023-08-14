Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A777BDB8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjHNQOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjHNQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:14:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3026F106;
        Mon, 14 Aug 2023 09:14:03 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EFUnw7032293;
        Mon, 14 Aug 2023 16:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Tk7BNyym1la7u0CA0aSkDYUvy3flaCroLHDQgpCk/mE=;
 b=amlClTTVELZ4jFpRWzGHD40TUNLB+iuRpzyhnwLdLoY8f5U0vWv5CzEzqxHa5DDHUWQ2
 jzcSX3hCeLQamTi+qrutBBaMkjuBSAPPh0eAaqscIM2bJfi++Wyxa/yFDtdP6qZA4uFB
 RmllO8ExK8y9BzG4jWIbhOmMU6fA94lXxZHYgN8TC0J7R8CstJCviM0Z3uvujnnI3vBf
 FlK1lCQKockk5/gXh/dYvIBDWeEk9SNSlG9Bb6lix24XqtFGi6qkcT3VfyeJyqkZE58D
 wWWLNC4qdLTbBu6vfRFY9RlzG+4qpaRDD/01Yul1pkrYHAXLGs3tTljnevaWHSW3nlUE 2Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sffxt969n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 16:13:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EGDn3S007529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 16:13:49 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 09:13:46 -0700
Message-ID: <0cfd73bb-3ae6-d7bd-296c-0c39d194464b@quicinc.com>
Date:   Mon, 14 Aug 2023 21:43:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] firmware: arm_scmi: Fixup perf microwatt support
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <lukasz.luba@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_rjendra@quicinc.com>,
        <srinivas.kandagatla@linaro.org>,
        Chandra Sekhar Lingutla <quic_lingutla@quicinc.com>
References: <20230811204818.30928-1-quic_sibis@quicinc.com>
 <20230814092503.xdzafmqu5h3shrlz@bogus>
Content-Language: en-US
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20230814092503.xdzafmqu5h3shrlz@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7aSznZ1ZkMRrhvQfHc0tOhHrBOI4pRzH
X-Proofpoint-GUID: 7aSznZ1ZkMRrhvQfHc0tOhHrBOI4pRzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140149
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sudeep,

On 8/14/23 14:55, Sudeep Holla wrote:
> On Sat, Aug 12, 2023 at 02:18:18AM +0530, Sibi Sankar wrote:
>> The perf power scale value would currently be reported as bogowatts if the
>> platform firmware supports microwatt power scale and meets the perf major
>> version requirements. Fix this by populating version information in the
>> driver private data before the call to protocol attributes is made.
>>
>> CC: Chandra Sekhar Lingutla <quic_lingutla@quicinc.com>
>> Fixes: 3630cd8130ce ("firmware: arm_scmi: Add SCMI v3.1 perf power-cost in microwatts")
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   drivers/firmware/arm_scmi/perf.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
>> index c0cd556fbaae..30dedd6ebfde 100644
>> --- a/drivers/firmware/arm_scmi/perf.c
>> +++ b/drivers/firmware/arm_scmi/perf.c
>> @@ -1080,6 +1080,8 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
> 
> Please rebase any patch when posting upstream on upstream kernel tree.
> This definitely looks like some downstream tree. I will adjust and apply
> this time. This file never crossed 1000 line and this patch indicates
> otherwise, so I am sure Qcom has some downstream changes in this file now.

Thanks for taking time to review the patch but zero points for the ^^
deduction lol. The correct phrasing would be v6.5 rc6 hasn't crossed 1k
lines but the patch was based on next-20230809 which has the perf level
indexing mode support in addition :)

- Sibi

> 
