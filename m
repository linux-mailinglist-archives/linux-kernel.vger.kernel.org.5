Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26457549BB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGOPRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGOPRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:17:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD172D7B;
        Sat, 15 Jul 2023 08:17:36 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36FEpcVw010251;
        Sat, 15 Jul 2023 15:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pI3A5ie5nsmRsQRouwoNLfld9D1VUu37GlPSLQyEGuQ=;
 b=WXbyuU9etsYl2ZUK/dlGxR7l3/JN4HsojE8RgA91aWg/czLsSfC/t/2qPN1b5bFxlgDv
 5a82F2nXwrDgr1r57mahncM+ixs++jWCUK0OtlwNo39t7OzvSVnwyDWcYQoB6BKXjXsg
 s6N1vgsBDZPlbLcaHCbIN6+/28cEWEj3tmq7slGNonWKvhv6DOGNVmi3q0B1Kq/wQPkq
 HGQR/6gYryIVSsDYl0Jy+W07sf5RFsEumzar3ipmna0C+rk9hWUO3gcBCutvcjmKaaLh
 Y1O9msKzC4Hf/O9AFzQ6dQ4m9acjbju1nfaB7WbEi8gnMxh4m0KCP2W6bg0Zxi53RbfX OQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0erg5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jul 2023 15:17:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36FFHWD2025751
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jul 2023 15:17:32 GMT
Received: from [10.216.17.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sat, 15 Jul
 2023 08:17:27 -0700
Message-ID: <9b8c6235-838f-1264-865f-7a03889abc2f@quicinc.com>
Date:   Sat, 15 Jul 2023 20:47:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/2] clk: qcom: ipq5332: drop the mem noc clocks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_saahtoma@quicinc.com>
References: <20230710102807.1189942-1-quic_kathirav@quicinc.com>
 <20230710102807.1189942-2-quic_kathirav@quicinc.com>
 <b8b2db1b-dbfc-591e-f074-1366e5ac576a@linaro.org>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <b8b2db1b-dbfc-591e-f074-1366e5ac576a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CFfI2QgrRk7aZ3pNaD7LVpj-SVuy-XZE
X-Proofpoint-ORIG-GUID: CFfI2QgrRk7aZ3pNaD7LVpj-SVuy-XZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=563
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307150144
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/15/2023 7:40 PM, Konrad Dybcio wrote:
> On 10.07.2023 12:28, Kathiravan T wrote:
>> Due to the recent design changes, all the mem noc clocks will be
>> configured by the bootloaders and it will be access protected by the TZ
>> firmware. So drop these clocks from the GCC driver.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
> Are there any IPQ5332s outside Qualcomm labs that will presumably
> never get that TZ update?
>
> Konrad

No, this TZ update will shipped as part of the next releases.

Thanks, Kathiravan T.


