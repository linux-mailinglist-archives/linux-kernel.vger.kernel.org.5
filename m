Return-Path: <linux-kernel+bounces-152018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239358AB77E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A514B1F21924
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E73813D8A5;
	Fri, 19 Apr 2024 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p6dZWNO1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408F64D;
	Fri, 19 Apr 2024 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713569498; cv=none; b=uVc244I0b5KTZuGy+pVIB+NccgsMLNbj+gncKTuf0dQim383U9OIeZGVKz9dv9howZPrXD4cbTiUDLkEGySOAgbDcv57fIoGPZxo72X+H1vosjbj4LJ25KtH6SWXuVOvne+C8bSb1vIvH8Ci0bGnfCX9x6fGIQtEE6rrw3WltYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713569498; c=relaxed/simple;
	bh=6IGgM1ninH2UvKvYGTOhBMyMEqSh2CQFZKSqqRp6Ml4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaPKBY0XsnfWZqv0xE72OP9PMFE4Mrvcr2zspA+auni5G8pDojVwwHqqAWFfeayHb1oUdahNHIx8/F3YTDBOhelYXv2qzAzfxzIJs8MtpgKpvF92dMiYUq1kmoFI3QcbsvAB8WFyOb4Y4/HJ030CHKgrFsA/6vGbs8zREZtsEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p6dZWNO1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JMsPNc025597;
	Fri, 19 Apr 2024 23:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=7YnOs/zIN96oMB3AwWlXg
	64tPuvFDKMPlHsSp9oJv1I=; b=p6dZWNO1tSiHG2IBHs697YnUU6PtAm4t1qJml
	/CsthJIMrWP0pL/iukK6CKVPqKADiZ5a7v8m+mUFCw7IQM4Tc2AQtILnQQjY9L0N
	xabs1UGVHrWYVtNOKeMairbBSR4ogrT2LbiRZ6t3Qnnant9r2Eh1iyFsURos8wm6
	tS62m00iiCjsVOqO1oIIVTedot3sbo9u16EFIivfkNh+WF6RpNFgaUNxRySXXOh8
	LSABk1GO4Ajley8x/kuIAzvChn5wQf2lrez7KPAG7T9IINAyTgHluFdJ7yQWzCeJ
	B686XdG5N7wun21PfCGLIOODR9/9yeJm5PHcp7UMv0GTqLYtw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xkkss9uc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 23:31:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JNVIsT003709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 23:31:18 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 19 Apr 2024 16:31:17 -0700
Date: Fri, 19 Apr 2024 16:31:17 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Sudeep Holla <sudeep.holla@arm.com>
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
Subject: Re: [PATCH v2 0/4] Implement vendor resets for PSCI SYSTEM_RESET2
Message-ID: <20240419134542691-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <Zh5GWqt2oCNHdF_h@bogus>
 <20240417140957985-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240419085345.4ovebbbmcabo3f73@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419085345.4ovebbbmcabo3f73@bogus>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ptwZxpIb3YjMjehV0iVZZt6crq1l_sl3
X-Proofpoint-GUID: ptwZxpIb3YjMjehV0iVZZt6crq1l_sl3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_15,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=949 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190183

On Fri, Apr 19, 2024 at 09:53:45AM +0100, Sudeep Holla wrote:
> On Wed, Apr 17, 2024 at 02:54:41PM -0700, Elliot Berman wrote:
> > On Tue, Apr 16, 2024 at 10:35:22AM +0100, Sudeep Holla wrote:
> > > On Sun, Apr 14, 2024 at 12:30:23PM -0700, Elliot Berman wrote:
> > > > The PSCI SYSTEM_RESET2 call allows vendor firmware to define additional
> > > > reset types which could be mapped to the reboot argument.
> > > >
> > > > Setting up reboot on Qualcomm devices can be inconsistent from chipset
> > > > to chipset.
> > >
> > > That doesn't sound good. Do you mean PSCI SYSTEM_RESET doesn't work as
> > > expected ? Does it mean it is not conformant to the specification ?
> > >
> >
> > I was motivating the reason for using SYSTEM_RESET2. How to set the PMIC
> > register and IMEM cookie can change between chipsets. Using
> > SYSTEM_RESET2 alows us to abstract how to perform the reset.
> 
> Fair enough. But I assume you are not providing the details of PMIC register
> or IMEM cookie via DT.

Kernel doesn't need this info.

> 
> Anyways you did confirm if PSCI SYSTEM_RESET works as expected or not. That
> is default and must work.
> 

Yes, SYSTEM_RESET works on Quacomm firmware. The bindings disallow
trying to override the default reboot. (reboot command = NULL or "") The
PSCI parsing of the DT also doesn't have any of the special handling to
deal with "mode-normal".

> > > > Generally, there is a PMIC register that gets written to
> > > > decide the reboot type. There is also sometimes a cookie that can be
> > > > written to indicate that the bootloader should behave differently than a
> > > > regular boot. These knobs evolve over product generations and require
> > > > more drivers. Qualcomm firmwares are beginning to expose vendor
> > > > SYSTEM_RESET2 types to simplify driver requirements from Linux.
> > > >
> > >
> > > Why can't this be fully userspace driven ? What is the need to keep the
> > > cookie in the DT ?
> >
> > As Dmitry pointed out, this information isn't discoverable. I suppose
> > we could technically use bootconfig or kernel command-line to convey the
> > map although I think devicetree is the right spot for this mapping.
> >
> 
> Yes and as usual DT has become dumping ground for firmware that don't
> make things discoverable. Make crap that Qcom puts in the DT are firmware
> related and can be make discoverable. Anyways it is sad that no efforts
> to make it so are done as DT is always there to provide shortcuts.
> 
> > - Other vendor-specific bits for PSCI are described in the devicetree.
> >   One example is the suspend param (e.g. the StateID) for cpu idle
> >   states.
> 
> You are right, but that is the only example I can see and it was done
> in very early days of PSCI. It shouldn't be example if there are better
> ways.
> 
> > - Describing firmware bits in the DT isn't unprecedented, and putting
> >   this information outside the DT means that other OSes (besides Linux)
> >   need their own way to convey this information.
> 
> Correct but it can be Qcom specific firmware interface. There are so many
> already. This splitting information between firmware and DT works well
> for vertically integrated things which probably is the case with most of
> Qcom SoCs but it is prone to issues if DT and firmware mismatch. Firmware
> discovery eliminates such issues.
> 

I worry about designing interfaces both in Qualcomm firmware and in
the PSCI driver which doesn't really suit handling the discovery. We can
implement the dynamic discovery mechanims once there is a board which
needs it.

Thanks,
Elliot

