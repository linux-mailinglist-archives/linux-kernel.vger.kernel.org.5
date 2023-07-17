Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04E6755BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjGQGhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGQGhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:37:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D8593;
        Sun, 16 Jul 2023 23:37:14 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H5pcVl028723;
        Mon, 17 Jul 2023 06:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DgQvj7P9SKd+4vVK23Z5kicrESGlyfKetsdyqYrWP4Y=;
 b=b8rr18dkArFi7/ETMxqT7NPoGdT+zplC+bCgdTHt6cDy0drRRFo2WQkwZqng6CtUYYM0
 w3T8EFpMbiiISJUecaqAlBYNbKuuyL7upDDI/RHlkEXUYzD0SDwrLRpLpYRgbZHG5h4N
 pJ9M8exepJKDuwTikXOemA1z+VnxvUL1UYCO+U3Lt5hns91TKMxCFuhyZY5vpYccfy06
 Kk8UAUvqd+SW1n+9BY3toWTA+z7adw6vhprGHrido+hEPcQ6m69vH9NHjz7kZrSY82z4
 leEcaMjHjXj0+wDg2TmRRAsbL+hgbG8fzKJrGXLONMpGARYKJfo3dyN0QlrujAX76eNc 8w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0cak6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 06:36:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36H6ahvk004461
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 06:36:43 GMT
Received: from [10.216.50.105] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 16 Jul
 2023 23:36:36 -0700
Message-ID: <52156f94-5bb0-93af-52ed-7cbb14492393@quicinc.com>
Date:   Mon, 17 Jul 2023 12:06:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <arnd@arndb.de>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <quic_saahtoma@quicinc.com>
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-5-quic_devipriy@quicinc.com>
 <ZK+NnWadQcmUDp0A@corigine.com>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <ZK+NnWadQcmUDp0A@corigine.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kQYvtwfe5s0BgfS4IKtY760RPTpIrRUJ
X-Proofpoint-ORIG-GUID: kQYvtwfe5s0BgfS4IKtY760RPTpIrRUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=909 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170059
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/2023 11:07 AM, Simon Horman wrote:
> On Tue, Jul 11, 2023 at 03:05:27PM +0530, Devi Priya wrote:
>> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574 based
>> devices.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> 
> ...
> 
>> +static const struct qcom_reset_map nss_cc_ipq9574_resets[] = {
>> +	[NSS_CC_CE_BCR] = { 0x28400, 0 },
>> +	[NSS_CC_CLC_BCR] = { 0x28600, 0 },
>> +	[NSS_CC_EIP197_BCR] = { 0x16004, 0 },
>> +	[NSS_CC_HAQ_BCR] = { 0x28300, 0 },
>> +	[NSS_CC_IMEM_BCR] = { 0xe004, 0 },
>> +	[NSS_CC_MAC_BCR] = { 0x28100, 0 },
>> +	[NSS_CC_PPE_BCR] = { 0x28200, 0 },
>> +	[NSS_CC_UBI_BCR] = { 0x28700, 0 },
>> +	[NSS_CC_UNIPHY_BCR] = { 0x28900, 0 },
>> +	[UBI3_CLKRST_CLAMP_ENABLE] = { 0x28A04, 9 },
>> +	[UBI3_CORE_CLAMP_ENABLE] = { 0x28A04, 8 },
>> +	[UBI2_CLKRST_CLAMP_ENABLE] = { 0x28A04, 7 },
>> +	[UBI2_CORE_CLAMP_ENABLE] = { 0x28A04, 6 },
>> +	[UBI1_CLKRST_CLAMP_ENABLE] = { 0x28A04, 5 },
>> +	[UBI1_CORE_CLAMP_ENABLE] = { 0x28A04, 4 },
>> +	[UBI0_CLKRST_CLAMP_ENABLE] = { 0x28A04, 3 },
>> +	[UBI0_CORE_CLAMP_ENABLE] = { 0x28A04, 2 },
>> +	[NSSNOC_NSS_CSR_ARES] = { 0x28A04, 1 },
>> +	[NSS_CSR_ARES]  { 0x28A04, 0 },
> 
> Hi Devi,
> 
> There appears to be an '=' missing in the line above.

Hi Simon,
Thanks for catching it! will update it in V2.

Regards,
Devi Priya
> 
> ...
