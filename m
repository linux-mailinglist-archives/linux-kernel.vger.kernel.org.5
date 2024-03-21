Return-Path: <linux-kernel+bounces-109872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B9A8856E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F1FB223BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3423C5645B;
	Thu, 21 Mar 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jl4Iulz6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63454BF7;
	Thu, 21 Mar 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014978; cv=none; b=cd7DhBuTFXAmXPrXvxS61c+hsqJlk5jpaFlGjcbvodfzyUZ53ZB8T9VaiydIQyvfEEojs7EPe5QAtEOBVG9yf/OWWqYqDg26Vj7Z8WqcM7g9XSaymJ9+849I4sWndmFG5l3Nkoa4sqfuHXXrd9ss686F/XxEZIFt7xLjraAvu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014978; c=relaxed/simple;
	bh=z4bJqEtjpB9p3LfYAUeEPJKZF2/fyX+8gXt0JX5QHf8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWqjWhaYzFVhtqgFCUUe5DswQkbfo1yq7fnJ52m4uQiLL0vNDw4s5Iybk7QPms7lL8f6D5WmOA4gYjKSK4o/quwfQo+OByMUStP7qa+UIduHvxeRM0Lh8nNSxgZ3pXK8+x4cEJ6UkmnQJYGK31q/laR98v15LfOQfkdaJ04rd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jl4Iulz6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L6Ro2A015321;
	Thu, 21 Mar 2024 09:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=HZHFgDwoldRyoSYtch7A+
	4TF5Dl0TrYZYdY3wcOp7Uo=; b=Jl4Iulz6v3+q8FOaRD2QpH2SvR20rDibLOyzH
	Bt6nC7mwfDd6PAKqzuwGiICHt8I5pXGRQRoV/UtOK/WOufLyr2eWwcPnu7tMYmdw
	HR2zDoyReziDMT2zQTnWC0TdoWL1frqjwwzJmxKVUtM2XCt3I31R8x+ftdxhbt2V
	R2nA7My25/XHJtq77MhtpgLtyQ7EpF5o7U4iUQLNB1TwekMDJBxZf6NaaLvP+I9N
	eOgTyCwo17qANf5T4mCsLofZ7X4tf11sdMCrAfEFA5FEjan2nlTWDr0LwP581aME
	7Yu/jY1LAslih4psfrAXtN9T+ZL9LjC+ddfcipb7Te7eDCvxw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0fmwgdrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 09:56:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L9uAWl011238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 09:56:10 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 02:56:05 -0700
Date: Thu, 21 Mar 2024 15:26:01 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] clk: qcom: add IPQ9574 interconnect clocks support
Message-ID: <ZfwEMUBdlQHYz/+h@hu-varada-blr.qualcomm.com>
References: <20240321043149.2739204-1-quic_varada@quicinc.com>
 <20240321043149.2739204-3-quic_varada@quicinc.com>
 <4079ddcf-425d-4194-93b8-ee113864541e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4079ddcf-425d-4194-93b8-ee113864541e@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qY1bNhBsnuPMxIGmJnK4l7gsQ10KCnqw
X-Proofpoint-ORIG-GUID: qY1bNhBsnuPMxIGmJnK4l7gsQ10KCnqw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=755 clxscore=1015
 suspectscore=0 mlxscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403210068

On Thu, Mar 21, 2024 at 08:25:15AM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2024 05:31, Varadarajan Narayanan wrote:
> > Unlike MSM platforms that manage NoC related clocks and scaling
> > from RPM, IPQ SoCs dont involve RPM in managing NoC related
> > clocks and there is no NoC scaling.
>
> If these are clocks, expose them as clocks, not as interconnects.

Earlier IPQ9574 PCIe patches were NAK-ed when these were exposed
as clocks. Please refer to the following discussions

https://lore.kernel.org/linux-arm-msm/CAA8EJpq0uawrOBHA8XHygEpGYF--HyxJWxKG44iiFdAZZz7O2w@mail.gmail.com/
https://lore.kernel.org/linux-arm-msm/CAA8EJppabK8j9T40waMv=t-1aksXfqJibWuS41GhruzLhpatrg@mail.gmail.com/

Dmitry had said
	<quote>
	I'd kindly suggest implementing the NoC attachment
	properly. In the end, other Qualcomm platforms use ICC
	drivers, so by following this pattern we will have more
	common code paths.
	</quote>

Hence posted these patches to get feedback.

> > However, there is a requirement to enable some NoC interface
> > clocks for accessing the peripheral controllers present on
> > these NoCs.
> >
> > Hence adding a minimalistic interconnect driver that can enable
> > the relevant clocks. This is similar to msm8996-cbf's usage of
> > icc-clk framework.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq9574.dtsi |  2 +
>
> DTS is always, ALWAYS, separate.

Ok.

>
> >  drivers/clk/qcom/gcc-ipq9574.c        | 75 ++++++++++++++++++++++++++-
> >  2 files changed, 76 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > index 7f2e5cbf3bbb..efffbd085715 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > @@ -11,6 +11,7 @@
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> >  #include <dt-bindings/thermal/thermal.h>
> > +#include <dt-bindings/interconnect/qcom,ipq9574.h>
>
> Keep the order,

Ok.

Thanks
Varada

