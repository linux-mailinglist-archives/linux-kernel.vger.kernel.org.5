Return-Path: <linux-kernel+bounces-133759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31989A83A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03181F21CEC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36FFC11;
	Sat,  6 Apr 2024 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l4YvvlLb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7612F22;
	Sat,  6 Apr 2024 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366953; cv=none; b=foE73pQJKz8OWQcdvf3P6uB5XNYBo3rq0h++jygJiqqpOunPwN+JMI37+RAii07Qo6y8pNIohOwakfc09l1ScCjka2vEijmUmo8YT1FxH578C7V6Unz9WdV13fvP1p6JUJjOJLi8Pwd+htIVvZHNZRxnEnusmxaOgcqJxqI3YXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366953; c=relaxed/simple;
	bh=om7AZpyPz67p/p8oMyDm6zaY4jVsX1OFAgVd2K8gmyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YB7oXF2hmuGFEZDGD/PUSOwjMSymPJf0ALhvtfRITdPtjhY4JYfDnT023LZw5IWrYA66Co/Bqq4P9gqXO2GhNzZcLD0jUiGYlTi9/TPC19dKTiLg/BdVvDOCOxG2P0e3t/TZkYqwvtyhRROgr3Ii8aCM80Ju+PC+Y7TSrIoGD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l4YvvlLb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4361JHSf026939;
	Sat, 6 Apr 2024 01:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+8aeLRDcutyaciqRgLP8Mis5NQ1ZL5M9w2DhTLXBu50=; b=l4
	YvvlLbkadFf93AokeGI7wjtk6EfDoExTXwzb8XTxreuhrT7ASMVimkodPP4zrc86
	kMtdVeG3bpc262GMB1kzzSwFy0GqooYPEUZVxK6STLVWMHAHpU1O+MLfKQeojwM9
	OeCHdsbkaqNIrIgf85RDkmQ6Sl+YEwetolx0lOJpMWvF+I4dlxZiJ6/bij/jJC0Y
	U7yjc4QExWJkm0A/z9P2FD7lFV6iQKHedneY+s5R6tvxNKydi6kPmnn5rcu3Nqa6
	VOzWzM/So5OYLabIK29QzIiLP+iGL1zbKAcYlkbO+pzFkbrXt+AQnSHuHZTTxrHb
	k0bUFwV7IiBglA+rUECw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa7m5jjp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Apr 2024 01:29:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4361Sx1M026496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Apr 2024 01:28:59 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 18:28:58 -0700
Message-ID: <0c7b34c6-b205-49cc-bedb-82cad6725660@quicinc.com>
Date: Fri, 5 Apr 2024 18:28:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] dt-bindings: spmi: Add X1E80100 SPMI PMIC ARB
 schema
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
        <devicetree@vger.kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240402-spmi-multi-master-support-v8-0-ce6f2d14a058@linaro.org>
 <20240402-spmi-multi-master-support-v8-1-ce6f2d14a058@linaro.org>
From: David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20240402-spmi-multi-master-support-v8-1-ce6f2d14a058@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IEnKgIA8KzALzZcL1_1I3cf6QHZt8slm
X-Proofpoint-GUID: IEnKgIA8KzALzZcL1_1I3cf6QHZt8slm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_31,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 mlxlogscore=832 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404060009

On 4/2/24 05:07, Abel Vesa wrote:
> +  reg:
> +    items:
> +      - description: core registers
> +      - description: tx-channel per virtual slave regosters

Minor: s/regosters/registers/

Thanks,
David Collins


