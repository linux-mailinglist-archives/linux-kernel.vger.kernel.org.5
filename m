Return-Path: <linux-kernel+bounces-144432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE88A465B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24939B212A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 00:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7714C7C;
	Mon, 15 Apr 2024 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YeMHkANG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE7639;
	Mon, 15 Apr 2024 00:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713141184; cv=none; b=r683TVcHV7HZv8FYHJZAMDUflxuY71BX5u1o7ydt1nNCPcp6gWChRFcAXP0t6EBCzCT097cdfHdagNQWXKxgyyWESDmIFkl12JAzy45R+iHIAi5xDjiCMqk7eQ0Ib0mMTvJDqyVTrKLcVEmX8iNOVONqsAAXjzWLXNJmWp8ky5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713141184; c=relaxed/simple;
	bh=155gXXdQANVmSfdXxHCjI5F0Dg3hhFGrVuBtSaIunTY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vm9mzOFm8tLS9reAzxn4Sq+JsNSEwdKCY7zD4A7ReGrkkRwdv7WIST8J3PFWHV9KHzgE5K8V2vLRywpC1HA+4czKmSnKJbP9UwlLiNw8RjcXbWnUcroMB9/YYsmJJtx1xqeCFqr0izvgo3G9iqgu5oQNaHSRzhsU73WMy7kgXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YeMHkANG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F0Mv4R025751;
	Mon, 15 Apr 2024 00:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=JH+99CJAPu+dl8sSsv/0Q
	anm5M2oT5yN2gTeVMFHO8M=; b=YeMHkANGMlol9YOwgxeQM8CpDWKY/Wy/V6Ybm
	b5sN1cdA583eOCTqEsAUr+66WD/Zx+is7kUKsHBuoHxKSfGDj9rtV85MG1mN/6R7
	Q5tPFNfW3qRmu+fc8OUn0/tfjnFAU/Xd1yganYHrEzZmwmKFgvXXcjTSz9orwMfm
	m4E66l2RppG9aDiJbf9wK5P2NyuuYM5cCbAUv8Cjy5Zzpda9z2A5VNpkq5ukgJjz
	XJX+QE8vH7Mj7iGQJcAvIoiZHcTxFQMBqMKxJTqWeP193iOUPbXtuA1JkSR1o1q/
	/lJcsVHLTbUlYcsHc3Ftzfy7AMD6sbCkaqQ8iu87xjvQCImKw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xggvgrg2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 00:32:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43F0WcwK020603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 00:32:38 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 14 Apr 2024 17:32:37 -0700
Date: Sun, 14 Apr 2024 17:32:37 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types
 for qcm6490-idp
Message-ID: <20240414173158942-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <20240414-arm-psci-system_reset2-vendor-reboots-v2-4-da9a055a648f@quicinc.com>
 <CAA8EJpoXrbdD5xVmuo-2b4-WwpSachcJ-abDtu4BS_qa-2A+OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpoXrbdD5xVmuo-2b4-WwpSachcJ-abDtu4BS_qa-2A+OA@mail.gmail.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i0sW7yvkwcQAUBWnVrmtschMRkubiVkZ
X-Proofpoint-ORIG-GUID: i0sW7yvkwcQAUBWnVrmtschMRkubiVkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=865 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150001

On Mon, Apr 15, 2024 at 02:13:29AM +0300, Dmitry Baryshkov wrote:
> On Sun, 14 Apr 2024 at 22:32, Elliot Berman <quic_eberman@quicinc.com> wrote:
> >
> > Add nodes for the vendor-defined system resets. "bootloader" will cause
> > device to reboot and stop in the bootloader's fastboot mode. "edl" will
> > cause device to reboot into "emergency download mode", which permits
> > loading images via the Firehose protocol.
> >
> > Co-developed-by: Shivendra Pratap <quic_spratap@quicinc.com>
> > Signed-off-by: Shivendra Pratap <quic_spratap@quicinc.com>
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> > index e4bfad50a669..a966f6c8dd7c 100644
> > --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> > @@ -126,6 +126,11 @@ debug_vm_mem: debug-vm@d0600000 {
> >                 };
> >         };
> >
> > +       psci {
> 
> Please use a label instead. Otherwise it looks as if you are adding
> new device node.
> 

Right. Fixed for the next revision.

Thanks,
Elliot

> > +               mode-bootloader = <0x10001 0x2>;
> > +               mode-edl = <0 0x1>;
> > +       };
> > +
> >         vph_pwr: vph-pwr-regulator {
> >                 compatible = "regulator-fixed";
> >                 regulator-name = "vph_pwr";
> >
> > --
> > 2.34.1
> >
> >
> 
> 
> -- 
> With best wishes
> Dmitry

