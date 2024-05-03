Return-Path: <linux-kernel+bounces-167432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8B38BA989
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C941F22A45
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28BE14F127;
	Fri,  3 May 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cHooHtXt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3F14E2CB;
	Fri,  3 May 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727511; cv=none; b=ulGswManYzK43yFjuMT1gS4Hf6pPAV4pHqSCYzXBy45Tm++0AvZ+GQ9uHL/W7rJUrarHde7OUy7A3ZtuxWaX8rC285cDmYGiNyXDjzpFsdssnF2NloNPO+cywIewkJ5RDeD4r0MyYRjjy+5a975UidQWEOUsQUUnClxgdyUamW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727511; c=relaxed/simple;
	bh=efRS0J2Mfz3BfrMBUM6bOn7BAON849782woB55PVO+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IX2e7rVNVquTN6EeuF7hLpCThRbj1yV5haPlXKJor3SUPnp1Fdt0QsT6lEBSeXcjw0btVxnrVRe+daXfksJksMTLQcDzRzDnyVEgQsPOjxUnp1Hb0ZZa7p6TQ9/3NhuYwdiibjGJEJraEAs3Bs8QFj29bxocp2upUX+eh9QfFvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cHooHtXt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4436rYn8030152;
	Fri, 3 May 2024 09:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5TYtEABa+Npo1ej5cnl3qJo/mPfhw85IRdYbSazcmzQ=; b=cH
	ooHtXthFEgtPrCn4gC0VJyzZx8GmFqzLH7Djgdx+DWz9se3Kg1Htq9tJ2Wd2BuAL
	cN6yX0QwzIDc4ewt2nALkr7LZFfcqjOiEh/FrpwC0tICYyK1hcywzGWBYWA+VmqP
	s2xsGFGw2pq296BOAk6V9azvbZcLC+Z/X6E0JtmakSl4btHqeIsGnWwPYJ+F+XDG
	BHefW5j97VLUePTf9p7xWwGuezKu9CfGA1l5y62CSe35rwsukBgeEpvAKm/zh2BM
	3TDcwUs2fOMZs2tfF1hXagpE4qwX+kyH8/2tJvL63mSIiElX9FHZ5ezYPGMiTsQ2
	5mD7tAyjtkO500WaWxyQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvmxyrsfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 09:11:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4439BhF5010268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 09:11:43 GMT
Received: from [10.216.42.60] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 02:11:39 -0700
Message-ID: <883248ce-23a7-1f41-aeab-67dc0828566b@quicinc.com>
Date: Fri, 3 May 2024 14:41:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] clk: qcom: gcc-ipq9574: Add BRANCH_HALT_VOTED flag
Content-Language: en-US
To: Stephen Boyd <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mturquette@baylibre.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20240502034247.2621996-1-quic_mdalam@quicinc.com>
 <2e05b0e246431d9dcf28c7135fff8231.sboyd@kernel.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <2e05b0e246431d9dcf28c7135fff8231.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xn3tNLO9LbxzwdmLuyROzMFXE30ijDug
X-Proofpoint-ORIG-GUID: xn3tNLO9LbxzwdmLuyROzMFXE30ijDug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_05,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030066



On 5/3/2024 3:38 AM, Stephen Boyd wrote:
> Quoting Md Sadre Alam (2024-05-01 20:42:47)
>> Add BRANCH_HALT_VOTED flag to inform clock framework
>> don't check for CLK_OFF bit.
>>
>> CRYPTO_AHB_CLK_ENA and CRYPTO_AXI_CLK_ENA enable bit is
>> present in other VOTE registers also, like TZ.
>> If anyone else also enabled this clock, even if we turn
>> off in GCC_APCS_CLOCK_BRANCH_ENA_VOTE | 0x180B004, it won't
>> turn off.
> 
> Are you seeing problems where we need to send this patch to stable?
Yes
> 
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> Any fixes tag?
Will add in next patch
> 
>>   drivers/clk/qcom/gcc-ipq9574.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
>> index 0a3f846695b8..f8b9a1e93bef 100644
>> --- a/drivers/clk/qcom/gcc-ipq9574.c
>> +++ b/drivers/clk/qcom/gcc-ipq9574.c
>> @@ -2140,9 +2140,10 @@ static struct clk_rcg2 pcnoc_bfdcd_clk_src = {
>>   
>>   static struct clk_branch gcc_crypto_axi_clk = {
>>          .halt_reg = 0x16010,
>> +       .halt_check = BRANCH_HALT_VOTED,
>>          .clkr = {
>> -               .enable_reg = 0x16010,
>> -               .enable_mask = BIT(0),
>> +               .enable_reg = 0xb004,
> 
> You could be more explicit in the commit text that you're changing the
> register offset to the voting register.
will update the commit message in next patch.
> 
>> +               .enable_mask = BIT(15),

Thanks for reviewing.
Regards,
Alam.

