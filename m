Return-Path: <linux-kernel+bounces-129640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F73E896DB1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25571290CD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A4914199C;
	Wed,  3 Apr 2024 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mbGnKHMB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9B71736;
	Wed,  3 Apr 2024 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142477; cv=none; b=QlK6mznj8PVdNXlIF/BW8BZ9/GVE5Yz21e/QFgC+1YGciMcvNpZwJFWk5WzrKMJMkhrPdUqxbtJvECF6WpfEZpx33wPHRWmuVgQxQQMaxMTTNwaEgTfFwSePtKqU9vSTEhiyH7IZgNIHiwR5L10Cc7Jl0tIDZ14qJ6P7N5P4rH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142477; c=relaxed/simple;
	bh=i84szZpHxYivPaf7yucT85uFEyY97k9I9t0K8390Qrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f1SY3dOVOuxfm5knc8Tvxq0gCoE+7ZtF2T48Z7sCYHqppkwGUGhU15PoJ2CtqloF2jChAptZAkDsBlPaHPhstfNFeVpv84p/3iI11uMeCk/JZxsdMHNJrCjFNAwZXaP5LSZeyorD1F/uSPokH9QSKhLp6ywuCVqJO7zE+0r1DVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mbGnKHMB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4336BL1Q004804;
	Wed, 3 Apr 2024 11:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SWVS0En1pP+DXPeCTmcGz+sebPgJGOg8nGz1gdr4C4I=; b=mb
	GnKHMBNuK+7foXBBzRSh7sBoTLQdoadEqDmYp3ldzKd59lERFGqgrQSsoEfNLwc3
	uAFNssnZq2WfilT6iemAU0TvHfN3XZ+haJk+z4tuZkv3wmWes+YJdI9MmajO8+IO
	Y2VLVmAfXlvigv+tWz55IJ3C6cQuSJ8B4OwIqOAbCl3De1ollBDLXA3g/qr70kEw
	k9rQieY+bOVei0d9HfUf+epV78/Z6VD85PqrPxvB1/DtO8/MmDzk0rVTXy2sgwJ5
	VAd1wPS7WVes0L2ZlsTlPLmLNfT3Dc+YU0JmsBAdGtAgXDRMaIK/MTqQuX60thcg
	JFzUaLumxDqqzyfx5i/Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9077grt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 11:07:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433B7nMp023264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 11:07:49 GMT
Received: from [10.218.10.146] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 04:07:44 -0700
Message-ID: <af0dae12-c9aa-b0b0-67fd-f52d94566809@quicinc.com>
Date: Wed, 3 Apr 2024 16:37:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/7] clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override for
 LUCID EVO PLL
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
 <20240330182817.3272224-2-quic_ajipan@quicinc.com>
 <d8c0ca00-7e14-454e-8a65-5dcf14ed7796@linaro.org>
 <e2f108d8-0b25-d799-fbe4-ab6256966982@quicinc.com>
 <da93a8ed-4fbb-488f-a1af-e701f7191fbd@linaro.org>
 <CAA8EJppB7dYvzeA0M6A_cN14FkC6K8WpLVoeE8NvytGcYDq5Pw@mail.gmail.com>
 <990d74fa-6d1d-4d64-b6fb-c68f5763c9d3@linaro.org>
From: Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <990d74fa-6d1d-4d64-b6fb-c68f5763c9d3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5wTflKlFKc3rvmrvBlQW-0Zs3zqSuWeG
X-Proofpoint-ORIG-GUID: 5wTflKlFKc3rvmrvBlQW-0Zs3zqSuWeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=894
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030077



On 4/3/2024 2:20 PM, Krzysztof Kozlowski wrote:
> On 03/04/2024 10:37, Dmitry Baryshkov wrote:
>> On Wed, 3 Apr 2024 at 09:49, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 02/04/2024 20:35, Ajit Pandey wrote:
>>>>
>>>>
>>>> On 3/31/2024 12:49 AM, Krzysztof Kozlowski wrote:
>>>>> On 30/03/2024 19:28, Ajit Pandey wrote:
>>>>>> In LUCID EVO PLL CAL_L_VAL and L_VAL bitfields are part of single
>>>>>> PLL_L_VAL register. Update for L_VAL bitfield values in PLL_L_VAL
>>>>>> register using regmap_write() API in __alpha_pll_trion_set_rate
>>>>>> callback will override LUCID EVO PLL initial configuration related
>>>>>> to PLL_CAL_L_VAL bit fields in PLL_L_VAL register.
>>>>>>
>>>>>> Observed random PLL lock failures during PLL enable due to such
>>>>>> override in PLL calibration value. Use regmap_update_bits() with
>>>>>> L_VAL bitfield mask instead of regmap_write() API to update only
>>>>>> PLL_L_VAL bitfields in __alpha_pll_trion_set_rate callback.
>>>>>>
>>>>>> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
>>>>>>
>>>>>
>>>>> No blank lines between tags.
>>>>>
>>>>> Add Cc-stable tag.
>>>>>
>>>> Sure, will update in next series
>>>>
>>>>> Please do not combine fixes with new features.
>>>>>   > Best regards,
>>>>> Krzysztof
>>>>>
>>>>
>>>> Actually this fix is required for correct scaling for few frequencies in
>>>> this patch series, hence combined them together and pushed this fix as
>>>> first patch in series so that they get mainlined together and feature
>>>> functionality will not get impacted.
>>>
>>> OK, that's fine but usual way is that such need is expressed in the
>>> cover letter, so maintainer will know what to do. What if this patch
>>> should go to fixes and rest normally to for-next? How do you expect
>>> maintainer to apply the patch? Entire thread and then manually move the
>>> commits? Why making it so complicated for the maintainers?
>>
OK, for the ease and more clarity I'll update the cover letter with fix 
details and required dependency on this feature in next series.

>> Huh? I think it's pretty normal to have fixes in front of the patch
>> series. Having it in the middle would be troublesome indeed. You are
>> the first person to complain.
> 
> No, I am not the first. It differs between subsystems and I do not
> recall all folks, but the one person coming to my mind is Mark Brown who
> expressed it numerous times.
> 
> Best regards,
> Krzysztof
> 


