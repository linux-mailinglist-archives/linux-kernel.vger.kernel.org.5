Return-Path: <linux-kernel+bounces-103030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AD587BA26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FE11C21B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA46F6CDB8;
	Thu, 14 Mar 2024 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UBqCNxL2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699914D9F9;
	Thu, 14 Mar 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407675; cv=none; b=UFgbsqn0vYHvFPXgXzqAMfTTl1CByMyGMifZxEeHJD0bZUF1w6rD39tWmPJLFnokDS/l7NCrLKuLKUuBODw6aUnkUz/IdcLhV1bI8rDbubOFniP0JrDOv7qTohZqRibnE9jmktHcduPB9roZY1YWkNUpemPrzcxhpfvUBBWf6R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407675; c=relaxed/simple;
	bh=yGECxDVBnHjeax8LXRZ/Y/zGcpZHh9rZqrLunVXFIiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U6UPZhkeS31XjwVca4aceImmvnnxHXfRKnjTcBq/jpFrVeHOLZm1j3YZ/M7r7aBkWWVjLuHvX3PISaynvu4I3AH6t/SucZiNYwFT7VRor5YRvEv92dirI4VZGhnPJStjBhm4WpxXm9U7Sm8OXEYPi3UX2vo/2TNf1766566KqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UBqCNxL2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E7HhqZ031313;
	Thu, 14 Mar 2024 09:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ACs28A64PZCK8xR1JHjXCW0uaEqfAaghLtlnmobTOXU=; b=UB
	qCNxL2jLNIU7rRqYwbuTE9ESHFC8Y/XbnB8FoTwVdCOQZS8k8HdCNkHsZpvCccrf
	nQ6BPs3XVvkKXiremkbGtSmGkZuo663dIs8xYsxGJsFDrSEVnhcxH9MqPYr/xMRq
	aSTbucVVRej5dyhD8M4EWzw6zAl5EdTCnZkvhgGShznZqi4pXksMqb2kynWfV1Ht
	52rrOkq7Ep04bLCYTFBvI3ldhRIwgEqBrsYaegAJ1cTS/fxZqcZDF8vnAX0qlWMi
	9bknApaMXN2vUUGtkEMziSkqngf2LIy5WzIMcXcAA8NUXmwXAP1m+JfAnJcoLhq2
	xD75hf4ZU/CWDVufYrQg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuujsrfs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 09:14:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E9ETH6025995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 09:14:29 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 02:14:23 -0700
Message-ID: <d5f9ff11-ebef-44e6-8f4c-d0a2beed1f8e@quicinc.com>
Date: Thu, 14 Mar 2024 14:44:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] clk: qcom: videocc-sm8150: Add index based clk lookup
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com>
 <20240313-videocc-sm8150-dt-node-v1-2-ae8ec3c822c2@quicinc.com>
 <CAA8EJpqsQr2nfDbW1JRyBoNSemudgrpxCRYH1y0ayX2Wd2u=VQ@mail.gmail.com>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <CAA8EJpqsQr2nfDbW1JRyBoNSemudgrpxCRYH1y0ayX2Wd2u=VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _bF-kjkkBD7tHgLJ7o5DjjJPKbtVpg9i
X-Proofpoint-GUID: _bF-kjkkBD7tHgLJ7o5DjjJPKbtVpg9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_07,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140063


On 3/14/2024 12:48 AM, Dmitry Baryshkov wrote:
> On Wed, 13 Mar 2024 at 13:11, Satya Priya Kakitapalli
> <quic_skakitap@quicinc.com> wrote:
>> Add support to look up for clocks using index instead of fw_name.
> Why? You are breaking compatibility with existing bindings.
> Also the commit message is incorrect. You are not _adding_ support.
> You are changing name-based lookup to index-based one.


As per the recent upstream discussions, I see that the clock names is 
not being allowed to use, it is recommended to use the index based 
lookup. Hence I updated this before adding the DT node.

Will update the commit text accordingly.


>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>>   drivers/clk/qcom/videocc-sm8150.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/videocc-sm8150.c b/drivers/clk/qcom/videocc-sm8150.c
>> index a0329260157a..2b788a03c5ed 100644
>> --- a/drivers/clk/qcom/videocc-sm8150.c
>> +++ b/drivers/clk/qcom/videocc-sm8150.c
>> @@ -19,6 +19,10 @@
>>   #include "reset.h"
>>   #include "gdsc.h"
>>
>> +enum {
>> +       DT_BI_TCXO,
>> +};
>> +
>>   enum {
>>          P_BI_TCXO,
>>          P_VIDEO_PLL0_OUT_MAIN,
>> @@ -49,7 +53,7 @@ static struct clk_alpha_pll video_pll0 = {
>>                  .hw.init = &(struct clk_init_data){
>>                          .name = "video_pll0",
>>                          .parent_data = &(const struct clk_parent_data){
>> -                               .fw_name = "bi_tcxo",
>> +                               .index = DT_BI_TCXO,
>>                          },
>>                          .num_parents = 1,
>>                          .ops = &clk_alpha_pll_trion_ops,
>> @@ -63,7 +67,7 @@ static const struct parent_map video_cc_parent_map_0[] = {
>>   };
>>
>>   static const struct clk_parent_data video_cc_parent_data_0[] = {
>> -       { .fw_name = "bi_tcxo" },
>> +       { .index = DT_BI_TCXO },
>>          { .hw = &video_pll0.clkr.hw },
>>   };
>>
>>
>> --
>> 2.25.1
>>
>>
>

