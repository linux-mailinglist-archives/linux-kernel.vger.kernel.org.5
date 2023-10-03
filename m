Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB7F7B6B00
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjJCOEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjJCOEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:04:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC16A9;
        Tue,  3 Oct 2023 07:04:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393CtFvq024974;
        Tue, 3 Oct 2023 14:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KW2J+DS9oHYENFNLmqwrDgX6qwBY0QVYINMUCr7I9Yw=;
 b=XK4rIydXnhdLo2yarTHTscnIJdElJzth/Ep8SXoVI6+uYwiVuaTGFEw+uc4TMXW78MIj
 cCrLu5JhjbeAPGffL3QE5Z+TDMCWHt4nc+joXxCqSaYrsX5t8XG8OmFLwhFOZDiRapX9
 KZ5P4CsNBR+QUxIUYo0qpib3c21kOiQYLGirz5aMAwEXUogs41MrYBgf7v5sGg/7+hFT
 6vKnl8A20HSchdW7hlR07TyOn7uVx7woWemxTXZrYiofyowHr1V87ltwn4ldB/t1KIyd
 C/jfR2Pz/mNjToHgx6dF5dv7b0t8PCq8UGF8gUpFIYoBRUIWAXFI+fO6aVEdiOQNmtKJ 0g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgbjgs659-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 14:03:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393E3tq2012896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 14:03:55 GMT
Received: from [10.216.32.208] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 3 Oct
 2023 07:03:01 -0700
Message-ID: <7d01eadc-4395-4871-91d4-a3d33d119921@quicinc.com>
Date:   Tue, 3 Oct 2023 19:32:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: ipq5332: Add Super-Speed UNIPHY in
 USB node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
        <arnd@arndb.de>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <quic_wcheng@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <quic_kathirav@quicinc.com>, <quic_nsekar@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20230929084209.3033093-1-quic_ipkumar@quicinc.com>
 <20230929084209.3033093-7-quic_ipkumar@quicinc.com>
 <618992fe-4c76-42ef-af47-ee66f74c5bb6@linaro.org>
 <3f89e0b7-189e-4cf7-bec5-b03c903c46b5@quicinc.com>
 <1e3af927-52b0-42ab-9643-db4bf3f2d2c4@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <1e3af927-52b0-42ab-9643-db4bf3f2d2c4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wd7JrN6cM8dnplHkB29Q3HpCe5dE3cnM
X-Proofpoint-GUID: Wd7JrN6cM8dnplHkB29Q3HpCe5dE3cnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_11,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=443 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2023 10:56 PM, Dmitry Baryshkov wrote:
> On 29/09/2023 16:31, Praveenkumar I wrote:
>>
>>
>> On 9/29/2023 6:44 PM, Konrad Dybcio wrote:
>>> On 29.09.2023 10:42, Praveenkumar I wrote:
>>>> Add UNIPHY node in USB to support Super-speed. As the SS PHY has
>>>> pipe clock, removed "qcom,select-utmi-as-pipe-clk" flag.
>>>>
>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> ---
>>> Patches 6 and 7 should be swapped, otherwise you may get no
>>> USB with this commit. Incremental patches must not break
>>> functionality, unless it is truly inevitable.
>> Understood. Will swap the 6 and 7 patches in the update.
>
> But just swapping the patches will not work, the patch for the board 
> file will break compilation. I think you have to squash them.
I think swapping will work as the PHY node in the base dtsi added 
separately in patch 3. If compilation fails, will squash them.

- Praveenkumar
>
>>
>> -- 
>> Thanks,
>> Praveenkumar
>>>
>>> Konrad
>>
>

