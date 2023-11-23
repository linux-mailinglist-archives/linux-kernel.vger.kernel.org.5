Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE567F58EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344842AbjKWHPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKWHPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:15:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8AF83;
        Wed, 22 Nov 2023 23:15:07 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN5xPSU015289;
        Thu, 23 Nov 2023 07:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dmtKlYR/zX+0yqgepCzSMKtDa2N/1FNfQNnT8kro9OM=;
 b=dZ4R6mCUqJc2srvA+dNf9aOHheXLbMY0UgLXbmDBpm54Imw26qmCbVh6m9rZ7ZbgKrWu
 cq1wHGCzUKYpSfx3tBlidjO5xtScJMr1SlffbJSqVprBBKjD8c7dzMvgbpfoA8IoVqes
 D6NlZitOf+xIRQbumipMUCIqhK8+bKLUAo6BhsLxS84nFUZINwZ+LQK3bdBMZZAYnqjd
 nL43/AfUhucjSaethwZHqY7xr+4mMkk61sPmO5quHC8vAT584jMXeA0DBq6IakhTeVMT
 mZ7ju2dlqjQ559meeaLi05STqqjNR2djuse6w1RC1Cy/DZJp8/AE+L3OdddMq2ptMAR2 cg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhvm0rqyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 07:14:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AN7EwZo023792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 07:14:58 GMT
Received: from [10.216.58.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 23:14:51 -0800
Message-ID: <7167bbde-f958-42d6-bffc-4a00ee2beee9@quicinc.com>
Date:   Thu, 23 Nov 2023 12:44:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] clk: qcom: add NSS clock Controller driver for
 Qualcomm IPQ5332
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
 <20231121-ipq5332-nsscc-v2-7-a7ff61beab72@quicinc.com>
 <1f643ec4-2f55-4fe3-8d66-a47241c25619@linaro.org>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <1f643ec4-2f55-4fe3-8d66-a47241c25619@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mXdGPNOETakmGv54R-ba0ioccd8_ZmYE
X-Proofpoint-ORIG-GUID: mXdGPNOETakmGv54R-ba0ioccd8_ZmYE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_04,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=640 mlxscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2023 1:50 AM, Konrad Dybcio wrote:
> 
> 
> On 11/21/23 15:30, Kathiravan Thirumoorthy wrote:
>> Add Networking Sub System Clock Controller(NSSCC) driver for Qualcomm
>> IPQ5332 based devices.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>> ---
> LGTM except a single nit


Thanks, will modify it as below

MODULE_DESCRIPTION("QTI NSSCC IPQ5332 Driver");


> 
>> +MODULE_DESCRIPTION("QTI NSS_CC MIAMI Driver");
> 
> Konrad
> 
