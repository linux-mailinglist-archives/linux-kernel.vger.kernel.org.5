Return-Path: <linux-kernel+bounces-149198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB6D8A8D10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77B31F20FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A73A3FE55;
	Wed, 17 Apr 2024 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S2+Zip9X"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582873AC01;
	Wed, 17 Apr 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386264; cv=none; b=UHmT8t8huHOoX4H61qqGGmTdohAkP7zHmTSrtSQwBmdfysVwyz8o1XP6+U4oQ6s9+gLIYv1kAOUk6rkcqlCHAQ+jq0XXHQLyYxmv5T7MPEyoXwwBBFfX8E+6bCw5TfTGCJvVzTp3rBWMZ4MrHQ8fYL70p5+bjcK/ntb5I+jBklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386264; c=relaxed/simple;
	bh=TOeuYkMhlHWfAApxBOAXbAsDnX6eVjHMCrKl3mloZRQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=op/GUPBoHAFWX6eerqzpuJ1JePQKIRENwTS5fpTqFLtDrXfUJIQZavp/2Lj+PbII8oSx4KH/P/QF35WVgWc4Wu6WWEQX5kILzXYFEenIaSGLGwLk12HUpnmY+fQSsZv+P0HBD4DHJVAupCY4tVnu9ZIhi4F/ODUlN9F74fKa3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S2+Zip9X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HIm7wa017747;
	Wed, 17 Apr 2024 20:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=LB1zueBv8HZ2hy6OpHG//
	Rm2TPlzVrzwuNAakK/MJf4=; b=S2+Zip9XfWMeyqOSkREfTXYQkA1QHPu2uceam
	gUTmPHGM3O7Z9kyNWkaTqF2QWN2yTGai3zsiYNifdJ/f3NGp2hIKhVZ73SqADFlL
	ZdpSnfC3UQSh2dnSmDxr6SN9c7UzZssoLpUoHFzzlo6KjOnkWgWeKCh6hGnsso24
	FCySZsvS2iYfFAwWd3fQwqeVaU0k1LoQTln2OcuqjP0VmyV4RVpnU5lp/mZpKbG+
	8I3Mc+GaOWDi3J16MchUdakZ+kD2zNdkwMCFv6F65WXapdH4t3FeNP8iIsGHIT+B
	s68mimDpQc7hvpjKLvcQHin/9Z5FlHyawyIk9x9WBHnqH1DFA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjm0s07e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 20:37:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HKbOC7022246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 20:37:24 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 13:37:24 -0700
Date: Wed, 17 Apr 2024 13:37:23 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
        Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Marijn Suijten
	<marijn.suijten@somainline.org>
Subject: Re: [PATCH 2/2] iommu/qcom: Always consume all clocks
Message-ID: <ZiAzA+4Xb+OhhLtM@hu-bjorande-lv.qualcomm.com>
References: <20240416-topic-qcom_iommu-v1-0-fabe55b3b7b3@linaro.org>
 <20240416-topic-qcom_iommu-v1-2-fabe55b3b7b3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240416-topic-qcom_iommu-v1-2-fabe55b3b7b3@linaro.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GiGnL9jHn8vhoI-KmiOsp6OahiHhwS0C
X-Proofpoint-ORIG-GUID: GiGnL9jHn8vhoI-KmiOsp6OahiHhwS0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_17,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=641
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170145

On Wed, Apr 17, 2024 at 10:07:00PM +0200, Konrad Dybcio wrote:
> Some platforms provide more clocks than others, we already have the DT
> schema to ensure sanity here plus these clocks simply need to be on.
> 
> Use devm_clk_bulk_get_all and get rid of some boilerplate.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

