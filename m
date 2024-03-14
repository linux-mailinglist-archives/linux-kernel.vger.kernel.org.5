Return-Path: <linux-kernel+bounces-103338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534FE87BE41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820EF1C21210
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFD46FBB8;
	Thu, 14 Mar 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zorg+HYu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB186EB66;
	Thu, 14 Mar 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424967; cv=none; b=cPmu7H7HCtPTmhnaA2mOysU0W/uBkA5dmRrzythoMMLxMvL7D0OQkZyUhwgsYozDGnl2TxDxKepM5qIo2efgtKi8QGwkv5McSZQds6FmeqEgy2Y7jD+w0Xd6/O48K6lv7JNYc8Qxgu84mcHtIrjXYHVTaKl+YH4NM4AEdJCVk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424967; c=relaxed/simple;
	bh=1VujOo3bwS8aZF9+nYwk4562s+hxXxzy/YG40BYsEn0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk2ec9OADNkYReYSzioxdIbwRn6FMg+6VGPks8s5xcuFpwR6DzYGsdG2xaezonsoufGrA2Bg0qKIHX3BPd6m30XD2VBuRV+BtpHL6aF649SZfomww6jFKtPshKJqcHlGJ1u7iWel9z2+NrcBfbs9+z/IaPRIVMOEh+x8y1xxhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zorg+HYu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42ECsvIB019870;
	Thu, 14 Mar 2024 14:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=N2j5RMdH
	DNmm3vWJcZlaSTomA4u+OU2nb6B+0WWCKZs=; b=Zorg+HYu948hVr1+iR8dxpo4
	bfHfry6RIKXCZaDkp2VQMriK4+dEwyXKMiJKH3/zVPRukJuzKVgPpYHU3CrFoMkv
	dqdaBUAb4j3jVgmtNdmO3UqfIASahKjTIoSJDQR1nIjgC2DUugUYn5dTLGs7+1b4
	BMNlQSFmVZLlJ9roHCyX751/TPdfGUO2N3dwdvU8Ng0iglSvohB/uJ4IFPBb2aOz
	G4FjLUy2GC/y2jVXbh1nRmeg1PYi6m3g7t9OcgSoRHdRYXZrAw6aexMC4mj9a0G7
	EIZhqlteO6R7UxULrUMVJjIfkOIUJJM8+RfpiXA4s6N1C41F/ycFNrUWJ5u9HA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wv1njr508-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 14:02:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EE2Lo6009173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 14:02:21 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 07:02:13 -0700
Date: Thu, 14 Mar 2024 19:32:10 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Elliot Berman <quic_eberman@quicinc.com>
CC: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik
	<quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet
	<corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v17 17/35] gunyah: rsc_mgr: Add memory parcel RPC
Message-ID: <20240314140210.GU440762@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-17-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-17-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l11wezTxCzYOMBhKzKDcLrBYuuW80ZZ3
X-Proofpoint-GUID: l11wezTxCzYOMBhKzKDcLrBYuuW80ZZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=782 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403140103

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:40]:

> In a Gunyah hypervisor system using the Gunyah Resource Manager, the
> "standard" unit of donating, lending and sharing memory is called a
> memory parcel (memparcel).  A memparcel is an abstraction used by the
> resource manager for securely managing donating, lending and sharing
> memory, which may be physically and virtually fragmented, without
> dealing directly with physical memory addresses.
> 
> Memparcels are created and managed through the RM RPC functions for
> lending, sharing and reclaiming memory from VMs.
> 
> When creating a new VM the initial VM memory containing the VM image and
> the VM's device tree blob must be provided as a memparcel. The memparcel
> must be created using the RM RPC for lending and mapping the memory to
> the VM.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

- vatsa

