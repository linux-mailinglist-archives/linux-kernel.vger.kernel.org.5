Return-Path: <linux-kernel+bounces-62922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3423D8527E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB0A1F2325E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D56CA94F;
	Tue, 13 Feb 2024 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kfEOYefG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8233F2;
	Tue, 13 Feb 2024 03:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707796390; cv=none; b=XrNap9e4HCmuNdM9bN2DUZKGVSErcTCFtPC7H2aTZa7su5Xs0NhCrsqmZL19J2p+oKFRAY0biiZlfMKYkrxEC1Usjq73xyPZhLhW0c9XKdf/PWqJubowvMLkX9r+c3JW7Iyoli28vqpHPEWNeku24o1lGyBn+9RUkO7uAkvznss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707796390; c=relaxed/simple;
	bh=0vaubSGu7gCAoSqrp4lajT42MHYD3qmoQox23k+o7mM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgTdCPMoTh3Kj0JuYqf0r0EMfQ5rK9RjtpwWXSJUb3/jOL+TIL1VEg6eb81q5o7fvnszECzGfr1KEOoaW3yguCUs4SaXKDkYEDOqCwze879BrcUOVrqe4TUzfFao4YDZcOo7qBle2FnecMPryJcqLhTvQBJn00Q7aILE5OlINzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kfEOYefG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D2w0IX000471;
	Tue, 13 Feb 2024 03:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=9l07FK8iA3FHEksQiWuc9dxFREf//NDwM0FUVNltkCo=; b=kf
	EOYefGbMFPyGF5PlzUHT4wpxq6T7Hy5P6MJJ9YJzmjDft0sEZN9Euhe7Irth1vdh
	Yb/ghLJdCKbu9b30asfvVNWw/do6BVt8qDlC9sj20AS7lPsRfZPJdRaIg6FTrRIu
	FI3FZrbemHv+oocCO1kNmXaerPO3vqhg/BMY64kaOnQJBijjkLvVzd6cJe0rjMRt
	yd9yYCoxjUxDZHiS0LMBisKek636FJTqqkMU/QSeTf4+n1DOdpyD/pwVuXnIypoY
	w5BPhVpcRBljRmG4sayryfQ9h6fOJgZHTDW/+jG5tk/sEo27zxa6X09CzlpuE2F1
	YOjkP7+IfJyIweSd3xbg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7ww5r8r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 03:52:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D3qDo0032663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 03:52:13 GMT
Received: from hu-subbaram-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 19:52:12 -0800
From: Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
To: <quic_mkshah@quicinc.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_collinsd@quicinc.com>, <quic_eberman@quicinc.com>,
        <quic_lsrao@quicinc.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] soc: qcom: rpmh-rsc: Enhance check for VRM in-flight request
Date: Mon, 12 Feb 2024 19:52:03 -0800
Message-ID: <20240213035203.2492516-1-quic_subbaram@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212-rpmh-rsc-fixes-v3-1-1be0d705dbb5@quicinc.com>
References: <20240212-rpmh-rsc-fixes-v3-1-1be0d705dbb5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n8nnk09KEUI1r4MUoFc9KOOQmLitkdWT
X-Proofpoint-ORIG-GUID: n8nnk09KEUI1r4MUoFc9KOOQmLitkdWT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=322 bulkscore=0
 spamscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130027

Hi Maulik,

> +bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
> +{

<snip>

> +	if (SLAVE_ID(addr1) == CMD_DB_HW_VRM
> +	    && VRM_ADDR(addr1) == VRM_ADDR(addr2))
> +		return true;
> +	else if (addr1 == addr2)
> +		return true;
> +	else
> +		return false;

Minor..it would be better if you modify it as following.

+	if (addr1 == addr2)
+		return true;
+	else if (SLAVE_ID(addr1) == CMD_DB_HW_VRM
+	    && VRM_ADDR(addr1) == VRM_ADDR(addr2))
+		return true;
+
+	return false;

-Subbaraman

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

