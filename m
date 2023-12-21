Return-Path: <linux-kernel+bounces-8668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3851181BAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D84282799
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D238C539F2;
	Thu, 21 Dec 2023 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bbwj+m+N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAD41C7A;
	Thu, 21 Dec 2023 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLElqE6031580;
	Thu, 21 Dec 2023 15:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9iEMGlU1FMnePwTtzvMYgnI459Oo0Zb3ITg7hL/BVxQ=; b=bb
	wj+m+NZsrM2HB0tfbV5EBkIhzWXCTpSNiBSmYl1BOx6HBz4gMNphrdRL3212u2pn
	mUhi1/I7M6gcd5jkg//qjwRi2XOfwP5jxVrgtNuTQjGDLUhAayejmdZ8DhJaYt/9
	AwLzxZhYvNXdd3LfXojplZmvVIo1P2FCJ7T+FORLY6xF39uq782NgcpfA5WQhtK8
	u1Tu9uUAEeD2rdy/v52GFlHkaiTfN+P4vU26yD4DC1CUQepNZMXkItjrSTZz6N3V
	5QUcz+coESVQqNfiHOYYLk0w9nM6UxNJ44Azrs8qzOblnR1g9R42Hrc8JiREzTnH
	9omJO0RdgUezMwc/w9gw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4qe2r3jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 15:32:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLFWvVs031096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 15:32:57 GMT
Received: from [10.216.6.230] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 07:32:53 -0800
Message-ID: <79bb4fa3-4227-48bd-bebe-fe66ea8c0144@quicinc.com>
Date: Thu, 21 Dec 2023 21:02:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: qcm6490: Add UFS nodes
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_bhaskarv@quicinc.com>, <quic_narepall@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_ahari@quicinc.com>
References: <20231221104529.13513-1-quic_mapa@quicinc.com>
 <5760478d-ca64-499c-939b-6e5b065afc2f@linaro.org>
From: MANISH PANDEY <quic_mapa@quicinc.com>
In-Reply-To: <5760478d-ca64-499c-939b-6e5b065afc2f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fPbxQfmHzrKaZclhorX1gtaIk7eTR7lJ
X-Proofpoint-ORIG-GUID: fPbxQfmHzrKaZclhorX1gtaIk7eTR7lJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 mlxlogscore=444 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312210117



On 12/21/2023 8:47 PM, Konrad Dybcio wrote:
> On 21.12.2023 11:45, Manish Pandey wrote:
>> Add UFS host controller and Phy nodes for
>> Qualcomm qcm6490 Board.
>>
>> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
>> ---
> This still doesn't compile and only v2 made it to my inbox.
> 
> Please fix this.
> 
> Konrad

Hi Konrad,
Thanks for the quick review, We would wait for qcom regulator patches to 
be merged first with regulator-allow-set-load added in required nodes. 
Post that we would address the comments and share next patch-set.
Sorry for inconvenience.

Regards
Manish

