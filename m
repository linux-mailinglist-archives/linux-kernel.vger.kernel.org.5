Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F107910C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352033AbjIDFND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjIDFNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:13:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367C7ED;
        Sun,  3 Sep 2023 22:12:57 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3844pvkw022759;
        Mon, 4 Sep 2023 05:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AwpqZ/W8iw3FSJjd3QS+6Vz0gbo9KyXxE+gvDSiDrY8=;
 b=nZUcNduliXjejSvKOJS4n2KOwWSd9OUrddm4ATe+dJa7OeGc+5fkRpBdepuh6pIbpev9
 68+TvRRrIp79J7mJ6mMlRKQqzTazFESbHT/OAJh29lOQfL94po/Jik2pBd7zXNDDkluD
 dl74TOU4+Uf1W5eNRiNx+V2p2EBxO5JEYYefUdGkshVQsJnCFcv60ONAzQebHC93G7C9
 lc+4pYk/WHbJuW0imEqor3agDlifR2Yyv2omJD2vOqsn2P1eThiZOcT+maiu5IZROwry
 ghtZqo+osP5p28F/kDSIGMCt+qZ0GrZAnRaxvlMMEoxUbdtmSYJIt88w/4NMKD/MHckc Dg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suvcram4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 05:12:40 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3845CcWn020480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 05:12:38 GMT
Received: from [10.201.200.63] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 3 Sep
 2023 22:12:33 -0700
Message-ID: <6593b9d1-2632-f6da-b0c7-162b31bdca55@quicinc.com>
Date:   Mon, 4 Sep 2023 10:42:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V3 2/4] phy: qcom-m31: Add compatible, phy init sequence
 for IPQ5018
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <20230901092645.20522-1-quic_nsekar@quicinc.com>
 <20230901092645.20522-3-quic_nsekar@quicinc.com>
 <CAA8EJppej++gbrWrRU9EFBntjzck4-9xbgS_sCPBfcxEofUo3Q@mail.gmail.com>
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
In-Reply-To: <CAA8EJppej++gbrWrRU9EFBntjzck4-9xbgS_sCPBfcxEofUo3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fzLlHxhe568XBH9bgIi7f3DpMcdkZvAq
X-Proofpoint-ORIG-GUID: fzLlHxhe568XBH9bgIi7f3DpMcdkZvAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_02,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=967 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040045
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/2/2023 3:20 AM, Dmitry Baryshkov wrote:
> On Fri, 1 Sept 2023 at 12:27, Nitheesh Sekar <quic_nsekar@quicinc.com> wrote:
>> Add phy init sequence and compatible string for IPQ5018
>> chipset.
>>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> ---
>> V3:
>>          Dropped 0 delay inits.
>>          Added static const type for m31_ipq5018_regs.
>> V2:
>>          Updated the commit message.
>> ---
>>   drivers/phy/qualcomm/phy-qcom-m31.c | 49 +++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
>> index ed08072ca032..ceee38695d7d 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-m31.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
>> @@ -82,6 +82,48 @@ struct m31_priv_data {
>>          unsigned int                    nregs;
>>   };
>>
>> +static const struct m31_phy_regs m31_ipq5018_regs[] = {
>> +       {
> C99 initializers, please?
Sorry. Missed it. Will update and post a new patchset.
>
>> +               USB_PHY_CFG0,
>> +               UTMI_PHY_OVERRIDE_EN
>> +       },
>> +       {
>> +               USB_PHY_UTMI_CTRL5,
>> +               POR_EN,
>> +               15
>> +       },
>> +       {
>> +               USB_PHY_FSEL_SEL,
>> +               FREQ_SEL
>> +       },
>> +       {
>> +               USB_PHY_HS_PHY_CTRL_COMMON0,
>> +               COMMONONN | FSEL | RETENABLEN
>> +       },
>> +       {
>> +               USB_PHY_REFCLK_CTRL,
>> +               CLKCORE
>> +       },
>> +       {
>> +               USB_PHY_UTMI_CTRL5,
>> +               POR_EN
>> +       },
>> +       {
>> +               USB_PHY_HS_PHY_CTRL2,
>> +               USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN
>> +       },
>> +       {
>> +               USB_PHY_UTMI_CTRL5
>> +       },
>> +       {
>> +               USB_PHY_HS_PHY_CTRL2,
>> +               USB2_SUSPEND_N | USB2_UTMI_CLK_EN
>> +       },
>> +       {
>> +               USB_PHY_CFG0
> What is the value written? While it didn't make sense to write 0
> delays, it is sensible to write 0 register values here.
Value to be written is 0. I will update this.
>
>> +       },
>> +};
>> +
>>   struct m31_phy_regs m31_ipq5332_regs[] = {
>>          {
>>                  USB_PHY_CFG0,
>> @@ -268,6 +310,12 @@ static int m31usb_phy_probe(struct platform_device *pdev)
>>          return PTR_ERR_OR_ZERO(phy_provider);
>>   }
>>
>> +static const struct m31_priv_data m31_ipq5018_data = {
>> +       .ulpi_mode = false,
>> +       .regs = m31_ipq5018_regs,
>> +       .nregs = ARRAY_SIZE(m31_ipq5018_regs),
>> +};
>> +
>>   static const struct m31_priv_data m31_ipq5332_data = {
>>          .ulpi_mode = false,
>>          .regs = m31_ipq5332_regs,
>> @@ -275,6 +323,7 @@ static const struct m31_priv_data m31_ipq5332_data = {
>>   };
>>
>>   static const struct of_device_id m31usb_phy_id_table[] = {
>> +       { .compatible = "qcom,ipq5018-usb-hsphy", .data = &m31_ipq5018_data },
>>          { .compatible = "qcom,ipq5332-usb-hsphy", .data = &m31_ipq5332_data },
>>          { },
>>   };
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
>
