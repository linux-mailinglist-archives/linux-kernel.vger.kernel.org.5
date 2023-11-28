Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D1A7FB6A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjK1KE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjK1KEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:04:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C2BDD;
        Tue, 28 Nov 2023 02:04:30 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS9CPVK030785;
        Tue, 28 Nov 2023 10:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vpTPxQ+fdoF6wnOYXP6scd3ZnbO2OTplcLMU91k9FQU=;
 b=YpUkbCE7GYXiSeRSEKzhX2LjR+WXvN7VczVySWwSJdU3V6YPUxB8LuAhzkgNDH0d8QwH
 Yo3dWhG8hDbDUKcZusTly7QAtUew4q25x4bCQZwaJT5lyLBhfHwpTfeyyHFSYRmmz8mG
 sTaa3IYcKpS0ZxN+aJdNM9WSUW8ZkCCogS/UEPhgHQuHPGqTp6JV/NUFlAWgMZHbm3gC
 vsPm8hWSO8RNOUuLVEThzbZyuB/SFHT5y+zhJlIMuLN0lR1hbAs/oS4fVWOd1xiiiXnB
 dBdM+SV6iu2zQ7fnf40i0HOQIH/a6pG+s8wbgCHt4CqhOJB3hrQi9YO+eUOJdK59Cbwj +w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3undc583hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 10:04:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ASA3t15024268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 10:03:55 GMT
Received: from [10.253.11.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 02:03:51 -0800
Message-ID: <4038b408-838d-4804-8866-cc8471749daa@quicinc.com>
Date:   Tue, 28 Nov 2023 18:03:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
Content-Language: en-US
To:     <neil.armstrong@linaro.org>, <bvanassche@acm.org>,
        <mani@kernel.org>, <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-10-git-send-email-quic_cang@quicinc.com>
 <0d8fe915-4d53-414b-b145-231fe913474d@linaro.org>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <0d8fe915-4d53-414b-b145-231fe913474d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v4UaJZUiA_8JVfm66l1wLIT-EEmzcPj7
X-Proofpoint-ORIG-GUID: v4UaJZUiA_8JVfm66l1wLIT-EEmzcPj7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_09,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 11/28/2023 5:59 PM, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 23/11/2023 09:46, Can Guo wrote:
>> On SM8550, two sets of UFS PHY settings are provided, one set is to 
>> support
>> HS-G5, another set is to support HS-G4 and lower gears. The two sets 
>> of PHY
>> settings are programming different values to different registers, mixing
>> the two sets and/or overwriting one set with another set is definitely 
>> not
>> blessed by UFS PHY designers.
>>
>> To add HS-G5 support for SM8550, split the two sets of PHY settings into
>> their dedicated overlay tables, only the common parts of the two sets of
>> PHY settings are left in the .tbls.
>>
>> Consider we are going to add even higher gear support in future, to avoid
>> adding more tables with different names, rename the .tbls_hs_g4 and 
>> make it
>> an array, a size of 2 is enough as of now.
>>
>> In this case, .tbls alone is not a complete set of PHY settings, so 
>> either
>> tbls_hs_overlay[0] or tbls_hs_overlay[1] must be applied on top of the
>> .tbls to become a complete set of PHY settings.
>>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> 
> Since Vinod has already merged SM8650 UFS PHY support, I'm afraid this
> serie will break UFS if the SM8650 UFS tables aren't updated aswell.
> 
> Could you confirm if this will be the case ?

Because this change modifies data struct, it would be caught during 
compiliation stage even if this change applies cleanly, hence it won't 
break UFS.

Thanks,
Can Guo.

> 
> Thanks,
> Neil
> 
> 
