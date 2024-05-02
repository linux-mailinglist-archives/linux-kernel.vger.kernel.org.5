Return-Path: <linux-kernel+bounces-166226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FFD8B97CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041E51F2791D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CB056458;
	Thu,  2 May 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YIOO6VEH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9915153373;
	Thu,  2 May 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642278; cv=none; b=OiQmRTrIaS6lrtrebV+8DC+caxvbhwildh6flScYkujCGriq84TD5LsGKuVEeGL1kyRKnex30kzkdWhJBb6mlwjgbhB/hk1H+Fsxr4xD/TfvlsVmhirtPZntA6UVAqMrHDXpWUbH7cjyJufhz4X/omS0X6p/YHX0mO9DcDPb/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642278; c=relaxed/simple;
	bh=S9nKncTosJNtyw2fp8qJOuPt58/MGn3btQW/Tmk2CNI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omzBpLBBHYjRgxd6xJR7Ex6GUHcnSqQUaKJs94O/W+22l1lyurzTEe8N4NXj4NaQWBUpjsGGoPbo6sPGs3PLr+kLTUZ9k1xtOsEOklZypGQmzmZ5dKkh80/zC5W1L4T0xwwunoslm11g00h2WghgQ14OETrLzCjdg6tQmbo07Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YIOO6VEH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4429Jhjo016657;
	Thu, 2 May 2024 09:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=v5c/xzuoMbwgLTcT01z9I
	raUvhuoSBUQKktz1b968Xw=; b=YIOO6VEH6ekLYPiopTBdm3D7pDqfUWzV0MvSM
	hVEnz1X+Qin/RrMNRK8CHdWZEx8s0++v1Y1hQ0NE6XhQZAeekqIet5YzH3TXFNOZ
	OVYOABl3qMJaPWgIELxdWC8AsLXzkm/XLttAwOd70zR/brw9jVIJkpyCkq/lDxl7
	gPDPgN5vv7KQ0od3sC24ZaG0ID1NppOhEOxVwAwZmSl215w4BV0gq50teK13vOGz
	9ShQIK7rl1tclqkvuRMPcKdChO6rwrkSMRjw91fEPciU2ayTBN76FDtZB0WGBZh4
	NuMTEz5xZPQtGkRqhuLWBA3E/xM8nCCrwS2EZWz0b5M79EgYQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv6q0r6c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 09:31:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4429V3vm024061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 09:31:03 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 May 2024 02:30:58 -0700
Date: Thu, 2 May 2024 15:00:54 +0530
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
Message-ID: <ZjNdTmmXucjtRxJt@hu-varada-blr.qualcomm.com>
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
 <20240418092305.2337429-7-quic_varada@quicinc.com>
 <a7194edd-a2c8-46fc-bea1-f26b0960e535@linaro.org>
 <Ziov6bWBXYXJ4Zp8@hu-varada-blr.qualcomm.com>
 <27f4f3dd-9375-40cf-8c8f-1c4edf66e31b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <27f4f3dd-9375-40cf-8c8f-1c4edf66e31b@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f32cUZJHVPOeDkNbmNDX5tkaGpQ2T_YX
X-Proofpoint-GUID: f32cUZJHVPOeDkNbmNDX5tkaGpQ2T_YX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020058

On Tue, Apr 30, 2024 at 12:05:29PM +0200, Konrad Dybcio wrote:
> On 25.04.2024 12:26 PM, Varadarajan Narayanan wrote:
> > On Tue, Apr 23, 2024 at 02:58:41PM +0200, Konrad Dybcio wrote:
> >>
> >>
> >> On 4/18/24 11:23, Varadarajan Narayanan wrote:
> >>> IPQ SoCs dont involve RPM in managing NoC related clocks and
> >>> there is no NoC scaling. Linux itself handles these clocks.
> >>> However, these should not be exposed as just clocks and align
> >>> with other Qualcomm SoCs that handle these clocks from a
> >>> interconnect provider.
> >>>
> >>> Hence include icc provider capability to the gcc node so that
> >>> peripherals can use the interconnect facility to enable these
> >>> clocks.
> >>>
> >>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>> ---
> >>
> >> If this is all you do to enable interconnect (which is not the case,
> >> as this patch only satisfies the bindings checker, the meaningful
> >> change happens in the previous patch) and nothing explodes, this is
> >> an apparent sign of your driver doing nothing.
> >
> > It appears to do nothing because, we are just enabling the clock
> > provider to also act as interconnect provider. Only when the
> > consumers are enabled with interconnect usage, this will create
> > paths and turn on the relevant NOC clocks.
>
> No, with sync_state it actually does "something" (sets the interconnect
> path bandwidths to zero). And *this* patch does nothing functionally,
> it only makes the dt checker happy.

I understand.

> > This interconnect will be used by the PCIe and NSS blocks. When
> > those patches were posted earlier, they were put on hold until
> > interconnect driver is available.
> >
> > Once this patch gets in, PCIe for example will make use of icc.
> > Please refer to https://lore.kernel.org/linux-arm-msm/20230519090219.15925-5-quic_devipriy@quicinc.com/.
> >
> > The 'pcieX' nodes will include the following entries.
> >
> > 	interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
> > 			<&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
> > 	interconnect-names = "pcie-mem", "cpu-pcie";
>
> Okay. What about USB that's already enabled? And BIMC/MEMNOC?

For USB, the GCC_ANOC_USB_AXI_CLK is enabled as part of the iface
clock. Hence, interconnect is not specified there.

MEMNOC to System NOC interfaces seem to be enabled automatically.
Software doesn't have to turn on or program specific clocks.

> >> The expected reaction to "enabling interconnect" without defining the
> >> required paths for your hardware would be a crash-on-sync_state, as all
> >> unused (from Linux's POV) resources ought to be shut down.
> >>
> >> Because you lack sync_state, the interconnects silently retain the state
> >> that they were left in (which is not deterministic), and that's precisely
> >> what we want to avoid.
> >
> > I tried to set 'sync_state' to icc_sync_state to be invoked and
> > didn't see any crash.
>
> Have you confirmed that the registers are actually written to, and with
> correct values?

I tried the following combinations:-

1. Top of tree linux-next + This patch set

	* icc_sync_state called
	* No crash or hang observed
	* From /sys/kernel/debug/clk/clk_summary can see the
	  relevant clocks are set to the expected rates (compared
	  with downstream kernel)

2. Top of tree linux-next + This patch set + PCIe enablement

	* icc_sync_state NOT called
	* No crash or hang observed
	* From /sys/kernel/debug/clk/clk_summary can see the
	  relevant clocks are set to the expected rates (compared
	  with downstream kernel)

Does this answer your question? Please let me know if you were
looking for some other information.

Thanks
Varada

