Return-Path: <linux-kernel+bounces-22654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A079482A0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B3B1F22890
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D04E1D3;
	Wed, 10 Jan 2024 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NgrvD+9+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348BE4D588;
	Wed, 10 Jan 2024 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AHsQTF022052;
	Wed, 10 Jan 2024 19:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=nrhDrGFKIB8w2f04JA38b
	fiMatM+Hu0hgpaDjz3dieM=; b=NgrvD+9+RjJym5sNKEzicNITuWtyU+TPfhW4+
	0B5x/QECXFaxewlSMRrouj3hViRI56CTq47N4uOhSYBeRO7XmjXHR3mRKYOmoYdy
	oL+I3ygFBx0mfCdWrx65c3kuTm0EcFk8epQJoeax/hZsE9geJQoBOkgMlQnZggW7
	QWwg1sBUPwAIRh6zL3r97pmU7DItrFq8bhyS/RWFp5SSsSNncp7uF2SMqD7WClAa
	mDHszgMh0XiWFROdzeRPAN9apKjRhZhfCkmrn24Kuoy+VuNtVgV9ThwZvk9xhtAo
	fwxCvyuUDTETOxab23ulVXfQoDfk/ntxKB1bJkSZfA3mWnKPA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhuak0yty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 19:23:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40AJNURT008042
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 19:23:30 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 11:23:30 -0800
Date: Wed, 10 Jan 2024 11:23:29 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC: Wesley Cheng <quic_wcheng@quicinc.com>, Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi
	<balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/12] usb: dwc3: qcom: Flatten the Qualcomm dwc3 binding
 and implementation
Message-ID: <20240110192329.GN1315173@hu-bjorande-lv.qualcomm.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-11-ab4a84165470@quicinc.com>
 <1c706807-a216-47cd-a1f6-0546bec27242@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1c706807-a216-47cd-a1f6-0546bec27242@quicinc.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uOGjTk5EMndLSvJkqKLYerTH2kYHN0Ls
X-Proofpoint-ORIG-GUID: uOGjTk5EMndLSvJkqKLYerTH2kYHN0Ls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=469
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100154

On Wed, Jan 10, 2024 at 08:43:23AM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 10/17/2023 8:41 AM, Bjorn Andersson wrote:
> > The USB block found in most Qualcomm platforms is modelled as three
> > different independent device drivers, and represented in DeviceTree as
> > two layered nodes. But as shown by the already existing layering
> > violations in the Qualcomm glue driver they can not be operated
> > independently.
> > 
> > In the current model, the probing of the core is asynchronous, and in a
> > number of places there's risk that the driver dereferences NULL
> > pointers, as it peeks into the core's drvdata.
> > 
> > There is also no way, in the current design to make the core notify the
> > glue upon DRD mode changes. Among the past proposals have been attempts
> > to provide a callback registration API, but as there is no way to know
> > when the core is probed this doesn't work.
> > 
> > Based on the recent refactoring its now possible to instantiate the glue
> > and core from a single representation of the DWC3 IP-block. This will
> > also allow for the glue to pass a callback to be called for DRD mode
> > changes.
> > 
> > The only overlapping handling between the Qualcomm glue and the core is
> > the release of reset, which is left to the core to handle.
> > 
> 
> Hi Bjorn,
> 
>  I think the reset has to be handled by glue itself. I was testing this
> series and found one issue:
> 
>  During suspend, we suspend core first which will assert the reset and then
> suspend the glue which will disable the clocks. This path doesn't seem to
> have a problem somehow even in flattened implementation.
> 
>  During resume, we resume the glue first and then resume the core. During
> resume of glue, we enable the clocks and at this point, the reset is still
> kept asserted causing the clocks to never turn ON leading to a crash. This
> is the case in flattened implementation only as in normal case, the reset is
> handled by glue and we never meddle with reset other than the time of
> probing.
> 
> I tried to check if we explicitly de-assert the reset during start of resume
> sequence of glue (in addition to the de-assertion present in core) and
> things worked out fine. But if I try to balance the reset count and add an
> assert at end of suspend sequence of glue (in addition to the assertion
> present in core), then it crashes complaining a double assertion happened.
> So double de-asserting is not causing a problem but double asserting is
> causing an issue.
> 

You're right. I looked at it briefly but ended up moving the reset
handling in the wrong direction...

I expect that in any scenario where a glue driver is used the core can
not control the reset. So far we've dealt with this by just not telling
the core about the reset.

Thanks,
Bjorn

> Regards,
> Krishna,

