Return-Path: <linux-kernel+bounces-130690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370DC897BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25DD1F24C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4837D1534E6;
	Wed,  3 Apr 2024 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K6NfjiI6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08963139D;
	Wed,  3 Apr 2024 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183840; cv=none; b=qmwjvEANRNhpapYxWl0C7+3wk+z2Tq1vKCcHOjDqDd59flervIgd+o9PdTs/MvcpHusP15/TZQn5Rg5/3/sEWZGWASzIFNo2WLkIVMDgax6sjHUtVy78aMBjMfo5FyqE0s48Z2ibmBc//mAkldNCyzNTSdkdGCKqsd9JdvpCUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183840; c=relaxed/simple;
	bh=t5QgvyF83tgaWo6fPsxfdOGZ6BsIZ6P3Qxjz6h+2Fog=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evhQtRQcBMb3Y3EbaiLY5ZRKeF/Y54hB+YXspwBB83MTaQdsmakWl/U+gmJgcg8rnNdp9JrU7JCc/aWSwumPWyAwWyss3KirDBl6Lw/9dAqhtx8f8fHn7gjz+2XQysGbc8+yNcdsQGpUQv6srF8vhoZec8+StNKFGL6YhZt5Nh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K6NfjiI6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433MRDDc005421;
	Wed, 3 Apr 2024 22:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	qcppdkim1; bh=1kjqUDLoruOJc33VEnfrziBTIXjrzQkIRltrYmSFYBI=; b=K6
	NfjiI6qy/JXvMbPrFzyUMwCX7PUba23CuTQTcGSbnSeIwZpGF45Y5SS2kOug7RK7
	y8PwEpg8Q6Xj+0mfSjpzRurywQ+swe7VDDUVWikmG4tjxMnFJeY7SQXDKAXtwAZk
	biQIKIJQHk3JAMnd7av7Xz5IBy3kJYei+ZueyQkKquWGjQaPWcxwsskCvIYDdkZb
	qsp00dvII/XQB9r6F9wtiUMmhK51HwrwXDP2NRHe8oJfwXRbTKXP4Bhoh6CiSjhq
	heyV9eCVJp6SHStEdHXkEGpUsaTmOX857deQT3hrbxnETwuLYrO6wHwqT6SfP5tO
	OYUw1FfcgWdbYVdKEH8Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9en004m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 22:37:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433MbCeI020507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 22:37:12 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 15:37:11 -0700
Date: Wed, 3 Apr 2024 15:37:11 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH] firmware: qcom: qcm: fix unused
 qcom_scm_qseecom_allowlist
Message-ID: <20240403153511225-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20231120185623.338608-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120185623.338608-1-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0a9H2KpuDITUGNYxS4w5HdT0XZ2X1lgE
X-Proofpoint-ORIG-GUID: 0a9H2KpuDITUGNYxS4w5HdT0XZ2X1lgE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_24,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 mlxlogscore=826 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404030153

On Mon, Nov 20, 2023 at 07:56:23PM +0100, Krzysztof Kozlowski wrote:
> For !OF builds, the qcom_scm_qseecom_allowlist is unused:
> 
>   drivers/firmware/qcom/qcom_scm.c:1652:34: error: ‘qcom_scm_qseecom_allowlist’ defined but not used [-Werror=unused-const-variable=]
> 
> Fixes: 00b1248606ba ("firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311191654.S4wlVUrz-lkp@intel.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

Hope this helps bump it :)

> ---
>  drivers/firmware/qcom/qcom_scm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 520de9b5633a..ecdb367dc9b8 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1649,7 +1649,7 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
>   * We do not yet support re-entrant calls via the qseecom interface. To prevent
>   + any potential issues with this, only allow validated machines for now.
>   */
> -static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
> +static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
>  	{ .compatible = "lenovo,thinkpad-x13s", },
>  	{ }
>  };
> -- 
> 2.34.1
> 
> 

