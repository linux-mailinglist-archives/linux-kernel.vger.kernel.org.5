Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6C7CD9EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjJRK6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjJRK6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:58:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF847FF;
        Wed, 18 Oct 2023 03:58:13 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I6tSue005405;
        Wed, 18 Oct 2023 10:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dfIPjwCo1TPlhSqa+JpWtxJpKqFI6gMa+tmQEAaensM=;
 b=f2j4Fpgo9dOa6n4Y0tU74WWyIVffjJ/CPiiJMkOitrl7zCzlNUmFrwZ6nkSRxaUfVgp+
 hIk1v8fIJcPbif4MZbnfcwx1muyEc/+/huBS+4WTced7jsa9E8MdRG9q+wwYE3XqQerM
 rpJ6gZW+pPuV+rjHrgnA13vklNH+vpq/O0ZCyzwTDV6BSATrTeYA60YZjGMB3JeAItfo
 9O02nh0rVXUqJi9khqWjGJbe4XDNo88LKx98kTEGPatGf3yB330P7zcqOBDP4NDlxBCg
 mYAGRs7TB1CTPvMEa9iOpB/o3EuddT/zYLHUa3LyF+XBOzN0emkFUpJmte700tnUKE8L ag== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsvxwtat6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 10:58:10 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IAwAMg029504
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 10:58:10 GMT
Received: from [10.216.39.143] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 03:58:04 -0700
Message-ID: <fe60f28b-ab8e-0cb5-b08c-c02f4df865eb@quicinc.com>
Date:   Wed, 18 Oct 2023 16:28:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V2 0/4] Add support for Qualcomm ECPRI clock controller
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231011090028.1706653-1-quic_imrashai@quicinc.com>
 <427980eb-3235-4d63-bb8f-3af06978a3eb@linaro.org>
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <427980eb-3235-4d63-bb8f-3af06978a3eb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0GpuOH3TlNKQgcwTDfaXcBTBUtwhOJtk
X-Proofpoint-ORIG-GUID: 0GpuOH3TlNKQgcwTDfaXcBTBUtwhOJtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_09,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=930 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180090
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2023 3:58 PM, Konrad Dybcio wrote:
> 
> 
> On 10/11/23 11:00, Imran Shaik wrote:
>> The ECPRI clock controller support for QDU1000 and QRU1000. The clock
>> controller has a special branch which requires an additional memory to
>> be enabled/disabled before the branch ops.
>>
>> Changes since v1:
>>   - Updated the dt-bindings
>>   - Modified mem ops logic as per the review comments
>>   - Update all the hex values to lowercase
>>   - Aligned the clock entries in DT as per the review comment
>>
>> Previous series:
>> v1 - 
>> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=774092
> That link is gone by now, as patchwork is periodically purged.
> 
> Please use lore links instead.
> 
> https://lore.kernel.org/linux-arm-msm/20230808051407.647395-1-quic_imrashai@quicinc.com/
> 
> Konrad

Sure, will use lore links from now.

Thanks,
Imran
