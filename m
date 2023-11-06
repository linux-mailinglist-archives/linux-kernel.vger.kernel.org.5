Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAEC7E209B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjKFL7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKFL7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:59:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9334294;
        Mon,  6 Nov 2023 03:59:50 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A69LeUQ000763;
        Mon, 6 Nov 2023 11:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2/DCkzmeV1d4xaptQXzY0hVaYF+2cW7ZXSlcQMQEqks=;
 b=Om+v0OlICBDvqiUsqzek1vACxgpuTUP4IpYgKAeBphf+h+5IUvHk+BAKx6BdbAhmMTgX
 bwl945Qz78oXaqF7NIcD5CYdSFdGZ6pjn/I+g8lfSo32gq0yglPb8U0d+DZ2Z6DKxoz1
 Zhe5bmlN/fi42pjXlh3HLNuJCljXaF0lYmHZIVk2Ij8DkyxEfx7+MdOYvYIZ9Kkp4Txd
 n5ZTwaucHxVAW9Mev+6q0e2XaHDhludqepCAvSHRdnzShd1bEvM/57LPqqzy5S9pyi08
 9X6/iEjZoLxPqiHhZfIHOO99lMZDxcmEVdazkulz1FxWma+Uh8+100f7jDczHwBpY4zQ PQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6wer0cy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 11:59:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6Bxh6S012004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 11:59:43 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 6 Nov
 2023 03:59:37 -0800
Message-ID: <6cbe8202-7708-95b2-f9ac-1dbbc6991a9a@quicinc.com>
Date:   Mon, 6 Nov 2023 17:29:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/2] phy: qcom-qmp-pcie: Add support to keep refclk always
 on
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_parass@quicinc.com>
References: <20231106-refclk_always_on-v1-0-17a7fd8b532b@quicinc.com>
 <CAA8EJpo3oi20p55CLxacdMJTKgr-6Wrnx=idb_D9U8p482mpgg@mail.gmail.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAA8EJpo3oi20p55CLxacdMJTKgr-6Wrnx=idb_D9U8p482mpgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u29m_hPxtfs8NzrLPcx_zztMGQ1II1ch
X-Proofpoint-GUID: u29m_hPxtfs8NzrLPcx_zztMGQ1II1ch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=817 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060099
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/6/2023 5:28 PM, Dmitry Baryshkov wrote:
> On Mon, 6 Nov 2023 at 13:53, Krishna chaitanya chundru
> <quic_krichai@quicinc.com> wrote:
>> This series adds support to provide refclk to endpoint even in low
>> power states.
>>
>> Due to some platform specific issues with CLKREQ signal, it is not being
>> propagated to the host and as host doesn't know the clkreq signal host is
>> not sending refclk. Due to this endpoint is seeing linkdown and going
>> to bad state.
> Is this a board issue or an SoC issue? In the latter case this should
> go to the PHY configuration structure instead of being specified in
> the DT.

Hi Dmitry,

This is not SOC level issue it is a board issue.

- Krishna Chaitanya.

>> To avoid those ref clk should be provided always to the endpoint. The
>> issue is coming only when ep intiates the L1.1 or L1.2 exit and clkreq
>> is not being propagated properly to the host.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>> Krishna chaitanya chundru (2):
>>        dt-bindings: phy: qcom,qmp: Add PCIe qcom,refclk-always-on property
>>        phy: qcom-qmp-pcie: Add support for keeping refclk always on
>>
>>   .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml    |  5 +++++
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c            | 21 +++++++++++++++++----
>>   2 files changed, 22 insertions(+), 4 deletions(-)
>> ---
>> base-commit: 71e68e182e382e951d6248bccc3c960dcec5a718
>> change-id: 20231106-refclk_always_on-9beae8297cb8
>>
>> Best regards,
>> --
>> Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>
>
