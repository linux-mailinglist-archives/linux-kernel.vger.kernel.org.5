Return-Path: <linux-kernel+bounces-116569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCDF88A0CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9941C359A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E15013C66F;
	Mon, 25 Mar 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LCXDPU0n"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C85C614;
	Mon, 25 Mar 2024 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711346972; cv=none; b=YJtNUo5Lz6nlT1cnCR1m+OfUNvmu+Ze/L84vJ4IvG4AkNXtfDN5S5PxahqpRTHsqTWw8xBRFfXYUvYoOZucwFyaZw2Usb3Vbud3KSOVfJtV8PPk0t1OYvNR9zFBPSOmeoGs1HcLjPpUYWk+O95l38glxxrishUV3QkxvXx7UMuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711346972; c=relaxed/simple;
	bh=DE6LIhbj2UWB34h0kcc4YDXBhEQORzOM6Xr5dm6Y+ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WSABC5rGlk0cVeNFon4qk7tL5K+V4KdbVomxSvSZh5Jcgpm1fGHLPtV2YvERMdlg8vFYsKCuQbTgUrsvp6kjfXQ6MD0J5k06bNA1JmWQPBcXv0AIjgANVsLe5wd+KmT5n+VU1nJtURQVoL7dNLeaRmjBGXDaTvSFeJ+RLu4bk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LCXDPU0n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P5rvEW026409;
	Mon, 25 Mar 2024 06:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PegxpEvd0+L0qenFnWPXNgTT/ypGzE73VwaQXWGfaY8=; b=LC
	XDPU0nASERXK3+z9bi21Nbd1uqCVgnHzyDrXcagQ9SiqkXelwbtq+zKrc12y4pQB
	dHCxrlpfd4v1ZvN5KsygqZi1V5ujblnNKR+urSDWEKbyJLOZ1UvlmvExx2MmkoE1
	w4weGyhMOVp7cV4uksToKD6H0rbyPBhGd1LBSxjGM4BzsN6dLdZFlCyqvRz0GcSc
	wfvCKXNMrijb7IdFZv0keQ6zm+xBbsxRF/atH1OEko6CUajiCJdaArgqG9HtDlXS
	LpgjxWC7zfam1IPQOu49EnW/StmtB+TgRuTFQb8x9IP/DxHerg7beb+OhPQO/gdv
	I265kTtKffpDvevpP2yQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x1mskpcvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:09:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42P69NWd019019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:09:23 GMT
Received: from [10.216.57.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 24 Mar
 2024 23:09:17 -0700
Message-ID: <ca66f8d7-da6f-4cc4-8d28-c35fcc5d2ba1@quicinc.com>
Date: Mon, 25 Mar 2024 11:39:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 2/6] clk: qcom: videocc-sm8550: Add support for
 videocc XO clk ares
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-3-quic_jkona@quicinc.com>
 <909591c5-d18a-4a9a-b276-c4a3b3c823f9@linaro.org>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <909591c5-d18a-4a9a-b276-c4a3b3c823f9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bpMIPXd_5TIad_bM3ZITXh-YJp7Ntnb0
X-Proofpoint-GUID: bpMIPXd_5TIad_bM3ZITXh-YJp7Ntnb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_03,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250032



On 3/23/2024 6:00 AM, Konrad Dybcio wrote:
> On 21.03.2024 10:25, Jagadeesh Kona wrote:
>> Add support for videocc XO clk ares for consumer drivers to be
>> able to request for this reset.
>>
>> Fixes: f53153a37969 ("clk: qcom: videocc-sm8550: Add video clock controller driver for SM8550")
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
> 
> I think I might have asked already, but I'm assuming these resets
> are also there on 8550, since the hw seems to be mostly unchanged
>
Thanks Konrad for your review.

Yes, videocc XO clk ares is present on 8550 as well, hence it is safe to 
model this reset for both 8550 and 8650.

Thanks,
Jagadeesh

> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad

