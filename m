Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1168978E7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbjHaIUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjHaIUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:20:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9995BEE;
        Thu, 31 Aug 2023 01:20:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V5GcTv005176;
        Thu, 31 Aug 2023 08:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OQ8JVTCIp9Wc3Ot+LLVj+1dsUoPDSuAAMBylpI5dnjo=;
 b=oV6rE5f7OKEY2tGPVag32nMZq9yd2WsGWuftz9EvNXlhxRrjTpSy12btdp149p+hnw21
 rCtZzTcl2w5Fd7NLUP+bXO5LNL/tMk+X/hRLdwnWCe6a/8HTohd6W/vuLQQ+8iZlCp/W
 BuT4Yke6Zx+Wyqf91MCecVQVnB6Knt3sh6qRkMy7egCB3JVpbDFWDUTVYsu5SkzZB2sr
 EHAyEv/xbKS4NWI31bYxZ0U/hrCCPfzOWMBMeEKhon2Yvyzv/68+tdi2PIHsDepRWRbb
 Mwit0nyGUj5VIwBI/kCiyTLwjsdvltshJoJW7hZ0YVMFDjihwQqHwnf+5Vs/ckgARHV6 8w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stj378jmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 08:20:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37V8KSWa029970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 08:20:28 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 31 Aug
 2023 01:20:23 -0700
Message-ID: <484fad11-b44a-0383-c34b-5ae30cd24bb9@quicinc.com>
Date:   Thu, 31 Aug 2023 13:50:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V6 0/5] Add camera clock controller support for SM8550
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230707035744.22245-1-quic_jkona@quicinc.com>
Content-Language: en-US
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <20230707035744.22245-1-quic_jkona@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H9EpKC9J43RhzReLkzXAwWXkU_xTYo8q
X-Proofpoint-ORIG-GUID: H9EpKC9J43RhzReLkzXAwWXkU_xTYo8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_06,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310074
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/2023 9:27 AM, Jagadeesh Kona wrote:
> Add bindings, driver and devicetree node for camera clock controller on
> SM8550.
> 
> Changes in v6:
>   - Updated parent map and frequency table of cam_cc_xo_clk_src to use
>     active only source P_BI_TCXO_AO instead of P_BI_TCXO
> 
> Changes in v5:
>   - Added clk_lucid_ole_pll_configure() to configure lucid ole PLL's
>   - Used module_platform_driver() instead of subsys_initcall()
>   - Fixed overloading .l config with CAL_L and RINGOSC_CAL_L fields
> 
> Changes in v4:
>   - Dropped the extra patches added in v2, since the review comments on
>     v3 recommended an alternate solution
> 
> Changes in v3:
>   - Squashed 2 extra patches added in v2 into single patch as per review
>     comments
> 
> Changes in v2:
>   - Took care of review comments from v1
>       + Removed new YAML file and reused SM8450 CAMCC YAML file for SM8550
>       + Sorted the PLL names in proper order
>       + Updated all PLL configurations to lower case hex
>       + Reused evo ops instead of adding new ops for ole pll
>       + Moved few clocks to separate patch to fix patch too long error
>       + Padded non-zero address part to 8 hex digits in DT change
>   - Added 2 extra patches updating .l config value across chipsets to
>     include CAL_L and RINGOSC_CAL_L fields and removed setting CAL_L
>     field explicitly in clk_lucid_evo_pll_configure().
> 
> v1:
>    - Initial CAMCC changes for SM8550
> 
> Previous series:
> v5 - https://patchwork.kernel.org/project/linux-clk/list/?series=759863
> v4 - https://patchwork.kernel.org/project/linux-clk/list/?series=755683
> v3 - https://patchwork.kernel.org/project/linux-clk/list/?series=753150
> v2 - https://patchwork.kernel.org/project/linux-clk/list/?series=751058
> v1 - https://patchwork.kernel.org/project/linux-clk/list/?series=749294
> 
> Jagadeesh Kona (5):
>    dt-bindings: clock: qcom: Add SM8550 camera clock controller
>    clk: qcom: clk-alpha-pll: Add support for lucid ole pll configure
>    clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
>    clk: qcom: camcc-sm8550: Add support for qdss, sleep and xo clocks
>    arm64: dts: qcom: sm8550: Add camera clock controller
> 
>   .../bindings/clock/qcom,sm8450-camcc.yaml     |    8 +-
>   arch/arm64/boot/dts/qcom/sm8550.dtsi          |   15 +
>   drivers/clk/qcom/Kconfig                      |    7 +
>   drivers/clk/qcom/Makefile                     |    1 +
>   drivers/clk/qcom/camcc-sm8550.c               | 3564 +++++++++++++++++
>   drivers/clk/qcom/clk-alpha-pll.c              |   29 +
>   drivers/clk/qcom/clk-alpha-pll.h              |    2 +
>   include/dt-bindings/clock/qcom,sm8550-camcc.h |  187 +
>   8 files changed, 3811 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/clk/qcom/camcc-sm8550.c
>   create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h
> 

Hi Bjorn,

All patches in this series are in reviewed state, could you please help 
to pick this series in the next release? Thanks!

Thanks,
Jagadeesh
