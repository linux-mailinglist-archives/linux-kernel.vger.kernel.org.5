Return-Path: <linux-kernel+bounces-123969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2135891074
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A06B22DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B991B7E4;
	Fri, 29 Mar 2024 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eNUKP51j"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131381755C;
	Fri, 29 Mar 2024 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711676300; cv=none; b=pl/HOmcbqZoaYVONDMZoMTAx+1rCYRKEyVCZreQWHYHKP9xFlObg3YBPET48LevCVk3qM2teJWp+s7/NbeuKFmHjpp7RM/ZhXuOHLQkrPmAUG0VLNv5tDEWXaIkYO9nhGozG/UDlbKrrfhW/57uD+iQBh7ZMVnxc/wDSNUV1IJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711676300; c=relaxed/simple;
	bh=bEV65ubQm/FEZ5JYW/r3IKEXil3A4CuaXPxGjJW8pes=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk2Ail4xeCYc91Ip8rF2rhtrasndr7PjA5cYI8okuYYu5qUDDCXnKxRI4K8Owlx4zBupiqTteMb4cwocsjsbLPh/FSWXgwCXgQXpA/N8Vc6D2nVRSOKoUx4VY3RphAC+vOt8FikxBWaaN1m63w1o5o+Qn8D245owHCMlSRqETOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eNUKP51j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T0TYmi010551;
	Fri, 29 Mar 2024 01:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=c/1DduJj9wfJzPL4Dkkd/
	9i0gYcpFhnFqx7+Fn+GsmI=; b=eNUKP51j2U8oyZBHuKMXgGotNBFnJjUTg22eE
	1qZEejnWhuqBHm4378NEU51sufVLsO8BmtQoPbKt3GOTHXUTs2TLOJO44vlinJNH
	FtZEzCjgiGA2PBUipAwuWTTkNxtjjsVaeJKdz+WQ0GPgXxXThwV6wXP0YVEGPmnJ
	5vUqM9RjIwinEWo5S/XCpaggftUETf5N0ZdBu8tgPBa/HJOVCzvL9Bv6JRmXxTWy
	bDh0eIeBY5vQbHWE45D2kot8ZLLCMOBJfqgRWKULffvPb98Hx7Rj2ifV7R2UNigB
	J8rvyT3KIhW5EYZXU9PyRJzTL4gKndU/Q6z11MkEbPxx79HdA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5fr7gfxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 01:37:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T1biaE020122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 01:37:44 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 18:37:44 -0700
Date: Thu, 28 Mar 2024 18:37:43 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: qcs6490-rb3gen2: Add DP output
Message-ID: <20240329013743.GA3476498@hu-bjorande-lv.qualcomm.com>
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
 <20240326-rb3gen2-dp-connector-v2-2-a9f1bc32ecaf@quicinc.com>
 <CAA8EJpoe7A94608V1GdQ-oU9UXagHPm0mVBUe4Yxi=HF2pMd7w@mail.gmail.com>
 <zsjzysb7h3wi3cfpaozl46l4jnsd7e3lxttzm5vptozjx24cqo@vqmyhl65q7ay>
 <CAA8EJppCuoOnaB03GsjXGYSs5Q9iQ2uXHWQqfkPA5jKzdHc8NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJppCuoOnaB03GsjXGYSs5Q9iQ2uXHWQqfkPA5jKzdHc8NQ@mail.gmail.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4f6O6XrFfrk4Cdb9PsSfTltshWEJKDEI
X-Proofpoint-ORIG-GUID: 4f6O6XrFfrk4Cdb9PsSfTltshWEJKDEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_19,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290012

On Thu, Mar 28, 2024 at 09:17:45AM +0200, Dmitry Baryshkov wrote:
> On Thu, 28 Mar 2024 at 05:07, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Thu, Mar 28, 2024 at 03:51:54AM +0200, Dmitry Baryshkov wrote:
> > > On Wed, 27 Mar 2024 at 04:04, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> > > >
> > > > The RB3Gen2 board comes with a mini DP connector, describe this, enable
> > > > MDSS, DP controller and the PHY that drives this.
> > > >
> > > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 40 ++++++++++++++++++++++++++++
> > > >  1 file changed, 40 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > index 63ebe0774f1d..f90bf3518e98 100644
> > > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > @@ -39,6 +39,20 @@ chosen {
> > > >                 stdout-path = "serial0:115200n8";
> > > >         };
> > > >
> > > > +       dp-connector {
> > > > +               compatible = "dp-connector";
> > > > +               label = "DP";
> > > > +               type = "mini";
> > > > +
> > > > +               hpd-gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
> > >
> > > Is it the standard hpd gpio? If so, is there any reason for using it
> > > through dp-connector rather than as a native HPD signal?
> > >
> >
> > I added it because you asked for it. That said, I do like having it
> > clearly defined in the devicetree.
> 
> I asked for the dp-connector device, not for the HPD function change.
> 

I didn't realize that you could have a dp-connector device without
defining the hpd-gpios, but it looks like you're right.

Do we have any reason for using the internal HPD, when we're already
spending the memory to allocate the dp-connector device?


PS. It's recommended that you dynamically switch to GPIO-based HPD in
lower-power scenarios, as this allow you to turn off the DP controller
and still detect plug events...

Regards,
Bjorn

