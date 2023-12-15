Return-Path: <linux-kernel+bounces-459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED76814171
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2092826AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A98B7492;
	Fri, 15 Dec 2023 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BbIWE6PJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712251C31;
	Fri, 15 Dec 2023 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF3Ps0Y008016;
	Fri, 15 Dec 2023 05:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lNyS6XOOhGk9188CugqQXE0AbjhCg2iwozC+KlPC2+w=; b=Bb
	IWE6PJ4v0UF1VzhXGTxDPmN+dqZgwR1Itiixv0Nidsubvgk3wJanouPAxQwXW2ch
	nBqE+nvAj5RGsN0GbohXAHNdTrxJ1J8CjWQH80l2Gl2VqALLXmp9sDD/Z3mHKhvn
	PjImWLYwZjSSV7wXBxeUwtsm/gw7Ymg1TijOHhhs1mbckxtI8Y1Xbi27GTCxM/Cd
	LkrLLhiHJgXgB89q494P2CngIuDXEMwQtuq64IQHLDjBc9tdFJYNe/3y3GEHV34q
	LUc3hz0i1OhrzEfCNPbDtlLDkAIgSExGJtCsAgASqC0BbRObbwgzIl+jPbV9Henl
	/R0NwoNNuBGrnEashkWg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0741j227-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:44:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF5iHFe009359
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:44:17 GMT
Received: from [10.201.3.91] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 21:44:09 -0800
Message-ID: <6a3895ad-7da3-49c0-a7a0-7dd1031e0544@quicinc.com>
Date: Fri, 15 Dec 2023 11:14:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] clk: qcom: ipq5332: Add separate clocks for PCIe
 and USB for Combo PHY
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <quic_nsekar@quicinc.com>, <quic_srichara@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
 <20231214062847.2215542-3-quic_ipkumar@quicinc.com>
 <CAA8EJpr61JuznqfdMG96mjrqquf2Qbfe=potB5vzk43XexWj2w@mail.gmail.com>
Content-Language: en-US
From: Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <CAA8EJpr61JuznqfdMG96mjrqquf2Qbfe=potB5vzk43XexWj2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p7j-yoodYOO4QQRr6l0cSrWkm_bl4Uet
X-Proofpoint-GUID: p7j-yoodYOO4QQRr6l0cSrWkm_bl4Uet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=931 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150033



On 12/14/2023 12:39 PM, Dmitry Baryshkov wrote:
> On Thu, 14 Dec 2023 at 08:29, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>> Qualcomm IPQ5332 has a combo PHY for PCIe and USB. Either one of the
>> interface (PCIe/USB) can use this combo PHY and the PHY drivers are
>> different for PCIe and USB. Hence separate the PCIe and USB pipe clock
>> source from DT, and individual driver node can be used as a clock source
>> separately in the gcc. Add separate enum for PCIe and USB pipe clock and
>> change the parent in corresponding structures.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Please use your full name for the git authorship and or the S-o-B
> tags. This applies to the whole series.
My full name is "Praveenkumar I". In my region, we used to have only the 
initial letter of surname.

--
Thanks,
Praveenkumar
> Other than that:
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
>> ---
>>   drivers/clk/qcom/gcc-ipq5332.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
>> index f98591148a97..aa0f616c3b1b 100644
>> --- a/drivers/clk/qcom/gcc-ipq5332.c
>> +++ b/drivers/clk/qcom/gcc-ipq5332.c
>> @@ -25,7 +25,8 @@ enum {
>>          DT_SLEEP_CLK,
>>          DT_PCIE_2LANE_PHY_PIPE_CLK,
>>          DT_PCIE_2LANE_PHY_PIPE_CLK_X1,
>> -       DT_USB_PCIE_WRAPPER_PIPE_CLK,
>> +       DT_PCIE_WRAPPER_PIPE_CLK,
>> +       DT_USB_WRAPPER_PIPE_CLK,
>>   };
>>
>>   enum {
>> @@ -728,7 +729,7 @@ static struct clk_regmap_phy_mux gcc_pcie3x1_0_pipe_clk_src = {
>>                  .hw.init = &(struct clk_init_data) {
>>                          .name = "gcc_pcie3x1_0_pipe_clk_src",
>>                          .parent_data = &(const struct clk_parent_data) {
>> -                               .index = DT_USB_PCIE_WRAPPER_PIPE_CLK,
>> +                               .index = DT_PCIE_WRAPPER_PIPE_CLK,
>>                          },
>>                          .num_parents = 1,
>>                          .ops = &clk_regmap_phy_mux_ops,
>> @@ -1072,7 +1073,7 @@ static struct clk_regmap_phy_mux gcc_usb0_pipe_clk_src = {
>>                  .hw.init = &(struct clk_init_data) {
>>                          .name = "gcc_usb0_pipe_clk_src",
>>                          .parent_data = &(const struct clk_parent_data) {
>> -                               .index = DT_USB_PCIE_WRAPPER_PIPE_CLK,
>> +                               .index = DT_USB_WRAPPER_PIPE_CLK,
>>                          },
>>                          .num_parents = 1,
>>                          .ops = &clk_regmap_phy_mux_ops,
>> --
>> 2.34.1
>>
>>
>


