Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507E2751BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjGMIff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjGMIfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:35:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B3944B7;
        Thu, 13 Jul 2023 01:27:13 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D7p9Ew012965;
        Thu, 13 Jul 2023 08:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aajb4O0+JqUQJ2iKdkoLlw9zfIhj2wplmnpG/Itk/gU=;
 b=JmDOTEeT9JciweujT8AdEJrwHKsMbTnDxAP62zM3QTdLGbzP92/DE1IhNyF1dvXhZdRx
 lkwvICc6nTchU6CiTDFTBT15vgEezDRkob2jtPfqoxwtAldxwIbupMQL/OaMszjzQnSM
 +2jU6iXTkMDi9BV8xbrOYr6nxdpwW6eLcRVLaSQzC6E3F8fORQcBijxP/xQZFLGXOeGB
 3aVGgWau5F3TqbOcKzrRFIBsoqMzk6XZzCFI/77FaiD6qgJ74zoDGxPeipi0J1is8O9C
 fGYQgPU/CKIiEakIrIywFBRSs83iU0bJyFa6H2cQ+VyYdFUtcAA2dSzP+8rzkDirSgKu AA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt57mrtsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 08:26:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D8QndF013004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 08:26:49 GMT
Received: from [10.50.29.227] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 01:26:32 -0700
Message-ID: <6cdd83b2-8f32-eafb-1a50-75b30f1b1414@quicinc.com>
Date:   Thu, 13 Jul 2023 13:56:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 0/3] Add notifier call chain to Embedded USB Debug(EUD)
 driver
Content-Language: en-US
To:     Konrad Dybcio <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1689148711.git.quic_schowdhu@quicinc.com>
 <c7ed2eb2-3b0a-a75e-bca9-641f802d6e15@kernel.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <c7ed2eb2-3b0a-a75e-bca9-641f802d6e15@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bjtGAvUvcqrOgPQmtWMjnFFP0PjcDAN1
X-Proofpoint-GUID: bjtGAvUvcqrOgPQmtWMjnFFP0PjcDAN1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=274 clxscore=1011
 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130072
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/2023 10:13 PM, Konrad Dybcio wrote:
> 
> 
> On 12.07.2023 10:22, Souradeep Chowdhury wrote:
>> This patch series adds the notifier chain to the Embedded USB Debug(EUD) driver.
>> The notifier chain is used to check the role switch status of EUD. Since EUD can
>> function only in device mode, other modules trying to do role-switch on the same
>> port have to first check the EUD status by calling this notifier chain and based
>> on the status proceed or block their role-switching step. The modules can call
>> the notifier through the call eud_notifier_call_chain and pass their own
>> role switch state as the argument. This chain will also be able to handle the
>> scenario of multiple modules switching roles on the same port since this can
>> create a priority and ordering among them for conflict resolution.
>>
>> Souradeep Chowdhury (3):
>>    usb: misc: Add the interface for notifier call for Embedded USB
>>      Debugger(EUD)
>>    usb: misc: Add notifier call chain to Embedded USB Debug(EUD) driver
>>    MAINTAINERS: Add the header file entry for Embedded USB debugger(EUD)
> Please actually CC all maintainers, as present in the MAINTAINERS file..
> 
> Consider using b4:
> 
> https://b4.docs.kernel.org/en/latest/index.html

Ack

> 
> Konrad
>>
>>   MAINTAINERS                          |  1 +
>>   drivers/usb/misc/qcom_eud.c          | 52 ++++++++++++++++++++++++++--
>>   drivers/usb/misc/qcom_eud_notifier.h | 10 ++++++
>>   3 files changed, 61 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/usb/misc/qcom_eud_notifier.h
>>
>> --
>> 2.17.1
>>
