Return-Path: <linux-kernel+bounces-156656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83008B0661
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF071C22B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445791591E8;
	Wed, 24 Apr 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y4j1cJv1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07A1E4A9;
	Wed, 24 Apr 2024 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952118; cv=none; b=UtAHjaU0Sd1pQGcSPW8gMr3l4viAMna5aSE2f3Ap8X2SfQlM4htxwQG0Fb84sMiCi3YISalvoespueKWqxfCsEvBSukHjJzpcsnVkAJ8dC4sPaeq/wOSL6wvYeRD9Hj3Kez5XQ+Ez0wgtHxoXK8u/Ao6z3LeEP/YbnXy/V3qRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952118; c=relaxed/simple;
	bh=qFeAqbZquuywth8gAciMHzmJRLCm3ua07vYvCDODKpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hqWEZy3m/uH5Ot4hzoVDHsFv8ntn+T/OXqiaDCyOYtMFajVhTddywDnbRHBSHIJeIf2q4hEPWuDRSRY3wPg5CKFDHLa5TDWoX6DXyOcgpZ1i4YPVXg5IZ+6v84lWRd6ND+kkUikIbNxH6S2XMvQx+GSaMvb8cyvC2GLfXC0bpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y4j1cJv1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O8Cjvt010801;
	Wed, 24 Apr 2024 09:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lm2WXy/93BOQFkB7wmh4mOt9I25v0ikGhyWwcZ/oo+M=; b=Y4
	j1cJv1UV3Al/68nfpARd8wA58RnyCQddb1GjndW9W9ycgP2HjEDLmg3ZXQsOyuHd
	2aL7IqLnl0Ets0IDHHtTESBMHYm1CgTQZsSPcY8STzCcFIY9XT91uR+QN3Ay7P5N
	PBPIJTHjjilqAm1S8u05Dd4c1N7sOd7BGd3+OIf/hLUWlJBQLOCNdtGj8PXRSdpI
	EeySiu3caCZk6ix6C7fmdB3r1bV6bw/VsA0LWEI2aZKaFWIsJO26bXcDma8g30Ob
	40RV7VZnxcnMo3+QyDYzREwcUoFaasoKIhXCQTa4rcfDLQ3jjEOgOl/tLXr7cEXM
	UqhlFgg6xrKM/BO/OSDQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9grf89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:48:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O9mRKM019862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:48:27 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 02:48:18 -0700
Message-ID: <a2efd882-2d69-490b-8362-c87e10dc625e@quicinc.com>
Date: Wed, 24 Apr 2024 15:18:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to
 switch video GDSC to HW mode
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "Andy Gross" <agross@kernel.org>,
        Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
 <20240413152013.22307-5-quic_jkona@quicinc.com>
 <3592cea4-7e5c-448a-83c0-562b4ef4e7a1@linaro.org>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <3592cea4-7e5c-448a-83c0-562b4ef4e7a1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OchKsveoWUoNiHZS7jF9lroVeA45wQkR
X-Proofpoint-ORIG-GUID: OchKsveoWUoNiHZS7jF9lroVeA45wQkR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240041



On 4/23/2024 4:24 AM, Konrad Dybcio wrote:
> 
> 
> On 4/13/24 17:20, Jagadeesh Kona wrote:
>> The HW_CTRL_TRIGGER flag provides flexibility to switch the GDSC
>> mode as per the consumers requirement compared to HW_CTRL flag which
>> directly switches the GDSC mode as part of gdsc enable/disable.
>> Hence use HW_CTRL_TRIGGER flag for vcodec GDSC's to allow venus driver
>> to switch the vcodec GDSC to HW/SW control modes at runtime using
>> dev_pm_genpd_set_hwmode() API.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
> 
> The commit title states clk: qcom: yet the only files changed are:
>

Thanks Konrad for your review! As there are 2 files with similar 
changes, I didn't mention file names in the commit title.

>>   drivers/clk/qcom/videocc-sc7280.c | 2 +-
>>   drivers/clk/qcom/videocc-sm8250.c | 4 ++--
> 
> With no explanation as to why anywhere
>

Sure, will update the target specific details in the commit text of next 
series.

Thanks,
Jagadeesh

> Konrad

