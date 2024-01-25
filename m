Return-Path: <linux-kernel+bounces-37852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C4F83B68D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483381C20981
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634071876;
	Thu, 25 Jan 2024 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M3n2k0u5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4763AC;
	Thu, 25 Jan 2024 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146039; cv=none; b=IHKTEeaNZH2OZm87aWaHKbnblLmawKrZZ7oIvaSaTim577mDMZfPar/oCqvN42ScvqLhhEKGCkmZeJwQcKnoO11TrBqQE+26lD2RIzIRgpSx908KRiJzdi7U+WdWt/TV2HhGymDH3jGpubQ3/vpMFYbTCQnzbnfwxkRj0Xq7ViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146039; c=relaxed/simple;
	bh=fzIVD4+iNeDKu+naiK4AJN3iIhQwGewaGbZ+jAqOuc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rhCsSMrNzyZOgG4ygJJvMsc8NLusfRpY8869fCQpCWb6zqN7J3CpAHiE9i3F1F8HpgcWWjbvU0jJ9dWUFPb3WlstKLzj+vNlWkhRF0ifWPa+XzVdGrggtSNJXd9i0wS8M6i5PLBogGfkdkz8IH7CP7a7nBDUmCQ0MdfvhViLwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M3n2k0u5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P1GW5P019607;
	Thu, 25 Jan 2024 01:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pkKzpIJivU24Gq/A7L0jMdVZQ+GADmmmF/yu2uWfFUA=; b=M3
	n2k0u5xZvmlGeSoUZIrYiG+++9/WPLk+DCCB/dRBZjsNr8GWDeYmBQn1oy5Hb1UM
	mrVc5ElDff+LIv1zrYRQIK+Z+irTy1UEzxbX4SRZMitgNKoobbUASw8nWOh2ieCG
	uxJ9ax4G+NRkMAgOZSz7d6sn2FXRZ5Nt7FUFKC+pYUsDs5zcPKRNceORoLHZmCPF
	1TrOIC0YoUMR40meTrwvT9DmvczgD2yIM9BeqXS5k89SaZ3tlZmibuqOfSmOTeIY
	+DjgifZSTKD9/dZCVOe6Vre03CBujujowq+AQ6PumhH9x5r0TqWXKkrYYDF1l57x
	vzEodvhI41QTW2NaSigA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu1cchtb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 01:27:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P1RDNg007259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 01:27:13 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 17:27:07 -0800
Message-ID: <dbd47da6-9b25-4d24-9934-98b9d895b1ac@quicinc.com>
Date: Thu, 25 Jan 2024 09:27:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: modify the wrong
 compatible name
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240124023305.15755-1-quic_tengfan@quicinc.com>
 <20240124023305.15755-2-quic_tengfan@quicinc.com>
 <88e8cffb-024d-4f4d-ba1f-e0be9ee85e31@linaro.org>
 <CAA8EJpqXS97FXoTwiLaSeHHEDOeBFRPRbCNR6WF-ArDm22tu-Q@mail.gmail.com>
 <8b730cb5-871f-47b8-9abd-d8f39d3b8ec6@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <8b730cb5-871f-47b8-9abd-d8f39d3b8ec6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ImFp93GK5c4dEVdrcmrKmyyX92TPoneh
X-Proofpoint-GUID: ImFp93GK5c4dEVdrcmrKmyyX92TPoneh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=921
 clxscore=1011 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250008



On 1/24/2024 4:46 PM, Krzysztof Kozlowski wrote:
> On 24/01/2024 09:07, Dmitry Baryshkov wrote:
>> On Wed, 24 Jan 2024 at 08:38, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 24/01/2024 03:33, Tengfei Fan wrote:
>>>> Use right compatible name "qcom,sm4450-tlmm" instead of
>>>> "qcom,sm4450-pinctrl".
>>>
>>> Why do you claim this one is right and other is wrong? Provide
>>> arguments. To me the compatible looks correct.
>>
>> Yeah, but the driver (and the dtsi) use -tlmm
> 
> Are they merged? If so, it would be the argument for the commit msg.
> Just provide some rationale why this is done this way, not the other
> (fixing driver and DTS).
> 
> Best regards,
> Krzysztof
> 

This commit message is causing some confusion. I will update this commit 
messge for just provide retionale why is this patch needed.

-- 
Thx and BRs,
Tengfei Fan

