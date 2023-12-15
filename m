Return-Path: <linux-kernel+bounces-430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD38814105
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96615283C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE5B63A6;
	Fri, 15 Dec 2023 04:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C1A0ef93"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAF53BA;
	Fri, 15 Dec 2023 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF2TX7M028392;
	Fri, 15 Dec 2023 04:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=fZbnhIpJaK2fgilpaTx88
	zv3506kRqZ00devt7lchuk=; b=C1A0ef93gx/utOfiCZjXAphy4x9+oE/U2Jin4
	Msu/3zCIXf5xiGFpHDR/asKLf0NteERe+klEpBbZHuiK04OuQj/mJ6QevTB8FpP9
	fd4wWruwBx9dbyWF2COgQApxT1v4uTSitvNsbzcGbzuLJvFLtm6epo+EB1qDAQ5y
	jZVHSQtW1TdaaNx+KjOAbketXmGiroadKEuhPMjEh+uq+M+gPG7KYa91y/EIXaQF
	S9u/k0Hfzx5efzV4eTIWdtxkqMn+QHLzKDmuKuZ/qcqIuhjaRicbsIK+e1yFLNLz
	qdDvjR9GRgvuDTX1Y0wIT4G97L3OytkfXSXjYbD8RhmUkTOow==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynjac7tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 04:39:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF4dbJO030231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 04:39:37 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 20:39:34 -0800
Date: Fri, 15 Dec 2023 10:09:30 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] regulator: qcom_smd: Add LDO5 MP5496 regulator
Message-ID: <ZXvYgmB/NRtZZb8f@hu-varada-blr.qualcomm.com>
References: <20231214104052.3267039-1-quic_varada@quicinc.com>
 <93bec6b7-78c3-4064-9775-b27c5ac511fb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <93bec6b7-78c3-4064-9775-b27c5ac511fb@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n2lVb3VfLE-ANA8UnoUHzw3lh2KVXzoy
X-Proofpoint-ORIG-GUID: n2lVb3VfLE-ANA8UnoUHzw3lh2KVXzoy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=14 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=14 priorityscore=1501 mlxlogscore=80 mlxscore=14
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150031

On Thu, Dec 14, 2023 at 07:26:24PM +0100, Konrad Dybcio wrote:
>
>
> On 12/14/23 11:40, Varadarajan Narayanan wrote:
> > Add support for LDO5 regulator. This is used by IPQ9574 USB.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> Why did you remove the bindings since the last revision?
>
> https://lore.kernel.org/linux-arm-msm/cover.1701160842.git.varada@hu-varada-blr.qualcomm.com/

Oops! Sorry. Sent the wrong patch.
Will send the correct one.

Varada

