Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E950C768B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGaF0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGaF0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:26:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162E1172D;
        Sun, 30 Jul 2023 22:26:04 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V50a0w016595;
        Mon, 31 Jul 2023 05:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GIIVPngHT6amS2p2ivzvnJxX9/+v77l19RnlHWUvqjo=;
 b=HnwmFz7zwH1PHFuolfQX+BcmZoOU7e4qkgrSt23ag+KEbuW7ijdXGnNblPrSrXwpKgs6
 utkD7rvvhZNh5Rz4ic2EgQ672T5Zu00MCVCHSYqMroIc+xAdwzvBtmd4I96Cm8LurNsB
 wUHJuZ/XfYDT3uPF5v7fKsN9ih9BwlIicQcEXzM9LrVvG06R+PAV1CEw2upSsQsFzD1s
 nI+X0QjgZlIgg+cWVuCqzWAX4nOBvz3CBiow0y2uSu5uhmWNA73bvwS1x0MvCrjY9bKn
 LKKHyni8rbHbLBc+tTviofA80InDfE7CWWQ4C4RR5O+u6ZCKoOeG5nZN1NobPTcy69ld ig== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4usrjn0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:25:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V5PfMv029092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:25:41 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 30 Jul
 2023 22:25:37 -0700
Message-ID: <e4e25cb0-380d-b642-7d2d-c133df6ae8ee@quicinc.com>
Date:   Mon, 31 Jul 2023 10:55:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 0/2] Drop the mem noc clocks from the IPQ5332 GCC driver
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_saahtoma@quicinc.com>
References: <20230710102807.1189942-1-quic_kathirav@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230710102807.1189942-1-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KD2_C25Am4NjS_X9eZsd-SwwEpYPGX_V
X-Proofpoint-ORIG-GUID: KD2_C25Am4NjS_X9eZsd-SwwEpYPGX_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=674 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310048
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/10/2023 3:58 PM, Kathiravan T wrote:
> Due to the recent design changes, all the mem noc clocks will be
> configured by the bootloaders and it will be access protected by the TZ
> firmware. Also there are no comsumers for these clocks in the kernel. So
> drop these clocks from the GCC driver.
>
> With these clocks removal, remove the gcc_apss_axi_clk_src clock as well
> since no clocks uses this as a parent.


Gentle Reminder...


>
> Kathiravan T (2):
>    clk: qcom: ipq5332: drop the mem noc clocks
>    clk: qcom: ipq5332: drop the gcc_apss_axi_clk_src clock
>
>   drivers/clk/qcom/gcc-ipq5332.c | 206 +++++++--------------------------
>   1 file changed, 39 insertions(+), 167 deletions(-)
>
