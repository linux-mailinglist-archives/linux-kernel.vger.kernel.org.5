Return-Path: <linux-kernel+bounces-158389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AE48B1F25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF76B23C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A12E1272D9;
	Thu, 25 Apr 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AwNrnfcH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC986626;
	Thu, 25 Apr 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040831; cv=none; b=AAVaWxaMToBcsC/KRsDpQOlcIZ0jNmu162AfP5pFXI4yhMnUywUKK/g2DSmpHCdXrIzc+JX+PB5kc7C1hAWy0Q2quTotxqf/ZtWzauBBBUm4qQBDR/i9LYJILLDlos3O0EyNGZuf/C2GcCkNU1Y1R8S4HcP+2x3TsBDwloXY830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040831; c=relaxed/simple;
	bh=DOXjsB1uURtz+pGbI/qx6BRXH9Ea1pQq5qQ1TGu1/bc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G50k8JzHKUNMx9Lq7gChSPCFBOFiRXi2bJv71jDHfyXIFuhc28yrHtKgWAPmqsf1v4fA1wGL52zup9rwe/s0LA5taAL7MQMoM5t4fUfFYO5q5LP3Ctse4vm+x6M+rq//8Eg94hVf30U0Njb5CkuTQavI1IFRqTSojnkPXQniIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AwNrnfcH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9wrxW032030;
	Thu, 25 Apr 2024 10:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=UdCeznE+3ZycNdbFwpeSn
	zDyv01X2mNOQtmOavOKyLg=; b=AwNrnfcHa03A8wj9bPcR9fDfR/8jWiNY6KPhd
	KZyijbAeQpMvqePEG84pU0cTTn1lGcB6J7OHJKUVvqr/qUwjoHQ/y7myzWYm9M2L
	zfPnl0aj+pAjUwDq4AhKJ8Eo97y+GRG96T/kknLNosh4/qfnXNctUARhrfmqUWCC
	nplKv+ZvUh7H9Y6VCCmgeqgYbrosaGpaVDQpw2kmebmBGfGvc/Ihg+45wS5OQdBx
	IgAV88PQbcEaVLDouQMpBcEcP4ymo9NcitH8/oBpJBPmig3bJ/wQuf8FpikCn+di
	iBmutOOHo2CqpkvrXSW2fIDfQtHuU1r9H8DgR0emj+4rvMAYA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqn0wg5pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:26:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PAQws1004198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:26:58 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 03:26:53 -0700
Date: Thu, 25 Apr 2024 15:56:49 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
Message-ID: <Ziov6bWBXYXJ4Zp8@hu-varada-blr.qualcomm.com>
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
 <20240418092305.2337429-7-quic_varada@quicinc.com>
 <a7194edd-a2c8-46fc-bea1-f26b0960e535@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a7194edd-a2c8-46fc-bea1-f26b0960e535@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CXhqYs3n6ZegyJD28IbldiROFAHASmth
X-Proofpoint-GUID: CXhqYs3n6ZegyJD28IbldiROFAHASmth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_10,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250075

On Tue, Apr 23, 2024 at 02:58:41PM +0200, Konrad Dybcio wrote:
>
>
> On 4/18/24 11:23, Varadarajan Narayanan wrote:
> > IPQ SoCs dont involve RPM in managing NoC related clocks and
> > there is no NoC scaling. Linux itself handles these clocks.
> > However, these should not be exposed as just clocks and align
> > with other Qualcomm SoCs that handle these clocks from a
> > interconnect provider.
> >
> > Hence include icc provider capability to the gcc node so that
> > peripherals can use the interconnect facility to enable these
> > clocks.
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> If this is all you do to enable interconnect (which is not the case,
> as this patch only satisfies the bindings checker, the meaningful
> change happens in the previous patch) and nothing explodes, this is
> an apparent sign of your driver doing nothing.

It appears to do nothing because, we are just enabling the clock
provider to also act as interconnect provider. Only when the
consumers are enabled with interconnect usage, this will create
paths and turn on the relevant NOC clocks.

This interconnect will be used by the PCIe and NSS blocks. When
those patches were posted earlier, they were put on hold until
interconnect driver is available.

Once this patch gets in, PCIe for example will make use of icc.
Please refer to https://lore.kernel.org/linux-arm-msm/20230519090219.15925-5-quic_devipriy@quicinc.com/.

The 'pcieX' nodes will include the following entries.

	interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
			<&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
	interconnect-names = "pcie-mem", "cpu-pcie";

> The expected reaction to "enabling interconnect" without defining the
> required paths for your hardware would be a crash-on-sync_state, as all
> unused (from Linux's POV) resources ought to be shut down.
>
> Because you lack sync_state, the interconnects silently retain the state
> that they were left in (which is not deterministic), and that's precisely
> what we want to avoid.

I tried to set 'sync_state' to icc_sync_state to be invoked and
didn't see any crash.

Thanks
Varada

