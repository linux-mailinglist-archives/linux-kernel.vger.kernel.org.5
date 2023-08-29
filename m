Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2FC78BE31
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjH2GDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjH2GCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:02:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C2410E;
        Mon, 28 Aug 2023 23:02:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T4AoXK022455;
        Tue, 29 Aug 2023 06:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dTHyNtfzuJvMXq7CMl5tpmCxV/Snk/7TBgcc7+jjycY=;
 b=Auyc2qEaYUQ94JoyKWd0HqDLpp6vn6itt1jFxV0kBuqCiehXRNMkgo/RzPtBKwr2XxjL
 NX+a3pamYBWl3HLuyXV1zF4hSQEELHSp/pWyCiI0pqFoDP0uL040ztrPUn/OzmDWq/Tz
 29IXyz+DNjgLj89C70kJXMpHPjWscuOhjeINgwT7jMKJmRYnz7wO1l7SSQ9PM+ea1iVV
 5cparz+3X4ADtYy6W4lmfrnq1swTTSuocN9T/XzjH1hKs8JySm0mDFjQBz07gUxilNpQ
 G+cp+uW1CEGS6+cauWtq4LaRLS1nuBSYDk0RtBm1+2PC3ndQugH3jMJ6wn0n1AHiCpve aQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srvr81ra3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:02:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T62Sv1004940
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:02:28 GMT
Received: from [10.216.63.45] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 28 Aug
 2023 23:02:23 -0700
Message-ID: <7893ea86-b180-fa85-ceeb-8b78a8880f12@quicinc.com>
Date:   Tue, 29 Aug 2023 11:32:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/7] thermal/drivers/qcom/tsens: Add support for IPQ5018
 tsens
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-4-git-send-email-quic_srichara@quicinc.com>
 <d9560045-5c8e-96a6-48dd-c97190d0cdd2@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <d9560045-5c8e-96a6-48dd-c97190d0cdd2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: snvptVAXNoSufvC-sr5yNoULTXQ0uU3z
X-Proofpoint-ORIG-GUID: snvptVAXNoSufvC-sr5yNoULTXQ0uU3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_03,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=582 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290051
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/2023 1:03 AM, Krzysztof Kozlowski wrote:
> On 28/08/2023 21:18, Sricharan Ramabadhran wrote:
>> IPQ5018 has tsens IP V1.0, 4 sensors and 1 interrupt.
>> The soc does not have a RPM, hence tsens has to be reset and
>> enabled in the driver init. Adding the driver support for same.
>>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
> 

  ok, will fix.

Regards,
  Sricharan
