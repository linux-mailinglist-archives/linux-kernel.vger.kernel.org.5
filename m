Return-Path: <linux-kernel+bounces-98484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E01B0877AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A1928107F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247BC8E2;
	Mon, 11 Mar 2024 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gWmz9m3l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEDFAD49;
	Mon, 11 Mar 2024 05:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710135541; cv=none; b=E9qmuBQ1hxvWxoU+bX7C3Gy1EbhAXePj5Ec4teFDhMXuVBBHPttGLgwvbEaK4sXNAVwedd4gYM9s1ZZXXuhF+Cf4ZJvExc79RXpDuOqwoIiKLP+Cw1ALZAPjq6u8GqHHwZDb3y8Q4FC9MTzt/hdav0MmQ3R0UTeeX7764xdyRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710135541; c=relaxed/simple;
	bh=AkZOu/ycQo26JPSpSdfiirIzKGaBHAYTDhkZtYbOcP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRe8bjhTiJp008djhFe5IO6FbSs24j3DKWCyE9Nv7V7cR14miGmTMwR4y198MQqnCuCX7NmwVpq97J2Ke20xotcE8hCeCAt81PwXIjHI+177zx8IDJdQMxS5n1N84zA9mKV4/KpAMUo0bKoSgol/yLYglnIfy7NdXosO5KfSOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gWmz9m3l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B2wdRm021309;
	Mon, 11 Mar 2024 05:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=9OLuA8Ie
	YGL+Fum93bhaJGG103DUqkeXo08bOEEnbog=; b=gWmz9m3lruXBdT0mRKeTS+EN
	zX1PS4/dSNCYlMEo8+fFRvLoK5PCPlVXyV5yB9LCR+BqVX1zrva3JRaNmGnxTNpz
	8dJIpHN2EpoSSRK2i/fjEsJ2aNXNRRPSKSXI6IzItlxo3vGtVDRW8gKMZ/QvBxC2
	ZoEHg5vOdXkDVZFDkrQ+PnqMYbQwV81Sew9lPmE9lVIyHRqCbsOufV6snZMhhy19
	I9JWHw0l4jDt5Y04xDO7XQE0SPvNp1zoguAuL+76aA7Y6yOv0JxTDK5dG4qMd9En
	VdQ81asQ930/4GLhJJ8bagZsoc1bdEvhgBxz+ttKcASR8x7h0tkiE7MCvueZDg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wrfuxtrgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 05:38:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42B5cihL009180
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 05:38:44 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 10 Mar
 2024 22:38:37 -0700
Date: Mon, 11 Mar 2024 11:08:34 +0530
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
Subject: Re: [PATCH v17 10/35] gunyah: vm_mgr: Add VM start/stop
Message-ID: <20240311053834.GM440762@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-10-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-10-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yamRmtGTnTw21zM-rmeSozSVsMIm2_AU
X-Proofpoint-GUID: yamRmtGTnTw21zM-rmeSozSVsMIm2_AU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=867
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110041

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:33]:

> Add ioctl to trigger the start of a Gunyah virtual machine. Subsequent
> commits will provide memory to the virtual machine and add ability to
> interact with the resources (capabilities) of the virtual machine.
> Although start of the virtual machine can be done implicitly on the
> first vCPU run for proxy-schedule virtual machines, there is a
> non-trivial number of calls to Gunyah: a more precise error can be given
> to userspace which calls VM_START without looking at kernel logs because
> userspace can detect that the VM start failed instead of "couldn't run
> the vCPU".
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Minor nit below. LGTM otherwise.

Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

> +static int gunyah_vm_start(struct gunyah_vm *ghvm)
> +{

.

> +err:
> +	/* gunyah_vm_free will handle releasing resources and reclaiming memory */

s/gunyah_vm_free/gunyah_vm_release

> +	up_write(&ghvm->status_lock);
> +	return ret;
> +}

