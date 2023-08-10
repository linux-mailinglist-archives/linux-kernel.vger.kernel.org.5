Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B6B776F35
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjHJEui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjHJEug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:50:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95212111;
        Wed,  9 Aug 2023 21:50:35 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A4EhcX032196;
        Thu, 10 Aug 2023 04:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vuIyYW9KmAZCjwpkiE3IvJTBTJ3saCoM2CI8+22ftXE=;
 b=cKjj5fOZxdpeaTA6UbZGXOkC6ft/y6vN0deofue0OjteawK2XTQvZQ7wriQt0HBcmYHb
 tKhXZhOOtEHcxyztd9M7BzURr1xGmRT8kkTtVZYEruZv8/+M4XjAYFdwoxM4y/VOcLki
 wx2x2zdX4k9uzinM1G7tYm2koJPQmiymIx3gxHqbfCogCURVdj7NZIzj9M0/xSO1TY9Y
 wZ8+79apTKnaM4EoiZMhHU2oo6k2S/SspFDUTtPz2MLIujvC1ahCk9yNfU/kzzYJXilj
 EW6sKF2LdnmIfsBvCG65aqe1Me6WSBbOoCyJfsv1XuehUG8hOekndTnfdltIiLb3chYZ xA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scbcghj5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:50:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A4oPds000482
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:50:25 GMT
Received: from [10.253.39.188] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 21:50:21 -0700
Message-ID: <31138efa-2ad1-25dd-46be-338db59c4f6c@quicinc.com>
Date:   Thu, 10 Aug 2023 12:50:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 4/4] arm64: defconfig: Enable qca8k nss clock
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230809080047.19877-1-quic_luoj@quicinc.com>
 <20230809080047.19877-5-quic_luoj@quicinc.com>
 <e42b0248-f7a7-5615-0c8a-8255c8a4548c@linaro.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <e42b0248-f7a7-5615-0c8a-8255c8a4548c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dIV7sEnrItuTSUb2vY3N9bx7exPNCM6F
X-Proofpoint-ORIG-GUID: dIV7sEnrItuTSUb2vY3N9bx7exPNCM6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_03,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=498 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100041
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2023 11:40 PM, Krzysztof Kozlowski wrote:
> On 09/08/2023 10:00, Luo Jie wrote:
>> Enable clock controller config for Qualcomm qca8386/qca8084 chip.
> 
> Which boards or products in upstream kernel use it? We do not enable
> drivers which are not used/needed.
> 
> Best regards,
> Krzysztof
> 

Thanks Krzysztof for the comments.
it is not used by the current upstream kernel, i will remove this patch 
in the next patch series.
