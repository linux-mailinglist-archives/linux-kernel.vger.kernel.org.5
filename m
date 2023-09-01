Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE978F94B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348534AbjIAHl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245339AbjIAHlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:41:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815CD10E2;
        Fri,  1 Sep 2023 00:41:52 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3815Eulg008729;
        Fri, 1 Sep 2023 07:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1DCT/jIQk3Ow01H7kLsDO/mvKja/LZsijEWLUkKfJuE=;
 b=ITDw6mXtngDqNtN3VPlWZ9O31OmzG8aXlYcgAISSe/R232XQSI/SZDiH/kLaz6LKrDro
 nZFJJbcl0NJ5LIGGHIBPCtJS/1SQrD+QX8IpMdfNv4a2z1ryx/6bewWowaJsPMneqebQ
 9yYgHRewRf+PHoDcjYzyKbXefAAJoe7yFxn5WNo+BoAqgVnVq6XdUksPnon6bos6+t2f
 GN4qI68Pcz2JVpdxv3LTZ5C5dDX8oV0xsMEYlUZRLSheSXOvAA5hkfKgxqYUyqgwlbCB
 3YVNUnlthd7e1TLRNMmkBR9YpNO+bJtTzddF6RcCbqg5pX5fW/bg8hUWIBfp+gR6Cm2m hQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stpy9b5h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 07:41:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3817fh0f026765
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 07:41:43 GMT
Received: from [10.216.36.87] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 1 Sep
 2023 00:41:38 -0700
Message-ID: <a3469c64-f7e7-259a-ebcf-8879dcfb33a0@quicinc.com>
Date:   Fri, 1 Sep 2023 13:11:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] clk: qcom: ipq5332: Drop set rate parent from gpll0
 dependent clocks
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1693474133-10467-1-git-send-email-quic_varada@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <1693474133-10467-1-git-send-email-quic_varada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tbC5nitQe2JZVolSfB09ZoNgPdlh81Nj
X-Proofpoint-GUID: tbC5nitQe2JZVolSfB09ZoNgPdlh81Nj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_05,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=956 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010071
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/2023 2:58 PM, Varadarajan Narayanan wrote:
> IPQ5332's GPLL0's nominal/turbo frequency is 800MHz.
> This must not be scaled based on the requirement of
> dependent clocks. Hence remove the CLK_SET_RATE_PARENT
> flag.


Reviewed-by: Kathiravan T <quic_kathirav@quicinc.com>


>
> Fixes: 3d89d52970fd ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC")
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   drivers/clk/qcom/gcc-ipq5332.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> index b02026f..b836159 100644
> --- a/drivers/clk/qcom/gcc-ipq5332.c
> +++ b/drivers/clk/qcom/gcc-ipq5332.c
> @@ -71,7 +71,6 @@ static struct clk_fixed_factor gpll0_div2 = {
>   				&gpll0_main.clkr.hw },
>   		.num_parents = 1,
>   		.ops = &clk_fixed_factor_ops,
> -		.flags = CLK_SET_RATE_PARENT,
>   	},
>   };
>   
> @@ -85,7 +84,6 @@ static struct clk_alpha_pll_postdiv gpll0 = {
>   				&gpll0_main.clkr.hw },
>   		.num_parents = 1,
>   		.ops = &clk_alpha_pll_postdiv_ro_ops,
> -		.flags = CLK_SET_RATE_PARENT,
>   	},
>   };
>   
