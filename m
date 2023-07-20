Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DE75AC9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjGTLO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGTLOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:14:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401E4BE;
        Thu, 20 Jul 2023 04:14:23 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KAIQPF005320;
        Thu, 20 Jul 2023 11:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0mw6PoMxySEnOfUv+KwV/pNOg9gt4stu3P+IYh12OsI=;
 b=M1/048Q3NkjoGWNlsxKaPOR3ifK1s1vb0S7QjIGIlemSH8OoBXavCb2WvyjYUlNyTDZx
 BV4wiWhs6GfjpY1IvpJnesrp/sYN+3IdZWiyjJW+sEqdsNG2nAlImgMp3nMboMSxXyl6
 L5QkWz8XH25j9dYUcHw9OhYHAw74GhKiejC7Js52uFzWRwp+qvePBel2LFWi4fxEm8L+
 CtmVUUpC6wNdD1WlVcJukRodIYdeMIl8xAxnIHkCzniD3uAdgXdHGtMUbD+Q2aElu1wb
 ddfdYIwUCifPsje68DLzW9c03e+W9QRv+4K+YPzwypMI8XMFo9OF8UaHEQrRAPzXNxSQ jA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxg3vab68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:14:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36KBEI7t006847
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:14:18 GMT
Received: from [10.201.197.30] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 04:14:14 -0700
Message-ID: <82a771a7-bebd-32dc-308d-a88fae002972@quicinc.com>
Date:   Thu, 20 Jul 2023 16:44:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] Add initial support for RDP404 of IPQ5018 family
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230720074302.13585-1-quic_harihk@quicinc.com>
 <5fdfe7b2-0afb-f7a1-c29a-4a7884ff8f1c@linaro.org>
From:   Hariharan K <quic_harihk@quicinc.com>
In-Reply-To: <5fdfe7b2-0afb-f7a1-c29a-4a7884ff8f1c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RdCxLCL0dYFMQ4oIsLZ514--JVqLf6Gw
X-Proofpoint-ORIG-GUID: RdCxLCL0dYFMQ4oIsLZ514--JVqLf6Gw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=948 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200094
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 2:28 PM, Krzysztof Kozlowski wrote:
> On 20/07/2023 09:43, Hariharan K wrote:
>> Add the initial device tree support for the Reference Design
>> Platform(RDP) 404 based on IPQ5018 family of SoC. This patch
>> carries the support for Console UART and eMMC.
>>
>> This series is based on the below series,
>> https://lore.kernel.org/lkml/20230720072938.315
>> 46-1-quic_harihk@quicinc.com/
> 
> Nope. You make it very difficult for us to review and follow your
> submissions. Especially considering issues in the old ipq5018 submission.
> 

Sorry, will address these issues in v2.

Best regards,
Hariharan K

> Best regards,
> Krzysztof
> 
