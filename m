Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1C4787A74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbjHXVbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243707AbjHXVbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:31:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A88B1BCD;
        Thu, 24 Aug 2023 14:31:21 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OLOkS9013479;
        Thu, 24 Aug 2023 21:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2fdg7h2226sqX99REpJg9DxaKy2gbykMMNCi5EUeiio=;
 b=JVFMmxNwfh/KGMWrKQkSaNnx6Hd4+sUsLNHoLtrWheCxfwGRvzdPk1PWStsL9C1F3Bcw
 94pxuh723DhccI8R2Vi55DEGIkKknKuHCbzMd8UVTvC4GW1Mr7mCGgW1ZV/r0rneKOI/
 wiwCQyiEjpHdkeb+aG987sKszZk4a1V/oH7uKqtAXFmd26WBz6Ognoi6m0o/pFUX4EQ2
 vHCQwvC7oKLEwzrr1wP95n2cPu3XsRNXna17P6Si+Y7Uzw+KBiLy+M62z8m8gEM34LrZ
 olLKqnEWWPR8EvzGAaAbmQHNevc/f5gaI0g4UDWdKPnyd7h5prBOxg+9Ovuky9mAg8k0 sw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sntyuu2ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 21:31:02 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37OLV1Cq032151
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 21:31:01 GMT
Received: from [10.110.124.126] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 14:31:00 -0700
Message-ID: <f71bc35a-c45c-0429-1164-d047d61ef061@quicinc.com>
Date:   Thu, 24 Aug 2023 14:31:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC DNM] perf: Add support for Qualcomm Last-Level Cache
 Controller PMU
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230809-topic-llcc_pmu-v1-1-dd27bd1f44c9@linaro.org>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230809-topic-llcc_pmu-v1-1-dd27bd1f44c9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oEznHW1ToxpU8I_kGSYdWB2aJAl0jKfn
X-Proofpoint-ORIG-GUID: oEznHW1ToxpU8I_kGSYdWB2aJAl0jKfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_17,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=961 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240187
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/2023 1:09 PM, Konrad Dybcio wrote:
> Add support for the Qualcomm LLCC (Last-Level Cache Controller) PMU,
> which provides a single event, expressing cache read misses.
> 
> Based on the vendor driver found in the msm-5.10 downstream kernel.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Hi, I've been trying to get this driver going upstream by cleaning it
> up and adding the necessary perf boilerplate (the original Qualcomm one
> only pokes at the PMU from within the kernel itself) to use the
> userspace tool.
> 
> I can not however get it to cooperate.. in this iteration I get a PMU
> event registered (though with only a "raw" name - no "x OR y" like with
> other PMUs on the system) as:
> 
> llcc_pmu/read_miss/                                [Kernel PMU event]
> 
> but the .read callback is never called when I run:
> 
> sudo perf stat -C 0 -a -e llcc_pmu/read_miss/ stress-ng -C 8 -c 8 -m 10
> 
> which always returns 0
> 
> if I add --always-kernel I get:
> <not supported>      llcc_pmu/read_miss/

Which SOC you are trying this on?


-- 
---Trilok Soni

