Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3CE75ACE5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjGTLVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGTLVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:21:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D996BE;
        Thu, 20 Jul 2023 04:21:35 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K7ldjo012416;
        Thu, 20 Jul 2023 11:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Dw/eeCPbrLfWlAS/vQvV+VTzD8WjYd8KoUjenQtJxX0=;
 b=KzvMmwfT3fw3pcPquW3azvkXfndmLfFuVgNCQNBXFfEBoy1mFqEzgBkJ9k7zv8QPbXvq
 KjcUF6B+GS3cVczbAFN45FcTSvoQ9Mv2ZuuMD0eY0WVAmzY3e67MVOzJRVoD/jSGlWOy
 BT3b0P+30iZjhaQ2TA9X5H/IYTD6yeS9oQ3n4IaRrm3k2iJdsb6X1L5/orGsstQryBnw
 1GWOYiawiGgHm3Wll2dpO11Z5UIhTvB0GbqhkXh3VpxIdiDqgBfN4/wxYXW52MouYfxx
 bsBLc8nskNzZ71RMCFTBN6LsN45V2gPC4eF1vR5/iuhmG4EHYoS+eIJLqYA0wdH61o/g PQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxxqv0nh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:21:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36KBLUnS028947
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:21:31 GMT
Received: from [10.201.197.30] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 04:21:26 -0700
Message-ID: <85e772cb-f11e-8ce6-f55e-d9599889debd@quicinc.com>
Date:   Thu, 20 Jul 2023 16:51:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] Add initial support for RDP415 of IPQ5018 family
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230720074846.20350-1-quic_harihk@quicinc.com>
 <56e1c9bf-7dc0-7c28-ab0c-02cf78aed7c9@linaro.org>
From:   Hariharan K <quic_harihk@quicinc.com>
In-Reply-To: <56e1c9bf-7dc0-7c28-ab0c-02cf78aed7c9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PMs7efWUoIgE9LvLX-c5o-CCJqMuxUpY
X-Proofpoint-GUID: PMs7efWUoIgE9LvLX-c5o-CCJqMuxUpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxlogscore=669 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200095
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 1:35 PM, Konrad Dybcio wrote:
> On 20.07.2023 09:48, Hariharan K wrote:
>> Add the initial device tree support for the Reference Design
>> Platform(RDP) 415 based on IPQ5018 family of SoC. This patch
>> carries the support for Console UART and eMMC.
>>
>> This series is based on the below series,
>> https://lore.kernel.org/lkml/20230720072938.315
>> 46-1-quic_harihk@quicinc.com/
>>
> You just sent 3 series doing almost the same thing.
> For v2, please bunch them all up into a single series.
> 

Sure. Will rework and post in next series.

Best regards,
Hariharan K

> Konrad
