Return-Path: <linux-kernel+bounces-150438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1BE8A9F54
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3B31C238E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7016F917;
	Thu, 18 Apr 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mUmbAQTK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9FC16F851;
	Thu, 18 Apr 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455865; cv=none; b=OwbCgvSiSP8A/AQ6DXa5DfklhXPaz3nVxxhrpgwwNpCkyIqByXdgfGuaHppYYvefED30PqoJLG6SDqwVdCdKUB2H9jESDz8lfZeVsvlqgUvaNouMWthl+vmfe1oIgR+dpoR7jW8gAa/ZGu0+DwmwLFXkWRgukTiB5+vhqcqbEjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455865; c=relaxed/simple;
	bh=qI2NDyYBetjYiJ8+DJsHQPX1KNa1xaxmLQvZQPm4Y+M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muJmzG8G9T0htO8X/FXzLaYKuFyfc/ylfBXiHAOK23AxUmZb7JozSwFvapNq++9R9BZd7ZboJBP7cOZYTu6xKJP0rD2pV65eRUDrl2kgjEwiD0z8kvvOK2zWIUg4DIE7rEaiD0Mj667apdrg71PPy9oehYDtl3Nyqtv75NBRb+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mUmbAQTK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IDLr3n026802;
	Thu, 18 Apr 2024 15:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=keHmXRi4wuYZaHcMOahf+
	Dk9RbwXyJs1kracniYm16k=; b=mUmbAQTKygnnDNK26Fsg/fQ/gjW7X0S7DecDO
	rfWyjXNOeIcsBd8yUbi07zbbEpJnm5mxq7JMpLZVz5OGucRupnguMqj9OCnBLyLP
	X5kNpAtzAi31B1Y9ntOJm0flQjJtkOPD4VJne5DdC6mLKL+CJBvr76BqIi3fYebe
	6QLW8YS3otMgxRZBj34fjMGnx79MMP3a6grq3gIwvrUqwFSbWqT3MaLRzJ4ChGKc
	Q9cUtuXJPgviqfcGLpfg+fhaMWKmtUdFZW4NJaa9MDOjstEEUUmNGlsUB5GUmSmS
	v3NebBC7dq9hwOySJMu6NubLHmStro+UyVhC2+Y5VJQpeqOxQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjx54h90f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 15:57:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IFvcF1013191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 15:57:38 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 08:57:38 -0700
Date: Thu, 18 Apr 2024 08:57:37 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Abel Vesa <abel.vesa@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: x1e80100: Drop the
 link-frequencies from mdss_dp3_in
Message-ID: <ZiFC8d6cD35B+PaC@hu-bjorande-lv.qualcomm.com>
References: <20240418-x1e80100-dts-fix-mdss-dp3-v1-0-9f8420e395d4@linaro.org>
 <20240418-x1e80100-dts-fix-mdss-dp3-v1-1-9f8420e395d4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240418-x1e80100-dts-fix-mdss-dp3-v1-1-9f8420e395d4@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NW4TPYbzOL1EXy3pjwrDa-nvTR2SjDn5
X-Proofpoint-ORIG-GUID: NW4TPYbzOL1EXy3pjwrDa-nvTR2SjDn5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_14,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=359 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180113

On Thu, Apr 18, 2024 at 01:22:18PM +0300, Abel Vesa wrote:
> The link-frequences belong in mdss_dp3_out. Display is broken because of
> this. Drop them from mdss_dp3_in.
> 

Why is display broken because you have this property in the wrong node?
Isn't it broken because you don't have it in &mdss_dp3_out and this is
just a cleanup of an invalid property?

Perhaps that's what you're trying to say? Would be nice to have that
clarified.

Regards,
Bjorn

> Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index f5a3b39ae70e..0642b5e88639 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -4096,7 +4096,6 @@ port@0 {
>  						mdss_dp3_in: endpoint {
>  							remote-endpoint = <&mdss_intf5_out>;
>  
> -							link-frequencies = /bits/ 64 <8100000000>;
>  						};
>  					};
>  
> 
> -- 
> 2.34.1
> 

