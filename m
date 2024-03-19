Return-Path: <linux-kernel+bounces-107250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E587F9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF75B1F2200F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406AF65190;
	Tue, 19 Mar 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hmkXb8Yt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8332B364;
	Tue, 19 Mar 2024 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837159; cv=none; b=CgAvE4g+fzl6sxUeePfT8npERKRoM0RLAMPN2niNrdNt6wGQHcqLAU62TKap1wT2swj6atrll5Tft0TVr6YcL96s3jhkRFljWnkt6j6gPdFqFW0jjcF9aSFdE8ECkhnLxCYMiOvU0f4np81kMCJP6pwnwZzrsdu+sS5vCGO70lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837159; c=relaxed/simple;
	bh=ixo4h0sm1HdR+DyLtPkwu2BzFHExC9+qcZOKojou8/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N3BKlBqaI8J6PgiB3dlUQNJRhv+g9/2Rg6T89uWVtnUUigKDXhFSbwcA0U8a30X7PoqQ3ckr0BwAMEdo/FvKuQoh/9SXPWx1hjKd+ASkAHsoOppDzkxLLiPEp5DaGJV8Zyv6aUOGOn6dJR+px8Uhv5/FFFxdY8gnaGi74gPjB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hmkXb8Yt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J65x5F008083;
	Tue, 19 Mar 2024 08:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iXtRita0/BgfzawOAnmeG3FaGNdHxP387PTjoetG0ME=; b=hm
	kXb8YtwEzWZxXNYi04BY5U7bE1fjYaAW/IxlAjV4pGLa609TiUW1HygZchFdnYqA
	YagVIhNqvgW37PbS6eSeaLX8VHRxFr7AqC3sc32tSJLamTmPugiW0NAeclZ+U0F6
	CnrV47ECS1qWGuShJMh5wYvyKhrYh2SVGRPR//kJ+KHfC/66mdFMNu6TaMi73v5A
	D0Aorp6yR4tVUU9X111uxABBLBPPDO4wVFPQ/MP5so2DgtnDJtaHnPH7uicfZVm4
	G5UvrrOrsU+pkBnweepMaXEHBwNKy/fSWGzep+R+ctDrd+eZtCrmPPdlaPF2lBxE
	1uSZRNM5kCZpzekuTN4A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy1j2gp4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:32:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J8WKQ4031678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:32:20 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 01:32:15 -0700
Message-ID: <3ca503a2-0d98-0555-a226-872dcedf6105@quicinc.com>
Date: Tue, 19 Mar 2024 14:02:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] phy: qcpm-qmp-usb: Add support for QDU1000/QRU1000
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay
 Abraham I" <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Amrit Anand
	<quic_amrianan@quicinc.com>
References: <20240311120215.16845-1-quic_kbajaj@quicinc.com>
 <20240311120215.16845-5-quic_kbajaj@quicinc.com>
 <CAA8EJpo7Zd-QxAxKFuo5zaR-=N8eBefpL=LcLQ9j+akhFQYUrg@mail.gmail.com>
From: Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <CAA8EJpo7Zd-QxAxKFuo5zaR-=N8eBefpL=LcLQ9j+akhFQYUrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 31_2DjJxo57CTm8TeMVCjezSnCpMV5Bl
X-Proofpoint-ORIG-GUID: 31_2DjJxo57CTm8TeMVCjezSnCpMV5Bl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190065



On 3/11/2024 5:41 PM, Dmitry Baryshkov wrote:
> On Mon, 11 Mar 2024 at 14:05, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>>
>> Add QDU1000/QRU1000 specific register layout and table configs.
>>
>> Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
>> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 52 +++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> index 5c003988c35d..e067574bea7a 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> @@ -1441,6 +1441,32 @@ static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_pcs_usb_tbl[] = {
>>          QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
>>   };
>>
>> +
>> +static const struct qmp_phy_init_tbl qdu1000_usb3_uniphy_pcs_tbl[] = {
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xc4),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x89),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0a),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl qdu1000_usb3_uniphy_pcs_usb_tbl[] = {
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
>> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_POWER_STATE_CONFIG1, 0x6f),
>> +};
>> +
>> +
>> +
> 
> Please drop extra empty lines.

Sure, will remove the extra lines.

> 
> Also the tables are more or less sorted out. Please move this to a
> correct place.

Will place the tables in sorted order.

> 
>>   struct qmp_usb_offsets {
>>          u16 serdes;
>>          u16 pcs;
>> @@ -1693,6 +1719,29 @@ static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
>>          .regs                   = qmp_v2_usb3phy_regs_layout,
>>   };
>>
>> +static const struct qmp_phy_cfg qdu1000_usb3_uniphy_cfg = {
>> +       .lanes                  = 1,
>> +
>> +       .offsets                = &qmp_usb_offsets_v5,
>> +
>> +       .serdes_tbl             = sm8150_usb3_uniphy_serdes_tbl,
>> +       .serdes_tbl_num         = ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
>> +       .tx_tbl                 = sm8350_usb3_uniphy_tx_tbl,
>> +       .tx_tbl_num             = ARRAY_SIZE(sm8350_usb3_uniphy_tx_tbl),
>> +       .rx_tbl                 = sm8350_usb3_uniphy_rx_tbl,
>> +       .rx_tbl_num             = ARRAY_SIZE(sm8350_usb3_uniphy_rx_tbl),
>> +       .pcs_tbl                = qdu1000_usb3_uniphy_pcs_tbl,
>> +       .pcs_tbl_num            = ARRAY_SIZE(qdu1000_usb3_uniphy_pcs_tbl),
>> +       .pcs_usb_tbl            = qdu1000_usb3_uniphy_pcs_usb_tbl,
>> +       .pcs_usb_tbl_num        = ARRAY_SIZE(qdu1000_usb3_uniphy_pcs_usb_tbl),
>> +       .vreg_list              = qmp_phy_vreg_l,
>> +       .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>> +       .regs                   = qmp_v4_usb3phy_regs_layout,
>> +       .pcs_usb_offset         = 0x1000,
>> +
>> +       .has_pwrdn_delay        = true,
>> +};
>> +
>>   static const struct qmp_phy_cfg sa8775p_usb3_uniphy_cfg = {
>>          .lanes                  = 1,
>>
>> @@ -2620,6 +2669,9 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
>>          }, {
>>                  .compatible = "qcom,sdx65-qmp-usb3-uni-phy",
>>                  .data = &sdx65_usb3_uniphy_cfg,
>> +       }, {
>> +               .compatible = "qcom,qdu1000-qmp-usb3-uni-phy",
>> +               .data = &qdu1000_usb3_uniphy_cfg,
> 
> Please keep the table sorted.

Will sort the table.

Thanks
Komal

> 
>>          }, {
>>                  .compatible = "qcom,sdx75-qmp-usb3-uni-phy",
>>                  .data = &sdx75_usb3_uniphy_cfg,
>> --
>> 2.42.0
>>
>>
> 
> 

