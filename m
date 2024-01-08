Return-Path: <linux-kernel+bounces-19862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D98138275AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A348B22297
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7DA53E2B;
	Mon,  8 Jan 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T0OEpvAU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866153E2E;
	Mon,  8 Jan 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408CD3j0026873;
	Mon, 8 Jan 2024 16:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=HwPgusZd6sVHWD8by0F+C
	dumsdRLBdsgVOZVKMtEy04=; b=T0OEpvAUtr967xCjX60o8oETNp9uqllaAy2Oa
	uOckrhDUQ3FSSjKqX7JS+UyUWiqCMWZhCP6Jy/cFDfj1VX1NDDx/xEWLq/ZoBUtb
	fuqyZOAaO8ctR2Ng4S9eg1JIofymRALjbnp25PxawpHVbkHHSd7pxRabmvDqyvwg
	OFtoB8+BC3D0xGVM6uVb7QF+C/sAxFVtyxeyL5k1nWKcdHg7eIkJHa/iT02KcqoN
	uvit8RuSPG7FuX2B7fxxZfsom822jxCDFOst7+UeKUbTg3KT6o09OJ9pVk7r2C1l
	rIq2uzlsmZh0GlTfRFuZYN93ouX9JSPh37ArstqvYjAMu6jOg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgbuj99ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 16:46:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408GkJEW019482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 16:46:19 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 08:46:18 -0800
Date: Mon, 8 Jan 2024 08:46:17 -0800
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
Subject: Re: [PATCH 00/12] usb: dwc3: qcom: Flatten dwc3 structure
Message-ID: <20240108164617.GJ1315173@hu-bjorande-lv.qualcomm.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <ZV3OgorG4G4mwvv1@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZV3OgorG4G4mwvv1@hovoldconsulting.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s1k51z_EGZ8hMjCFo420-aH1DU7AN6ss
X-Proofpoint-ORIG-GUID: s1k51z_EGZ8hMjCFo420-aH1DU7AN6ss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=832 lowpriorityscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080141

On Wed, Nov 22, 2023 at 10:48:50AM +0100, Johan Hovold wrote:
> On Mon, Oct 16, 2023 at 08:11:08PM -0700, Bjorn Andersson wrote:
> > The USB IP-block found in most Qualcomm platforms is modelled in the
> > Linux kernel as 3 different independent device drivers, but as shown by
> > the already existing layering violations in the Qualcomm glue driver
> > they can not be operated independently.
> > 
> > With the current implementation, the glue driver registers the core and
> > has no way to know when this is done. As a result, e.g. the suspend
> > callbacks needs to guard against NULL pointer dereferences when trying
> > to peek into the struct dwc3 found in the drvdata of the child.
> > 
> > Missing from the upstream Qualcomm USB support is handling of role
> > switching, in which the glue needs to be notified upon DRD mode changes.
> > Several attempts has been made through the years to register callbacks
> > etc, but they always fall short when it comes to handling of the core's
> > probe deferral on resources etc.
> 
> Nice to see this finally being worked on. It's not clear why mode-change
> notifications would be a problem though, as if you get such a
> notification, you know that core has been probed.
>  

The problem here is that the usb_role_switch is implemented in the core,
but the glue needs to act upon the notification as well - and there's
currently no way to have the core notify the glue about such changes.


You can see this "solved" in the case of extcon, where both the Qualcomm
glue and core listens to and act upon the extcon updates. This isn't
pretty, but with the of-graph based role-switching description (and good
judgement) it's not possible to replicate this on modern platforms.

Which means that this leaves a TODO to investigate if we can drop the
extcon support from dwc3-qcom.c

Regards,
Bjorn

> > Furhtermore, the DeviceTree binding is a direct representation of the
> > Linux driver model, and doesn't necessarily describe "the USB IP-block".
> 
> True.
> 
> Johan

