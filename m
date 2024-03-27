Return-Path: <linux-kernel+bounces-120182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739F88D3D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41ACB2A7499
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E2F1CF9A;
	Wed, 27 Mar 2024 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="epBV9ekP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5720334;
	Wed, 27 Mar 2024 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711503980; cv=none; b=lWCLfjKrK2qonqUrJLATmhZqYb+cEjwTXrFn20zhTbcDWanb3gEr9FwlVbR/Imof7A95sD24kd9djcYK9ifp1T7k1tZ4ywralPlF7Oj/0ARIz/AtGqMlFsngO0qAuuX66WWjsvkKcvb+x8Xl8jup6DZ2gXVSFq+jnMlY8QiITGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711503980; c=relaxed/simple;
	bh=HlIAUH5uwQqP1NoramiPx0ynaL0jbu+tb/BWx6ErTU0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSP6C6qHV7tLHwyz8yh2NnSzMnUKZ6BNDXcdjz+siwlS6mjg6M1S2L3AqCpnfGBGeG0eA6rIu1Eoplk8bYPiAXQEgWvmFvtG3esKyGrWsE1LdQHfSuBdRCGJZ5uURW501HaO+4IJ4CsFA9+9TPWiekJbU1cXiZGA+ikbODkzEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=epBV9ekP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R0Wjx8018515;
	Wed, 27 Mar 2024 01:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=2MDr1/ScghGWOQiG54TEb
	6BhdAzXd758M7gz4CJdEzM=; b=epBV9ekPGAFqcEAhNPw5gRd65eqTnxWqqlOv6
	qwm70QCzQ/35XX51JR8rc39nsU/6WaFtRLQ0F075gDD9rLR0UdMurGI7sK5C36wo
	f5MM+txynKdmBgD3jAEEIhdncweflFdERaXJPpUzd0S6JkcwvriTUxLabFrTlIGR
	ZL7y29ffogAoNnbIuk8TR/vDeUaBjzxNGe1rYUDGQyWdZJ5Hh1LX9RZJ/bicizsN
	Ku7d9RM2q7pEusoTKOxxmKXIHztg0Cn/zjxtPnDQKqkRpA15NTr1ZcJdUZcjM7Zv
	uicXU0xNBq5CgU5E8G7wzNVnxk1MVWxI3gYxlUxTzPY13Jo3g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x477yrb1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 01:46:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42R1k4xe006882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 01:46:04 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 18:46:03 -0700
Date: Tue, 26 Mar 2024 18:46:02 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Jameson Thies <jthies@google.com>
CC: <heikki.krogerus@linux.intel.com>, <linux-usb@vger.kernel.org>,
        <pmalani@chromium.org>, <bleung@google.com>,
        <abhishekpandit@chromium.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <fabrice.gasnier@foss.st.com>,
        <gregkh@linuxfoundation.org>, <hdegoede@redhat.com>,
        <neil.armstrong@linaro.org>, <rajaram.regupathy@intel.com>,
        <saranya.gopal@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] usb: typec: ucsi: Check capabilities before cable
 and identity discovery
Message-ID: <20240327014602.GB2136359@hu-bjorande-lv.qualcomm.com>
References: <20240315171836.343830-1-jthies@google.com>
 <20240315171836.343830-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240315171836.343830-2-jthies@google.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zC_GlHJK0_LYl76AEeNORxwCfreSz2u3
X-Proofpoint-ORIG-GUID: zC_GlHJK0_LYl76AEeNORxwCfreSz2u3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 mlxlogscore=783 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403270010

On Fri, Mar 15, 2024 at 05:18:35PM +0000, Jameson Thies wrote:
> Check the UCSI_CAP_GET_PD_MESSAGE bit before sending GET_PD_MESSAGE to
> discover partner and cable identity, check UCSI_CAP_CABLE_DETAILS before
> sending GET_CABLE_PROPERTY to discover the cable and check
> UCSI_CAP_ALT_MODE_DETAILS before registering the a cable plug. Additionally,
> move 8 bits from reserved_1 to features in the ucsi_capability struct. This
> makes the field 16 bits, still 8 short of the 24 bits allocated for it in
> UCSI v3.0, but it will not overflow because UCSI only defines 14 bits in
> bmOptionalFeatures.
> 
> Fixes: 38ca416597b0 ("usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY")
> Link: https://lore.kernel.org/linux-usb/44e8142f-d9b3-487b-83fe-39deadddb492@linaro.org
> Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Jameson Thies <jthies@google.com>

Thanks you, Jameson, this resolve the regression I ran into on
qcs6490-rb3gen2 as well.

Tested-by: Bjorn Andersson <quic_bjorande@quicinc.com> # QCS6490 Rb3Gen2

Regards,
Bjorn

