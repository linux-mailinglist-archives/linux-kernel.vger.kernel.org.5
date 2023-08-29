Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E579B78BD45
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjH2D3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbjH2D3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:29:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFCF110;
        Mon, 28 Aug 2023 20:29:37 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T2VbxH031740;
        Tue, 29 Aug 2023 03:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EhZf3ayO/wDgQ6rYztFJO+yN7mD/q2RQlkhBvaG9Ui0=;
 b=ouLV7d8WwDMdkAzdgRpJEIK3wTlBNoK43jpEpbAYIC7dlHCUEM3U05Ed7KcHk5KUOtZg
 +27dPSAbTnOxFw+m1EJtu9BDVthfesqW5PAWopD8keUVCQ4btSaFZoWiDdq6CT2pPZCp
 vp7i+Gvix/gHgzkIkR2rev9n804KBXAw1Vkd60EdsaQ9llUVBu1BK6aQM92KnSiBuVgD
 zFIR9OxG+4/85FyuVxN+I3+i667jrcC3Le6K6SNu6xLIBFNmyoyWterK4NeX/Q7xmdd4
 0Qe/GItjjCmtrokuCcfZ5WDvPTfSX10dbsK/CTt32rwp2zJPPDLB5NYLuAeKuD3xstE4 fw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srvr81ghx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 03:28:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T3SrGw001787
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 03:28:53 GMT
Received: from [10.216.21.12] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 20:28:45 -0700
Message-ID: <63826bbc-7193-f6fd-358d-87ad6b3ae5b1@quicinc.com>
Date:   Tue, 29 Aug 2023 08:58:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/7] clk: qcom: clk-alpha-pll: Add NSS HUAYRA ALPHA PLL
 support for ipq9574
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <arnd@arndb.de>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <geert+renesas@glider.be>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <netdev@vger.kernel.org>, <nfraprado@collabora.com>,
        <p.zabel@pengutronix.de>, <peng.fan@nxp.com>, <rafal@milecki.pl>,
        <richardcochran@gmail.com>, <robh+dt@kernel.org>, <will@kernel.org>
CC:     <quic_saahtoma@quicinc.com>
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-2-quic_devipriy@quicinc.com>
 <4a00db79414dbc47a2b7792d849f7056.sboyd@kernel.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <4a00db79414dbc47a2b7792d849f7056.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q7kegw_-tSm7uznGqCAL3sL8_6h0oaLb
X-Proofpoint-ORIG-GUID: Q7kegw_-tSm7uznGqCAL3sL8_6h0oaLb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_20,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290030
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2023 2:28 AM, Stephen Boyd wrote:
> Quoting Devi Priya (2023-08-25 02:12:28)
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
>> index e4ef645f65d1..1c2a72840cd2 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.c
>> +++ b/drivers/clk/qcom/clk-alpha-pll.c
>> @@ -228,6 +228,18 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
>>                  [PLL_OFF_ALPHA_VAL] = 0x24,
>>                  [PLL_OFF_ALPHA_VAL_U] = 0x28,
>>          },
>> +
> 
> Why the extra newline? All other types aren't this way.
Sure, will drop it in V3

Thanks,
Devi Priya
> 
>> +       [CLK_ALPHA_PLL_TYPE_NSS_HUAYRA] =  {
>> +               [PLL_OFF_L_VAL] = 0x04,
>> +               [PLL_OFF_ALPHA_VAL] = 0x08,
>> +               [PLL_OFF_TEST_CTL] = 0x0c,
>> +               [PLL_OFF_TEST_CTL_U] = 0x10,
>> +               [PLL_OFF_USER_CTL] = 0x14,
>> +               [PLL_OFF_CONFIG_CTL] = 0x18,
>> +               [PLL_OFF_CONFIG_CTL_U] = 0x1c,
>> +               [PLL_OFF_STATUS] = 0x20,
>> +       },
>> +
