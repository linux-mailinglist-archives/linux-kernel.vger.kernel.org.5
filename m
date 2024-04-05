Return-Path: <linux-kernel+bounces-132348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE79789936B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01891C2256A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFA817BAF;
	Fri,  5 Apr 2024 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i06to5Uw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F0134A9;
	Fri,  5 Apr 2024 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285601; cv=none; b=QInyBm6OMP+W31kjrKpORxISu/sRyIdAxy6UGC1TXww35A7KJ+xEVT+wbBNz8jUyImXTqvOgUDgQs5vCbkrCrlxs2TYDVqf3B4Ju9ZeONDhIuP4XzvjdsSNbeQcqMgyGG1ifwRlG/voSdI5lGIJLXj1OpeCgIRh1XyqcC9Ma7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285601; c=relaxed/simple;
	bh=MVyig03Aeny4dPArOYRzNf9KUnxEWGJk4/oTmXeTRxM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR89osuUgZTI60WjRzyW704EmP7a+8eCKGBGDlKhuaG7HK56Bm7YyQa4dVjm5eJzbr3t9V7naUENOqO7TObfKjYLdv+tLD8VHRYoesbINyZGKj6bUatoMEnGQihDRs/jVBGCn6Z19PQnlai80ysGR8l6gLMXTV1KkUBsSGb3JkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i06to5Uw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4351aVTJ030616;
	Fri, 5 Apr 2024 02:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=99qh0tkEGCjZkpRMCBd3k
	DZQgwUu7FIq8N3AVVlZjNc=; b=i06to5Uw9I0hdnp8y1zgX/C/xQ0po+T3AdOuM
	dcMy0OtMHQqqDYwrZbnLJTTVXMgnQv+B832DkFN3v2ukKAC91wFddd/Y3cKUTUKl
	ucTfDEOGcb2Kg1VVgvrUbGCb7Ia1Xa4PMwzt3n5IjuwsLOrE0T2uFRHtxXWKg7Qw
	tgl/MFG75afOSUN6gjemVQTwHL7kKmn4mUM6V8nqam36tA77oRSJlcT0IEnKHMuO
	c+kwf2VywUon9w1z3Dc7hmZH89v/Uw3l9bAWkELtK7WJ9s3EOQuwmyb1R6eEPSCi
	Qtwa0pbWAAsz0xCxH2Ra/y3pQERh/NUPxhaUFrz/BIO4FMrxg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa7snr2y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 02:53:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4352rFGC014932
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 02:53:15 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 19:53:15 -0700
Date: Thu, 4 Apr 2024 19:53:13 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Komal Bajaj <quic_kbajaj@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tsoni@quicinc.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable various
 remoteprocs
Message-ID: <Zg9nmVl9eqTbkkDe@hu-bjorande-lv.qualcomm.com>
References: <20240402090349.30172-1-quic_kbajaj@quicinc.com>
 <20240402090349.30172-3-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402090349.30172-3-quic_kbajaj@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: My1cAsIVuXWZL7ace_yOdZ4P3IhlBSQ7
X-Proofpoint-ORIG-GUID: My1cAsIVuXWZL7ace_yOdZ4P3IhlBSQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_01,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=807
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050020

On Tue, Apr 02, 2024 at 02:33:49PM +0530, Komal Bajaj wrote:
> Enable the ADSP, CDSP and WPSS that are found on qcs6490-rb3gen2.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 97824c769ba3..a25431ddf922 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -434,6 +434,21 @@ &qupv3_id_0 {
>  	status = "okay";
>  };
> 
> +&remoteproc_adsp {
> +	firmware-name = "qcom/qcm6490/adsp.mbn";

Should this be qcm6490?


I already proposed a patch to add adsp and cdsp, using qcs6490, and this
was merged earlier this week. Please pay attention and review patches
posted on the public list.

Either way, this will now have to be rebased on linux-next.

Thanks,
Bjorn

> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/qcm6490/cdsp.mbn";
> +	status = "okay";
> +};
> +
> +&remoteproc_wpss {
> +	firmware-name = "qcom/qcm6490/wpss.mbn";
> +	status = "okay";
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges = <32 2>, /* ADSP */
>  			       <48 4>; /* NFC */
> --
> 2.42.0
> 

