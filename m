Return-Path: <linux-kernel+bounces-19934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AD0827701
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533151F226E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D4D55E40;
	Mon,  8 Jan 2024 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N37iDMzO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672A55C12;
	Mon,  8 Jan 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408BoIoV025456;
	Mon, 8 Jan 2024 18:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=cW3/52u923rUZekNz8/9L
	Anvs2y92KpYma+wacAjnTE=; b=N37iDMzOZUq0CKK2SF8XWvW/udLwoKiMXp/Uo
	Pn7sJx/sybXuhC/NCu/bquS4HPgi/bFNDxxCk5869NIwb+qQRYFMByZ8QCDeEuNI
	HEieZ7wjQD8K17j2kpRpfY4gEZG5lM0dXFle6a0iZ7LjFsi/khHZUD3OhRTpEjdu
	vepoRhQo6jaQ+92qALsj0VpMXN0MMXf7TQdVsyINJgrb1dDZ+8atQTmV8fnWR5Vh
	wy0JCcQ4r5nU5qhlpESyKs/sZGZ2ThuRLVkUQBJVcGmwUAZ2fgFAUH3SyRMghbYx
	4yUKxees3RH2Dm5Je4E8oCJ76qfUmQzAgkb1BrxO1MdI1LRsw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgbjyhg5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 18:02:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408I2Obp027117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 18:02:24 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 10:02:24 -0800
Date: Mon, 8 Jan 2024 10:02:23 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Kurapati PSSNV
	<quic_kriskura@quicinc.com>
Subject: Re: [PATCH 06/12] usb: dwc3: qcom: Add dwc3 core reference in driver
 state
Message-ID: <20240108180223.GK1315173@hu-bjorande-lv.qualcomm.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-6-ab4a84165470@quicinc.com>
 <ZV3xmW0fDWY5-6qZ@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZV3xmW0fDWY5-6qZ@hovoldconsulting.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TW63nP16Eh9jn7-rOIH8U91wuAlO_iug
X-Proofpoint-ORIG-GUID: TW63nP16Eh9jn7-rOIH8U91wuAlO_iug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080153

On Wed, Nov 22, 2023 at 01:18:33PM +0100, Johan Hovold wrote:
> On Mon, Oct 16, 2023 at 08:11:14PM -0700, Bjorn Andersson wrote:
> > In the coming changes the Qualcomm DWC3 glue will be able to either
> > manage the DWC3 core as a child platform_device, or directly instantiate
> > it within its own context.
> > 
> > Introduce a reference to the dwc3 core state and make the driver
> > reference the dwc3 core either the child device or this new reference.
> > 
> > As the new member isn't assigned, and qcom->dwc_dev is assigned in all
> > current cases, the change should have no functional impact.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  drivers/usb/dwc3/dwc3-qcom.c | 100 +++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 83 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > index 7c810712d246..901e5050363b 100644
> > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > @@ -67,7 +67,8 @@ struct dwc3_acpi_pdata {
> >  struct dwc3_qcom {
> >  	struct device		*dev;
> >  	void __iomem		*qscratch_base;
> > -	struct platform_device	*dwc_dev;
> > +	struct platform_device	*dwc_dev; /* only used when core is separate device */
> > +	struct dwc3		*dwc; /* not used when core is separate device */
> 
> Hmm. This quickly become really messy and hard to maintain. It may be
> fine as an intermediate step as part of this series, but why can't you
> do the conversion fully so that the Qualcomm glue driver never registers
> a core platform device? Is it just about where the core driver looks for
> DT properties?
> 

In the new driver model, pdev->dev.of_node needs to contain the
resources for both the glue and the core. For most of the information,
that's a matter of copying properties and child nodes from the child
of_node, but e.g. reg and interrupts needs to be merged.

As mentioned in my other reply, extcon is serviced to both nodes, so
without the callbacks that will break, at least - and I'd have to check
to see if the of_graphs can be handled...


That said, part of the reason for doing this shuffle is to make sure
that dwc is always a valid pointer, and while keeping this scheme of two
modes we will not be able to assume this anywhere in the code - and
hence continue to rely on luck.

One way around this would be to follow the of_platform_populate() with a
check to see if the core was registered and if so grab the dwc pointer,
otherwise of_platform_depopulate() the core again and probe defer.

It will come with a penalty for devices running on the old binding, and
we don't protect ourselves from the core being unbound while we're
holding a pointer to its internal data. But it looks like a much better
position to me.

(In this case I think dwc_dev becomes a local variable using during
probe, and the rest of the code would operate on dwc)

Regards,
Bjorn

