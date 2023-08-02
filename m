Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B800276CB03
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjHBKiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjHBKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:37:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B0830C6;
        Wed,  2 Aug 2023 03:33:35 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3726Hu0O032084;
        Wed, 2 Aug 2023 10:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6egafR2Gmg6Gnx3u00f+chwbDAZ6iWRLb/UrBZWJ5s8=;
 b=lzriBW1WKMIKGJfd0ybv/KueMz2VE0q9qO+Tvud3Nez2zgdFCBIMHYpOU1T6x++9Az0m
 jepxSO16zsr7jC9Az1Ym75q0Ke8RTrqL5YKaMx7z4skiaU7xwzRN+O1KZuqk46Fe6mCV
 x/Poi6geGoY8OmPqnzSYccEd7jD3dB6D84eRcBY4FA7jcZSWXCx4ACoAOmxGwwaDV38c
 lfqsbUpWT5Dr43EjlDXluxnriJPLQoNJQCm8sBtGpX+vr8gNgpebJ423vyKBJMU2Dy1t
 rmiyZuFBh9WnjALwgO9IURWwTkmm7ilZQ4nZgaa10w9HWY0vJ+/5/LUAO568tVFoSoCd 4A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7bp69byd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 10:33:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372AXQU1029558
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 10:33:26 GMT
Received: from [10.253.73.93] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 03:33:23 -0700
Message-ID: <b0ddd1d0-9140-16a7-3cd8-18c9cd4e69f4@quicinc.com>
Date:   Wed, 2 Aug 2023 18:33:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] clk: Add the flag CLK_ENABLE_MUTEX_LOCK of enabling
 clock
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230801085352.22873-1-quic_luoj@quicinc.com>
 <20230801085352.22873-2-quic_luoj@quicinc.com>
 <02abeb64fb360245791b467b371f1491.sboyd@kernel.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <02abeb64fb360245791b467b371f1491.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x9oFqgpz1mi4t-YF2X74ZeW9-okoVMUu
X-Proofpoint-ORIG-GUID: x9oFqgpz1mi4t-YF2X74ZeW9-okoVMUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_05,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 mlxlogscore=716 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020093
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 3:18 AM, Stephen Boyd wrote:
> Quoting Luo Jie (2023-08-01 01:53:50)
>> Support the clock controller where the HW register is
>> accessed by MDIO bus, the spin lock can't be used because
>> of sleep during the MDIO operation.
>>
>> Add the flag CLK_ENABLE_MUTEX_LOCK to hint clock framework
>> to use mutex lock instead of the spin lock.
> 
> Why can't you enable the MDIO bus clk in .prepare()?

thanks Stephen for the suggestion, let me check this and update patchset.
