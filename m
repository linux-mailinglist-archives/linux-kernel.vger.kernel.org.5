Return-Path: <linux-kernel+bounces-118395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC71F88BA28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21B42E4DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DFB12AAEF;
	Tue, 26 Mar 2024 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gPnehI6x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90FB12AACF;
	Tue, 26 Mar 2024 06:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711433032; cv=none; b=J7Mu2MF4NpktCLCFdwKLS3czdvczzUFOxzESbUIg97VsPH32axzYmSudYC6LtvccPjgy38HUcEeWjLG8BusdU48MbOJreAeCnjkBBDDeclmpuwjEFZ3JbIJyeOEo7vfiwHAiUhD3gG1esuAf1NSt25KpNs/jUvD/SEqTZuHmVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711433032; c=relaxed/simple;
	bh=kjJeqqiFES5V8Nk4/QzSFSxE95r0Rl3IkZeNoS9BKDo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2CK7vijR5CseJHQ870vVgOv3V6zrLjY+0TSiU9dnnlhN62KnxiO1HmuqAzcu2iNebeiANDsTDVbwDTCSk1731Dc8nAoY3zjeNN+GiJbxlh2y4vbI3+3FC3MZ3iYUfFlUjs7rGjclkZ31ZcQe0UEEnAI8jnibGai88puw0p+OHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gPnehI6x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q0b2ur032405;
	Tue, 26 Mar 2024 06:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=DthhqmamU+m1j9b6ylwIZ
	Z5H+pmY1Pn1rYA7g+nPMCg=; b=gPnehI6x0QrKV+OjSEFhiPyl4subr3GgLQst/
	/pK8h7fo1+21Q8hNMjIIxk0KUgdIIxcgxo1ImruYpzqHGJkJ7tGli2iPcSp408c0
	VZSd2IiibL2qLgCTG1h3Ps7bZMPe3uc+/yZuZLLWhW62KSsKiKOOY5FPtcprCwjd
	Bjv/CKtt7xZmXh50Lybf3N10a1rikQS867uWUPgKv7qOMyI+0/DSuqzUH1ZofaiO
	gKbVyStfiIqPyBuFVkk0l8Ukai1s8cCflKaKAQ+PuymdrUL6fuM62qC9nejM7jhU
	rdmVAEMmBzJ3EJQJWZ2YUgnfoUPrymB737MUxib+G1u9TpkmA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3huu0taj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 06:03:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42Q63gKO010335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 06:03:42 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 23:03:38 -0700
Date: Tue, 26 Mar 2024 11:33:35 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] clk: qcom: add IPQ9574 interconnect clocks support
Message-ID: <ZgJlNx1vHoM2DfSz@hu-varada-blr.qualcomm.com>
References: <20240325102036.95484-1-quic_varada@quicinc.com>
 <20240325102036.95484-4-quic_varada@quicinc.com>
 <fe40b307-26d0-4b2a-869b-5d093415b9d1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fe40b307-26d0-4b2a-869b-5d093415b9d1@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wX7-v7rlQhyAtaU0W9LGJU5ae4DjYuZQ
X-Proofpoint-ORIG-GUID: wX7-v7rlQhyAtaU0W9LGJU5ae4DjYuZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_02,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=905 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260038

On Mon, Mar 25, 2024 at 08:42:21PM +0100, Konrad Dybcio wrote:
> On 25.03.2024 11:20 AM, Varadarajan Narayanan wrote:
> > Unlike MSM platforms that manage NoC related clocks and scaling
> > from RPM, IPQ SoCs dont involve RPM in managing NoC related
> > clocks and there is no NoC scaling.
> >
> > However, there is a requirement to enable some NoC interface
> > clocks for accessing the peripheral controllers present on
> > these NoCs. Though exposing these as normal clocks would work,
> > having a minimalistic interconnect driver to handle these clocks
> > would make it consistent with other Qualcomm platforms resulting
> > in common code paths.  This is similar to msm8996-cbf's usage of
> > icc-clk framework.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> [...]
>
> >
> > +
> > +static struct icc_clk_data *icc_ipq9574;
> > +
>
> What does this help achieve?

Had it as a place holder in case if the provider pointer is needed
for any debug. Will remove it.

> > +static int noc_clks[] = {
>
> We could probably use indexed identifiers here to avoid confusion:
> [ICC_BINDING_NAME] = CLK_BINDING_NAME

ok.

> >  static int gcc_ipq9574_probe(struct platform_device *pdev)
> >  {
> > -	return qcom_cc_probe(pdev, &gcc_ipq9574_desc);
> > +	int ret = qcom_cc_probe(pdev, &gcc_ipq9574_desc);
> > +	struct icc_provider *provider;
> > +	struct icc_clk_data *icd;
> > +	int i;
> > +
> > +	if (ret)
>
> I'd personally prefer if you left ret uninitialized and assigned it
> above the if-statement.

ok

> > +		return dev_err_probe(&pdev->dev, ret, "%s failed\n", __func__);
>
> Please avoid the use of __func__ throughout your change and write
> a more useful error message.
>
> > +
> > +	icd = devm_kmalloc(&pdev->dev, ARRAY_SIZE(noc_clks) * sizeof(*icd),
> > +			   GFP_KERNEL);
>
> devm_kcalloc

ok

> > +
> > +	if (IS_ERR_OR_NULL(icd))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(icd),
> > +				     "%s malloc failed\n", __func__);
>
> ditto

ok

> > +
> > +	icc_ipq9574 = icd;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(noc_clks); i++, icd++) {
> > +		icd->clk = gcc_ipq9574_clks[noc_clks[i]]->hw.clk;
> > +		if (IS_ERR_OR_NULL(icd->clk)) {
> > +			dev_err(&pdev->dev, "%s: %d clock not found\n",
> > +				__func__, noc_clks[i]);
> > +			return -ENOENT;
>
> return dev_err_probe

ok

> > +		}
> > +		icd->name = clk_hw_get_name(&gcc_ipq9574_clks[noc_clks[i]]->hw);
> > +	}
> > +
> > +	provider = icc_clk_register(&pdev->dev, IPQ_APPS_ID,
> > +				    ARRAY_SIZE(noc_clks), icc_ipq9574);
> > +	if (IS_ERR_OR_NULL(provider))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(provider),
> > +				     "%s: icc_clk_register failed\n", __func__);
>
> ditto

ok

> On a second thought, since I'm assuming you're going to expand this to other
> IPQ SoCs, it might be useful to factor this out into drivers/clk/qcom/common.c

Will move it.

Thanks
Varada

