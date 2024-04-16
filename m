Return-Path: <linux-kernel+bounces-146082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BDA8A6014
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CD0289892
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3807A95E;
	Tue, 16 Apr 2024 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cHJd2rKg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970DA5223;
	Tue, 16 Apr 2024 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713229885; cv=none; b=kfm6vQjweGBe4r+iQ3wREiuvp+wv49X6+ujZo2XmCkL2kbaF1HN0u8c1KVZdNTeUY2eVPshZsFCHrgxTHqiWgZRbw+J9S/VTs1YvPJSdv37cFeabKmb7o1hbUhTq18kH5+JqAcL/2KU3IX7JrIJUceZrQUzUfzejnP5mrCcW05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713229885; c=relaxed/simple;
	bh=DTe0SYylnC9J3y1Ml9vbf6iKbIaZ8MV4bdiF/+8kOd8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVHzC++/ngPLRlgdNNWNxWGTux9HOYCbdWSizUR6H2LSIh8rHMWQbLCEq8ERlz57WrB1DSFxjIFSOvkBQy5HaVZg8en7nspRXPOeJR4IcZm05t1gkbtMLt8s+hUWRjK7DXPKDDp8b+zJbSDPwe/7Xthot5Tu5he26NXBKYekFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cHJd2rKg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FNocAQ004353;
	Tue, 16 Apr 2024 01:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=DF6xjwVEYJH6vaL4RMK0y
	Xhgc3M/qQ6eMe0NEkdCmpw=; b=cHJd2rKgXJ1Aaka/myi/A0I/68AwmdM4ukeAt
	5W53Ywk3J4yXWIMDVf94jGqDvfMUxFAT1roBIsYsy+gET0IYroU+ZQNvgtSb0/dn
	YIqVdBEA2P9gzacrOBWu0ExK2gRl5mFg/+3T9RuXvRZoWQGKf6o5BxcBLNPKtmzG
	jV1efe8RxfmSjyeJXbw/+ak4ROVui4rR1Xhq1lqareCn1xrrIyzagxuDCFK6188M
	6GO8ySjUmT7oUf/iwa2fzPsbfjrU2zincM3qIU8xKdi0Gka3g/pxlTv/cav0cbil
	hrrW383UXzuw/6Sfctzm3DV/7V+QOUarAKZrx46Htm6/kjdKQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh1m5hyyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 01:11:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G1B3aS030860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 01:11:03 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 18:11:02 -0700
Date: Mon, 15 Apr 2024 18:11:02 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
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
Message-ID: <20240415180247696-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <20240414-arm-psci-system_reset2-vendor-reboots-v2-4-da9a055a648f@quicinc.com>
 <CAA8EJpoXrbdD5xVmuo-2b4-WwpSachcJ-abDtu4BS_qa-2A+OA@mail.gmail.com>
 <20240414173158942-0700.eberman@hu-eberman-lv.qualcomm.com>
 <be5bd196-a782-41a7-a1a8-8aea6b4b2365@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <be5bd196-a782-41a7-a1a8-8aea6b4b2365@linaro.org>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U-8j-JyVKdKj6fhq0S1oYCcKoreolAsg
X-Proofpoint-ORIG-GUID: U-8j-JyVKdKj6fhq0S1oYCcKoreolAsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_20,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160005

On Mon, Apr 15, 2024 at 09:42:40PM +0200, Konrad Dybcio wrote:
> 
> 
> On 4/15/24 02:32, Elliot Berman wrote:
> > On Mon, Apr 15, 2024 at 02:13:29AM +0300, Dmitry Baryshkov wrote:
> > > On Sun, 14 Apr 2024 at 22:32, Elliot Berman <quic_eberman@quicinc.com> wrote:
> > > > 
> > > > Add nodes for the vendor-defined system resets. "bootloader" will cause
> > > > device to reboot and stop in the bootloader's fastboot mode. "edl" will
> > > > cause device to reboot into "emergency download mode", which permits
> > > > loading images via the Firehose protocol.
> > > > 
> > > > Co-developed-by: Shivendra Pratap <quic_spratap@quicinc.com>
> > > > Signed-off-by: Shivendra Pratap <quic_spratap@quicinc.com>
> > > > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > > > ---
> > > >   arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> > > > index e4bfad50a669..a966f6c8dd7c 100644
> > > > --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> > > > @@ -126,6 +126,11 @@ debug_vm_mem: debug-vm@d0600000 {
> > > >                  };
> > > >          };
> > > > 
> > > > +       psci {
> > > 
> > > Please use a label instead. Otherwise it looks as if you are adding
> > > new device node.
> > > 
> > 
> > Right. Fixed for the next revision.
> 
> Are you guys planning to make this sorta ABI-like?
> 
> If so (which would be greatly appreciated by the way..), perhaps you
> could stick these magic values in dt-bindings and give them cool names
> 
> FWIW DEN0022 (my second-favorite book) suggests these values are almost
> totally vendor-defined, so if I were Qualcomm, I'd take the creative
> liberty to come up with a set of numbers and never ever ever change
> them

This is my goal as well. I'd like to keep the magic values out of
dt-bindings until we get the vendor SYSTEM_RESET2 spread across more
devices, as things might need a bit of settling. Since having stable
vendor reset2 is (IMO) primarily a benefit to Qualcomm, I expect this
will happen naturally.


