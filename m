Return-Path: <linux-kernel+bounces-51570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804CA848CA2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579CF1C210FD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31F71B5B3;
	Sun,  4 Feb 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n7CYokBT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B80B1B582;
	Sun,  4 Feb 2024 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707040777; cv=none; b=Acp1xXLc7tQeIliDw4UgPVupYFJBB/aG7Ug0x3CRGI2cvwiE3jaynmJ2woxE++z5ov9BfZrS3ndnFaU6o8+Vqmb/10H7nbQJPzxaM5mQ0dNgZbUDm6EZ66axrfm+pyiSFhc4FerN5gtbnwNTKFwMv8FtXfJrCmwGEup2Rg8vQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707040777; c=relaxed/simple;
	bh=PREsO0fDn5ks0m6BkKrklGoIT157BD8L8D9Y5xRwnpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MWzBEiGH0RmmWiIded/rhGwpMFE4QYERGwntuTFdXv6EOcN1hLWHtVAvBVXrxVN0LN9zI38oRbWRwwrCbhTlPCYzN77tTIYQ5gPCGdzfNnrpL/JCKPHpL9akAIVH2k/RmyNfxesIA/es2WYsN5xw7ebXd2Rub9fAsufvI8l/4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n7CYokBT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4149uIou002651;
	Sun, 4 Feb 2024 09:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tmDZogz+xOwkuZlnDnPxKEWbHLw0ooZZybvU2YEDlg4=; b=n7
	CYokBTfMrYx4h15SvgxU1+rjFXTj0wKVA5iHN/WJrRwbFb5fsdwXaE7FsNsTNs1V
	g0bLdn/kKc1BWOIOErg8rI3sxXIJLlURYehbCwGep3jh4YaY4VNi2WYtI9kG2TGd
	l74c3qopTODCq1RigzKhY5+2haGrYJaNepipdQJFMZcj9jbO8N72Oxj0UfwfuCPE
	ld/7jAXddPXJtVRMNVTgNFpa2kN2oHHh6N8ZOA8WFSWPzNZkDoK6ChbdLCUcz+s2
	/UNb2elfl/KXKjeXk3SPxYVg/7IBFrQqFeeB+LPzU2arXwUJI5sWn1b2q5Ar5GxI
	4kOrEVIyjuB5uJ5cJtZA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1f40sjd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Feb 2024 09:59:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4149xHnA020742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 4 Feb 2024 09:59:17 GMT
Received: from [10.253.73.69] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 4 Feb
 2024 01:59:12 -0800
Message-ID: <7d86388d-15f5-4e72-b99f-aee3b47a5232@quicinc.com>
Date: Sun, 4 Feb 2024 17:59:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 2/3] net: mdio: ipq4019: add support for
 clock-frequency property
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell
 King <linux@armlinux.org.uk>,
        Robert Marko <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240130003546.1546-1-ansuelsmth@gmail.com>
 <20240130003546.1546-3-ansuelsmth@gmail.com>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20240130003546.1546-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RA8x5ZYS1QVVacm8q5u3nrlWgkvWcodj
X-Proofpoint-GUID: RA8x5ZYS1QVVacm8q5u3nrlWgkvWcodj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402040076



On 1/30/2024 8:35 AM, Christian Marangi wrote:
> +
> +	/* If div is /256 assume nobody have set this value and
> +	 * try to find one MDC rate that is close the 802.3 spec of
> +	 * 2.5MHz
> +	 */
> +	for (div = 256; div >= 8; div /= 2) {
> +		/* Stop as soon as we found a divider that
> +		 * reached the closest value to 2.5MHz
> +		 */
> +		if (DIV_ROUND_UP(ahb_rate, div) > 2500000)
> +			break;

Hi Christian,
Sorry for the delayed review.

The MDIO hardware block supports higher frequency 6.25M and 12.5M,
Would you remove this 2.5MHZ limitation? On the IPQ platform, we
normally use 6.25MHZ.
> +
> +		priv->mdc_rate = DIV_ROUND_UP(ahb_rate, div);
> +	}
>   }

