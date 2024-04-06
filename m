Return-Path: <linux-kernel+bounces-133761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA189A840
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2881F21C54
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5C18029;
	Sat,  6 Apr 2024 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nUEmvF9k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3341798F;
	Sat,  6 Apr 2024 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366974; cv=none; b=QqVhWWUUmVXEIYLNM9d1mlSju2OeLFfTg99CfnSQr9PQ9KUstRW8p3aMiYNK3+AcZS3LV/1Tq8plyt2tThEy6XhsU1d3IbKymh0Px2dfL8VZaI/xpa2XASef+iyvdRluuYeJ9OFUGWGnOOQTZAy8Sr9gPrXz0v9k26OM3pDXQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366974; c=relaxed/simple;
	bh=NsHQ/imKT0d/0cboJ2thWKSIH7tqL+1bHVMysKlX4Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h/qJJSYkBDeWxjYbkJ7+x+LDO/DQuhXMC1hw4b1bc/aPrL9kxVBdJnXgr49tDx1/uDGyGBLYCaUrNccaB981X8cj0Fg0i9o1v+rjqjYvJiEqyfwm1vL7vLAW6zm+Tmne1/ty5ATiqA9SucVGPSYDjoWYa0Tchcau9lVc3Gtwpy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nUEmvF9k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4360oWSF006625;
	Sat, 6 Apr 2024 01:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QojhALS8RST3msugK13RJ0F9CH18lEsP2QIYK2u8P20=; b=nU
	EmvF9kr5kvNbGzSRybcUYWry325OkJvKC1GlycpotIYUh+OhtNBvGA0n6dkqM4eL
	SYwgU7gXuUlmCITFV1xNU/t9XtQjYPkaIUFYxabIJCRinWl3TScU2u1g7vQ2aCEk
	wdhCdNZLfmU9NYM+6rlsXRXd0V01Iowf5hzNSiKWqGF9kV24SoC5ve4SMDJgQlq9
	FulBV4ZJHqm+8TnOoFPxf0eBz3CbbaSNFfTX9YYu7Otmp1XVVceYcuQq8eMNQlIy
	bS/NeghodAUECL1BZyG+H69h5xd/DJ5yQm2DEhz2UXzfzRh9hBLT5wxP8Id/CeWm
	0TzFKBCs5svNLc8DjdBQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xafpksmbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Apr 2024 01:29:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4361T9G3026757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Apr 2024 01:29:09 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 18:29:07 -0700
Message-ID: <907632cd-ce3e-4868-92c8-8a79d09fa011@quicinc.com>
Date: Fri, 5 Apr 2024 18:29:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/7] spmi: pmic-arb: Add multi bus support
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold
	<johan@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20240402-spmi-multi-master-support-v8-0-ce6f2d14a058@linaro.org>
 <20240402-spmi-multi-master-support-v8-7-ce6f2d14a058@linaro.org>
From: David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20240402-spmi-multi-master-support-v8-7-ce6f2d14a058@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DzLzYEJ86RzxmAT8-h-u_ubXkHxLSS4A
X-Proofpoint-ORIG-GUID: DzLzYEJ86RzxmAT8-h-u_ubXkHxLSS4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_31,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=754 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404060010

On 4/2/24 05:07, Abel Vesa wrote:
> +static void spmi_pmic_arb_deregister_buses(struct spmi_pmic_arb *pmic_arb)
> +{
> +	int i;
> +
> +	for (i = 0; i < PMIC_ARB_MAX_BUSES; i++) {

s/PMIC_ARB_MAX_BUSES/pmic_arb->buses_available/

This is needed to avoid a NULL pointer dereference in the case that a
single SPMI bus is specified in DT and then removed at runtime.

> +		struct spmi_pmic_arb_bus *bus = pmic_arb->buses[i];
> +
> +		irq_set_chained_handler_and_data(bus->irq,
> +						 NULL, NULL);
> +		irq_domain_remove(bus->domain);
> +	}
> +}

Thanks,
David Collins


