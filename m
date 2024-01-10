Return-Path: <linux-kernel+bounces-21680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DB18292B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D071C25480
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3524A3C;
	Wed, 10 Jan 2024 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CfcAwT2v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3123B1;
	Wed, 10 Jan 2024 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A1oeTY007299;
	Wed, 10 Jan 2024 03:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=d9w7wjgOS8mGxwNpTv84Utw47mif3tx4Ue+gG+2EhJA=; b=Cf
	cAwT2vpoVLXzZ4hynPZkYfLwzLErMFuZblyVe2dH4yplRFfWJkDyjIV8JJ/lzLLq
	DhoJxHBX2FMajlbb7W9sFYSlk6CMGjQ4MtSSlb7UGM6DBXIVGEH8w5siQHBTbkIS
	WjdAC/B95Gm/8a3VxsjZ4d5QAaUK0/FxjEYuM9HWJ2db7PdaWev9VXHgluaLDIxd
	y897I4Ec9xwntlIB9graKnhQ3numPMZFmMOPStMqDqij01xVWQre0O256+z7Qfcx
	M9knYG/9KmagyV97+NCs2T/yzZ6p+aFEOmC+a9iMyFXgPC+wwiWteUDktdRGL8G1
	bRn9ithfn6abfA0o/04w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh3g6a1ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 03:13:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A3DbkX017605
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 03:13:37 GMT
Received: from [10.216.11.180] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 19:13:27 -0800
Message-ID: <1c706807-a216-47cd-a1f6-0546bec27242@quicinc.com>
Date: Wed, 10 Jan 2024 08:43:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] usb: dwc3: qcom: Flatten the Qualcomm dwc3 binding
 and implementation
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-11-ab4a84165470@quicinc.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20231016-dwc3-refactor-v1-11-ab4a84165470@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U2RJGWVGzdGrz0jn4htADaAadCfK1gqy
X-Proofpoint-ORIG-GUID: U2RJGWVGzdGrz0jn4htADaAadCfK1gqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=445
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100025



On 10/17/2023 8:41 AM, Bjorn Andersson wrote:
> The USB block found in most Qualcomm platforms is modelled as three
> different independent device drivers, and represented in DeviceTree as
> two layered nodes. But as shown by the already existing layering
> violations in the Qualcomm glue driver they can not be operated
> independently.
> 
> In the current model, the probing of the core is asynchronous, and in a
> number of places there's risk that the driver dereferences NULL
> pointers, as it peeks into the core's drvdata.
> 
> There is also no way, in the current design to make the core notify the
> glue upon DRD mode changes. Among the past proposals have been attempts
> to provide a callback registration API, but as there is no way to know
> when the core is probed this doesn't work.
> 
> Based on the recent refactoring its now possible to instantiate the glue
> and core from a single representation of the DWC3 IP-block. This will
> also allow for the glue to pass a callback to be called for DRD mode
> changes.
> 
> The only overlapping handling between the Qualcomm glue and the core is
> the release of reset, which is left to the core to handle.
> 

Hi Bjorn,

  I think the reset has to be handled by glue itself. I was testing this 
series and found one issue:

  During suspend, we suspend core first which will assert the reset and 
then suspend the glue which will disable the clocks. This path doesn't 
seem to have a problem somehow even in flattened implementation.

  During resume, we resume the glue first and then resume the core. 
During resume of glue, we enable the clocks and at this point, the reset 
is still kept asserted causing the clocks to never turn ON leading to a 
crash. This is the case in flattened implementation only as in normal 
case, the reset is handled by glue and we never meddle with reset other 
than the time of probing.

I tried to check if we explicitly de-assert the reset during start of 
resume sequence of glue (in addition to the de-assertion present in 
core) and things worked out fine. But if I try to balance the reset 
count and add an assert at end of suspend sequence of glue (in addition 
to the assertion present in core), then it crashes complaining a double 
assertion happened. So double de-asserting is not causing a problem but 
double asserting is causing an issue.

Regards,
Krishna,

