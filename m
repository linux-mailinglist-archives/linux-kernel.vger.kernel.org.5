Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0997F2079
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjKTWjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKTWjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:39:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3B597;
        Mon, 20 Nov 2023 14:39:50 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKLvlTp007578;
        Mon, 20 Nov 2023 22:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=f8L9nhtIuJda89+/HgbEISF8b2edhNC6k49x6R/K4ow=;
 b=Kt0KD54qwEeAg33D+pcYQXBM9nr9fS2HzuCD7j8Wc5cTEsXT0E2S3vtYT6J7xU4qoPRD
 NcEANm1ciEOwkPcUmAyv0DzYy3thSW2HuF4dk3W0TED8KK7SyJxwbdrqKQQclTJfPBBO
 r64P5naM0sL5rfSEthp/OObOVkmpD99H4VW69UwVKUviMAYgD8UATehAgUY8HXrGVCsq
 UIkmUupXSCT9X1FCSkBa12lhS2RQkHml4QewYSM3Nta+W0pigbS7JrM1Zdd1sS43XvRh
 CnKZN+t/gNAja+Fo6XU2HESqu7LN5dQODArqVC7PTJc0j2rXI0zQyxcocsLLzYEHnq5D uQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug37mj0nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 22:39:35 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKMdY6Q016666
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 22:39:34 GMT
Received: from [10.110.29.191] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 14:39:33 -0800
Message-ID: <bf6c628d-132c-296b-b29a-dc7be4390578@quicinc.com>
Date:   Mon, 20 Nov 2023 14:39:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/2] dt-bindings: arm: Add remote etm driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Mike Leach" <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>
References: <20231107060939.13449-1-quic_jinlmao@quicinc.com>
 <20231107060939.13449-3-quic_jinlmao@quicinc.com>
 <10afe65f-4e86-4127-9f8d-b4e3f5ee8a3a@linaro.org>
Content-Language: en-US
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <10afe65f-4e86-4127-9f8d-b4e3f5ee8a3a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M1hrlZSwaz4MWX8VnvJbfsHWvi3NLK-j
X-Proofpoint-ORIG-GUID: M1hrlZSwaz4MWX8VnvJbfsHWvi3NLK-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=549 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200166
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/2023 9:22 AM, Krzysztof Kozlowski wrote:
> On 07/11/2023 07:09, Mao Jinlong wrote:
>> Add new coresight-remote-etm.yaml file describing the bindings required
>> to define coresight remote etm in the device trees.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> 
> +Cc Trilok,
> 
> Several Qualcomm boards have warnings coming from Coresight bindings.
> These are big, fat warnings coming usually from ARM bindings (e.g.
> dynamic funnel, TMC). I don't know Coresight good enough to fix them by
> myself.
> 
> I would prefer not to take any new Qualcomm specific Coresight bindings
> and definitely no new Coresight device nodes in Qualcomm boards, before
> these are fixed.
> 
> Therefore I kindly ask to fix all warnings in Qualcomm boards coming
> from existing Coresight bindings.

Thanks Krzysztof, we can look into it as first thing to fix. 
 
-- 
---Trilok Soni

